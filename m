Received: from eggs.gnu.org ([2001:4830:134:3::10]:59700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fGSNW-0003Wy-Ha
	for qemu-devel@nongnu.org; Wed, 09 May 2018 12:55:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fGSNT-0006cQ-PB
	for qemu-devel@nongnu.org; Wed, 09 May 2018 12:55:46 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Wed,  9 May 2018 18:55:20 +0200
Message-Id: <20180509165530.29561-4-mreitz@redhat.com>
In-Reply-To: <20180509165530.29561-1-mreitz@redhat.com>
References: <20180509165530.29561-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 03/13] tests: Add QAPI optional discriminator
 tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

There already is an optional discriminator test, although it also noted
the discriminator name itself as optional.  Changing that, and adding a
default-variant field, makes that test pass instead of failing.

Besides this one, a number of tests adding various error cases are
added.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/Makefile.include                                    |  3 +++
 ...flat-union-optional-discriminator-invalid-default.json | 12 ++++++++++++
 .../flat-union-optional-discriminator-no-default.json     | 11 +++++++++++
 tests/qapi-schema/flat-union-optional-discriminator.json  |  4 ++--
 .../flat-union-superfluous-default-variant.json           | 11 +++++++++++
 .../flat-union-optional-discriminator-invalid-default.err |  1 +
 ...flat-union-optional-discriminator-invalid-default.exit |  1 +
 .../flat-union-optional-discriminator-invalid-default.out |  0
 .../flat-union-optional-discriminator-no-default.err      |  1 +
 .../flat-union-optional-discriminator-no-default.exit     |  1 +
 .../flat-union-optional-discriminator-no-default.out      |  0
 tests/qapi-schema/flat-union-optional-discriminator.err   |  1 -
 tests/qapi-schema/flat-union-optional-discriminator.exit  |  2 +-
 tests/qapi-schema/flat-union-optional-discriminator.out   | 15 +++++++++++++++
 .../flat-union-superfluous-default-variant.err            |  1 +
 .../flat-union-superfluous-default-variant.exit           |  1 +
 .../flat-union-superfluous-default-variant.out            |  0
 17 files changed, 61 insertions(+), 4 deletions(-)
 create mode 100644 tests/qapi-schema/flat-union-optional-discriminator-invalid-default.json
 create mode 100644 tests/qapi-schema/flat-union-optional-discriminator-no-default.json
 create mode 100644 tests/qapi-schema/flat-union-superfluous-default-variant.json
 create mode 100644 tests/qapi-schema/flat-union-optional-discriminator-invalid-default.err
 create mode 100644 tests/qapi-schema/flat-union-optional-discriminator-invalid-default.exit
 create mode 100644 tests/qapi-schema/flat-union-optional-discriminator-invalid-default.out
 create mode 100644 tests/qapi-schema/flat-union-optional-discriminator-no-default.err
 create mode 100644 tests/qapi-schema/flat-union-optional-discriminator-no-default.exit
 create mode 100644 tests/qapi-schema/flat-union-optional-discriminator-no-default.out
 create mode 100644 tests/qapi-schema/flat-union-superfluous-default-variant.err
 create mode 100644 tests/qapi-schema/flat-union-superfluous-default-variant.exit
 create mode 100644 tests/qapi-schema/flat-union-superfluous-default-variant.out

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 3b9a5e31a2..d01df12b09 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -500,7 +500,10 @@ qapi-schema += flat-union-invalid-branch-key.json
 qapi-schema += flat-union-invalid-discriminator.json
 qapi-schema += flat-union-no-base.json
 qapi-schema += flat-union-optional-discriminator.json
+qapi-schema += flat-union-optional-discriminator-no-default.json
+qapi-schema += flat-union-optional-discriminator-invalid-default.json
 qapi-schema += flat-union-string-discriminator.json
+qapi-schema += flat-union-superfluous-default-variant.json
 qapi-schema += funny-char.json
 qapi-schema += ident-with-escape.json
 qapi-schema += include-before-err.json
