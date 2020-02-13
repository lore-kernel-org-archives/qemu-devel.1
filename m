Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53ED9C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 13:48:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19596217F4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 13:48:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19596217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2Er9-00033h-5e
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 08:48:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58122)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <miaoyubo@huawei.com>) id 1j29GO-0002A2-Lh
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 02:50:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <miaoyubo@huawei.com>) id 1j29GM-0000wO-MG
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 02:50:20 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:44312 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <miaoyubo@huawei.com>) id 1j29GM-0000pd-15
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 02:50:18 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id B77ED4E740AF9CA5FCB3;
 Thu, 13 Feb 2020 15:50:06 +0800 (CST)
Received: from DESKTOP-D7EVK5B.china.huawei.com (10.173.221.29) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Thu, 13 Feb 2020 15:49:59 +0800
From: Yubo Miao <miaoyubo@huawei.com>
To: <peter.maydell@linaro.org>, <shannon.zhaosl@gmail.com>
Subject: [RFC 1/2] arm: acpi: pci-expender-bus: Make arm to support PXB-PCIE
Date: Thu, 13 Feb 2020 15:49:51 +0800
Message-ID: <20200213074952.544-2-miaoyubo@huawei.com>
X-Mailer: git-send-email 2.24.1.windows.2
In-Reply-To: <20200213074952.544-1-miaoyubo@huawei.com>
References: <20200213074952.544-1-miaoyubo@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.221.29]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.35
X-Mailman-Approved-At: Thu, 13 Feb 2020 08:44:55 -0500
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: imammedo@redhat.com, miaoyubo@huawei.com, qemu-devel@nongnu.org,
 xiexiangyou@huawei.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: miaoyubo <miaoyubo@huawei.com>

Currently virt machine is not supported by pxb-pcie,
and only one main host bridge described in ACPI tables.
Under this circumstance, different io numas for differnt devices
is not possible, in order to present io numas to the guest,
especially for host pssthrough devices. PXB-PCIE is supproted
by arm and certain resource is allocated for each pxb-pcie
in acpi table.

Signed-off-by: miaoyubo <miaoyubo@huawei.com>
---
 hw/arm/virt-acpi-build.c | 234 +++++++++++++++++++++++++++++++++++++--
 hw/pci-host/gpex.c       |   4 +
 include/hw/arm/virt.h    |   1 +
 3 files changed, 228 insertions(+), 11 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index bd5f771e9b..2e449d0098 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -49,6 +49,8 @@
 #include "kvm_arm.h"
 #include "migration/vmstate.h"
=20
+#include "hw/arm/virt.h"
+#include "hw/pci/pci_bus.h"
 #define ARM_SPI_BASE 32
=20
 static void acpi_dsdt_add_cpus(Aml *scope, int smp_cpus)
@@ -152,20 +154,227 @@ static void acpi_dsdt_add_virtio(Aml *scope,
 }
