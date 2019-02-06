Received: from eggs.gnu.org ([209.51.188.92]:38274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1grTIl-000065-TK
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 14:56:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1grTIk-0007xp-6P
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 14:56:07 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Wed,  6 Feb 2019 20:55:46 +0100
Message-Id: <20190206195551.28893-4-mreitz@redhat.com>
In-Reply-To: <20190206195551.28893-1-mreitz@redhat.com>
References: <20190206195551.28893-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 3/8] tests: Add QAPI optional discriminator
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
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Kevin Wolf <kwolf@redhat.com>

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
 tests/qapi-schema/qapi-schema-test.json              | 11 +++++++++++
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
 tests/qapi-schema/qapi-schema-test.out               | 10 ++++++++++
 20 files changed, 70 insertions(+), 4 deletions(-)
 create mode 100644 tests/qapi-schema/flat-union-optional-discriminator-i=
nvalid-default.json
 create mode 100644 tests/qapi-schema/flat-union-optional-discriminator-i=
nvalid-specification.json
 rename tests/qapi-schema/{flat-union-optional-discriminator.json =3D> fl=
at-union-optional-discriminator-no-default.json} (70%)
 create mode 100644 tests/qapi-schema/flat-union-superfluous-default-vari=
ant.json
 create mode 100644 tests/qapi-schema/flat-union-optional-discriminator-i=
nvalid-default.err
 rename tests/qapi-schema/{flat-union-optional-discriminator.exit =3D> fl=
at-union-optional-discriminator-invalid-default.exit} (100%)
 rename tests/qapi-schema/{flat-union-optional-discriminator.out =3D> fla=
t-union-optional-discriminator-invalid-default.out} (100%)
 create mode 100644 tests/qapi-schema/flat-union-optional-discriminator-i=
nvalid-specification.err
 create mode 100644 tests/qapi-schema/flat-union-optional-discriminator-i=
nvalid-specification.exit
 create mode 100644 tests/qapi-schema/flat-union-optional-discriminator-i=
nvalid-specification.out
 create mode 100644 tests/qapi-schema/flat-union-optional-discriminator-n=
o-default.err
 create mode 100644 tests/qapi-schema/flat-union-optional-discriminator-n=
o-default.exit
 create mode 100644 tests/qapi-schema/flat-union-optional-discriminator-n=
o-default.out
 delete mode 100644 tests/qapi-schema/flat-union-optional-discriminator.e=
rr
 create mode 100644 tests/qapi-schema/flat-union-superfluous-default-vari=
ant.err
 create mode 100644 tests/qapi-schema/flat-union-superfluous-default-vari=
ant.exit
 create mode 100644 tests/qapi-schema/flat-union-superfluous-default-vari=
ant.out

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 75ad9c0dd3..8fd05da00a 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -422,8 +422,11 @@ qapi-schema +=3D flat-union-invalid-branch-key.json
 qapi-schema +=3D flat-union-invalid-discriminator.json
 qapi-schema +=3D flat-union-invalid-if-discriminator.json
 qapi-schema +=3D flat-union-no-base.json
-qapi-schema +=3D flat-union-optional-discriminator.json
+qapi-schema +=3D flat-union-optional-discriminator-invalid-specification=
.json
+qapi-schema +=3D flat-union-optional-discriminator-no-default.json
+qapi-schema +=3D flat-union-optional-discriminator-invalid-default.json
 qapi-schema +=3D flat-union-string-discriminator.json
+qapi-schema +=3D flat-union-superfluous-default-variant.json
 qapi-schema +=3D funny-char.json
 qapi-schema +=3D ident-with-escape.json
 qapi-schema +=3D include-before-err.json
diff --git a/tests/qapi-schema/flat-union-optional-discriminator-invalid-=
default.json b/tests/qapi-schema/flat-union-optional-discriminator-invali=
d-default.json
new file mode 100644
index 0000000000..015a47ba52
--- /dev/null
+++ b/tests/qapi-schema/flat-union-optional-discriminator-invalid-default=
.json
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
diff --git a/tests/qapi-schema/flat-union-optional-discriminator-invalid-=
specification.json b/tests/qapi-schema/flat-union-optional-discriminator-=
invalid-specification.json
new file mode 100644
index 0000000000..fd896942a2
--- /dev/null
+++ b/tests/qapi-schema/flat-union-optional-discriminator-invalid-specifi=
cation.json
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
diff --git a/tests/qapi-schema/flat-union-optional-discriminator.json b/t=
ests/qapi-schema/flat-union-optional-discriminator-no-default.json
similarity index 70%
rename from tests/qapi-schema/flat-union-optional-discriminator.json
rename to tests/qapi-schema/flat-union-optional-discriminator-no-default.=
json
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
diff --git a/tests/qapi-schema/flat-union-superfluous-default-variant.jso=
n b/tests/qapi-schema/flat-union-superfluous-default-variant.json
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
diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/=
qapi-schema-test.json
index cb0857df52..6c7462928e 100644
--- a/tests/qapi-schema/qapi-schema-test.json
+++ b/tests/qapi-schema/qapi-schema-test.json
@@ -104,6 +104,17 @@
 { 'struct': 'UserDefC',
   'data': { 'string1': 'str', 'string2': 'str' } }
=20
+# for testing unions with an optional discriminator
+{ 'union': 'UserDefFlatUnion3',
+  'base': { '*enum1': 'EnumOne' },
+  'discriminator': 'enum1',
+  'default-variant': 'value1',
+  'data': { 'value1' : 'UserDefA',
+            'value2' : 'UserDefB',
+            'value3' : 'UserDefB'
+            # 'value4' defaults to empty
+  } }
+
 # for testing use of 'number' within alternates
 { 'alternate': 'AltEnumBool', 'data': { 'e': 'EnumOne', 'b': 'bool' } }
 { 'alternate': 'AltEnumNum', 'data': { 'e': 'EnumOne', 'n': 'number' } }
