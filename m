Received: from eggs.gnu.org ([209.51.188.92]:50846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gzkNF-0004sk-Iq
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 10:46:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gzkHP-0005nS-JS
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 10:40:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39718)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gzkHP-0005li-BV
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 10:40:55 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  1 Mar 2019 16:40:46 +0100
Message-Id: <20190301154051.23317-3-armbru@redhat.com>
In-Reply-To: <20190301154051.23317-1-armbru@redhat.com>
References: <20190301154051.23317-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 2/7] tests/qapi-schema: Cover conditional arrays
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

Commit 967c885108f neglected to cover arrays of conditional types.  Do
that now.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/qapi-schema/qapi-schema-test.json | 2 +-
 tests/qapi-schema/qapi-schema-test.out  | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/qapi-schema-test.json
index cb0857df52..70612f394e 100644
--- a/tests/qapi-schema/qapi-schema-test.json
+++ b/tests/qapi-schema/qapi-schema-test.json
@@ -236,5 +236,5 @@
 
 { 'event': 'TestIfEvent', 'data':
   { 'foo': 'TestIfStruct',
-    'bar': { 'type': 'TestIfEnum', 'if': 'defined(TEST_IF_EVT_BAR)' } },
+    'bar': { 'type': ['TestIfEnum'], 'if': 'defined(TEST_IF_EVT_BAR)' } },
   'if': 'defined(TEST_IF_EVT) && defined(TEST_IF_STRUCT)' }
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/qapi-schema-test.out
index b59f4ca5a4..97f671ca5f 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -325,9 +325,11 @@ command TestIfCmd q_obj_TestIfCmd-arg -> UserDefThree
     if ['defined(TEST_IF_CMD)', 'defined(TEST_IF_STRUCT)']
 command TestCmdReturnDefThree None -> UserDefThree
    gen=True success_response=True boxed=False oob=False preconfig=False
+array TestIfEnumList TestIfEnum
+    if ['defined(TEST_IF_ENUM)']
 object q_obj_TestIfEvent-arg
     member foo: TestIfStruct optional=False
-    member bar: TestIfEnum optional=False
+    member bar: TestIfEnumList optional=False
         if ['defined(TEST_IF_EVT_BAR)']
     if ['defined(TEST_IF_EVT) && defined(TEST_IF_STRUCT)']
 event TestIfEvent q_obj_TestIfEvent-arg
-- 
2.17.2
