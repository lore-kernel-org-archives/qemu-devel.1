Received: from eggs.gnu.org ([2001:4830:134:3::10]:45910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d896n-0000Ck-QD
	for qemu-devel@nongnu.org; Tue, 09 May 2017 13:39:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d896i-0004jO-NE
	for qemu-devel@nongnu.org; Tue, 09 May 2017 13:39:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53550)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1d896i-0004iD-DP
	for qemu-devel@nongnu.org; Tue, 09 May 2017 13:39:32 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 57200448D74
	for <qemu-devel@nongnu.org>; Tue,  9 May 2017 17:39:31 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue,  9 May 2017 20:35:54 +0300
Message-Id: <20170509173559.31598-13-marcandre.lureau@redhat.com>
In-Reply-To: <20170509173559.31598-1-marcandre.lureau@redhat.com>
References: <20170509173559.31598-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 12/17] qdev: use int and uint properties as
 appropriate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Use unsigned type for various properties.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/hw/qdev-core.h       |  5 +++-
 include/hw/qdev-properties.h | 67 ++++++++++++++++++++++++++------------=
------
 hw/block/fdc.c               | 54 +++++++++++++++++------------------
 hw/core/qdev-properties.c    |  8 +++---
 hw/core/qdev.c               | 24 ++++++++++------
 hw/net/e1000e.c              | 14 ++++-----
 6 files changed, 96 insertions(+), 76 deletions(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 0f21a500cd..ac10458650 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -225,7 +225,10 @@ struct Property {
     PropertyInfo *info;
     ptrdiff_t    offset;
     uint8_t      bitnr;
-    int64_t      defval;
+    union {
+        int64_t i;
+        uint64_t u;
+    } defval;
     int          arrayoffset;
     PropertyInfo *arrayinfo;
     int          arrayfieldsize;
diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index 16d5d0629b..ca9c550fa3 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -37,36 +37,47 @@ extern PropertyInfo qdev_prop_arraylen;
         .offset    =3D offsetof(_state, _field)                    \
             + type_check(_type, typeof_field(_state, _field)),   \
         }
-#define DEFINE_PROP_DEFAULT(_name, _state, _field, _defval, _prop, _type=
) { \
+
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
-#define DEFINE_PROP_BIT(_name, _state, _field, _bit, _defval) {  \
-        .name      =3D (_name),                                    \
-        .info      =3D &(qdev_prop_bit),                           \
-        .bitnr    =3D (_bit),                                      \
-        .offset    =3D offsetof(_state, _field)                    \
-            + type_check(uint32_t,typeof_field(_state, _field)), \
-        .defval    =3D (bool)_defval,                              \
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
-        .defval    =3D (bool)_defval,                                   =
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
-        .defval    =3D (bool)_defval,                              \
+#define DEFINE_PROP_BOOL(_name, _state, _field, _defval) {      \
+        .name      =3D (_name),                                   \
+        .info      =3D &(qdev_prop_bool),                         \
+        .offset    =3D offsetof(_state, _field)                   \
+            + type_check(bool, typeof_field(_state, _field)),   \
+        .defval.u    =3D (bool)_defval,                           \
         }
=20
 #define PROP_ARRAY_LEN_PREFIX "len-"
@@ -107,19 +118,19 @@ extern PropertyInfo qdev_prop_arraylen;
         }
=20
 #define DEFINE_PROP_UINT8(_n, _s, _f, _d)                       \
-    DEFINE_PROP_DEFAULT(_n, _s, _f, _d, qdev_prop_uint8, uint8_t)
+    DEFINE_PROP_UINT(_n, _s, _f, _d, qdev_prop_uint8, uint8_t)
 #define DEFINE_PROP_UINT16(_n, _s, _f, _d)                      \
-    DEFINE_PROP_DEFAULT(_n, _s, _f, _d, qdev_prop_uint16, uint16_t)
+    DEFINE_PROP_UINT(_n, _s, _f, _d, qdev_prop_uint16, uint16_t)
 #define DEFINE_PROP_UINT32(_n, _s, _f, _d)                      \
-    DEFINE_PROP_DEFAULT(_n, _s, _f, _d, qdev_prop_uint32, uint32_t)
+    DEFINE_PROP_UINT(_n, _s, _f, _d, qdev_prop_uint32, uint32_t)
 #define DEFINE_PROP_INT32(_n, _s, _f, _d)                      \
-    DEFINE_PROP_DEFAULT(_n, _s, _f, _d, qdev_prop_int32, int32_t)
+    DEFINE_PROP_INT(_n, _s, _f, _d, qdev_prop_int32, int32_t)
 #define DEFINE_PROP_UINT64(_n, _s, _f, _d)                      \
-    DEFINE_PROP_DEFAULT(_n, _s, _f, _d, qdev_prop_uint64, uint64_t)
+    DEFINE_PROP_UINT(_n, _s, _f, _d, qdev_prop_uint64, uint64_t)
 #define DEFINE_PROP_SIZE(_n, _s, _f, _d)                       \
