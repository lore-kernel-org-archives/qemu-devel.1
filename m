Received: from eggs.gnu.org ([209.51.188.92]:50846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gzkNE-0004sk-Cm
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 10:46:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gzkHU-0005uZ-M2
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 10:41:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:6377)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gzkHR-0005pK-TR
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 10:40:58 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  1 Mar 2019 16:40:50 +0100
Message-Id: <20190301154051.23317-7-armbru@redhat.com>
In-Reply-To: <20190301154051.23317-1-armbru@redhat.com>
References: <20190301154051.23317-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 6/7] tests/qapi-schema: Cover forward reference
 to sub-module
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, eblake@redhat.com, quintela@redhat.com

The forward reference from the main module to the sub-module works
fine, except for an issue visible in qapi-schema-test.out: the array
type wrapped around the forward reference ends up in the main module,
not the sub-module.  The next commit will explain why that's bad, and
fix it.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/qapi-schema/qapi-schema-test.json | 3 ++-
 tests/qapi-schema/qapi-schema-test.out  | 5 +++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/qapi-schema-test.json
index 908f718027..0952c68734 100644
--- a/tests/qapi-schema/qapi-schema-test.json
+++ b/tests/qapi-schema/qapi-schema-test.json
@@ -128,7 +128,8 @@
             'boolean': ['bool'],
             'string': ['str'],
             'sizes': ['size'],
-            'any': ['any'] } }
+            'any': ['any'],
+            'user': ['Status'] } } # intentional forward ref. to sub-module
 
 # for testing sub-modules
 { 'include': 'include/sub-module.json' }
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/qapi-schema-test.out
index cecf270ec3..38c1de70d8 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -144,6 +144,9 @@ object q_obj_sizeList-wrapper
     member data: sizeList optional=False
 object q_obj_anyList-wrapper
     member data: anyList optional=False
+array StatusList Status
+object q_obj_StatusList-wrapper
+    member data: StatusList optional=False
 enum UserDefListUnionKind
     member integer
     member s8
@@ -159,6 +162,7 @@ enum UserDefListUnionKind
     member string
     member sizes
     member any
+    member user
 object UserDefListUnion
     member type: UserDefListUnionKind optional=False
     tag type
@@ -176,6 +180,7 @@ object UserDefListUnion
     case string: q_obj_strList-wrapper
     case sizes: q_obj_sizeList-wrapper
     case any: q_obj_anyList-wrapper
+    case user: q_obj_StatusList-wrapper
 include include/sub-module.json
 module include/sub-module.json
 include sub-sub-module.json
-- 
2.17.2
