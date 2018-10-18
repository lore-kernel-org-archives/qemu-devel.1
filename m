Received: from eggs.gnu.org ([2001:4830:134:3::10]:48592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gDEz0-0008Mu-W8
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:33:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gDEyy-0006sf-1j
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:33:25 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:39657)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gDEyq-0006kc-97
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:33:17 -0400
Received: by mail-wm1-x330.google.com with SMTP id y144-v6so1608645wmd.4
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 13:33:11 -0700 (PDT)
Received: from 640k.lan (dynamic-adsl-78-12-231-174.clienti.tiscali.it.
	[78.12.231.174]) by smtp.gmail.com with ESMTPSA id
	a12-v6sm14270952wrr.71.2018.10.18.13.33.09
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 18 Oct 2018 13:33:09 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 18 Oct 2018 22:32:15 +0200
Message-Id: <1539894735-14232-49-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
References: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 48/48] replay: pass raw icount value to
 replay_save_clock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This avoids lock recursion when REPLAY_CLOCK is called inside the
timers spinlock.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 cpus.c                   |  4 ++--
 include/sysemu/replay.h  | 10 ++++++++--
 replay/replay-internal.c | 25 +++++++++++++++----------
 replay/replay-internal.h |  2 ++
 replay/replay-time.c     |  8 +++++---
 stubs/cpu-get-icount.c   |  5 +++++
 stubs/replay.c           |  2 +-
 7 files changed, 38 insertions(+), 18 deletions(-)

diff --git a/cpus.c b/cpus.c
index 361678e..1c741bc 100644
--- a/cpus.c
+++ b/cpus.c
@@ -509,8 +509,8 @@ static void icount_warp_rt(void)
     seqlock_write_lock(&timers_state.vm_clock_seqlock,
                        &timers_state.vm_clock_lock);
     if (runstate_is_running()) {
-        int64_t clock = REPLAY_CLOCK(REPLAY_CLOCK_VIRTUAL_RT,
-                                     cpu_get_clock_locked());
+        int64_t clock = REPLAY_CLOCK_LOCKED(REPLAY_CLOCK_VIRTUAL_RT,
+                                            cpu_get_clock_locked());
         int64_t warp_delta;
 
         warp_delta = clock - timers_state.vm_clock_warp_start;
diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
index 7f7a594..3a7c58e 100644
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
+            ? replay_save_clock((clock), (value), cpu_get_icount_raw_locked()) \
         : (value))
 
 /* Events */
diff --git a/replay/replay-internal.c b/replay/replay-internal.c
index b077cb5..1cea1d4 100644
--- a/replay/replay-internal.c
+++ b/replay/replay-internal.c
@@ -217,20 +217,25 @@ void replay_mutex_unlock(void)
     }
 }
 
+void replay_advance_current_step(uint64_t current_step)
+{
+    int diff = (int)(replay_get_current_step() - replay_state.current_step);
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
-        int diff = (int)(replay_get_current_step() - replay_state.current_step);
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
diff --git a/replay/replay-internal.h b/replay/replay-internal.h
index 9b0fd91..af6f4d5 100644
--- a/replay/replay-internal.h
+++ b/replay/replay-internal.h
@@ -122,6 +122,8 @@ void replay_finish_event(void);
     data_kind variable. */
 void replay_fetch_data_kind(void);
 
+/*! Advance replay_state.current_step to the specified value. */
+void replay_advance_current_step(uint64_t current_step);
 /*! Saves queued events (like instructions and sound). */
 void replay_save_instructions(void);
 
diff --git a/replay/replay-time.c b/replay/replay-time.c
index 6a7565e..0df1693 100644
--- a/replay/replay-time.c
+++ b/replay/replay-time.c
@@ -15,13 +15,15 @@
 #include "replay-internal.h"
 #include "qemu/error-report.h"
 
-int64_t replay_save_clock(ReplayClockKind kind, int64_t clock)
+int64_t replay_save_clock(ReplayClockKind kind, int64_t clock, int64_t raw_icount)
 {
-
     if (replay_file) {
         g_assert(replay_mutex_locked());
 
-        replay_save_instructions();
+        /* Due to the caller's locking requirements we get the icount from it
+         * instead of using replay_save_instructions().
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
-- 
1.8.3.1
