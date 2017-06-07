Received: from eggs.gnu.org ([2001:4830:134:3::10]:33327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dIdz2-000893-8T
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 12:39:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dIdyw-0007pJ-F4
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 12:39:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41346)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dIdyw-0007o6-65
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 12:38:54 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 37A2237EEE
	for <qemu-devel@nongnu.org>; Wed,  7 Jun 2017 16:38:53 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  7 Jun 2017 20:36:08 +0400
Message-Id: <20170607163635.17635-17-marcandre.lureau@redhat.com>
In-Reply-To: <20170607163635.17635-1-marcandre.lureau@redhat.com>
References: <20170607163635.17635-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 16/43] qdev: wrap default property value in
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
Cc: armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Wrap the Property default value (an int64_t) in a union, to prepare
for the next patch adding a uint64_t.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/hw/qdev-core.h       | 4 +++-
 include/hw/qdev-properties.h | 8 ++++----
 hw/core/qdev-properties.c    | 6 +++---
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 9523339762..784971b8d8 100644
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
index 05603805cb..34524d0bfe 100644
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
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index c5e028a45e..f3f682c611 100644
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
--=20
2.13.0.91.g00982b8dd
