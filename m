Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D82C282DD
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 15:33:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6BB220673
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 15:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DDV61L2s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6BB220673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipwHz-0007y3-EH
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 10:33:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51376)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ipwFz-00064u-CX
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 10:31:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ipwFy-0003eK-0V
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 10:31:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30710
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ipwFx-0003cb-SR
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 10:31:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578670285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AatnzykRieGA2avKkbx/ijhUmKlcCrZGoVMSDcIsOps=;
 b=DDV61L2s5dDxyJlS8+gDJyWoHqboMRBi63y2moQKvnf8dMTcc89vBetfYOt8xLzk4kBRvY
 dl+8czOcyfDfpgL0m3sITUEYDB6S+JTS7ogycPIDZRoeZIaPR231MkrNarvZ49WgviXpw+
 jWC5pZH4W8uVtegKOAvGXtK4n1A6g2Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-jGbgRumkMlOJVH0hFjk6nQ-1; Fri, 10 Jan 2020 10:31:23 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 99820802CBC
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2020 15:31:22 +0000 (UTC)
Received: from localhost (ovpn-112-59.ams2.redhat.com [10.36.112.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 318E77C3E9;
 Fri, 10 Jan 2020 15:31:14 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/26] qdev: remove extraneous error
Date: Fri, 10 Jan 2020 19:30:16 +0400
Message-Id: <20200110153039.1379601-4-marcandre.lureau@redhat.com>
In-Reply-To: <20200110153039.1379601-1-marcandre.lureau@redhat.com>
References: <20200110153039.1379601-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: jGbgRumkMlOJVH0hFjk6nQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

All callers use error_abort, and even the function itself calls with
error_abort.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/hw/qdev-properties.h |  3 +--
 hw/core/qdev.c               | 15 ++++-----------
 target/arm/cpu.c             | 36 ++++++++++++------------------------
 3 files changed, 17 insertions(+), 37 deletions(-)

diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index a90a9cec80..906e697c58 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -253,13 +253,12 @@ void error_set_from_qdev_prop_error(Error **errp, int=
 ret, DeviceState *dev,
  * qdev_property_add_static:
  * @dev: Device to add the property to.
  * @prop: The qdev property definition.
- * @errp: location to store error information.
  *
  * Add a static QOM property to @dev for qdev property @prop.
  * On error, store error in @errp.  Static properties access data in a str=
uct.
  * The type of the QOM property is derived from prop->info.
  */
-void qdev_property_add_static(DeviceState *dev, Property *prop, Error **er=
rp);
+void qdev_property_add_static(DeviceState *dev, Property *prop);
=20
 void qdev_alias_all_properties(DeviceState *target, Object *source);
=20
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 48fae0b932..c2aa7f91a6 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -717,24 +717,17 @@ static void qdev_property_add_legacy(DeviceState *dev=
, Property *prop,
     g_free(name);
 }
=20
-void qdev_property_add_static(DeviceState *dev, Property *prop,
-                              Error **errp)
+void qdev_property_add_static(DeviceState *dev, Property *prop)
 {
-    Error *local_err =3D NULL;
     Object *obj =3D OBJECT(dev);
=20
     if (prop->info->create) {
-        prop->info->create(obj, prop, &local_err);
+        prop->info->create(obj, prop, &error_abort);
     } else {
         object_property_add(obj, prop->name, prop->info->name,
                             prop->info->get, prop->info->set,
                             prop->info->release,
-                            prop, &local_err);
-    }
-
-    if (local_err) {
-        error_propagate(errp, local_err);
-        return;
+                            prop, &error_abort);
     }
=20
     object_property_set_description(obj, prop->name,
@@ -988,7 +981,7 @@ static void device_initfn(Object *obj)
     do {
         for (prop =3D DEVICE_CLASS(class)->props; prop && prop->name; prop=
++) {
             qdev_property_add_legacy(dev, prop, &error_abort);
-            qdev_property_add_static(dev, prop, &error_abort);
+            qdev_property_add_static(dev, prop);
         }
         class =3D object_class_get_parent(class);
     } while (class !=3D object_class_by_name(TYPE_DEVICE));
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index d62fd5fdc6..6921464e2b 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1104,26 +1104,22 @@ void arm_cpu_post_init(Object *obj)
=20
     if (arm_feature(&cpu->env, ARM_FEATURE_CBAR) ||
         arm_feature(&cpu->env, ARM_FEATURE_CBAR_RO)) {
-        qdev_property_add_static(DEVICE(obj), &arm_cpu_reset_cbar_property=
,
-                                 &error_abort);
+        qdev_property_add_static(DEVICE(obj), &arm_cpu_reset_cbar_property=
);
     }
=20
     if (!arm_feature(&cpu->env, ARM_FEATURE_M)) {
-        qdev_property_add_static(DEVICE(obj), &arm_cpu_reset_hivecs_proper=
ty,
-                                 &error_abort);
+        qdev_property_add_static(DEVICE(obj), &arm_cpu_reset_hivecs_proper=
ty);
     }
=20
     if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
-        qdev_property_add_static(DEVICE(obj), &arm_cpu_rvbar_property,
-                                 &error_abort);
+        qdev_property_add_static(DEVICE(obj), &arm_cpu_rvbar_property);
     }
=20
     if (arm_feature(&cpu->env, ARM_FEATURE_EL3)) {
         /* Add the has_el3 state CPU property only if EL3 is allowed.  Thi=
s will
          * prevent "has_el3" from existing on CPUs which cannot support EL=
3.
          */
-        qdev_property_add_static(DEVICE(obj), &arm_cpu_has_el3_property,
-                                 &error_abort);
+        qdev_property_add_static(DEVICE(obj), &arm_cpu_has_el3_property);
=20
 #ifndef CONFIG_USER_ONLY
         object_property_add_link(obj, "secure-memory",
@@ -1136,8 +1132,7 @@ void arm_cpu_post_init(Object *obj)
     }
=20
     if (arm_feature(&cpu->env, ARM_FEATURE_EL2)) {
-        qdev_property_add_static(DEVICE(obj), &arm_cpu_has_el2_property,
-                                 &error_abort);
+        qdev_property_add_static(DEVICE(obj), &arm_cpu_has_el2_property);
     }
=20
     if (arm_feature(&cpu->env, ARM_FEATURE_PMU)) {
@@ -1154,32 +1149,27 @@ void arm_cpu_post_init(Object *obj)
     if (arm_feature(&cpu->env, ARM_FEATURE_VFP)) {
         cpu->has_vfp =3D true;
         if (!kvm_enabled()) {
-            qdev_property_add_static(DEVICE(obj), &arm_cpu_has_vfp_propert=
y,
-                                     &error_abort);
+            qdev_property_add_static(DEVICE(obj), &arm_cpu_has_vfp_propert=
y);
         }
     }
=20
     if (arm_feature(&cpu->env, ARM_FEATURE_NEON)) {
         cpu->has_neon =3D true;
         if (!kvm_enabled()) {
-            qdev_property_add_static(DEVICE(obj), &arm_cpu_has_neon_proper=
ty,
-                                     &error_abort);
+            qdev_property_add_static(DEVICE(obj), &arm_cpu_has_neon_proper=
ty);
         }
     }
=20
     if (arm_feature(&cpu->env, ARM_FEATURE_M) &&
         arm_feature(&cpu->env, ARM_FEATURE_THUMB_DSP)) {
-        qdev_property_add_static(DEVICE(obj), &arm_cpu_has_dsp_property,
-                                 &error_abort);
+        qdev_property_add_static(DEVICE(obj), &arm_cpu_has_dsp_property);
     }
=20
     if (arm_feature(&cpu->env, ARM_FEATURE_PMSA)) {
-        qdev_property_add_static(DEVICE(obj), &arm_cpu_has_mpu_property,
-                                 &error_abort);
+        qdev_property_add_static(DEVICE(obj), &arm_cpu_has_mpu_property);
         if (arm_feature(&cpu->env, ARM_FEATURE_V7)) {
             qdev_property_add_static(DEVICE(obj),
-                                     &arm_cpu_pmsav7_dregion_property,
-                                     &error_abort);
+                                     &arm_cpu_pmsav7_dregion_property);
         }
     }
=20
@@ -1198,12 +1188,10 @@ void arm_cpu_post_init(Object *obj)
                             NULL, NULL, &error_abort);
     }
=20
-    qdev_property_add_static(DEVICE(obj), &arm_cpu_cfgend_property,
-                             &error_abort);
+    qdev_property_add_static(DEVICE(obj), &arm_cpu_cfgend_property);
=20
     if (arm_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER)) {
-        qdev_property_add_static(DEVICE(cpu), &arm_cpu_gt_cntfrq_property,
-                                 &error_abort);
+        qdev_property_add_static(DEVICE(cpu), &arm_cpu_gt_cntfrq_property)=
;
     }
 }
=20
--=20
2.25.0.rc1.20.g2443f3f80d.dirty


