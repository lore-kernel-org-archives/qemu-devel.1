Received: from eggs.gnu.org ([2001:4830:134:3::10]:52608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dG4AE-0005NF-LA
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:59:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dG4AD-0004OZ-Cw
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:59:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:11226)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dG4AD-0004O5-4r
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:59:53 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 16B2861D11
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 13:59:52 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 31 May 2017 17:56:43 +0400
Message-Id: <20170531135709.345-20-marcandre.lureau@redhat.com>
In-Reply-To: <20170531135709.345-1-marcandre.lureau@redhat.com>
References: <20170531135709.345-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 19/45] qdev: add unsigned properties
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

Add and use unsigned type for various properties.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/hw/qdev-core.h       |  1 +
 include/hw/qdev-properties.h | 51 +++++++++++++++++++++++++++-----------=
------
 hw/core/qdev-properties.c    | 23 ++++++++++++--------
 3 files changed, 46 insertions(+), 29 deletions(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 784971b8d8..9d7c1c0e9b 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -228,6 +228,7 @@ struct Property {
     uint8_t      bitnr;
     union {
         int64_t i;
+        uint64_t u;
     } defval;
     int          arrayoffset;
     PropertyInfo *arrayinfo;
diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index 6663a547ea..16d3ada8df 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -37,6 +37,7 @@ extern PropertyInfo qdev_prop_arraylen;
         .offset    =3D offsetof(_state, _field)                    \
             + type_check(_type, typeof_field(_state, _field)),   \
         }
+
 #define DEFINE_PROP_INT(_name, _state, _field, _defval, _prop, _type) { =
\
         .name      =3D (_name),                                         =
  \
         .info      =3D &(_prop),                                        =
  \
@@ -44,29 +45,39 @@ extern PropertyInfo qdev_prop_arraylen;
             + type_check(_type,typeof_field(_state, _field)),           =
\
         .defval.i  =3D (_type)_defval,                                  =
  \
         }
-#define DEFINE_PROP_BIT(_name, _state, _field, _bit, _defval) {  \
-        .name      =3D (_name),                                    \
-        .info      =3D &(qdev_prop_bit),                           \
-        .bitnr    =3D (_bit),                                      \
-        .offset    =3D offsetof(_state, _field)                    \
-            + type_check(uint32_t,typeof_field(_state, _field)), \
-        .defval.i  =3D (bool)_defval,                              \
+
+#define DEFINE_PROP_BIT(_name, _state, _field, _bit, _defval) {         =
\
+        .name      =3D (_name),                                         =
  \
+        .info      =3D &(qdev_prop_bit),                                =
  \
+        .bitnr    =3D (_bit),                                           =
  \
+        .offset    =3D offsetof(_state, _field)                         =
  \
+            + type_check(uint32_t, typeof_field(_state, _field)),       =
 \
+        .defval.u   =3D (bool)_defval,                                  =
  \
         }
+
+#define DEFINE_PROP_UINT(_name, _state, _field, _defval, _prop, _type) {=
 \
+        .name      =3D (_name),                                         =
  \
+        .info      =3D &(_prop),                                        =
  \
+        .offset    =3D offsetof(_state, _field)                         =
  \
+            + type_check(_type, typeof_field(_state, _field)),          =
\
+        .defval.u  =3D (_type)_defval,                                  =
  \
+        }
+
 #define DEFINE_PROP_BIT64(_name, _state, _field, _bit, _defval) {       =
\
         .name      =3D (_name),                                         =
  \
         .info      =3D &(qdev_prop_bit64),                              =
  \
         .bitnr    =3D (_bit),                                           =
  \
         .offset    =3D offsetof(_state, _field)                         =
  \
             + type_check(uint64_t, typeof_field(_state, _field)),       =
\
-        .defval.i  =3D (bool)_defval,                                   =
  \
+        .defval.u  =3D (bool)_defval,                                   =
  \
         }
=20
-#define DEFINE_PROP_BOOL(_name, _state, _field, _defval) {       \
-        .name      =3D (_name),                                    \
-        .info      =3D &(qdev_prop_bool),                          \
-        .offset    =3D offsetof(_state, _field)                    \
-            + type_check(bool, typeof_field(_state, _field)),    \
-        .defval.i  =3D (bool)_defval,                              \
+#define DEFINE_PROP_BOOL(_name, _state, _field, _defval) {      \
+        .name      =3D (_name),                                   \
+        .info      =3D &(qdev_prop_bool),                         \
+        .offset    =3D offsetof(_state, _field)                   \
+            + type_check(bool, typeof_field(_state, _field)),   \
+        .defval.u    =3D (bool)_defval,                           \
         }
=20
 #define PROP_ARRAY_LEN_PREFIX "len-"
@@ -107,17 +118,17 @@ extern PropertyInfo qdev_prop_arraylen;
         }
=20
 #define DEFINE_PROP_UINT8(_n, _s, _f, _d)                       \
-    DEFINE_PROP_INT(_n, _s, _f, _d, qdev_prop_uint8, uint8_t)
+    DEFINE_PROP_UINT(_n, _s, _f, _d, qdev_prop_uint8, uint8_t)
 #define DEFINE_PROP_UINT16(_n, _s, _f, _d)                      \
-    DEFINE_PROP_INT(_n, _s, _f, _d, qdev_prop_uint16, uint16_t)
+    DEFINE_PROP_UINT(_n, _s, _f, _d, qdev_prop_uint16, uint16_t)
 #define DEFINE_PROP_UINT32(_n, _s, _f, _d)                      \
