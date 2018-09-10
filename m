Received: from eggs.gnu.org ([2001:4830:134:3::10]:40702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fzVjm-0003bp-Oc
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 19:37:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fzVbe-0005Sq-8q
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 19:28:38 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:48465)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fzVbe-0005Jv-1I
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 19:28:34 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon, 10 Sep 2018 19:27:50 -0400
Message-Id: <20180910232752.31565-11-cota@braap.org>
In-Reply-To: <20180910232752.31565-1-cota@braap.org>
References: <20180910232752.31565-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v2 10/12] cpus: access .qemu_icount_bias with
 atomic64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Murilo Opsfelder Araujo <muriloo@linux.ibm.com>

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 cpus.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/cpus.c b/cpus.c
index f045416c94..5a16a0186c 100644
--- a/cpus.c
+++ b/cpus.c
@@ -277,7 +277,8 @@ static int64_t cpu_get_icount_raw_locked(void)
 static int64_t cpu_get_icount_locked(void)
 {
     int64_t icount = cpu_get_icount_raw_locked();
-    return atomic_read__nocheck(&timers_state.qemu_icount_bias) + cpu_icount_to_ns(icount);
+    return atomic_read_i64(&timers_state.qemu_icount_bias) +
+        cpu_icount_to_ns(icount);
 }
 
 int64_t cpu_get_icount_raw(void)
@@ -450,9 +451,9 @@ static void icount_adjust(void)
                    timers_state.icount_time_shift + 1);
     }
     last_delta = delta;
-    atomic_set__nocheck(&timers_state.qemu_icount_bias,
-                        cur_icount - (timers_state.qemu_icount
-                                      << timers_state.icount_time_shift));
+    atomic_set_i64(&timers_state.qemu_icount_bias,
+                   cur_icount - (timers_state.qemu_icount
+                                 << timers_state.icount_time_shift));
     seqlock_write_unlock(&timers_state.vm_clock_seqlock,
                          &timers_state.vm_clock_lock);
 }
@@ -512,8 +513,8 @@ static void icount_warp_rt(void)
             int64_t delta = clock - cur_icount;
             warp_delta = MIN(warp_delta, delta);
         }
-        atomic_set__nocheck(&timers_state.qemu_icount_bias,
-                            timers_state.qemu_icount_bias + warp_delta);
+        atomic_set_i64(&timers_state.qemu_icount_bias,
+                       timers_state.qemu_icount_bias + warp_delta);
     }
     timers_state.vm_clock_warp_start = -1;
     seqlock_write_unlock(&timers_state.vm_clock_seqlock,
@@ -544,8 +545,8 @@ void qtest_clock_warp(int64_t dest)
 
         seqlock_write_lock(&timers_state.vm_clock_seqlock,
                            &timers_state.vm_clock_lock);
-        atomic_set__nocheck(&timers_state.qemu_icount_bias,
-                            timers_state.qemu_icount_bias + warp);
+        atomic_set_i64(&timers_state.qemu_icount_bias,
+                       timers_state.qemu_icount_bias + warp);
         seqlock_write_unlock(&timers_state.vm_clock_seqlock,
                              &timers_state.vm_clock_lock);
 
@@ -616,8 +617,8 @@ void qemu_start_warp_timer(void)
              */
             seqlock_write_lock(&timers_state.vm_clock_seqlock,
                                &timers_state.vm_clock_lock);
-            atomic_set__nocheck(&timers_state.qemu_icount_bias,
-                                timers_state.qemu_icount_bias + deadline);
+            atomic_set_i64(&timers_state.qemu_icount_bias,
+                           timers_state.qemu_icount_bias + deadline);
             seqlock_write_unlock(&timers_state.vm_clock_seqlock,
                                  &timers_state.vm_clock_lock);
             qemu_clock_notify(QEMU_CLOCK_VIRTUAL);
-- 
2.17.1
