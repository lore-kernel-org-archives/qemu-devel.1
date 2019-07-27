Return-Path: <SRS0=iAYr=VY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F47C7618F
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jul 2019 00:56:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5052229F9
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jul 2019 00:56:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5052229F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hrB0i-0000Da-Tb
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 20:56:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44595)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.williamson@redhat.com>) id 1hrB0U-00084Y-PU
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 20:56:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1hrB0F-0008On-At
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 20:56:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49522)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1hrB0D-0008Bq-55
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 20:56:01 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 548B83DE0F;
 Sat, 27 Jul 2019 00:55:48 +0000 (UTC)
Received: from gimli.home (ovpn-116-99.phx2.redhat.com [10.3.116.99])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B920F5D9C6;
 Sat, 27 Jul 2019 00:55:40 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 26 Jul 2019 18:55:40 -0600
Message-ID: <156418894044.10856.8768465172285114615.stgit@gimli.home>
In-Reply-To: <156418830210.10856.17740359763468342629.stgit@gimli.home>
References: <156418830210.10856.17740359763468342629.stgit@gimli.home>
User-Agent: StGit/0.19-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Sat, 27 Jul 2019 00:55:48 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [for-4.2 PATCH 1/2] pci: Use PCI aliases when
 determining device IOMMU address space
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
Cc: brijesh.singh@amd.com, mst@redhat.com, zhexu@redhat.com,
 eric.auger@redhat.com, Suravee.Suthikulpanit@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PCIe requester IDs are used by modern IOMMUs to differentiate devices
in order to provide a unique IOVA address space per device.  These
requester IDs are composed of the bus/device/function (BDF) of the
requesting device.  Conventional PCI pre-dates this concept and is
simply a shared parallel bus where transactions are claimed by
decoding target ranges rather than the packetized, point-to-point
mechanisms of PCI-express.  In order to interface conventional PCI
to PCIe, the PCIe-to-PCI bridge creates and accepts packetized
transactions on behalf of all downstream devices, using one of two
potential forms of a requester ID relating to the bridge itself or its
subordinate bus.  All downstream devices are therefore aliased by the
bridge's requester ID and it's not possible for the IOMMU to create
unique IOVA spaces for devices downstream of such buses.

At least that's how it works on bare metal.  Until now point we've
ignored this nuance of vIOMMU support in QEMU, creating a unique
AddressSpace per device regardless of the virtual bus topology.

Aside from simply being true to bare metal behavior, there are aspects
of a shared address space that we can use to our advantage when
designing a VM.  For instance, a PCI device assignment scenario where
we have the following IOMMU group on the host system:

  $ ls  /sys/kernel/iommu_groups/1/devices/
  0000:00:01.0  0000:01:00.0  0000:01:00.1

An IOMMU group is considered the smallest set of devices which are
fully DMA isolated from other devices by the IOMMU.  In this case the
root port at 00:01.0 does not guarantee that it prevents peer to peer
traffic between the endpoints on bus 01: and the devices are therefore
grouped together.  VFIO considers an IOMMU group to be the smallest
unit of device ownership and allows only a single shared IOVA space
per group due to the limitations of the isolation.

Therefore, if we attempt to create the following VM, we get an error:

qemu-system-x86_64 -machine q35... \
  -device intel-iommu,intremap=on \
  -device pcie-root-port,addr=1e.0,id=pcie.1 \
  -device vfio-pci,host=1:00.0,bus=pcie.1,addr=0.0,multifunction=on \
  -device vfio-pci,host=1:00.1,bus=pcie.1,addr=0.1

qemu-system-x86_64: -device vfio-pci,host=1:00.1,bus=pcie.1,addr=0.1: vfio \
0000:01:00.1: group 1 used in multiple address spaces

VFIO only allows a single IOVA space (AddressSpace) for both devices,
but we've placed them into a topology where the vIOMMU expects a
separate AddressSpace for each device.  On bare metal we know that
a conventional PCI bus would provide the sort of aliasing we need
here, forcing the IOMMU to consider these devices to be part of a
single shared IOVA space.  The support provided here does the same
for QEMU, such that we can create a conventional PCI topology to
expose equivalent AddressSpace sharing requirements to the VM:

