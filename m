Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5118AC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 06:19:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC652206F4
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 06:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I7XiWhlp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC652206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZTga-0008UP-6G
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 02:19:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55952)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jZTSZ-0003E3-7M
 for qemu-devel@nongnu.org; Fri, 15 May 2020 02:04:39 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31868
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jZTST-0004Rg-7H
 for qemu-devel@nongnu.org; Fri, 15 May 2020 02:04:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589522672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eCEZ/6oJEhvPBqTOieM83Ucvj4MZ9QS4v9ox13PPec4=;
 b=I7XiWhlprLTddCARTayvZy1Wnl14m3E21MufgfTyLxUSyrdBsqL89eiQNe/D7VasMYuYWg
 nZ33OJKb0KGaZa4XovoB4GXjvLp4alu7kM1qMKydU7PmHUZiFXcZ5vQksGQreOnjVGGbkb
 ntqbg1ZRDJqtFj+/O9I0BctDXvQ+Tuo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-xBXBpOc4Mw2b4KJwufgF0g-1; Fri, 15 May 2020 02:04:30 -0400
X-MC-Unique: xBXBpOc4Mw2b4KJwufgF0g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B0F2BFD2
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 06:04:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B51F378B24;
 Fri, 15 May 2020 06:04:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 63DF611358CD; Fri, 15 May 2020 08:04:24 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 16/21] qdev: Unrealize must not fail
Date: Fri, 15 May 2020 08:04:19 +0200
Message-Id: <20200515060424.18993-17-armbru@redhat.com>
In-Reply-To: <20200515060424.18993-1-armbru@redhat.com>
References: <20200515060424.18993-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 00:39:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: pbonzini@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Devices may have component devices and buses.

Device realization may fail.  Realization is recursive: a device's
realize() method realizes its components, and device_set_realized()
realizes its buses (which should in turn realize the devices on that
bus, except bus_set_realized() doesn't implement that, yet).

When realization of a component or bus fails, we need to roll back:
unrealize everything we realized so far.  If any of these unrealizes
failed, the device would be left in an inconsistent state.  Must not
happen.

device_set_realized() lets it happen: it ignores errors in the roll
back code starting at label child_realize_fail.

Since realization is recursive, unrealization must be recursive, too.
But how could a partly failed unrealize be rolled back?  We'd have to
re-realize, which can fail.  This design is fundamentally broken.

device_set_realized() does not roll back at all.  Instead, it keeps
unrealizing, ignoring further errors.

It can screw up even for a device with no buses: if the lone
dc->unrealize() fails, it still unregisters vmstate, and calls
listeners' unrealize() callback.

bus_set_realized() does not roll back either.  Instead, it stops
unrealizing.

Fortunately, no unrealize method can fail, as we'll see below.

To fix the design error, drop parameter @errp from all the unrealize
methods.

Any unrealize method that uses @errp now needs an update.  This leads
us to unrealize() methods that can fail.  Merely passing it to another
unrealize method cannot cause failure, though.  Here are the ones that
do other things with @errp:

* virtio_serial_device_unrealize()

  Fails when qbus_set_hotplug_handler() fails, but still does all the
  other work.  On failure, the device would stay realized with its
  resources completely gone.  Oops.  Can't happen, because
  qbus_set_hotplug_handler() can't actually fail here.  Pass
  &error_abort to qbus_set_hotplug_handler() instead.

* hw/ppc/spapr_drc.c's unrealize()

  Fails when object_property_del() fails, but all the other work is
  already done.  On failure, the device would stay realized with its
  vmstate registration gone.  Oops.  Can't happen, because
  object_property_del() can't actually fail here.  Pass &error_abort
  to object_property_del() instead.

* spapr_phb_unrealize()

  Fails and bails out when remove_drcs() fails, but other work is
  already done.  On failure, the device would stay realized with some
  of its resources gone.  Oops.  remove_drcs() fails only when
  chassis_from_bus()'s object_property_get_uint() fails, and it can't
  here.  Pass &error_abort to remove_drcs() instead.

Therefore, no unrealize method can fail before this patch.

device_set_realized()'s recursive unrealization via bus uses
object_property_set_bool().  Can't drop @errp there, so pass
&error_abort.

We similarly unrealize with object_property_set_bool() elsewhere,
always ignoring errors.  Pass &error_abort instead.

Several unrealize methods no longer handle errors from other unrealize
methods: virtio_9p_device_unrealize(),
virtio_input_device_unrealize(), scsi_qdev_unrealize(), ...
Much of the deleted error handling looks wrong anyway.

One unrealize methods no longer ignore such errors:
usb_ehci_pci_exit().

Several realize methods no longer ignore errors when rolling back:
v9fs_device_realize_common(), pci_qdev_unrealize(),
spapr_phb_realize(), usb_qdev_realize(), vfio_ccw_realize(),
virtio_device_realize().

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20200505152926.18877-17-armbru@redhat.com>
---
 hw/9pfs/9p.h                    |  2 +-
 hw/s390x/virtio-ccw.h           |  2 +-
 hw/sd/sdhci-internal.h          |  2 +-
 hw/usb/ccid.h                   |  2 +-
 hw/usb/hcd-ehci.h               |  2 +-
 include/hw/qdev-core.h          |  4 ++--
 include/hw/s390x/s390-ccw.h     |  2 +-
 include/hw/scsi/scsi.h          |  2 +-
 include/hw/usb.h                |  2 +-
 include/hw/xen/xen-block.h      |  2 +-
 include/hw/xen/xen-bus.h        |  2 +-
 hw/9pfs/9p.c                    |  4 ++--
 hw/9pfs/virtio-9p-device.c      |  4 ++--
 hw/acpi/pcihp.c                 |  2 +-
 hw/audio/intel-hda.c            |  2 +-
 hw/block/pflash_cfi02.c         |  2 +-
 hw/block/vhost-user-blk.c       |  2 +-
 hw/block/virtio-blk.c           |  2 +-
 hw/block/xen-block.c            |  8 ++++----
 hw/char/serial-pci-multi.c      |  2 +-
 hw/char/serial-pci.c            |  2 +-
 hw/char/serial.c                |  2 +-
 hw/char/virtio-console.c        |  2 +-
 hw/char/virtio-serial-bus.c     |  8 ++++----
 hw/core/bus.c                   | 17 ++++-------------
 hw/core/cpu.c                   |  2 +-
 hw/core/generic-loader.c        |  2 +-
 hw/core/qdev.c                  | 17 ++++++-----------
 hw/display/virtio-gpu-base.c    |  2 +-
 hw/dma/rc4030.c                 |  2 +-
 hw/i386/kvm/apic.c              |  2 +-
 hw/i386/pc.c                    |  4 ++--
 hw/ide/qdev.c                   |  4 ++--
 hw/input/virtio-input-hid.c     |  2 +-
 hw/input/virtio-input-host.c    |  2 +-
 hw/input/virtio-input.c         |  9 ++-------
 hw/intc/apic.c                  |  2 +-
 hw/intc/apic_common.c           |  4 ++--
 hw/intc/ioapic.c                |  2 +-
 hw/intc/xics.c                  |  2 +-
 hw/ipack/ipack.c                |  6 ++----
 hw/mem/pc-dimm.c                |  2 +-
 hw/net/virtio-net.c             |  2 +-
 hw/nvram/mac_nvram.c            |  2 +-
 hw/pci/pci.c                    | 14 +++++++-------
 hw/pci/pcie.c                   |  2 +-
 hw/pci/shpc.c                   |  2 +-
 hw/ppc/pnv_core.c               |  2 +-
 hw/ppc/spapr.c                  |  8 ++++----
 hw/ppc/spapr_cpu_core.c         |  2 +-
 hw/ppc/spapr_drc.c              | 14 ++++----------
 hw/ppc/spapr_iommu.c            |  2 +-
 hw/ppc/spapr_pci.c              | 14 +++++---------
 hw/ppc/spapr_tpm_proxy.c        |  2 +-
 hw/s390x/css-bridge.c           |  2 +-
 hw/s390x/s390-ccw.c             |  2 +-
 hw/s390x/s390-pci-bus.c         |  4 ++--
 hw/s390x/virtio-ccw.c           |  8 ++++----
 hw/scsi/lsi53c895a.c            |  2 +-
 hw/scsi/scsi-bus.c              | 13 ++++---------
 hw/scsi/scsi-disk.c             |  2 +-
 hw/scsi/vhost-scsi.c            |  2 +-
 hw/scsi/vhost-user-scsi.c       |  2 +-
 hw/scsi/virtio-scsi.c           |  2 +-
 hw/sd/sdhci-pci.c               |  2 +-
 hw/sd/sdhci.c                   |  6 +++---
 hw/usb/bus.c                    | 12 ++++++------
 hw/usb/ccid-card-emulated.c     |  2 +-
 hw/usb/dev-audio.c              |  2 +-
 hw/usb/dev-hid.c                |  2 +-
 hw/usb/dev-hub.c                |  2 +-
 hw/usb/dev-network.c            |  2 +-
 hw/usb/dev-smartcard-reader.c   | 11 +++--------
 hw/usb/dev-uas.c                |  2 +-
 hw/usb/dev-wacom.c              |  2 +-
 hw/usb/hcd-ehci-pci.c           |  2 +-
 hw/usb/hcd-ehci.c               |  2 +-
 hw/usb/host-libusb.c            |  2 +-
 hw/usb/redirect.c               |  2 +-
 hw/vfio/ap.c                    |  2 +-
 hw/vfio/ccw.c                   |  6 +++---
 hw/virtio/vhost-user-fs.c       |  2 +-
 hw/virtio/vhost-vsock.c         |  2 +-
 hw/virtio/virtio-balloon.c      |  2 +-
 hw/virtio/virtio-crypto.c       |  2 +-
 hw/virtio/virtio-iommu.c        |  2 +-
 hw/virtio/virtio-pmem.c         |  2 +-
 hw/virtio/virtio-rng.c          |  2 +-
 hw/virtio/virtio.c              | 11 +++--------
 hw/watchdog/wdt_diag288.c       |  2 +-
 hw/xen/xen-bus.c                | 12 ++++++------
 target/i386/cpu.c               |  9 ++-------
 target/ppc/translate_init.inc.c |  9 ++-------
 93 files changed, 158 insertions(+), 214 deletions(-)

diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
index b8f72a3bd9..dd1c6cb8d2 100644
--- a/hw/9pfs/9p.h
+++ b/hw/9pfs/9p.h
@@ -423,7 +423,7 @@ int v9fs_name_to_path(V9fsState *s, V9fsPath *dirpath,
                       const char *name, V9fsPath *path);
 int v9fs_device_realize_common(V9fsState *s, const V9fsTransport *t,
                                Error **errp);
-void v9fs_device_unrealize_common(V9fsState *s, Error **errp);
+void v9fs_device_unrealize_common(V9fsState *s);
 
 V9fsPDU *pdu_alloc(V9fsState *s);
 void pdu_free(V9fsPDU *pdu);
diff --git a/hw/s390x/virtio-ccw.h b/hw/s390x/virtio-ccw.h
index 3453aa1f98..c0e3355248 100644
--- a/hw/s390x/virtio-ccw.h
+++ b/hw/s390x/virtio-ccw.h
@@ -76,7 +76,7 @@ typedef struct VirtioCcwDevice VirtioCcwDevice;
 typedef struct VirtIOCCWDeviceClass {
     CCWDeviceClass parent_class;
     void (*realize)(VirtioCcwDevice *dev, Error **errp);
-    void (*unrealize)(VirtioCcwDevice *dev, Error **errp);
+    void (*unrealize)(VirtioCcwDevice *dev);
     void (*parent_reset)(DeviceState *dev);
 } VirtIOCCWDeviceClass;
 
diff --git a/hw/sd/sdhci-internal.h b/hw/sd/sdhci-internal.h
index 34141400f8..e7c8a523b5 100644
--- a/hw/sd/sdhci-internal.h
+++ b/hw/sd/sdhci-internal.h
@@ -335,7 +335,7 @@ extern const VMStateDescription sdhci_vmstate;
 void sdhci_initfn(SDHCIState *s);
 void sdhci_uninitfn(SDHCIState *s);
 void sdhci_common_realize(SDHCIState *s, Error **errp);
-void sdhci_common_unrealize(SDHCIState *s, Error **errp);
+void sdhci_common_unrealize(SDHCIState *s);
 void sdhci_common_class_init(ObjectClass *klass, void *data);
 
 #endif
diff --git a/hw/usb/ccid.h b/hw/usb/ccid.h
index bb2fdbfff3..531bf28fb0 100644
--- a/hw/usb/ccid.h
+++ b/hw/usb/ccid.h
@@ -36,7 +36,7 @@ typedef struct CCIDCardClass {
                             const uint8_t *apdu,
                             uint32_t len);
     void (*realize)(CCIDCardState *card, Error **errp);
-    void (*unrealize)(CCIDCardState *card, Error **errp);
+    void (*unrealize)(CCIDCardState *card);
 } CCIDCardClass;
 
 /*
diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h
index edb59311c4..57b38cfc05 100644
--- a/hw/usb/hcd-ehci.h
+++ b/hw/usb/hcd-ehci.h
@@ -324,7 +324,7 @@ extern const VMStateDescription vmstate_ehci;
 void usb_ehci_init(EHCIState *s, DeviceState *dev);
 void usb_ehci_finalize(EHCIState *s);
 void usb_ehci_realize(EHCIState *s, DeviceState *dev, Error **errp);
-void usb_ehci_unrealize(EHCIState *s, DeviceState *dev, Error **errp);
+void usb_ehci_unrealize(EHCIState *s, DeviceState *dev);
 void ehci_reset(void *opaque);
 
 #define TYPE_PCI_EHCI "pci-ehci-usb"
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 6f537f687f..b870b27966 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -30,10 +30,10 @@ typedef enum DeviceCategory {
 } DeviceCategory;
 
 typedef void (*DeviceRealize)(DeviceState *dev, Error **errp);
-typedef void (*DeviceUnrealize)(DeviceState *dev, Error **errp);
+typedef void (*DeviceUnrealize)(DeviceState *dev);
 typedef void (*DeviceReset)(DeviceState *dev);
 typedef void (*BusRealize)(BusState *bus, Error **errp);
-typedef void (*BusUnrealize)(BusState *bus, Error **errp);
+typedef void (*BusUnrealize)(BusState *bus);
 
 /**
  * DeviceClass:
diff --git a/include/hw/s390x/s390-ccw.h b/include/hw/s390x/s390-ccw.h
index fffb54562f..7f27bc2f53 100644
--- a/include/hw/s390x/s390-ccw.h
+++ b/include/hw/s390x/s390-ccw.h
@@ -33,7 +33,7 @@ typedef struct S390CCWDevice {
 typedef struct S390CCWDeviceClass {
     CCWDeviceClass parent_class;
     void (*realize)(S390CCWDevice *dev, char *sysfsdev, Error **errp);
-    void (*unrealize)(S390CCWDevice *dev, Error **errp);
+    void (*unrealize)(S390CCWDevice *dev);
     IOInstEnding (*handle_request) (SubchDev *sch);
     int (*handle_halt) (SubchDev *sch);
     int (*handle_clear) (SubchDev *sch);
diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
index 332ef602f4..2fc23e44ba 100644
--- a/include/hw/scsi/scsi.h
+++ b/include/hw/scsi/scsi.h
@@ -59,7 +59,7 @@ struct SCSIRequest {
 typedef struct SCSIDeviceClass {
     DeviceClass parent_class;
     void (*realize)(SCSIDevice *dev, Error **errp);
-    void (*unrealize)(SCSIDevice *dev, Error **errp);
+    void (*unrealize)(SCSIDevice *dev);
     int (*parse_cdb)(SCSIDevice *dev, SCSICommand *cmd, uint8_t *buf,
                      void *hba_private);
     SCSIRequest *(*alloc_req)(SCSIDevice *s, uint32_t tag, uint32_t lun,
diff --git a/include/hw/usb.h b/include/hw/usb.h
index c24d968a19..1cf1cd9584 100644
--- a/include/hw/usb.h
+++ b/include/hw/usb.h
@@ -272,7 +272,7 @@ struct USBDevice {
      OBJECT_GET_CLASS(USBDeviceClass, (obj), TYPE_USB_DEVICE)
 
 typedef void (*USBDeviceRealize)(USBDevice *dev, Error **errp);
-typedef void (*USBDeviceUnrealize)(USBDevice *dev, Error **errp);
+typedef void (*USBDeviceUnrealize)(USBDevice *dev);
 
 typedef struct USBDeviceClass {
     DeviceClass parent_class;
diff --git a/include/hw/xen/xen-block.h b/include/hw/xen/xen-block.h
index 11d351b4b3..2cd2fc2701 100644
--- a/include/hw/xen/xen-block.h
+++ b/include/hw/xen/xen-block.h
@@ -57,7 +57,7 @@ typedef struct XenBlockDevice {
 } XenBlockDevice;
 
 typedef void (*XenBlockDeviceRealize)(XenBlockDevice *blockdev, Error **errp);
-typedef void (*XenBlockDeviceUnrealize)(XenBlockDevice *blockdev, Error **errp);
+typedef void (*XenBlockDeviceUnrealize)(XenBlockDevice *blockdev);
 
 typedef struct XenBlockDeviceClass {
     /*< private >*/
