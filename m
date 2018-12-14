Received: from eggs.gnu.org ([2001:4830:134:3::10]:59370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1gXqm5-0005gC-UY
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 11:57:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1gXqm4-0002GD-2N
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 11:57:17 -0500
Received: from mail-eopbgr80118.outbound.protection.outlook.com
	([40.107.8.118]:22409
	helo=EUR04-VI1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1gXqm3-0001B5-M1
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 11:57:15 -0500
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Fri, 14 Dec 2018 16:57:08 +0000
Message-ID: <20181214165657.749-4-rkagan@virtuozzo.com>
References: <20181214165657.749-1-rkagan@virtuozzo.com>
In-Reply-To: <20181214165657.749-1-rkagan@virtuozzo.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [RFC PATCH 3/5] qdev-properties: add r/o 64bit
 bitfield property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Amit Shah <amit@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, Markus Armbruster <armbru@redhat.com>, =?iso-8859-1?Q?Andreas_F=E4rber?= <afaerber@suse.de>

Add a version 64bit bitfield property with no setter, useful for
introspecting the device state without being able to modify it.

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
---
 include/hw/qdev-properties.h | 9 +++++++++
 hw/core/qdev-properties.c    | 9 ++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index 3ab9cd2eb6..24df135ff8 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -9,6 +9,7 @@
=20
 extern const PropertyInfo qdev_prop_bit;
 extern const PropertyInfo qdev_prop_bit64;
+extern const PropertyInfo qdev_prop_bit64_ro;
 extern const PropertyInfo qdev_prop_bool;
 extern const PropertyInfo qdev_prop_uint8;
 extern const PropertyInfo qdev_prop_uint16;
@@ -96,6 +97,14 @@ extern const PropertyInfo qdev_prop_off_auto_pcibar;
         .defval.u  =3D (bool)_defval,                                     =
\
         }
=20
+#define DEFINE_PROP_BIT64_RO(_name, _state, _field, _bit) {             \
+        .name      =3D (_name),                                           =
\
+        .info      =3D &(qdev_prop_bit64_ro),                             =
\
+        .bitnr    =3D (_bit),                                             =
\
+        .offset    =3D offsetof(_state, _field)                           =
\
+            + type_check(uint64_t, typeof_field(_state, _field)),       \
+        }
+
 #define DEFINE_PROP_BOOL(_name, _state, _field, _defval) {       \
         .name      =3D (_name),                                    \
         .info      =3D &(qdev_prop_bool),                          \
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index bd84c4ea4c..bb9bd48e5c 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -146,7 +146,8 @@ const PropertyInfo qdev_prop_bit =3D {
=20
 static uint64_t qdev_get_prop_mask64(Property *prop)
 {
-    assert(prop->info =3D=3D &qdev_prop_bit64);
+    assert(prop->info =3D=3D &qdev_prop_bit64 ||
+           prop->info =3D=3D &qdev_prop_bit64_ro);
     return 0x1ull << prop->bitnr;
 }
=20
@@ -201,6 +202,12 @@ const PropertyInfo qdev_prop_bit64 =3D {
     .set_default_value =3D set_default_value_bool,
 };
=20
+const PropertyInfo qdev_prop_bit64_ro =3D {
+    .name  =3D "bool",
+    .description =3D "on/off",
+    .get   =3D prop_get_bit64,
+};
+
 /* --- bool --- */
=20
 static void get_bool(Object *obj, Visitor *v, const char *name, void *opaq=
ue,
--=20
2.19.2