qemu-system-x86_64 -machine q35... \
  -device intel-iommu,intremap=on \
  -device pcie-pci-bridge,addr=1e.0,id=pci.1 \
  -device vfio-pci,host=1:00.0,bus=pci.1,addr=1.0,multifunction=on \
  -device vfio-pci,host=1:00.1,bus=pci.1,addr=1.1

There are pros and cons to this configuration; it's not necessarily
recommended, it's simply a tool we can use to create configurations
which may provide additional functionality in spite of host hardware
limitations or as a benefit to the guest configuration or resource
usage.  An incomplete list of pros and cons:

Cons:
 a) Extended PCI configuration space is unavailable to devices
    downstream of a conventional PCI bus.  The degree to which this
    is a drawback depends on the device and guest drivers.
 b) Applying this topology to devices which are already isolated by
    the host IOMMU (singleton IOMMU groups) will result in devices
    which appear to be non-isolated to the VM (non-singleton groups).
    This can limit configurations within the guest, such as userspace
    drivers or nested device assignment.

Pros:
 a) QEMU better emulates bare metal.
 b) Configurations as above are now possible.
 c) Host IOMMU resources and VM locked memory requirements are reduced
    in vIOMMU configurations due to shared IOMMU domains on the host
    and avoidance of duplicate locked memory accounting.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/pci/pci.c |   43 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 40 insertions(+), 3 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 8076a80ab3a9..b550741e88a3 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2610,12 +2610,49 @@ AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
 {
     PCIBus *bus = pci_get_bus(dev);
     PCIBus *iommu_bus = bus;
+    uint8_t devfn = dev->devfn;
 
-    while(iommu_bus && !iommu_bus->iommu_fn && iommu_bus->parent_dev) {
-        iommu_bus = pci_get_bus(iommu_bus->parent_dev);
+    while (iommu_bus && !iommu_bus->iommu_fn && iommu_bus->parent_dev) {
+        PCIBus *parent_bus = pci_get_bus(iommu_bus->parent_dev);
+
+        /*
+         * The requester ID of the provided device may be aliased, as seen from
+         * the IOMMU, due to topology limitations.  The IOMMU relies on a
+         * requester ID to provide a unique AddressSpace for devices, but
+         * conventional PCI buses pre-date such concepts.  Instead, the PCIe-
+         * to-PCI bridge creates and accepts transactions on behalf of down-
+         * stream devices.  When doing so, all downstream devices are masked
+         * (aliased) behind a single requester ID.  The requester ID used
+         * depends on the format of the bridge devices.  Proper PCIe-to-PCI
+         * bridges, with a PCIe capability indicating such, follow the
+         * guidelines of chapter 2.3 of the PCIe-to-PCI/X bridge specification,
+         * where the bridge uses the seconary bus as the bridge portion of the
+         * requester ID and devfn of 00.0.  For other bridges, typically those
+         * found on the root complex such as the dmi-to-pci-bridge, we follow
+         * the convention of typical bare-metal hardware, which uses the
+         * requester ID of the bridge itself.  There are device specific
+         * exceptions to these rules, but these are the defaults that the
+         * Linux kernel uses when determining DMA aliases itself and believed
+         * to be true for the bare metal equivalents of the devices emulated
+         * in QEMU.
+         */
+        if (!pci_bus_is_express(iommu_bus)) {
+            PCIDevice *parent = iommu_bus->parent_dev;
+
+            if (pci_is_express(parent) &&
+                pcie_cap_get_type(parent) == PCI_EXP_TYPE_PCI_BRIDGE) {
+                devfn = PCI_DEVFN(0, 0);
+                bus = iommu_bus;
+            } else {
+                devfn = parent->devfn;
+                bus = parent_bus;
+            }
+        }
+
+        iommu_bus = parent_bus;
     }
     if (iommu_bus && iommu_bus->iommu_fn) {
-        return iommu_bus->iommu_fn(bus, iommu_bus->iommu_opaque, dev->devfn);
+        return iommu_bus->iommu_fn(bus, iommu_bus->iommu_opaque, devfn);
     }
     return &address_space_memory;
 }


