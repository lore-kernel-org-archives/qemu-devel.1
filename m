Received: from eggs.gnu.org ([209.51.188.92]:35105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ghPgs-0006Oy-QF
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 21:03:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ghPgq-0003KQ-Q1
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 21:03:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50874)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ghPgq-0003JX-7L
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 21:03:24 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 10 Jan 2019 00:02:58 -0200
Message-Id: <20190110020259.8492-3-ehabkost@redhat.com>
In-Reply-To: <20190110020259.8492-1-ehabkost@redhat.com>
References: <20190110020259.8492-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/3] globals: Allow global properties to be
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
properties by simply not registering those properties, or by
making the property setter report an error.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Note: the "An error is fatal for non-hotplugged devices [...]"
comment that appears in the diff scope is inaccurate, but I will
fix that in a separate patch because I don't want this to get
into the way of fixing the crash.
---
 include/hw/qdev-core.h | 3 +++
 qom/object.c           | 4 +++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index bc014c1c9f..463e1ddb1e 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -250,6 +250,8 @@ struct PropertyInfo {
 /**
  * GlobalProperty:
  * @used: Set to true if property was used when initializing a device.
+ * @optional: If set to true, errors when applying the property won't be
+ *            reported by object_apply_global_props().
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
index 4e5226ca12..226ddf0189 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -387,7 +387,9 @@ void object_apply_global_props(Object *obj, const GPtrArray *props, Error **errp
         }
         p->used = true;
         object_property_parse(obj, p->value, p->property, &err);
-        if (err != NULL) {
+        if (p->optional) {
+            error_free(err);
+        } else if (err != NULL) {
             error_prepend(&err, "can't apply global %s.%s=%s: ",
                           p->driver, p->property, p->value);
             /*
-- 
2.18.0.rc1.1.g3f1ff2140
