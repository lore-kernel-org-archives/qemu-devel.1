Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32110C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 13:51:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFDC120836
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 13:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EUr2kW0h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFDC120836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if2OR-0005iu-SC
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 08:51:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54152)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1if2JQ-0000hD-T5
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 08:45:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1if2JM-00034R-U8
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 08:45:55 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49485
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1if2JM-00032I-Oj
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 08:45:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576071950;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YovsefqkDCb88PowQRGU4k8V5ag/mFw+4KdGkVx8ejg=;
 b=EUr2kW0hpPwuxPwnv+tvOuRKQgELESgZ54mrj7+Zip7ymulVAbLjrnkfmrfcyN3PicHjoq
 wb61ClbSzgDKdIItF9nF2R9vuEV4tOrQizMmuVqcL3jt6U9q0rodmOh2EVVuno7TIBQhy6
 gixum/Jb6bhR5IRVPS4BFZe01kMsEzk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-B4qyxb_tN_iFdrQxka6Lkw-1; Wed, 11 Dec 2019 08:45:44 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B6038A2D81
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 13:45:43 +0000 (UTC)
Received: from localhost (ovpn-112-63.ams2.redhat.com [10.36.112.63])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9F348166A9;
 Wed, 11 Dec 2019 13:45:36 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 2/8] vmstate: replace DeviceState with VMStateIf
Date: Wed, 11 Dec 2019 17:45:00 +0400
Message-Id: <20191211134506.1803403-3-marcandre.lureau@redhat.com>
In-Reply-To: <20191211134506.1803403-1-marcandre.lureau@redhat.com>
References: <20191211134506.1803403-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: B4qyxb_tN_iFdrQxka6Lkw-1
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
Cc: berrange@redhat.com, quintela@redhat.com, mprivozn@redhat.com,
 dgilbert@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Replace DeviceState dependency with VMStateIf on vmstate API.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Acked-by: Halil Pasic <pasic@linux.ibm.com>
---
 hw/block/onenand.c           |  2 +-
 hw/core/qdev.c               |  7 ++++---
 hw/ide/cmd646.c              |  2 +-
 hw/ide/isa.c                 |  2 +-
 hw/ide/piix.c                |  2 +-
 hw/ide/via.c                 |  2 +-
 hw/misc/max111x.c            |  2 +-
 hw/net/eepro100.c            |  4 ++--
 hw/net/virtio-net.c          |  3 ++-
 hw/nvram/eeprom93xx.c        |  4 ++--
 hw/ppc/spapr_drc.c           |  9 +++++----
 hw/ppc/spapr_iommu.c         |  4 ++--
 hw/s390x/s390-skeys.c        |  2 +-
 include/migration/register.h |  2 +-
 include/migration/vmstate.h  |  8 ++++----
 migration/savevm.c           | 20 ++++++++++----------
 stubs/vmstate.c              |  4 ++--
 17 files changed, 41 insertions(+), 38 deletions(-)

diff --git a/hw/block/onenand.c b/hw/block/onenand.c
index fcc5a69b90..9c233c12e4 100644
--- a/hw/block/onenand.c
+++ b/hw/block/onenand.c
@@ -822,7 +822,7 @@ static void onenand_realize(DeviceState *dev, Error **e=
rrp)
     onenand_mem_setup(s);
     sysbus_init_irq(sbd, &s->intr);
     sysbus_init_mmio(sbd, &s->container);