=20
 static void acpi_dsdt_add_pci(Aml *scope, const MemMapEntry *memmap,
-                              uint32_t irq, bool use_highmem, bool highm=
em_ecam)
+                              uint32_t irq, bool use_highmem, bool highm=
em_ecam,
+                              VirtMachineState *vms)
 {
     int ecam_id =3D VIRT_ECAM_ID(highmem_ecam);
-    Aml *method, *crs, *ifctx, *UUID, *ifctx1, *elsectx, *buf;
+    Aml *method, *crs, *ifctx, *UUID, *ifctx1, *elsectx, *buf, *dev;
     int i, bus_no;
+    int count =3D 0;
     hwaddr base_mmio =3D memmap[VIRT_PCIE_MMIO].base;
     hwaddr size_mmio =3D memmap[VIRT_PCIE_MMIO].size;
     hwaddr base_pio =3D memmap[VIRT_PCIE_PIO].base;
     hwaddr size_pio =3D memmap[VIRT_PCIE_PIO].size;
     hwaddr base_ecam =3D memmap[ecam_id].base;
     hwaddr size_ecam =3D memmap[ecam_id].size;
+    /*
+     * 0x600000 would be enough for pxb device
+     * if it is too small, there is no enough space
+     * for a pcie device plugged in a pcie-root port
+     */
+    hwaddr size_addr =3D 0x600000;
+    hwaddr size_io =3D 0x4000;
     int nr_pcie_buses =3D size_ecam / PCIE_MMCFG_SIZE_MIN;
+    int root_bus_limit =3D 0xFF;
+    PCIBus *bus =3D NULL;
+    bus =3D VIRT_MACHINE(vms)->bus;
+
+    if (bus) {
+        QLIST_FOREACH(bus, &bus->child, sibling) {
+            uint8_t bus_num =3D pci_bus_num(bus);
+            uint8_t numa_node =3D pci_bus_numa_node(bus);
+
+            if (!pci_bus_is_root(bus)) {
+                continue;
+            }
+            if (bus_num < root_bus_limit) {
+                root_bus_limit =3D bus_num - 1;
+            }
+            count++;
+            dev =3D aml_device("PC%.02X", bus_num);
+            aml_append(dev, aml_name_decl("_HID", aml_string("PNP0A08"))=
);
+            aml_append(dev, aml_name_decl("_CID", aml_string("PNP0A03"))=
);
+            aml_append(dev, aml_name_decl("_ADR", aml_int(0)));
+            aml_append(dev, aml_name_decl("_CCA", aml_int(1)));
+            aml_append(dev, aml_name_decl("_SEG", aml_int(0)));
+            aml_append(dev, aml_name_decl("_BBN", aml_int(bus_num)));
+            aml_append(dev, aml_name_decl("_UID", aml_int(bus_num)));
+            aml_append(dev, aml_name_decl("_STR", aml_unicode("pxb Devic=
e")));
+            if (numa_node !=3D NUMA_NODE_UNASSIGNED) {
+                method =3D aml_method("_PXM", 0, AML_NOTSERIALIZED);
+                aml_append(method, aml_return(aml_int(numa_node)));
+                aml_append(dev, method);
+            }
+            /* Declare the PCI Routing Table. */
+            Aml *rt_pkg =3D aml_varpackage(nr_pcie_buses * PCI_NUM_PINS)=
;
+            for (bus_no =3D 0; bus_no < nr_pcie_buses; bus_no++) {
+                for (i =3D 0; i < PCI_NUM_PINS; i++) {
+                    int gsi =3D (i + bus_no) % (PCI_NUM_PINS);
+                    Aml *pkg =3D aml_package(4);
+                    aml_append(pkg, aml_int((bus_no << 16) | 0xFFFF));
+                    aml_append(pkg, aml_int(i));
+                    aml_append(pkg, aml_name("GSI%d", gsi));
+                    aml_append(pkg, aml_int(0));
+                    aml_append(rt_pkg, pkg);
+                }
+            }
+            aml_append(dev, aml_name_decl("_PRT", rt_pkg));
+
+            for (i =3D 0; i < PCI_NUM_PINS; i++) {
+                uint32_t irqs =3D  irq + i;
+                Aml *dev_gsi =3D aml_device("GSI%d", i);
+                aml_append(dev_gsi, aml_name_decl("_HID",
+                           aml_string("PNP0C0F")));
+                aml_append(dev_gsi, aml_name_decl("_UID", aml_int(0)));
+                crs =3D aml_resource_template();
+                aml_append(crs,
+                           aml_interrupt(AML_CONSUMER, AML_LEVEL,
+                                         AML_ACTIVE_HIGH,
+                                         AML_EXCLUSIVE, &irqs, 1));
+                aml_append(dev_gsi, aml_name_decl("_PRS", crs));
+                crs =3D aml_resource_template();
+                aml_append(crs,
+                           aml_interrupt(AML_CONSUMER, AML_LEVEL,
+                                         AML_ACTIVE_HIGH,
+                                         AML_EXCLUSIVE, &irqs, 1));
+                aml_append(dev_gsi, aml_name_decl("_CRS", crs));
+                method =3D aml_method("_SRS", 1, AML_NOTSERIALIZED);
+                aml_append(dev_gsi, method);
+                aml_append(dev, dev_gsi);
+            }
+
+            method =3D aml_method("_CBA", 0, AML_NOTSERIALIZED);
+            aml_append(method, aml_return(aml_int(base_ecam)));
+            aml_append(dev, method);
+
+            method =3D aml_method("_CRS", 0, AML_NOTSERIALIZED);
+            Aml *rbuf =3D aml_resource_template();
+            aml_append(rbuf,
+                       aml_word_bus_number(AML_MIN_FIXED, AML_MAX_FIXED,
+                                           AML_POS_DECODE, 0x0000,
+                                           bus_num, bus_num + 1, 0x0000,
+                                           2));
+            aml_append(rbuf,
+                       aml_dword_memory(AML_POS_DECODE, AML_MIN_FIXED,
+                                        AML_MAX_FIXED, AML_NON_CACHEABLE=
,
+                                        AML_READ_WRITE, 0x0000,
+                                        base_mmio + size_mmio -
+                                        size_addr * count,
+                                        base_mmio + size_mmio - 1 -
+                                        size_addr * (count - 1),
+                                        0x0000, size_addr));
+            aml_append(rbuf,
+                       aml_dword_io(AML_MIN_FIXED, AML_MAX_FIXED,
+                       AML_POS_DECODE, AML_ENTIRE_RANGE,
+                       0x0000, (size_pio) / 2 - size_io * count,
+                       (size_pio / 2) - 1 - size_io * (count - 1),
+                       base_pio, size_io));
+
+            if (use_highmem) {
+                hwaddr base_mmio_high =3D memmap[VIRT_HIGH_PCIE_MMIO].ba=
se;
+                hwaddr size_mmio_high =3D memmap[VIRT_HIGH_PCIE_MMIO].si=
ze;
+
+                aml_append(rbuf,
+                       aml_qword_memory(AML_POS_DECODE, AML_MIN_FIXED,
+                                        AML_MAX_FIXED, AML_NON_CACHEABLE=
,
+                                        AML_READ_WRITE, 0x0000,
+                                        base_mmio_high + size_mmio_high =
-
+                                        size_addr * count,
+                                        base_mmio_high + size_mmio_high =
-
+                                        1 - size_addr * (count - 1),
+                                        0x0000, size_addr));
+            }
+
+            aml_append(method, aml_name_decl("RBUF", rbuf));
+            aml_append(method, aml_return(rbuf));
+            aml_append(dev, method);
+            /* Declare an _OSC (OS Control Handoff) method */
+            aml_append(dev, aml_name_decl("SUPP", aml_int(0)));
+            aml_append(dev, aml_name_decl("CTRL", aml_int(0)));
+            method =3D aml_method("_OSC", 4, AML_NOTSERIALIZED);
+            aml_append(method,
+            aml_create_dword_field(aml_arg(3), aml_int(0), "CDW1"));
+
+            /*
+             * PCI Firmware Specification 3.0
+             * 4.5.1. _OSC Interface for PCI Host Bridge Devices
+             * The _OSC interface for a PCI/PCI-X/PCI Express hierarchy =
is
+             * identified by the Universal Unique IDentifier (UUID)
+             * 33DB4D5B-1FF7-401C-9657-7441C03DD766
+             */
+            UUID =3D aml_touuid("33DB4D5B-1FF7-401C-9657-7441C03DD766");
+            ifctx =3D aml_if(aml_equal(aml_arg(0), UUID));
+            aml_append(ifctx,
+                aml_create_dword_field(aml_arg(3), aml_int(4), "CDW2"));
+            aml_append(ifctx,
+                aml_create_dword_field(aml_arg(3), aml_int(8), "CDW3"));
+            aml_append(ifctx, aml_store(aml_name("CDW2"), aml_name("SUPP=
")));
+            aml_append(ifctx, aml_store(aml_name("CDW3"), aml_name("CTRL=
")));
+            /*
+             * Allow OS control for all 5 features:
+             * PCIeHotplug SHPCHotplug PME AER PCIeCapability.
+             */
+            aml_append(ifctx,
+                       aml_store(aml_and(aml_name("CTRL"), aml_int(0x1F)=
, NULL),
+                       aml_name("CTRL")));
+
+            ifctx1 =3D aml_if(aml_lnot(aml_equal(aml_arg(1), aml_int(0x1=
))));
+            aml_append(ifctx1,
+                       aml_store(aml_or(aml_name("CDW1"), aml_int(0x08),=
 NULL),
+                       aml_name("CDW1")));
+            aml_append(ifctx, ifctx1);
+
+            ifctx1 =3D aml_if(aml_lnot(aml_equal(aml_name("CDW3"),
+                            aml_name("CTRL"))));
+            aml_append(ifctx1,
+                       aml_store(aml_or(aml_name("CDW1"), aml_int(0x10),=
 NULL),
+                                 aml_name("CDW1")));
+            aml_append(ifctx, ifctx1);
+
+            aml_append(ifctx, aml_store(aml_name("CTRL"), aml_name("CDW3=
")));
+            aml_append(ifctx, aml_return(aml_arg(3)));
+            aml_append(method, ifctx);
+
+            elsectx =3D aml_else();
+            aml_append(elsectx,
+                       aml_store(aml_or(aml_name("CDW1"), aml_int(4), NU=
LL),
+                       aml_name("CDW1")));
+            aml_append(elsectx, aml_return(aml_arg(3)));
+            aml_append(method, elsectx);
+            aml_append(dev, method);
+
+            method =3D aml_method("_DSM", 4, AML_NOTSERIALIZED);
+
+            /*
+             * PCI Firmware Specification 3.0
+             * 4.6.1. _DSM for PCI Express Slot Information
+             * The UUID in _DSM in this context is
+             * {E5C937D0-3553-4D7A-9117-EA4D19C3434D}
+             */
+            UUID =3D aml_touuid("E5C937D0-3553-4D7A-9117-EA4D19C3434D");
+            ifctx =3D aml_if(aml_equal(aml_arg(0), UUID));
+            ifctx1 =3D aml_if(aml_equal(aml_arg(2), aml_int(0)));
+            uint8_t byte_list[1] =3D {1};
+            buf =3D aml_buffer(1, byte_list);
+            aml_append(ifctx1, aml_return(buf));
+            aml_append(ifctx, ifctx1);
+            aml_append(method, ifctx);
+
+            byte_list[0] =3D 0;
+            buf =3D aml_buffer(1, byte_list);
+            aml_append(method, aml_return(buf));
+            aml_append(dev, method);
+
+            Aml *dev_rp0 =3D aml_device("%s", "RP0");
+            aml_append(dev_rp0, aml_name_decl("_ADR", aml_int(0)));
+            aml_append(dev, dev_rp0);
+
+            aml_append(scope, dev);
+
+        }
+    }
=20
-    Aml *dev =3D aml_device("%s", "PCI0");
+    dev =3D aml_device("%s", "PCI0");
     aml_append(dev, aml_name_decl("_HID", aml_string("PNP0A08")));
     aml_append(dev, aml_name_decl("_CID", aml_string("PNP0A03")));
     aml_append(dev, aml_name_decl("_SEG", aml_int(0)));
@@ -219,16 +428,18 @@ static void acpi_dsdt_add_pci(Aml *scope, const Mem=
MapEntry *memmap,
     Aml *rbuf =3D aml_resource_template();
     aml_append(rbuf,
         aml_word_bus_number(AML_MIN_FIXED, AML_MAX_FIXED, AML_POS_DECODE=
,
-                            0x0000, 0x0000, nr_pcie_buses - 1, 0x0000,
-                            nr_pcie_buses));
+                            0x0000, 0x0000, root_bus_limit, 0x0000,
+                            root_bus_limit + 1));
     aml_append(rbuf,
         aml_dword_memory(AML_POS_DECODE, AML_MIN_FIXED, AML_MAX_FIXED,
                          AML_NON_CACHEABLE, AML_READ_WRITE, 0x0000, base=
_mmio,
-                         base_mmio + size_mmio - 1, 0x0000, size_mmio));
+                         base_mmio + size_mmio - 1 - size_addr * count,
+                         0x0000, size_mmio - size_addr * count));
     aml_append(rbuf,
         aml_dword_io(AML_MIN_FIXED, AML_MAX_FIXED, AML_POS_DECODE,
-                     AML_ENTIRE_RANGE, 0x0000, 0x0000, size_pio - 1, bas=
e_pio,
-                     size_pio));
+                     AML_ENTIRE_RANGE, 0x0000, 0x0000,
+                     size_pio / 2 - 1 - size_io * count, base_pio,
+                     size_pio / 2 - size_io * count));
=20
     if (use_highmem) {
         hwaddr base_mmio_high =3D memmap[VIRT_HIGH_PCIE_MMIO].base;
@@ -238,8 +449,9 @@ static void acpi_dsdt_add_pci(Aml *scope, const MemMa=
pEntry *memmap,
             aml_qword_memory(AML_POS_DECODE, AML_MIN_FIXED, AML_MAX_FIXE=
D,
                              AML_NON_CACHEABLE, AML_READ_WRITE, 0x0000,
                              base_mmio_high,
-                             base_mmio_high + size_mmio_high - 1, 0x0000=
,
-                             size_mmio_high));
+                             base_mmio_high + size_mmio_high - 1 -
+                             size_addr * count,
+                             0x0000, size_mmio_high - size_addr * count)=
);
     }
=20
     aml_append(method, aml_name_decl("RBUF", rbuf));
@@ -744,7 +956,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, Vi=
rtMachineState *vms)
     acpi_dsdt_add_virtio(scope, &memmap[VIRT_MMIO],
                     (irqmap[VIRT_MMIO] + ARM_SPI_BASE), NUM_VIRTIO_TRANS=
PORTS);
     acpi_dsdt_add_pci(scope, memmap, (irqmap[VIRT_PCIE] + ARM_SPI_BASE),
-                      vms->highmem, vms->highmem_ecam);
+                      vms->highmem, vms->highmem_ecam, vms);
     if (vms->acpi_dev) {
         build_ged_aml(scope, "\\_SB."GED_DEVICE,
                       HOTPLUG_HANDLER(vms->acpi_dev),
diff --git a/hw/pci-host/gpex.c b/hw/pci-host/gpex.c
index 0ca604dc62..2c18cdfec4 100644
--- a/hw/pci-host/gpex.c
+++ b/hw/pci-host/gpex.c
@@ -36,6 +36,7 @@
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
+#include "hw/arm/virt.h"
=20
 /***********************************************************************=
*****
  * GPEX host
@@ -98,6 +99,9 @@ static void gpex_host_realize(DeviceState *dev, Error *=
*errp)
                                      pci_swizzle_map_irq_fn, s, &s->io_m=
mio,
                                      &s->io_ioport, 0, 4, TYPE_PCIE_BUS)=
;
=20
+#ifdef __aarch64__
+    VIRT_MACHINE(qdev_get_machine())->bus =3D pci->bus;
+#endif
     qdev_set_parent_bus(DEVICE(&s->gpex_root), BUS(pci->bus));
     pci_bus_set_route_irq_fn(pci->bus, gpex_route_intx_pin_to_irq);
     qdev_init_nofail(DEVICE(&s->gpex_root));
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 71508bf40c..cfc65dd19b 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -140,6 +140,7 @@ typedef struct {
     DeviceState *gic;
     DeviceState *acpi_dev;
     Notifier powerdown_notifier;
+    PCIBus *bus;
 } VirtMachineState;
=20
 #define VIRT_ECAM_ID(high) (high ? VIRT_HIGH_PCIE_ECAM : VIRT_PCIE_ECAM)
--=20
2.19.1



