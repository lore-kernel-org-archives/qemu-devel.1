Received: from eggs.gnu.org ([2001:4830:134:3::10]:45071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dNITA-0004FU-I1
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 08:41:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dNIT8-0002CP-AM
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 08:41:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34766)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dNIT7-0002BL-U2
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 08:41:18 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DCD1E4AC8
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 12:41:16 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 20 Jun 2017 14:40:43 +0200
Message-Id: <1497962468-22936-17-git-send-email-armbru@redhat.com>
In-Reply-To: <1497962468-22936-1-git-send-email-armbru@redhat.com>
References: <1497962468-22936-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 16/41] qdev: wrap default property value in
 an union
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

Wrap the Property default value (an int64_t) in a union, to prepare
for the next patch adding a uint64_t.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20170607163635.17635-17-marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/core/qdev-properties.c    | 6 +++---
 include/hw/qdev-core.h       | 4 +++-
 include/hw/qdev-properties.h | 8 ++++----
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index c5e028a..f3f682c 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -71,7 +71,7 @@ static void set_enum(Object *obj, Visitor *v, const cha=
r *name, void *opaque,
=20
 static void set_default_value_enum(Object *obj, const Property *prop)
 {
-    object_property_set_str(obj, prop->info->enum_table[prop->defval],
+    object_property_set_str(obj, prop->info->enum_table[prop->defval.i],
                             prop->name, &error_abort);
 }
=20
@@ -128,7 +128,7 @@ static void prop_set_bit(Object *obj, Visitor *v, con=
st char *name,
=20
 static void set_default_value_bool(Object *obj, const Property *prop)
 {
-    object_property_set_bool(obj, prop->defval, prop->name, &error_abort=
);
+    object_property_set_bool(obj, prop->defval.i, prop->name, &error_abo=
rt);
 }
=20
 PropertyInfo qdev_prop_bit =3D {
@@ -261,7 +261,7 @@ static void set_uint8(Object *obj, Visitor *v, const =
char *name, void *opaque,
=20
 static void set_default_value_int(Object *obj, const Property *prop)
 {
-    object_property_set_int(obj, prop->defval, prop->name, &error_abort)=
;
+    object_property_set_int(obj, prop->defval.i, prop->name, &error_abor=
t);
 }
=20
 PropertyInfo qdev_prop_uint8 =3D {
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 9523339..784971b 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -226,7 +226,9 @@ struct Property {
     PropertyInfo *info;
     ptrdiff_t    offset;
     uint8_t      bitnr;
-    int64_t      defval;
+    union {
+        int64_t i;
+    } defval;
     int          arrayoffset;
     PropertyInfo *arrayinfo;
     int          arrayfieldsize;
diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index 0560380..34524d0 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -42,7 +42,7 @@ extern PropertyInfo qdev_prop_arraylen;
         .info      =3D &(_prop),                                        =
  \
         .offset    =3D offsetof(_state, _field)                         =
  \
             + type_check(_type,typeof_field(_state, _field)),           =
\
-        .defval    =3D (_type)_defval,                                  =
  \
+        .defval.i  =3D (_type)_defval,                                  =
  \
         }
 #define DEFINE_PROP_BIT(_name, _state, _field, _bit, _defval) {  \
         .name      =3D (_name),                                    \
@@ -50,7 +50,7 @@ extern PropertyInfo qdev_prop_arraylen;
         .bitnr    =3D (_bit),                                      \
         .offset    =3D offsetof(_state, _field)                    \
             + type_check(uint32_t,typeof_field(_state, _field)), \
-        .defval    =3D (bool)_defval,                              \
+        .defval.i  =3D (bool)_defval,                              \
         }
 #define DEFINE_PROP_BIT64(_name, _state, _field, _bit, _defval) {       =
\
         .name      =3D (_name),                                         =
  \
@@ -58,7 +58,7 @@ extern PropertyInfo qdev_prop_arraylen;
         .bitnr    =3D (_bit),                                           =
  \
         .offset    =3D offsetof(_state, _field)                         =
  \
             + type_check(uint64_t, typeof_field(_state, _field)),       =
\
-        .defval    =3D (bool)_defval,                                   =
  \
+        .defval.i  =3D (bool)_defval,                                   =
  \
         }
=20
 #define DEFINE_PROP_BOOL(_name, _state, _field, _defval) {       \
@@ -66,7 +66,7 @@ extern PropertyInfo qdev_prop_arraylen;
         .info      =3D &(qdev_prop_bool),                          \
         .offset    =3D offsetof(_state, _field)                    \
             + type_check(bool, typeof_field(_state, _field)),    \
-        .defval    =3D (bool)_defval,                              \
+        .defval.i  =3D (bool)_defval,                              \
         }
=20
 #define PROP_ARRAY_LEN_PREFIX "len-"
--=20
2.7.5
