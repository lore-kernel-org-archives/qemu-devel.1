Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C128CC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 06:18:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77FF7206F4
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 06:18:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KAxbUhVk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77FF7206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZTfe-0007Pp-LJ
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 02:18:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55930)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jZTSW-00039N-HU
 for qemu-devel@nongnu.org; Fri, 15 May 2020 02:04:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53386
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jZTSS-0004R1-Gp
 for qemu-devel@nongnu.org; Fri, 15 May 2020 02:04:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589522671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h/qykU8iCadwT7p47noufadIr1VjHyZ8u1lFyNssLo8=;
 b=KAxbUhVkVs1I0TXaQQ8bIusNGNNnbPK3Lhuo1XtbualVKIEeAfQJWD2nGy4Xagy2yercM6
 SCIFE2GTlNChBvaIX3Z9Skppx3md0u3hAqLdcvHwx8+cPcC6PBQ+c3O7PHBuLFGIuwNJhV
 vbN7342VMmUp8FyMV82lhiAVeCp3gjY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-ANngyTouOEiDOX1AX0H5FQ-1; Fri, 15 May 2020 02:04:30 -0400
X-MC-Unique: ANngyTouOEiDOX1AX0H5FQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2DE4580183C
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 06:04:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A33221001920;
 Fri, 15 May 2020 06:04:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5EF1111358CC; Fri, 15 May 2020 08:04:24 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 15/21] Drop more @errp parameters after previous commit
Date: Fri, 15 May 2020 08:04:18 +0200
Message-Id: <20200515060424.18993-16-armbru@redhat.com>
In-Reply-To: <20200515060424.18993-1-armbru@redhat.com>
References: <20200515060424.18993-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 23:27:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Several functions can't fail anymore: ich9_pm_add_properties(),
device_add_bootindex_property(), ppc_compat_add_property(),
spapr_caps_add_properties(), PropertyInfo.create().  Drop their @errp
parameter.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20200505152926.18877-16-armbru@redhat.com>
---
 include/hw/acpi/ich9.h    | 2 +-
 include/hw/ppc/spapr.h    | 2 +-
 include/hw/qdev-core.h    | 2 +-
 include/sysemu/sysemu.h   | 2 +-
 target/ppc/cpu.h          | 3 +--
 bootdevice.c              | 2 +-
 hw/acpi/ich9.c            | 2 +-
 hw/block/fdc.c            | 4 ++--
 hw/block/nvme.c           | 2 +-
 hw/block/vhost-user-blk.c | 2 +-
 hw/block/virtio-blk.c     | 2 +-
 hw/core/qdev-properties.c | 2 +-
 hw/core/qdev.c            | 2 +-
 hw/isa/lpc_ich9.c         | 2 +-
 hw/net/e1000.c            | 2 +-
 hw/net/e1000e.c           | 2 +-
 hw/net/eepro100.c         | 2 +-
 hw/net/lance.c            | 2 +-
 hw/net/lasi_i82596.c      | 2 +-
 hw/net/ne2000-pci.c       | 2 +-
 hw/net/pcnet-pci.c        | 2 +-
 hw/net/rtl8139.c          | 2 +-
 hw/net/spapr_llan.c       | 2 +-
 hw/net/sungem.c           | 2 +-
 hw/net/sunhme.c           | 2 +-
 hw/net/tulip.c            | 2 +-
 hw/net/virtio-net.c       | 2 +-
 hw/net/vmxnet3.c          | 2 +-
 hw/ppc/spapr.c            | 5 ++---
 hw/ppc/spapr_caps.c       | 2 +-
 hw/s390x/s390-ccw.c       | 2 +-
 hw/scsi/scsi-bus.c        | 2 +-
 hw/scsi/vhost-scsi.c      | 2 +-
 hw/scsi/vhost-user-scsi.c | 2 +-
 hw/usb/dev-network.c      | 2 +-
 hw/usb/host-libusb.c      | 2 +-
 hw/usb/redirect.c         | 2 +-
 hw/vfio/pci.c             | 2 +-
 target/ppc/compat.c       | 3 +--
 39 files changed, 41 insertions(+), 44 deletions(-)

