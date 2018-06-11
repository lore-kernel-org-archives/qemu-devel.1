Received: from eggs.gnu.org ([2001:4830:134:3::10]:43745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fSTnd-0001pw-4x
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 16:52:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fSTnY-00087R-1C
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 16:52:25 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 11 Jun 2018 22:51:56 +0200
Message-Id: <20180611205203.2624-4-mreitz@redhat.com>
In-Reply-To: <20180611205203.2624-1-mreitz@redhat.com>
References: <20180611205203.2624-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 03/10] tests: Add QAPI optional
 discriminator tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Kevin Wolf <kwolf@redhat.com>

There already is an optional discriminator test, although it also noted
the discriminator name itself as optional.  This already gives us one
error test case, to which this patch adds various others.

Furthermore, a passing test case is added to qapi-schema-test.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/Makefile.include                               |  5 ++++-
 ...union-optional-discriminator-invalid-default.json | 12 ++++++++++++
 ...optional-discriminator-invalid-specification.json | 12 ++++++++++++
 ...lat-union-optional-discriminator-no-default.json} |  5 +++--
 .../flat-union-superfluous-default-variant.json      | 11 +++++++++++
 tests/qapi-schema/qapi-schema-test.json              |  9 +++++++++
 ...-union-optional-discriminator-invalid-default.err |  1 +
 ...nion-optional-discriminator-invalid-default.exit} |  0
 ...union-optional-discriminator-invalid-default.out} |  0
 ...-optional-discriminator-invalid-specification.err |  1 +
 ...optional-discriminator-invalid-specification.exit |  1 +
 ...-optional-discriminator-invalid-specification.out |  0
 .../flat-union-optional-discriminator-no-default.err |  1 +
 ...flat-union-optional-discriminator-no-default.exit |  1 +
 .../flat-union-optional-discriminator-no-default.out |  0
 .../flat-union-optional-discriminator.err            |  1 -
 .../flat-union-superfluous-default-variant.err       |  1 +
 .../flat-union-superfluous-default-variant.exit      |  1 +
 .../flat-union-superfluous-default-variant.out       |  0
 tests/qapi-schema/qapi-schema-test.out               |  9 +++++++++
 20 files changed, 67 insertions(+), 4 deletions(-)
 create mode 100644 tests/qapi-schema/flat-union-optional-discriminator-invalid-default.json
 create mode 100644 tests/qapi-schema/flat-union-optional-discriminator-invalid-specification.json
 rename tests/qapi-schema/{flat-union-optional-discriminator.json => flat-union-optional-discriminator-no-default.json} (70%)
 create mode 100644 tests/qapi-schema/flat-union-superfluous-default-variant.json
 create mode 100644 tests/qapi-schema/flat-union-optional-discriminator-invalid-default.err
 rename tests/qapi-schema/{flat-union-optional-discriminator.exit => flat-union-optional-discriminator-invalid-default.exit} (100%)
 rename tests/qapi-schema/{flat-union-optional-discriminator.out => flat-union-optional-discriminator-invalid-default.out} (100%)
 create mode 100644 tests/qapi-schema/flat-union-optional-discriminator-invalid-specification.err
 create mode 100644 tests/qapi-schema/flat-union-optional-discriminator-invalid-specification.exit
 create mode 100644 tests/qapi-schema/flat-union-optional-discriminator-invalid-specification.out
 create mode 100644 tests/qapi-schema/flat-union-optional-discriminator-no-default.err
 create mode 100644 tests/qapi-schema/flat-union-optional-discriminator-no-default.exit
 create mode 100644 tests/qapi-schema/flat-union-optional-discriminator-no-default.out
 delete mode 100644 tests/qapi-schema/flat-union-optional-discriminator.err
 create mode 100644 tests/qapi-schema/flat-union-superfluous-default-variant.err
 create mode 100644 tests/qapi-schema/flat-union-superfluous-default-variant.exit
 create mode 100644 tests/qapi-schema/flat-union-superfluous-default-variant.out

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 2023e257fd..66d10e1072 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -505,8 +505,11 @@ qapi-schema += flat-union-int-branch.json
 qapi-schema += flat-union-invalid-branch-key.json
 qapi-schema += flat-union-invalid-discriminator.json
 qapi-schema += flat-union-no-base.json
