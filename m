Received: from eggs.gnu.org ([209.51.188.92]:39194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ghehe-0004I0-0B
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 13:05:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ghehc-0000of-TT
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 13:05:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58944)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gheha-0000my-WE
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 13:05:12 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 10 Jan 2019 16:04:57 -0200
Message-Id: <20190110180458.18762-2-ehabkost@redhat.com>
In-Reply-To: <20190110180458.18762-1-ehabkost@redhat.com>
References: <20190110180458.18762-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH v3 1/2] globals: Allow global properties to be
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
Cc: Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Cornelia Huck <cohuck@redhat.com>

Making some global properties optional will let us simplify
compat code when a given property works on most (but not all)
subclasses of a given type.

Device types will be able to opt out from optional compat
properties by simply not registering those properties.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes v2 -> v3:
* Don't ignore all errors, ignore property only if it doesn't
  exist

Changes v1 -> v2:
* (new patch)

Note: the "An error is fatal for non-hotplugged devices [...]"
comment that appears in the diff scope is inaccurate, but I will
fix that in a separate patch because I don't want this to get
into the way of fixing the crash.
---
 include/hw/qdev-core.h | 3 +++
 qom/object.c           | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index bc014c1c9f..29874c8611 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -250,6 +250,8 @@ struct PropertyInfo {
 /**
  * GlobalProperty:
  * @used: Set to true if property was used when initializing a device.
+ * @optional: If set to true, GlobalProperty will be skipped without errors
+ *            if the property doesn't exist.
  *
  * An error is fatal for non-hotplugged devices, when the global is applied.
  */
@@ -258,6 +260,7 @@ typedef struct GlobalProperty {
     const char *property;
     const char *value;
     bool used;
+    bool optional;
 } GlobalProperty;
 
 static inline void
diff --git a/qom/object.c b/qom/object.c
index 4e5226ca12..b8c732063b 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -385,6 +385,9 @@ void object_apply_global_props(Object *obj, const GPtrArray *props, Error **errp
         if (object_dynamic_cast(obj, p->driver) == NULL) {
             continue;
         }
+        if (p->optional && !object_property_find(obj, p->property, NULL)) {
+            continue;
+        }
         p->used = true;
         object_property_parse(obj, p->value, p->property, &err);
         if (err != NULL) {
-- 
2.18.0.rc1.1.g3f1ff2140
