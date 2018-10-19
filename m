Received: from eggs.gnu.org ([2001:4830:134:3::10]:38011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gDUzN-0004Q8-4L
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 09:38:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gDUzL-0000A5-8P
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 09:38:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35852)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gDUzJ-0008TQ-AW
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 09:38:50 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 177CA30917B0
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 13:38:47 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Fri, 19 Oct 2018 14:38:26 +0100
Message-Id: <20181019133835.16494-3-berrange@redhat.com>
In-Reply-To: <20181019133835.16494-1-berrange@redhat.com>
References: <20181019133835.16494-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 02/11] qom: don't require user creatable
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

When an object is in turn owned by another user object, it is not
desirable to expose this in the QOM object hierarchy, as it is
just an internal implementation detail, we should be free to change
without exposure.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 qom/object.c            | 12 ++++++++----
 qom/object_interfaces.c | 16 ++++++++++------
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index 547dcf97c3..f20f0c45a7 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -607,15 +607,19 @@ Object *object_new_with_propv(const char *typename,
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
index 941fd63afd..94d5f91d69 100644
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
2.17.2