diff --git a/include/hw/xen/xen-bus.h b/include/hw/xen/xen-bus.h
index c18c1372af..4ec0bb072f 100644
--- a/include/hw/xen/xen-bus.h
+++ b/include/hw/xen/xen-bus.h
@@ -42,7 +42,7 @@ typedef void (*XenDeviceRealize)(XenDevice *xendev, Error **errp);
 typedef void (*XenDeviceFrontendChanged)(XenDevice *xendev,
                                          enum xenbus_state frontend_state,
                                          Error **errp);
-typedef void (*XenDeviceUnrealize)(XenDevice *xendev, Error **errp);
+typedef void (*XenDeviceUnrealize)(XenDevice *xendev);
 
 typedef struct XenDeviceClass {
     /*< private >*/
diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 9e046f7acb..a2a14b5979 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -4124,13 +4124,13 @@ int v9fs_device_realize_common(V9fsState *s, const V9fsTransport *t,
     rc = 0;
 out:
     if (rc) {
-        v9fs_device_unrealize_common(s, NULL);
+        v9fs_device_unrealize_common(s);
     }
     v9fs_path_free(&path);
     return rc;
 }
 
-void v9fs_device_unrealize_common(V9fsState *s, Error **errp)
+void v9fs_device_unrealize_common(V9fsState *s)
 {
     if (s->ops && s->ops->cleanup) {
         s->ops->cleanup(&s->ctx);
diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
index 536447a355..e5b44977c7 100644
--- a/hw/9pfs/virtio-9p-device.c
+++ b/hw/9pfs/virtio-9p-device.c
@@ -212,7 +212,7 @@ static void virtio_9p_device_realize(DeviceState *dev, Error **errp)
     v->vq = virtio_add_queue(vdev, MAX_REQ, handle_9p_output);
 }
 
-static void virtio_9p_device_unrealize(DeviceState *dev, Error **errp)
+static void virtio_9p_device_unrealize(DeviceState *dev)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     V9fsVirtioState *v = VIRTIO_9P(dev);
@@ -220,7 +220,7 @@ static void virtio_9p_device_unrealize(DeviceState *dev, Error **errp)
 
     virtio_delete_queue(v->vq);
     virtio_cleanup(vdev);
-    v9fs_device_unrealize_common(s, errp);
+    v9fs_device_unrealize_common(s);
 }
 
 /* virtio-9p device */
diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index fbc86af102..d42906ea19 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -266,7 +266,7 @@ void acpi_pcihp_device_unplug_cb(HotplugHandler *hotplug_dev, AcpiPciHpState *s,
 {
     trace_acpi_pci_unplug(PCI_SLOT(PCI_DEVICE(dev)->devfn),
                           acpi_pcihp_get_bsel(pci_get_bus(PCI_DEVICE(dev))));
-    object_property_set_bool(OBJECT(dev), false, "realized", NULL);
+    object_property_set_bool(OBJECT(dev), false, "realized", &error_abort);
 }
 
 void acpi_pcihp_device_unplug_request_cb(HotplugHandler *hotplug_dev,
diff --git a/hw/audio/intel-hda.c b/hw/audio/intel-hda.c
index e8d18b7c58..4696ae0d9a 100644
--- a/hw/audio/intel-hda.c
+++ b/hw/audio/intel-hda.c
@@ -74,7 +74,7 @@ static void hda_codec_dev_realize(DeviceState *qdev, Error **errp)
     }
 }
 
-static void hda_codec_dev_unrealize(DeviceState *qdev, Error **errp)
+static void hda_codec_dev_unrealize(DeviceState *qdev)
 {
     HDACodecDevice *dev = HDA_CODEC_DEVICE(qdev);
     HDACodecDeviceClass *cdc = HDA_CODEC_DEVICE_GET_CLASS(dev);
diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index 12f18d401a..f0579ecb17 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -949,7 +949,7 @@ static Property pflash_cfi02_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
-static void pflash_cfi02_unrealize(DeviceState *dev, Error **errp)
+static void pflash_cfi02_unrealize(DeviceState *dev)
 {
     PFlashCFI02 *pfl = PFLASH_CFI02(dev);
     timer_del(&pfl->timer);
diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 5263e0c9ad..9d8c0b3909 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -452,7 +452,7 @@ virtio_err:
     vhost_user_cleanup(&s->vhost_user);
 }
 
-static void vhost_user_blk_device_unrealize(DeviceState *dev, Error **errp)
+static void vhost_user_blk_device_unrealize(DeviceState *dev)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VHostUserBlk *s = VHOST_USER_BLK(dev);
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index fb32717a12..f5f6fc925e 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1223,7 +1223,7 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
                          conf->conf.lsecs);
 }
 
