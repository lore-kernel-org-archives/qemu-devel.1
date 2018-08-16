Received: from eggs.gnu.org ([2001:4830:134:3::10]:48525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fqHuA-0003QU-L4
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:01:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fqHu3-0001Qf-Kp
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:01:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58564 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fqHu3-0001Nh-5c
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:01:27 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Thu, 16 Aug 2018 14:01:09 +0100
Message-Id: <20180816130118.31841-3-berrange@redhat.com>
In-Reply-To: <20180816130118.31841-1-berrange@redhat.com>
References: <20180816130118.31841-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 02/11] qom: don't require user creatable
 objects to be registered
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

When an object is in turn owned by another user object, it is not
desirable to expose this in the QOM object hierarchy, as it is
just an internal implementation detail, we should be free to change
without exposure.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 qom/object.c            | 12 ++++++++----
 qom/object_interfaces.c | 16 ++++++++++------
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index 75d1d48944..fff85d6d62 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -600,15 +600,19 @@ Object *object_new_with_propv(const char *typename,
         goto error;
     }
=20
-    object_property_add_child(parent, id, obj, &local_err);
-    if (local_err) {
-        goto error;
+    if (id !=3D NULL) {
+        object_property_add_child(parent, id, obj, &local_err);
+        if (local_err) {
+            goto error;
+        }
     }
=20
     if (object_dynamic_cast(obj, TYPE_USER_CREATABLE)) {
         user_creatable_complete(obj, &local_err);
         if (local_err) {
-            object_unparent(obj);
+            if (id !=3D NULL) {
+                object_unparent(obj);
+            }
             goto error;
         }
     }
diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
index 72b97a8bed..e0f12c0a9b 100644
--- a/qom/object_interfaces.c
+++ b/qom/object_interfaces.c
@@ -83,16 +83,20 @@ Object *user_creatable_add_type(const char *type, con=
st char *id,
         goto out;
     }
=20
-    object_property_add_child(object_get_objects_root(),
-                              id, obj, &local_err);
-    if (local_err) {
-        goto out;
+    if (id !=3D NULL) {
+        object_property_add_child(object_get_objects_root(),
+                                  id, obj, &local_err);
+        if (local_err) {
+            goto out;
+        }
     }
=20
     user_creatable_complete(obj, &local_err);
     if (local_err) {
-        object_property_del(object_get_objects_root(),
-                            id, &error_abort);
+        if (id !=3D NULL) {
+            object_property_del(object_get_objects_root(),
+                                id, &error_abort);
+        }
         goto out;
     }
 out:
--=20
2.17.1