diff --git a/tests/qapi-schema/flat-union-optional-discriminator-invalid-default.json b/tests/qapi-schema/flat-union-optional-discriminator-invalid-default.json
new file mode 100644
index 0000000000..015a47ba52
--- /dev/null
+++ b/tests/qapi-schema/flat-union-optional-discriminator-invalid-default.json
@@ -0,0 +1,12 @@
+# default-variant must refer to an actual value of the discriminator's
+# enum
+{ 'enum': 'Enum', 'data': [ 'one', 'two' ] }
+{ 'struct': 'Base',
+  'data': { '*switch': 'Enum' } }
+{ 'struct': 'Branch', 'data': { 'name': 'str' } }
+{ 'union': 'MyUnion',
+  'base': 'Base',
+  'discriminator': 'switch',
+  'default-variant': 'three',
+  'data': { 'one': 'Branch',
+            'two': 'Branch' } }
diff --git a/tests/qapi-schema/flat-union-optional-discriminator-no-default.json b/tests/qapi-schema/flat-union-optional-discriminator-no-default.json
new file mode 100644
index 0000000000..0d612f5a62
--- /dev/null
+++ b/tests/qapi-schema/flat-union-optional-discriminator-no-default.json
@@ -0,0 +1,11 @@
+# Using an optional discriminator requires specifying a default
+# variant
+{ 'enum': 'Enum', 'data': [ 'one', 'two' ] }
+{ 'struct': 'Base',
+  'data': { '*switch': 'Enum' } }
+{ 'struct': 'Branch', 'data': { 'name': 'str' } }
+{ 'union': 'MyUnion',
+  'base': 'Base',
+  'discriminator': 'switch',
+  'data': { 'one': 'Branch',
+            'two': 'Branch' } }
diff --git a/tests/qapi-schema/flat-union-optional-discriminator.json b/tests/qapi-schema/flat-union-optional-discriminator.json
index 08a8f7ef8b..68e87083a1 100644
--- a/tests/qapi-schema/flat-union-optional-discriminator.json
+++ b/tests/qapi-schema/flat-union-optional-discriminator.json
@@ -1,10 +1,10 @@
-# we require the discriminator to be non-optional
 { 'enum': 'Enum', 'data': [ 'one', 'two' ] }
 { 'struct': 'Base',
   'data': { '*switch': 'Enum' } }
 { 'struct': 'Branch', 'data': { 'name': 'str' } }
 { 'union': 'MyUnion',
   'base': 'Base',
-  'discriminator': '*switch',
+  'discriminator': 'switch',
+  'default-variant': 'one',
   'data': { 'one': 'Branch',
             'two': 'Branch' } }
