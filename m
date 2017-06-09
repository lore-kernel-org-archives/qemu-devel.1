Received: from eggs.gnu.org ([2001:4830:134:3::10]:38241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dJKGE-0000b9-6k
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 09:47:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dJKGC-0003Vh-Js
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 09:47:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45751)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dJKGC-0003VM-Ai
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 09:47:32 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 50A2281222
	for <qemu-devel@nongnu.org>; Fri,  9 Jun 2017 13:47:31 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  9 Jun 2017 15:46:45 +0200
Message-Id: <1497016045-6009-2-git-send-email-armbru@redhat.com>
In-Reply-To: <1497016045-6009-1-git-send-email-armbru@redhat.com>
References: <1497016045-6009-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 01/41] qdev: remove PropertyInfo.qtype field
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

Remove dependency on qapi qtype, replace a field by a few PropertyInfo
callbacks to set the default value type (introduced in commit 4f2d3d7).

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20170607163635.17635-2-marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/core/qdev-properties.c    | 35 ++++++++++++++++++++++++++++++++++-
 hw/core/qdev.c               | 13 ++-----------
 include/hw/qdev-core.h       |  2 +-
 include/hw/qdev-properties.h |  5 -----
 4 files changed, 37 insertions(+), 18 deletions(-)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 9f1a497..c5e028a 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -69,6 +69,12 @@ static void set_enum(Object *obj, Visitor *v, const ch=
ar *name, void *opaque,
     visit_type_enum(v, prop->name, ptr, prop->info->enum_table, errp);
 }
=20
+static void set_default_value_enum(Object *obj, const Property *prop)
+{
+    object_property_set_str(obj, prop->info->enum_table[prop->defval],
+                            prop->name, &error_abort);
+}
+
 /* Bit */
=20
 static uint32_t qdev_get_prop_mask(Property *prop)
@@ -120,11 +126,17 @@ static void prop_set_bit(Object *obj, Visitor *v, c=
onst char *name,
     bit_prop_set(dev, prop, value);
 }
=20
+static void set_default_value_bool(Object *obj, const Property *prop)
+{
+    object_property_set_bool(obj, prop->defval, prop->name, &error_abort=
);
+}
+
 PropertyInfo qdev_prop_bit =3D {
     .name  =3D "bool",
     .description =3D "on/off",
     .get   =3D prop_get_bit,
     .set   =3D prop_set_bit,
+    .set_default_value =3D set_default_value_bool,
 };
=20
 /* Bit64 */
@@ -183,6 +195,7 @@ PropertyInfo qdev_prop_bit64 =3D {
     .description =3D "on/off",
     .get   =3D prop_get_bit64,
     .set   =3D prop_set_bit64,
+    .set_default_value =3D set_default_value_bool,
 };
=20
 /* --- bool --- */
@@ -216,6 +229,7 @@ PropertyInfo qdev_prop_bool =3D {
     .name  =3D "bool",
     .get   =3D get_bool,
     .set   =3D set_bool,
+    .set_default_value =3D set_default_value_bool,
 };
=20
 /* --- 8bit integer --- */
@@ -245,10 +259,16 @@ static void set_uint8(Object *obj, Visitor *v, cons=
t char *name, void *opaque,
     visit_type_uint8(v, name, ptr, errp);
 }
=20
+static void set_default_value_int(Object *obj, const Property *prop)
+{
+    object_property_set_int(obj, prop->defval, prop->name, &error_abort)=
;
+}
+
 PropertyInfo qdev_prop_uint8 =3D {
     .name  =3D "uint8",
     .get   =3D get_uint8,
     .set   =3D set_uint8,
+    .set_default_value =3D set_default_value_int,
 };
=20
 /* --- 16bit integer --- */
@@ -282,6 +302,7 @@ PropertyInfo qdev_prop_uint16 =3D {
     .name  =3D "uint16",
     .get   =3D get_uint16,
     .set   =3D set_uint16,
+    .set_default_value =3D set_default_value_int,
 };
