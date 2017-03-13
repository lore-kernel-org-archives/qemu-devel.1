Received: from eggs.gnu.org ([2001:4830:134:3::10]:52402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cnJJq-0007aq-KR
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:19:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cnJJm-0003dK-5u
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:18:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40748)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cnJJl-0003aN-PA
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:18:53 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 13 Mar 2017 07:18:30 +0100
Message-Id: <1489385927-6735-31-git-send-email-armbru@redhat.com>
In-Reply-To: <1489385927-6735-1-git-send-email-armbru@redhat.com>
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9 30/47] tests/qapi-schema: Improve doc /
 expression mismatch coverage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, eblake@redhat.com, mdroth@linux.vnet.ibm.com

New test doc-bad-expr.json shows we fail to reject a misplaced
expression comment.

New test doc-no-symbol.json shows a bad error message.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/Makefile.include               | 2 ++
 tests/qapi-schema/doc-bad-expr.err   | 0
 tests/qapi-schema/doc-bad-expr.exit  | 1 +
 tests/qapi-schema/doc-bad-expr.json  | 8 ++++++++
 tests/qapi-schema/doc-bad-expr.out   | 4 ++++
 tests/qapi-schema/doc-no-symbol.err  | 1 +
 tests/qapi-schema/doc-no-symbol.exit | 1 +
 tests/qapi-schema/doc-no-symbol.json | 7 +++++++
 tests/qapi-schema/doc-no-symbol.out  | 0
 9 files changed, 24 insertions(+)
 create mode 100644 tests/qapi-schema/doc-bad-expr.err
 create mode 100644 tests/qapi-schema/doc-bad-expr.exit
 create mode 100644 tests/qapi-schema/doc-bad-expr.json
 create mode 100644 tests/qapi-schema/doc-bad-expr.out
 create mode 100644 tests/qapi-schema/doc-no-symbol.err
 create mode 100644 tests/qapi-schema/doc-no-symbol.exit
 create mode 100644 tests/qapi-schema/doc-no-symbol.json
 create mode 100644 tests/qapi-schema/doc-no-symbol.out

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 7230977..800acbf 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -368,6 +368,7 @@ qapi-schema += base-cycle-indirect.json
 qapi-schema += command-int.json
 qapi-schema += comments.json
 qapi-schema += doc-bad-args.json
+qapi-schema += doc-bad-expr.json
 qapi-schema += doc-bad-symbol.json
 qapi-schema += doc-duplicated-arg.json
 qapi-schema += doc-duplicated-return.json
@@ -385,6 +386,7 @@ qapi-schema += doc-missing.json
 qapi-schema += doc-missing-colon.json
 qapi-schema += doc-missing-expr.json
 qapi-schema += doc-missing-space.json
+qapi-schema += doc-no-symbol.json
 qapi-schema += double-data.json
 qapi-schema += double-type.json
 qapi-schema += duplicate-key.json
diff --git a/tests/qapi-schema/doc-bad-expr.err b/tests/qapi-schema/doc-bad-expr.err
new file mode 100644
index 0000000..e69de29
diff --git a/tests/qapi-schema/doc-bad-expr.exit b/tests/qapi-schema/doc-bad-expr.exit
new file mode 100644
index 0000000..573541a
--- /dev/null
+++ b/tests/qapi-schema/doc-bad-expr.exit
@@ -0,0 +1 @@
+0
diff --git a/tests/qapi-schema/doc-bad-expr.json b/tests/qapi-schema/doc-bad-expr.json
new file mode 100644
index 0000000..ec1fbf2
--- /dev/null
+++ b/tests/qapi-schema/doc-bad-expr.json
@@ -0,0 +1,8 @@
+# Doc comment separated from defining expression by non-defining expression
+# BUG: not rejected
+
+##
+# @foo:
+##
+{ 'include': 'empty.json' }
+{ 'struct': 'foo', 'data': {} }
diff --git a/tests/qapi-schema/doc-bad-expr.out b/tests/qapi-schema/doc-bad-expr.out
new file mode 100644
index 0000000..236a849
--- /dev/null
+++ b/tests/qapi-schema/doc-bad-expr.out
@@ -0,0 +1,4 @@
+enum QType ['none', 'qnull', 'qint', 'qstring', 'qdict', 'qlist', 'qfloat', 'qbool']
+    prefix QTYPE
+object foo
+object q_empty
diff --git a/tests/qapi-schema/doc-no-symbol.err b/tests/qapi-schema/doc-no-symbol.err
new file mode 100644
index 0000000..727966c
--- /dev/null
+++ b/tests/qapi-schema/doc-no-symbol.err
@@ -0,0 +1 @@
+tests/qapi-schema/doc-no-symbol.json:4: Definition of 'foo' follows documentation for 'None'
diff --git a/tests/qapi-schema/doc-no-symbol.exit b/tests/qapi-schema/doc-no-symbol.exit
new file mode 100644
index 0000000..d00491f
--- /dev/null
+++ b/tests/qapi-schema/doc-no-symbol.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/doc-no-symbol.json b/tests/qapi-schema/doc-no-symbol.json
new file mode 100644
index 0000000..ee86ca1
--- /dev/null
+++ b/tests/qapi-schema/doc-no-symbol.json
@@ -0,0 +1,7 @@
+# Documentation for expression lacks symbol
+# BUG: Error message claims it has symbol 'None'
+
+##
+# foo:
+##
+{ 'command': 'foo', 'data': {'a': 'int'} }
diff --git a/tests/qapi-schema/doc-no-symbol.out b/tests/qapi-schema/doc-no-symbol.out
new file mode 100644
index 0000000..e69de29
-- 
2.7.4