diff --git a/tests/qapi-schema/flat-union-superfluous-default-variant.json b/tests/qapi-schema/flat-union-superfluous-default-variant.json
new file mode 100644
index 0000000000..8558165868
--- /dev/null
+++ b/tests/qapi-schema/flat-union-superfluous-default-variant.json
@@ -0,0 +1,11 @@
+# default-variant only makes sense with an optional discriminator
+{ 'enum': 'Enum', 'data': [ 'one', 'two' ] }
+{ 'struct': 'Base',
+  'data': { 'switch': 'Enum' } }
+{ 'struct': 'Branch', 'data': { 'name': 'str' } }
+{ 'union': 'MyUnion',
+  'base': 'Base',
+  'discriminator': 'switch',
+  'default-variant': 'one',
+  'data': { 'one': 'Branch',
+            'two': 'Branch' } }
diff --git a/tests/qapi-schema/flat-union-optional-discriminator-invalid-default.err b/tests/qapi-schema/flat-union-optional-discriminator-invalid-default.err
new file mode 100644
index 0000000000..b6bd3423d6
--- /dev/null
+++ b/tests/qapi-schema/flat-union-optional-discriminator-invalid-default.err
@@ -0,0 +1 @@
+tests/qapi-schema/flat-union-optional-discriminator-invalid-default.json:7: Default variant 'three' of flat union 'MyUnion' is not part of 'Enum'
diff --git a/tests/qapi-schema/flat-union-optional-discriminator-invalid-default.exit b/tests/qapi-schema/flat-union-optional-discriminator-invalid-default.exit
new file mode 100644
index 0000000000..d00491fd7e
--- /dev/null
+++ b/tests/qapi-schema/flat-union-optional-discriminator-invalid-default.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/flat-union-optional-discriminator-invalid-default.out b/tests/qapi-schema/flat-union-optional-discriminator-invalid-default.out
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/flat-union-optional-discriminator-no-default.err b/tests/qapi-schema/flat-union-optional-discriminator-no-default.err
new file mode 100644
index 0000000000..1342efd9e8
--- /dev/null
+++ b/tests/qapi-schema/flat-union-optional-discriminator-no-default.err
@@ -0,0 +1 @@
+tests/qapi-schema/flat-union-optional-discriminator-no-default.json:7: Default variant must be specified for optional discriminator 'switch'
diff --git a/tests/qapi-schema/flat-union-optional-discriminator-no-default.exit b/tests/qapi-schema/flat-union-optional-discriminator-no-default.exit
new file mode 100644
index 0000000000..d00491fd7e
--- /dev/null
+++ b/tests/qapi-schema/flat-union-optional-discriminator-no-default.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/flat-union-optional-discriminator-no-default.out b/tests/qapi-schema/flat-union-optional-discriminator-no-default.out
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/flat-union-optional-discriminator.err b/tests/qapi-schema/flat-union-optional-discriminator.err
index aaabedb3bd..e69de29bb2 100644
--- a/tests/qapi-schema/flat-union-optional-discriminator.err
+++ b/tests/qapi-schema/flat-union-optional-discriminator.err
@@ -1 +0,0 @@
-tests/qapi-schema/flat-union-optional-discriminator.json:6: Discriminator of flat union 'MyUnion' does not allow optional name '*switch'
diff --git a/tests/qapi-schema/flat-union-optional-discriminator.exit b/tests/qapi-schema/flat-union-optional-discriminator.exit
index d00491fd7e..573541ac97 100644
--- a/tests/qapi-schema/flat-union-optional-discriminator.exit
+++ b/tests/qapi-schema/flat-union-optional-discriminator.exit
@@ -1 +1 @@
-1
+0
diff --git a/tests/qapi-schema/flat-union-optional-discriminator.out b/tests/qapi-schema/flat-union-optional-discriminator.out
index e69de29bb2..d3a72f63c2 100644
--- a/tests/qapi-schema/flat-union-optional-discriminator.out
+++ b/tests/qapi-schema/flat-union-optional-discriminator.out
@@ -0,0 +1,15 @@
+object q_empty
+enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool']
+    prefix QTYPE
+module flat-union-optional-discriminator.json
+enum Enum ['one', 'two']
+object Base
+    member switch: Enum optional=True
+object Branch
+    member name: str optional=False
+object MyUnion
+    base Base
+    tag switch
+    default variant: one
+    case one: Branch
+    case two: Branch
diff --git a/tests/qapi-schema/flat-union-superfluous-default-variant.err b/tests/qapi-schema/flat-union-superfluous-default-variant.err
new file mode 100644
index 0000000000..5230bbf645
--- /dev/null
+++ b/tests/qapi-schema/flat-union-superfluous-default-variant.err
@@ -0,0 +1 @@
+tests/qapi-schema/flat-union-superfluous-default-variant.json:6: Must not specify a default variant for non-optional discriminator 'switch'
diff --git a/tests/qapi-schema/flat-union-superfluous-default-variant.exit b/tests/qapi-schema/flat-union-superfluous-default-variant.exit
new file mode 100644
index 0000000000..d00491fd7e
--- /dev/null
+++ b/tests/qapi-schema/flat-union-superfluous-default-variant.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/flat-union-superfluous-default-variant.out b/tests/qapi-schema/flat-union-superfluous-default-variant.out
new file mode 100644
index 0000000000..e69de29bb2
-- 
2.14.3
