Received: from eggs.gnu.org ([2001:4830:134:3::10]:47129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dQCP3-0002rO-9T
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:49:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dQCP2-00017m-Hv
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:49:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50143)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dQCP2-00017V-C8
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:49:04 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed, 28 Jun 2017 20:48:44 +0800
Message-Id: <20170628124850.12821-2-famz@redhat.com>
In-Reply-To: <20170628124850.12821-1-famz@redhat.com>
References: <20170628124850.12821-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 1/7] qom: Make link property API public
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>

The get/set pair and the struct will be reused by qdev link prop, make
them public.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 include/qom/object.h | 13 +++++++++++++
 qom/object.c         | 18 ++++++------------
 2 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index abaeb8c..4659e6a 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1613,4 +1613,17 @@ Object *container_get(Object *root, const char *path);
  * Returns the instance_size of the given @typename.
  */
 size_t object_type_get_instance_size(const char *typename);
+
+typedef struct {
+    Object **child;
+    void (*check)(Object *, const char *, Object *, Error **);
+    ObjectPropertyLinkFlags flags;
+} LinkProperty;
+
+void object_get_link_property(Object *obj, Visitor *v,
+                              const char *name, void *opaque,
+                              Error **errp);
+void object_set_link_property(Object *obj, Visitor *v,
+                              const char *name, void *opaque,
+                              Error **errp);
 #endif
diff --git a/qom/object.c b/qom/object.c
index 5f6fdfa..3868370 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1434,15 +1434,9 @@ void object_property_allow_set_link(Object *obj, const char *name,
     /* Allow the link to be set, always */
 }
 
-typedef struct {
-    Object **child;
-    void (*check)(Object *, const char *, Object *, Error **);
-    ObjectPropertyLinkFlags flags;
-} LinkProperty;
-
-static void object_get_link_property(Object *obj, Visitor *v,
-                                     const char *name, void *opaque,
-                                     Error **errp)
+void object_get_link_property(Object *obj, Visitor *v,
+                              const char *name, void *opaque,
+                              Error **errp)
 {
     LinkProperty *lprop = opaque;
     Object **child = lprop->child;
@@ -1498,9 +1492,9 @@ static Object *object_resolve_link(Object *obj, const char *name,
     return target;
 }
 
-static void object_set_link_property(Object *obj, Visitor *v,
-                                     const char *name, void *opaque,
-                                     Error **errp)
+void object_set_link_property(Object *obj, Visitor *v,
+                              const char *name, void *opaque,
+                              Error **errp)
 {
     Error *local_err = NULL;
     LinkProperty *prop = opaque;
-- 
2.9.4