diff --git a/include/hw/acpi/ich9.h b/include/hw/acpi/ich9.h
index 41568d1837..28a53181cb 100644
--- a/include/hw/acpi/ich9.h
+++ b/include/hw/acpi/ich9.h
@@ -72,7 +72,7 @@ void ich9_pm_init(PCIDevice *lpc_pci, ICH9LPCPMRegs *pm,
 void ich9_pm_iospace_update(ICH9LPCPMRegs *pm, uint32_t pm_io_base);
 extern const VMStateDescription vmstate_ich9_pm;
 
-void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm, Error **errp);
+void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm);
 
 void ich9_pm_device_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
                                 Error **errp);
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index e579eaf28c..d2533e7264 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -921,7 +921,7 @@ static inline uint8_t spapr_get_cap(SpaprMachineState *spapr, int cap)
 void spapr_caps_init(SpaprMachineState *spapr);
 void spapr_caps_apply(SpaprMachineState *spapr);
 void spapr_caps_cpu_apply(SpaprMachineState *spapr, PowerPCCPU *cpu);
-void spapr_caps_add_properties(SpaprMachineClass *smc, Error **errp);
+void spapr_caps_add_properties(SpaprMachineClass *smc);
 int spapr_caps_post_migration(SpaprMachineState *spapr);
 
 void spapr_check_pagesize(SpaprMachineState *spapr, hwaddr pagesize,
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index d87d989e72..6f537f687f 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -286,7 +286,7 @@ struct PropertyInfo {
     const QEnumLookup *enum_table;
     int (*print)(DeviceState *dev, Property *prop, char *dest, size_t len);
     void (*set_default_value)(ObjectProperty *op, const Property *prop);
-    void (*create)(ObjectClass *oc, Property *prop, Error **errp);
+    void (*create)(ObjectClass *oc, Property *prop);
     ObjectPropertyAccessor *get;
     ObjectPropertyAccessor *set;
     ObjectPropertyRelease *release;
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index ef81302e1a..26c0c802d1 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -92,7 +92,7 @@ void check_boot_index(int32_t bootindex, Error **errp);
 void del_boot_device_path(DeviceState *dev, const char *suffix);
 void device_add_bootindex_property(Object *obj, int32_t *bootindex,
                                    const char *name, const char *suffix,
-                                   DeviceState *dev, Error **errp);
+                                   DeviceState *dev);
 void restore_boot_order(void *opaque);
 void validate_bootdevices(const char *devices, Error **errp);
 void add_boot_device_lchs(DeviceState *dev, const char *suffix,
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 6b6dd7e483..7db7882f52 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1338,8 +1338,7 @@ void ppc_set_compat_all(uint32_t compat_pvr, Error **errp);
 #endif
 int ppc_compat_max_vthreads(PowerPCCPU *cpu);
 void ppc_compat_add_property(Object *obj, const char *name,
-                             uint32_t *compat_pvr, const char *basedesc,
-                             Error **errp);
+                             uint32_t *compat_pvr, const char *basedesc);
 #endif /* defined(TARGET_PPC64) */
 
 typedef CPUPPCState CPUArchState;
diff --git a/bootdevice.c b/bootdevice.c
index d11576d575..0ff55e2b79 100644
--- a/bootdevice.c
+++ b/bootdevice.c
@@ -327,7 +327,7 @@ static void property_release_bootindex(Object *obj, const char *name,
 
 void device_add_bootindex_property(Object *obj, int32_t *bootindex,
                                    const char *name, const char *suffix,
-                                   DeviceState *dev, Error **errp)
+                                   DeviceState *dev)
 {
     BootIndexProperty *prop = g_malloc0(sizeof(*prop));
 
diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index 9e4c03bef8..2d204babc6 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -369,7 +369,7 @@ static void ich9_pm_set_enable_tco(Object *obj, bool value, Error **errp)
     s->pm.enable_tco = value;
 }
 
-void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm, Error **errp)
+void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm)
 {
     static const uint32_t gpe0_len = ICH9_PMIO_GPE0_LEN;
     pm->acpi_memory_hotplug.is_enabled = true;
diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index 9628cc171e..c5fb9d6ece 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -2813,10 +2813,10 @@ static void isabus_fdc_instance_init(Object *obj)
 
     device_add_bootindex_property(obj, &isa->bootindexA,
                                   "bootindexA", "/floppy@0",
-                                  DEVICE(obj), NULL);
+                                  DEVICE(obj));
     device_add_bootindex_property(obj, &isa->bootindexB,
                                   "bootindexB", "/floppy@1",
-                                  DEVICE(obj), NULL);
+                                  DEVICE(obj));
 }
 
 static const TypeInfo isa_fdc_info = {
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 9b453423cf..2f3100e56c 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1594,7 +1594,7 @@ static void nvme_instance_init(Object *obj)
 
     device_add_bootindex_property(obj, &s->conf.bootindex,
                                   "bootindex", "/namespace@1,0",
-                                  DEVICE(obj), &error_abort);
+                                  DEVICE(obj));
 }
 
 static const TypeInfo nvme_info = {
diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 6c485d1c9e..5263e0c9ad 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -481,7 +481,7 @@ static void vhost_user_blk_instance_init(Object *obj)
     VHostUserBlk *s = VHOST_USER_BLK(obj);
 
     device_add_bootindex_property(obj, &s->bootindex, "bootindex",
-                                  "/disk@0,0", DEVICE(obj), NULL);
+                                  "/disk@0,0", DEVICE(obj));
 }
 
 static const VMStateDescription vmstate_vhost_user_blk = {
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 97ba8a2187..fb32717a12 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1248,7 +1248,7 @@ static void virtio_blk_instance_init(Object *obj)
 
     device_add_bootindex_property(obj, &s->conf.conf.bootindex,
                                   "bootindex", "/disk@0,0",
-                                  DEVICE(obj), NULL);
+                                  DEVICE(obj));
 }
 
 static const VMStateDescription vmstate_virtio_blk = {
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 2f294ec4a4..cc924815da 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -1250,7 +1250,7 @@ const PropertyInfo qdev_prop_size = {
 
 /* --- object link property --- */
 
-static void create_link_property(ObjectClass *oc, Property *prop, Error **errp)
+static void create_link_property(ObjectClass *oc, Property *prop)
 {
     object_class_property_add_link(oc, prop->name, prop->link_type,
                                    prop->offset,
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 3f91bff712..2afa2562b8 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -782,7 +782,7 @@ static void qdev_class_add_property(DeviceClass *klass, Property *prop)
     ObjectClass *oc = OBJECT_CLASS(klass);
 
     if (prop->info->create) {
-        prop->info->create(oc, prop, &error_abort);
+        prop->info->create(oc, prop);
     } else {
         ObjectProperty *op;
 
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index c975d46675..cd6e169d47 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -639,7 +639,7 @@ static void ich9_lpc_initfn(Object *obj)
     object_property_add_uint8_ptr(OBJECT(lpc), ACPI_PM_PROP_ACPI_DISABLE_CMD,
                                   &acpi_disable_cmd, OBJ_PROP_FLAG_READ);
 
-    ich9_pm_add_properties(obj, &lpc->pm, NULL);
+    ich9_pm_add_properties(obj, &lpc->pm);
 }
 
 static void ich9_lpc_realize(PCIDevice *d, Error **errp)
diff --git a/hw/net/e1000.c b/hw/net/e1000.c
index 0d2c2759e3..a18f80e369 100644
--- a/hw/net/e1000.c
+++ b/hw/net/e1000.c
@@ -1774,7 +1774,7 @@ static void e1000_instance_init(Object *obj)
     E1000State *n = E1000(obj);
     device_add_bootindex_property(obj, &n->conf.bootindex,
                                   "bootindex", "/ethernet-phy@0",
-                                  DEVICE(n), NULL);
+                                  DEVICE(n));
 }
 
 static const TypeInfo e1000_base_info = {
diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
index 79ba158d41..fda34518c9 100644
--- a/hw/net/e1000e.c
+++ b/hw/net/e1000e.c
@@ -705,7 +705,7 @@ static void e1000e_instance_init(Object *obj)
     E1000EState *s = E1000E(obj);
     device_add_bootindex_property(obj, &s->conf.bootindex,
                                   "bootindex", "/ethernet-phy@0",
-                                  DEVICE(obj), NULL);
+                                  DEVICE(obj));
 }
 
 static const TypeInfo e1000e_info = {
diff --git a/hw/net/eepro100.c b/hw/net/eepro100.c
index f6474f0e68..16e95ef9cc 100644
--- a/hw/net/eepro100.c
+++ b/hw/net/eepro100.c
@@ -1883,7 +1883,7 @@ static void eepro100_instance_init(Object *obj)
     EEPRO100State *s = DO_UPCAST(EEPRO100State, dev, PCI_DEVICE(obj));
     device_add_bootindex_property(obj, &s->conf.bootindex,
                                   "bootindex", "/ethernet-phy@0",
-                                  DEVICE(s), NULL);
+                                  DEVICE(s));
 }
 
 static E100PCIDeviceInfo e100_devices[] = {
diff --git a/hw/net/lance.c b/hw/net/lance.c
index 688724db0b..4c5f01baad 100644
--- a/hw/net/lance.c
+++ b/hw/net/lance.c
@@ -134,7 +134,7 @@ static void lance_instance_init(Object *obj)
 
     device_add_bootindex_property(obj, &s->conf.bootindex,
                                   "bootindex", "/ethernet-phy@0",
-                                  DEVICE(obj), NULL);
+                                  DEVICE(obj));
 }
 
 static Property lance_properties[] = {
diff --git a/hw/net/lasi_i82596.c b/hw/net/lasi_i82596.c
index 52637a562d..5e0fd69763 100644
--- a/hw/net/lasi_i82596.c
+++ b/hw/net/lasi_i82596.c
@@ -152,7 +152,7 @@ static void lasi_82596_instance_init(Object *obj)
 
     device_add_bootindex_property(obj, &s->conf.bootindex,
                                   "bootindex", "/ethernet-phy@0",
-                                  DEVICE(obj), NULL);
+                                  DEVICE(obj));
 }
 
 static Property lasi_82596_properties[] = {
diff --git a/hw/net/ne2000-pci.c b/hw/net/ne2000-pci.c
index e11d67bf75..9e5d10859a 100644
--- a/hw/net/ne2000-pci.c
+++ b/hw/net/ne2000-pci.c
@@ -92,7 +92,7 @@ static void ne2000_instance_init(Object *obj)
 
     device_add_bootindex_property(obj, &s->c.bootindex,
                                   "bootindex", "/ethernet-phy@0",
-                                  &pci_dev->qdev, NULL);
+                                  &pci_dev->qdev);
 }
 
 static Property ne2000_properties[] = {
diff --git a/hw/net/pcnet-pci.c b/hw/net/pcnet-pci.c
index d1f31e0272..49d3e42e83 100644
--- a/hw/net/pcnet-pci.c
+++ b/hw/net/pcnet-pci.c
@@ -250,7 +250,7 @@ static void pcnet_instance_init(Object *obj)
 
     device_add_bootindex_property(obj, &s->conf.bootindex,
                                   "bootindex", "/ethernet-phy@0",
-                                  DEVICE(obj), NULL);
+                                  DEVICE(obj));
 }
 
 static Property pcnet_properties[] = {
diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
index 70aca7ec26..ab93d78ab3 100644
--- a/hw/net/rtl8139.c
+++ b/hw/net/rtl8139.c
@@ -3415,7 +3415,7 @@ static void rtl8139_instance_init(Object *obj)
 
     device_add_bootindex_property(obj, &s->conf.bootindex,
                                   "bootindex", "/ethernet-phy@0",
-                                  DEVICE(obj), NULL);
+                                  DEVICE(obj));
 }
 
 static Property rtl8139_properties[] = {
diff --git a/hw/net/spapr_llan.c b/hw/net/spapr_llan.c
index a2377025a7..968a1ce78e 100644
--- a/hw/net/spapr_llan.c
+++ b/hw/net/spapr_llan.c
@@ -340,7 +340,7 @@ static void spapr_vlan_instance_init(Object *obj)
 
     device_add_bootindex_property(obj, &dev->nicconf.bootindex,
                                   "bootindex", "",
-                                  DEVICE(dev), NULL);
+                                  DEVICE(dev));
 
     if (dev->compat_flags & SPAPRVLAN_FLAG_RX_BUF_POOLS) {
         for (i = 0; i < RX_MAX_POOLS; i++) {
diff --git a/hw/net/sungem.c b/hw/net/sungem.c
index b01197d952..e4b7b57704 100644
--- a/hw/net/sungem.c
+++ b/hw/net/sungem.c
@@ -1378,7 +1378,7 @@ static void sungem_instance_init(Object *obj)
 
     device_add_bootindex_property(obj, &s->conf.bootindex,
                                   "bootindex", "/ethernet-phy@0",
-                                  DEVICE(obj), NULL);
+                                  DEVICE(obj));
 }
 
 static Property sungem_properties[] = {
diff --git a/hw/net/sunhme.c b/hw/net/sunhme.c
index 9c38583180..bc48d46b9f 100644
--- a/hw/net/sunhme.c
+++ b/hw/net/sunhme.c
@@ -901,7 +901,7 @@ static void sunhme_instance_init(Object *obj)
 
     device_add_bootindex_property(obj, &s->conf.bootindex,
                                   "bootindex", "/ethernet-phy@0",
-                                  DEVICE(obj), NULL);
+                                  DEVICE(obj));
 }
 
 static void sunhme_reset(DeviceState *ds)
