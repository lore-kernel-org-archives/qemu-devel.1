Received: from eggs.gnu.org ([2001:4830:134:3::10]:47765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f5YWS-0006CX-FC
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 11:15:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f5YWR-0005cy-Is
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 11:15:56 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon,  9 Apr 2018 17:15:33 +0200
Message-Id: <20180409151533.2253-9-cohuck@redhat.com>
In-Reply-To: <20180409151533.2253-1-cohuck@redhat.com>
References: <20180409151533.2253-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL for-2.12 8/8] s390x: load_psw() should only
 exchange the PSW for KVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

Let's simplify it a bit. On some weird circumstances we would have
tried to recompute watchpoints when running under KVM. load_psw() is
called from do_restart_interrupt() during a SIGP RESTART if the target
CPU is STOPPED. Let's touch watchpoints only in the TCG case - where
they are used for PER emulation.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20180409113019.14568-3-david@redhat.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/helper.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index 615fa24ab9..e8548f340a 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -103,16 +103,18 @@ void load_psw(CPUS390XState *env, uint64_t mask, uint64_t addr)
 
     env->psw.addr = addr;
     env->psw.mask = mask;
-    if (tcg_enabled()) {
-        env->cc_op = (mask >> 44) & 3;
+
+    /* KVM will handle all WAITs and trigger a WAIT exit on disabled_wait */
+    if (!tcg_enabled()) {
+        return;
     }
+    env->cc_op = (mask >> 44) & 3;
 
     if ((old_mask ^ mask) & PSW_MASK_PER) {
         s390_cpu_recompute_watchpoints(CPU(s390_env_get_cpu(env)));
     }
 
-    /* KVM will handle all WAITs and trigger a WAIT exit on disabled_wait */
-    if (tcg_enabled() && (mask & PSW_MASK_WAIT)) {
+    if (mask & PSW_MASK_WAIT) {
         s390_handle_wait(s390_env_get_cpu(env));
     }
 }
-- 
2.14.3