diff --git a/tests/qapi-schema/flat-union-optional-discriminator-invalid-=
default.err b/tests/qapi-schema/flat-union-optional-discriminator-invalid=
-default.err
new file mode 100644
index 0000000000..b6bd3423d6
--- /dev/null
+++ b/tests/qapi-schema/flat-union-optional-discriminator-invalid-default=
.err
@@ -0,0 +1 @@
+tests/qapi-schema/flat-union-optional-discriminator-invalid-default.json=
:7: Default variant 'three' of flat union 'MyUnion' is not part of 'Enum'
diff --git a/tests/qapi-schema/flat-union-optional-discriminator.exit b/t=
ests/qapi-schema/flat-union-optional-discriminator-invalid-default.exit
similarity index 100%
rename from tests/qapi-schema/flat-union-optional-discriminator.exit
rename to tests/qapi-schema/flat-union-optional-discriminator-invalid-def=
ault.exit
diff --git a/tests/qapi-schema/flat-union-optional-discriminator.out b/te=
sts/qapi-schema/flat-union-optional-discriminator-invalid-default.out
similarity index 100%
rename from tests/qapi-schema/flat-union-optional-discriminator.out
rename to tests/qapi-schema/flat-union-optional-discriminator-invalid-def=
ault.out
diff --git a/tests/qapi-schema/flat-union-optional-discriminator-invalid-=
specification.err b/tests/qapi-schema/flat-union-optional-discriminator-i=
nvalid-specification.err
new file mode 100644
index 0000000000..cbf154e726
--- /dev/null
+++ b/tests/qapi-schema/flat-union-optional-discriminator-invalid-specifi=
cation.err
@@ -0,0 +1 @@
+tests/qapi-schema/flat-union-optional-discriminator-invalid-specificatio=
n.json:7: Discriminator of flat union 'MyUnion' does not allow optional n=
ame '*switch'
diff --git a/tests/qapi-schema/flat-union-optional-discriminator-invalid-=
specification.exit b/tests/qapi-schema/flat-union-optional-discriminator-=
invalid-specification.exit
new file mode 100644
index 0000000000..d00491fd7e
--- /dev/null
+++ b/tests/qapi-schema/flat-union-optional-discriminator-invalid-specifi=
cation.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/flat-union-optional-discriminator-invalid-=
specification.out b/tests/qapi-schema/flat-union-optional-discriminator-i=
nvalid-specification.out
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/flat-union-optional-discriminator-no-defau=
lt.err b/tests/qapi-schema/flat-union-optional-discriminator-no-default.e=
rr
new file mode 100644
index 0000000000..1342efd9e8
--- /dev/null
+++ b/tests/qapi-schema/flat-union-optional-discriminator-no-default.err
@@ -0,0 +1 @@
+tests/qapi-schema/flat-union-optional-discriminator-no-default.json:7: D=
efault variant must be specified for optional discriminator 'switch'
diff --git a/tests/qapi-schema/flat-union-optional-discriminator-no-defau=
lt.exit b/tests/qapi-schema/flat-union-optional-discriminator-no-default.=
exit
new file mode 100644
index 0000000000..d00491fd7e
--- /dev/null
+++ b/tests/qapi-schema/flat-union-optional-discriminator-no-default.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/flat-union-optional-discriminator-no-defau=
lt.out b/tests/qapi-schema/flat-union-optional-discriminator-no-default.o=
ut
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/flat-union-optional-discriminator.err b/te=
sts/qapi-schema/flat-union-optional-discriminator.err
deleted file mode 100644
index aaabedb3bd..0000000000
--- a/tests/qapi-schema/flat-union-optional-discriminator.err
+++ /dev/null
@@ -1 +0,0 @@
-tests/qapi-schema/flat-union-optional-discriminator.json:6: Discriminato=
r of flat union 'MyUnion' does not allow optional name '*switch'
diff --git a/tests/qapi-schema/flat-union-superfluous-default-variant.err=
 b/tests/qapi-schema/flat-union-superfluous-default-variant.err
new file mode 100644
index 0000000000..5230bbf645
--- /dev/null
+++ b/tests/qapi-schema/flat-union-superfluous-default-variant.err
@@ -0,0 +1 @@
+tests/qapi-schema/flat-union-superfluous-default-variant.json:6: Must no=
t specify a default variant for non-optional discriminator 'switch'
diff --git a/tests/qapi-schema/flat-union-superfluous-default-variant.exi=
t b/tests/qapi-schema/flat-union-superfluous-default-variant.exit
new file mode 100644
index 0000000000..d00491fd7e
--- /dev/null
+++ b/tests/qapi-schema/flat-union-superfluous-default-variant.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/flat-union-superfluous-default-variant.out=
 b/tests/qapi-schema/flat-union-superfluous-default-variant.out
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/q=
api-schema-test.out
index 9464101d26..0044fb4554 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -92,6 +92,16 @@ alternate UserDefAlternate
 object UserDefC
     member string1: str optional=3DFalse
     member string2: str optional=3DFalse
+object q_obj_UserDefFlatUnion3-base
+    member enum1: EnumOne optional=3DTrue
+object UserDefFlatUnion3
+    base q_obj_UserDefFlatUnion3-base
+    tag enum1
+    default variant: value1
+    case value1: UserDefA
+    case value2: UserDefB
+    case value3: UserDefB
+    case value4: q_empty
 alternate AltEnumBool
     tag type
     case e: EnumOne
--=20
2.20.1
