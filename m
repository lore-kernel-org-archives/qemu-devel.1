Received: from eggs.gnu.org ([2001:4830:134:3::10]:35199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciDc8-0000gy-2R
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 00:12:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciDc7-0006kX-1Y
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 00:12:48 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 27 Feb 2017 16:12:34 +1100
Message-Id: <20170227051239.2680-5-david@gibson.dropbear.id.au>
In-Reply-To: <20170227051239.2680-1-david@gibson.dropbear.id.au>
References: <20170227051239.2680-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCHv2 4/9] target/ppc: SDR1 is a hypervisor resource
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, aik@ozlabs.ru, sjitindarsingh@gmail.com, aneesh.kumar@linux.vnet.ibm.com
Cc: qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, agraf@suse.de, mdroth@linux.vnet.ibm.com, David Gibson <david@gibson.dropbear.id.au>

At present the SDR1 register - the base of the system's hashed page table
(HPT) - is represented as an SPR with supervisor read and write permission.
However, on CPUs which have a hypervisor mode, the SDR1 is a hypervisor
only resource.  Change the permission checking on the SPR to reflect this.

Now that this is done, we don't need to check for an external HPT executing
mtsdr1: an external HPT only applies when we're emulating the behaviour of
a hypervisor, rather than modelling the CPU's hypervisor mode internally,
so if we're permitted to execute mtsdr1, we don't have an external HPT.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 target/ppc/misc_helper.c    |  8 +++-----
 target/ppc/translate_init.c | 20 ++++++++++++++++----
 2 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
index ab432ba..fa573dd 100644
--- a/target/ppc/misc_helper.c
+++ b/target/ppc/misc_helper.c
@@ -82,11 +82,9 @@ void helper_store_sdr1(CPUPPCState *env, target_ulong val)
 {
     PowerPCCPU *cpu = ppc_env_get_cpu(env);
 
-    if (!env->external_htab) {
-        if (env->spr[SPR_SDR1] != val) {
-            ppc_store_sdr1(env, val);
-            tlb_flush(CPU(cpu));
-        }
+    if (env->spr[SPR_SDR1] != val) {
+        ppc_store_sdr1(env, val);
+        tlb_flush(CPU(cpu));
     }
 }
 
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index a1405e9..c92435d 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -740,10 +740,22 @@ static void gen_spr_ne_601 (CPUPPCState *env)
                  &spr_read_decr, &spr_write_decr,
                  0x00000000);
     /* Memory management */
-    spr_register(env, SPR_SDR1, "SDR1",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_sdr1,
-                 0x00000000);
+#ifndef CONFIG_USER_ONLY
+    if (env->has_hv_mode) {
+        /* SDR1 is a hypervisor resource on CPUs which have a
+         * hypervisor mode */
+        spr_register_hv(env, SPR_SDR1, "SDR1",
+                        SPR_NOACCESS, SPR_NOACCESS,
+                        SPR_NOACCESS, SPR_NOACCESS,
+                        &spr_read_generic, &spr_write_sdr1,
+                        0x00000000);
+    } else {
+        spr_register(env, SPR_SDR1, "SDR1",
+                     SPR_NOACCESS, SPR_NOACCESS,
+                     &spr_read_generic, &spr_write_sdr1,
+                     0x00000000);
+    }
+#endif
 }
 
 /* BATs 0-3 */
-- 
2.9.3