-static void virtio_blk_device_unrealize(DeviceState *dev, Error **errp)
+static void virtio_blk_device_unrealize(DeviceState *dev)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VirtIOBlock *s = VIRTIO_BLK(dev);
diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
index 99cb4c67cb..570489d6d9 100644
--- a/hw/block/xen-block.c
+++ b/hw/block/xen-block.c
@@ -136,7 +136,7 @@ static void xen_block_connect(XenDevice *xendev, Error **errp)
     g_free(ring_ref);
 }
 
-static void xen_block_unrealize(XenDevice *xendev, Error **errp)
+static void xen_block_unrealize(XenDevice *xendev)
 {
     XenBlockDevice *blockdev = XEN_BLOCK_DEVICE(xendev);
     XenBlockDeviceClass *blockdev_class =
@@ -157,7 +157,7 @@ static void xen_block_unrealize(XenDevice *xendev, Error **errp)
     blockdev->dataplane = NULL;
 
     if (blockdev_class->unrealize) {
-        blockdev_class->unrealize(blockdev, errp);
+        blockdev_class->unrealize(blockdev);
     }
 }
 
@@ -567,7 +567,7 @@ static const TypeInfo xen_block_type_info = {
     .class_init = xen_block_class_init,
 };
 
-static void xen_disk_unrealize(XenBlockDevice *blockdev, Error **errp)
+static void xen_disk_unrealize(XenBlockDevice *blockdev)
 {
     trace_xen_disk_unrealize();
 }
@@ -606,7 +606,7 @@ static const TypeInfo xen_disk_type_info = {
     .class_init = xen_disk_class_init,
 };
 
-static void xen_cdrom_unrealize(XenBlockDevice *blockdev, Error **errp)
+static void xen_cdrom_unrealize(XenBlockDevice *blockdev)
 {
     trace_xen_cdrom_unrealize();
 }
diff --git a/hw/char/serial-pci-multi.c b/hw/char/serial-pci-multi.c
index 1742cb77ec..5f9ccfcc93 100644
--- a/hw/char/serial-pci-multi.c
+++ b/hw/char/serial-pci-multi.c
@@ -56,7 +56,7 @@ static void multi_serial_pci_exit(PCIDevice *dev)
 
     for (i = 0; i < pci->ports; i++) {
         s = pci->state + i;
-        object_property_set_bool(OBJECT(s), false, "realized", NULL);
+        object_property_set_bool(OBJECT(s), false, "realized", &error_abort);
         memory_region_del_subregion(&pci->iobar, &s->io);
         g_free(pci->name[i]);
     }
diff --git a/hw/char/serial-pci.c b/hw/char/serial-pci.c
index 743552c56b..37818db156 100644
--- a/hw/char/serial-pci.c
+++ b/hw/char/serial-pci.c
@@ -68,7 +68,7 @@ static void serial_pci_exit(PCIDevice *dev)
     PCISerialState *pci = DO_UPCAST(PCISerialState, dev, dev);
     SerialState *s = &pci->state;
 
-    object_property_set_bool(OBJECT(s), false, "realized", NULL);
+    object_property_set_bool(OBJECT(s), false, "realized", &error_abort);
     qemu_free_irq(s->irq);
 }
 
diff --git a/hw/char/serial.c b/hw/char/serial.c
index c822a9ae6c..7d74694587 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -950,7 +950,7 @@ static void serial_realize(DeviceState *dev, Error **errp)
     serial_reset(s);
 }
 
-static void serial_unrealize(DeviceState *dev, Error **errp)
+static void serial_unrealize(DeviceState *dev)
 {
     SerialState *s = SERIAL(dev);
 
diff --git a/hw/char/virtio-console.c b/hw/char/virtio-console.c
index b010c21de4..4f46753ea3 100644
--- a/hw/char/virtio-console.c
+++ b/hw/char/virtio-console.c
@@ -249,7 +249,7 @@ static void virtconsole_realize(DeviceState *dev, Error **errp)
     }
 }
 
-static void virtconsole_unrealize(DeviceState *dev, Error **errp)
+static void virtconsole_unrealize(DeviceState *dev)
 {
     VirtConsole *vcon = VIRTIO_CONSOLE(dev);
 
diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index 99a65bab7f..262089c0c9 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -1010,7 +1010,7 @@ static void virtser_port_device_plug(HotplugHandler *hotplug_dev,
     virtio_notify_config(VIRTIO_DEVICE(hotplug_dev));
 }
 
-static void virtser_port_device_unrealize(DeviceState *dev, Error **errp)
+static void virtser_port_device_unrealize(DeviceState *dev)
 {
     VirtIOSerialPort *port = VIRTIO_SERIAL_PORT(dev);
     VirtIOSerialPortClass *vsc = VIRTIO_SERIAL_PORT_GET_CLASS(dev);
@@ -1022,7 +1022,7 @@ static void virtser_port_device_unrealize(DeviceState *dev, Error **errp)
     QTAILQ_REMOVE(&vser->ports, port, next);
 
     if (vsc->unrealize) {
-        vsc->unrealize(dev, errp);
+        vsc->unrealize(dev);
     }
 }
 
@@ -1122,7 +1122,7 @@ static const TypeInfo virtio_serial_port_type_info = {
     .class_init = virtio_serial_port_class_init,
 };
 
-static void virtio_serial_device_unrealize(DeviceState *dev, Error **errp)
+static void virtio_serial_device_unrealize(DeviceState *dev)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VirtIOSerial *vser = VIRTIO_SERIAL(dev);
@@ -1147,7 +1147,7 @@ static void virtio_serial_device_unrealize(DeviceState *dev, Error **errp)
         g_free(vser->post_load);
     }
 
-    qbus_set_hotplug_handler(BUS(&vser->bus), NULL, errp);
+    qbus_set_hotplug_handler(BUS(&vser->bus), NULL, &error_abort);
 
     virtio_cleanup(vdev);
 }
diff --git a/hw/core/bus.c b/hw/core/bus.c
index 4a57ae107e..a9e4118d3c 100644
--- a/hw/core/bus.c
+++ b/hw/core/bus.c
@@ -176,11 +176,10 @@ static void bus_set_realized(Object *obj, bool value, Error **errp)
     BusState *bus = BUS(obj);
     BusClass *bc = BUS_GET_CLASS(bus);
     BusChild *kid;
-    Error *local_err = NULL;
 
     if (value && !bus->realized) {
         if (bc->realize) {
-            bc->realize(bus, &local_err);
+            bc->realize(bus, errp);
         }
 
         /* TODO: recursive realization */
@@ -188,21 +187,13 @@ static void bus_set_realized(Object *obj, bool value, Error **errp)
         QTAILQ_FOREACH(kid, &bus->children, sibling) {
             DeviceState *dev = kid->child;
             object_property_set_bool(OBJECT(dev), false, "realized",
-                                     &local_err);
-            if (local_err != NULL) {
-                break;
-            }
+                                     &error_abort);
         }
-        if (bc->unrealize && local_err == NULL) {
-            bc->unrealize(bus, &local_err);
+        if (bc->unrealize) {
+            bc->unrealize(bus);
         }
     }
 
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
-        return;
-    }
-
     bus->realized = value;
 }
 
diff --git a/hw/core/cpu.c b/hw/core/cpu.c
index 786a1bec8a..5284d384fb 100644
--- a/hw/core/cpu.c
+++ b/hw/core/cpu.c
@@ -345,7 +345,7 @@ static void cpu_common_realizefn(DeviceState *dev, Error **errp)
     trace_init_vcpu(cpu);
 }
 
-static void cpu_common_unrealizefn(DeviceState *dev, Error **errp)
+static void cpu_common_unrealizefn(DeviceState *dev)
 {
     CPUState *cpu = CPU(dev);
     /* NOTE: latest generic point before the cpu is fully unrealized */
diff --git a/hw/core/generic-loader.c b/hw/core/generic-loader.c
index b9aaa52706..a242c076f6 100644
--- a/hw/core/generic-loader.c
+++ b/hw/core/generic-loader.c
@@ -173,7 +173,7 @@ static void generic_loader_realize(DeviceState *dev, Error **errp)
     }
 }
 
-static void generic_loader_unrealize(DeviceState *dev, Error **errp)
+static void generic_loader_unrealize(DeviceState *dev)
 {
     qemu_unregister_reset(generic_loader_reset, dev);
 }
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 2afa2562b8..b9c7a2f904 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -392,7 +392,7 @@ static void device_reset_child_foreach(Object *obj, ResettableChildCallback cb,
 void qdev_simple_device_unplug_cb(HotplugHandler *hotplug_dev,
                                   DeviceState *dev, Error **errp)
 {
-    object_property_set_bool(OBJECT(dev), false, "realized", NULL);
+    object_property_set_bool(OBJECT(dev), false, "realized", &error_abort);
 }
 
 /*
@@ -945,23 +945,18 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
        }
 
     } else if (!value && dev->realized) {
-        /* We want local_err to track only the first error */
         QLIST_FOREACH(bus, &dev->child_bus, sibling) {
             object_property_set_bool(OBJECT(bus), false, "realized",
-                                     local_err ? NULL : &local_err);
+                                     &error_abort);
         }
         if (qdev_get_vmsd(dev)) {
             vmstate_unregister(VMSTATE_IF(dev), qdev_get_vmsd(dev), dev);
         }
         if (dc->unrealize) {
-            dc->unrealize(dev, local_err ? NULL : &local_err);
+            dc->unrealize(dev);
         }
         dev->pending_deleted_event = true;
         DEVICE_LISTENER_CALL(unrealize, Reverse, dev);
