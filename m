Received: from eggs.gnu.org ([2001:4830:134:3::10]:33626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1co8Ux-0001at-8G
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:57:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1co8Ur-0000NB-KJ
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:57:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50492)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1co8Ur-0000KR-4x
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:57:45 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 15 Mar 2017 13:57:25 +0100
Message-Id: <1489582656-31133-37-git-send-email-armbru@redhat.com>
In-Reply-To: <1489582656-31133-1-git-send-email-armbru@redhat.com>
References: <1489582656-31133-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 for-2.9 36/47] tests/qapi-schema: Improve
 coverage of bogus member docs
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

New test doc-bad-union-member.json shows we can fail to reject
documentation for nonexistent members.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 tests/Makefile.include                          |  2 ++
 tests/qapi-schema/doc-bad-alternate-member.err  |  1 +
 tests/qapi-schema/doc-bad-alternate-member.exit |  1 +
 tests/qapi-schema/doc-bad-alternate-member.json |  9 +++++++++
 tests/qapi-schema/doc-bad-alternate-member.out  |  0
 tests/qapi-schema/doc-bad-union-member.err      |  0
 tests/qapi-schema/doc-bad-union-member.exit     |  1 +
 tests/qapi-schema/doc-bad-union-member.json     | 19 +++++++++++++++++++
 tests/qapi-schema/doc-bad-union-member.out      | 11 +++++++++++
 9 files changed, 44 insertions(+)
 create mode 100644 tests/qapi-schema/doc-bad-alternate-member.err
 create mode 100644 tests/qapi-schema/doc-bad-alternate-member.exit
 create mode 100644 tests/qapi-schema/doc-bad-alternate-member.json
 create mode 100644 tests/qapi-schema/doc-bad-alternate-member.out
 create mode 100644 tests/qapi-schema/doc-bad-union-member.err
 create mode 100644 tests/qapi-schema/doc-bad-union-member.exit
 create mode 100644 tests/qapi-schema/doc-bad-union-member.json
 create mode 100644 tests/qapi-schema/doc-bad-union-member.out

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 734c7ff..e6e00b4 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -367,8 +367,10 @@ qapi-schema += base-cycle-direct.json
 qapi-schema += base-cycle-indirect.json
 qapi-schema += command-int.json
 qapi-schema += comments.json
+qapi-schema += doc-bad-alternate-member.json
 qapi-schema += doc-bad-command-arg.json
 qapi-schema += doc-bad-symbol.json
+qapi-schema += doc-bad-union-member.json
 qapi-schema += doc-before-include.json
 qapi-schema += doc-before-pragma.json
 qapi-schema += doc-duplicated-arg.json
diff --git a/tests/qapi-schema/doc-bad-alternate-member.err b/tests/qapi-schema/doc-bad-alternate-member.err
new file mode 100644
index 0000000..387f782
--- /dev/null
+++ b/tests/qapi-schema/doc-bad-alternate-member.err
@@ -0,0 +1 @@
+tests/qapi-schema/doc-bad-alternate-member.json:3: The following documented members are not in the declaration: aa, bb
diff --git a/tests/qapi-schema/doc-bad-alternate-member.exit b/tests/qapi-schema/doc-bad-alternate-member.exit
new file mode 100644
index 0000000..d00491f
--- /dev/null
+++ b/tests/qapi-schema/doc-bad-alternate-member.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/doc-bad-alternate-member.json b/tests/qapi-schema/doc-bad-alternate-member.json
new file mode 100644
index 0000000..738635c
--- /dev/null
+++ b/tests/qapi-schema/doc-bad-alternate-member.json
@@ -0,0 +1,9 @@
+# Arguments listed in the doc comment must exist in the actual schema
+
+##
+# @AorB:
+# @aa: a
+# @bb: b
+##
+{ 'alternate': 'AorB',
+  'data': { 'a': 'str', 'b': 'int' } }
diff --git a/tests/qapi-schema/doc-bad-alternate-member.out b/tests/qapi-schema/doc-bad-alternate-member.out
new file mode 100644
index 0000000..e69de29
diff --git a/tests/qapi-schema/doc-bad-union-member.err b/tests/qapi-schema/doc-bad-union-member.err
new file mode 100644
index 0000000..e69de29
diff --git a/tests/qapi-schema/doc-bad-union-member.exit b/tests/qapi-schema/doc-bad-union-member.exit
new file mode 100644
index 0000000..573541a
--- /dev/null
+++ b/tests/qapi-schema/doc-bad-union-member.exit
@@ -0,0 +1 @@
+0
diff --git a/tests/qapi-schema/doc-bad-union-member.json b/tests/qapi-schema/doc-bad-union-member.json
new file mode 100644
index 0000000..d611435
--- /dev/null
+++ b/tests/qapi-schema/doc-bad-union-member.json
@@ -0,0 +1,19 @@
+# Arguments listed in the doc comment must exist in the actual schema
+
+##
+# @Frob:
+# @a: a
+# @b: b
+##
+{ 'union': 'Frob',
+  'base': 'Base',
+  'discriminator': 'type',
+  'data': { 'nothing': 'Empty' } }
+
+{ 'struct': 'Base',
+  'data': { 'type': 'T' } }
+
+{ 'struct': 'Empty',
+  'data': { } }
+
+{ 'enum': 'T', 'data': ['nothing'] }
diff --git a/tests/qapi-schema/doc-bad-union-member.out b/tests/qapi-schema/doc-bad-union-member.out
new file mode 100644
index 0000000..2576ecd
--- /dev/null
+++ b/tests/qapi-schema/doc-bad-union-member.out
@@ -0,0 +1,11 @@
+object Base
+    member type: T optional=False
+object Empty
+object Frob
+    base Base
+    tag type
+    case nothing: Empty
+enum QType ['none', 'qnull', 'qint', 'qstring', 'qdict', 'qlist', 'qfloat', 'qbool']
+    prefix QTYPE
+enum T ['nothing']
+object q_empty
-- 
2.7.4
