Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E732CA9EBC
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 22:50:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEBE220663
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 22:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dtEBLeTD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEBE220663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNPS5-0005Va-OW
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 18:50:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58573)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1iNPPp-0002mh-Rn
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 18:47:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1iNPPo-0007kt-0g
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 18:47:41 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56123
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1iNPPn-0007kN-Sp
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 18:47:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571870859;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WQ9ATuF+8iTM/ych0GJuV5txOigAQQgIJ6+qrzJWQyo=;
 b=dtEBLeTD2EiwYyIwrFk30iiWMRrJv9Nw/I9VMkyFZjnzQJ01mIDvx29QoKDkPMji88fGcV
 V4rxs7ppuOogHQ01p6OKv14e5xstmXIsXPOwt6jO8OsUx7xRPvHoXmXcR8EizX+OWqDZZ8
 /50eSqoLQ7bhuoBBTBwrdlhD1kDYfmo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-niap3piQMiOmy8fCTjyTMw-1; Wed, 23 Oct 2019 18:47:37 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D65B21800D6B
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 22:47:36 +0000 (UTC)
Received: from gimli.home (ovpn-118-102.phx2.redhat.com [10.3.118.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8B60D19C77;
 Wed, 23 Oct 2019 22:47:29 +0000 (UTC)
Subject: [RESEND PATCH 2/2] hw/i386: AMD-Vi IVRS DMA alias support
From: Alex Williamson <alex.williamson@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 23 Oct 2019 16:47:28 -0600
Message-ID: <157187084880.5439.16700585779699233836.stgit@gimli.home>
In-Reply-To: <157187055395.5439.6693401317571144578.stgit@gimli.home>
References: <157187055395.5439.6693401317571144578.stgit@gimli.home>
User-Agent: StGit/0.19-dirty
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: niap3piQMiOmy8fCTjyTMw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: peterx@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When we account for DMA aliases in the PCI address space, we can no
longer use a single IVHD entry in the IVRS covering all devices.  We
instead need to walk the PCI bus and create alias ranges when we find
a conventional bus.  These alias ranges cannot overlap with a "Select
All" range (as currently implemented), so we also need to enumerate
each device with IVHD entries.

Importantly, the IVHD entries used here include a Device ID, which is
simply the PCI BDF (Bus/Device/Function).  The guest firmware is
responsible for programming bus numbers, so the final revision of this
table depends on the update mechanism (acpi_build_update) to be called
after guest PCI enumeration.

For an example guest configuration of:

-+-[0000:40]---00.0-[41]----00.0  Intel Corporation 82574L Gigabit Network =
Connection
 \-[0000:00]-+-00.0  Intel Corporation 82G33/G31/P35/P31 Express DRAM Contr=
oller
             +-01.0  Device 1234:1111
             +-02.0-[01]----00.0  Intel Corporation 82574L Gigabit Network =
Connection
             +-02.1-[02]----00.0  Red Hat, Inc. QEMU XHCI Host Controller
             +-02.2-[03]--
             +-02.3-[04]--
             +-02.4-[05]--
             +-02.5-[06-09]----00.0-[07-09]--+-00.0-[08]--
             |                               \-01.0-[09]----00.0  Intel Cor=
poration 82574L Gigabit Network Connection
             +-02.6-[0a-0c]----00.0-[0b-0c]--+-01.0-[0c]--
             |                               \-03.0  Intel Corporation 8254=
0EM Gigabit Ethernet Controller
             +-02.7-[0d]----0e.0  Intel Corporation 82540EM Gigabit Etherne=
t Controller
             +-03.0  Red Hat, Inc. QEMU PCIe Expander bridge
             +-04.0  Advanced Micro Devices, Inc. [AMD] Device 0020
             +-1f.0  Intel Corporation 82801IB (ICH9) LPC Interface Control=
ler
             +-1f.2  Intel Corporation 82801IR/IO/IH (ICH9R/DO/DH) 6 port S=
ATA Controller [AHCI mode]
             \-1f.3  Intel Corporation 82801I (ICH9 Family) SMBus Controlle=
r

Where we have:

00:02.7 PCI bridge: Intel Corporation 82801 PCI Bridge
 (dmi-to-pci-bridge)
00:03.0 Host bridge: Red Hat, Inc. QEMU PCIe Expander bridge
 (pcie-expander-bus)
06:00.0 PCI bridge: Texas Instruments XIO3130 PCI Express Switch (Upstream)
 (pcie-switch-upstream-port)
07:00.0 PCI bridge: Texas Instruments XIO3130 PCI Express Switch (Downstrea=
m)
 (pcie-switch-downstream-port)
07:01.0 PCI bridge: Texas Instruments XIO3130 PCI Express Switch (Downstrea=
m)
 (pcie-switch-downstream-port)
0a:00.0 PCI bridge: Red Hat, Inc. Device 000e
 (pcie-to-pci-bridge)

The following IVRS table is produced:

AMD-Vi: Using IVHD type 0x10
AMD-Vi: device: 00:04.0 cap: 0040 seg: 0 flags: d1 info 0000
AMD-Vi:        mmio-addr: 00000000fed80000
AMD-Vi:   DEV_SELECT=09=09=09 devid: 40:00.0 flags: 00
AMD-Vi:   DEV_SELECT_RANGE_START=09 devid: 41:00.0 flags: 00
AMD-Vi:   DEV_RANGE_END=09=09 devid: 41:1f.7
AMD-Vi:   DEV_SELECT=09=09=09 devid: 00:00.0 flags: 00
AMD-Vi:   DEV_SELECT=09=09=09 devid: 00:01.0 flags: 00
AMD-Vi:   DEV_SELECT=09=09=09 devid: 00:02.0 flags: 00
AMD-Vi:   DEV_SELECT_RANGE_START=09 devid: 01:00.0 flags: 00
AMD-Vi:   DEV_RANGE_END=09=09 devid: 01:1f.7
AMD-Vi:   DEV_SELECT=09=09=09 devid: 00:02.1 flags: 00
AMD-Vi:   DEV_SELECT_RANGE_START=09 devid: 02:00.0 flags: 00
AMD-Vi:   DEV_RANGE_END=09=09 devid: 02:1f.7
AMD-Vi:   DEV_SELECT=09=09=09 devid: 00:02.2 flags: 00
AMD-Vi:   DEV_SELECT_RANGE_START=09 devid: 03:00.0 flags: 00
AMD-Vi:   DEV_RANGE_END=09=09 devid: 03:1f.7
AMD-Vi:   DEV_SELECT=09=09=09 devid: 00:02.3 flags: 00
AMD-Vi:   DEV_SELECT_RANGE_START=09 devid: 04:00.0 flags: 00
AMD-Vi:   DEV_RANGE_END=09=09 devid: 04:1f.7
AMD-Vi:   DEV_SELECT=09=09=09 devid: 00:02.4 flags: 00
AMD-Vi:   DEV_SELECT_RANGE_START=09 devid: 05:00.0 flags: 00
AMD-Vi:   DEV_RANGE_END=09=09 devid: 05:1f.7
AMD-Vi:   DEV_SELECT=09=09=09 devid: 00:02.5 flags: 00
AMD-Vi:   DEV_SELECT=09=09=09 devid: 06:00.0 flags: 00
AMD-Vi:   DEV_SELECT=09=09=09 devid: 07:00.0 flags: 00
AMD-Vi:   DEV_SELECT_RANGE_START=09 devid: 08:00.0 flags: 00
AMD-Vi:   DEV_RANGE_END=09=09 devid: 08:1f.7
AMD-Vi:   DEV_SELECT=09=09=09 devid: 07:01.0 flags: 00
AMD-Vi:   DEV_SELECT_RANGE_START=09 devid: 09:00.0 flags: 00
AMD-Vi:   DEV_RANGE_END=09=09 devid: 09:1f.7
AMD-Vi:   DEV_SELECT=09=09=09 devid: 00:02.6 flags: 00
AMD-Vi:   DEV_SELECT=09=09=09 devid: 0a:00.0 flags: 00
AMD-Vi:   DEV_ALIAS_RANGE=09=09 devid: 0b:00.0 flags: 00 devid_to: 0b:00.0
AMD-Vi:   DEV_RANGE_END=09=09 devid: 0c:1f.7
AMD-Vi:   DEV_SELECT=09=09=09 devid: 00:02.7 flags: 00
AMD-Vi:   DEV_ALIAS_RANGE=09=09 devid: 0d:00.0 flags: 00 devid_to: 00:02.7
AMD-Vi:   DEV_RANGE_END=09=09 devid: 0d:1f.7
AMD-Vi:   DEV_SELECT=09=09=09 devid: 00:03.0 flags: 00
AMD-Vi:   DEV_SELECT=09=09=09 devid: 00:04.0 flags: 00
AMD-Vi:   DEV_SELECT=09=09=09 devid: 00:1f.0 flags: 00
AMD-Vi:   DEV_SELECT=09=09=09 devid: 00:1f.2 flags: 00
AMD-Vi:   DEV_SELECT=09=09=09 devid: 00:1f.3 flags: 00

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/i386/acpi-build.c |  127 ++++++++++++++++++++++++++++++++++++++++++++++=
+---
 1 file changed, 120 insertions(+), 7 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 1d077a7cb772..ab521ec53a6d 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2515,12 +2515,105 @@ build_dmar_q35(GArray *table_data, BIOSLinker *lin=
ker)
  */
 #define IOAPIC_SB_DEVID   (uint64_t)PCI_BUILD_BDF(0, PCI_DEVFN(0x14, 0))
=20
+/*
+ * Insert IVHD entry for device and recurse, insert alias, or insert range=
 as
+ * necessary for the PCI topology.
+ */
+static void
+insert_ivhd(PCIBus *bus, PCIDevice *dev, void *opaque)
+{
+    GArray *table_data =3D opaque;
+    uint32_t entry;
+
+    /* "Select" IVHD entry, type 0x2 */
+    entry =3D PCI_BUILD_BDF(pci_bus_num(bus), dev->devfn) << 8 | 0x2;
+    build_append_int_noprefix(table_data, entry, 4);
+
+    if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_BRIDGE)) {
+        PCIBus *sec_bus =3D pci_bridge_get_sec_bus(PCI_BRIDGE(dev));
+        uint8_t sec =3D pci_bus_num(sec_bus);
+        uint8_t sub =3D dev->config[PCI_SUBORDINATE_BUS];
+
+        if (pci_bus_is_express(sec_bus)) {
+            /*
+             * Walk the bus if there are subordinates, otherwise use a ran=
ge
+             * to cover an entire leaf bus.  We could potentially also use=
 a
+             * range for traversed buses, but we'd need to take care not t=
o
+             * create both Select and Range entries covering the same devi=
ce.
+             * This is easier and potentially more compact.
+             *
+             * An example bare metal system seems to use Select entries fo=
r
+             * root ports without a slot (ie. built-ins) and Range entries
+             * when there is a slot.  The same system also only hard-codes
+             * the alias range for an onboard PCIe-to-PCI bridge, apparent=
ly
+             * making no effort to support nested bridges.  We attempt to
+             * be more thorough here.
+             */
+            if (sec =3D=3D sub) { /* leaf bus */
+                /* "Start of Range" IVHD entry, type 0x3 */
+                entry =3D PCI_BUILD_BDF(sec, PCI_DEVFN(0, 0)) << 8 | 0x3;
+                build_append_int_noprefix(table_data, entry, 4);
+                /* "End of Range" IVHD entry, type 0x4 */
+                entry =3D PCI_BUILD_BDF(sub, PCI_DEVFN(31, 7)) << 8 | 0x4;
+                build_append_int_noprefix(table_data, entry, 4);
+            } else {
+                pci_for_each_device(sec_bus, sec, insert_ivhd, table_data)=
;
+            }
+        } else {
+            /*
+             * If the secondary bus is conventional, then we need to creat=
e an
+             * Alias range for everything downstream.  The range covers th=
e
+             * first devfn on the secondary bus to the last devfn on the
+             * subordinate bus.  The alias target depends on legacy versus
+             * express bridges, just as in pci_device_iommu_address_space(=
).
+             * DeviceIDa vs DeviceIDb as per the AMD IOMMU spec.
+             */
+            uint16_t dev_id_a, dev_id_b;
+
+            dev_id_a =3D PCI_BUILD_BDF(sec, PCI_DEVFN(0, 0));
+
+            if (pci_is_express(dev) &&
+                pcie_cap_get_type(dev) =3D=3D PCI_EXP_TYPE_PCI_BRIDGE) {
+                dev_id_b =3D dev_id_a;
+            } else {
+                dev_id_b =3D PCI_BUILD_BDF(pci_bus_num(bus), dev->devfn);
+            }
+
+            /* "Alias Start of Range" IVHD entry, type 0x43, 8 bytes */
+            build_append_int_noprefix(table_data, dev_id_a << 8 | 0x43, 4)=
;
+            build_append_int_noprefix(table_data, dev_id_b << 8 | 0x0, 4);
+
+            /* "End of Range" IVHD entry, type 0x4 */
+            entry =3D PCI_BUILD_BDF(sub, PCI_DEVFN(31, 7)) << 8 | 0x4;
+            build_append_int_noprefix(table_data, entry, 4);
+        }
+    }
+}
+
+/* For all PCI host bridges, walk and insert IVHD entries */
+static int
+ivrs_host_bridges(Object *obj, void *opaque)
+{
+    GArray *ivhd_blob =3D opaque;
+
+    if (object_dynamic_cast(obj, TYPE_PCI_HOST_BRIDGE)) {
+        PCIBus *bus =3D PCI_HOST_BRIDGE(obj)->bus;
+
+        if (bus) {
+            pci_for_each_device(bus, pci_bus_num(bus), insert_ivhd, ivhd_b=
lob);
+        }
+    }
+
+    return 0;
+}
+
 static void
 build_amd_iommu(GArray *table_data, BIOSLinker *linker)
 {
-    int ivhd_table_len =3D 28;
+    int ivhd_table_len =3D 24;
     int iommu_start =3D table_data->len;
     AMDVIState *s =3D AMD_IOMMU_DEVICE(x86_iommu_get_default());
+    GArray *ivhd_blob =3D g_array_new(false, true, 1);
=20
     /* IVRS header */
     acpi_data_push(table_data, sizeof(AcpiTableHeader));
@@ -2541,6 +2634,27 @@ build_amd_iommu(GArray *table_data, BIOSLinker *link=
er)
                              (1UL << 7),  /* PPRSup       */
                              1);