-    vmstate_register(dev,
+    vmstate_register(VMSTATE_IF(dev),
                      ((s->shift & 0x7f) << 24)
                      | ((s->id.man & 0xff) << 16)
                      | ((s->id.dev & 0xff) << 8)
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index add43d460e..fadc01f622 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -890,7 +890,8 @@ static void device_set_realized(Object *obj, bool value=
, Error **errp)
         dev->canonical_path =3D object_get_canonical_path(OBJECT(dev));
=20
         if (qdev_get_vmsd(dev)) {
-            if (vmstate_register_with_alias_id(dev, -1, qdev_get_vmsd(dev)=
, dev,
+            if (vmstate_register_with_alias_id(VMSTATE_IF(dev),
+                                               -1, qdev_get_vmsd(dev), dev=
,
                                                dev->instance_id_alias,
                                                dev->alias_required_for_ver=
sion,
                                                &local_err) < 0) {
@@ -925,7 +926,7 @@ static void device_set_realized(Object *obj, bool value=
, Error **errp)
                                      local_errp);
         }
         if (qdev_get_vmsd(dev)) {
-            vmstate_unregister(dev, qdev_get_vmsd(dev), dev);
+            vmstate_unregister(VMSTATE_IF(dev), qdev_get_vmsd(dev), dev);
         }
         if (dc->unrealize) {
             local_errp =3D local_err ? NULL : &local_err;
@@ -949,7 +950,7 @@ child_realize_fail:
     }
=20
     if (qdev_get_vmsd(dev)) {
-        vmstate_unregister(dev, qdev_get_vmsd(dev), dev);
+        vmstate_unregister(VMSTATE_IF(dev), qdev_get_vmsd(dev), dev);
     }
=20
 post_realize_fail:
diff --git a/hw/ide/cmd646.c b/hw/ide/cmd646.c
index 19984d2af9..3f9be968d1 100644
--- a/hw/ide/cmd646.c
+++ b/hw/ide/cmd646.c
@@ -302,7 +302,7 @@ static void pci_cmd646_ide_realize(PCIDevice *dev, Erro=
r **errp)
     }
     g_free(irq);
=20
-    vmstate_register(DEVICE(dev), 0, &vmstate_ide_pci, d);
+    vmstate_register(VMSTATE_IF(dev), 0, &vmstate_ide_pci, d);
     qemu_register_reset(cmd646_reset, d);
 }
=20
diff --git a/hw/ide/isa.c b/hw/ide/isa.c
index 7b6e283679..9c7f88b2d5 100644
--- a/hw/ide/isa.c
+++ b/hw/ide/isa.c
@@ -75,7 +75,7 @@ static void isa_ide_realizefn(DeviceState *dev, Error **e=
rrp)
     ide_init_ioport(&s->bus, isadev, s->iobase, s->iobase2);
     isa_init_irq(isadev, &s->irq, s->isairq);
     ide_init2(&s->bus, s->irq);
-    vmstate_register(dev, 0, &vmstate_ide_isa, s);
+    vmstate_register(VMSTATE_IF(dev), 0, &vmstate_ide_isa, s);
     ide_register_restart_cb(&s->bus);
 }
=20
diff --git a/hw/ide/piix.c b/hw/ide/piix.c
index db313dd3b1..bc575b4d70 100644
--- a/hw/ide/piix.c
+++ b/hw/ide/piix.c
@@ -156,7 +156,7 @@ static void pci_piix_ide_realize(PCIDevice *dev, Error =
**errp)
     bmdma_setup_bar(d);
     pci_register_bar(dev, 4, PCI_BASE_ADDRESS_SPACE_IO, &d->bmdma_bar);
=20
-    vmstate_register(DEVICE(dev), 0, &vmstate_ide_pci, d);
+    vmstate_register(VMSTATE_IF(dev), 0, &vmstate_ide_pci, d);
=20
     pci_piix_init_ports(d);
 }
diff --git a/hw/ide/via.c b/hw/ide/via.c
index 053622bd82..096de8dba0 100644
--- a/hw/ide/via.c
+++ b/hw/ide/via.c
@@ -190,7 +190,7 @@ static void via_ide_realize(PCIDevice *dev, Error **err=
p)
     bmdma_setup_bar(d);
     pci_register_bar(dev, 4, PCI_BASE_ADDRESS_SPACE_IO, &d->bmdma_bar);
=20
-    vmstate_register(DEVICE(dev), 0, &vmstate_ide_pci, d);
+    vmstate_register(VMSTATE_IF(dev), 0, &vmstate_ide_pci, d);
=20
     for (i =3D 0; i < 2; i++) {
         ide_bus_new(&d->bus[i], sizeof(d->bus[i]), DEVICE(d), i, 2);
diff --git a/hw/misc/max111x.c b/hw/misc/max111x.c
index a713149f16..211008ce02 100644
--- a/hw/misc/max111x.c
+++ b/hw/misc/max111x.c
@@ -146,7 +146,7 @@ static int max111x_init(SSISlave *d, int inputs)
     s->input[7] =3D 0x80;
     s->com =3D 0;
=20
-    vmstate_register(dev, -1, &vmstate_max111x, s);
+    vmstate_register(VMSTATE_IF(dev), -1, &vmstate_max111x, s);
     return 0;
 }
