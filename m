Received: from eggs.gnu.org ([2001:4830:134:3::10]:55704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1f5V0L-0005ES-0t
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 07:30:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1f5V0H-0007SG-SB
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 07:30:33 -0400
From: David Hildenbrand <david@redhat.com>
Date: Mon,  9 Apr 2018 13:30:19 +0200
Message-Id: <20180409113019.14568-3-david@redhat.com>
In-Reply-To: <20180409113019.14568-1-david@redhat.com>
References: <20180409113019.14568-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 for-2.12 2/2] s390x: load_psw() should only
 exchange the PSW for KVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>

Let's simplify it a bit. On some weird circumstances we would have tried
to recompute watchpoints when running under KVM.

Signed-off-by: David Hildenbrand <david@redhat.com>
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
