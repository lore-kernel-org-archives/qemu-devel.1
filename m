Received: from eggs.gnu.org ([2001:4830:134:3::10]:50408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cjwhR-0003Lz-LK
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 18:33:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cjwhO-0003x2-J3
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 18:33:25 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43034)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cjwhO-0003w5-9v
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 18:33:22 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v23NSgcn087913
	for <qemu-devel@nongnu.org>; Fri, 3 Mar 2017 18:33:20 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28xs8f6vj2-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 03 Mar 2017 18:33:19 -0500
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Fri, 3 Mar 2017 16:33:19 -0700
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Fri,  3 Mar 2017 17:32:57 -0600
Message-Id: <1488583977-32253-1-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2] spapr_pci: allow control of BAR alignment
 through SLOF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, Alexey Kardashevskiy <aik@ozlabs.ru>

In certain cases, such as PCI-passthrough with VFIO, we cannot offload
MMIO accesses to KVM unless the BAR alignment matches the host. This
patch, in conjunction with a separately submitted patch for SLOF
which allows for control of this via the device-tree, allows us to
set this alignment via QEMU.

Cc: qemu-ppc@nongnu.org
Cc: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
v2:
  * Keep natural alignment as the default in SLOF, only set DT prop if
    different alignment is specified by QEMU (David)
---
 hw/ppc/spapr.c              |  7 ++++++-
 hw/ppc/spapr_pci.c          | 10 ++++++++++
 include/hw/pci-host/spapr.h |  1 +
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 14192ac..ef8df35 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3166,7 +3166,12 @@ DEFINE_SPAPR_MACHINE(2_9, "2.9", true);
  * pseries-2.8
  */
 #define SPAPR_COMPAT_2_8                            \
-    HW_COMPAT_2_8
+    HW_COMPAT_2_8                                   \
+    {                                               \
+        .driver   = TYPE_SPAPR_PCI_HOST_BRIDGE,     \
+        .property = "mem_bar_min_align",            \
+        .value    = "0",                            \
+    },                                              \
 
 static void spapr_machine_2_8_instance_options(MachineState *machine)
 {
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 919d3c2..485d32d 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1664,6 +1664,10 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    if (sphb->mem_bar_min_align == (uint64_t)-1) {
+        sphb->mem_bar_min_align = qemu_real_host_page_size;
+    }
+
     sphb->dtbusname = g_strdup_printf("pci@%" PRIx64, sphb->buid);
 
     namebuf = alloca(strlen(sphb->dtbusname) + 32);
@@ -1858,6 +1862,8 @@ static Property spapr_phb_properties[] = {
     DEFINE_PROP_UINT32("numa_node", sPAPRPHBState, numa_node, -1),
     DEFINE_PROP_BOOL("pre-2.8-migration", sPAPRPHBState,
                      pre_2_8_migration, false),
+    DEFINE_PROP_UINT64("mem_bar_min_align", sPAPRPHBState, mem_bar_min_align,
+                       -1),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -2228,6 +2234,10 @@ int spapr_populate_pci_dt(sPAPRPHBState *phb,
     if (ret) {
         return ret;
     }
+    if (phb->mem_bar_min_align) {
+        _FDT(fdt_setprop_cell(fdt, bus_off, "qemu,mem-bar-min-align",
+                              phb->mem_bar_min_align));
+    }
 
     return 0;
 }
diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
index dfa7614..fa33346 100644
--- a/include/hw/pci-host/spapr.h
+++ b/include/hw/pci-host/spapr.h
@@ -79,6 +79,7 @@ struct sPAPRPHBState {
     uint64_t dma64_win_addr;
 
     uint32_t numa_node;
+    uint64_t mem_bar_min_align;
 
     /* Fields for migration compatibility hacks */
     bool pre_2_8_migration;
-- 
2.7.4
