Received: from eggs.gnu.org ([2001:4830:134:3::10]:51782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dno1W-0006na-L5
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:38:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dno1R-0001og-Oc
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:38:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59066)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dno1R-0001oI-JC
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:38:17 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A099D7D0CA
	for <qemu-devel@nongnu.org>; Fri,  1 Sep 2017 15:38:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-75.ams2.redhat.com
	[10.36.116.75])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6C947957B1
	for <qemu-devel@nongnu.org>; Fri,  1 Sep 2017 15:38:12 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  1 Sep 2017 17:37:56 +0200
Message-Id: <20170901153758.8628-46-armbru@redhat.com>
In-Reply-To: <20170901153758.8628-1-armbru@redhat.com>
References: <20170901153758.8628-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 45/47] qapi: Convert indirect uses of
 FOO_lookup[...] to qapi_enum_lookup()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <1503564371-26090-15-git-send-email-armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/core/qdev-properties.c | 7 +++++--
 qapi/qapi-visit-core.c    | 2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 078fc5d239..7512bd4379 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -72,7 +72,9 @@ static void set_enum(Object *obj, Visitor *v, const cha=
r *name, void *opaque,
=20
 static void set_default_value_enum(Object *obj, const Property *prop)
 {
-    object_property_set_str(obj, prop->info->enum_table[prop->defval.i],
+    object_property_set_str(obj,
+                            qapi_enum_lookup(prop->info->enum_table,
+                                             prop->defval.i),
                             prop->name, &error_abort);
 }
=20
@@ -1095,7 +1097,8 @@ void qdev_prop_set_enum(DeviceState *dev, const cha=
r *name, int value)
     Property *prop;
=20
     prop =3D qdev_prop_find(dev, name);
-    object_property_set_str(OBJECT(dev), prop->info->enum_table[value],
+    object_property_set_str(OBJECT(dev),
+                            qapi_enum_lookup(prop->info->enum_table, val=
ue),
                             name, &error_abort);
 }
=20
diff --git a/qapi/qapi-visit-core.c b/qapi/qapi-visit-core.c
index f285879d72..30dc85b6f3 100644
--- a/qapi/qapi-visit-core.c
+++ b/qapi/qapi-visit-core.c
@@ -345,7 +345,7 @@ static void output_type_enum(Visitor *v, const char *=
name, int *obj,
         return;
     }
=20
-    enum_str =3D (char *)strings[value];
+    enum_str =3D (char *)qapi_enum_lookup(strings, value);
     visit_type_str(v, name, &enum_str, errp);
 }
=20
--=20
2.13.5
