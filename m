Received: from eggs.gnu.org ([2001:4830:134:3::10]:38242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f0Lmy-0002Is-Fd
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 02:39:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f0Lmx-0006kx-IX
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 02:39:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33386 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1f0Lmx-0006kr-D9
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 02:39:27 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EFDB54068026
	for <qemu-devel@nongnu.org>; Mon, 26 Mar 2018 06:39:26 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Mon, 26 Mar 2018 14:38:59 +0800
Message-Id: <20180326063901.27425-7-peterx@redhat.com>
In-Reply-To: <20180326063901.27425-1-peterx@redhat.com>
References: <20180326063901.27425-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.12 6/8] tests: add oob-test for
 qapi-schema
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

It simply tests the new OOB capability, and make sure the QAPISchema can
parse it correctly.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/Makefile.include                  | 1 +
 tests/qapi-schema/oob-test.err          | 1 +
 tests/qapi-schema/oob-test.exit         | 1 +
 tests/qapi-schema/oob-test.json         | 2 ++
 tests/qapi-schema/oob-test.out          | 0
 tests/qapi-schema/qapi-schema-test.json | 3 +++
 tests/qapi-schema/qapi-schema-test.out  | 2 ++
 tests/test-qmp-cmds.c                   | 4 ++++
 8 files changed, 14 insertions(+)
 create mode 100644 tests/qapi-schema/oob-test.err
 create mode 100644 tests/qapi-schema/oob-test.exit
 create mode 100644 tests/qapi-schema/oob-test.json
 create mode 100644 tests/qapi-schema/oob-test.out

diff --git a/tests/Makefile.include b/tests/Makefile.include
index eb218a9539..3b9a5e31a2 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -523,6 +523,7 @@ qapi-schema += missing-comma-object.json
 qapi-schema += missing-type.json
 qapi-schema += nested-struct-data.json
 qapi-schema += non-objects.json
+qapi-schema += oob-test.json
 qapi-schema += pragma-doc-required-crap.json
 qapi-schema += pragma-extra-junk.json
 qapi-schema += pragma-name-case-whitelist-crap.json
diff --git a/tests/qapi-schema/oob-test.err b/tests/qapi-schema/oob-test.err
new file mode 100644
index 0000000000..35b60f7480
--- /dev/null
+++ b/tests/qapi-schema/oob-test.err
@@ -0,0 +1 @@
+tests/qapi-schema/oob-test.json:2: 'allow-oob' of command 'oob-command-1' should only use true value
diff --git a/tests/qapi-schema/oob-test.exit b/tests/qapi-schema/oob-test.exit
new file mode 100644
index 0000000000..d00491fd7e
--- /dev/null
+++ b/tests/qapi-schema/oob-test.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/oob-test.json b/tests/qapi-schema/oob-test.json
new file mode 100644
index 0000000000..da9635920f
--- /dev/null
+++ b/tests/qapi-schema/oob-test.json
@@ -0,0 +1,2 @@
+# Check against oob illegal value
+{ 'command': 'oob-command-1', 'allow-oob': 'some-string' }
diff --git a/tests/qapi-schema/oob-test.out b/tests/qapi-schema/oob-test.out
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/qapi-schema-test.json
index c72dbd8050..06e30f452e 100644
--- a/tests/qapi-schema/qapi-schema-test.json
+++ b/tests/qapi-schema/qapi-schema-test.json
@@ -139,6 +139,9 @@
 { 'command': 'boxed-struct', 'boxed': true, 'data': 'UserDefZero' }
 { 'command': 'boxed-union', 'data': 'UserDefNativeListUnion', 'boxed': true }
 
+# Smoke test on Out-Of-Band
+{ 'command': 'an-oob-command', 'allow-oob': true }
+
 # For testing integer range flattening in opts-visitor. The following schema
 # corresponds to the option format:
 #
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/qapi-schema-test.out
index 4f43370017..467577d770 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -166,6 +166,8 @@ command boxed-struct UserDefZero -> None
    gen=True success_response=True boxed=True oob=False
 command boxed-union UserDefNativeListUnion -> None
    gen=True success_response=True boxed=True oob=False
+command an-oob-command None -> None
+   gen=True success_response=True boxed=False oob=True
 object UserDefOptions
     member i64: intList optional=True
     member u64: uint64List optional=True
diff --git a/tests/test-qmp-cmds.c b/tests/test-qmp-cmds.c
index 93fbbb1b73..db690cc5ae 100644
--- a/tests/test-qmp-cmds.c
+++ b/tests/test-qmp-cmds.c
@@ -16,6 +16,10 @@ void qmp_user_def_cmd(Error **errp)
 {
 }
 
+void qmp_an_oob_command(Error **errp)
+{
+}
+
 Empty2 *qmp_user_def_cmd0(Error **errp)
 {
     return g_new0(Empty2, 1);
-- 
2.14.3
