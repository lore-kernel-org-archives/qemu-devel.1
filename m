Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3FCBC83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 16:57:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8CA120757
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 16:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="enoMN3V7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8CA120757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTTXn-0005pa-Ph
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 12:57:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34532)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jTTFd-00074p-8g
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 12:38:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jTTDI-0002bk-Iw
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 12:38:28 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50710
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jTTDI-0002bW-3h
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 12:36:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588091763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=geLYC3lNN4C+LXNUVW83AAFmHLmqi1bfvQCyEEm7w/4=;
 b=enoMN3V7RFAlBb0ijAb5yQKabCon8n56AVESi02CkC73EKELz+h4eg1+ywatuHwDRWyC7b
 iscMxjKEdkc6DOAwFmehm6Jx64LiPsM4QAQ6Z//+bypQyEY90A+pw1Ng0DgCih3pTwMl0o
 dIQCt9/a5P5Q88jQPl08cuLAjd9anmk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-TJZgCtyHOJqpWaNxXlp6NA-1; Tue, 28 Apr 2020 12:34:30 -0400
X-MC-Unique: TJZgCtyHOJqpWaNxXlp6NA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A87D4464
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2020 16:34:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B644363F7A;
 Tue, 28 Apr 2020 16:34:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3B0F311358CE; Tue, 28 Apr 2020 18:34:20 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 17/17] qom: Drop @errp parameter of object_property_del()
Date: Tue, 28 Apr 2020 18:34:19 +0200
Message-Id: <20200428163419.4483-18-armbru@redhat.com>
In-Reply-To: <20200428163419.4483-1-armbru@redhat.com>
References: <20200428163419.4483-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 04:11:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Same story as for object_property_add(): the only way
object_property_del() can fail is when the property with this name
does not exist.  Since our property names are all hardcoded, failure
is a programming error, and the appropriate way to handle it is
passing &error_abort.  Most callers do that, the commit before
previous fixed one that didn't (and got the error handling wrong), and
the two remaining exceptions ignore errors.

Drop the @errp parameter and assert the precondition instead.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qom/object.h       | 2 +-
 hw/core/qdev.c             | 2 +-
 hw/i386/pc_sysfw.c         | 2 +-
 hw/ppc/spapr_drc.c         | 4 ++--
 qom/object.c               | 7 +------
 qom/object_interfaces.c    | 3 +--
 tests/check-qom-proplist.c | 2 +-
 7 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 7458fefc7b..15af9dbbc8 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1047,7 +1047,7 @@ ObjectProperty *object_property_add(Object *obj, cons=
t char *name,
                                     ObjectPropertyRelease *release,
                                     void *opaque);
=20
-void object_property_del(Object *obj, const char *name, Error **errp);
+void object_property_del(Object *obj, const char *name);
=20
 ObjectProperty *object_class_property_add(ObjectClass *klass, const char *=
name,
                                           const char *type,
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 64ac9829bd..e26e5a75c9 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -64,7 +64,7 @@ static void bus_remove_child(BusState *bus, DeviceState *=
child)
             bus->num_children--;
=20
             /* This gives back ownership of kid->child back to us.  */
-            object_property_del(OBJECT(bus), name, NULL);
+            object_property_del(OBJECT(bus), name);
             object_unref(OBJECT(kid->child));
             g_free(kid);
             return;
diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index 002133a2d8..2abab3a27c 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -120,7 +120,7 @@ static void pc_system_flash_cleanup_unused(PCMachineSta=
te *pcms)
         dev_obj =3D OBJECT(pcms->flash[i]);
         if (!object_property_get_bool(dev_obj, "realized", &error_abort)) =
{
             prop_name =3D g_strdup_printf("pflash%d", i);
-            object_property_del(OBJECT(pcms), prop_name, &error_abort);
+            object_property_del(OBJECT(pcms), prop_name);
             g_free(prop_name);
             object_unparent(dev_obj);
             pcms->flash[i] =3D NULL;
diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 8b2171f698..b958f8acb5 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -405,7 +405,7 @@ static void spapr_drc_release(SpaprDrc *drc)
     g_free(drc->fdt);
     drc->fdt =3D NULL;
     drc->fdt_start_offset =3D 0;
-    object_property_del(OBJECT(drc), "device", &error_abort);
+    object_property_del(OBJECT(drc), "device");
     drc->dev =3D NULL;
 }
=20
@@ -551,7 +551,7 @@ static void unrealize(DeviceState *d)
     vmstate_unregister(VMSTATE_IF(drc), &vmstate_spapr_drc, drc);
     root_container =3D container_get(object_get_root(), DRC_CONTAINER_PATH=
);
     name =3D g_strdup_printf("%x", spapr_drc_index(drc));
-    object_property_del(root_container, name, &error_abort);
+    object_property_del(root_container, name);
     g_free(name);
 }
=20
diff --git a/qom/object.c b/qom/object.c
index 14c7efe127..424cc20987 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1280,15 +1280,10 @@ ObjectProperty *object_class_property_find(ObjectCl=
ass *klass, const char *name,
     return prop;
 }
=20
-void object_property_del(Object *obj, const char *name, Error **errp)
+void object_property_del(Object *obj, const char *name)
 {
     ObjectProperty *prop =3D g_hash_table_lookup(obj->properties, name);
=20
-    if (!prop) {
-        error_setg(errp, "Property '.%s' not found", name);
-        return;
-    }
-
     if (prop->release) {
         prop->release(obj, name, prop->opaque);
     }
diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
index 54e14a3a14..5684ed0483 100644
--- a/qom/object_interfaces.c
+++ b/qom/object_interfaces.c
@@ -88,8 +88,7 @@ Object *user_creatable_add_type(const char *type, const c=
har *id,
     user_creatable_complete(USER_CREATABLE(obj), &local_err);
     if (local_err) {
         if (id !=3D NULL) {
-            object_property_del(object_get_objects_root(),
-                                id, &error_abort);
+            object_property_del(object_get_objects_root(), id);
         }
         goto out;
     }
diff --git a/tests/check-qom-proplist.c b/tests/check-qom-proplist.c
index 84f48fe592..13a824cfae 100644
--- a/tests/check-qom-proplist.c
+++ b/tests/check-qom-proplist.c
@@ -280,7 +280,7 @@ static void dummy_bus_init(Object *obj)
 static void dummy_bus_unparent(Object *obj)
 {
     DummyBus *bus =3D DUMMY_BUS(obj);
-    object_property_del(obj->parent, "backend", NULL);
+    object_property_del(obj->parent, "backend");
     object_unparent(OBJECT(bus->backend));
 }
=20
--=20
2.21.1