=20
 /* --- 32bit integer --- */
@@ -340,12 +361,14 @@ PropertyInfo qdev_prop_uint32 =3D {
     .name  =3D "uint32",
     .get   =3D get_uint32,
     .set   =3D set_uint32,
+    .set_default_value =3D set_default_value_int,
 };
=20
 PropertyInfo qdev_prop_int32 =3D {
     .name  =3D "int32",
     .get   =3D get_int32,
     .set   =3D set_int32,
+    .set_default_value =3D set_default_value_int,
 };
=20
 /* --- 64bit integer --- */
@@ -379,6 +402,7 @@ PropertyInfo qdev_prop_uint64 =3D {
     .name  =3D "uint64",
     .get   =3D get_uint64,
     .set   =3D set_uint64,
+    .set_default_value =3D set_default_value_int,
 };
=20
 /* --- string --- */
@@ -526,6 +550,7 @@ PropertyInfo qdev_prop_on_off_auto =3D {
     .enum_table =3D OnOffAuto_lookup,
     .get =3D get_enum,
     .set =3D set_enum,
+    .set_default_value =3D set_default_value_enum,
 };
=20
 /* --- lost tick policy --- */
@@ -537,6 +562,7 @@ PropertyInfo qdev_prop_losttickpolicy =3D {
     .enum_table  =3D LostTickPolicy_lookup,
     .get   =3D get_enum,
     .set   =3D set_enum,
+    .set_default_value =3D set_default_value_enum,
 };
=20
 /* --- Block device error handling policy --- */
@@ -550,6 +576,7 @@ PropertyInfo qdev_prop_blockdev_on_error =3D {
     .enum_table =3D BlockdevOnError_lookup,
     .get =3D get_enum,
     .set =3D set_enum,
+    .set_default_value =3D set_default_value_enum,
 };
=20
 /* --- BIOS CHS translation */
@@ -563,6 +590,7 @@ PropertyInfo qdev_prop_bios_chs_trans =3D {
     .enum_table =3D BiosAtaTranslation_lookup,
     .get =3D get_enum,
     .set =3D set_enum,
+    .set_default_value =3D set_default_value_enum,
 };
=20
 /* --- FDC default drive types */
@@ -573,7 +601,8 @@ PropertyInfo qdev_prop_fdc_drive_type =3D {
                    "144/288/120/none/auto",
     .enum_table =3D FloppyDriveType_lookup,
     .get =3D get_enum,
-    .set =3D set_enum
+    .set =3D set_enum,
+    .set_default_value =3D set_default_value_enum,
 };
=20
 /* --- pci address --- */
@@ -648,6 +677,7 @@ PropertyInfo qdev_prop_pci_devfn =3D {
     .print =3D print_pci_devfn,
     .get   =3D get_int32,
     .set   =3D set_pci_devfn,
+    .set_default_value =3D set_default_value_int,
 };
=20
 /* --- blocksize --- */
@@ -695,6 +725,7 @@ PropertyInfo qdev_prop_blocksize =3D {
     .description =3D "A power of two between 512 and 32768",
     .get   =3D get_uint16,
     .set   =3D set_blocksize,
+    .set_default_value =3D set_default_value_int,
 };
=20
 /* --- pci host address --- */
@@ -917,6 +948,7 @@ PropertyInfo qdev_prop_arraylen =3D {
     .name =3D "uint32",
     .get =3D get_uint32,
     .set =3D set_prop_arraylen,
+    .set_default_value =3D set_default_value_int,
 };
=20
 /* --- public helpers --- */
@@ -1153,4 +1185,5 @@ PropertyInfo qdev_prop_size =3D {
     .name  =3D "size",
     .get =3D get_size,
     .set =3D set_size,
+    .set_default_value =3D set_default_value_int,
 };
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 0ce45a2..849952a 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -793,17 +793,8 @@ void qdev_property_add_static(DeviceState *dev, Prop=
erty *prop,
                                     prop->info->description,
                                     &error_abort);
