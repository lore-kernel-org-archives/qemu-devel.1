Received: from eggs.gnu.org ([2001:4830:134:3::10]:59141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1fzbjV-0001zC-7e
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 02:01:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1fzbjQ-0005hQ-7d
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 02:01:05 -0400
Received: from mail.ispras.ru ([83.149.199.45]:49644)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1fzbjP-0005gU-NO
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 02:01:00 -0400
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20180820150903.1224-4-pbonzini@redhat.com>
	<000001d43ea0$02146ed0$063d4c70$@ru>
	<5b9a85eb-cefd-925c-b24b-95b93bbbfce8@redhat.com>
	<000a01d448c8$4a55c0e0$df0142a0$@ru>
	<ea5f162e-bd8a-001c-b78c-25378e3b2919@redhat.com>
In-Reply-To: <ea5f162e-bd8a-001c-b78c-25378e3b2919@redhat.com>
Date: Tue, 11 Sep 2018 09:00:58 +0300
Message-ID: <001e01d44994$d02acb80$70806280$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: ru
Subject: Re: [Qemu-devel] [3/4] cpus: protect TimerState writes with a
 spinlock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Paolo Bonzini' <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: "'Emilio G . Cota'" <cota@braap.org>

> From: Paolo Bonzini [mailto:pbonzini@redhat.com]
> On 10/09/2018 07:36, Pavel Dovgalyuk wrote:
> > After locking here,
> >
> >>      if (runstate_is_running()) {
> >>          int64_t clock = REPLAY_CLOCK(REPLAY_CLOCK_VIRTUAL_RT,
> >>                                       cpu_get_clock_locked());
> > REPLAY_CLOCK can't request icount with cpu_get_icount_raw, because
> > it loops infinitely here:
> >
> >     do {
> >         start = seqlock_read_begin(&timers_state.vm_clock_seqlock);
> >         icount = cpu_get_icount_raw_locked();
> >     } while (seqlock_read_retry(&timers_state.vm_clock_seqlock, start));
> 
> Yeah, I meant to ask for the backtrace but I can see that the issue is in
> replay_save_instructions().  Does this work?

Thanks, that works. Here is the updated diff (stubs were added).
Will you apply it?


Pavel Dovgalyuk


diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
index 3ced6bc..bb8660b 100644
--- a/include/sysemu/replay.h
+++ b/include/sysemu/replay.h
@@ -100,14 +100,20 @@ bool replay_has_interrupt(void);
 /* Processing clocks and other time sources */
 
 /*! Save the specified clock */
-int64_t replay_save_clock(ReplayClockKind kind, int64_t clock);
+int64_t replay_save_clock(ReplayClockKind kind, int64_t clock,
+                          int64_t raw_icount);
 /*! Read the specified clock from the log or return cached data */
 int64_t replay_read_clock(ReplayClockKind kind);
 /*! Saves or reads the clock depending on the current replay mode. */
 #define REPLAY_CLOCK(clock, value)                                      \
     (replay_mode == REPLAY_MODE_PLAY ? replay_read_clock((clock))       \
         : replay_mode == REPLAY_MODE_RECORD                             \
-            ? replay_save_clock((clock), (value))                       \
+            ? replay_save_clock((clock), (value), cpu_get_icount_raw()) \
+        : (value))
+#define REPLAY_CLOCK_LOCKED(clock, value)                               \
+    (replay_mode == REPLAY_MODE_PLAY ? replay_read_clock((clock))       \
+        : replay_mode == REPLAY_MODE_RECORD                             \
+            ? replay_save_clock((clock), (value), cpu_get_icount_raw_locked()) 
         : (value))
 
 /* Events */
diff --git a/replay/replay-internal.h b/replay/replay-internal.h
index ac4b27b..4f82676 100644
--- a/replay/replay-internal.h
+++ b/replay/replay-internal.h
@@ -122,6 +122,8 @@ void replay_finish_event(void);
     data_kind variable. */
 void replay_fetch_data_kind(void);
 
+/*! Advance replay_state.current_step to the specified value. */
+void replay_advance_current_step(uint64_t current_step);
 /*! Saves queued events (like instructions and sound). */
 void replay_save_instructions(void);
 
diff --git a/cpus.c b/cpus.c
index 8ee6e5d..f257a6e 100644
--- a/cpus.c
+++ b/cpus.c
@@ -502,8 +502,8 @@ static void icount_warp_rt(void)
     seqlock_write_lock(&timers_state.vm_clock_seqlock,
                        &timers_state.vm_clock_lock);
     if (runstate_is_running()) {
-        int64_t clock = REPLAY_CLOCK(REPLAY_CLOCK_VIRTUAL_RT,
-                                     cpu_get_clock_locked());
+        int64_t clock = REPLAY_CLOCK_LOCKED(REPLAY_CLOCK_VIRTUAL_RT,
+                                            cpu_get_clock_locked());
         int64_t warp_delta;
 
         warp_delta = clock - timers_state.vm_clock_warp_start;
diff --git a/replay/replay-internal.c b/replay/replay-internal.c
index b077cb5..7be4c01 100644
--- a/replay/replay-internal.c
+++ b/replay/replay-internal.c
@@ -217,20 +217,25 @@ void replay_mutex_unlock(void)
     }
 }
 
+void replay_advance_current_step(uint64_t current_step)
+{
+    int diff = (int)(current_step - replay_state.current_step);
+
+    /* Time can only go forward */
+    assert(diff >= 0);
+
+    if (diff > 0) {
+        replay_put_event(EVENT_INSTRUCTION);
+        replay_put_dword(diff);
+        replay_state.current_step += diff;
+    }
+}
+
 /*! Saves cached instructions. */
 void replay_save_instructions(void)
 {
     if (replay_file && replay_mode == REPLAY_MODE_RECORD) {
         g_assert(replay_mutex_locked());
-        int diff = (int)(replay_get_current_step() - replay_state.current_step)
-
-        /* Time can only go forward */
-        assert(diff >= 0);
-
-        if (diff > 0) {
-            replay_put_event(EVENT_INSTRUCTION);
-            replay_put_dword(diff);
-            replay_state.current_step += diff;
-        }
+        replay_advance_current_step(replay_get_current_step());
     }
 }
diff --git a/replay/replay-time.c b/replay/replay-time.c
index 6a7565e..17caf35 100644
--- a/replay/replay-time.c
+++ b/replay/replay-time.c
@@ -15,13 +15,15 @@
 #include "replay-internal.h"
 #include "qemu/error-report.h"
 
-int64_t replay_save_clock(ReplayClockKind kind, int64_t clock)
+int64_t replay_save_clock(ReplayClockKind kind, int64_t clock, int64_t raw_icou
 {
-
     if (replay_file) {
         g_assert(replay_mutex_locked());
 
-        replay_save_instructions();
+        /* Due to the caller's locking requirements we get the icount from it i
+         * of using replay_save_instructions().
+         */
+        replay_advance_current_step(raw_icount);
         replay_put_event(EVENT_CLOCK + kind);
         replay_put_qword(clock);
     }
diff --git a/stubs/cpu-get-icount.c b/stubs/cpu-get-icount.c
index 0b7239d..35f0c1e 100644
--- a/stubs/cpu-get-icount.c
+++ b/stubs/cpu-get-icount.c
@@ -11,6 +11,11 @@ int64_t cpu_get_icount(void)
     abort();
 }
 
+int64_t cpu_get_icount_raw(void)
+{
+    abort();
+}
+
 void qemu_timer_notify_cb(void *opaque, QEMUClockType type)
 {
     qemu_notify_event();
diff --git a/stubs/replay.c b/stubs/replay.c
index 04279ab..4ac6078 100644
--- a/stubs/replay.c
+++ b/stubs/replay.c
@@ -4,7 +4,7 @@
 
 ReplayMode replay_mode;
 
-int64_t replay_save_clock(unsigned int kind, int64_t clock)
+int64_t replay_save_clock(unsigned int kind, int64_t clock, int64_t raw_icount)
 {
     abort();
     return 0;
