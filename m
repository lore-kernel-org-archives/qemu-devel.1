Received: from eggs.gnu.org ([2001:4830:134:3::10]:44053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz1Th-0006xl-Rk
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:13:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz1Tg-0003cK-GZ
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:13:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54078)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dz1Tg-0003bo-95
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:13:48 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7752D7E449
	for <qemu-devel@nongnu.org>; Mon,  2 Oct 2017 14:13:47 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  2 Oct 2017 16:13:35 +0200
Message-Id: <20171002141341.24616-6-armbru@redhat.com>
In-Reply-To: <20171002141341.24616-1-armbru@redhat.com>
References: <20171002141341.24616-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 05/11] tests/qapi-schema/doc-bad-section: New,
 factored out of doc-good
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com
List-ID: <qemu-devel.nongnu.org>

A negative test case crept into doc-good.json: invalid use of section
markup we currently fail to reject.  Move this into its own
doc-bad-section.json.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/Makefile.include                 |  3 ++-
 tests/qapi-schema/doc-bad-section.err  |  0
 tests/qapi-schema/doc-bad-section.exit |  1 +
 tests/qapi-schema/doc-bad-section.json | 11 +++++++++++
 tests/qapi-schema/doc-bad-section.out  | 13 +++++++++++++
 tests/qapi-schema/doc-good.json        |  1 -
 tests/qapi-schema/doc-good.out         |  2 +-
 tests/qapi-schema/doc-good.texi        |  2 +-
 8 files changed, 29 insertions(+), 4 deletions(-)
 create mode 100644 tests/qapi-schema/doc-bad-section.err
 create mode 100644 tests/qapi-schema/doc-bad-section.exit
 create mode 100644 tests/qapi-schema/doc-bad-section.json
 create mode 100644 tests/qapi-schema/doc-bad-section.out

diff --git a/tests/Makefile.include b/tests/Makefile.include
index abc6707ef2..de4a713c25 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -412,6 +412,7 @@ qapi-schema += command-int.json
 qapi-schema += comments.json
 qapi-schema += doc-bad-alternate-member.json
 qapi-schema += doc-bad-command-arg.json
+qapi-schema += doc-bad-section.json
 qapi-schema += doc-bad-symbol.json
 qapi-schema += doc-bad-union-member.json
 qapi-schema += doc-before-include.json
@@ -429,10 +430,10 @@ qapi-schema += doc-invalid-end2.json
 qapi-schema += doc-invalid-return.json
 qapi-schema += doc-invalid-section.json
 qapi-schema += doc-invalid-start.json
-qapi-schema += doc-missing.json
 qapi-schema += doc-missing-colon.json
 qapi-schema += doc-missing-expr.json
 qapi-schema += doc-missing-space.json
+qapi-schema += doc-missing.json
 qapi-schema += doc-no-symbol.json
 qapi-schema += double-data.json
 qapi-schema += double-type.json
diff --git a/tests/qapi-schema/doc-bad-section.err b/tests/qapi-schema/doc-bad-section.err
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/doc-bad-section.exit b/tests/qapi-schema/doc-bad-section.exit
new file mode 100644
index 0000000000..573541ac97
--- /dev/null
+++ b/tests/qapi-schema/doc-bad-section.exit
@@ -0,0 +1 @@
+0
diff --git a/tests/qapi-schema/doc-bad-section.json b/tests/qapi-schema/doc-bad-section.json
new file mode 100644
index 0000000000..560df4b087
--- /dev/null
+++ b/tests/qapi-schema/doc-bad-section.json
@@ -0,0 +1,11 @@
+# = section within an expression comment
+# BUG: not rejected
+
+##
+# @Enum:
+# == Produces *invalid* texinfo
+# @one: The _one_ {and only}
+#
+# @two is undocumented
+##
+{ 'enum': 'Enum', 'data': [ 'one', 'two' ] }
diff --git a/tests/qapi-schema/doc-bad-section.out b/tests/qapi-schema/doc-bad-section.out
new file mode 100644
index 0000000000..6fce84dd34
--- /dev/null
+++ b/tests/qapi-schema/doc-bad-section.out
@@ -0,0 +1,13 @@
+enum Enum ['one', 'two']
+enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool']
+    prefix QTYPE
+object q_empty
+doc symbol=Enum
+    body=
+== Produces *invalid* texinfo
+    arg=one
+The _one_ {and only}
+    arg=two
+
+    section=
+@two is undocumented
diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-good.json
index cfdc0a8a81..97ab4625ff 100644
--- a/tests/qapi-schema/doc-good.json
+++ b/tests/qapi-schema/doc-good.json
@@ -51,7 +51,6 @@
 
 ##
 # @Enum:
-# == Produces *invalid* texinfo
 # @one: The _one_ {and only}
 #
 # @two is undocumented
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.out
index 63ca25a8b9..c55e394e8a 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -77,7 +77,7 @@ Examples:
 - {braces}
 doc symbol=Enum
     body=
-== Produces *invalid* texinfo
+
     arg=one
 The _one_ {and only}
     arg=two
diff --git a/tests/qapi-schema/doc-good.texi b/tests/qapi-schema/doc-good.texi
index c410626e4a..a331349756 100644
--- a/tests/qapi-schema/doc-good.texi
+++ b/tests/qapi-schema/doc-good.texi
@@ -76,7 +76,7 @@ Examples:
 
 @deftp {Enum} Enum
 
-@subsection Produces @strong{invalid} texinfo
+
 
 @b{Values:}
 @table @asis
-- 
2.13.6
