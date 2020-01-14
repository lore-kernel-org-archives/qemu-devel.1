Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26066C33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 13:22:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D592F20678
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 13:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nu+TJRyV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D592F20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irM9Q-0004Kt-QO
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 08:22:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41844)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1irLkb-0004ZL-Rm
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 07:56:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1irLka-0002Nz-2B
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 07:56:53 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26956
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1irLkZ-0002NR-Uo
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 07:56:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579006611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A9ILjMmGuIyM1P2hRnpWbTP5WXqnScSgd+A/btvZYmk=;
 b=Nu+TJRyVdCgoPONg/yBy9e2pI0R5CKAHLDHR881fpedDURf231Z/GkKWV2Qp4dBkc3mEAg
 x2dc4TpshpZ37LtBu67QeGieMKPoTjXaQvOpfTRDzsz+ZlG54apV3rguh3ydCAxRNtMNOr
 tPM4aH6AYIKdhybe24CX8J0Vmc0Cjkk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-ct9GR9yINdSwSFjUmuvLYg-1; Tue, 14 Jan 2020 07:56:50 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 665D58024CE;
 Tue, 14 Jan 2020 12:56:48 +0000 (UTC)
Received: from secure.mitica (ovpn-116-207.ams2.redhat.com [10.36.116.207])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 73F525D9E5;
 Tue, 14 Jan 2020 12:56:34 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 27/30] migration: Define VMSTATE_INSTANCE_ID_ANY
Date: Tue, 14 Jan 2020 13:52:51 +0100
Message-Id: <20200114125254.4515-28-quintela@redhat.com>
In-Reply-To: <20200114125254.4515-1-quintela@redhat.com>
References: <20200114125254.4515-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: ct9GR9yINdSwSFjUmuvLYg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Corey Minyard <cminyard@mvista.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Xu <peterx@redhat.com>

Define the new macro VMSTATE_INSTANCE_ID_ANY for callers who wants to
auto-generate the vmstate instance ID.  Previously it was hard coded
as -1 instead of this macro.  It helps to change this default value in
the follow up patches.  No functional change.

Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 backends/dbus-vmstate.c     | 3 ++-
 hw/arm/stellaris.c          | 2 +-
 hw/core/qdev.c              | 3 ++-
 hw/display/ads7846.c        | 2 +-
 hw/i2c/core.c               | 2 +-
 hw/input/stellaris_input.c  | 3 ++-
 hw/intc/apic_common.c       | 2 +-
 hw/misc/max111x.c           | 3 ++-
 hw/net/eepro100.c           | 3 ++-
 hw/pci/pci.c                | 2 +-
 hw/ppc/spapr.c              | 2 +-
 hw/timer/arm_timer.c        | 2 +-
 hw/tpm/tpm_emulator.c       | 3 ++-
 include/migration/vmstate.h | 2 ++
 migration/savevm.c          | 8 ++++----
 15 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/backends/dbus-vmstate.c b/backends/dbus-vmstate.c
index 56b482a7d6..cc594a722e 100644
--- a/backends/dbus-vmstate.c
+++ b/backends/dbus-vmstate.c
@@ -412,7 +412,8 @@ dbus_vmstate_complete(UserCreatable *uc, Error **errp)
         return;
     }
=20
-    if (vmstate_register(VMSTATE_IF(self), -1, &dbus_vmstate, self) < 0) {
+    if (vmstate_register(VMSTATE_IF(self), VMSTATE_INSTANCE_ID_ANY,
+                         &dbus_vmstate, self) < 0) {
         error_setg(errp, "Failed to register vmstate");
     }
 }
diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index b198066b54..bb025e0bd0 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -708,7 +708,7 @@ static int stellaris_sys_init(uint32_t base, qemu_irq i=
rq,
     memory_region_init_io(&s->iomem, NULL, &ssys_ops, s, "ssys", 0x0000100=
0);
     memory_region_add_subregion(get_system_memory(), base, &s->iomem);
     ssys_reset(s);
-    vmstate_register(NULL, -1, &vmstate_stellaris_sys, s);
+    vmstate_register(NULL, VMSTATE_INSTANCE_ID_ANY, &vmstate_stellaris_sys=
, s);
     return 0;
 }
