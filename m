Received: from eggs.gnu.org ([2001:4830:134:3::10]:43685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dVtt5-00019H-IT
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 02:15:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dVtt3-0002Bp-Sq
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 02:15:39 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 14 Jul 2017 16:15:19 +1000
Message-Id: <20170714061521.28300-17-david@gibson.dropbear.id.au>
In-Reply-To: <20170714061521.28300-1-david@gibson.dropbear.id.au>
References: <20170714061521.28300-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 16/18] pseries: Enable HPT resizing for 2.10
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, mdroth@linux.vnet.ibm.com, groug@kaod.org, sjitindarsingh@gmail.com, sbobroff@au1.ibm.com, lvivier@redhat.com, David Gibson <david@gibson.dropbear.id.au>

We've now implemented a PAPR extensions which allows PAPR guests (i.e.
"pseries" machine type) to resize their hash page table during runtime.

However, that extension is only enabled if explicitly chosen on the
command line.  This patch enables it by default for spapr-2.10, but leaves
it disabled (by default) for older machine types.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
---
 hw/ppc/spapr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 322540b393..775cc28c78 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3433,7 +3433,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     smc->dr_lmb_enabled = true;
     smc->tcg_default_cpu = "POWER8";
     mc->has_hotpluggable_cpus = true;
-    smc->resize_hpt_default = SPAPR_RESIZE_HPT_DISABLED;
+    smc->resize_hpt_default = SPAPR_RESIZE_HPT_ENABLED;
     fwc->get_dev_path = spapr_get_fw_dev_path;
     nc->nmi_monitor_handler = spapr_nmi;
     smc->phb_placement = spapr_phb_placement;
@@ -3540,6 +3540,7 @@ static void spapr_machine_2_9_class_options(MachineClass *mc)
     SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_9);
     mc->numa_auto_assign_ram = numa_legacy_auto_assign_ram;
     smc->pre_2_10_has_unused_icps = true;
+    smc->resize_hpt_default = SPAPR_RESIZE_HPT_DISABLED;
 }
 
 DEFINE_SPAPR_MACHINE(2_9, "2.9", false);
-- 
2.13.0
