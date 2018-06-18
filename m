Received: from eggs.gnu.org ([2001:4830:134:3::10]:49665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUlEW-0005IY-JU
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 23:53:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUlET-0003vk-HW
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 23:53:36 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 18 Jun 2018 13:52:57 +1000
Message-Id: <20180618035324.19907-2-david@gibson.dropbear.id.au>
In-Reply-To: <20180618035324.19907-1-david@gibson.dropbear.id.au>
References: <20180618035324.19907-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 01/28] target/ppc: Don't require private l1d
 cache on POWER8 for cap_ppc_safe_cache
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org, clg@kaod.org, agraf@suse.de, aik@ozlabs.ru, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, David Gibson <david@gibson.dropbear.id.au>

From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

For cap_ppc_safe_cache to be set to workaround, we require both a l1d
cache flush instruction and private l1d cache.

On POWER8 don't require private l1d cache. This means a guest on a
POWER8 machine can make use of the cache flush workarounds.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/kvm.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 2c0c34e125..7fe9d0126b 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2412,11 +2412,28 @@ bool kvmppc_has_cap_mmu_hash_v3(void)
     return cap_mmu_hash_v3;
 }
 
+static bool kvmppc_power8_host(void)
+{
+    bool ret = false;
+#ifdef TARGET_PPC64
+    {
+        uint32_t base_pvr = CPU_POWERPC_POWER_SERVER_MASK & mfpvr();
+        ret = (base_pvr == CPU_POWERPC_POWER8E_BASE) ||
+              (base_pvr == CPU_POWERPC_POWER8NVL_BASE) ||
+              (base_pvr == CPU_POWERPC_POWER8_BASE);
+    }
+#endif /* TARGET_PPC64 */
+    return ret;
+}
+
 static int parse_cap_ppc_safe_cache(struct kvm_ppc_cpu_char c)
 {
+    bool l1d_thread_priv_req = !kvmppc_power8_host();
+
     if (~c.behaviour & c.behaviour_mask & H_CPU_BEHAV_L1D_FLUSH_PR) {
         return 2;
-    } else if ((c.character & c.character_mask & H_CPU_CHAR_L1D_THREAD_PRIV) &&
+    } else if ((!l1d_thread_priv_req ||
+                c.character & c.character_mask & H_CPU_CHAR_L1D_THREAD_PRIV) &&
                (c.character & c.character_mask
                 & (H_CPU_CHAR_L1D_FLUSH_ORI30 | H_CPU_CHAR_L1D_FLUSH_TRIG2))) {
         return 1;
-- 
2.17.1
