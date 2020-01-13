Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9795C33CAD
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 14:04:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 632CB20678
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 14:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="Iab57YVx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 632CB20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ir0KK-0006jj-I8
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 09:04:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58447)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1ir0Hl-0001up-W3
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 09:01:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1ir0Hh-0005jM-Qg
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 09:01:39 -0500
Received: from forwardcorp1p.mail.yandex.net
 ([2a02:6b8:0:1472:2741:0:8b6:217]:37462)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
 id 1ir0Hh-0005cq-3L
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 09:01:37 -0500
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net
 [IPv6:2a02:6b8:0:1619::119])
 by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id E6CFB2E14CB;
 Mon, 13 Jan 2020 17:01:31 +0300 (MSK)
Received: from vla1-5a8b76e65344.qloud-c.yandex.net
 (vla1-5a8b76e65344.qloud-c.yandex.net [2a02:6b8:c0d:3183:0:640:5a8b:76e6])
 by mxbackcorp2j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id
 550MBlBHoJ-1VLah1EM; Mon, 13 Jan 2020 17:01:31 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1578924091; bh=rRxTyrByTSj+qunoOKpt1PLG0YLSoHmiXfDV8UvB+z4=;
 h=Message-Id:Date:Subject:To:From:Cc;
 b=Iab57YVxaJK1/5mbi75lZOA1SUldTPikFQgj+h++sRoPfP66VGZLtEyxY6OU4sIiH
 OXi6YxPJTFvyESJsbBtpnXoAAq7I2ZgFDey4X0px3H+Xg6mSsxOwZmic0p5vu8s/wH
 V2N6x1I7QDT5LXV4f91s3rT/DAZ+oSqIeYjqhOrg=
Authentication-Results: mxbackcorp2j.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net
 [2a02:6b8:0:408:c8ef:4094:aec7:9c0f])
 by vla1-5a8b76e65344.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 B0RjkbXcyT-1VV0qsew; Mon, 13 Jan 2020 17:01:31 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
From: Yury Kotov <yury-kotov@yandex-team.ru>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH] pcie: Defer hot unplug until migration is complete
Date: Mon, 13 Jan 2020 17:01:22 +0300
Message-Id: <20200113140122.29486-1-yury-kotov@yandex-team.ru>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a02:6b8:0:1472:2741:0:8b6:217
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: yc-core@yandex-team.ru, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Devices hot-plug during migration is not allowed and disabled in
corresponding QMP-commands (device_add, device_del).
But guest still can unplug device by powering it off
(Example: echo 0 > /sys/bus/pci/slots/XXX/power).

Fix it by deferring unplugging until the migration is complete.

Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
---
 hw/pci-bridge/gen_pcie_root_port.c |  7 ++++
 hw/pci-bridge/ioh3420.c            |  7 ++++
 hw/pci-bridge/xio3130_downstream.c |  7 ++++
 hw/pci/pcie.c                      | 54 +++++++++++++++++++++++-------
 hw/pci/pcie_port.c                 | 47 ++++++++++++++++++++++++++
 include/hw/pci/pcie.h              |  1 +
 include/hw/pci/pcie_port.h         | 20 +++++++++++
 7 files changed, 130 insertions(+), 13 deletions(-)

diff --git a/hw/pci-bridge/gen_pcie_root_port.c b/hw/pci-bridge/gen_pcie_=
root_port.c
index 9eaefebca8..5b3c202341 100644
--- a/hw/pci-bridge/gen_pcie_root_port.c
+++ b/hw/pci-bridge/gen_pcie_root_port.c
@@ -100,6 +100,9 @@ static void gen_rp_realize(DeviceState *dev, Error **=
errp)
     }
 }
=20
+static const VMStateDescription vmstate_rp_deffered_unplug =3D
+    VMSTATE_DEFFERED_UNPLUG("pcie-root-port");
+
 static const VMStateDescription vmstate_rp_dev =3D {
     .name =3D "pcie-root-port",
     .priority =3D MIG_PRI_PCI_BUS,
@@ -114,6 +117,10 @@ static const VMStateDescription vmstate_rp_dev =3D {
                           GenPCIERootPort,
                           gen_rp_test_migrate_msix),
         VMSTATE_END_OF_LIST()
+    },
+    .subsections =3D (const VMStateDescription * []) {
+        &vmstate_rp_deffered_unplug,
+        NULL
     }
 };
=20
diff --git a/hw/pci-bridge/ioh3420.c b/hw/pci-bridge/ioh3420.c
index f1e16135a3..2399a9a87f 100644
--- a/hw/pci-bridge/ioh3420.c
+++ b/hw/pci-bridge/ioh3420.c
@@ -82,6 +82,9 @@ static void ioh3420_interrupts_uninit(PCIDevice *d)
     msi_uninit(d);
 }
