Received: from eggs.gnu.org ([2001:4830:134:3::10]:58193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fYDQH-0003FF-Gx
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 12:36:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fYDQG-0002vU-Du
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 12:36:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43752 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fYDQG-0002um-8M
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 12:36:00 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 27 Jun 2018 18:35:38 +0200
Message-Id: <20180627163551.31610-3-marcandre.lureau@redhat.com>
In-Reply-To: <20180627163551.31610-1-marcandre.lureau@redhat.com>
References: <20180627163551.31610-1-marcandre.lureau@redhat.com>
Subject: [Qemu-devel] [PATCH v6 02/15] tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, eblake@redhat.com, armbru@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

---
 tests/test-qmp-cmds.c                   | 8 +++++++-
 tests/qapi-schema/qapi-schema-test.json | 6 ++++++
 tests/qapi-schema/qapi-schema-test.out  | 6 +++++-
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/tests/test-qmp-cmds.c b/tests/test-qmp-cmds.c
index eaf30b7a0f..840530b84c 100644
--- a/tests/test-qmp-cmds.c
+++ b/tests/test-qmp-cmds.c
@@ -13,11 +13,17 @@
 static QmpCommandList qmp_commands;
 
 /* #if defined(TEST_IF_STRUCT) && defined(TEST_IF_CMD) */
-void qmp_TestIfCmd(TestIfStruct *foo, Error **errp)
+UserDefThree *qmp_TestIfCmd(TestIfStruct *foo, Error **errp)
 {
+    return NULL;
 }
 /* #endif */
 
+UserDefThree *qmp_TestCmdReturnDefThree(Error **errp)
+{
+    return NULL;
+}
+
 void qmp_user_def_cmd(Error **errp)
 {
 }
diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/qapi-schema-test.json
index ec0fea804f..16209b57b3 100644
--- a/tests/qapi-schema/qapi-schema-test.json
+++ b/tests/qapi-schema/qapi-schema-test.json
@@ -56,6 +56,9 @@
   'data': { 'string0': 'str',
             'dict1': 'UserDefTwoDict' } }
 
+{ 'struct': 'UserDefThree',
+  'data': { 'string0': 'str' } }
+
 # dummy struct to force generation of array types not otherwise mentioned
 { 'struct': 'ForceArrays',
   'data': { 'unused1':['UserDefOne'], 'unused2':['UserDefTwo'],
@@ -209,7 +212,10 @@
   'if': 'defined(TEST_IF_ALT) && defined(TEST_IF_STRUCT)' }
 
 { 'command': 'TestIfCmd', 'data': { 'foo': 'TestIfStruct' },
+  'returns': 'UserDefThree',
   'if': ['defined(TEST_IF_CMD)', 'defined(TEST_IF_STRUCT)'] }
 
+{ 'command': 'TestCmdReturnDefThree', 'returns': 'UserDefThree' }
+
 { 'event': 'TestIfEvent', 'data': { 'foo': 'TestIfStruct' },
   'if': 'defined(TEST_IF_EVT) && defined(TEST_IF_STRUCT)' }
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/qapi-schema-test.out
index 34b6d546f3..ed25e5b60c 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -36,6 +36,8 @@ object UserDefTwoDict
 object UserDefTwo
     member string0: str optional=False
     member dict1: UserDefTwoDict optional=False
+object UserDefThree
+    member string0: str optional=False
 object ForceArrays
     member unused1: UserDefOneList optional=False
     member unused2: UserDefTwoList optional=False
@@ -249,7 +251,9 @@ alternate TestIfAlternate
     case bar: TestStruct
 object q_obj_TestIfCmd-arg
     member foo: TestIfStruct optional=False
-command TestIfCmd q_obj_TestIfCmd-arg -> None
+command TestIfCmd q_obj_TestIfCmd-arg -> UserDefThree
+   gen=True success_response=True boxed=False oob=False preconfig=False
+command TestCmdReturnDefThree None -> UserDefThree
    gen=True success_response=True boxed=False oob=False preconfig=False
 object q_obj_TestIfEvent-arg
     member foo: TestIfStruct optional=False
-- 
2.18.0.rc1