-qapi-schema += flat-union-optional-discriminator.json
+qapi-schema += flat-union-optional-discriminator-invalid-specification.json
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
diff --git a/tests/qapi-schema/flat-union-optional-discriminator-invalid-specification.json b/tests/qapi-schema/flat-union-optional-discriminator-invalid-specification.json
new file mode 100644
index 0000000000..fd896942a2
--- /dev/null
+++ b/tests/qapi-schema/flat-union-optional-discriminator-invalid-specification.json
@@ -0,0 +1,12 @@
+# For using optional discriminators, only the field in the base struct
+# must be marked optional, not the discriminator name itself
+{ 'enum': 'Enum', 'data': [ 'one', 'two' ] }
+{ 'struct': 'Base',
+  'data': { '*switch': 'Enum' } }
+{ 'struct': 'Branch', 'data': { 'name': 'str' } }
+{ 'union': 'MyUnion',
+  'base': 'Base',
+  'discriminator': '*switch',
+  'default-variant': 'one',
+  'data': { 'one': 'Branch',
+            'two': 'Branch' } }
diff --git a/tests/qapi-schema/flat-union-optional-discriminator.json b/tests/qapi-schema/flat-union-optional-discriminator-no-default.json
similarity index 70%
rename from tests/qapi-schema/flat-union-optional-discriminator.json
rename to tests/qapi-schema/flat-union-optional-discriminator-no-default.json
index 08a8f7ef8b..0d612f5a62 100644
--- a/tests/qapi-schema/flat-union-optional-discriminator.json
+++ b/tests/qapi-schema/flat-union-optional-discriminator-no-default.json
@@ -1,10 +1,11 @@
-# we require the discriminator to be non-optional
+# Using an optional discriminator requires specifying a default
+# variant
 { 'enum': 'Enum', 'data': [ 'one', 'two' ] }
 { 'struct': 'Base',
   'data': { '*switch': 'Enum' } }
 { 'struct': 'Branch', 'data': { 'name': 'str' } }
 { 'union': 'MyUnion',
   'base': 'Base',
-  'discriminator': '*switch',
+  'discriminator': 'switch',
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
diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/qapi-schema-test.json
index 46c7282945..64d5f6694e 100644
--- a/tests/qapi-schema/qapi-schema-test.json
+++ b/tests/qapi-schema/qapi-schema-test.json
@@ -99,6 +99,15 @@
 { 'struct': 'UserDefC',
   'data': { 'string1': 'str', 'string2': 'str' } }
 
+# for testing unions with an optional discriminator
+{ 'union': 'UserDefFlatUnion3',
+  'base': { '*enum1': 'EnumOne' },
+  'discriminator': 'enum1',
+  'default-variant': 'value1',
+  'data': { 'value1' : 'UserDefA',
+            'value2' : 'UserDefB',
+            'value3' : 'UserDefB' } }
+
 # for testing use of 'number' within alternates
 { 'alternate': 'AltEnumBool', 'data': { 'e': 'EnumOne', 'b': 'bool' } }
 { 'alternate': 'AltEnumNum', 'data': { 'e': 'EnumOne', 'n': 'number' } }
diff --git a/tests/qapi-schema/flat-union-optional-discriminator-invalid-default.err b/tests/qapi-schema/flat-union-optional-discriminator-invalid-default.err
new file mode 100644
index 0000000000..b6bd3423d6
--- /dev/null
+++ b/tests/qapi-schema/flat-union-optional-discriminator-invalid-default.err
@@ -0,0 +1 @@
+tests/qapi-schema/flat-union-optional-discriminator-invalid-default.json:7: Default variant 'three' of flat union 'MyUnion' is not part of 'Enum'
diff --git a/tests/qapi-schema/flat-union-optional-discriminator.exit b/tests/qapi-schema/flat-union-optional-discriminator-invalid-default.exit
similarity index 100%
rename from tests/qapi-schema/flat-union-optional-discriminator.exit
rename to tests/qapi-schema/flat-union-optional-discriminator-invalid-default.exit
diff --git a/tests/qapi-schema/flat-union-optional-discriminator.out b/tests/qapi-schema/flat-union-optional-discriminator-invalid-default.out
similarity index 100%
rename from tests/qapi-schema/flat-union-optional-discriminator.out
rename to tests/qapi-schema/flat-union-optional-discriminator-invalid-default.out
diff --git a/tests/qapi-schema/flat-union-optional-discriminator-invalid-specification.err b/tests/qapi-schema/flat-union-optional-discriminator-invalid-specification.err
new file mode 100644
index 0000000000..cbf154e726
--- /dev/null
+++ b/tests/qapi-schema/flat-union-optional-discriminator-invalid-specification.err
@@ -0,0 +1 @@
+tests/qapi-schema/flat-union-optional-discriminator-invalid-specification.json:7: Discriminator of flat union 'MyUnion' does not allow optional name '*switch'
diff --git a/tests/qapi-schema/flat-union-optional-discriminator-invalid-specification.exit b/tests/qapi-schema/flat-union-optional-discriminator-invalid-specification.exit
new file mode 100644
index 0000000000..d00491fd7e
--- /dev/null
+++ b/tests/qapi-schema/flat-union-optional-discriminator-invalid-specification.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/flat-union-optional-discriminator-invalid-specification.out b/tests/qapi-schema/flat-union-optional-discriminator-invalid-specification.out
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
deleted file mode 100644
index aaabedb3bd..0000000000
--- a/tests/qapi-schema/flat-union-optional-discriminator.err
+++ /dev/null
@@ -1 +0,0 @@
-tests/qapi-schema/flat-union-optional-discriminator.json:6: Discriminator of flat union 'MyUnion' does not allow optional name '*switch'
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
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/qapi-schema-test.out
index 542a19c407..4e3c2934bb 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -76,6 +76,15 @@ alternate UserDefAlternate
 object UserDefC
     member string1: str optional=False
     member string2: str optional=False
+object q_obj_UserDefFlatUnion3-base
+    member enum1: EnumOne optional=True
+object UserDefFlatUnion3
+    base q_obj_UserDefFlatUnion3-base
+    tag enum1
+    default variant: value1
+    case value1: UserDefA
+    case value2: UserDefB
+    case value3: UserDefB
 alternate AltEnumBool
     tag type
     case e: EnumOne
-- 
2.17.1
