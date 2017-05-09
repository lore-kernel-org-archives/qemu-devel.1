Received: from eggs.gnu.org ([2001:4830:134:3::10]:44962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d893m-0005Dj-4k
	for qemu-devel@nongnu.org; Tue, 09 May 2017 13:36:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d893l-0003PF-3h
	for qemu-devel@nongnu.org; Tue, 09 May 2017 13:36:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37376)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1d893k-0003P5-Ri
	for qemu-devel@nongnu.org; Tue, 09 May 2017 13:36:29 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C6E56C059756
	for <qemu-devel@nongnu.org>; Tue,  9 May 2017 17:36:27 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue,  9 May 2017 20:35:43 +0300
Message-Id: <20170509173559.31598-2-marcandre.lureau@redhat.com>
In-Reply-To: <20170509173559.31598-1-marcandre.lureau@redhat.com>
References: <20170509173559.31598-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 01/17] qdev: remove PropertyInfo.qtype field
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

Remove dependency on qapi qtype, replace a field by a few helper
functions to determine the default value type (introduced in commit
4f2d3d7).

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/hw/qdev-core.h       |  1 -
 include/hw/qdev-properties.h |  5 -----
 hw/core/qdev.c               | 32 ++++++++++++++++++++++++++------
 3 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 4bf86b0ad8..0f21a500cd 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -225,7 +225,6 @@ struct Property {
     PropertyInfo *info;
     ptrdiff_t    offset;
     uint8_t      bitnr;
-    QType        qtype;
     int64_t      defval;
     int          arrayoffset;
     PropertyInfo *arrayinfo;
diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index 1d69fa7a8f..16d5d0629b 100644
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
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 02b632f6b3..83b0297755 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -755,6 +755,30 @@ static void qdev_property_add_legacy(DeviceState *de=
v, Property *prop,
     g_free(name);
 }
=20
+static bool prop_info_is_bool(const PropertyInfo *info)
+{
+    return info =3D=3D &qdev_prop_bit
+        || info =3D=3D &qdev_prop_bit64
+        || info =3D=3D &qdev_prop_bool;
+}
+
+static bool prop_info_is_int(const PropertyInfo *info)
+{
+    return info =3D=3D &qdev_prop_uint8
+        || info =3D=3D &qdev_prop_uint16
+        || info =3D=3D &qdev_prop_uint32
+        || info =3D=3D &qdev_prop_int32
+        || info =3D=3D &qdev_prop_uint64
+        || info =3D=3D &qdev_prop_size
+        || info =3D=3D &qdev_prop_pci_devfn
+        || info =3D=3D &qdev_prop_on_off_auto
+        || info =3D=3D &qdev_prop_losttickpolicy
+        || info =3D=3D &qdev_prop_blockdev_on_error
+        || info =3D=3D &qdev_prop_bios_chs_trans
+        || info =3D=3D &qdev_prop_blocksize
+        || info =3D=3D &qdev_prop_arraylen;
+}
+
 /**
  * qdev_property_add_static:
  * @dev: Device to add the property to.
@@ -794,16 +818,12 @@ void qdev_property_add_static(DeviceState *dev, Pro=
perty *prop,
                                     prop->info->description,
                                     &error_abort);
=20
-    if (prop->qtype =3D=3D QTYPE_NONE) {
-        return;
-    }
-
-    if (prop->qtype =3D=3D QTYPE_QBOOL) {
+    if (prop_info_is_bool(prop->info)) {
         object_property_set_bool(obj, prop->defval, prop->name, &error_a=
bort);
     } else if (prop->info->enum_table) {
         object_property_set_str(obj, prop->info->enum_table[prop->defval=
],
                                 prop->name, &error_abort);
-    } else if (prop->qtype =3D=3D QTYPE_QINT) {
+    } else if (prop_info_is_int(prop->info)) {
         object_property_set_int(obj, prop->defval, prop->name, &error_ab=
ort);
     }
 }
--=20
2.13.0.rc1.16.gd80b50c3f