=20
diff --git a/hw/net/eepro100.c b/hw/net/eepro100.c
index cc2dd8b1c9..cc71a7a036 100644
--- a/hw/net/eepro100.c
+++ b/hw/net/eepro100.c
@@ -1815,7 +1815,7 @@ static void pci_nic_uninit(PCIDevice *pci_dev)
 {
     EEPRO100State *s =3D DO_UPCAST(EEPRO100State, dev, pci_dev);
=20
-    vmstate_unregister(&pci_dev->qdev, s->vmstate, s);
+    vmstate_unregister(VMSTATE_IF(&pci_dev->qdev), s->vmstate, s);
     g_free(s->vmstate);
     eeprom93xx_free(&pci_dev->qdev, s->eeprom);
     qemu_del_nic(s->nic);
@@ -1874,7 +1874,7 @@ static void e100_nic_realize(PCIDevice *pci_dev, Erro=
r **errp)
=20
     s->vmstate =3D g_memdup(&vmstate_eepro100, sizeof(vmstate_eepro100));
     s->vmstate->name =3D qemu_get_queue(s->nic)->model;
-    vmstate_register(&pci_dev->qdev, -1, s->vmstate, s);
+    vmstate_register(VMSTATE_IF(&pci_dev->qdev), -1, s->vmstate, s);
 }
=20
 static void eepro100_instance_init(Object *obj)
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index db3d7c38e6..777d62d3c8 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -2853,7 +2853,8 @@ static void virtio_net_handle_migration_primary(VirtI=
ONet *n,
=20
     if (migration_in_setup(s) && !should_be_hidden) {
         if (failover_unplug_primary(n)) {
-            vmstate_unregister(n->primary_dev, qdev_get_vmsd(n->primary_de=
v),
+            vmstate_unregister(VMSTATE_IF(n->primary_dev),
+                    qdev_get_vmsd(n->primary_dev),
                     n->primary_dev);
             qapi_event_send_unplug_primary(n->primary_device_id);
             atomic_set(&n->primary_should_be_hidden, true);
diff --git a/hw/nvram/eeprom93xx.c b/hw/nvram/eeprom93xx.c
index 5b01b9b03f..07f09549ed 100644
--- a/hw/nvram/eeprom93xx.c
+++ b/hw/nvram/eeprom93xx.c
@@ -321,7 +321,7 @@ eeprom_t *eeprom93xx_new(DeviceState *dev, uint16_t nwo=
rds)
     /* Output DO is tristate, read results in 1. */
     eeprom->eedo =3D 1;
     logout("eeprom =3D 0x%p, nwords =3D %u\n", eeprom, nwords);
-    vmstate_register(dev, 0, &vmstate_eeprom, eeprom);
+    vmstate_register(VMSTATE_IF(dev), 0, &vmstate_eeprom, eeprom);
     return eeprom;
 }
=20
@@ -329,7 +329,7 @@ void eeprom93xx_free(DeviceState *dev, eeprom_t *eeprom=
)
 {
     /* Destroy EEPROM. */
     logout("eeprom =3D 0x%p\n", eeprom);
-    vmstate_unregister(dev, &vmstate_eeprom, eeprom);
+    vmstate_unregister(VMSTATE_IF(dev), &vmstate_eeprom, eeprom);
     g_free(eeprom);
 }
=20
diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 62f1a42592..17aeac3801 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -511,7 +511,7 @@ static void realize(DeviceState *d, Error **errp)
         error_propagate(errp, err);
         return;
     }
-    vmstate_register(DEVICE(drc), spapr_drc_index(drc), &vmstate_spapr_drc=
,
+    vmstate_register(VMSTATE_IF(drc), spapr_drc_index(drc), &vmstate_spapr=
_drc,
                      drc);
     trace_spapr_drc_realize_complete(spapr_drc_index(drc));
 }
@@ -523,7 +523,7 @@ static void unrealize(DeviceState *d, Error **errp)
     gchar *name;
=20
     trace_spapr_drc_unrealize(spapr_drc_index(drc));
-    vmstate_unregister(DEVICE(drc), &vmstate_spapr_drc, drc);
+    vmstate_unregister(VMSTATE_IF(drc), &vmstate_spapr_drc, drc);
     root_container =3D container_get(object_get_root(), DRC_CONTAINER_PATH=
);
     name =3D g_strdup_printf("%x", spapr_drc_index(drc));
     object_property_del(root_container, name, errp);
@@ -619,7 +619,8 @@ static void realize_physical(DeviceState *d, Error **er=
rp)
         return;
     }
=20
-    vmstate_register(DEVICE(drcp), spapr_drc_index(SPAPR_DR_CONNECTOR(drcp=
)),
+    vmstate_register(VMSTATE_IF(drcp),
+                     spapr_drc_index(SPAPR_DR_CONNECTOR(drcp)),
                      &vmstate_spapr_drc_physical, drcp);
     qemu_register_reset(drc_physical_reset, drcp);
 }
@@ -635,7 +636,7 @@ static void unrealize_physical(DeviceState *d, Error **=
errp)
         return;
     }
