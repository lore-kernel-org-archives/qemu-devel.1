Received: from eggs.gnu.org ([209.51.188.92]:35447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjUym-000807-Ei
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:06:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjUyQ-0003Ox-83
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:06:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57526)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gjUyO-00035Q-IL
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:06:09 -0500
Date: Tue, 15 Jan 2019 15:05:49 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190115200252.25911-35-mst@redhat.com>
References: <20190115200252.25911-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190115200252.25911-1-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 34/49] globals: Allow global properties to be
 optional
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Cornelia Huck <cohuck@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>

From: Eduardo Habkost <ehabkost@redhat.com>

Making some global properties optional will let us simplify
compat code when a given property works on most (but not all)
subclasses of a given type.

Device types will be able to opt out from optional compat
properties by simply not registering those properties.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/qdev-core.h | 3 +++
 qom/object.c           | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 9614f76ae6..0a84c42756 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -250,6 +250,8 @@ struct PropertyInfo {
 /**
  * GlobalProperty:
  * @used: Set to true if property was used when initializing a device.
+ * @optional: If set to true, GlobalProperty will be skipped without err=
ors
+ *            if the property doesn't exist.
  *
  * An error is fatal for non-hotplugged devices, when the global is appl=
ied.
  */
@@ -258,6 +260,7 @@ typedef struct GlobalProperty {
     const char *property;
     const char *value;
     bool used;
+    bool optional;
 } GlobalProperty;
=20
 static inline void
diff --git a/qom/object.c b/qom/object.c
index 4e5226ca12..b8c732063b 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -385,6 +385,9 @@ void object_apply_global_props(Object *obj, const GPt=
rArray *props, Error **errp
         if (object_dynamic_cast(obj, p->driver) =3D=3D NULL) {
             continue;
         }
+        if (p->optional && !object_property_find(obj, p->property, NULL)=
) {
+            continue;
+        }
         p->used =3D true;
         object_property_parse(obj, p->value, p->property, &err);
         if (err !=3D NULL) {
--=20
MST
