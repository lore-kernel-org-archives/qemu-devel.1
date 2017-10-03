Received: from eggs.gnu.org ([2001:4830:134:3::10]:36642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dzScd-0001mD-5w
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 15:12:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dzSca-0005ba-0R
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 15:12:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38056)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dzScZ-0005Zg-Q2
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 15:12:47 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue,  3 Oct 2017 15:12:23 -0400
Message-Id: <20171003191227.11845-2-stefanha@redhat.com>
In-Reply-To: <20171003191227.11845-1-stefanha@redhat.com>
References: <20171003191227.11845-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/5] qom: provide root container for internal
 objs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: Peter Xu <peterx@redhat.com>

We have object_get_objects_root() to keep user created objects, however
no place for objects that will be used internally.  Create such a
container for internal objects.

CC: Andreas F=C3=A4rber <afaerber@suse.de>
CC: Markus Armbruster <armbru@redhat.com>
CC: Paolo Bonzini <pbonzini@redhat.com>
Suggested-by: Daniel P. Berrange <berrange@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Message-id: 20170928025958.1420-2-peterx@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/qom/object.h | 11 +++++++++++
 qom/object.c         | 11 +++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index f3e5cff37a..e0d9824415 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1214,6 +1214,17 @@ Object *object_get_root(void);
 Object *object_get_objects_root(void);
=20
 /**
+ * object_get_internal_root:
+ *
+ * Get the container object that holds internally used object
+ * instances.  Any object which is put into this container must not be
+ * user visible, and it will not be exposed in the QOM tree.
+ *
+ * Returns: the internal object container
+ */
+Object *object_get_internal_root(void);
+
+/**
  * object_get_canonical_path_component:
  *
  * Returns: The final component in the object's canonical path.  The can=
onical
diff --git a/qom/object.c b/qom/object.c
index 3e18537e9b..6a7bd9257b 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1370,6 +1370,17 @@ Object *object_get_objects_root(void)
     return container_get(object_get_root(), "/objects");
 }
=20
+Object *object_get_internal_root(void)
+{
+    static Object *internal_root;
+
+    if (!internal_root) {
+        internal_root =3D object_new("container");
+    }
+
+    return internal_root;
+}
+
 static void object_get_child_property(Object *obj, Visitor *v,
                                       const char *name, void *opaque,
                                       Error **errp)
--=20
2.13.6