-
-        if (local_err != NULL) {
-            goto fail;
-        }
     }
 
     assert(local_err == NULL);
@@ -971,7 +966,7 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
 child_realize_fail:
     QLIST_FOREACH(bus, &dev->child_bus, sibling) {
         object_property_set_bool(OBJECT(bus), false, "realized",
-                                 NULL);
+                                 &error_abort);
     }
 
     if (qdev_get_vmsd(dev)) {
@@ -982,7 +977,7 @@ post_realize_fail:
     g_free(dev->canonical_path);
     dev->canonical_path = NULL;
     if (dc->unrealize) {
-        dc->unrealize(dev, NULL);
+        dc->unrealize(dev);
     }
 
 fail:
@@ -1083,7 +1078,7 @@ static void device_unparent(Object *obj)
     BusState *bus;
 
     if (dev->realized) {
-        object_property_set_bool(obj, false, "realized", NULL);
+        object_property_set_bool(obj, false, "realized", &error_abort);
     }
     while (dev->num_child_bus) {
         bus = QLIST_FIRST(&dev->child_bus);
diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c
index 55e07995fe..c159351be3 100644
--- a/hw/display/virtio-gpu-base.c
+++ b/hw/display/virtio-gpu-base.c
@@ -203,7 +203,7 @@ virtio_gpu_base_set_features(VirtIODevice *vdev, uint64_t features)
 }
 
 static void
-virtio_gpu_base_device_unrealize(DeviceState *qdev, Error **errp)
+virtio_gpu_base_device_unrealize(DeviceState *qdev)
 {
     VirtIOGPUBase *g = VIRTIO_GPU_BASE(qdev);
 
diff --git a/hw/dma/rc4030.c b/hw/dma/rc4030.c
index 7434d274aa..eefbabd758 100644
--- a/hw/dma/rc4030.c
+++ b/hw/dma/rc4030.c
@@ -690,7 +690,7 @@ static void rc4030_realize(DeviceState *dev, Error **errp)
     address_space_init(&s->dma_as, MEMORY_REGION(&s->dma_mr), "rc4030-dma");
 }
 
-static void rc4030_unrealize(DeviceState *dev, Error **errp)
+static void rc4030_unrealize(DeviceState *dev)
 {
     rc4030State *s = RC4030(dev);
 
diff --git a/hw/i386/kvm/apic.c b/hw/i386/kvm/apic.c
index 91fb622d63..4eb2d77b87 100644
--- a/hw/i386/kvm/apic.c
+++ b/hw/i386/kvm/apic.c
@@ -230,7 +230,7 @@ static void kvm_apic_realize(DeviceState *dev, Error **errp)
     }
 }
 
-static void kvm_apic_unrealize(DeviceState *dev, Error **errp)
+static void kvm_apic_unrealize(DeviceState *dev)
 {
 }
 
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 33cf14363a..2128f3d6fe 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1385,7 +1385,7 @@ static void pc_memory_unplug(HotplugHandler *hotplug_dev,
     }
 
     pc_dimm_unplug(PC_DIMM(dev), MACHINE(pcms));
-    object_property_set_bool(OBJECT(dev), false, "realized", NULL);
+    object_property_set_bool(OBJECT(dev), false, "realized", &error_abort);
  out:
     error_propagate(errp, local_err);
 }
@@ -1493,7 +1493,7 @@ static void pc_cpu_unplug_cb(HotplugHandler *hotplug_dev,
 
     found_cpu = pc_find_cpu_slot(MACHINE(pcms), cpu->apic_id, NULL);
     found_cpu->cpu = NULL;
-    object_property_set_bool(OBJECT(dev), false, "realized", NULL);
+    object_property_set_bool(OBJECT(dev), false, "realized", &error_abort);
 
     /* decrement the number of CPUs */
     x86ms->boot_cpus--;
diff --git a/hw/ide/qdev.c b/hw/ide/qdev.c
index 4909b14b91..06b11583f5 100644
--- a/hw/ide/qdev.c
+++ b/hw/ide/qdev.c
@@ -36,7 +36,7 @@
 /* --------------------------------- */
 
 static char *idebus_get_fw_dev_path(DeviceState *dev);
-static void idebus_unrealize(BusState *qdev, Error **errp);
+static void idebus_unrealize(BusState *qdev);
 
 static Property ide_props[] = {
     DEFINE_PROP_UINT32("unit", IDEDevice, unit, -1),
@@ -51,7 +51,7 @@ static void ide_bus_class_init(ObjectClass *klass, void *data)
     k->unrealize = idebus_unrealize;
 }
 
-static void idebus_unrealize(BusState *bus, Error **errp)
+static void idebus_unrealize(BusState *bus)
 {
     IDEBus *ibus = IDE_BUS(bus);
 
diff --git a/hw/input/virtio-input-hid.c b/hw/input/virtio-input-hid.c
index e8ae6c148a..09cf260985 100644
--- a/hw/input/virtio-input-hid.c
+++ b/hw/input/virtio-input-hid.c
@@ -165,7 +165,7 @@ static void virtio_input_hid_realize(DeviceState *dev, Error **errp)
     }
 }
 
-static void virtio_input_hid_unrealize(DeviceState *dev, Error **errp)
+static void virtio_input_hid_unrealize(DeviceState *dev)
 {
     VirtIOInputHID *vhid = VIRTIO_INPUT_HID(dev);
     qemu_input_handler_unregister(vhid->hs);
diff --git a/hw/input/virtio-input-host.c b/hw/input/virtio-input-host.c
index f2ab6df676..85daf73f1a 100644
--- a/hw/input/virtio-input-host.c
+++ b/hw/input/virtio-input-host.c
@@ -178,7 +178,7 @@ err_close:
     return;
 }
 
-static void virtio_input_host_unrealize(DeviceState *dev, Error **errp)
+static void virtio_input_host_unrealize(DeviceState *dev)
 {
     VirtIOInputHost *vih = VIRTIO_INPUT_HOST(dev);
 
diff --git a/hw/input/virtio-input.c b/hw/input/virtio-input.c
index 4d49790f50..54bcb46c74 100644
--- a/hw/input/virtio-input.c
+++ b/hw/input/virtio-input.c
@@ -276,19 +276,14 @@ static void virtio_input_finalize(Object *obj)
     g_free(vinput->queue);
 }
 
-static void virtio_input_device_unrealize(DeviceState *dev, Error **errp)
+static void virtio_input_device_unrealize(DeviceState *dev)
 {
     VirtIOInputClass *vic = VIRTIO_INPUT_GET_CLASS(dev);
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VirtIOInput *vinput = VIRTIO_INPUT(dev);
-    Error *local_err = NULL;
 
     if (vic->unrealize) {
-        vic->unrealize(dev, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
-            return;
-        }
+        vic->unrealize(dev);
     }
     virtio_delete_queue(vinput->evt);
     virtio_delete_queue(vinput->sts);
diff --git a/hw/intc/apic.c b/hw/intc/apic.c
index bd40467965..6b46839ef4 100644
--- a/hw/intc/apic.c
+++ b/hw/intc/apic.c
@@ -900,7 +900,7 @@ static void apic_realize(DeviceState *dev, Error **errp)
     msi_nonbroken = true;
 }
 
-static void apic_unrealize(DeviceState *dev, Error **errp)
+static void apic_unrealize(DeviceState *dev)
 {
     APICCommonState *s = APIC(dev);
 
diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
index 243bb69430..7da2862b3d 100644
--- a/hw/intc/apic_common.c
+++ b/hw/intc/apic_common.c
@@ -293,13 +293,13 @@ static void apic_common_realize(DeviceState *dev, Error **errp)
                                    s, -1, 0, NULL);
 }
 
-static void apic_common_unrealize(DeviceState *dev, Error **errp)
+static void apic_common_unrealize(DeviceState *dev)
 {
     APICCommonState *s = APIC_COMMON(dev);
     APICCommonClass *info = APIC_COMMON_GET_CLASS(s);
 
     vmstate_unregister(NULL, &vmstate_apic_common, s);
-    info->unrealize(dev, errp);
+    info->unrealize(dev);
 
     if (apic_report_tpr_access && info->enable_tpr_reporting) {
         info->enable_tpr_reporting(s, false);
diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
index 15747fe2c2..ffe30dc457 100644
--- a/hw/intc/ioapic.c
+++ b/hw/intc/ioapic.c
@@ -451,7 +451,7 @@ static void ioapic_realize(DeviceState *dev, Error **errp)
     qemu_add_machine_init_done_notifier(&s->machine_done);
 }
 
-static void ioapic_unrealize(DeviceState *dev, Error **errp)
+static void ioapic_unrealize(DeviceState *dev)
 {
     IOAPICCommonState *s = IOAPIC_COMMON(dev);
 
diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index e56d578841..d5032c8f8a 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -338,7 +338,7 @@ static void icp_realize(DeviceState *dev, Error **errp)
     vmstate_register(NULL, icp->cs->cpu_index, &vmstate_icp_server, icp);
 }
 
-static void icp_unrealize(DeviceState *dev, Error **errp)
+static void icp_unrealize(DeviceState *dev)
 {
     ICPState *icp = ICP(dev);
 
diff --git a/hw/ipack/ipack.c b/hw/ipack/ipack.c
index 49787a13bc..f19ecaeb1c 100644
--- a/hw/ipack/ipack.c
+++ b/hw/ipack/ipack.c
@@ -60,15 +60,13 @@ static void ipack_device_realize(DeviceState *dev, Error **errp)
     k->realize(dev, errp);
 }
 
-static void ipack_device_unrealize(DeviceState *dev, Error **errp)
+static void ipack_device_unrealize(DeviceState *dev)
 {
     IPackDevice *idev = IPACK_DEVICE(dev);
     IPackDeviceClass *k = IPACK_DEVICE_GET_CLASS(dev);
-    Error *err = NULL;
 
     if (k->unrealize) {
-        k->unrealize(dev, &err);
-        error_propagate(errp, err);
+        k->unrealize(dev);
         return;
     }
 
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index b81c82f57b..f2a86ec4ee 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -199,7 +199,7 @@ static void pc_dimm_realize(DeviceState *dev, Error **errp)
     host_memory_backend_set_mapped(dimm->hostmem, true);
 }
 
-static void pc_dimm_unrealize(DeviceState *dev, Error **errp)
+static void pc_dimm_unrealize(DeviceState *dev)
 {
     PCDIMMDevice *dimm = PC_DIMM(dev);
 
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index b43fd7d608..b7f3d1b2eb 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3077,7 +3077,7 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
     n->qdev = dev;
 }
 
-static void virtio_net_device_unrealize(DeviceState *dev, Error **errp)
+static void virtio_net_device_unrealize(DeviceState *dev)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VirtIONet *n = VIRTIO_NET(dev);
diff --git a/hw/nvram/mac_nvram.c b/hw/nvram/mac_nvram.c
index 2e8a1e3812..ff5db03e6b 100644
--- a/hw/nvram/mac_nvram.c
+++ b/hw/nvram/mac_nvram.c
@@ -107,7 +107,7 @@ static void macio_nvram_realizefn(DeviceState *dev, Error **errp)
     sysbus_init_mmio(d, &s->mem);
 }
 
