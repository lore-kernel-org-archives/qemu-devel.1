Received: from eggs.gnu.org ([2001:4830:134:3::10]:52529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dG4A9-0005Ib-EI
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:59:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dG4A5-0004K2-8R
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:59:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50912)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dG4A4-0004Jt-VF
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:59:45 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E3D0D61BAA
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 13:59:43 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 31 May 2017 17:56:42 +0400
Message-Id: <20170531135709.345-19-marcandre.lureau@redhat.com>
In-Reply-To: <20170531135709.345-1-marcandre.lureau@redhat.com>
References: <20170531135709.345-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 18/45] qdev: make default property int
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

The following patch will add uint properties.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/hw/qdev-core.h       |  4 +++-
 include/hw/qdev-properties.h | 34 ++++++++++++++--------------
 hw/block/fdc.c               | 54 ++++++++++++++++++++++----------------=
------
 hw/core/qdev-properties.c    |  6 ++---
 hw/net/e1000e.c              | 14 ++++++------
 5 files changed, 57 insertions(+), 55 deletions(-)

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
index 85e68998a9..6663a547ea 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -37,12 +37,12 @@ extern PropertyInfo qdev_prop_arraylen;
         .offset    =3D offsetof(_state, _field)                    \
             + type_check(_type, typeof_field(_state, _field)),   \
         }
-#define DEFINE_PROP_DEFAULT(_name, _state, _field, _defval, _prop, _type=
) { \
+#define DEFINE_PROP_INT(_name, _state, _field, _defval, _prop, _type) { =
\
         .name      =3D (_name),                                         =
  \
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
@@ -107,19 +107,19 @@ extern PropertyInfo qdev_prop_arraylen;
         }
=20
 #define DEFINE_PROP_UINT8(_n, _s, _f, _d)                       \
-    DEFINE_PROP_DEFAULT(_n, _s, _f, _d, qdev_prop_uint8, uint8_t)
+    DEFINE_PROP_INT(_n, _s, _f, _d, qdev_prop_uint8, uint8_t)
 #define DEFINE_PROP_UINT16(_n, _s, _f, _d)                      \
-    DEFINE_PROP_DEFAULT(_n, _s, _f, _d, qdev_prop_uint16, uint16_t)
+    DEFINE_PROP_INT(_n, _s, _f, _d, qdev_prop_uint16, uint16_t)
 #define DEFINE_PROP_UINT32(_n, _s, _f, _d)                      \
-    DEFINE_PROP_DEFAULT(_n, _s, _f, _d, qdev_prop_uint32, uint32_t)
+    DEFINE_PROP_INT(_n, _s, _f, _d, qdev_prop_uint32, uint32_t)
 #define DEFINE_PROP_INT32(_n, _s, _f, _d)                      \
-    DEFINE_PROP_DEFAULT(_n, _s, _f, _d, qdev_prop_int32, int32_t)
+    DEFINE_PROP_INT(_n, _s, _f, _d, qdev_prop_int32, int32_t)
 #define DEFINE_PROP_UINT64(_n, _s, _f, _d)                      \
-    DEFINE_PROP_DEFAULT(_n, _s, _f, _d, qdev_prop_uint64, uint64_t)
+    DEFINE_PROP_INT(_n, _s, _f, _d, qdev_prop_uint64, uint64_t)
 #define DEFINE_PROP_SIZE(_n, _s, _f, _d)                       \
-    DEFINE_PROP_DEFAULT(_n, _s, _f, _d, qdev_prop_size, uint64_t)
+    DEFINE_PROP_INT(_n, _s, _f, _d, qdev_prop_size, uint64_t)
 #define DEFINE_PROP_PCI_DEVFN(_n, _s, _f, _d)                   \