=20
+    /*
+     * A PCI bus walk, for each PCI host bridge, is necessary to create a
+     * complete set of IVHD entries.  Do this into a separate blob so that=
 we
+     * can calculate the total IVRS table length here and then append the =
new
+     * blob further below.  Fall back to an entry covering all devices, wh=
ich
+     * is sufficient when no aliases are present.
+     */
+    object_child_foreach_recursive(object_get_root(),
+                                   ivrs_host_bridges, ivhd_blob);
+
+    if (!ivhd_blob->len) {
+        /*
+         *   Type 1 device entry reporting all devices
+         *   These are 4-byte device entries currently reporting the range=
 of
+         *   Refer to Spec - Table 95:IVHD Device Entry Type Codes(4-byte)
+         */
+        build_append_int_noprefix(ivhd_blob, 0x0000001, 4);
+    }
+
+    ivhd_table_len +=3D ivhd_blob->len;
+
     /*
      * When interrupt remapping is supported, we add a special IVHD device
      * for type IO-APIC.
@@ -2548,6 +2662,7 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linke=
r)
     if (x86_iommu_ir_supported(x86_iommu_get_default())) {
         ivhd_table_len +=3D 8;
     }
+
     /* IVHD length */
     build_append_int_noprefix(table_data, ivhd_table_len, 2);
     /* DeviceID */
@@ -2567,12 +2682,10 @@ build_amd_iommu(GArray *table_data, BIOSLinker *lin=
ker)
                              (1UL << 2)   | /* GTSup  */
                              (1UL << 6),    /* GASup  */
                              4);
-    /*
-     *   Type 1 device entry reporting all devices
-     *   These are 4-byte device entries currently reporting the range of
-     *   Refer to Spec - Table 95:IVHD Device Entry Type Codes(4-byte)
-     */
-    build_append_int_noprefix(table_data, 0x0000001, 4);
+
+    /* IVHD entries as found above */
+    g_array_append_vals(table_data, ivhd_blob->data, ivhd_blob->len);
+    g_array_free(ivhd_blob, TRUE);
=20
     /*
      * Add a special IVHD device type.