=20
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 9f1753f5cf..58e87d336d 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -879,7 +879,8 @@ static void device_set_realized(Object *obj, bool value=
, Error **errp)
=20
         if (qdev_get_vmsd(dev)) {
             if (vmstate_register_with_alias_id(VMSTATE_IF(dev),
-                                               -1, qdev_get_vmsd(dev), dev=
,
+                                               VMSTATE_INSTANCE_ID_ANY,
+                                               qdev_get_vmsd(dev), dev,
                                                dev->instance_id_alias,
                                                dev->alias_required_for_ver=
sion,
                                                &local_err) < 0) {
diff --git a/hw/display/ads7846.c b/hw/display/ads7846.c
index c12272ae72..9228b40b1a 100644
--- a/hw/display/ads7846.c
+++ b/hw/display/ads7846.c
@@ -154,7 +154,7 @@ static void ads7846_realize(SSISlave *d, Error **errp)
=20
     ads7846_int_update(s);
=20
-    vmstate_register(NULL, -1, &vmstate_ads7846, s);
+    vmstate_register(NULL, VMSTATE_INSTANCE_ID_ANY, &vmstate_ads7846, s);
 }
=20
 static void ads7846_class_init(ObjectClass *klass, void *data)
diff --git a/hw/i2c/core.c b/hw/i2c/core.c
index 92cd489069..d770035ba0 100644
--- a/hw/i2c/core.c
+++ b/hw/i2c/core.c
@@ -61,7 +61,7 @@ I2CBus *i2c_init_bus(DeviceState *parent, const char *nam=
e)
=20
     bus =3D I2C_BUS(qbus_create(TYPE_I2C_BUS, parent, name));
     QLIST_INIT(&bus->current_devs);
-    vmstate_register(NULL, -1, &vmstate_i2c_bus, bus);
+    vmstate_register(NULL, VMSTATE_INSTANCE_ID_ANY, &vmstate_i2c_bus, bus)=
;
     return bus;
 }
=20
diff --git a/hw/input/stellaris_input.c b/hw/input/stellaris_input.c
index 59892b07fc..e6ee5e11f1 100644
--- a/hw/input/stellaris_input.c
+++ b/hw/input/stellaris_input.c
@@ -88,5 +88,6 @@ void stellaris_gamepad_init(int n, qemu_irq *irq, const i=
nt *keycode)
     }
     s->num_buttons =3D n;
     qemu_add_kbd_event_handler(stellaris_gamepad_put_key, s);
-    vmstate_register(NULL, -1, &vmstate_stellaris_gamepad, s);
+    vmstate_register(NULL, VMSTATE_INSTANCE_ID_ANY,
+                     &vmstate_stellaris_gamepad, s);
 }
diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
index 375cb6abe9..f2c3a7f309 100644
--- a/hw/intc/apic_common.c
+++ b/hw/intc/apic_common.c
@@ -284,7 +284,7 @@ static void apic_common_realize(DeviceState *dev, Error=
 **errp)
     }
=20
     if (s->legacy_instance_id) {
-        instance_id =3D -1;
+        instance_id =3D VMSTATE_INSTANCE_ID_ANY;
     }
     vmstate_register_with_alias_id(NULL, instance_id, &vmstate_apic_common=
,
                                    s, -1, 0, NULL);
diff --git a/hw/misc/max111x.c b/hw/misc/max111x.c
index 211008ce02..2b87bdee5b 100644
--- a/hw/misc/max111x.c
+++ b/hw/misc/max111x.c
@@ -146,7 +146,8 @@ static int max111x_init(SSISlave *d, int inputs)
     s->input[7] =3D 0x80;
     s->com =3D 0;
=20
-    vmstate_register(VMSTATE_IF(dev), -1, &vmstate_max111x, s);
+    vmstate_register(VMSTATE_IF(dev), VMSTATE_INSTANCE_ID_ANY,
+                     &vmstate_max111x, s);
     return 0;
 }
=20
diff --git a/hw/net/eepro100.c b/hw/net/eepro100.c
index cc71a7a036..6cc97769d9 100644
--- a/hw/net/eepro100.c
+++ b/hw/net/eepro100.c
@@ -1874,7 +1874,8 @@ static void e100_nic_realize(PCIDevice *pci_dev, Erro=
r **errp)
=20
     s->vmstate =3D g_memdup(&vmstate_eepro100, sizeof(vmstate_eepro100));
     s->vmstate->name =3D qemu_get_queue(s->nic)->model;
-    vmstate_register(VMSTATE_IF(&pci_dev->qdev), -1, s->vmstate, s);
+    vmstate_register(VMSTATE_IF(&pci_dev->qdev), VMSTATE_INSTANCE_ID_ANY,
+                     s->vmstate, s);
 }