=20
+static const VMStateDescription vmstate_ioh3420_deffered_unplug =3D
+    VMSTATE_DEFFERED_UNPLUG("ioh-3240-express-root-port");
+
 static const VMStateDescription vmstate_ioh3420 =3D {
     .name =3D "ioh-3240-express-root-port",
     .priority =3D MIG_PRI_PCI_BUS,
@@ -93,6 +96,10 @@ static const VMStateDescription vmstate_ioh3420 =3D {
         VMSTATE_STRUCT(parent_obj.parent_obj.parent_obj.exp.aer_log,
                        PCIESlot, 0, vmstate_pcie_aer_log, PCIEAERLog),
         VMSTATE_END_OF_LIST()
+    },
+    .subsections =3D (const VMStateDescription * []) {
+        &vmstate_ioh3420_deffered_unplug,
+        NULL
     }
 };
=20
diff --git a/hw/pci-bridge/xio3130_downstream.c b/hw/pci-bridge/xio3130_d=
ownstream.c
index a9f084b863..a5b4fe08ee 100644
--- a/hw/pci-bridge/xio3130_downstream.c
+++ b/hw/pci-bridge/xio3130_downstream.c
@@ -139,6 +139,9 @@ static Property xio3130_downstream_props[] =3D {
     DEFINE_PROP_END_OF_LIST()
 };
=20
+static const VMStateDescription vmstate_xio3130_downstream_deffered_unpl=
ug =3D
+    VMSTATE_DEFFERED_UNPLUG("xio3130-express-downstream-port");
+
 static const VMStateDescription vmstate_xio3130_downstream =3D {
     .name =3D "xio3130-express-downstream-port",
     .priority =3D MIG_PRI_PCI_BUS,
@@ -150,6 +153,10 @@ static const VMStateDescription vmstate_xio3130_down=
stream =3D {
         VMSTATE_STRUCT(parent_obj.parent_obj.parent_obj.exp.aer_log,
                        PCIESlot, 0, vmstate_pcie_aer_log, PCIEAERLog),
         VMSTATE_END_OF_LIST()
+    },
+    .subsections =3D (const VMStateDescription * []) {
+        &vmstate_xio3130_downstream_deffered_unplug,
+        NULL
     }
 };
=20
diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 08718188bb..29f0e5c05b 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -28,6 +28,8 @@
 #include "hw/pci/pcie_regs.h"
 #include "hw/pci/pcie_port.h"
 #include "qemu/range.h"
+#include "sysemu/sysemu.h"
+#include "migration/misc.h"
=20
 //#define DEBUG_PCIE
 #ifdef DEBUG_PCIE
@@ -575,6 +577,7 @@ void pcie_cap_slot_reset(PCIDevice *dev)
=20
     if (dev->cap_present & QEMU_PCIE_SLTCAP_PCP) {
         /* Downstream ports enforce device number 0. */
+        PCIESlot *slot =3D PCIE_SLOT(dev);
         bool populated =3D pci_bridge_get_sec_bus(PCI_BRIDGE(dev))->devi=
ces[0];
         uint16_t pic;
=20
@@ -588,6 +591,7 @@ void pcie_cap_slot_reset(PCIDevice *dev)
=20
         pic =3D populated ? PCI_EXP_SLTCTL_PIC_ON : PCI_EXP_SLTCTL_PIC_O=
FF;
         pci_word_test_and_set_mask(exp_cap + PCI_EXP_SLTCTL, pic);
+        slot->unplug_is_deferred =3D false;
     }
=20
     pci_word_test_and_clear_mask(exp_cap + PCI_EXP_SLTSTA,
@@ -608,13 +612,42 @@ void pcie_cap_slot_get(PCIDevice *dev, uint16_t *sl=
t_ctl, uint16_t *slt_sta)
     *slt_sta =3D pci_get_word(exp_cap + PCI_EXP_SLTSTA);
 }
