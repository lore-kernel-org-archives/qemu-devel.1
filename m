Received: from eggs.gnu.org ([2001:4830:134:3::10]:35377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ermxw-0007Sb-VJ
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 10:51:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ermxt-0000hh-VJ
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 10:51:25 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33532 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ermxt-0000gu-Qa
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 10:51:21 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6580A8182D01
	for <qemu-devel@nongnu.org>; Fri,  2 Mar 2018 15:51:18 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  2 Mar 2018 16:51:10 +0100
Message-Id: <20180302155110.5481-3-pbonzini@redhat.com>
In-Reply-To: <20180302155110.5481-1-pbonzini@redhat.com>
References: <20180302155110.5481-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] q35: change default NIC to e1000e
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com, berrange@redhat.com

The e1000 NIC is getting old and is not a very good default for a
PCIe machine type.  Change it to e1000e, which should be supported
by a good number of guests.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/pc.c         | 5 +++--
 hw/i386/pc_piix.c    | 2 +-
 hw/i386/pc_q35.c     | 2 +-
 include/hw/i386/pc.h | 2 +-
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 2f7746c859..1398ac9b68 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1619,7 +1619,7 @@ void pc_basic_device_init(ISABus *isa_bus, qemu_irq *gsi,
     }
 }
 
-void pc_nic_init(ISABus *isa_bus, PCIBus *pci_bus)
+void pc_nic_init(ISABus *isa_bus, PCIBus *pci_bus, const char *default_model)
 {
     int i;
 
@@ -1630,7 +1630,8 @@ void pc_nic_init(ISABus *isa_bus, PCIBus *pci_bus)
         if (!pci_bus || (nd->model && strcmp(nd->model, "ne2k_isa") == 0)) {
             pc_init_ne2k_isa(isa_bus, nd);
         } else {
-            pci_nic_init_nofail(nd, pci_bus, "e1000", NULL);
+            const char *model = nd->model ? nd->model : default_model;
+            pci_nic_init_nofail(nd, pci_bus, model, NULL);
         }
     }
     rom_reset_order_override();
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 8658bcba63..309b052ed1 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -240,7 +240,7 @@ static void pc_init1(MachineState *machine,
     pc_basic_device_init(isa_bus, pcms->gsi, &rtc_state, true,
                          (pcms->vmport != ON_OFF_AUTO_ON), pcms->pit, 0x4);
 
-    pc_nic_init(isa_bus, pci_bus);
+    pc_nic_init(isa_bus, pci_bus, "e1000");
 
     ide_drive_get(hd, ARRAY_SIZE(hd));
     if (pcmc->pci_enabled) {
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 0c0bc48137..764179af08 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -272,7 +272,7 @@ static void pc_q35_init(MachineState *machine)
 
     /* the rest devices to which pci devfn is automatically assigned */
     pc_vga_init(isa_bus, host_bus);
-    pc_nic_init(isa_bus, host_bus);
+    pc_nic_init(isa_bus, host_bus, "e1000e");
 
     if (pcms->acpi_nvdimm_state.is_enabled) {
         nvdimm_init_acpi_state(&pcms->acpi_nvdimm_state, system_io,
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index bb49165fe0..25d71f3bb5 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -248,7 +248,7 @@ void pc_init_ne2k_isa(ISABus *bus, NICInfo *nd);
 void pc_cmos_init(PCMachineState *pcms,
                   BusState *ide0, BusState *ide1,
                   ISADevice *s);
-void pc_nic_init(ISABus *isa_bus, PCIBus *pci_bus);
+void pc_nic_init(ISABus *isa_bus, PCIBus *pci_bus, const char *default_model);
 void pc_pci_device_init(PCIBus *pci_bus);
 
 typedef void (*cpu_set_smm_t)(int smm, void *arg);
-- 
2.14.3
