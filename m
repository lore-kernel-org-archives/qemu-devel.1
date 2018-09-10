Received: from eggs.gnu.org ([2001:4830:134:3::10]:38675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fzLmv-0001nu-2Q
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 08:59:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fzLmr-0008Dg-S9
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 08:59:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59256 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fzLmr-0008DJ-MI
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 08:59:29 -0400
References: <20180820150903.1224-4-pbonzini@redhat.com>
	<000001d43ea0$02146ed0$063d4c70$@ru>
	<5b9a85eb-cefd-925c-b24b-95b93bbbfce8@redhat.com>
	<000a01d448c8$4a55c0e0$df0142a0$@ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ea5f162e-bd8a-001c-b78c-25378e3b2919@redhat.com>
Date: Mon, 10 Sep 2018 14:59:27 +0200
MIME-Version: 1.0
In-Reply-To: <000a01d448c8$4a55c0e0$df0142a0$@ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: "'Emilio G . Cota'" <cota@braap.org>

On 10/09/2018 07:36, Pavel Dovgalyuk wrote:
> After locking here,
>=20
>>      if (runstate_is_running()) {
>>          int64_t clock =3D REPLAY_CLOCK(REPLAY_CLOCK_VIRTUAL_RT,
>>                                       cpu_get_clock_locked());
> REPLAY_CLOCK can't request icount with cpu_get_icount_raw, because
> it loops infinitely here:
>=20
>     do {
>         start =3D seqlock_read_begin(&timers_state.vm_clock_seqlock);
>         icount =3D cpu_get_icount_raw_locked();
>     } while (seqlock_read_retry(&timers_state.vm_clock_seqlock, start))=
;

Yeah, I meant to ask for the backtrace but I can see that the issue is in
replay_save_instructions().  Does this work?

diff --git a/cpus.c b/cpus.c
index 8ee6e5db93..f257a6ef12 100644
--- a/cpus.c
+++ b/cpus.c
@@ -502,8 +502,8 @@ static void icount_warp_rt(void)
     seqlock_write_lock(&timers_state.vm_clock_seqlock,
                        &timers_state.vm_clock_lock);
     if (runstate_is_running()) {
-        int64_t clock =3D REPLAY_CLOCK(REPLAY_CLOCK_VIRTUAL_RT,
-                                     cpu_get_clock_locked());
+        int64_t clock =3D REPLAY_CLOCK_LOCKED(REPLAY_CLOCK_VIRTUAL_RT,
+                                            cpu_get_clock_locked());
         int64_t warp_delta;
=20
         warp_delta =3D clock - timers_state.vm_clock_warp_start;
diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
index 3ced6bc231..bb8660b4e4 100644
--- a/include/sysemu/replay.h
+++ b/include/sysemu/replay.h
@@ -100,14 +100,20 @@ bool replay_has_interrupt(void);
 /* Processing clocks and other time sources */
=20
 /*! Save the specified clock */
-int64_t replay_save_clock(ReplayClockKind kind, int64_t clock);
+int64_t replay_save_clock(ReplayClockKind kind, int64_t clock,
+                          int64_t raw_icount);
 /*! Read the specified clock from the log or return cached data */
 int64_t replay_read_clock(ReplayClockKind kind);
 /*! Saves or reads the clock depending on the current replay mode. */
 #define REPLAY_CLOCK(clock, value)                                      =
\
     (replay_mode =3D=3D REPLAY_MODE_PLAY ? replay_read_clock((clock))   =
    \
         : replay_mode =3D=3D REPLAY_MODE_RECORD                         =
    \
-            ? replay_save_clock((clock), (value))                       =
\
+            ? replay_save_clock((clock), (value), cpu_get_icount_raw()) =
\
+        : (value))
+#define REPLAY_CLOCK_LOCKED(clock, value)                               =
\
+    (replay_mode =3D=3D REPLAY_MODE_PLAY ? replay_read_clock((clock))   =
    \
+        : replay_mode =3D=3D REPLAY_MODE_RECORD                         =
    \
+            ? replay_save_clock((clock), (value), cpu_get_icount_raw_loc=
ked()) \
         : (value))
=20
 /* Events */
diff --git a/replay/replay-internal.c b/replay/replay-internal.c
index b077cb5fd5..7be4c010d0 100644
--- a/replay/replay-internal.c
+++ b/replay/replay-internal.c
@@ -217,20 +217,25 @@ void replay_mutex_unlock(void)
     }
 }
=20
+void replay_advance_current_step(uint64_t current_step)
+{
+    int diff =3D (int)(current_step - replay_state.current_step);
+
+    /* Time can only go forward */
+    assert(diff >=3D 0);
+
+    if (diff > 0) {
+        replay_put_event(EVENT_INSTRUCTION);
+        replay_put_dword(diff);
+        replay_state.current_step +=3D diff;
+    }
+}
+
 /*! Saves cached instructions. */
 void replay_save_instructions(void)
 {
     if (replay_file && replay_mode =3D=3D REPLAY_MODE_RECORD) {
         g_assert(replay_mutex_locked());
-        int diff =3D (int)(replay_get_current_step() - replay_state.curr=
ent_step);
-
-        /* Time can only go forward */
-        assert(diff >=3D 0);
-
-        if (diff > 0) {
-            replay_put_event(EVENT_INSTRUCTION);
-            replay_put_dword(diff);
-            replay_state.current_step +=3D diff;
-        }
+        replay_advance_current_step(replay_get_current_step());
     }
 }
diff --git a/replay/replay-internal.h b/replay/replay-internal.h
index ac4b27b674..4f82676209 100644
--- a/replay/replay-internal.h
+++ b/replay/replay-internal.h
@@ -122,6 +122,8 @@ void replay_finish_event(void);
     data_kind variable. */
 void replay_fetch_data_kind(void);
=20
+/*! Advance replay_state.current_step to the specified value. */
+void replay_advance_current_step(uint64_t current_step);
 /*! Saves queued events (like instructions and sound). */
 void replay_save_instructions(void);
=20
diff --git a/replay/replay-time.c b/replay/replay-time.c
index 6a7565ec8d..17caf35e74 100644
--- a/replay/replay-time.c
+++ b/replay/replay-time.c
@@ -15,13 +15,15 @@
 #include "replay-internal.h"
 #include "qemu/error-report.h"
=20
-int64_t replay_save_clock(ReplayClockKind kind, int64_t clock)
+int64_t replay_save_clock(ReplayClockKind kind, int64_t clock, int64_t r=
aw_icount)
 {
-
     if (replay_file) {
         g_assert(replay_mutex_locked());
=20
-        replay_save_instructions();
+        /* Due to the caller's locking requirements we get the icount fr=
om it instead
+         * of using replay_save_instructions().
+         */
+        replay_advance_current_step(raw_icount);
         replay_put_event(EVENT_CLOCK + kind);
         replay_put_qword(clock);
     }

Thanks,

Paolo