diff --git a/hw/net/tulip.c b/hw/net/tulip.c
index 1295f51d07..6cefc0add2 100644
--- a/hw/net/tulip.c
+++ b/hw/net/tulip.c
@@ -1001,7 +1001,7 @@ static void tulip_instance_init(Object *obj)
 
     device_add_bootindex_property(obj, &d->c.bootindex,
                                   "bootindex", "/ethernet-phy@0",
-                                  &pci_dev->qdev, NULL);
+                                  &pci_dev->qdev);
 }
 
 static Property tulip_properties[] = {
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index e51231e795..b43fd7d608 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3125,7 +3125,7 @@ static void virtio_net_instance_init(Object *obj)
     n->config_size = sizeof(struct virtio_net_config);
     device_add_bootindex_property(obj, &n->nic_conf.bootindex,
                                   "bootindex", "/ethernet-phy@0",
-                                  DEVICE(n), NULL);
+                                  DEVICE(n));
 }
 
 static int virtio_net_pre_save(void *opaque)
diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
index 6d91cd8309..7a6ca4ec35 100644
--- a/hw/net/vmxnet3.c
+++ b/hw/net/vmxnet3.c
@@ -2237,7 +2237,7 @@ static void vmxnet3_instance_init(Object *obj)
     VMXNET3State *s = VMXNET3(obj);
     device_add_bootindex_property(obj, &s->conf.bootindex,
                                   "bootindex", "/ethernet-phy@0",
-                                  DEVICE(obj), NULL);
+                                  DEVICE(obj));
 }
 
 static void vmxnet3_pci_uninit(PCIDevice *pci_dev)
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 976d40f60f..b73f4d94d3 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3316,8 +3316,7 @@ static void spapr_instance_init(Object *obj)
                                     " place of standard EPOW events when possible"
                                     " (required for memory hot-unplug support)");
     ppc_compat_add_property(obj, "max-cpu-compat", &spapr->max_compat_pvr,
-                            "Maximum permitted CPU compatibility mode",
-                            &error_fatal);
+                            "Maximum permitted CPU compatibility mode");
 
     object_property_add_str(obj, "resize-hpt",
                             spapr_get_resize_hpt, spapr_set_resize_hpt);