-static void macio_nvram_unrealizefn(DeviceState *dev, Error **errp)
+static void macio_nvram_unrealizefn(DeviceState *dev)
 {
     MacIONVRAMState *s = MACIO_NVRAM(dev);
 
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index b5bc842fac..70c66965f5 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -146,7 +146,7 @@ static void pcie_bus_realize(BusState *qbus, Error **errp)
     }
 }
 
-static void pci_bus_unrealize(BusState *qbus, Error **errp)
+static void pci_bus_unrealize(BusState *qbus)
 {
     PCIBus *bus = PCI_BUS(qbus);
 
@@ -456,7 +456,7 @@ void pci_root_bus_cleanup(PCIBus *bus)
 {
     pci_bus_uninit(bus);
     /* the caller of the unplug hotplug handler will delete this device */
-    object_property_set_bool(OBJECT(bus), false, "realized", NULL);
+    object_property_set_bool(OBJECT(bus), false, "realized", &error_abort);
 }
 
 void pci_bus_irqs(PCIBus *bus, pci_set_irq_fn set_irq, pci_map_irq_fn map_irq,
@@ -1118,7 +1118,7 @@ static void pci_unregister_io_regions(PCIDevice *pci_dev)
     pci_unregister_vga(pci_dev);
 }
 
-static void pci_qdev_unrealize(DeviceState *dev, Error **errp)
+static void pci_qdev_unrealize(DeviceState *dev)
 {
     PCIDevice *pci_dev = PCI_DEVICE(dev);
     PCIDeviceClass *pc = PCI_DEVICE_GET_CLASS(pci_dev);
@@ -2108,7 +2108,7 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
             error_setg(errp, "failover primary device must be on "
                              "PCIExpress bus");
             error_propagate(errp, local_err);
-            pci_qdev_unrealize(DEVICE(pci_dev), NULL);
+            pci_qdev_unrealize(DEVICE(pci_dev));
             return;
         }
         class_id = pci_get_word(pci_dev->config + PCI_CLASS_DEVICE);
@@ -2116,7 +2116,7 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
             error_setg(errp, "failover primary device is not an "
                              "Ethernet device");
             error_propagate(errp, local_err);
-            pci_qdev_unrealize(DEVICE(pci_dev), NULL);
+            pci_qdev_unrealize(DEVICE(pci_dev));
             return;
         }
         if (!(pci_dev->cap_present & QEMU_PCI_CAP_MULTIFUNCTION)
@@ -2126,7 +2126,7 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
             error_setg(errp, "failover: primary device must be in its own "
                               "PCI slot");
             error_propagate(errp, local_err);
-            pci_qdev_unrealize(DEVICE(pci_dev), NULL);
+            pci_qdev_unrealize(DEVICE(pci_dev));
             return;
         }
         qdev->allow_unplug_during_migration = true;
@@ -2142,7 +2142,7 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
     pci_add_option_rom(pci_dev, is_default_rom, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
-        pci_qdev_unrealize(DEVICE(pci_dev), NULL);
+        pci_qdev_unrealize(DEVICE(pci_dev));
         return;
     }
 }
diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index abc99b6eff..f50e10b8fb 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -457,7 +457,7 @@ void pcie_cap_slot_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
 void pcie_cap_slot_unplug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
                              Error **errp)
 {
-    object_property_set_bool(OBJECT(dev), false, "realized", NULL);
+    object_property_set_bool(OBJECT(dev), false, "realized", &error_abort);
 }
 
 static void pcie_unplug_device(PCIBus *bus, PCIDevice *dev, void *opaque)
diff --git a/hw/pci/shpc.c b/hw/pci/shpc.c
index 7f0aa28e44..b76d3d2c9a 100644
--- a/hw/pci/shpc.c
+++ b/hw/pci/shpc.c
@@ -547,7 +547,7 @@ void shpc_device_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
 void shpc_device_unplug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
                            Error **errp)
 {
-    object_property_set_bool(OBJECT(dev), false, "realized", NULL);
+    object_property_set_bool(OBJECT(dev), false, "realized", &error_abort);
 }
 
 void shpc_device_unplug_request_cb(HotplugHandler *hotplug_dev,
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 7033104676..96a446f001 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -275,7 +275,7 @@ static void pnv_core_cpu_unrealize(PnvCore *pc, PowerPCCPU *cpu)
     object_unparent(OBJECT(cpu));
 }
 
-static void pnv_core_unrealize(DeviceState *dev, Error **errp)
+static void pnv_core_unrealize(DeviceState *dev)
 {
     PnvCore *pc = PNV_CORE(dev);
     CPUCore *cc = CPU_CORE(dev);
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index b73f4d94d3..c0bf8c8d4f 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3670,7 +3670,7 @@ static void spapr_memory_unplug(HotplugHandler *hotplug_dev, DeviceState *dev)
     SpaprDimmState *ds = spapr_pending_dimm_unplugs_find(spapr, PC_DIMM(dev));
 
     pc_dimm_unplug(PC_DIMM(dev), MACHINE(hotplug_dev));
-    object_property_set_bool(OBJECT(dev), false, "realized", NULL);
+    object_property_set_bool(OBJECT(dev), false, "realized", &error_abort);
     spapr_pending_dimm_unplugs_remove(spapr, ds);
 }
 
@@ -3763,7 +3763,7 @@ static void spapr_core_unplug(HotplugHandler *hotplug_dev, DeviceState *dev)
 
     assert(core_slot);
     core_slot->cpu = NULL;
-    object_property_set_bool(OBJECT(dev), false, "realized", NULL);
+    object_property_set_bool(OBJECT(dev), false, "realized", &error_abort);
 }
 
 static
@@ -4036,7 +4036,7 @@ void spapr_phb_release(DeviceState *dev)
 
 static void spapr_phb_unplug(HotplugHandler *hotplug_dev, DeviceState *dev)
 {
-    object_property_set_bool(OBJECT(dev), false, "realized", NULL);
+    object_property_set_bool(OBJECT(dev), false, "realized", &error_abort);
 }
 
 static void spapr_phb_unplug_request(HotplugHandler *hotplug_dev,
@@ -4072,7 +4072,7 @@ static void spapr_tpm_proxy_unplug(HotplugHandler *hotplug_dev, DeviceState *dev
 {
     SpaprMachineState *spapr = SPAPR_MACHINE(OBJECT(hotplug_dev));
 
-    object_property_set_bool(OBJECT(dev), false, "realized", NULL);
+    object_property_set_bool(OBJECT(dev), false, "realized", &error_abort);
     object_unparent(OBJECT(dev));
     spapr->tpm_proxy = NULL;
 }
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index df5c7742ca..e1f76c74f3 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -218,7 +218,7 @@ static void spapr_cpu_core_reset_handler(void *opaque)
     spapr_cpu_core_reset(opaque);
 }
 
-static void spapr_cpu_core_unrealize(DeviceState *dev, Error **errp)
+static void spapr_cpu_core_unrealize(DeviceState *dev)
 {
     SpaprCpuCore *sc = SPAPR_CPU_CORE(OBJECT(dev));
     CPUCore *cc = CPU_CORE(dev);
diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 728307a992..8b2171f698 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -541,7 +541,7 @@ static void realize(DeviceState *d, Error **errp)
     trace_spapr_drc_realize_complete(spapr_drc_index(drc));
 }
 
-static void unrealize(DeviceState *d, Error **errp)
+static void unrealize(DeviceState *d)
 {
     SpaprDrc *drc = SPAPR_DR_CONNECTOR(d);
     Object *root_container;
@@ -551,7 +551,7 @@ static void unrealize(DeviceState *d, Error **errp)
     vmstate_unregister(VMSTATE_IF(drc), &vmstate_spapr_drc, drc);
     root_container = container_get(object_get_root(), DRC_CONTAINER_PATH);
     name = g_strdup_printf("%x", spapr_drc_index(drc));
-    object_property_del(root_container, name, errp);
+    object_property_del(root_container, name, &error_abort);
     g_free(name);
 }
 
@@ -650,17 +650,11 @@ static void realize_physical(DeviceState *d, Error **errp)
     qemu_register_reset(drc_physical_reset, drcp);
 }
 
-static void unrealize_physical(DeviceState *d, Error **errp)
+static void unrealize_physical(DeviceState *d)
 {
     SpaprDrcPhysical *drcp = SPAPR_DRC_PHYSICAL(d);
-    Error *local_err = NULL;
-
-    unrealize(d, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        return;
-    }
 
+    unrealize(d);
     vmstate_unregister(VMSTATE_IF(drcp), &vmstate_spapr_drc_physical, drcp);
     qemu_unregister_reset(drc_physical_reset, drcp);
 }
diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
index 601b896214..7e1d6d59ac 100644
--- a/hw/ppc/spapr_iommu.c
+++ b/hw/ppc/spapr_iommu.c
@@ -416,7 +416,7 @@ void spapr_tce_table_disable(SpaprTceTable *tcet)
     tcet->nb_table = 0;
 }
 
-static void spapr_tce_table_unrealize(DeviceState *dev, Error **errp)
+static void spapr_tce_table_unrealize(DeviceState *dev)
 {
     SpaprTceTable *tcet = SPAPR_TCE_TABLE(dev);
 
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 61b84a392d..616034222d 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1627,7 +1627,8 @@ static void spapr_pci_unplug(HotplugHandler *plug_handler,
         return;
     }
 
-    object_property_set_bool(OBJECT(plugged_dev), false, "realized", NULL);
+    object_property_set_bool(OBJECT(plugged_dev), false, "realized",
+                             &error_abort);
 }
 
 static void spapr_pci_unplug_request(HotplugHandler *plug_handler,
@@ -1715,7 +1716,7 @@ static void spapr_phb_finalizefn(Object *obj)
     sphb->dtbusname = NULL;
 }
 
