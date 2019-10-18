Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB0C5CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 15:18:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4C38222BD
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 15:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="qWEoTFz3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4C38222BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLU17-0005na-Ac
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 11:18:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39149)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1iLTrE-0006lf-9J
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 11:08:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1iLTrB-0000Ie-L5
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 11:07:59 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:38696)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1iLTr7-0000Dd-Ru; Fri, 18 Oct 2019 11:07:54 -0400
Received: from crumble.bar.greensocs.com (crumble.bar.greensocs.com
 [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPS id 43F9296F54;
 Fri, 18 Oct 2019 15:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1571411272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6vGveMHLjzG3M9XbNsp7F2Gj1HQXW7Dw2jM2Twu2XEE=;
 b=qWEoTFz351lHwa00qgecQpLR87ZlhCBgZk5PdaDs/JxkrLy4WmdzJKZN6mUTQVMlocHFxj
 2Igm3HuZBpINENBo/+r133kH1Ham6v6yhMEe+whhc06prgxy+wRFyPi/NK7IHk89BIobuG
 LVmU1Dlrj0eMv6NCL756tn1LEQ+pU2s=
From: Damien Hedde <damien.hedde@greensocs.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 06/13] hw/core/qdev: handle parent bus change regarding
 resettable
Date: Fri, 18 Oct 2019 17:06:23 +0200
Message-Id: <20191018150630.31099-7-damien.hedde@greensocs.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191018150630.31099-1-damien.hedde@greensocs.com>
References: <20191018150630.31099-1-damien.hedde@greensocs.com>
MIME-Version: 1.0
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1571411272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6vGveMHLjzG3M9XbNsp7F2Gj1HQXW7Dw2jM2Twu2XEE=;
 b=rtuhlzY5vEWPsHgKqSb8gxkp/4KKzilEu/e4CYnyO81zlGPI/mF6GQpMlzcZ4adY9ESB79
 UvayK0Ni7pbny9NE7mZpDos3vEi0OFGQI5sKsfqYwMv/iKioqFJWovPErK41OEhQlGNU7Q
 TFHr8qujVWV8H5CZVZYW7krBmEfX4pA=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1571411272; a=rsa-sha256; cv=none;
 b=loeaI8nBfTzxSv+OVhDob4D6JCsA5YoPoobpLb/JrdBlvbXiMbhiHDnqYVnUSbM7nXPBNA
 AricptmnI1k+3dkObdCuuotzTz9gwNh9jALzf9qs5EpCWFFgEEiFFoYeqaOdHz0XADuJ0y
 okoHknY8MyHZFwjlSwmf36LRyA2kw+c=
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
 berrange@redhat.com, ehabkost@redhat.com, cohuck@redhat.com,
 mark.burton@greensocs.com, qemu-s390x@nongnu.org, edgari@xilinx.com,
 qemu-arm@nongnu.org, pbonzini@redhat.com, philmd@redhat.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In qdev_set_parent_bus(), when changing the parent bus of a
realized device, if the source and destination buses are not in the
same reset state, some adaptation are required. This patch adds
needed call to resettable_change_parent() to make sure a device reset
state stays coherent with its parent bus.

The addition is a no-op if:
1. the device being parented is not realized.
2. the device is realized, but both buses are not under reset.

Case 2 means that as long as qdev_set_parent_bus() is called
during the machine realization procedure (which is before the
machine reset so nothing is in reset), it is a no op.

There are 49 call sites of qdev_set_parent_bus(). All but one fall
into the no-op case:
+ 28 calls related to virtio (in hw/{s390x,display,virtio}/
  {vhost,virtio}-xxx.c) to set a _vdev_/_vgpu_ composing device
  parent bus just before realizing the _vdev_/_vgpu_.
+ hw/qdev.c: when creating a device in qdev_try_create()
+ hw/sysbus.c: when initializing a device in the sysbus
+ hw/display/virtio-gpu-pci.c: before realizing VirtIOGPUPCIBase/vgpu
+ hw/display/virtio-vga.c: before realizing VirtIOVGABase/vgpu
+ hw/i386/amd_iommu.c: before realizing AMDVIState/pci
+ hw/misc/auxbus.c: when creating an AUXBus
+ hw/misc/auxbus.c: when creating an AUXBus child
+ hw/misc/macio/macio.c: when initializing a MACIOState child
+ hw/misc/macio/macio.c: before realizing NewWorldMacIOState/pmu
+ hw/misc/macio/macio.c: before realizing NewWorldMacIOState/cuda
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
including during the sysbus reset procedure. This case will be fixed by
a following commit before globally enabling resettable API for sysbus
reset.

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
---

Exhaustive list of the 28 virtio caller to qdev_set_parent_bus():
+ hw/display/virtio-gpu-pci.c     -> VirtIOGPUPCIBase/vgpu realize
+ hw/display_virtio-vga.c         -> VirtIOVGABase/vgpu realize
+ hw/s390x/vhost-vsock-ccw.c      -> VHostVSockCCWState/vdev realize
+ hw/s390x/virtio-ccw-9p.c        -> V9fsCCWState/vdev realize
+ hw/s390x/virtio-ccw-balloon.c   -> VirtIOBalloonCcw/vdev realize
+ hw/s390x/virtio-ccw-blk.c       -> VirtIOBlkCcw/vdev realize
+ hw/s390x/virtio-ccw-crypto.c    -> VirtIOCryptoCcw/vdev realize
+ hw/s390x/virtio-ccw-gpu.c       -> VirtIOGPUCcw/vdev realize
+ hw/s390x/virtio-ccw-input.c     -> VirtIOInputCcw/vdev realize
+ hw/s390x/virtio-ccw-net.c       -> VirtIONetCcw/vdev realize
+ hw/s390x/virtio-ccw-rng.c       -> VirtIORNGCcw/vdev realize
+ hw/s390x/virtio-ccw-scsi.c      -> VirtIOSCSICcw/vdev realize
+ hw/s390x/virtio-ccw-scsi.c      -> VHostSCSICcw/vdev realize
+ hw/s390x/virtio-ccw-serial.c    -> VirtioSerialCcw/vdev realize
+ hw/virtio/vhost-scsi-pci.c      -> VHostSCSIPCI/vdev realize
+ hw/virtio/vhost-user-blk-pci.c  -> VHostUserBlkPCI/vdev realize
+ hw/virtio/vhost-user-scsi-pci.c -> VHostUserSCSIPCI/vdev realize
+ hw/virtio/vhost-vsock-pci.c     -> VHostVSockPCI/vdev realize
+ hw/virtio/virtio-9p-pci.c       -> V9fsPCIState/vdev realize
+ hw/virtio/virtio-balloon-pci.c  -> VirtIOBalloonPCI/vdev realize
+ hw/virtio/virtio-blk-pci.c      -> VirtIOBlkPCI/vdev realize
+ hw/virtio/virtio-crypto-pci.c   -> VirtIOCryptoPCI/vdev realize
+ hw/virtio/virtio-input-pci.c    -> VirtIOInputPCI/vdev realize
+ hw/virtio/virtio-net-pci.c      -> VirtIONetPCI/vdev realize
+ hw/virtio/virtio-pmem-pci.c     -> VirtIOPMEMPCI/vdev realize
+ hw/virtio/virtio-rng-pci.c      -> VirtIORngPCI/vdev realize
+ hw/virtio/virtio-scsi-pci.c     -> VirtIOSCSIPCI/vdev realize
+ hw/virtio/virtio-serial-pci.c   -> VirtIOSerialPCI/vdev realize
---
 hw/core/qdev.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 81784c73fb..3933f62d0c 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -96,23 +96,29 @@ static void bus_add_child(BusState *bus, DeviceState =
*child)
=20
 void qdev_set_parent_bus(DeviceState *dev, BusState *bus)
 {
-    bool replugging =3D dev->parent_bus !=3D NULL;
+    BusState *old_parent_bus =3D dev->parent_bus;
=20
-    if (replugging) {
+    if (old_parent_bus) {
         trace_qdev_update_parent_bus(dev, dev->parent_bus, bus);
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
2.23.0


