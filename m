Received: from eggs.gnu.org ([2001:4830:134:3::10]:43211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fHBf0-0003va-68
	for qemu-devel@nongnu.org; Fri, 11 May 2018 13:16:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fHBey-0002MO-Fa
	for qemu-devel@nongnu.org; Fri, 11 May 2018 13:16:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48962 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fHBey-0002MF-9P
	for qemu-devel@nongnu.org; Fri, 11 May 2018 13:16:48 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E8AD740006ED
	for <qemu-devel@nongnu.org>; Fri, 11 May 2018 17:16:47 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
Date: Fri, 11 May 2018 19:15:59 +0200
Message-Id: <1526058959-41425-1-git-send-email-imammedo@redhat.com>
In-Reply-To: <1525423069-61903-7-git-send-email-imammedo@redhat.com>
References: <1525423069-61903-7-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v8 06/11] tests: qapi-schema tests for
 allow-preconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, armbru@redhat.com, eblake@redhat.com

use new allow-preconfig parameter in tests and make sure that
the QAPISchema can parse allow-preconfig correctly

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
v7:
  * s/allowed_in_preconfig/allow_preconfig/
  * squash in "tests: add allow-preconfig-test for qapi-schema"
  * reuse an-oob-command for allow-preconfig test and rename it to test-flags-command
---
 tests/Makefile.include                      |  1 +
 tests/qapi-schema/allow-preconfig-test.err  |  1 +
 tests/qapi-schema/allow-preconfig-test.exit |  1 +
 tests/qapi-schema/allow-preconfig-test.json |  2 ++
 tests/qapi-schema/allow-preconfig-test.out  |  0
 tests/qapi-schema/doc-good.out              |  4 ++--
 tests/qapi-schema/ident-with-escape.out     |  2 +-
 tests/qapi-schema/indented-expr.out         |  4 ++--
 tests/qapi-schema/qapi-schema-test.json     |  4 ++--
 tests/qapi-schema/qapi-schema-test.out      | 22 +++++++++++-----------
 tests/qapi-schema/test-qapi.py              |  4 ++--
 tests/test-qmp-cmds.c                       |  2 +-
 12 files changed, 26 insertions(+), 21 deletions(-)
 create mode 100644 tests/qapi-schema/allow-preconfig-test.err
 create mode 100644 tests/qapi-schema/allow-preconfig-test.exit
 create mode 100644 tests/qapi-schema/allow-preconfig-test.json
 create mode 100644 tests/qapi-schema/allow-preconfig-test.out

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 3b9a5e3..74ed400 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -524,6 +524,7 @@ qapi-schema += missing-type.json
 qapi-schema += nested-struct-data.json
 qapi-schema += non-objects.json
 qapi-schema += oob-test.json
+qapi-schema += allow-preconfig-test.json
 qapi-schema += pragma-doc-required-crap.json
 qapi-schema += pragma-extra-junk.json
 qapi-schema += pragma-name-case-whitelist-crap.json
diff --git a/tests/qapi-schema/allow-preconfig-test.err b/tests/qapi-schema/allow-preconfig-test.err
new file mode 100644
index 0000000..700d583
--- /dev/null
+++ b/tests/qapi-schema/allow-preconfig-test.err
@@ -0,0 +1 @@
+tests/qapi-schema/allow-preconfig-test.json:2: 'allow-preconfig' of command 'allow-preconfig-test' should only use true value
diff --git a/tests/qapi-schema/allow-preconfig-test.exit b/tests/qapi-schema/allow-preconfig-test.exit
new file mode 100644
index 0000000..d00491f
--- /dev/null
+++ b/tests/qapi-schema/allow-preconfig-test.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/allow-preconfig-test.json b/tests/qapi-schema/allow-preconfig-test.json
new file mode 100644
index 0000000..d9f0e91
--- /dev/null
+++ b/tests/qapi-schema/allow-preconfig-test.json
@@ -0,0 +1,2 @@
+# Check against allow-preconfig illegal value
+{ 'command': 'allow-preconfig-test', 'allow-preconfig': 'some-string' }
diff --git a/tests/qapi-schema/allow-preconfig-test.out b/tests/qapi-schema/allow-preconfig-test.out
new file mode 100644
index 0000000..e69de29
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.out
index 63058b1..9c8a483 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -28,9 +28,9 @@ object q_obj_cmd-arg
     member arg2: str optional=True
     member arg3: bool optional=False
 command cmd q_obj_cmd-arg -> Object
-   gen=True success_response=True boxed=False oob=False
+   gen=True success_response=True boxed=False oob=False preconfig=False
 command cmd-boxed Object -> None
-   gen=True success_response=True boxed=True oob=False
+   gen=True success_response=True boxed=True oob=False preconfig=False
 doc freeform
     body=
 = Section
diff --git a/tests/qapi-schema/ident-with-escape.out b/tests/qapi-schema/ident-with-escape.out
index 82213aa..24c976f 100644
--- a/tests/qapi-schema/ident-with-escape.out
+++ b/tests/qapi-schema/ident-with-escape.out
@@ -5,4 +5,4 @@ module ident-with-escape.json
 object q_obj_fooA-arg
     member bar1: str optional=False
 command fooA q_obj_fooA-arg -> None