-static void spapr_phb_unrealize(DeviceState *dev, Error **errp)
+static void spapr_phb_unrealize(DeviceState *dev)
 {
     SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
     SysBusDevice *s = SYS_BUS_DEVICE(dev);
@@ -1724,7 +1725,6 @@ static void spapr_phb_unrealize(DeviceState *dev, Error **errp)
     SpaprTceTable *tcet;
     int i;
     const unsigned windows_supported = spapr_phb_windows_supported(sphb);
-    Error *local_err = NULL;
 
     spapr_phb_nvgpu_free(sphb);
 
@@ -1745,11 +1745,7 @@ static void spapr_phb_unrealize(DeviceState *dev, Error **errp)
         }
     }
 
-    remove_drcs(sphb, phb->bus, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        return;
-    }
+    remove_drcs(sphb, phb->bus, &error_abort);
 
     for (i = PCI_NUM_PINS - 1; i >= 0; i--) {
         if (sphb->lsi_table[i].irq) {
@@ -2011,7 +2007,7 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
     return;
 
 unrealize:
-    spapr_phb_unrealize(dev, NULL);
+    spapr_phb_unrealize(dev);
 }
 
 static int spapr_phb_children_reset(Object *child, void *opaque)
diff --git a/hw/ppc/spapr_tpm_proxy.c b/hw/ppc/spapr_tpm_proxy.c
index 991615d77a..a01f81f9e0 100644
--- a/hw/ppc/spapr_tpm_proxy.c
+++ b/hw/ppc/spapr_tpm_proxy.c
@@ -140,7 +140,7 @@ static void spapr_tpm_proxy_realize(DeviceState *d, Error **errp)
     qemu_register_reset(spapr_tpm_proxy_reset, tpm_proxy);
 }
 
-static void spapr_tpm_proxy_unrealize(DeviceState *d, Error **errp)
+static void spapr_tpm_proxy_unrealize(DeviceState *d)
 {
     SpaprTpmProxy *tpm_proxy = SPAPR_TPM_PROXY(d);
 
diff --git a/hw/s390x/css-bridge.c b/hw/s390x/css-bridge.c
index 5d5286bc6e..3f6aec6b6a 100644
--- a/hw/s390x/css-bridge.c
+++ b/hw/s390x/css-bridge.c
@@ -54,7 +54,7 @@ static void ccw_device_unplug(HotplugHandler *hotplug_dev,
 
     css_generate_sch_crws(sch->cssid, sch->ssid, sch->schid, 1, 0);
 
-    object_property_set_bool(OBJECT(dev), false, "realized", NULL);
+    object_property_set_bool(OBJECT(dev), false, "realized", &error_abort);
 }
 
 static void virtual_css_bus_reset(BusState *qbus)
diff --git a/hw/s390x/s390-ccw.c b/hw/s390x/s390-ccw.c
index 569020dae4..c48510f9e5 100644
--- a/hw/s390x/s390-ccw.c
+++ b/hw/s390x/s390-ccw.c
@@ -132,7 +132,7 @@ out_err_propagate:
     error_propagate(errp, err);
 }
 
-static void s390_ccw_unrealize(S390CCWDevice *cdev, Error **errp)
+static void s390_ccw_unrealize(S390CCWDevice *cdev)
 {
     CcwDevice *ccw_dev = CCW_DEVICE(cdev);
     SubchDev *sch = ccw_dev->sch;
diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index ed8be124da..c4a4259f0c 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -1003,7 +1003,7 @@ static void s390_pcihost_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
                                      pbdev->fh, pbdev->fid);
         bus = pci_get_bus(pci_dev);
         devfn = pci_dev->devfn;
-        object_property_set_bool(OBJECT(dev), false, "realized", NULL);
+        object_property_set_bool(OBJECT(dev), false, "realized", &error_abort);
 
         s390_pci_msix_free(pbdev);
         s390_pci_iommu_free(s, bus, devfn);
@@ -1014,7 +1014,7 @@ static void s390_pcihost_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
         pbdev->fid = 0;
         QTAILQ_REMOVE(&s->zpci_devs, pbdev, link);
         g_hash_table_remove(s->zpci_table, &pbdev->idx);
-        object_property_set_bool(OBJECT(dev), false, "realized", NULL);
+        object_property_set_bool(OBJECT(dev), false, "realized", &error_abort);
     }
 }
 
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index 64f928fc7d..c1f4bb1d33 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -752,14 +752,14 @@ out_err:
     g_free(sch);
 }
 
-static void virtio_ccw_device_unrealize(VirtioCcwDevice *dev, Error **errp)
+static void virtio_ccw_device_unrealize(VirtioCcwDevice *dev)
 {
     VirtIOCCWDeviceClass *dc = VIRTIO_CCW_DEVICE_GET_CLASS(dev);
     CcwDevice *ccw_dev = CCW_DEVICE(dev);
     SubchDev *sch = ccw_dev->sch;
 
     if (dc->unrealize) {
-        dc->unrealize(dev, errp);
+        dc->unrealize(dev);
     }
 
     if (sch) {
@@ -1155,11 +1155,11 @@ static void virtio_ccw_busdev_realize(DeviceState *dev, Error **errp)
     virtio_ccw_device_realize(_dev, errp);
 }
 
-static void virtio_ccw_busdev_unrealize(DeviceState *dev, Error **errp)
+static void virtio_ccw_busdev_unrealize(DeviceState *dev)
 {
     VirtioCcwDevice *_dev = (VirtioCcwDevice *)dev;
 
-    virtio_ccw_device_unrealize(_dev, errp);
+    virtio_ccw_device_unrealize(_dev);
 }
 
 static void virtio_ccw_busdev_unplug(HotplugHandler *hotplug_dev,
diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index ec53b14f7f..63ff4181de 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -2312,7 +2312,7 @@ static void lsi_scsi_realize(PCIDevice *dev, Error **errp)
     scsi_bus_new(&s->bus, sizeof(s->bus), d, &lsi_scsi_info, NULL);
 }
 
-static void lsi_scsi_unrealize(DeviceState *dev, Error **errp)
+static void lsi_scsi_unrealize(DeviceState *dev)
 {
     LSIState *s = LSI53C895A(dev);
 
diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index 1733307407..2836f807a0 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -59,11 +59,11 @@ static void scsi_device_realize(SCSIDevice *s, Error **errp)
     }
 }
 
-static void scsi_device_unrealize(SCSIDevice *s, Error **errp)
+static void scsi_device_unrealize(SCSIDevice *s)
 {
     SCSIDeviceClass *sc = SCSI_DEVICE_GET_CLASS(s);
     if (sc->unrealize) {
-        sc->unrealize(s, errp);
+        sc->unrealize(s);
     }
 }
 
@@ -222,10 +222,9 @@ static void scsi_qdev_realize(DeviceState *qdev, Error **errp)
             scsi_dma_restart_cb, dev);
 }
 
-static void scsi_qdev_unrealize(DeviceState *qdev, Error **errp)
+static void scsi_qdev_unrealize(DeviceState *qdev)
 {
     SCSIDevice *dev = SCSI_DEVICE(qdev);
-    Error *local_err = NULL;
 
     if (dev->vmsentry) {
         qemu_del_vm_change_state_handler(dev->vmsentry);
@@ -233,11 +232,7 @@ static void scsi_qdev_unrealize(DeviceState *qdev, Error **errp)
 
     scsi_device_purge_requests(dev, SENSE_CODE(NO_SENSE));
 
-    scsi_device_unrealize(dev, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        return;
-    }
+    scsi_device_unrealize(dev);
 
     blockdev_mark_auto_del(dev->conf.blk);
 }
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index e5bcd0baf8..387503e11b 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -2421,7 +2421,7 @@ static void scsi_realize(SCSIDevice *dev, Error **errp)
                          dev->conf.lsecs);
 }
 
-static void scsi_unrealize(SCSIDevice *dev, Error **errp)
+static void scsi_unrealize(SCSIDevice *dev)
 {
     del_boot_device_lchs(&dev->qdev, NULL);
 }
diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
index ffa667171d..c1b012aea4 100644
--- a/hw/scsi/vhost-scsi.c
+++ b/hw/scsi/vhost-scsi.c
@@ -248,7 +248,7 @@ static void vhost_scsi_realize(DeviceState *dev, Error **errp)
     return;
 }
 
-static void vhost_scsi_unrealize(DeviceState *dev, Error **errp)
+static void vhost_scsi_unrealize(DeviceState *dev)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VHostSCSICommon *vsc = VHOST_SCSI_COMMON(dev);
diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index ae380b63b4..cbb5d97599 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -143,7 +143,7 @@ free_virtio:
     virtio_scsi_common_unrealize(dev);
 }
 
-static void vhost_user_scsi_unrealize(DeviceState *dev, Error **errp)
+static void vhost_user_scsi_unrealize(DeviceState *dev)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VHostUserSCSI *s = VHOST_USER_SCSI(dev);
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 472bbd233b..9b72094a61 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -954,7 +954,7 @@ void virtio_scsi_common_unrealize(DeviceState *dev)
     virtio_cleanup(vdev);
 }
 
-static void virtio_scsi_device_unrealize(DeviceState *dev, Error **errp)
+static void virtio_scsi_device_unrealize(DeviceState *dev)
 {
     VirtIOSCSI *s = VIRTIO_SCSI(dev);
 
diff --git a/hw/sd/sdhci-pci.c b/hw/sd/sdhci-pci.c
index 19fa8bd8ed..4f5977d487 100644
--- a/hw/sd/sdhci-pci.c
+++ b/hw/sd/sdhci-pci.c
@@ -50,7 +50,7 @@ static void sdhci_pci_exit(PCIDevice *dev)
 {
     SDHCIState *s = PCI_SDHCI(dev);
 
-    sdhci_common_unrealize(s, &error_abort);
+    sdhci_common_unrealize(s);
     sdhci_uninitfn(s);
 }
 
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 70531ad360..1b75d7bab9 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1346,7 +1346,7 @@ void sdhci_common_realize(SDHCIState *s, Error **errp)
                           SDHC_REGISTERS_MAP_SIZE);
 }
 