@@ -4525,7 +4524,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] = SPAPR_CAP_ON;
     smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] = SPAPR_CAP_ON;
     smc->default_caps.caps[SPAPR_CAP_FWNMI] = SPAPR_CAP_ON;
-    spapr_caps_add_properties(smc, &error_abort);
+    spapr_caps_add_properties(smc);
     smc->irq = &spapr_irq_dual;
     smc->dr_phb_enabled = true;
     smc->linux_pci_probe = true;
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 184563e608..efdc0dbbcf 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -824,7 +824,7 @@ void spapr_caps_cpu_apply(SpaprMachineState *spapr, PowerPCCPU *cpu)
     }
 }
 
-void spapr_caps_add_properties(SpaprMachineClass *smc, Error **errp)
+void spapr_caps_add_properties(SpaprMachineClass *smc)
 {
     ObjectClass *klass = OBJECT_CLASS(smc);
     int i;
diff --git a/hw/s390x/s390-ccw.c b/hw/s390x/s390-ccw.c
index 0c5a5b60bd..569020dae4 100644
--- a/hw/s390x/s390-ccw.c
+++ b/hw/s390x/s390-ccw.c
@@ -151,7 +151,7 @@ static void s390_ccw_instance_init(Object *obj)
     S390CCWDevice *dev = S390_CCW_DEVICE(obj);
 
     device_add_bootindex_property(obj, &dev->bootindex, "bootindex",
-                                  "/disk@0,0", DEVICE(obj), NULL);
+                                  "/disk@0,0", DEVICE(obj));
 }
 
 static void s390_ccw_class_init(ObjectClass *klass, void *data)
diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index ab5459a589..1733307407 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -1738,7 +1738,7 @@ static void scsi_dev_instance_init(Object *obj)
 
     device_add_bootindex_property(obj, &s->conf.bootindex,
                                   "bootindex", NULL,
-                                  &s->qdev, NULL);
+                                  &s->qdev);
 }
 
 static const TypeInfo scsi_device_type_info = {
diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
index f052377b7e..ffa667171d 100644
--- a/hw/scsi/vhost-scsi.c
+++ b/hw/scsi/vhost-scsi.c
@@ -311,7 +311,7 @@ static void vhost_scsi_instance_init(Object *obj)
     vsc->feature_bits = kernel_feature_bits;
 
     device_add_bootindex_property(obj, &vsc->bootindex, "bootindex", NULL,
-                                  DEVICE(vsc), NULL);
+                                  DEVICE(vsc));
 }
 
 static const TypeInfo vhost_scsi_info = {
diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index a01bf63a08..ae380b63b4 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -217,7 +217,7 @@ static void vhost_user_scsi_instance_init(Object *obj)
 
     /* Add the bootindex property for this object */
     device_add_bootindex_property(obj, &vsc->bootindex, "bootindex", NULL,
-                                  DEVICE(vsc), NULL);
+                                  DEVICE(vsc));
 }
 
 static const TypeInfo vhost_user_scsi_info = {
diff --git a/hw/usb/dev-network.c b/hw/usb/dev-network.c
index 6210427544..720744488b 100644
--- a/hw/usb/dev-network.c
+++ b/hw/usb/dev-network.c
@@ -1381,7 +1381,7 @@ static void usb_net_instance_init(Object *obj)
 
     device_add_bootindex_property(obj, &s->conf.bootindex,
                                   "bootindex", "/ethernet-phy@0",
-                                  &dev->qdev, NULL);
+                                  &dev->qdev);
 }
 
 static const VMStateDescription vmstate_usb_net = {
diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
index 2ac7a936fb..78a5c2ba55 100644
--- a/hw/usb/host-libusb.c
+++ b/hw/usb/host-libusb.c
@@ -1101,7 +1101,7 @@ static void usb_host_instance_init(Object *obj)
 
     device_add_bootindex_property(obj, &s->bootindex,
                                   "bootindex", NULL,
-                                  &udev->qdev, NULL);
+                                  &udev->qdev);
 }
 
 static void usb_host_unrealize(USBDevice *udev, Error **errp)
diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index 45d8b76218..e9a97feaed 100644
--- a/hw/usb/redirect.c
+++ b/hw/usb/redirect.c
@@ -2595,7 +2595,7 @@ static void usbredir_instance_init(Object *obj)
 
     device_add_bootindex_property(obj, &dev->bootindex,
                                   "bootindex", NULL,
-                                  &udev->qdev, NULL);
+                                  &udev->qdev);
 }
 
 static const TypeInfo usbredir_dev_info = {
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 5e75a95129..342dd6b912 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3133,7 +3133,7 @@ static void vfio_instance_init(Object *obj)
 
     device_add_bootindex_property(obj, &vdev->bootindex,
                                   "bootindex", NULL,
-                                  &pci_dev->qdev, NULL);
+                                  &pci_dev->qdev);
     vdev->host.domain = ~0U;
     vdev->host.bus = ~0U;
     vdev->host.slot = ~0U;
diff --git a/target/ppc/compat.c b/target/ppc/compat.c
index 7f144392f8..fda0dfe8f8 100644
--- a/target/ppc/compat.c
+++ b/target/ppc/compat.c
@@ -298,8 +298,7 @@ out:
 }
 
 void ppc_compat_add_property(Object *obj, const char *name,
-                             uint32_t *compat_pvr, const char *basedesc,
-                             Error **errp)
+                             uint32_t *compat_pvr, const char *basedesc)
 {
     gchar *namesv[ARRAY_SIZE(compat_table) + 1];
     gchar *names, *desc;
-- 
2.21.1