=20
-    if (prop->qtype =3D=3D QTYPE_NONE) {
-        return;
-    }
-
-    if (prop->qtype =3D=3D QTYPE_QBOOL) {
-        object_property_set_bool(obj, prop->defval, prop->name, &error_a=
bort);
-    } else if (prop->info->enum_table) {
-        object_property_set_str(obj, prop->info->enum_table[prop->defval=
],
-                                prop->name, &error_abort);
-    } else if (prop->qtype =3D=3D QTYPE_QINT) {
-        object_property_set_int(obj, prop->defval, prop->name, &error_ab=
ort);
+    if (prop->info->set_default_value) {
+        prop->info->set_default_value(obj, prop);
     }
 }
=20
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index e69489e..9523339 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -226,7 +226,6 @@ struct Property {
     PropertyInfo *info;
     ptrdiff_t    offset;
     uint8_t      bitnr;
-    QType        qtype;
     int64_t      defval;
     int          arrayoffset;
     PropertyInfo *arrayinfo;
@@ -238,6 +237,7 @@ struct PropertyInfo {
     const char *description;
     const char * const *enum_table;
     int (*print)(DeviceState *dev, Property *prop, char *dest, size_t le=
n);
+    void (*set_default_value)(Object *obj, const Property *prop);
     ObjectPropertyAccessor *get;
     ObjectPropertyAccessor *set;
     ObjectPropertyRelease *release;
diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index d206fc9..85e6899 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -42,7 +42,6 @@ extern PropertyInfo qdev_prop_arraylen;
         .info      =3D &(_prop),                                        =
  \
         .offset    =3D offsetof(_state, _field)                         =
  \
             + type_check(_type,typeof_field(_state, _field)),           =
\
-        .qtype     =3D QTYPE_QINT,                                      =
  \
         .defval    =3D (_type)_defval,                                  =
  \
         }
 #define DEFINE_PROP_BIT(_name, _state, _field, _bit, _defval) {  \
@@ -51,7 +50,6 @@ extern PropertyInfo qdev_prop_arraylen;
         .bitnr    =3D (_bit),                                      \
         .offset    =3D offsetof(_state, _field)                    \
             + type_check(uint32_t,typeof_field(_state, _field)), \
-        .qtype     =3D QTYPE_QBOOL,                                \
         .defval    =3D (bool)_defval,                              \
         }
 #define DEFINE_PROP_BIT64(_name, _state, _field, _bit, _defval) {       =
\
@@ -60,7 +58,6 @@ extern PropertyInfo qdev_prop_arraylen;
         .bitnr    =3D (_bit),                                           =
  \
         .offset    =3D offsetof(_state, _field)                         =
  \
             + type_check(uint64_t, typeof_field(_state, _field)),       =
\
-        .qtype     =3D QTYPE_QBOOL,                                     =
  \
         .defval    =3D (bool)_defval,                                   =
  \
         }
=20
@@ -69,7 +66,6 @@ extern PropertyInfo qdev_prop_arraylen;
         .info      =3D &(qdev_prop_bool),                          \
         .offset    =3D offsetof(_state, _field)                    \
             + type_check(bool, typeof_field(_state, _field)),    \
-        .qtype     =3D QTYPE_QBOOL,                                \
         .defval    =3D (bool)_defval,                              \
         }
=20
@@ -105,7 +101,6 @@ extern PropertyInfo qdev_prop_arraylen;
         .info =3D &(qdev_prop_arraylen),                                =
  \
         .offset =3D offsetof(_state, _field)                            =
  \
             + type_check(uint32_t, typeof_field(_state, _field)),       =
\
-        .qtype =3D QTYPE_QINT,                                          =
  \
         .arrayinfo =3D &(_arrayprop),                                   =
  \
         .arrayfieldsize =3D sizeof(_arraytype),                         =
  \
         .arrayoffset =3D offsetof(_state, _arrayfield),                 =
  \
--=20
2.7.5
