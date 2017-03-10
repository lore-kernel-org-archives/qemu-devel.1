Received: from eggs.gnu.org ([2001:4830:134:3::10]:50188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cm97m-0006Fj-Gb
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 20:13:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cm97k-0003se-41
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 20:13:42 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 10 Mar 2017 12:13:26 +1100
Message-Id: <20170310011328.30719-4-david@gibson.dropbear.id.au>
In-Reply-To: <20170310011328.30719-1-david@gibson.dropbear.id.au>
References: <20170310011328.30719-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCH for-2.10 3/5] pseries: Enable HPT resizing for
 2.10
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, agraf@suse.de, sjitindarsingh@gmail.com, sam.bobroff@au1.ibm.com, David Gibson <david@gibson.dropbear.id.au>

We've now implemented a PAPR extensions which allows PAPR guests (i.e.
"pseries" machine type) to resize their hash page table during runtime.

However, that extension is only enabled if explicitly chosen on the
command line.  This patch enables it by default for spapr-2.10, but leaves
it disabled (by default) for older machine types.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index bf6ba64..6553f2c 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3155,7 +3155,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     smc->dr_lmb_enabled = true;
     smc->tcg_default_cpu = "POWER8";
     mc->has_hotpluggable_cpus = true;
-    smc->resize_hpt_default = SPAPR_RESIZE_HPT_DISABLED;
+    smc->resize_hpt_default = SPAPR_RESIZE_HPT_ENABLED;
     fwc->get_dev_path = spapr_get_fw_dev_path;
     nc->nmi_monitor_handler = spapr_nmi;
     smc->phb_placement = spapr_phb_placement;
@@ -3246,8 +3246,11 @@ static void spapr_machine_2_9_instance_options(MachineState *machine)
 
 static void spapr_machine_2_9_class_options(MachineClass *mc)
 {
+    sPAPRMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
+
     spapr_machine_2_10_class_options(mc);
     SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_9);
+    smc->resize_hpt_default = SPAPR_RESIZE_HPT_DISABLED;
 }
 
 DEFINE_SPAPR_MACHINE(2_9, "2.9", false);
-- 
2.9.3