-void sdhci_common_unrealize(SDHCIState *s, Error **errp)
+void sdhci_common_unrealize(SDHCIState *s)
 {
     /* This function is expected to be called only once for each class:
      * - SysBus:    via DeviceClass->unrealize(),
@@ -1479,11 +1479,11 @@ static void sdhci_sysbus_realize(DeviceState *dev, Error **errp)
     sysbus_init_mmio(sbd, &s->iomem);
 }
 
-static void sdhci_sysbus_unrealize(DeviceState *dev, Error **errp)
+static void sdhci_sysbus_unrealize(DeviceState *dev)
 {
     SDHCIState *s = SYSBUS_SDHCI(dev);
 
-    sdhci_common_unrealize(s, &error_abort);
+    sdhci_common_unrealize(s);
 
      if (s->dma_mr) {
         address_space_destroy(s->dma_as);
diff --git a/hw/usb/bus.c b/hw/usb/bus.c
index 686f492112..fa07df98a2 100644
--- a/hw/usb/bus.c
+++ b/hw/usb/bus.c
@@ -14,7 +14,7 @@ static void usb_bus_dev_print(Monitor *mon, DeviceState *qdev, int indent);
 
 static char *usb_get_dev_path(DeviceState *dev);
 static char *usb_get_fw_dev_path(DeviceState *qdev);
-static void usb_qdev_unrealize(DeviceState *qdev, Error **errp);
+static void usb_qdev_unrealize(DeviceState *qdev);
 
 static Property usb_props[] = {
     DEFINE_PROP_STRING("port", USBDevice, port_path),
@@ -130,12 +130,12 @@ USBDevice *usb_device_find_device(USBDevice *dev, uint8_t addr)
     return NULL;
 }
 
-static void usb_device_unrealize(USBDevice *dev, Error **errp)
+static void usb_device_unrealize(USBDevice *dev)
 {
     USBDeviceClass *klass = USB_DEVICE_GET_CLASS(dev);
 
     if (klass->unrealize) {
-        klass->unrealize(dev, errp);
+        klass->unrealize(dev);
     }
 }
 
@@ -265,14 +265,14 @@ static void usb_qdev_realize(DeviceState *qdev, Error **errp)
     if (dev->auto_attach) {
         usb_device_attach(dev, &local_err);
         if (local_err) {
-            usb_qdev_unrealize(qdev, NULL);
+            usb_qdev_unrealize(qdev);
             error_propagate(errp, local_err);
             return;
         }
     }
 }
 
-static void usb_qdev_unrealize(DeviceState *qdev, Error **errp)
+static void usb_qdev_unrealize(DeviceState *qdev)
 {
     USBDevice *dev = USB_DEVICE(qdev);
     USBDescString *s, *next;
@@ -286,7 +286,7 @@ static void usb_qdev_unrealize(DeviceState *qdev, Error **errp)
     if (dev->attached) {
         usb_device_detach(dev);
     }
-    usb_device_unrealize(dev, errp);
+    usb_device_unrealize(dev);
     if (dev->port) {
         usb_release_port(dev);
     }
diff --git a/hw/usb/ccid-card-emulated.c b/hw/usb/ccid-card-emulated.c
index 3083124556..7d6105ef34 100644
--- a/hw/usb/ccid-card-emulated.c
+++ b/hw/usb/ccid-card-emulated.c
@@ -562,7 +562,7 @@ out1:
     qemu_mutex_destroy(&card->event_list_mutex);
 }
 
-static void emulated_unrealize(CCIDCardState *base, Error **errp)
+static void emulated_unrealize(CCIDCardState *base)
 {
     EmulatedState *card = EMULATED_CCID_CARD(base);
     VEvent *vevent = vevent_new(VEVENT_LAST, NULL, NULL);
diff --git a/hw/usb/dev-audio.c b/hw/usb/dev-audio.c
index 6fa213fad5..1371c44f48 100644
--- a/hw/usb/dev-audio.c
+++ b/hw/usb/dev-audio.c
@@ -923,7 +923,7 @@ static void usb_audio_handle_data(USBDevice *dev, USBPacket *p)
     }
 }
 
-static void usb_audio_unrealize(USBDevice *dev, Error **errp)
+static void usb_audio_unrealize(USBDevice *dev)
 {
     USBAudioState *s = USB_AUDIO(dev);
 
diff --git a/hw/usb/dev-hid.c b/hw/usb/dev-hid.c
index 67ec8b69ec..89f63b698b 100644
--- a/hw/usb/dev-hid.c
+++ b/hw/usb/dev-hid.c
@@ -699,7 +699,7 @@ static void usb_hid_handle_data(USBDevice *dev, USBPacket *p)
     }
 }
 
-static void usb_hid_unrealize(USBDevice *dev, Error **errp)
+static void usb_hid_unrealize(USBDevice *dev)
 {
     USBHIDState *us = USB_HID(dev);
 
diff --git a/hw/usb/dev-hub.c b/hw/usb/dev-hub.c
index 49a573b346..5f19dd9fb5 100644
--- a/hw/usb/dev-hub.c
+++ b/hw/usb/dev-hub.c
@@ -565,7 +565,7 @@ static void usb_hub_handle_data(USBDevice *dev, USBPacket *p)
     }
 }
 
-static void usb_hub_unrealize(USBDevice *dev, Error **errp)
+static void usb_hub_unrealize(USBDevice *dev)
 {
     USBHubState *s = (USBHubState *)dev;
     int i;
diff --git a/hw/usb/dev-network.c b/hw/usb/dev-network.c
index 720744488b..c69756709b 100644
--- a/hw/usb/dev-network.c
+++ b/hw/usb/dev-network.c
@@ -1326,7 +1326,7 @@ static void usbnet_cleanup(NetClientState *nc)
     s->nic = NULL;
 }
 
-static void usb_net_unrealize(USBDevice *dev, Error **errp)
+static void usb_net_unrealize(USBDevice *dev)
 {
     USBNetState *s = (USBNetState *) dev;
 
diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index ef72738ced..ada18c1983 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -1146,7 +1146,7 @@ static void ccid_handle_data(USBDevice *dev, USBPacket *p)
     }
 }
 
-static void ccid_unrealize(USBDevice *dev, Error **errp)
+static void ccid_unrealize(USBDevice *dev)
 {
     USBCCIDState *s = USB_CCID_DEV(dev);
 
@@ -1269,23 +1269,18 @@ void ccid_card_card_inserted(CCIDCardState *card)
     ccid_on_slot_change(s, true);
 }
 
-static void ccid_card_unrealize(DeviceState *qdev, Error **errp)
+static void ccid_card_unrealize(DeviceState *qdev)
 {
     CCIDCardState *card = CCID_CARD(qdev);
     CCIDCardClass *cc = CCID_CARD_GET_CLASS(card);
     USBDevice *dev = USB_DEVICE(qdev->parent_bus->parent);
     USBCCIDState *s = USB_CCID_DEV(dev);
-    Error *local_err = NULL;
 
     if (ccid_card_inserted(s)) {
         ccid_card_card_removed(card);
     }
     if (cc->unrealize) {
-        cc->unrealize(card, &local_err);
-        if (local_err != NULL) {
-            error_propagate(errp, local_err);
-            return;
-        }
+        cc->unrealize(card);
     }
     s->card = NULL;
 }
diff --git a/hw/usb/dev-uas.c b/hw/usb/dev-uas.c
index 11a8684cc2..a3a4d41c07 100644
--- a/hw/usb/dev-uas.c
+++ b/hw/usb/dev-uas.c
@@ -894,7 +894,7 @@ static void usb_uas_handle_data(USBDevice *dev, USBPacket *p)
     }
 }
 
-static void usb_uas_unrealize(USBDevice *dev, Error **errp)
+static void usb_uas_unrealize(USBDevice *dev)
 {
     UASDevice *uas = USB_UAS(dev);
 
diff --git a/hw/usb/dev-wacom.c b/hw/usb/dev-wacom.c
index 8ed57b3b44..8aba44b8bc 100644
--- a/hw/usb/dev-wacom.c
+++ b/hw/usb/dev-wacom.c
@@ -331,7 +331,7 @@ static void usb_wacom_handle_data(USBDevice *dev, USBPacket *p)
     }
 }
 
-static void usb_wacom_unrealize(USBDevice *dev, Error **errp)
+static void usb_wacom_unrealize(USBDevice *dev)
 {
     USBWacomState *s = (USBWacomState *) dev;
 
diff --git a/hw/usb/hcd-ehci-pci.c b/hw/usb/hcd-ehci-pci.c
index fc73a054c6..4c37c8e227 100644
--- a/hw/usb/hcd-ehci-pci.c
+++ b/hw/usb/hcd-ehci-pci.c
@@ -105,7 +105,7 @@ static void usb_ehci_pci_exit(PCIDevice *dev)
     EHCIPCIState *i = PCI_EHCI(dev);
     EHCIState *s = &i->ehci;
 
-    usb_ehci_unrealize(s, DEVICE(dev), NULL);
+    usb_ehci_unrealize(s, DEVICE(dev));
 
     g_free(s->irq);
     s->irq = NULL;
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
index 29d49c2d7e..1495e8f7fa 100644
--- a/hw/usb/hcd-ehci.c
+++ b/hw/usb/hcd-ehci.c
@@ -2522,7 +2522,7 @@ void usb_ehci_realize(EHCIState *s, DeviceState *dev, Error **errp)
     s->vmstate = qemu_add_vm_change_state_handler(usb_ehci_vm_state_change, s);
 }
 
-void usb_ehci_unrealize(EHCIState *s, DeviceState *dev, Error **errp)
+void usb_ehci_unrealize(EHCIState *s, DeviceState *dev)
 {
     trace_usb_ehci_unrealize();
 
diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
index 78a5c2ba55..e28441379d 100644
--- a/hw/usb/host-libusb.c
+++ b/hw/usb/host-libusb.c
@@ -1104,7 +1104,7 @@ static void usb_host_instance_init(Object *obj)
                                   &udev->qdev);
 }
 
-static void usb_host_unrealize(USBDevice *udev, Error **errp)
+static void usb_host_unrealize(USBDevice *udev)
 {
     USBHostDevice *s = USB_HOST_DEVICE(udev);
 
diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index e9a97feaed..417a60a2e6 100644
--- a/hw/usb/redirect.c
+++ b/hw/usb/redirect.c
@@ -1468,7 +1468,7 @@ static void usbredir_cleanup_device_queues(USBRedirDevice *dev)
     }
 }
 
-static void usbredir_unrealize(USBDevice *udev, Error **errp)
+static void usbredir_unrealize(USBDevice *udev)
 {
     USBRedirDevice *dev = USB_REDIRECT(udev);
 
diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index 8649ac15f9..95564c17ed 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -124,7 +124,7 @@ out_get_dev_err:
     vfio_put_group(vfio_group);
 }
 
-static void vfio_ap_unrealize(DeviceState *dev, Error **errp)
+static void vfio_ap_unrealize(DeviceState *dev)
 {
     APDevice *apdev = AP_DEVICE(dev);
     VFIOAPDevice *vapdev = VFIO_AP_DEVICE(apdev);
diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 50cc2ec75c..c8624943c1 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -521,13 +521,13 @@ out_device_err:
     vfio_put_group(group);
 out_group_err:
     if (cdc->unrealize) {
-        cdc->unrealize(cdev, NULL);
+        cdc->unrealize(cdev);
     }
 out_err_propagate:
     error_propagate(errp, err);
 }
 
-static void vfio_ccw_unrealize(DeviceState *dev, Error **errp)
+static void vfio_ccw_unrealize(DeviceState *dev)
 {
     CcwDevice *ccw_dev = DO_UPCAST(CcwDevice, parent_obj, dev);
     S390CCWDevice *cdev = DO_UPCAST(S390CCWDevice, parent_obj, ccw_dev);
@@ -541,7 +541,7 @@ static void vfio_ccw_unrealize(DeviceState *dev, Error **errp)
     vfio_put_group(group);
 
     if (cdc->unrealize) {
-        cdc->unrealize(cdev, errp);
+        cdc->unrealize(cdev);
     }
 }
 
diff --git a/hw/virtio/vhost-user-fs.c b/hw/virtio/vhost-user-fs.c
index 6136768875..1bc5d03a00 100644
--- a/hw/virtio/vhost-user-fs.c
+++ b/hw/virtio/vhost-user-fs.c
@@ -241,7 +241,7 @@ err_virtio:
     return;
 }
 
-static void vuf_device_unrealize(DeviceState *dev, Error **errp)
+static void vuf_device_unrealize(DeviceState *dev)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VHostUserFS *fs = VHOST_USER_FS(dev);
diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
index 09b6b07f94..4a228f5168 100644
--- a/hw/virtio/vhost-vsock.c
+++ b/hw/virtio/vhost-vsock.c
@@ -377,7 +377,7 @@ err_virtio:
     return;
 }
 
-static void vhost_vsock_device_unrealize(DeviceState *dev, Error **errp)
+static void vhost_vsock_device_unrealize(DeviceState *dev)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VHostVSock *vsock = VHOST_VSOCK(dev);
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 6d3ddf6449..065cd450f1 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -819,7 +819,7 @@ static void virtio_balloon_device_realize(DeviceState *dev, Error **errp)
     reset_stats(s);
 }
 
-static void virtio_balloon_device_unrealize(DeviceState *dev, Error **errp)
+static void virtio_balloon_device_unrealize(DeviceState *dev)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VirtIOBalloon *s = VIRTIO_BALLOON(dev);
diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
index 4c65114de5..bd9165c565 100644
--- a/hw/virtio/virtio-crypto.c
+++ b/hw/virtio/virtio-crypto.c
@@ -822,7 +822,7 @@ static void virtio_crypto_device_realize(DeviceState *dev, Error **errp)
     cryptodev_backend_set_used(vcrypto->cryptodev, true);
 }
 
-static void virtio_crypto_device_unrealize(DeviceState *dev, Error **errp)
+static void virtio_crypto_device_unrealize(DeviceState *dev)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VirtIOCrypto *vcrypto = VIRTIO_CRYPTO(dev);
diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 22ba8848c2..483883ec1d 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -688,7 +688,7 @@ static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
     }
 }
 
-static void virtio_iommu_device_unrealize(DeviceState *dev, Error **errp)
+static void virtio_iommu_device_unrealize(DeviceState *dev)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VirtIOIOMMU *s = VIRTIO_IOMMU(dev);
diff --git a/hw/virtio/virtio-pmem.c b/hw/virtio/virtio-pmem.c
index 43399522f5..c3374b2f3f 100644
--- a/hw/virtio/virtio-pmem.c
+++ b/hw/virtio/virtio-pmem.c
@@ -124,7 +124,7 @@ static void virtio_pmem_realize(DeviceState *dev, Error **errp)
     pmem->rq_vq = virtio_add_queue(vdev, 128, virtio_pmem_flush);
 }
 
-static void virtio_pmem_unrealize(DeviceState *dev, Error **errp)
+static void virtio_pmem_unrealize(DeviceState *dev)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VirtIOPMEM *pmem = VIRTIO_PMEM(dev);
diff --git a/hw/virtio/virtio-rng.c b/hw/virtio/virtio-rng.c
index 672619c780..a8df41b11b 100644
--- a/hw/virtio/virtio-rng.c
+++ b/hw/virtio/virtio-rng.c
@@ -230,7 +230,7 @@ static void virtio_rng_device_realize(DeviceState *dev, Error **errp)
                                                      vrng);
 }
 
-static void virtio_rng_device_unrealize(DeviceState *dev, Error **errp)
+static void virtio_rng_device_unrealize(DeviceState *dev)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VirtIORNG *vrng = VIRTIO_RNG(dev);
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index b6c8ef5bc0..850fcce5e7 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3622,7 +3622,7 @@ static void virtio_device_realize(DeviceState *dev, Error **errp)
     virtio_bus_device_plugged(vdev, &err);
     if (err != NULL) {
         error_propagate(errp, err);
-        vdc->unrealize(dev, NULL);
+        vdc->unrealize(dev);
         return;
     }
 
@@ -3630,20 +3630,15 @@ static void virtio_device_realize(DeviceState *dev, Error **errp)
     memory_listener_register(&vdev->listener, vdev->dma_as);
 }
 
-static void virtio_device_unrealize(DeviceState *dev, Error **errp)
+static void virtio_device_unrealize(DeviceState *dev)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(dev);
-    Error *err = NULL;
 
     virtio_bus_device_unplugged(vdev);
 
     if (vdc->unrealize != NULL) {
-        vdc->unrealize(dev, &err);
-        if (err != NULL) {
-            error_propagate(errp, err);
-            return;
-        }
+        vdc->unrealize(dev);
     }
 
     g_free(vdev->bus_name);
diff --git a/hw/watchdog/wdt_diag288.c b/hw/watchdog/wdt_diag288.c
index 5b6eb2b09f..71a945f0bd 100644
--- a/hw/watchdog/wdt_diag288.c
+++ b/hw/watchdog/wdt_diag288.c
@@ -108,7 +108,7 @@ static void wdt_diag288_realize(DeviceState *dev, Error **errp)
                                   dev);
 }
 
-static void wdt_diag288_unrealize(DeviceState *dev, Error **errp)
+static void wdt_diag288_unrealize(DeviceState *dev)
 {
     DIAG288State *diag288 = DIAG288(dev);
 
diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
index 18237b34ea..32dd4461be 100644
--- a/hw/xen/xen-bus.c
+++ b/hw/xen/xen-bus.c
@@ -428,7 +428,7 @@ static void xen_bus_backend_changed(void *opaque)
     xen_bus_cleanup(xenbus);
 }
 
-static void xen_bus_unrealize(BusState *bus, Error **errp)
+static void xen_bus_unrealize(BusState *bus)
 {
     XenBus *xenbus = XEN_BUS(bus);
 
@@ -486,7 +486,7 @@ static void xen_bus_realize(BusState *bus, Error **errp)
     return;
 
 fail:
-    xen_bus_unrealize(bus, &error_abort);
+    xen_bus_unrealize(bus);
 }
 
 static void xen_bus_unplug_request(HotplugHandler *hotplug,
@@ -1189,7 +1189,7 @@ void xen_device_unbind_event_channel(XenDevice *xendev,
     g_free(channel);
 }
 
-static void xen_device_unrealize(DeviceState *dev, Error **errp)
+static void xen_device_unrealize(DeviceState *dev)
 {
     XenDevice *xendev = XEN_DEVICE(dev);
     XenDeviceClass *xendev_class = XEN_DEVICE_GET_CLASS(xendev);
@@ -1208,7 +1208,7 @@ static void xen_device_unrealize(DeviceState *dev, Error **errp)
     }
 
     if (xendev_class->unrealize) {
-        xendev_class->unrealize(xendev, errp);
+        xendev_class->unrealize(xendev);
     }
 
     /* Make sure all event channels are cleaned up */
@@ -1242,7 +1242,7 @@ static void xen_device_exit(Notifier *n, void *data)
 {
     XenDevice *xendev = container_of(n, XenDevice, exit);
 
-    xen_device_unrealize(DEVICE(xendev), &error_abort);
+    xen_device_unrealize(DEVICE(xendev));
 }
 
 static void xen_device_realize(DeviceState *dev, Error **errp)
@@ -1336,7 +1336,7 @@ static void xen_device_realize(DeviceState *dev, Error **errp)
     return;
 
 unrealize:
-    xen_device_unrealize(dev, &error_abort);
+    xen_device_unrealize(dev);
 }
 
 static Property xen_device_props[] = {
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 6a64d2a5cd..7a4a8e3847 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6722,11 +6722,10 @@ out:
     }
 }
 
