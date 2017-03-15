Received: from eggs.gnu.org ([2001:4830:134:3::10]:33624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1co8Ux-0001am-8E
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:57:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1co8Us-0000Oc-2C
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:57:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50506)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1co8Ur-0000M1-Q6
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:57:45 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 15 Mar 2017 13:57:34 +0100
Message-Id: <1489582656-31133-46-git-send-email-armbru@redhat.com>
In-Reply-To: <1489582656-31133-1-git-send-email-armbru@redhat.com>
References: <1489582656-31133-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 for-2.9 45/47] qapi: Drop unused
 .check_clash() parameter schema
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, eblake@redhat.com, mdroth@linux.vnet.ibm.com

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 scripts/qapi.py | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index 82c25a1..b798ae4 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -1183,7 +1183,7 @@ class QAPISchemaObjectType(QAPISchemaType):
             self.base = schema.lookup_type(self._base_name)
             assert isinstance(self.base, QAPISchemaObjectType)
             self.base.check(schema)
-            self.base.check_clash(schema, self.info, seen)
+            self.base.check_clash(self.info, seen)
         for m in self.local_members:
             m.check(schema)
             m.check_clash(self.info, seen)
@@ -1193,14 +1193,14 @@ class QAPISchemaObjectType(QAPISchemaType):
         if self.variants:
             self.variants.check(schema, seen)
             assert self.variants.tag_member in self.members
-            self.variants.check_clash(schema, self.info, seen)
+            self.variants.check_clash(self.info, seen)
         if self.doc:
             self.doc.check()
 
     # Check that the members of this type do not cause duplicate JSON members,
     # and update seen to track the members seen so far. Report any errors
     # on behalf of info, which is not necessarily self.info
-    def check_clash(self, schema, info, seen):
+    def check_clash(self, info, seen):
         assert not self.variants       # not implemented
         for m in self.members:
             m.check_clash(info, seen)
@@ -1329,12 +1329,12 @@ class QAPISchemaObjectTypeVariants(object):
                 assert isinstance(v.type, QAPISchemaObjectType)
                 v.type.check(schema)
 
-    def check_clash(self, schema, info, seen):
+    def check_clash(self, info, seen):
         for v in self.variants:
             # Reset seen map for each variant, since qapi names from one
             # branch do not affect another branch
             assert isinstance(v.type, QAPISchemaObjectType)
-            v.type.check_clash(schema, info, dict(seen))
+            v.type.check_clash(info, dict(seen))
 
 
 class QAPISchemaObjectTypeVariant(QAPISchemaObjectTypeMember):
-- 
2.7.4
