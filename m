Received: from eggs.gnu.org ([209.51.188.92]:55421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hDVO1-0007Kp-1B
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 10:36:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hDVNy-0000To-N7
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 10:36:35 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon,  8 Apr 2019 16:35:41 +0200
Message-Id: <20190408143543.3982-3-kwolf@redhat.com>
In-Reply-To: <20190408143543.3982-1-kwolf@redhat.com>
References: <20190408143543.3982-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/4] tests/qapi-schema: Test for good feature
 lists in structs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qapi-schema/qapi-schema-test.json | 27 +++++++++++++++++++++++++
 tests/qapi-schema/qapi-schema-test.out  | 26 ++++++++++++++++++++++++
 tests/qapi-schema/test-qapi.py          |  4 ++++
 3 files changed, 57 insertions(+)

diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/=
qapi-schema-test.json
index 0952c68734..263514b448 100644
--- a/tests/qapi-schema/qapi-schema-test.json
+++ b/tests/qapi-schema/qapi-schema-test.json
@@ -242,3 +242,30 @@
   { 'foo': 'TestIfStruct',
     'bar': { 'type': ['TestIfEnum'], 'if': 'defined(TEST_IF_EVT_BAR)' } =
},
   'if': 'defined(TEST_IF_EVT) && defined(TEST_IF_STRUCT)' }
+
+# test 'features' for structs
+
+{ 'struct': 'FeatureStruct0',
+  'data': { 'foo': 'int' },
+  'features': [] }
+{ 'struct': 'FeatureStruct1',
+  'data': { 'foo': 'int' },
+  'features': [ 'feature1' ] }
+{ 'struct': 'FeatureStruct2',
+  'data': { 'foo': 'int' },
+  'features': [ { 'name': 'feature1' } ] }
+{ 'struct': 'FeatureStruct3',
+  'data': { 'foo': 'int' },
+  'features': [ 'feature1', 'feature2' ] }
+
+{ 'struct': 'CondFeatureStruct1',
+  'data': { 'foo': 'int' },
+  'features': [ { 'name': 'feature1', 'if': 'defined(TEST_IF_FEATURE_1)'=
} ] }
+{ 'struct': 'CondFeatureStruct2',
+  'data': { 'foo': 'int' },
+  'features': [ { 'name': 'feature1', 'if': 'defined(TEST_IF_FEATURE_1)'=
},
+                { 'name': 'feature2', 'if': 'defined(TEST_IF_FEATURE_2)'=
} ] }
+{ 'struct': 'CondFeatureStruct3',
+  'data': { 'foo': 'int' },
+  'features': [ { 'name': 'feature1', 'if': [ 'defined(TEST_IF_COND_1)',
+                                              'defined(TEST_IF_COND_2)']=
 } ] }
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/q=
api-schema-test.out
index 77fb1e1aa9..490e202f65 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -354,3 +354,29 @@ object q_obj_TestIfEvent-arg
 event TestIfEvent q_obj_TestIfEvent-arg
    boxed=3DFalse
     if ['defined(TEST_IF_EVT) && defined(TEST_IF_STRUCT)']
+object FeatureStruct0
+    member foo: int optional=3DFalse
+object FeatureStruct1
+    member foo: int optional=3DFalse
+    feature feature1
+object FeatureStruct2
+    member foo: int optional=3DFalse
+    feature feature1
+object FeatureStruct3
+    member foo: int optional=3DFalse
+    feature feature1
+    feature feature2
+object CondFeatureStruct1
+    member foo: int optional=3DFalse
+    feature feature1
+        if ['defined(TEST_IF_FEATURE_1)']
+object CondFeatureStruct2
+    member foo: int optional=3DFalse
+    feature feature1
+        if ['defined(TEST_IF_FEATURE_1)']
+    feature feature2
+        if ['defined(TEST_IF_FEATURE_2)']
+object CondFeatureStruct3
+    member foo: int optional=3DFalse
+    feature feature1
+        if ['defined(TEST_IF_COND_1)', 'defined(TEST_IF_COND_2)']
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi=
.py
index f2d6815c86..08e29c23a6 100644
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -49,6 +49,10 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
             self._print_if(m.ifcond, 8)
         self._print_variants(variants)
         self._print_if(ifcond)
+        if features:
+            for f in features:
+                print('    feature %s' % f['name'])
+                self._print_if(f.get('if'), 8)
=20
     def visit_alternate_type(self, name, info, ifcond, variants):
         print('alternate %s' % name)
--=20
2.20.1