-static void x86_cpu_unrealizefn(DeviceState *dev, Error **errp)
+static void x86_cpu_unrealizefn(DeviceState *dev)
 {
     X86CPU *cpu = X86_CPU(dev);
     X86CPUClass *xcc = X86_CPU_GET_CLASS(dev);
-    Error *local_err = NULL;
 
 #ifndef CONFIG_USER_ONLY
     cpu_remove_sync(CPU(dev));
@@ -6738,11 +6737,7 @@ static void x86_cpu_unrealizefn(DeviceState *dev, Error **errp)
         cpu->apic_state = NULL;
     }
 
-    xcc->parent_unrealize(dev, &local_err);
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
-        return;
-    }
+    xcc->parent_unrealize(dev);
 }
 
 typedef struct BitProperty {
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
index 2b6e832c4c..d8adc1bd49 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -10293,19 +10293,14 @@ unrealize:
     cpu_exec_unrealizefn(cs);
 }
 
-static void ppc_cpu_unrealize(DeviceState *dev, Error **errp)
+static void ppc_cpu_unrealize(DeviceState *dev)
 {
     PowerPCCPU *cpu = POWERPC_CPU(dev);
     PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
-    Error *local_err = NULL;
     opc_handler_t **table, **table_2;
     int i, j, k;
 
-    pcc->parent_unrealize(dev, &local_err);
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
-        return;
-    }
+    pcc->parent_unrealize(dev);
 
     for (i = 0; i < PPC_CPU_OPCODES_LEN; i++) {
         if (cpu->opcodes[i] == &invalid_handler) {
-- 
2.21.1


