Received: from eggs.gnu.org ([2001:4830:134:3::10]:46204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciw7h-0007uD-1i
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 23:44:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciw7g-0008Sn-0h
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 23:44:21 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed,  1 Mar 2017 15:43:25 +1100
Message-Id: <20170301044405.1792-11-david@gibson.dropbear.id.au>
In-Reply-To: <20170301044405.1792-1-david@gibson.dropbear.id.au>
References: <20170301044405.1792-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 10/50] target/ppc: SDR1 is a hypervisor resource
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, thuth@redhat.com, lvivier@redhat.com, David Gibson <david@gibson.dropbear.id.au>

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
