Received: from eggs.gnu.org ([209.51.188.92]:60551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1guanm-000861-US
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 05:33:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1guanl-0004U8-IA
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 05:33:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60723)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1guanl-0004CI-7A
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 05:33:01 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Fri, 15 Feb 2019 10:32:39 +0000
Message-Id: <20190215103239.28640-3-berrange@redhat.com>
In-Reply-To: <20190215103239.28640-1-berrange@redhat.com>
References: <20190215103239.28640-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 2/2] Revert "globals: Allow global
 properties to be optional"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Gonglei <arei.gonglei@huawei.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

This reverts commit d7741743f4f3d2683d1bb6938f88dc0167c21afa.

Relying on setting properties on parents types which may not
be relevant to certain sub-classes had unexpected side-effects
causing bugs in device config defaults. It is preferrable to
be explicit about which devices get which properties, even if
this needs repetition.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 include/hw/qdev-core.h | 3 ---
 qom/object.c           | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 0a84c42756..9614f76ae6 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -250,8 +250,6 @@ struct PropertyInfo {
 /**
  * GlobalProperty:
  * @used: Set to true if property was used when initializing a device.
- * @optional: If set to true, GlobalProperty will be skipped without err=
ors
- *            if the property doesn't exist.
  *
  * An error is fatal for non-hotplugged devices, when the global is appl=
ied.
  */
@@ -260,7 +258,6 @@ typedef struct GlobalProperty {
     const char *property;
     const char *value;
     bool used;
-    bool optional;
 } GlobalProperty;
=20
 static inline void
diff --git a/qom/object.c b/qom/object.c
index b8c732063b..4e5226ca12 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -385,9 +385,6 @@ void object_apply_global_props(Object *obj, const GPt=
rArray *props, Error **errp
         if (object_dynamic_cast(obj, p->driver) =3D=3D NULL) {
             continue;
         }
-        if (p->optional && !object_property_find(obj, p->property, NULL)=
) {
-            continue;
-        }
         p->used =3D true;
         object_property_parse(obj, p->value, p->property, &err);
         if (err !=3D NULL) {
--=20
2.20.1