-    DEFINE_PROP_INT(_n, _s, _f, _d, qdev_prop_uint32, uint32_t)
+    DEFINE_PROP_UINT(_n, _s, _f, _d, qdev_prop_uint32, uint32_t)
 #define DEFINE_PROP_INT32(_n, _s, _f, _d)                      \
     DEFINE_PROP_INT(_n, _s, _f, _d, qdev_prop_int32, int32_t)
 #define DEFINE_PROP_UINT64(_n, _s, _f, _d)                      \
-    DEFINE_PROP_INT(_n, _s, _f, _d, qdev_prop_uint64, uint64_t)
+    DEFINE_PROP_UINT(_n, _s, _f, _d, qdev_prop_uint64, uint64_t)
 #define DEFINE_PROP_SIZE(_n, _s, _f, _d)                       \
-    DEFINE_PROP_INT(_n, _s, _f, _d, qdev_prop_size, uint64_t)
+    DEFINE_PROP_UINT(_n, _s, _f, _d, qdev_prop_size, uint64_t)
 #define DEFINE_PROP_PCI_DEVFN(_n, _s, _f, _d)                   \
     DEFINE_PROP_INT(_n, _s, _f, _d, qdev_prop_pci_devfn, int32_t)
=20
@@ -163,7 +174,7 @@ extern PropertyInfo qdev_prop_arraylen;
 #define DEFINE_PROP_BIOS_CHS_TRANS(_n, _s, _f, _d) \
     DEFINE_PROP_INT(_n, _s, _f, _d, qdev_prop_bios_chs_trans, int)
 #define DEFINE_PROP_BLOCKSIZE(_n, _s, _f) \
-    DEFINE_PROP_INT(_n, _s, _f, 0, qdev_prop_blocksize, uint16_t)
+    DEFINE_PROP_UINT(_n, _s, _f, 0, qdev_prop_blocksize, uint16_t)
 #define DEFINE_PROP_PCI_HOST_DEVADDR(_n, _s, _f) \
     DEFINE_PROP(_n, _s, _f, qdev_prop_pci_host_devaddr, PCIHostDeviceAdd=
ress)
=20
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 952cda7758..92fb43cb0d 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -71,7 +71,7 @@ static void set_enum(Object *obj, Visitor *v, const cha=
r *name, void *opaque,
=20
 static void set_default_value_enum(Object *obj, const Property *prop)
 {
-    object_property_set_str(obj, prop->info->enum_table[prop->defval.i],
+    object_property_set_str(obj, prop->info->enum_table[prop->defval.u],
                             prop->name, &error_abort);
 }
=20
@@ -128,7 +128,7 @@ static void prop_set_bit(Object *obj, Visitor *v, con=
st char *name,
=20
 static void set_default_value_bool(Object *obj, const Property *prop)
 {
-    object_property_set_bool(obj, prop->defval.i, prop->name, &error_abo=
rt);
+    object_property_set_bool(obj, prop->defval.u, prop->name, &error_abo=
rt);
 }
=20
 PropertyInfo qdev_prop_bit =3D {
@@ -264,11 +264,16 @@ static void set_default_value_int(Object *obj, cons=
t Property *prop)
     object_property_set_int(obj, prop->defval.i, prop->name, &error_abor=
t);
 }
=20
+static void set_default_value_uint(Object *obj, const Property *prop)
+{
+    object_property_set_uint(obj, prop->defval.u, prop->name, &error_abo=
rt);
+}
+
 PropertyInfo qdev_prop_uint8 =3D {
     .name  =3D "uint8",
     .get   =3D get_uint8,
     .set   =3D set_uint8,
-    .set_default_value =3D set_default_value_int,
+    .set_default_value =3D set_default_value_uint,
 };
=20
 /* --- 16bit integer --- */
@@ -302,7 +307,7 @@ PropertyInfo qdev_prop_uint16 =3D {
     .name  =3D "uint16",
     .get   =3D get_uint16,
     .set   =3D set_uint16,
-    .set_default_value =3D set_default_value_int,
+    .set_default_value =3D set_default_value_uint,
 };
=20
 /* --- 32bit integer --- */
@@ -361,7 +366,7 @@ PropertyInfo qdev_prop_uint32 =3D {
     .name  =3D "uint32",
     .get   =3D get_uint32,
     .set   =3D set_uint32,
-    .set_default_value =3D set_default_value_int,
+    .set_default_value =3D set_default_value_uint,
 };
=20
 PropertyInfo qdev_prop_int32 =3D {
@@ -402,7 +407,7 @@ PropertyInfo qdev_prop_uint64 =3D {
     .name  =3D "uint64",
     .get   =3D get_uint64,
     .set   =3D set_uint64,
-    .set_default_value =3D set_default_value_int,
+    .set_default_value =3D set_default_value_uint,
 };
=20
 /* --- string --- */
@@ -725,7 +730,7 @@ PropertyInfo qdev_prop_blocksize =3D {
     .description =3D "A power of two between 512 and 32768",
     .get   =3D get_uint16,
     .set   =3D set_blocksize,
-    .set_default_value =3D set_default_value_int,
+    .set_default_value =3D set_default_value_uint,
 };
=20
 /* --- pci host address --- */
@@ -948,7 +953,7 @@ PropertyInfo qdev_prop_arraylen =3D {
     .name =3D "uint32",
     .get =3D get_uint32,
     .set =3D set_prop_arraylen,
-    .set_default_value =3D set_default_value_int,
+    .set_default_value =3D set_default_value_uint,
 };
=20
 /* --- public helpers --- */
@@ -1185,5 +1190,5 @@ PropertyInfo qdev_prop_size =3D {
     .name  =3D "size",
     .get =3D get_size,
     .set =3D set_size,
-    .set_default_value =3D set_default_value_int,
+    .set_default_value =3D set_default_value_uint,
 };
--=20
2.13.0.91.g00982b8dd