-   gen=True success_response=True boxed=False oob=False
+   gen=True success_response=True boxed=False oob=False preconfig=False
diff --git a/tests/qapi-schema/indented-expr.out b/tests/qapi-schema/indented-expr.out
index 862678f..bd8a486 100644
--- a/tests/qapi-schema/indented-expr.out
+++ b/tests/qapi-schema/indented-expr.out
@@ -3,6 +3,6 @@ enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool']
     prefix QTYPE
 module indented-expr.json
 command eins None -> None
-   gen=True success_response=True boxed=False oob=False
+   gen=True success_response=True boxed=False oob=False preconfig=False
 command zwei None -> None
-   gen=True success_response=True boxed=False oob=False
+   gen=True success_response=True boxed=False oob=False preconfig=False
diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/qapi-schema-test.json
index 06e30f4..46c7282 100644
--- a/tests/qapi-schema/qapi-schema-test.json
+++ b/tests/qapi-schema/qapi-schema-test.json
@@ -139,8 +139,8 @@
 { 'command': 'boxed-struct', 'boxed': true, 'data': 'UserDefZero' }
 { 'command': 'boxed-union', 'data': 'UserDefNativeListUnion', 'boxed': true }
 
-# Smoke test on Out-Of-Band
-{ 'command': 'an-oob-command', 'allow-oob': true }
+# Smoke test on Out-Of-Band and allow-preconfig-test
+{ 'command': 'test-flags-command', 'allow-oob': true, 'allow-preconfig': true }
 
 # For testing integer range flattening in opts-visitor. The following schema
 # corresponds to the option format:
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/qapi-schema-test.out
index 467577d..542a19c 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -16,7 +16,7 @@ object Empty1
 object Empty2
     base Empty1
 command user_def_cmd0 Empty2 -> Empty2
-   gen=True success_response=True boxed=False oob=False
+   gen=True success_response=True boxed=False oob=False preconfig=False
 enum QEnumTwo ['value1', 'value2']
     prefix QENUM_TWO
 object UserDefOne
@@ -143,31 +143,31 @@ object UserDefNativeListUnion
     case sizes: q_obj_sizeList-wrapper
     case any: q_obj_anyList-wrapper
 command user_def_cmd None -> None
-   gen=True success_response=True boxed=False oob=False
+   gen=True success_response=True boxed=False oob=False preconfig=False
 object q_obj_user_def_cmd1-arg
     member ud1a: UserDefOne optional=False
 command user_def_cmd1 q_obj_user_def_cmd1-arg -> None
-   gen=True success_response=True boxed=False oob=False
+   gen=True success_response=True boxed=False oob=False preconfig=False
 object q_obj_user_def_cmd2-arg
     member ud1a: UserDefOne optional=False
     member ud1b: UserDefOne optional=True
 command user_def_cmd2 q_obj_user_def_cmd2-arg -> UserDefTwo
-   gen=True success_response=True boxed=False oob=False
+   gen=True success_response=True boxed=False oob=False preconfig=False
 object q_obj_guest-get-time-arg
     member a: int optional=False
     member b: int optional=True
 command guest-get-time q_obj_guest-get-time-arg -> int
-   gen=True success_response=True boxed=False oob=False
+   gen=True success_response=True boxed=False oob=False preconfig=False
 object q_obj_guest-sync-arg
     member arg: any optional=False
 command guest-sync q_obj_guest-sync-arg -> any
-   gen=True success_response=True boxed=False oob=False
+   gen=True success_response=True boxed=False oob=False preconfig=False
 command boxed-struct UserDefZero -> None
-   gen=True success_response=True boxed=True oob=False
+   gen=True success_response=True boxed=True oob=False preconfig=False
 command boxed-union UserDefNativeListUnion -> None
-   gen=True success_response=True boxed=True oob=False
-command an-oob-command None -> None
-   gen=True success_response=True boxed=False oob=True
+   gen=True success_response=True boxed=True oob=False preconfig=False
+command test-flags-command None -> None
+   gen=True success_response=True boxed=False oob=True preconfig=True
 object UserDefOptions
     member i64: intList optional=True
     member u64: uint64List optional=True
@@ -231,4 +231,4 @@ object q_obj___org.qemu_x-command-arg
     member c: __org.qemu_x-Union2 optional=False
     member d: __org.qemu_x-Alt optional=False
 command __org.qemu_x-command q_obj___org.qemu_x-command-arg -> __org.qemu_x-Union1
-   gen=True success_response=True boxed=False oob=False
+   gen=True success_response=True boxed=False oob=False preconfig=False
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi.py
index 89b92ed..4512a41 100644
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -45,8 +45,8 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
                       success_response, boxed, allow_oob, allow_preconfig):
         print('command %s %s -> %s' % \
               (name, arg_type and arg_type.name, ret_type and ret_type.name))
-        print('   gen=%s success_response=%s boxed=%s oob=%s' % \
-              (gen, success_response, boxed, allow_oob))
+        print('   gen=%s success_response=%s boxed=%s oob=%s preconfig=%s' % \
+              (gen, success_response, boxed, allow_oob, allow_preconfig))
 
     def visit_event(self, name, info, arg_type, boxed):
         print('event %s %s' % (name, arg_type and arg_type.name))
diff --git a/tests/test-qmp-cmds.c b/tests/test-qmp-cmds.c
index e0ed461..491b0c4 100644
--- a/tests/test-qmp-cmds.c
+++ b/tests/test-qmp-cmds.c
@@ -16,7 +16,7 @@ void qmp_user_def_cmd(Error **errp)
 {
 }
 
-void qmp_an_oob_command(Error **errp)
+void qmp_test_flags_command(Error **errp)
 {
 }
 
-- 
2.7.4
