Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA30CA9EB9
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 22:49:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57CA620663
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 22:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dUvio57+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57CA620663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNPRj-0004ns-4t
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 18:49:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58528)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1iNPPe-0002ON-0r
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 18:47:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1iNPPc-0007We-Fd
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 18:47:29 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59354
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1iNPPc-0007Va-Bs
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 18:47:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571870847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pYg1SwOq4QlcSgQKnovf7R8KFz3UQCo+XBlibAGO21U=;
 b=dUvio57+0FrExHM0YwVleleJAga0Yabc4seLtXMf6/fjoBDQlky5X79uAVHypeEwdQ2FcV
 y15YBmNMUbebZ7RCVPxa8rn+l2iVBdfO/GFZdH2DCqyAg+hc5wF/9ia9yaUKjtdnbG2sVc
 AZ0FbmkCT7mMX9a7KLc+BK7r1sa5dUo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-92-ehebglMTOGaoOdoUIerq6w-1; Wed, 23 Oct 2019 18:47:24 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B308C1005500
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 22:47:23 +0000 (UTC)
Received: from gimli.home (ovpn-118-102.phx2.redhat.com [10.3.118.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 595CB5DA8D;
 Wed, 23 Oct 2019 22:47:15 +0000 (UTC)
Subject: [RESEND PATCH 1/2] pci: Use PCI aliases when determining device
 IOMMU address space
From: Alex Williamson <alex.williamson@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 23 Oct 2019 16:47:15 -0600
Message-ID: <157187083548.5439.14747141504058604843.stgit@gimli.home>
In-Reply-To: <157187055395.5439.6693401317571144578.stgit@gimli.home>
References: <157187055395.5439.6693401317571144578.stgit@gimli.home>
User-Agent: StGit/0.19-dirty
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: ehebglMTOGaoOdoUIerq6w-1
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
  -device intel-iommu,intremap=3Don \
  -device pcie-root-port,addr=3D1e.0,id=3Dpcie.1 \
  -device vfio-pci,host=3D1:00.0,bus=3Dpcie.1,addr=3D0.0,multifunction=3Don=
 \
  -device vfio-pci,host=3D1:00.1,bus=3Dpcie.1,addr=3D0.1

qemu-system-x86_64: -device vfio-pci,host=3D1:00.1,bus=3Dpcie.1,addr=3D0.1:=
 vfio \
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
  -device intel-iommu,intremap=3Don \
  -device pcie-pci-bridge,addr=3D1e.0,id=3Dpci.1 \
  -device vfio-pci,host=3D1:00.0,bus=3Dpci.1,addr=3D1.0,multifunction=3Don =
\
  -device vfio-pci,host=3D1:00.1,bus=3Dpci.1,addr=3D1.1

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

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/pci/pci.c |   43 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 40 insertions(+), 3 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index aa05c2b9b24e..0ac0e097bfbb 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2614,12 +2614,49 @@ AddressSpace *pci_device_iommu_address_space(PCIDev=
ice *dev)
 {
     PCIBus *bus =3D pci_get_bus(dev);
     PCIBus *iommu_bus =3D bus;
+    uint8_t devfn =3D dev->devfn;
=20
-    while(iommu_bus && !iommu_bus->iommu_fn && iommu_bus->parent_dev) {
-        iommu_bus =3D pci_get_bus(iommu_bus->parent_dev);
+    while (iommu_bus && !iommu_bus->iommu_fn && iommu_bus->parent_dev) {
+        PCIBus *parent_bus =3D pci_get_bus(iommu_bus->parent_dev);
+
+        /*
+         * The requester ID of the provided device may be aliased, as seen=
 from
+         * the IOMMU, due to topology limitations.  The IOMMU relies on a
+         * requester ID to provide a unique AddressSpace for devices, but
+         * conventional PCI buses pre-date such concepts.  Instead, the PC=
Ie-
+         * to-PCI bridge creates and accepts transactions on behalf of dow=
n-
+         * stream devices.  When doing so, all downstream devices are mask=
ed
+         * (aliased) behind a single requester ID.  The requester ID used
+         * depends on the format of the bridge devices.  Proper PCIe-to-PC=
I
+         * bridges, with a PCIe capability indicating such, follow the
+         * guidelines of chapter 2.3 of the PCIe-to-PCI/X bridge specifica=
tion,
+         * where the bridge uses the seconary bus as the bridge portion of=
 the
+         * requester ID and devfn of 00.0.  For other bridges, typically t=
hose
+         * found on the root complex such as the dmi-to-pci-bridge, we fol=
low
+         * the convention of typical bare-metal hardware, which uses the
+         * requester ID of the bridge itself.  There are device specific
+         * exceptions to these rules, but these are the defaults that the
+         * Linux kernel uses when determining DMA aliases itself and belie=
ved
+         * to be true for the bare metal equivalents of the devices emulat=
ed
+         * in QEMU.
+         */
+        if (!pci_bus_is_express(iommu_bus)) {
+            PCIDevice *parent =3D iommu_bus->parent_dev;
+
+            if (pci_is_express(parent) &&
+                pcie_cap_get_type(parent) =3D=3D PCI_EXP_TYPE_PCI_BRIDGE) =
{
+                devfn =3D PCI_DEVFN(0, 0);
+                bus =3D iommu_bus;
+            } else {
+                devfn =3D parent->devfn;
+                bus =3D parent_bus;
+            }
+        }
+
+        iommu_bus =3D parent_bus;
     }
     if (iommu_bus && iommu_bus->iommu_fn) {
-        return iommu_bus->iommu_fn(bus, iommu_bus->iommu_opaque, dev->devf=
n);
+        return iommu_bus->iommu_fn(bus, iommu_bus->iommu_opaque, devfn);
     }
     return &address_space_memory;
 }


