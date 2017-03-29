Received: from eggs.gnu.org ([2001:4830:134:3::10]:44801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ctJV7-0001ya-K2
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 15:43:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ctJV6-00008x-S8
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 15:43:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44420)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ctJV6-00008R-N1
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 15:43:24 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AE0E14E4D6
	for <qemu-devel@nongnu.org>; Wed, 29 Mar 2017 19:43:23 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed, 29 Mar 2017 16:41:43 -0300
Message-Id: <20170329194148.19015-5-ehabkost@redhat.com>
In-Reply-To: <20170329194148.19015-1-ehabkost@redhat.com>
References: <20170329194148.19015-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC v2 4/9] qom: Make object_class_get_parent()
 const-aware
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This makes object_class_get_parent() return a const pointer in
case its class argument is a const pointer.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/qom/object.h | 6 +++++-
 qom/object.c         | 2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 6829735f99..674a45862d 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -873,7 +873,11 @@ ObjectClass *object_class_dynamic_cast(ObjectClass *klass,
  *
  * Returns: The parent for @klass or %NULL if none.
  */
-ObjectClass *object_class_get_parent(ObjectClass *klass);
+#define object_class_get_parent(klass)            \
+    (QUALIFIED_CAST(typeof(klass), ObjectClass *) \
+     object_class_get_parent_const(klass))
+
+const ObjectClass *object_class_get_parent_const(const ObjectClass *klass);
 
 /**
  * object_class_get_name:
diff --git a/qom/object.c b/qom/object.c
index eb4bc924ff..8f60ad9b8e 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -774,7 +774,7 @@ ObjectClass *object_class_by_name(const char *typename)
     return type->class;
 }
 
-ObjectClass *object_class_get_parent(ObjectClass *class)
+const ObjectClass *object_class_get_parent_const(const ObjectClass *class)
 {
     TypeImpl *type = type_get_parent(class->type);
 
-- 
2.11.0.259.g40922b1
