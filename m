Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0597DC35246
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 12:53:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF873206D7
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 12:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="pcB+W5CM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF873206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iriB4-0006Yv-Nz
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 07:53:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49713)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1irhuj-0002MU-7G
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 07:36:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1irhuh-00035b-71
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 07:36:49 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:53576)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1irhug-000343-U1; Wed, 15 Jan 2020 07:36:47 -0500
Received: from crumble.bar.greensocs.com (crumble.bar.greensocs.com
 [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPS id 6550496F54;
 Wed, 15 Jan 2020 12:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1579091805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gkyGk7NyoDpVOzRr9M+POqcI/hKXDSH+9wGTwV0JCFM=;
 b=pcB+W5CMxmBGgeyDl5dO7yynkOQgc29fjmpqLztBjXiqyzOIzfCdxfc5RX+ObbqIOFinTb
 6/qgZfPr5zojhP3A8KCpwoxHec7+2VUnuwAn+1eWILQLBqr1dmIUOoh6hk8rMM/sa7kg9k
 Pa94HhwPqSPjh9oAAbESd09dmq+WKJc=
From: Damien Hedde <damien.hedde@greensocs.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 06/11] hw/core/qdev: handle parent bus change regarding
 resettable
Date: Wed, 15 Jan 2020 13:36:15 +0100
Message-Id: <20200115123620.250132-7-damien.hedde@greensocs.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200115123620.250132-1-damien.hedde@greensocs.com>
References: <20200115123620.250132-1-damien.hedde@greensocs.com>
MIME-Version: 1.0
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1579091805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gkyGk7NyoDpVOzRr9M+POqcI/hKXDSH+9wGTwV0JCFM=;
 b=YjasE5nY/bdl9lagYPYVXAGNe4ZhKV0a6ht+mEInZDejAj+M4aMdu6IF/aIXRMHcCzRdnu
 YrIiDdcj/SUIwRFLNgGtsd4cFRd2COkEBLSq1nOE6I8ys9c1bG7pIhAHVT8Z5I5N2u7VWb
 5nIwz1I67K9rKXZINFEoq11ZfmyD+/g=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1579091805; a=rsa-sha256; cv=none;
 b=BWVWtEJJW/DbraSTr4LtIAItV0OqdRX/wy0nhuwSsiLCQi5fMdfchNkIiX5y+n06zaYbmT
 cH15HsEYTFMa4cUgeWECennkCFF4UNRgpjHNDADEtuJ5fvOVuU/JQ0R6lAWSuTTtLkW95/
 G0WOLi+Pnpaqt4u4oylTfk5NR69hRkc=
ARC-Authentication-Results: i=1;
	beetle.greensocs.com;
	none
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 5.135.226.135
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
Cc: Damien Hedde <damien.hedde@greensocs.com>, peter.maydell@linaro.org,
 berrange@redhat.com, ehabkost@redhat.com,
 Richard Henderson <richard.henderson@linaro.org>, cohuck@redhat.com,
 mark.burton@greensocs.com, qemu-s390x@nongnu.org, edgari@xilinx.com,
 pbonzini@redhat.com, philmd@redhat.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In qdev_set_parent_bus(), when changing the parent bus of a
realized device, if the source and destination buses are not in the
same reset state, some adaptations are required. This patch adds
needed call to resettable_change_parent() to make sure a device reset
state stays coherent with its parent bus.

The addition is a no-op if:
1. the device being parented is not realized.
2. the device is realized, but both buses are not under reset.

Case 2 means that as long as qdev_set_parent_bus() is called
during the machine realization procedure (which is before the
machine reset so nothing is in reset), it is a no op.

There are 52 call sites of qdev_set_parent_bus(). All but one fall
into the no-op case:
+ 29 trivial calls related to virtio (in hw/{s390x,display,virtio}/
  {vhost,virtio}-xxx.c) to set a vdev(or vgpu) composing device
  parent bus just before realizing the same vdev(vgpu).
+ hw/core/qdev.c: when creating a device in qdev_try_create()
+ hw/core/sysbus.c: when initializing a device in the sysbus
+ hw/i386/amd_iommu.c: before realizing AMDVIState/pci
+ hw/isa/piix4.c: before realizing PIIX4State/rtc
+ hw/misc/auxbus.c: when creating an AUXBus
+ hw/misc/auxbus.c: when creating an AUXBus child
+ hw/misc/macio/macio.c: when initializing a MACIOState child
+ hw/misc/macio/macio.c: before realizing NewWorldMacIOState/pmu
+ hw/misc/macio/macio.c: before realizing NewWorldMacIOState/cuda
+ hw/net/virtio-net.c: Used for migration when using the failover
                       mechanism to migration a vfio-pci/net. It is
                       a no-op because at this point the device is
                       already on the bus.
+ hw/pci-host/designware.c: before realizing DesignwarePCIEHost/root
+ hw/pci-host/gpex.c: before realizing GPEXHost/root
+ hw/pci-host/prep.c: when initializaing PREPPCIState/pci_dev
+ hw/pci-host/q35.c: before realizing Q35PCIHost/mch
+ hw/pci-host/versatile.c: when initializing PCIVPBState/pci_dev
+ hw/pci-host/xilinx-pcie.c: before realizing XilinxPCIEHost/root
+ hw/s390x/event-facility.c: when creating SCLPEventFacility/
                             TYPE_SCLP_QUIESCE
+ hw/s390x/event-facility.c: ditto with SCLPEventFacility/
                             TYPE_SCLP_CPU_HOTPLUG
+ hw/s390x/sclp.c: Not trivial because it is called on a SLCPDevice
  just after realizing it. Ok because at this point the destination
  bus (sysbus) is not in reset; the realize step is before the
  machine reset.
+ hw/sd/core.c: Not OK. Used in sdbus_reparent_card(). See below.
+ hw/ssi/ssi.c: Used to put spi slave on spi bus and connect the cs
  line in ssi_auto_connect_slave(). Ok because this function is only
  used in realize step in hw/ssi/aspeed_smc.ci, hw/ssi/imx_spi.c,
  hw/ssi/mss-spi.c, hw/ssi/xilinx_spi.c and hw/ssi/xilinx_spips.c.
+ hw/xen/xen-legacy-backend.c: when creating a XenLegacyDevice device
+ qdev-monitor.c: in device hotplug creation procedure before realize

Note that this commit alone will have no effect, right now there is no
use of resettable API to reset anything. So a bus will never be tagged
as in-reset by this same API.

The one place where side-effect will occurs is in hw/sd/core.c in
sdbus_reparent_card(). This function is only used in the raspi machines,
including during the sysbus reset procedure. This case will be
carrefully handled when doing the multiple phase reset transition.

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---

v6 update: there are now 3 more call sites (52 instead of 49).
+ hw/isa/piix4.c
+ hw/net/virtio-net.c
+ hw/virtio/vhost-user-fs-pci.c (in list below)

Exhaustive list of the 29 "virtio" caller to qdev_set_parent_bus():
+ hw/display/virtio-gpu-pci.c:     VirtIOGPUPCIBase/vgpu realize
+ hw/display/virtio-vga.c:         VirtIOVGABase/vgpu realize
+ hw/s390x/vhost-vsock-ccw.c:      VHostVSockCCWState/vdev realize
+ hw/s390x/virtio-ccw-9p.c:        V9fsCCWState/vdev realize
+ hw/s390x/virtio-ccw-balloon.c:   VirtIOBalloonCcw/vdev realize
+ hw/s390x/virtio-ccw-blk.c:       VirtIOBlkCcw/vdev realize
+ hw/s390x/virtio-ccw-crypto.c:    VirtIOCryptoCcw/vdev realize
+ hw/s390x/virtio-ccw-gpu.c:       VirtIOGPUCcw/vdev realize
+ hw/s390x/virtio-ccw-input.c:     VirtIOInputCcw/vdev realize
+ hw/s390x/virtio-ccw-net.c:       VirtIONetCcw/vdev realize
+ hw/s390x/virtio-ccw-rng.c:       VirtIORNGCcw/vdev realize
+ hw/s390x/virtio-ccw-scsi.c:      VirtIOSCSICcw/vdev realize
+ hw/s390x/virtio-ccw-scsi.c:      VHostSCSICcw/vdev realize
+ hw/s390x/virtio-ccw-serial.c:    VirtioSerialCcw/vdev realize
+ hw/virtio/vhost-scsi-pci.c:      VHostSCSIPCI/vdev realize
+ hw/virtio/vhost-user-blk-pci.c:  VHostUserBlkPCI/vdev realize
+ hw/virtio/vhost-user-fs-pci.c:   VHostUserFSPCI/vdev realize
+ hw/virtio/vhost-user-scsi-pci.c: VHostUserSCSIPCI/vdev realize
+ hw/virtio/vhost-vsock-pci.c:     VHostVSockPCI/vdev realize
+ hw/virtio/virtio-9p-pci.c:       V9fsPCIState/vdev realize
+ hw/virtio/virtio-balloon-pci.c:  VirtIOBalloonPCI/vdev realize
+ hw/virtio/virtio-blk-pci.c:      VirtIOBlkPCI/vdev realize
+ hw/virtio/virtio-crypto-pci.c:   VirtIOCryptoPCI/vdev realize
+ hw/virtio/virtio-input-pci.c:    VirtIOInputPCI/vdev realize
+ hw/virtio/virtio-net-pci.c:      VirtIONetPCI/vdev realize
+ hw/virtio/virtio-pmem-pci.c:     VirtIOPMEMPCI/vdev realize
+ hw/virtio/virtio-rng-pci.c:      VirtIORngPCI/vdev realize
+ hw/virtio/virtio-scsi-pci.c:     VirtIOSCSIPCI/vdev realize
+ hw/virtio/virtio-serial-pci.c:   VirtIOSerialPCI/vdev realize
---
 hw/core/qdev.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index d431a020fc..310b87e25a 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -96,25 +96,31 @@ static void bus_add_child(BusState *bus, DeviceState =
*child)
=20
 void qdev_set_parent_bus(DeviceState *dev, BusState *bus)
 {
-    bool replugging =3D dev->parent_bus !=3D NULL;
+    BusState *old_parent_bus =3D dev->parent_bus;
=20
-    if (replugging) {
+    if (old_parent_bus) {
         trace_qdev_update_parent_bus(dev, object_get_typename(OBJECT(dev=
)),
-            dev->parent_bus, object_get_typename(OBJECT(dev->parent_bus)=
),
+            old_parent_bus, object_get_typename(OBJECT(old_parent_bus)),
             OBJECT(bus), object_get_typename(OBJECT(bus)));
         /*
          * Keep a reference to the device while it's not plugged into
          * any bus, to avoid it potentially evaporating when it is
          * dereffed in bus_remove_child().
+         * Also keep the ref of the parent bus until the end, so that
+         * we can safely call resettable_change_parent() below.
          */
         object_ref(OBJECT(dev));
         bus_remove_child(dev->parent_bus, dev);
-        object_unref(OBJECT(dev->parent_bus));
     }
     dev->parent_bus =3D bus;
     object_ref(OBJECT(bus));
     bus_add_child(bus, dev);
-    if (replugging) {
+    if (dev->realized) {
+        resettable_change_parent(OBJECT(dev), OBJECT(bus),
+                                 OBJECT(old_parent_bus));
+    }
+    if (old_parent_bus) {
+        object_unref(OBJECT(old_parent_bus));
         object_unref(OBJECT(dev));
     }
 }
--=20
2.24.1


