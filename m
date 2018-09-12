Received: from eggs.gnu.org ([2001:4830:134:3::10]:32947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1g04gO-0007DW-Gm
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 08:55:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1g04gN-0007gV-ME
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 08:55:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55000 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1g04gN-0007g8-FN
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 08:55:47 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 12 Sep 2018 16:55:23 +0400
Message-Id: <20180912125531.32131-2-marcandre.lureau@redhat.com>
In-Reply-To: <20180912125531.32131-1-marcandre.lureau@redhat.com>
References: <20180912125531.32131-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/9] qom/user-creatable: add a few helper macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, dgilbert@redhat.com, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Improve a bit code readability.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qom/object_interfaces.h | 4 ++++
 qom/object.c                    | 4 ++--
 qom/object_interfaces.c         | 9 +++------
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/include/qom/object_interfaces.h b/include/qom/object_interfa=
ces.h
index 4d513fb329..46b0861457 100644
--- a/include/qom/object_interfaces.h
+++ b/include/qom/object_interfaces.h
@@ -9,9 +9,13 @@
 #define USER_CREATABLE_CLASS(klass) \
      OBJECT_CLASS_CHECK(UserCreatableClass, (klass), \
                         TYPE_USER_CREATABLE)
+#define IS_USER_CREATABLE_CLASS(klass) \
+    object_class_dynamic_cast(OBJECT_CLASS(oc), TYPE_USER_CREATABLE)
 #define USER_CREATABLE_GET_CLASS(obj) \
      OBJECT_GET_CLASS(UserCreatableClass, (obj), \
                       TYPE_USER_CREATABLE)
+#define IS_USER_CREATABLE(obj) \
+    object_dynamic_cast(OBJECT(obj), TYPE_USER_CREATABLE)
 #define USER_CREATABLE(obj) \
      INTERFACE_CHECK(UserCreatable, (obj), \
                      TYPE_USER_CREATABLE)
diff --git a/qom/object.c b/qom/object.c
index 75d1d48944..0703e8e4ff 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -424,7 +424,7 @@ void object_initialize_childv(Object *parentobj, cons=
t char *propname,
         goto out;
     }
=20
-    if (object_dynamic_cast(obj, TYPE_USER_CREATABLE)) {
+    if (IS_USER_CREATABLE(obj)) {
         user_creatable_complete(obj, &local_err);
         if (local_err) {
             object_unparent(obj);
@@ -605,7 +605,7 @@ Object *object_new_with_propv(const char *typename,
         goto error;
     }
=20
-    if (object_dynamic_cast(obj, TYPE_USER_CREATABLE)) {
+    if (IS_USER_CREATABLE(obj)) {
         user_creatable_complete(obj, &local_err);
         if (local_err) {
             object_unparent(obj);
diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
index 72b97a8bed..e3084bc04a 100644
--- a/qom/object_interfaces.c
+++ b/qom/object_interfaces.c
@@ -10,18 +10,15 @@
=20
 void user_creatable_complete(Object *obj, Error **errp)
 {
-
     UserCreatableClass *ucc;
-    UserCreatable *uc =3D
-        (UserCreatable *)object_dynamic_cast(obj, TYPE_USER_CREATABLE);
=20
-    if (!uc) {
+    if (!IS_USER_CREATABLE(obj)) {
         return;
     }
=20
-    ucc =3D USER_CREATABLE_GET_CLASS(uc);
+    ucc =3D USER_CREATABLE_GET_CLASS(obj);
     if (ucc->complete) {
-        ucc->complete(uc, errp);
+        ucc->complete(USER_CREATABLE(obj), errp);
     }
 }
=20
--=20
2.19.0.rc1