=20
+static void pcie_cap_slot_unplug(PCIDevice *dev)
+{
+    uint32_t pos =3D dev->exp.exp_cap;
+    uint8_t *exp_cap =3D dev->config + pos;
+    PCIBus *sec_bus =3D pci_bridge_get_sec_bus(PCI_BRIDGE(dev));
+
+    pci_for_each_device(sec_bus, pci_bus_num(sec_bus),
+                        pcie_unplug_device, NULL);
+    pci_word_test_and_clear_mask(exp_cap + PCI_EXP_SLTSTA, PCI_EXP_SLTST=
A_PDS);
+    if (dev->cap_present & QEMU_PCIE_LNKSTA_DLLLA) {
+        pci_word_test_and_clear_mask(exp_cap + PCI_EXP_LNKSTA,
+                                     PCI_EXP_LNKSTA_DLLLA);
+    }
+    pci_word_test_and_set_mask(exp_cap + PCI_EXP_SLTSTA, PCI_EXP_SLTSTA_=
PDC);
+    hotplug_event_notify(dev);
+}
+
+void pcie_cap_slot_deferred_unplug(PCIDevice *dev)
+{
+    PCIESlot *slot =3D PCIE_SLOT(dev);
+
+    if (migration_is_idle() && slot->unplug_is_deferred) {
+        pcie_cap_slot_unplug(dev);
+        slot->unplug_is_deferred =3D false;
+    }
+}
+
 void pcie_cap_slot_write_config(PCIDevice *dev,
                                 uint16_t old_slt_ctl, uint16_t old_slt_s=
ta,
                                 uint32_t addr, uint32_t val, int len)
 {
+    PCIESlot *slot =3D PCIE_SLOT(dev);
     uint32_t pos =3D dev->exp.exp_cap;
     uint8_t *exp_cap =3D dev->config + pos;
     uint16_t sltsta =3D pci_get_word(exp_cap + PCI_EXP_SLTSTA);
+    bool may_unplug;
=20
     if (ranges_overlap(addr, len, pos + PCI_EXP_SLTSTA, 2)) {
         /*
@@ -660,22 +693,17 @@ void pcie_cap_slot_write_config(PCIDevice *dev,
      * this is a work around for guests that overwrite
      * control of powered off slots before powering them on.
      */
-    if ((sltsta & PCI_EXP_SLTSTA_PDS) && (val & PCI_EXP_SLTCTL_PCC) &&
-        (val & PCI_EXP_SLTCTL_PIC_OFF) =3D=3D PCI_EXP_SLTCTL_PIC_OFF &&
+    may_unplug =3D (val & PCI_EXP_SLTCTL_PCC) &&
+                 (val & PCI_EXP_SLTCTL_PIC_OFF) =3D=3D PCI_EXP_SLTCTL_PI=
C_OFF;
+    if (may_unplug && (sltsta & PCI_EXP_SLTSTA_PDS) &&
         (!(old_slt_ctl & PCI_EXP_SLTCTL_PCC) ||
         (old_slt_ctl & PCI_EXP_SLTCTL_PIC_OFF) !=3D PCI_EXP_SLTCTL_PIC_O=
FF)) {
-        PCIBus *sec_bus =3D pci_bridge_get_sec_bus(PCI_BRIDGE(dev));
-        pci_for_each_device(sec_bus, pci_bus_num(sec_bus),
-                            pcie_unplug_device, NULL);
-
-        pci_word_test_and_clear_mask(exp_cap + PCI_EXP_SLTSTA,
-                                     PCI_EXP_SLTSTA_PDS);
-        if (dev->cap_present & QEMU_PCIE_LNKSTA_DLLLA) {
-            pci_word_test_and_clear_mask(exp_cap + PCI_EXP_LNKSTA,
-                                         PCI_EXP_LNKSTA_DLLLA);
+        slot->unplug_is_deferred =3D !migration_is_idle();
+        if (!slot->unplug_is_deferred) {
+            pcie_cap_slot_unplug(dev);
         }
-        pci_word_test_and_set_mask(exp_cap + PCI_EXP_SLTSTA,
-                                       PCI_EXP_SLTSTA_PDC);
+    } else if (!may_unplug) {
+        slot->unplug_is_deferred =3D false;
     }
=20
     hotplug_event_notify(dev);
diff --git a/hw/pci/pcie_port.c b/hw/pci/pcie_port.c
index c19a9be592..bd5fbf6827 100644
--- a/hw/pci/pcie_port.c
+++ b/hw/pci/pcie_port.c
@@ -23,6 +23,9 @@
 #include "hw/qdev-properties.h"
 #include "qemu/module.h"
 #include "hw/hotplug.h"
+#include "sysemu/runstate.h"
+#include "migration/migration.h"
+#include "migration/misc.h"
=20
 void pcie_port_init_reg(PCIDevice *d)
 {
@@ -150,6 +153,48 @@ static Property pcie_slot_props[] =3D {
     DEFINE_PROP_END_OF_LIST()
 };
=20
+bool vmstate_deffered_unplug_needed(void *opaque)
+{
+    PCIESlot *slot =3D opaque;
+
+    return slot->unplug_is_deferred;
+}
+
+static void pcie_slot_migration_notifier_cb(Notifier *notifier, void *da=
ta)
+{
+    PCIESlot *slot =3D container_of(notifier, PCIESlot, migration_notifi=
er);
+
+    pcie_cap_slot_deferred_unplug(PCI_DEVICE(slot));
+}
+
+static void pcie_slot_vm_state_change(void *opaque, int running, RunStat=
e state)
+{
+    PCIESlot *slot =3D opaque;
+
+    pcie_cap_slot_deferred_unplug(PCI_DEVICE(slot));
+}
+
+static void pcie_slot_init(Object *obj)
+{
+    PCIESlot *slot =3D PCIE_SLOT(obj);
+
+    slot->unplug_is_deferred =3D false;
+    slot->migration_notifier =3D (Notifier) {
+        .notify =3D pcie_slot_migration_notifier_cb
+    };
+    add_migration_state_change_notifier(&slot->migration_notifier);
+    slot->vmstate_change =3D
+        qemu_add_vm_change_state_handler(pcie_slot_vm_state_change, slot=
);
+}
+
+static void pcie_slot_finalize(Object *obj)
+{
+    PCIESlot *slot =3D PCIE_SLOT(obj);
+
+    remove_migration_state_change_notifier(&slot->migration_notifier);
+    qemu_del_vm_change_state_handler(slot->vmstate_change);
+}
+
 static void pcie_slot_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(oc);
@@ -166,6 +211,8 @@ static const TypeInfo pcie_slot_type_info =3D {
     .name =3D TYPE_PCIE_SLOT,
     .parent =3D TYPE_PCIE_PORT,
     .instance_size =3D sizeof(PCIESlot),
+    .instance_init =3D pcie_slot_init,
+    .instance_finalize =3D pcie_slot_finalize,
     .abstract =3D true,
     .class_init =3D pcie_slot_class_init,
     .interfaces =3D (InterfaceInfo[]) {
diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
index 7064875835..128f26199e 100644
--- a/include/hw/pci/pcie.h
+++ b/include/hw/pci/pcie.h
@@ -110,6 +110,7 @@ void pcie_cap_slot_get(PCIDevice *dev, uint16_t *slt_=
ctl, uint16_t *slt_sta);
 void pcie_cap_slot_write_config(PCIDevice *dev,
                                 uint16_t old_slt_ctl, uint16_t old_slt_s=
ta,
                                 uint32_t addr, uint32_t val, int len);
+void pcie_cap_slot_deferred_unplug(PCIDevice *dev);
 int pcie_cap_slot_post_load(void *opaque, int version_id);
 void pcie_cap_slot_push_attention_button(PCIDevice *dev);
=20
diff --git a/include/hw/pci/pcie_port.h b/include/hw/pci/pcie_port.h
index 7515430087..32e45f0c89 100644
--- a/include/hw/pci/pcie_port.h
+++ b/include/hw/pci/pcie_port.h
@@ -23,6 +23,9 @@
=20
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci/pci_bus.h"
+#include "qemu/notify.h"
+#include "sysemu/sysemu.h"
+#include "migration/vmstate.h"
=20
 #define TYPE_PCIE_PORT "pcie-port"
 #define PCIE_PORT(obj) OBJECT_CHECK(PCIEPort, (obj), TYPE_PCIE_PORT)
@@ -44,6 +47,10 @@ void pcie_port_init_reg(PCIDevice *d);
 struct PCIESlot {
     /*< private >*/
     PCIEPort    parent_obj;
+    bool        unplug_is_deferred;
+    Notifier    migration_notifier;
+    VMChangeStateEntry *vmstate_change;
+
     /*< public >*/
=20
     /* pci express switch port with slot */
@@ -58,6 +65,19 @@ struct PCIESlot {
     QLIST_ENTRY(PCIESlot) next;
 };
=20
+bool vmstate_deffered_unplug_needed(void *opaque);
+
+#define VMSTATE_DEFFERED_UNPLUG(parent_section_name) {            \
+    .name =3D parent_section_name "/deffered-unplug",               \
+    .version_id =3D 1,                                              \
+    .minimum_version_id =3D 1,                                      \
+    .needed =3D vmstate_deffered_unplug_needed,                     \
+    .fields =3D (VMStateField[]) {                                  \
+        VMSTATE_BOOL(unplug_is_deferred, PCIESlot),               \
+        VMSTATE_END_OF_LIST()                                     \
+    }                                                             \
+}
+
 void pcie_chassis_create(uint8_t chassis_number);
 PCIESlot *pcie_chassis_find_slot(uint8_t chassis, uint16_t slot);
 int pcie_chassis_add_slot(struct PCIESlot *slot);
--=20
2.24.1