-    DEFINE_PROP_DEFAULT(_n, _s, _f, _d, qdev_prop_pci_devfn, int32_t)
+    DEFINE_PROP_INT(_n, _s, _f, _d, qdev_prop_pci_devfn, int32_t)
=20
 /*
  * Please avoid pointer properties.  If you must use them, you must
@@ -153,17 +153,17 @@ extern PropertyInfo qdev_prop_arraylen;
 #define DEFINE_PROP_MACADDR(_n, _s, _f)         \
     DEFINE_PROP(_n, _s, _f, qdev_prop_macaddr, MACAddr)
 #define DEFINE_PROP_ON_OFF_AUTO(_n, _s, _f, _d) \
-    DEFINE_PROP_DEFAULT(_n, _s, _f, _d, qdev_prop_on_off_auto, OnOffAuto=
)
+    DEFINE_PROP_INT(_n, _s, _f, _d, qdev_prop_on_off_auto, OnOffAuto)
 #define DEFINE_PROP_LOSTTICKPOLICY(_n, _s, _f, _d) \
-    DEFINE_PROP_DEFAULT(_n, _s, _f, _d, qdev_prop_losttickpolicy, \
+    DEFINE_PROP_INT(_n, _s, _f, _d, qdev_prop_losttickpolicy, \
                         LostTickPolicy)
 #define DEFINE_PROP_BLOCKDEV_ON_ERROR(_n, _s, _f, _d) \
-    DEFINE_PROP_DEFAULT(_n, _s, _f, _d, qdev_prop_blockdev_on_error, \
+    DEFINE_PROP_INT(_n, _s, _f, _d, qdev_prop_blockdev_on_error, \
                         BlockdevOnError)
 #define DEFINE_PROP_BIOS_CHS_TRANS(_n, _s, _f, _d) \
-    DEFINE_PROP_DEFAULT(_n, _s, _f, _d, qdev_prop_bios_chs_trans, int)
+    DEFINE_PROP_INT(_n, _s, _f, _d, qdev_prop_bios_chs_trans, int)
 #define DEFINE_PROP_BLOCKSIZE(_n, _s, _f) \
-    DEFINE_PROP_DEFAULT(_n, _s, _f, 0, qdev_prop_blocksize, uint16_t)
+    DEFINE_PROP_INT(_n, _s, _f, 0, qdev_prop_blocksize, uint16_t)
 #define DEFINE_PROP_PCI_HOST_DEVADDR(_n, _s, _f) \
     DEFINE_PROP(_n, _s, _f, qdev_prop_pci_host_devaddr, PCIHostDeviceAdd=
ress)
=20
diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index 2e629b398b..07ce4a0d20 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -511,9 +511,9 @@ typedef struct FloppyDrive {
 static Property floppy_drive_properties[] =3D {
     DEFINE_PROP_UINT32("unit", FloppyDrive, unit, -1),
     DEFINE_BLOCK_PROPERTIES(FloppyDrive, conf),
-    DEFINE_PROP_DEFAULT("drive-type", FloppyDrive, type,
-                        FLOPPY_DRIVE_TYPE_AUTO, qdev_prop_fdc_drive_type=
,
-                        FloppyDriveType),
+    DEFINE_PROP_INT("drive-type", FloppyDrive, type,
+                    FLOPPY_DRIVE_TYPE_AUTO, qdev_prop_fdc_drive_type,
+                    FloppyDriveType),
     DEFINE_PROP_END_OF_LIST(),
 };
=20
@@ -2805,15 +2805,15 @@ static Property isa_fdc_properties[] =3D {
     DEFINE_PROP_DRIVE("driveB", FDCtrlISABus, state.qdev_for_drives[1].b=
lk),
     DEFINE_PROP_BIT("check_media_rate", FDCtrlISABus, state.check_media_=
rate,
                     0, true),
-    DEFINE_PROP_DEFAULT("fdtypeA", FDCtrlISABus, state.qdev_for_drives[0=
].type,
-                        FLOPPY_DRIVE_TYPE_AUTO, qdev_prop_fdc_drive_type=
,
-                        FloppyDriveType),
-    DEFINE_PROP_DEFAULT("fdtypeB", FDCtrlISABus, state.qdev_for_drives[1=
].type,
-                        FLOPPY_DRIVE_TYPE_AUTO, qdev_prop_fdc_drive_type=
,
-                        FloppyDriveType),
-    DEFINE_PROP_DEFAULT("fallback", FDCtrlISABus, state.fallback,
-                        FLOPPY_DRIVE_TYPE_288, qdev_prop_fdc_drive_type,
-                        FloppyDriveType),
+    DEFINE_PROP_INT("fdtypeA", FDCtrlISABus, state.qdev_for_drives[0].ty=
pe,
+                    FLOPPY_DRIVE_TYPE_AUTO, qdev_prop_fdc_drive_type,
+                    FloppyDriveType),
+    DEFINE_PROP_INT("fdtypeB", FDCtrlISABus, state.qdev_for_drives[1].ty=
pe,
+                    FLOPPY_DRIVE_TYPE_AUTO, qdev_prop_fdc_drive_type,
+                    FloppyDriveType),
+    DEFINE_PROP_INT("fallback", FDCtrlISABus, state.fallback,
+                    FLOPPY_DRIVE_TYPE_288, qdev_prop_fdc_drive_type,
+                    FloppyDriveType),
     DEFINE_PROP_END_OF_LIST(),
 };
=20
@@ -2862,15 +2862,15 @@ static const VMStateDescription vmstate_sysbus_fd=
c =3D{
 static Property sysbus_fdc_properties[] =3D {
     DEFINE_PROP_DRIVE("driveA", FDCtrlSysBus, state.qdev_for_drives[0].b=
lk),
     DEFINE_PROP_DRIVE("driveB", FDCtrlSysBus, state.qdev_for_drives[1].b=
lk),
-    DEFINE_PROP_DEFAULT("fdtypeA", FDCtrlSysBus, state.qdev_for_drives[0=
].type,
-                        FLOPPY_DRIVE_TYPE_AUTO, qdev_prop_fdc_drive_type=
,
-                        FloppyDriveType),
-    DEFINE_PROP_DEFAULT("fdtypeB", FDCtrlSysBus, state.qdev_for_drives[1=
].type,
-                        FLOPPY_DRIVE_TYPE_AUTO, qdev_prop_fdc_drive_type=
,
-                        FloppyDriveType),
-    DEFINE_PROP_DEFAULT("fallback", FDCtrlISABus, state.fallback,
-                        FLOPPY_DRIVE_TYPE_144, qdev_prop_fdc_drive_type,
-                        FloppyDriveType),
+    DEFINE_PROP_INT("fdtypeA", FDCtrlSysBus, state.qdev_for_drives[0].ty=
pe,
+                    FLOPPY_DRIVE_TYPE_AUTO, qdev_prop_fdc_drive_type,
+                    FloppyDriveType),
+    DEFINE_PROP_INT("fdtypeB", FDCtrlSysBus, state.qdev_for_drives[1].ty=
pe,
+                    FLOPPY_DRIVE_TYPE_AUTO, qdev_prop_fdc_drive_type,
+                    FloppyDriveType),
+    DEFINE_PROP_INT("fallback", FDCtrlISABus, state.fallback,
+                    FLOPPY_DRIVE_TYPE_144, qdev_prop_fdc_drive_type,
+                    FloppyDriveType),
     DEFINE_PROP_END_OF_LIST(),
 };
=20
@@ -2891,12 +2891,12 @@ static const TypeInfo sysbus_fdc_info =3D {
=20
 static Property sun4m_fdc_properties[] =3D {
     DEFINE_PROP_DRIVE("drive", FDCtrlSysBus, state.qdev_for_drives[0].bl=
k),
-    DEFINE_PROP_DEFAULT("fdtype", FDCtrlSysBus, state.qdev_for_drives[0]=
.type,
-                        FLOPPY_DRIVE_TYPE_AUTO, qdev_prop_fdc_drive_type=
,
-                        FloppyDriveType),
-    DEFINE_PROP_DEFAULT("fallback", FDCtrlISABus, state.fallback,
-                        FLOPPY_DRIVE_TYPE_144, qdev_prop_fdc_drive_type,
-                        FloppyDriveType),
+    DEFINE_PROP_INT("fdtype", FDCtrlSysBus, state.qdev_for_drives[0].typ=
e,
+                    FLOPPY_DRIVE_TYPE_AUTO, qdev_prop_fdc_drive_type,
+                    FloppyDriveType),
+    DEFINE_PROP_INT("fallback", FDCtrlISABus, state.fallback,
+                    FLOPPY_DRIVE_TYPE_144, qdev_prop_fdc_drive_type,
+                    FloppyDriveType),
     DEFINE_PROP_END_OF_LIST(),
 };
=20
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 482efb2683..952cda7758 100644
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
diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
index 6e234938db..4e4cc9b52f 100644
--- a/hw/net/e1000e.c
+++ b/hw/net/e1000e.c
@@ -645,13 +645,13 @@ static PropertyInfo e1000e_prop_disable_vnet,
=20
 static Property e1000e_properties[] =3D {
     DEFINE_NIC_PROPERTIES(E1000EState, conf),
-    DEFINE_PROP_DEFAULT("disable_vnet_hdr", E1000EState, disable_vnet, f=
alse,
-                        e1000e_prop_disable_vnet, bool),
-    DEFINE_PROP_DEFAULT("subsys_ven", E1000EState, subsys_ven,
-                        PCI_VENDOR_ID_INTEL,
-                        e1000e_prop_subsys_ven, uint16_t),
-    DEFINE_PROP_DEFAULT("subsys", E1000EState, subsys, 0,
-                        e1000e_prop_subsys, uint16_t),
+    DEFINE_PROP_INT("disable_vnet_hdr", E1000EState, disable_vnet, false=
,
+                    e1000e_prop_disable_vnet, bool),
+    DEFINE_PROP_INT("subsys_ven", E1000EState, subsys_ven,
+                    PCI_VENDOR_ID_INTEL,
+                    e1000e_prop_subsys_ven, uint16_t),
+    DEFINE_PROP_INT("subsys", E1000EState, subsys, 0,
+                    e1000e_prop_subsys, uint16_t),
     DEFINE_PROP_END_OF_LIST(),
 };
=20
--=20
2.13.0.91.g00982b8dd
