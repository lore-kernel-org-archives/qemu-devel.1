Received: from eggs.gnu.org ([2001:4830:134:3::10]:38726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz2bc-0007yJ-7b
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz2ba-0007vG-81
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54582)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dz2ba-0007uB-2C
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:02 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  2 Oct 2017 17:25:35 +0200
Message-Id: <20171002152552.27999-16-armbru@redhat.com>
In-Reply-To: <20171002152552.27999-1-armbru@redhat.com>
References: <20171002152552.27999-1-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 15/32] tests/qapi-schema: Improve simple
 union coverage
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, marcandre.lureau@redhat.com, eblake@redhat.com
List-ID: <qemu-devel.nongnu.org>

This demonstrates a bug in the lowering of simple unions: if more than
one schema uses the same built-in type T for a simple union member,
they all generate the same q_obj_T_wrapper into their qapi-types.h.
They clash when you include more than one schema's qapi-types.h.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/qapi-schema/qapi-schema-test.json |  6 ++++++
 tests/qapi-schema/qapi-schema-test.out  | 10 ++++++++++
 2 files changed, 16 insertions(+)

diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/qapi-schema-test.json
index c72dbd8050..c091626635 100644
--- a/tests/qapi-schema/qapi-schema-test.json
+++ b/tests/qapi-schema/qapi-schema-test.json
@@ -82,6 +82,12 @@
   'base': 'UserDefZero',
   'data': { 'string': 'str', 'enum1': 'EnumOne' } }
 
+{ 'union': 'UserDefSimpleUnion',
+  'data': { 'value1': 'UserDefA',
+# FIXME generated q_obj_int_wrapper clashes with qapi-schema.json's
+#           'value2': 'int',
+            'value3': 'UserDefB' } }
+
 # this variant of UserDefFlatUnion defaults to a union that uses members with
 # allocated types to test corner cases in the cleanup/dealloc visitor
 { 'union': 'UserDefFlatUnion2',
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/qapi-schema-test.out
index 4b42db23b2..97bb02f2fd 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -108,6 +108,12 @@ object UserDefOptions
     member u16: uint16List optional=True
     member i64x: int optional=True
     member u64x: uint64 optional=True
+object UserDefSimpleUnion
+    member type: UserDefSimpleUnionKind optional=False
+    tag type
+    case value1: q_obj_UserDefA-wrapper
+    case value3: q_obj_UserDefB-wrapper
+enum UserDefSimpleUnionKind ['value1', 'value3']
 object UserDefTwo
     member string0: str optional=False
     member dict1: UserDefTwoDict optional=False
@@ -169,6 +175,10 @@ object q_obj_EVENT_D-arg
     member b: str optional=False
     member c: str optional=True
     member enum3: EnumOne optional=True
+object q_obj_UserDefA-wrapper
+    member data: UserDefA optional=False
+object q_obj_UserDefB-wrapper
+    member data: UserDefB optional=False
 object q_obj_UserDefFlatUnion2-base
     member integer: int optional=True
     member string: str optional=False
-- 
2.13.6
