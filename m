Received: from eggs.gnu.org ([2001:4830:134:3::10]:40648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dnnTi-0007m1-Mj
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:03:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dnnTg-0002rr-VI
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:03:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48896)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dnnTg-0002rO-N6
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:03:24 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri,  1 Sep 2017 12:02:49 -0300
Message-Id: <20170901150317.10380-2-ehabkost@redhat.com>
In-Reply-To: <20170901150317.10380-1-ehabkost@redhat.com>
References: <20170901150317.10380-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 01/29] qom: Remove unused errp parameter from
 can_be_deleted()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org

The errp argument is ignored by all implementations of the
method, and user_creatable_del() would break if any
implementation set an error (because it calls error_setg(errp) if
the function returns false).  Remove the unused parameter.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20170829220337.23427-1-ehabkost@redhat.com>
Reviewed-by: Gonglei <arei.gonglei@huawei.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/qom/object_interfaces.h | 5 ++---
 backends/cryptodev.c            | 2 +-
 backends/hostmem.c              | 2 +-
 qom/object_interfaces.c         | 6 +++---
 4 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/include/qom/object_interfaces.h b/include/qom/object_interfaces.h
index fdd7603c84..d63c1c28f8 100644
--- a/include/qom/object_interfaces.h
+++ b/include/qom/object_interfaces.h
@@ -51,7 +51,7 @@ typedef struct UserCreatableClass {
 
     /* <public> */
     void (*complete)(UserCreatable *uc, Error **errp);
-    bool (*can_be_deleted)(UserCreatable *uc, Error **errp);
+    bool (*can_be_deleted)(UserCreatable *uc);
 } UserCreatableClass;
 
 /**
@@ -68,12 +68,11 @@ void user_creatable_complete(Object *obj, Error **errp);
 /**
  * user_creatable_can_be_deleted:
  * @uc: the object whose can_be_deleted() method is called if implemented
- * @errp: if an error occurs, a pointer to an area to store the error
  *
  * Wrapper to call can_be_deleted() method if one of types it's inherited
  * from implements USER_CREATABLE interface.
  */
-bool user_creatable_can_be_deleted(UserCreatable *uc, Error **errp);
+bool user_creatable_can_be_deleted(UserCreatable *uc);
 
 /**
  * user_creatable_add_type:
diff --git a/backends/cryptodev.c b/backends/cryptodev.c
index 1764c179fe..67edfa5328 100644
--- a/backends/cryptodev.c
+++ b/backends/cryptodev.c
@@ -215,7 +215,7 @@ bool cryptodev_backend_is_ready(CryptoDevBackend *backend)
 }
 
 static bool
-cryptodev_backend_can_be_deleted(UserCreatable *uc, Error **errp)
+cryptodev_backend_can_be_deleted(UserCreatable *uc)
 {
     return !cryptodev_backend_is_used(CRYPTODEV_BACKEND(uc));
 }
diff --git a/backends/hostmem.c b/backends/hostmem.c
index 4606b73849..34550b9067 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -342,7 +342,7 @@ out:
 }
 
 static bool
-host_memory_backend_can_be_deleted(UserCreatable *uc, Error **errp)
+host_memory_backend_can_be_deleted(UserCreatable *uc)
 {
     if (host_memory_backend_is_mapped(MEMORY_BACKEND(uc))) {
         return false;
diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
index ff27e0669e..3bb8959f09 100644
--- a/qom/object_interfaces.c
+++ b/qom/object_interfaces.c
@@ -23,13 +23,13 @@ void user_creatable_complete(Object *obj, Error **errp)
     }
 }
 
-bool user_creatable_can_be_deleted(UserCreatable *uc, Error **errp)
+bool user_creatable_can_be_deleted(UserCreatable *uc)
 {
 
     UserCreatableClass *ucc = USER_CREATABLE_GET_CLASS(uc);
 
     if (ucc->can_be_deleted) {
-        return ucc->can_be_deleted(uc, errp);
+        return ucc->can_be_deleted(uc);
     } else {
         return true;
     }
@@ -178,7 +178,7 @@ void user_creatable_del(const char *id, Error **errp)
         return;
     }
 
-    if (!user_creatable_can_be_deleted(USER_CREATABLE(obj), errp)) {
+    if (!user_creatable_can_be_deleted(USER_CREATABLE(obj))) {
         error_setg(errp, "object '%s' is in use, can not be deleted", id);
         return;
     }
-- 
2.13.5
