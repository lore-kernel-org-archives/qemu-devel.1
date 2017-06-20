Received: from eggs.gnu.org ([2001:4830:134:3::10]:45267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dNITH-0004Mf-0U
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 08:41:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dNITA-0002Fb-Le
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 08:41:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37726)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dNITA-0002Dz-7k
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 08:41:20 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 085EE40F09
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 12:41:19 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 20 Jun 2017 14:40:45 +0200
Message-Id: <1497962468-22936-19-git-send-email-armbru@redhat.com>
In-Reply-To: <1497962468-22936-1-git-send-email-armbru@redhat.com>
References: <1497962468-22936-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 18/41] apic-common: make "id" property a
 uint32
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

The getter and setter of TYPE_APIC_COMMON property "id" are
apic_common_get_id() and apic_common_set_id().

apic_common_get_id() reads either APICCommonState member uint32_t
initial_apic_id or uint8_t id into an int64_t local variable.  It then
passes this variable to visit_type_int().

apic_common_set_id() uses visit_type_int() to read the value into a
local variable, which it then assigns both to initial_apic_id and id.

While the state backing the property is two unsigned members, 8 and 32
bits wide, the actual visitor is 64 bits signed.

Change getter and setter to use visit_type_uint32().  Then everything's
uint32_t, except for @id.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20170607163635.17635-19-marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/intc/apic_common.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
index 1ef56f8..e1ac330 100644
--- a/hw/intc/apic_common.c
+++ b/hw/intc/apic_common.c
@@ -450,10 +450,10 @@ static void apic_common_get_id(Object *obj, Visitor=
 *v, const char *name,
                                void *opaque, Error **errp)
 {
     APICCommonState *s =3D APIC_COMMON(obj);
-    int64_t value;
+    uint32_t value;
=20
     value =3D s->apicbase & MSR_IA32_APICBASE_EXTD ? s->initial_apic_id =
: s->id;
-    visit_type_int(v, name, &value, errp);
+    visit_type_uint32(v, name, &value, errp);
 }
=20
 static void apic_common_set_id(Object *obj, Visitor *v, const char *name=
,
@@ -462,14 +462,14 @@ static void apic_common_set_id(Object *obj, Visitor=
 *v, const char *name,
     APICCommonState *s =3D APIC_COMMON(obj);
     DeviceState *dev =3D DEVICE(obj);
     Error *local_err =3D NULL;
-    int64_t value;
+    uint32_t value;
=20
     if (dev->realized) {
         qdev_prop_set_after_realize(dev, name, errp);
         return;
     }
=20
-    visit_type_int(v, name, &value, &local_err);
+    visit_type_uint32(v, name, &value, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
@@ -484,7 +484,7 @@ static void apic_common_initfn(Object *obj)
     APICCommonState *s =3D APIC_COMMON(obj);
=20
     s->id =3D s->initial_apic_id =3D -1;
-    object_property_add(obj, "id", "int",
+    object_property_add(obj, "id", "uint32",
                         apic_common_get_id,
                         apic_common_set_id, NULL, NULL, NULL);
 }
--=20
2.7.5
