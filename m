Received: from eggs.gnu.org ([2001:4830:134:3::10]:40237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fzVjm-0003UC-RU
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 19:37:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fzVbU-0005LM-Hw
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 19:28:26 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:60641)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fzVbU-0005Jm-Ap
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 19:28:24 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon, 10 Sep 2018 19:27:49 -0400
Message-Id: <20180910232752.31565-10-cota@braap.org>
In-Reply-To: <20180910232752.31565-1-cota@braap.org>
References: <20180910232752.31565-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v2 09/12] cpus: access .qemu_icount with
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
 cpus.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/cpus.c b/cpus.c
index 38dabb138d..f045416c94 100644
--- a/cpus.c
+++ b/cpus.c
@@ -252,8 +252,8 @@ void cpu_update_icount(CPUState *cpu)
 
     seqlock_write_lock(&timers_state.vm_clock_seqlock,
                        &timers_state.vm_clock_lock);
-    atomic_set__nocheck(&timers_state.qemu_icount,
-                        timers_state.qemu_icount + executed);
+    atomic_set_i64(&timers_state.qemu_icount,
+                   timers_state.qemu_icount + executed);
     seqlock_write_unlock(&timers_state.vm_clock_seqlock,
                          &timers_state.vm_clock_lock);
 }
@@ -270,8 +270,8 @@ static int64_t cpu_get_icount_raw_locked(void)
         /* Take into account what has run */
         cpu_update_icount(cpu);
     }
-    /* The read is protected by the seqlock, so __nocheck is okay.  */
-    return atomic_read__nocheck(&timers_state.qemu_icount);
+    /* The read is protected by the seqlock, but needs atomic64 to avoid UB */
+    return atomic_read_i64(&timers_state.qemu_icount);
 }
 
 static int64_t cpu_get_icount_locked(void)
-- 
2.17.1
