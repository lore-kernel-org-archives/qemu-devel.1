Received: from eggs.gnu.org ([209.51.188.92]:50900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gzkNE-0004uY-KT
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 10:46:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gzkHP-0005na-K2
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 10:40:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48390)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gzkHP-0005md-Cp
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 10:40:55 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  1 Mar 2019 16:40:45 +0100
Message-Id: <20190301154051.23317-2-armbru@redhat.com>
In-Reply-To: <20190301154051.23317-1-armbru@redhat.com>
References: <20190301154051.23317-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 1/7] tests/qapi-schema: Make test-qapi.py print
 arrays
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

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/qapi-schema/qapi-schema-test.out | 6 ++++++
 tests/qapi-schema/test-qapi.py         | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/qapi-schema-test.out
index d8aec17115..b59f4ca5a4 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -52,6 +52,9 @@ object UserDefTwo
     member dict1: UserDefTwoDict optional=False
 object UserDefThree
     member string0: str optional=False
+array UserDefOneList UserDefOne
+array UserDefTwoList UserDefTwo
+array TestStructList TestStruct
 object ForceArrays
     member unused1: UserDefOneList optional=False
     member unused2: UserDefTwoList optional=False
@@ -248,6 +251,7 @@ object __org.qemu_x-Union1
     member type: __org.qemu_x-Union1Kind optional=False
     tag type
     case __org.qemu_x-branch: q_obj_str-wrapper
+array __org.qemu_x-Union1List __org.qemu_x-Union1
 object __org.qemu_x-Struct2
     member array: __org.qemu_x-Union1List optional=False
 object __org.qemu_x-Union2
@@ -260,6 +264,8 @@ alternate __org.qemu_x-Alt
     case b: __org.qemu_x-Base
 event __ORG.QEMU_X-EVENT __org.qemu_x-Struct
    boxed=False
+array __org.qemu_x-EnumList __org.qemu_x-Enum
+array __org.qemu_x-StructList __org.qemu_x-Struct
 object q_obj___org.qemu_x-command-arg
     member a: __org.qemu_x-EnumList optional=False
     member b: __org.qemu_x-StructList optional=False
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi.py
index d592854601..d21fca01fc 100644
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -32,6 +32,12 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
             self._print_if(m.ifcond, indent=8)
         self._print_if(ifcond)
 
+    def visit_array_type(self, name, info, ifcond, element_type):
+        if not info:
+            return              # suppress built-in arrays
+        print('array %s %s' % (name, element_type.name))
+        self._print_if(ifcond)
+
     def visit_object_type(self, name, info, ifcond, base, members, variants):
         print('object %s' % name)
         if base:
-- 
2.17.2
