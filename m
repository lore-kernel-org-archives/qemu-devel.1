Received: from eggs.gnu.org ([2001:4830:134:3::10]:37608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cFAqu-0002Qv-0X
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 21:24:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cFAqt-0008E5-3v
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 21:23:59 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  9 Dec 2016 13:23:13 +1100
Message-Id: <20161209022314.14399-5-david@gibson.dropbear.id.au>
In-Reply-To: <20161209022314.14399-1-david@gibson.dropbear.id.au>
References: <20161209022314.14399-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [for-2.9 4/5] pseries: Enable HPT resizing for 2.9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: paulus@samba.org, sjitindarsingh@gmail.com
Cc: agraf@suse.de, mdroth@linux.vnet.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, David Gibson <david@gibson.dropbear.id.au>

We've now implemented a PAPR extensions which allows PAPR guests (i.e.
"pseries" machine type) to resize their hash page table during runtime.

However, that extension is only enabled if explicitly chosen on the
command line.  This patch enables it by default for spapr-2.9, but leaves
it disabled (by default) for older machine types.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index f3b74dc..25468f6 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2770,7 +2770,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
 
     smc->dr_lmb_enabled = true;
     smc->tcg_default_cpu = "POWER8";
-    smc->resize_hpt_default = SPAPR_RESIZE_HPT_DISABLED;
+    smc->resize_hpt_default = SPAPR_RESIZE_HPT_ENABLED;
     mc->query_hotpluggable_cpus = spapr_query_hotpluggable_cpus;
     fwc->get_dev_path = spapr_get_fw_dev_path;
     nc->nmi_monitor_handler = spapr_nmi;
@@ -2851,8 +2851,11 @@ static void spapr_machine_2_8_instance_options(MachineState *machine)
 
 static void spapr_machine_2_8_class_options(MachineClass *mc)
 {
+    sPAPRMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
+
     spapr_machine_2_9_class_options(mc);
     SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_8);
+    smc->resize_hpt_default = SPAPR_RESIZE_HPT_DISABLED;
 }
 
 DEFINE_SPAPR_MACHINE(2_8, "2.8", false);
-- 
2.9.3
