Received: from eggs.gnu.org ([2001:4830:134:3::10]:50193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fC4xF-0002Lr-8z
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 11:06:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fC4xC-0003QT-LK
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 11:06:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43050 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fC4xC-0003QJ-Fx
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 11:06:30 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 23E50406C74B
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 15:06:30 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
Date: Fri, 27 Apr 2018 17:05:19 +0200
Message-Id: <1524841523-95513-8-git-send-email-imammedo@redhat.com>
In-Reply-To: <1524841523-95513-1-git-send-email-imammedo@redhat.com>
References: <1524841523-95513-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v6 07/11] tests: add allowed-in-preconfig-test
 for qapi-schema
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, ehabkost@redhat.com, pkrempa@redhat.com, armbru@redhat.com

make sure the QAPISchema can parse allowed-in-preconfig correctly

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 tests/Makefile.include                           | 1 +
 tests/qapi-schema/allowed-in-preconfig-test.err  | 1 +
 tests/qapi-schema/allowed-in-preconfig-test.exit | 1 +
 tests/qapi-schema/allowed-in-preconfig-test.json | 2 ++
 tests/qapi-schema/allowed-in-preconfig-test.out  | 0
 tests/qapi-schema/qapi-schema-test.json          | 3 +++
 tests/qapi-schema/qapi-schema-test.out           | 2 ++
 tests/test-qmp-cmds.c                            | 4 ++++
 8 files changed, 14 insertions(+)
 create mode 100644 tests/qapi-schema/allowed-in-preconfig-test.err
 create mode 100644 tests/qapi-schema/allowed-in-preconfig-test.exit
 create mode 100644 tests/qapi-schema/allowed-in-preconfig-test.json
 create mode 100644 tests/qapi-schema/allowed-in-preconfig-test.out

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 3b9a5e3..4d2460d 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -524,6 +524,7 @@ qapi-schema += missing-type.json
 qapi-schema += nested-struct-data.json
 qapi-schema += non-objects.json
 qapi-schema += oob-test.json
+qapi-schema += allowed-in-preconfig-test.json
 qapi-schema += pragma-doc-required-crap.json
 qapi-schema += pragma-extra-junk.json
 qapi-schema += pragma-name-case-whitelist-crap.json
diff --git a/tests/qapi-schema/allowed-in-preconfig-test.err b/tests/qapi-schema/allowed-in-preconfig-test.err
new file mode 100644
index 0000000..2b0511b
--- /dev/null
+++ b/tests/qapi-schema/allowed-in-preconfig-test.err
@@ -0,0 +1 @@
+tests/qapi-schema/allowed-in-preconfig-test.json:2: 'allowed-in-preconfig' of command 'allowed-in-preconfig-test' should only use true value
diff --git a/tests/qapi-schema/allowed-in-preconfig-test.exit b/tests/qapi-schema/allowed-in-preconfig-test.exit
new file mode 100644
index 0000000..d00491f
--- /dev/null
+++ b/tests/qapi-schema/allowed-in-preconfig-test.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/allowed-in-preconfig-test.json b/tests/qapi-schema/allowed-in-preconfig-test.json
new file mode 100644
index 0000000..7e0e6cb
--- /dev/null
+++ b/tests/qapi-schema/allowed-in-preconfig-test.json
@@ -0,0 +1,2 @@
+# Check against allowed-in-preconfig illegal value
+{ 'command': 'allowed-in-preconfig-test', 'allowed-in-preconfig': 'some-string' }
diff --git a/tests/qapi-schema/allowed-in-preconfig-test.out b/tests/qapi-schema/allowed-in-preconfig-test.out
new file mode 100644
index 0000000..e69de29
diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/qapi-schema-test.json
index 06e30f4..608ca35 100644
--- a/tests/qapi-schema/qapi-schema-test.json
+++ b/tests/qapi-schema/qapi-schema-test.json
@@ -142,6 +142,9 @@
 # Smoke test on Out-Of-Band
 { 'command': 'an-oob-command', 'allow-oob': true }
 
+# test allowed-in-preconfig flag
+{ 'command': 'allowed-in-preconfig-test', 'allowed-in-preconfig': true }
+
 # For testing integer range flattening in opts-visitor. The following schema
 # corresponds to the option format:
 #
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/qapi-schema-test.out
index 1f5038f..c955e2d 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -168,6 +168,8 @@ command boxed-union UserDefNativeListUnion -> None
    gen=True success_response=True boxed=True oob=False preconfig=False
 command an-oob-command None -> None
    gen=True success_response=True boxed=False oob=True preconfig=False
+command allowed-in-preconfig-test None -> None
+   gen=True success_response=True boxed=False oob=False preconfig=True
 object UserDefOptions
     member i64: intList optional=True
     member u64: uint64List optional=True
diff --git a/tests/test-qmp-cmds.c b/tests/test-qmp-cmds.c
index db690cc..730476a 100644
--- a/tests/test-qmp-cmds.c
+++ b/tests/test-qmp-cmds.c
@@ -20,6 +20,10 @@ void qmp_an_oob_command(Error **errp)
 {
 }
 
+void qmp_allowed_in_preconfig_test(Error **errp)
+{
+}
+
 Empty2 *qmp_user_def_cmd0(Error **errp)
 {
     return g_new0(Empty2, 1);
-- 
2.7.4
