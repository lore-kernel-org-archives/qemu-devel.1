Received: from eggs.gnu.org ([2001:4830:134:3::10]:60631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f934T-0005ZZ-62
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 02:29:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f934Q-0005Sw-OM
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 02:29:29 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 19 Apr 2018 16:29:15 +1000
Message-Id: <20180419062917.31486-6-david@gibson.dropbear.id.au>
In-Reply-To: <20180419062917.31486-1-david@gibson.dropbear.id.au>
References: <20180419062917.31486-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [RFC for-2.13 5/7] spapr: Limit available pagesizes to
 provide a consistent guest environment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: groug@kaod.org, abologna@redhat.com
Cc: aik@ozlabs.ru, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>

KVM HV has some limitations (deriving from the hardware) that mean not all
host-cpu supported pagesizes may be usable in the guest.  At present this
means that KVM guests and TCG guests may see different available page sizes
even if they notionally have the same vcpu model.  This is confusing and
also prevents migration between TCG and KVM.

This patch makes the environment consistent by always allowing the same set
of pagesizes.  Since we can't remove the KVM limitations, we do this by
always applying the same limitations it has, even to TCG guests.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_caps.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index e71de14ffb..5a247f190f 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -331,6 +331,38 @@ static void cap_hpt_mps_apply(sPAPRMachineState *spapr,
     spapr_check_pagesize(spapr, qemu_getrampagesize(), errp);
 }
 
+static bool spapr_pagesize_cb(void *opaque, uint32_t seg_pshift, uint32_t pshift)
+{
+    unsigned maxshift = *((unsigned *)opaque);
+
+    assert(pshift >= seg_pshift);
+
+    /* Don't allow the guest to use pages bigger than the configured
+     * maximum size */
+    if (pshift > maxshift) {
+        return false;
+    }
+
+    /* For whatever reason, KVM doesn't allow multiple pagesizes
+     * within a segment, *except* for the case of 16M pages in a 4k or
+     * 64k segment.  Always exclude other cases, so that TCG and KVM
+     * guests see a consistent environment */
+    if ((pshift != seg_pshift) && (pshift != 24)) {
+        return false;
+    }
+
+    return true;
+}
+
+static void cap_hpt_mps_cpu_apply(sPAPRMachineState *spapr,
+                                   PowerPCCPU *cpu,
+                                   uint8_t val, Error **errp)
+{
+    unsigned maxshift = val;
+
+    ppc_hash64_filter_pagesizes(cpu, spapr_pagesize_cb, &maxshift);
+}
+
 sPAPRCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
     [SPAPR_CAP_HTM] = {
         .name = "htm",
@@ -398,6 +430,7 @@ sPAPRCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
         .set = spapr_cap_set_int,
         .type = "int",
         .apply = cap_hpt_mps_apply,
+        .cpu_apply = cap_hpt_mps_cpu_apply,
     },
 };
 
-- 
2.14.3