-    DEFINE_PROP_DEFAULT(_n, _s, _f, _d, qdev_prop_size, uint64_t)
+    DEFINE_PROP_UINT(_n, _s, _f, _d, qdev_prop_size, uint64_t)
 #define DEFINE_PROP_PCI_DEVFN(_n, _s, _f, _d)                   \
-    DEFINE_PROP_DEFAULT(_n, _s, _f, _d, qdev_prop_pci_devfn, int32_t)
+    DEFINE_PROP_INT(_n, _s, _f, _d, qdev_prop_pci_devfn, int32_t)
=20
 /*
  * Please avoid pointer properties.  If you must use them, you must
@@ -153,17 +164,17 @@ extern PropertyInfo qdev_prop_arraylen;
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
+    DEFINE_PROP_UINT(_n, _s, _f, 0, qdev_prop_blocksize, uint16_t)
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
index fa3617db2d..f87327b132 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -982,17 +982,17 @@ void qdev_prop_set_bit(DeviceState *dev, const char=
 *name, bool value)
=20
 void qdev_prop_set_uint8(DeviceState *dev, const char *name, uint8_t val=
ue)
 {
-    object_property_set_int(OBJECT(dev), value, name, &error_abort);
+    object_property_set_uint(OBJECT(dev), value, name, &error_abort);
 }
=20
 void qdev_prop_set_uint16(DeviceState *dev, const char *name, uint16_t v=
alue)
 {
-    object_property_set_int(OBJECT(dev), value, name, &error_abort);
+    object_property_set_uint(OBJECT(dev), value, name, &error_abort);
 }
=20
 void qdev_prop_set_uint32(DeviceState *dev, const char *name, uint32_t v=
alue)
 {
-    object_property_set_int(OBJECT(dev), value, name, &error_abort);
+    object_property_set_uint(OBJECT(dev), value, name, &error_abort);
 }
=20
 void qdev_prop_set_int32(DeviceState *dev, const char *name, int32_t val=
ue)
@@ -1002,7 +1002,7 @@ void qdev_prop_set_int32(DeviceState *dev, const ch=
ar *name, int32_t value)
=20
 void qdev_prop_set_uint64(DeviceState *dev, const char *name, uint64_t v=
alue)
 {
-    object_property_set_int(OBJECT(dev), value, name, &error_abort);
+    object_property_set_uint(OBJECT(dev), value, name, &error_abort);
 }
=20
 void qdev_prop_set_string(DeviceState *dev, const char *name, const char=
 *value)
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 83b0297755..b9313546f7 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -764,17 +764,21 @@ static bool prop_info_is_bool(const PropertyInfo *i=
nfo)
=20
 static bool prop_info_is_int(const PropertyInfo *info)
 {
+    return info =3D=3D &qdev_prop_int32
+        || info =3D=3D &qdev_prop_pci_devfn
+        || info =3D=3D &qdev_prop_on_off_auto
+        || info =3D=3D &qdev_prop_losttickpolicy
+        || info =3D=3D &qdev_prop_blockdev_on_error
+        || info =3D=3D &qdev_prop_bios_chs_trans;
+}
+
+static bool prop_info_is_uint(const PropertyInfo *info)
+{
     return info =3D=3D &qdev_prop_uint8
         || info =3D=3D &qdev_prop_uint16
         || info =3D=3D &qdev_prop_uint32
-        || info =3D=3D &qdev_prop_int32
         || info =3D=3D &qdev_prop_uint64
         || info =3D=3D &qdev_prop_size
-        || info =3D=3D &qdev_prop_pci_devfn
-        || info =3D=3D &qdev_prop_on_off_auto
-        || info =3D=3D &qdev_prop_losttickpolicy
-        || info =3D=3D &qdev_prop_blockdev_on_error
-        || info =3D=3D &qdev_prop_bios_chs_trans
         || info =3D=3D &qdev_prop_blocksize
         || info =3D=3D &qdev_prop_arraylen;
 }
@@ -819,12 +823,14 @@ void qdev_property_add_static(DeviceState *dev, Pro=
perty *prop,
                                     &error_abort);
=20
     if (prop_info_is_bool(prop->info)) {
-        object_property_set_bool(obj, prop->defval, prop->name, &error_a=
bort);
+        object_property_set_bool(obj, prop->defval.u, prop->name, &error=
_abort);
     } else if (prop->info->enum_table) {
-        object_property_set_str(obj, prop->info->enum_table[prop->defval=
],
+        object_property_set_str(obj, prop->info->enum_table[prop->defval=
.i],
                                 prop->name, &error_abort);
     } else if (prop_info_is_int(prop->info)) {
-        object_property_set_int(obj, prop->defval, prop->name, &error_ab=
ort);
+        object_property_set_int(obj, prop->defval.i, prop->name, &error_=
abort);
+    } else if (prop_info_is_uint(prop->info)) {
+        object_property_set_uint(obj, prop->defval.u, prop->name, &error=
_abort);
     }
 }
=20
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
2.13.0.rc1.16.gd80b50c3f
