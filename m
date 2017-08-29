Received: from eggs.gnu.org ([2001:4830:134:3::10]:38729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dmobq-00074G-Pd
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 18:03:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dmobk-0000YC-Kt
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 18:03:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34408)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dmobk-0000Xn-CK
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 18:03:40 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 29 Aug 2017 19:03:37 -0300
Message-Id: <20170829220337.23427-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] qom: Remove unused errp parameter from
 can_be_deleted()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gonglei <arei.gonglei@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Lin Ma <lma@suse.com>

The errp argument is ignored by all implementations of the
method, and user_creatable_del() would break if any
implementation set an error (because it calls error_setg(errp) if
the function returns false).  Remove the unused parameter.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/qom/object_interfaces.h | 5 ++---
 backends/cryptodev.c            | 2 +-
 backends/hostmem.c              | 2 +-
 qom/object_interfaces.c         | 6 +++---
 4 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/include/qom/object_interfaces.h b/include/qom/object_interfa=
ces.h
index fdd7603..d63c1c2 100644
--- a/include/qom/object_interfaces.h
+++ b/include/qom/object_interfaces.h
@@ -51,7 +51,7 @@ typedef struct UserCreatableClass {
=20
     /* <public> */
     void (*complete)(UserCreatable *uc, Error **errp);
-    bool (*can_be_deleted)(UserCreatable *uc, Error **errp);
+    bool (*can_be_deleted)(UserCreatable *uc);
 } UserCreatableClass;
=20
 /**
@@ -68,12 +68,11 @@ void user_creatable_complete(Object *obj, Error **err=
p);
 /**
  * user_creatable_can_be_deleted:
  * @uc: the object whose can_be_deleted() method is called if implemente=
d
- * @errp: if an error occurs, a pointer to an area to store the error
  *
  * Wrapper to call can_be_deleted() method if one of types it's inherite=
d
  * from implements USER_CREATABLE interface.
  */
-bool user_creatable_can_be_deleted(UserCreatable *uc, Error **errp);
+bool user_creatable_can_be_deleted(UserCreatable *uc);
=20
 /**
  * user_creatable_add_type:
diff --git a/backends/cryptodev.c b/backends/cryptodev.c
index 1764c17..67edfa5 100644
--- a/backends/cryptodev.c
+++ b/backends/cryptodev.c
@@ -215,7 +215,7 @@ bool cryptodev_backend_is_ready(CryptoDevBackend *bac=
kend)
 }
=20
 static bool
-cryptodev_backend_can_be_deleted(UserCreatable *uc, Error **errp)
+cryptodev_backend_can_be_deleted(UserCreatable *uc)
 {
     return !cryptodev_backend_is_used(CRYPTODEV_BACKEND(uc));
 }
diff --git a/backends/hostmem.c b/backends/hostmem.c
index 4606b73..34550b9 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -342,7 +342,7 @@ out:
 }
=20
 static bool
-host_memory_backend_can_be_deleted(UserCreatable *uc, Error **errp)
+host_memory_backend_can_be_deleted(UserCreatable *uc)
 {
     if (host_memory_backend_is_mapped(MEMORY_BACKEND(uc))) {
         return false;
diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
index ff27e06..3bb8959 100644
--- a/qom/object_interfaces.c
+++ b/qom/object_interfaces.c
@@ -23,13 +23,13 @@ void user_creatable_complete(Object *obj, Error **err=
p)
     }
 }
=20
-bool user_creatable_can_be_deleted(UserCreatable *uc, Error **errp)
+bool user_creatable_can_be_deleted(UserCreatable *uc)
 {
=20
     UserCreatableClass *ucc =3D USER_CREATABLE_GET_CLASS(uc);
=20
     if (ucc->can_be_deleted) {
-        return ucc->can_be_deleted(uc, errp);
+        return ucc->can_be_deleted(uc);
     } else {
         return true;
     }
@@ -178,7 +178,7 @@ void user_creatable_del(const char *id, Error **errp)
         return;
     }
=20
-    if (!user_creatable_can_be_deleted(USER_CREATABLE(obj), errp)) {
+    if (!user_creatable_can_be_deleted(USER_CREATABLE(obj))) {
         error_setg(errp, "object '%s' is in use, can not be deleted", id=
);
         return;
     }
--=20
2.9.4