=20
 static void eepro100_instance_init(Object *obj)
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index e3d310365d..3ac7961451 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -122,7 +122,7 @@ static void pci_bus_realize(BusState *qbus, Error **err=
p)
     bus->machine_done.notify =3D pcibus_machine_done;
     qemu_add_machine_init_done_notifier(&bus->machine_done);
=20
-    vmstate_register(NULL, -1, &vmstate_pcibus, bus);
+    vmstate_register(NULL, VMSTATE_INSTANCE_ID_ANY, &vmstate_pcibus, bus);
 }
=20
 static void pcie_bus_realize(BusState *qbus, Error **errp)
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 30a5fbd3be..02cf53fc5b 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2948,7 +2948,7 @@ static void spapr_machine_init(MachineState *machine)
      * interface, this is a legacy from the sPAPREnvironment structure
      * which predated MachineState but had a similar function */
     vmstate_register(NULL, 0, &vmstate_spapr, spapr);
-    register_savevm_live("spapr/htab", -1, 1,
+    register_savevm_live("spapr/htab", VMSTATE_INSTANCE_ID_ANY, 1,
                          &savevm_htab_handlers, spapr);
=20
     qbus_set_hotplug_handler(sysbus_get_default(), OBJECT(machine),
diff --git a/hw/timer/arm_timer.c b/hw/timer/arm_timer.c
index af524fabf7..beaa285685 100644
--- a/hw/timer/arm_timer.c
+++ b/hw/timer/arm_timer.c
@@ -180,7 +180,7 @@ static arm_timer_state *arm_timer_init(uint32_t freq)
     s->control =3D TIMER_CTRL_IE;
=20
     s->timer =3D ptimer_init(arm_timer_tick, s, PTIMER_POLICY_DEFAULT);
-    vmstate_register(NULL, -1, &vmstate_arm_timer, s);
+    vmstate_register(NULL, VMSTATE_INSTANCE_ID_ANY, &vmstate_arm_timer, s)=
;
     return s;
 }
=20
diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
index 10d587ed40..3a0fc442f3 100644
--- a/hw/tpm/tpm_emulator.c
+++ b/hw/tpm/tpm_emulator.c
@@ -914,7 +914,8 @@ static void tpm_emulator_inst_init(Object *obj)
     tpm_emu->cur_locty_number =3D ~0;
     qemu_mutex_init(&tpm_emu->mutex);
=20
-    vmstate_register(NULL, -1, &vmstate_tpm_emulator, obj);
+    vmstate_register(NULL, VMSTATE_INSTANCE_ID_ANY,
+                     &vmstate_tpm_emulator, obj);
 }
=20
 /*
diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 4aef72c426..ed74dd5624 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -1157,6 +1157,8 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDe=
scription *vmsd,
=20
 bool vmstate_save_needed(const VMStateDescription *vmsd, void *opaque);
=20
+#define  VMSTATE_INSTANCE_ID_ANY  -1
+
 /* Returns: 0 on success, -1 on failure */
 int vmstate_register_with_alias_id(VMStateIf *obj, int instance_id,
                                    const VMStateDescription *vmsd,
diff --git a/migration/savevm.c b/migration/savevm.c
index e57686bca7..8dab99efc4 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -775,7 +775,7 @@ int register_savevm_live(const char *idstr,
=20
     pstrcat(se->idstr, sizeof(se->idstr), idstr);
=20
-    if (instance_id =3D=3D -1) {
+    if (instance_id =3D=3D VMSTATE_INSTANCE_ID_ANY) {
         se->instance_id =3D calculate_new_instance_id(se->idstr);
     } else {
         se->instance_id =3D instance_id;
@@ -842,14 +842,14 @@ int vmstate_register_with_alias_id(VMStateIf *obj, in=
t instance_id,
=20
             se->compat =3D g_new0(CompatEntry, 1);
             pstrcpy(se->compat->idstr, sizeof(se->compat->idstr), vmsd->na=
me);
-            se->compat->instance_id =3D instance_id =3D=3D -1 ?
+            se->compat->instance_id =3D instance_id =3D=3D VMSTATE_INSTANC=
E_ID_ANY ?
                          calculate_compat_instance_id(vmsd->name) : instan=
ce_id;
-            instance_id =3D -1;
+            instance_id =3D VMSTATE_INSTANCE_ID_ANY;
         }
     }
     pstrcat(se->idstr, sizeof(se->idstr), vmsd->name);
=20
-    if (instance_id =3D=3D -1) {
+    if (instance_id =3D=3D VMSTATE_INSTANCE_ID_ANY) {
         se->instance_id =3D calculate_new_instance_id(se->idstr);
     } else {
         se->instance_id =3D instance_id;
--=20
2.24.1


