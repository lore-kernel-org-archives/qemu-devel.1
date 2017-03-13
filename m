Received: from eggs.gnu.org ([2001:4830:134:3::10]:52156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cnJJl-0007Wn-AC
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:18:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cnJJj-0003Y6-MT
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:18:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33476)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cnJJj-0003XL-GF
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:18:51 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 13 Mar 2017 07:18:08 +0100
Message-Id: <1489385927-6735-9-git-send-email-armbru@redhat.com>
In-Reply-To: <1489385927-6735-1-git-send-email-armbru@redhat.com>
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9 08/47] tests/qapi-schema: Cover empty
 union base
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

The new test case shows off qapi.py choking on an empty union base.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/Makefile.include                  |  1 +
 tests/qapi-schema/union-base-empty.err  | 10 ++++++++++
 tests/qapi-schema/union-base-empty.exit |  1 +
 tests/qapi-schema/union-base-empty.json |  9 +++++++++
 tests/qapi-schema/union-base-empty.out  |  0
 5 files changed, 21 insertions(+)
 create mode 100644 tests/qapi-schema/union-base-empty.err
 create mode 100644 tests/qapi-schema/union-base-empty.exit
 create mode 100644 tests/qapi-schema/union-base-empty.json
 create mode 100644 tests/qapi-schema/union-base-empty.out

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 736dd15..9f4e890 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -470,6 +470,7 @@ qapi-schema += unclosed-list.json
 qapi-schema += unclosed-object.json
 qapi-schema += unclosed-string.json
 qapi-schema += unicode-str.json
+qapi-schema += union-base-empty.json
 qapi-schema += union-base-no-discriminator.json
 qapi-schema += union-branch-case.json
 qapi-schema += union-clash-branches.json
diff --git a/tests/qapi-schema/union-base-empty.err b/tests/qapi-schema/union-base-empty.err
new file mode 100644
index 0000000..61e6ec6
--- /dev/null
+++ b/tests/qapi-schema/union-base-empty.err
@@ -0,0 +1,10 @@
+Traceback (most recent call last):
+  File "tests/qapi-schema/test-qapi.py", line 56, in <module>
+    schema = QAPISchema(sys.argv[1])
+  File "scripts/qapi.py", line 1483, in __init__
+    self.exprs = check_exprs(parser.exprs)
+  File "scripts/qapi.py", line 917, in check_exprs
+    check_union(expr, info)
+  File "scripts/qapi.py", line 734, in check_union
+    assert base_members
+AssertionError
diff --git a/tests/qapi-schema/union-base-empty.exit b/tests/qapi-schema/union-base-empty.exit
new file mode 100644
index 0000000..d00491f
--- /dev/null
+++ b/tests/qapi-schema/union-base-empty.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/union-base-empty.json b/tests/qapi-schema/union-base-empty.json
new file mode 100644
index 0000000..d1843d3
--- /dev/null
+++ b/tests/qapi-schema/union-base-empty.json
@@ -0,0 +1,9 @@
+# Flat union with empty base and therefore without discriminator
+
+{ 'struct': 'Empty', 'data': { } }
+
+{ 'union': 'TestUnion',
+  'base': 'Empty',
+  'discriminator': 'type',
+  'data': { 'value1': 'int',
+            'value2': 'str' } }
diff --git a/tests/qapi-schema/union-base-empty.out b/tests/qapi-schema/union-base-empty.out
new file mode 100644
index 0000000..e69de29
-- 
2.7.4
