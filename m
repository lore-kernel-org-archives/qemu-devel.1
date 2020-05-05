Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B5A6C47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 15:38:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66A02206B9
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 15:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XEw8Ri4B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66A02206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVzeO-0004Iu-As
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 11:38:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46002)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jVzVr-0003OU-73
 for qemu-devel@nongnu.org; Tue, 05 May 2020 11:29:39 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41519)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jVzVn-0007RR-A5
 for qemu-devel@nongnu.org; Tue, 05 May 2020 11:29:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588692573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kBtM3zIW9dthrt5vgz9AzzxJghrxgkviKsCOyjI5V38=;
 b=XEw8Ri4BSWu/O1xXenFITYaexg0YCJ15dNr9ycG34RvmAIAF/SnOgXMLFk0aO3Bcq7GfWo
 dRwz5HyiZHEUHGRoF6v1NkvIn/PlRYjsERnZw3Cb49pvrkSK7ID5c/rD1KMwElLpbjKNIn
 mJb6PTAM5dQMsqQjsL0crdkMcFaI51o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-xP_tXZ4EPKiGpGrF9mtcVg-1; Tue, 05 May 2020 11:29:32 -0400
X-MC-Unique: xP_tXZ4EPKiGpGrF9mtcVg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2ED33800D24
 for <qemu-devel@nongnu.org>; Tue,  5 May 2020 15:29:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C906E6061C;
 Tue,  5 May 2020 15:29:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6DAC111358CF; Tue,  5 May 2020 17:29:26 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 18/18] qom: Drop @errp parameter of object_property_del()
Date: Tue,  5 May 2020 17:29:26 +0200
Message-Id: <20200505152926.18877-19-armbru@redhat.com>
In-Reply-To: <20200505152926.18877-1-armbru@redhat.com>
References: <20200505152926.18877-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:40
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 philmd@redhat.com
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

Drop the @errp parameter.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
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
index 990e28e408..fd453dc8d6 100644
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
index b9c7a2f904..9e5538aeae 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -65,7 +65,7 @@ static void bus_remove_child(BusState *bus, DeviceState *=
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
index 23f481ca46..e89ffbe3d1 100644
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
index 054e75043d..7e26f86fa6 100644
--- a/qom/object_interfaces.c
+++ b/qom/object_interfaces.c
@@ -89,8 +89,7 @@ Object *user_creatable_add_type(const char *type, const c=
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