=20
-    vmstate_unregister(DEVICE(drcp), &vmstate_spapr_drc_physical, drcp);
+    vmstate_unregister(VMSTATE_IF(drcp), &vmstate_spapr_drc_physical, drcp=
);
     qemu_unregister_reset(drc_physical_reset, drcp);
 }
=20
diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
index 3d3bcc8649..5704fe6051 100644
--- a/hw/ppc/spapr_iommu.c
+++ b/hw/ppc/spapr_iommu.c
@@ -317,7 +317,7 @@ static void spapr_tce_table_realize(DeviceState *dev, E=
rror **errp)
=20
     QLIST_INSERT_HEAD(&spapr_tce_tables, tcet, list);
=20
-    vmstate_register(DEVICE(tcet), tcet->liobn, &vmstate_spapr_tce_table,
+    vmstate_register(VMSTATE_IF(tcet), tcet->liobn, &vmstate_spapr_tce_tab=
le,
                      tcet);
 }
=20
@@ -420,7 +420,7 @@ static void spapr_tce_table_unrealize(DeviceState *dev,=
 Error **errp)
 {
     SpaprTceTable *tcet =3D SPAPR_TCE_TABLE(dev);
=20
-    vmstate_unregister(DEVICE(tcet), &vmstate_spapr_tce_table, tcet);
+    vmstate_unregister(VMSTATE_IF(tcet), &vmstate_spapr_tce_table, tcet);
=20
     QLIST_REMOVE(tcet, list);
=20
diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
index bd37f39120..5da6e5292f 100644
--- a/hw/s390x/s390-skeys.c
+++ b/hw/s390x/s390-skeys.c
@@ -392,7 +392,7 @@ static inline void s390_skeys_set_migration_enabled(Obj=
ect *obj, bool value,
         register_savevm_live(TYPE_S390_SKEYS, 0, 1,
                              &savevm_s390_storage_keys, ss);
     } else {
-        unregister_savevm(DEVICE(ss), TYPE_S390_SKEYS, ss);
+        unregister_savevm(VMSTATE_IF(ss), TYPE_S390_SKEYS, ss);
     }
 }
=20
diff --git a/include/migration/register.h b/include/migration/register.h
index 73149c9a01..00c38ebe9f 100644
--- a/include/migration/register.h
+++ b/include/migration/register.h
@@ -76,6 +76,6 @@ int register_savevm_live(const char *idstr,
                          const SaveVMHandlers *ops,
                          void *opaque);
=20
-void unregister_savevm(DeviceState *dev, const char *idstr, void *opaque);
+void unregister_savevm(VMStateIf *obj, const char *idstr, void *opaque);
=20
 #endif
diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index f546f61c5e..4aef72c426 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -1158,22 +1158,22 @@ int vmstate_save_state_v(QEMUFile *f, const VMState=
Description *vmsd,
 bool vmstate_save_needed(const VMStateDescription *vmsd, void *opaque);
=20
 /* Returns: 0 on success, -1 on failure */
-int vmstate_register_with_alias_id(DeviceState *dev, int instance_id,
+int vmstate_register_with_alias_id(VMStateIf *obj, int instance_id,
                                    const VMStateDescription *vmsd,
                                    void *base, int alias_id,
                                    int required_for_version,
                                    Error **errp);
=20
 /* Returns: 0 on success, -1 on failure */
-static inline int vmstate_register(DeviceState *dev, int instance_id,
+static inline int vmstate_register(VMStateIf *obj, int instance_id,
                                    const VMStateDescription *vmsd,
                                    void *opaque)
 {
-    return vmstate_register_with_alias_id(dev, instance_id, vmsd,
+    return vmstate_register_with_alias_id(obj, instance_id, vmsd,
                                           opaque, -1, 0, NULL);
 }
=20
-void vmstate_unregister(DeviceState *dev, const VMStateDescription *vmsd,
+void vmstate_unregister(VMStateIf *obj, const VMStateDescription *vmsd,
                         void *opaque);
=20
 struct MemoryRegion;
diff --git a/migration/savevm.c b/migration/savevm.c
index a71b930b91..59efc1981d 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -760,17 +760,17 @@ int register_savevm_live(const char *idstr,
     return 0;
 }
=20
-void unregister_savevm(DeviceState *dev, const char *idstr, void *opaque)
+void unregister_savevm(VMStateIf *obj, const char *idstr, void *opaque)
 {
     SaveStateEntry *se, *new_se;
     char id[256] =3D "";
=20
-    if (dev) {
-        char *path =3D qdev_get_dev_path(dev);
-        if (path) {
-            pstrcpy(id, sizeof(id), path);
+    if (obj) {
+        char *oid =3D vmstate_if_get_id(obj);
+        if (oid) {
+            pstrcpy(id, sizeof(id), oid);
             pstrcat(id, sizeof(id), "/");
-            g_free(path);
+            g_free(oid);
         }
     }
     pstrcat(id, sizeof(id), idstr);
@@ -784,7 +784,7 @@ void unregister_savevm(DeviceState *dev, const char *id=
str, void *opaque)
     }
 }
=20
-int vmstate_register_with_alias_id(DeviceState *dev, int instance_id,
+int vmstate_register_with_alias_id(VMStateIf *obj, int instance_id,
                                    const VMStateDescription *vmsd,
                                    void *opaque, int alias_id,
                                    int required_for_version,
@@ -802,8 +802,8 @@ int vmstate_register_with_alias_id(DeviceState *dev, in=
t instance_id,
     se->vmsd =3D vmsd;
     se->alias_id =3D alias_id;
=20
-    if (dev) {
-        char *id =3D qdev_get_dev_path(dev);
+    if (obj) {
+        char *id =3D vmstate_if_get_id(obj);
         if (id) {
             if (snprintf(se->idstr, sizeof(se->idstr), "%s/", id) >=3D
                 sizeof(se->idstr)) {
@@ -834,7 +834,7 @@ int vmstate_register_with_alias_id(DeviceState *dev, in=
t instance_id,
     return 0;
 }
=20
-void vmstate_unregister(DeviceState *dev, const VMStateDescription *vmsd,
+void vmstate_unregister(VMStateIf *obj, const VMStateDescription *vmsd,
                         void *opaque)
 {
     SaveStateEntry *se, *new_se;
diff --git a/stubs/vmstate.c b/stubs/vmstate.c
index e1e89b87f0..6951d9fdc5 100644
--- a/stubs/vmstate.c
+++ b/stubs/vmstate.c
@@ -3,7 +3,7 @@
=20
 const VMStateDescription vmstate_dummy =3D {};
=20
-int vmstate_register_with_alias_id(DeviceState *dev,
+int vmstate_register_with_alias_id(VMStateIf *obj,
                                    int instance_id,
                                    const VMStateDescription *vmsd,
                                    void *base, int alias_id,
@@ -13,7 +13,7 @@ int vmstate_register_with_alias_id(DeviceState *dev,
     return 0;
 }
=20
-void vmstate_unregister(DeviceState *dev,
+void vmstate_unregister(VMStateIf *obj,
                         const VMStateDescription *vmsd,
                         void *opaque)
 {
--=20
2.24.0.308.g228f53135a


