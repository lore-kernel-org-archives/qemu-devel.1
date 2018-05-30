Received: from eggs.gnu.org ([2001:4830:134:3::10]:46192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fOAA6-0004dW-8I
	for qemu-devel@nongnu.org; Wed, 30 May 2018 19:05:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fOAA4-00005n-LD
	for qemu-devel@nongnu.org; Wed, 30 May 2018 19:05:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46266)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fOAA4-00005Y-Cc
	for qemu-devel@nongnu.org; Wed, 30 May 2018 19:05:44 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed, 30 May 2018 20:05:23 -0300
Message-Id: <20180530230528.30166-8-ehabkost@redhat.com>
In-Reply-To: <20180530230528.30166-1-ehabkost@redhat.com>
References: <20180530230528.30166-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 07/12] tests: qapi-schema tests for
 allow-preconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

use new allow-preconfig parameter in tests and make sure that
the QAPISchema can parse allow-preconfig correctly

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <1526058959-41425-1-git-send-email-imammedo@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/test-qmp-cmds.c                       |  2 +-
 tests/Makefile.include                      |  1 +
 tests/qapi-schema/allow-preconfig-test.err  |  1 +
 tests/qapi-schema/allow-preconfig-test.exit |  1 +
 tests/qapi-schema/allow-preconfig-test.json |  2 ++
 tests/qapi-schema/allow-preconfig-test.out  |  0
 tests/qapi-schema/doc-good.out              |  4 ++--
 tests/qapi-schema/ident-with-escape.out     |  2 +-
 tests/qapi-schema/indented-expr.out         |  4 ++--
 tests/qapi-schema/qapi-schema-test.json     |  4 ++--
 tests/qapi-schema/qapi-schema-test.out      | 22 ++++++++++-----------
 tests/qapi-schema/test-qapi.py              |  4 ++--
 12 files changed, 26 insertions(+), 21 deletions(-)
 create mode 100644 tests/qapi-schema/allow-preconfig-test.err
 create mode 100644 tests/qapi-schema/allow-preconfig-test.exit
 create mode 100644 tests/qapi-schema/allow-preconfig-test.json
 create mode 100644 tests/qapi-schema/allow-preconfig-test.out

diff --git a/tests/test-qmp-cmds.c b/tests/test-qmp-cmds.c
index e0ed461f58..491b0c4a44 100644
--- a/tests/test-qmp-cmds.c
+++ b/tests/test-qmp-cmds.c
@@ -16,7 +16,7 @@ void qmp_user_def_cmd(Error **errp)
 {
 }
 
-void qmp_an_oob_command(Error **errp)
+void qmp_test_flags_command(Error **errp)
 {
 }
 
diff --git a/tests/Makefile.include b/tests/Makefile.include
index b499ba1813..86f90c0cb0 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -525,6 +525,7 @@ qapi-schema += missing-type.json
 qapi-schema += nested-struct-data.json
 qapi-schema += non-objects.json
 qapi-schema += oob-test.json
+qapi-schema += allow-preconfig-test.json
 qapi-schema += pragma-doc-required-crap.json
 qapi-schema += pragma-extra-junk.json
 qapi-schema += pragma-name-case-whitelist-crap.json
diff --git a/tests/qapi-schema/allow-preconfig-test.err b/tests/qapi-schema/allow-preconfig-test.err
new file mode 100644
index 0000000000..700d583306
--- /dev/null
+++ b/tests/qapi-schema/allow-preconfig-test.err
@@ -0,0 +1 @@
+tests/qapi-schema/allow-preconfig-test.json:2: 'allow-preconfig' of command 'allow-preconfig-test' should only use true value
diff --git a/tests/qapi-schema/allow-preconfig-test.exit b/tests/qapi-schema/allow-preconfig-test.exit
new file mode 100644
index 0000000000..d00491fd7e
--- /dev/null
+++ b/tests/qapi-schema/allow-preconfig-test.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/allow-preconfig-test.json b/tests/qapi-schema/allow-preconfig-test.json
new file mode 100644
index 0000000000..d9f0e914df
--- /dev/null
+++ b/tests/qapi-schema/allow-preconfig-test.json
@@ -0,0 +1,2 @@
+# Check against allow-preconfig illegal value
+{ 'command': 'allow-preconfig-test', 'allow-preconfig': 'some-string' }
diff --git a/tests/qapi-schema/allow-preconfig-test.out b/tests/qapi-schema/allow-preconfig-test.out
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.out
index 63058b1590..9c8a4838e1 100644
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
index 82213aa51d..24c976f473 100644
--- a/tests/qapi-schema/ident-with-escape.out
+++ b/tests/qapi-schema/ident-with-escape.out
@@ -5,4 +5,4 @@ module ident-with-escape.json
 object q_obj_fooA-arg
     member bar1: str optional=False
 command fooA q_obj_fooA-arg -> None
-   gen=True success_response=True boxed=False oob=False
+   gen=True success_response=True boxed=False oob=False preconfig=False
diff --git a/tests/qapi-schema/indented-expr.out b/tests/qapi-schema/indented-expr.out
index 862678f8f4..bd8a48630e 100644
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
index 06e30f452e..46c7282945 100644
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
index 467577d770..542a19c407 100644
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
index 89b92eddd4..4512a41504 100644
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
-- 
2.17.1
