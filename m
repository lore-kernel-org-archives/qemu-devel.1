Received: from eggs.gnu.org ([2001:4830:134:3::10]:44684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dCqPV-0000wq-Q2
	for qemu-devel@nongnu.org; Mon, 22 May 2017 12:42:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dCqPT-0001KY-0d
	for qemu-devel@nongnu.org; Mon, 22 May 2017 12:42:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40488)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dCqPS-0001K1-OE
	for qemu-devel@nongnu.org; Mon, 22 May 2017 12:42:18 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8E45979706
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 16:42:17 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 22 May 2017 18:42:15 +0200
Message-Id: <1495471335-23707-5-git-send-email-armbru@redhat.com>
In-Reply-To: <1495471335-23707-1-git-send-email-armbru@redhat.com>
References: <1495471335-23707-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 4/4] qapi: Reject alternates that can't work
 with keyval_parse()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, mlureau@redhat.com

Alternates are sum types like unions, but use the JSON type on the
wire / QType in QObject instead of an explicit tag.  That's why we
require alternate members to have distinct QTypes.

The recently introduced keyval_parse() (commit d454dbe) can only
produce string scalars.  The qobject_input_visitor_new_keyval() input
visitor mostly hides the difference, so code using a QObject input
visitor doesn't have to care whether its input was parsed from JSON or
KEY=VALUE,...  The difference leaks for alternates, as noted in commit
0ee9ae7: an non-string, non-enum scalar alternate value can't
currently be expressed.

In part, this is just our insufficiently sophisticated implementation.
Consider alternate type 'GuestFileWhence'.  It has an integer member
and a 'QGASeek' member.  The latter is an enumeration with values
'set', 'cur', 'end'.  The meaning of b=set, b=cur, b=end, b=0, b=1 and
so forth is perfectly obvious.  However, our current implementation
falls apart at run time for b=0, b=1, and so forth.  Fixable, but not
today; add a test case and a TODO comment.

Now consider an alternate type with a string and an integer member.
What's the meaning of a=42?  Is it the string "42" or the integer 42?
Whichever meaning you pick makes the other inexpressible.  This isn't
just an implementation problem, it's fundamental.  Our current
implementation will pick string.

So far, we haven't needed such alternates.  To make sure we stop and
think before we add one that cannot sanely work with keyval_parse(),
let's require alternate members to have sufficiently district
representation in KEY=VALUE,... syntax:

* A string member clashes with any other scalar member

* An enumeration member clashes with bool members when it has value
  'on' or 'off'.

* An enumeration member clashes with numeric members when it has a
  value that starts with '-', '+', '0' or '9'.  This is a rather lazy
  approximation of the actual number syntax accepted by the visitor.

  Note that enumeration values starting with '-' and '+' are rejected
  elsewhere already, but better safe than sorry.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi.py                                     | 19 +++++++++++++++++--
 tests/Makefile.include                              |  2 ++
 tests/qapi-schema/alternate-conflict-dict.json      |  2 +-
 tests/qapi-schema/alternate-conflict-enum-bool.err  |  1 +
 tests/qapi-schema/alternate-conflict-enum-bool.exit |  1 +
 tests/qapi-schema/alternate-conflict-enum-bool.json |  6 ++++++
 tests/qapi-schema/alternate-conflict-enum-bool.out  |  0
 tests/qapi-schema/alternate-conflict-enum-int.err   |  1 +
 tests/qapi-schema/alternate-conflict-enum-int.exit  |  1 +
 tests/qapi-schema/alternate-conflict-enum-int.json  |  6 ++++++
 tests/qapi-schema/alternate-conflict-enum-int.out   |  0
 tests/qapi-schema/alternate-conflict-string.err     |  2 +-
 tests/qapi-schema/alternate-conflict-string.json    |  6 ++----
 tests/qapi-schema/qapi-schema-test.json             |  4 +++-
 tests/qapi-schema/qapi-schema-test.out              |  4 ++--
 tests/test-keyval.c                                 | 18 +++++++++++-------
 util/keyval.c                                       | 10 +++++-----
 17 files changed, 60 insertions(+), 23 deletions(-)
 create mode 100644 tests/qapi-schema/alternate-conflict-enum-bool.err
 create mode 100644 tests/qapi-schema/alternate-conflict-enum-bool.exit
 create mode 100644 tests/qapi-schema/alternate-conflict-enum-bool.json
 create mode 100644 tests/qapi-schema/alternate-conflict-enum-bool.out
 create mode 100644 tests/qapi-schema/alternate-conflict-enum-int.err
 create mode 100644 tests/qapi-schema/alternate-conflict-enum-int.exit
 create mode 100644 tests/qapi-schema/alternate-conflict-enum-int.json
 create mode 100644 tests/qapi-schema/alternate-conflict-enum-int.out

diff --git a/scripts/qapi.py b/scripts/qapi.py
index 6c4d554..b7a25e4 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -812,11 +812,26 @@ def check_alternate(expr, info):
         if not qtype:
             raise QAPISemError(info, "Alternate '%s' member '%s' cannot use "
                                "type '%s'" % (name, key, value))
-        if qtype in types_seen:
+        conflicting = set([qtype])
+        if qtype == 'QTYPE_QSTRING':
+            enum_expr = enum_types.get(value)
+            if enum_expr:
+                for v in enum_expr['data']:
+                    if v in ['on', 'off']:
+                        conflicting.add('QTYPE_QBOOL')
+                    if re.match(r'[-+0-9.]', v): # lazy, could be tightened
+                        conflicting.add('QTYPE_QINT')
+                        conflicting.add('QTYPE_QFLOAT')
+            else:
+                conflicting.add('QTYPE_QINT')
+                conflicting.add('QTYPE_QFLOAT')
+                conflicting.add('QTYPE_QBOOL')
+        if conflicting & set(types_seen):
             raise QAPISemError(info, "Alternate '%s' member '%s' can't "
                                "be distinguished from member '%s'"
                                % (name, key, types_seen[qtype]))
-        types_seen[qtype] = key
+        for qt in conflicting:
+            types_seen[qt] = key
 
 
 def check_enum(expr, info):
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 4277597..92116de 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -342,6 +342,8 @@ qapi-schema += alternate-array.json
 qapi-schema += alternate-base.json
 qapi-schema += alternate-clash.json
 qapi-schema += alternate-conflict-dict.json
+qapi-schema += alternate-conflict-enum-bool.json
+qapi-schema += alternate-conflict-enum-int.json
 qapi-schema += alternate-conflict-string.json
 qapi-schema += alternate-empty.json
 qapi-schema += alternate-nested.json
diff --git a/tests/qapi-schema/alternate-conflict-dict.json b/tests/qapi-schema/alternate-conflict-dict.json
index d566cca..3d78812 100644
--- a/tests/qapi-schema/alternate-conflict-dict.json
+++ b/tests/qapi-schema/alternate-conflict-dict.json
@@ -1,4 +1,4 @@
-# we reject alternates with multiple object branches
+# alternate branches of object type conflict with each other
 { 'struct': 'One',
   'data': { 'name': 'str' } }
 { 'struct': 'Two',
diff --git a/tests/qapi-schema/alternate-conflict-enum-bool.err b/tests/qapi-schema/alternate-conflict-enum-bool.err
new file mode 100644
index 0000000..0dfc002
--- /dev/null
+++ b/tests/qapi-schema/alternate-conflict-enum-bool.err
@@ -0,0 +1 @@
+tests/qapi-schema/alternate-conflict-enum-bool.json:4: Alternate 'Alt' member 'two' can't be distinguished from member 'one'
diff --git a/tests/qapi-schema/alternate-conflict-enum-bool.exit b/tests/qapi-schema/alternate-conflict-enum-bool.exit
new file mode 100644
index 0000000..d00491f
--- /dev/null
+++ b/tests/qapi-schema/alternate-conflict-enum-bool.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/alternate-conflict-enum-bool.json b/tests/qapi-schema/alternate-conflict-enum-bool.json
new file mode 100644
index 0000000..bff25c3
--- /dev/null
+++ b/tests/qapi-schema/alternate-conflict-enum-bool.json
@@ -0,0 +1,6 @@
+# alternate branch of 'enum' type that conflicts with bool
+{ 'enum': 'Enum',
+  'data': [ 'aus', 'off' ] }
+{ 'alternate': 'Alt',
+  'data': { 'one': 'Enum',
+            'two': 'bool' } }
diff --git a/tests/qapi-schema/alternate-conflict-enum-bool.out b/tests/qapi-schema/alternate-conflict-enum-bool.out
new file mode 100644
index 0000000..e69de29
diff --git a/tests/qapi-schema/alternate-conflict-enum-int.err b/tests/qapi-schema/alternate-conflict-enum-int.err
new file mode 100644
index 0000000..2cc8e7b
--- /dev/null
+++ b/tests/qapi-schema/alternate-conflict-enum-int.err
@@ -0,0 +1 @@
+tests/qapi-schema/alternate-conflict-enum-int.json:4: Alternate 'Alt' member 'two' can't be distinguished from member 'one'
diff --git a/tests/qapi-schema/alternate-conflict-enum-int.exit b/tests/qapi-schema/alternate-conflict-enum-int.exit
new file mode 100644
index 0000000..d00491f
--- /dev/null
+++ b/tests/qapi-schema/alternate-conflict-enum-int.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/alternate-conflict-enum-int.json b/tests/qapi-schema/alternate-conflict-enum-int.json
new file mode 100644
index 0000000..beb428c
--- /dev/null
+++ b/tests/qapi-schema/alternate-conflict-enum-int.json
@@ -0,0 +1,6 @@
+# alternate branches of 'enum' type that conflicts with numbers
+{ 'enum': 'Enum',
+  'data': [ '1', '2', '3' ] }
+{ 'alternate': 'Alt',
+  'data': { 'one': 'Enum',
+            'two': 'int' } }
diff --git a/tests/qapi-schema/alternate-conflict-enum-int.out b/tests/qapi-schema/alternate-conflict-enum-int.out
new file mode 100644
index 0000000..e69de29
diff --git a/tests/qapi-schema/alternate-conflict-string.err b/tests/qapi-schema/alternate-conflict-string.err
index fc523b0..fe2f188 100644
--- a/tests/qapi-schema/alternate-conflict-string.err
+++ b/tests/qapi-schema/alternate-conflict-string.err
@@ -1 +1 @@
-tests/qapi-schema/alternate-conflict-string.json:4: Alternate 'Alt' member 'two' can't be distinguished from member 'one'
+tests/qapi-schema/alternate-conflict-string.json:2: Alternate 'Alt' member 'two' can't be distinguished from member 'one'
diff --git a/tests/qapi-schema/alternate-conflict-string.json b/tests/qapi-schema/alternate-conflict-string.json
index 72f04a8..85adbd4 100644
--- a/tests/qapi-schema/alternate-conflict-string.json
+++ b/tests/qapi-schema/alternate-conflict-string.json
@@ -1,6 +1,4 @@
-# we reject alternates with multiple string-like branches
-{ 'enum': 'Enum',
-  'data': [ 'hello', 'world' ] }
+# alternate branches of 'str' type conflict with all scalar types
 { 'alternate': 'Alt',
   'data': { 'one': 'str',
-            'two': 'Enum' } }
+            'two': 'int' } }
diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/qapi-schema-test.json
index 303f2b2..17649c6 100644
--- a/tests/qapi-schema/qapi-schema-test.json
+++ b/tests/qapi-schema/qapi-schema-test.json
@@ -101,12 +101,14 @@
 # for testing use of 'number' within alternates
 { 'alternate': 'AltEnumBool', 'data': { 'e': 'EnumOne', 'b': 'bool' } }
 { 'alternate': 'AltEnumNum', 'data': { 'e': 'EnumOne', 'n': 'number' } }
-{ 'alternate': 'AltNumStr', 'data': { 'n': 'number', 's': 'str' } }
 { 'alternate': 'AltNumEnum', 'data': { 'n': 'number', 'e': 'EnumOne' } }
 { 'alternate': 'AltEnumInt', 'data': { 'e': 'EnumOne', 'i': 'int' } }
 { 'alternate': 'AltIntNum', 'data': { 'i': 'int', 'n': 'number' } }
 { 'alternate': 'AltNumInt', 'data': { 'n': 'number', 'i': 'int' } }
 
+# for testing use of 'str' within alternates
+{ 'alternate': 'AltStrObj', 'data': { 's': 'str', 'o': 'TestStruct' } }
+
 # for testing native lists
 { 'union': 'UserDefNativeListUnion',
   'data': { 'integer': ['int'],
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/qapi-schema-test.out
index 3081091..9f68610 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -22,10 +22,10 @@ alternate AltNumInt
     tag type
     case n: number
     case i: int
-alternate AltNumStr
+alternate AltStrObj
     tag type
-    case n: number
     case s: str
+    case o: TestStruct
 event EVENT_A None
    boxed=False
 event EVENT_B None
diff --git a/tests/test-keyval.c b/tests/test-keyval.c
index c556b1b..c3be005 100644
--- a/tests/test-keyval.c
+++ b/tests/test-keyval.c
@@ -614,22 +614,26 @@ static void test_keyval_visit_alternate(void)
     Error *err = NULL;
     Visitor *v;
     QDict *qdict;
-    AltNumStr *ans;
+    AltStrObj *aso;
     AltNumInt *ani;
+    AltEnumBool *aeb;
 
     /*
      * Can't do scalar alternate variants other than string.  You get
      * the string variant if there is one, else an error.
+     * TODO make it work for unambiguous cases like AltEnumBool below
      */
-    qdict = keyval_parse("a=1,b=2", NULL, &error_abort);
+    qdict = keyval_parse("a=1,b=2,c=on", NULL, &error_abort);
     v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
     QDECREF(qdict);
     visit_start_struct(v, NULL, NULL, 0, &error_abort);
-    visit_type_AltNumStr(v, "a", &ans, &error_abort);
-    g_assert_cmpint(ans->type, ==, QTYPE_QSTRING);
-    g_assert_cmpstr(ans->u.s, ==, "1");
-    qapi_free_AltNumStr(ans);
-    visit_type_AltNumInt(v, "a", &ani, &err);
+    visit_type_AltStrObj(v, "a", &aso, &error_abort);
+    g_assert_cmpint(aso->type, ==, QTYPE_QSTRING);
+    g_assert_cmpstr(aso->u.s, ==, "1");
+    qapi_free_AltStrObj(aso);
+    visit_type_AltNumInt(v, "b", &ani, &err);
+    error_free_or_abort(&err);
+    visit_type_AltEnumBool(v, "c", &aeb, &err);
     error_free_or_abort(&err);
     visit_end_struct(v, NULL);
     visit_free(v);
diff --git a/util/keyval.c b/util/keyval.c
index 93d5db6..7dbda62 100644
--- a/util/keyval.c
+++ b/util/keyval.c
@@ -65,11 +65,11 @@
  * denote numbers, true, false or null.  The special QObject input
  * visitor returned by qobject_input_visitor_new_keyval() mostly hides
  * this by automatically converting strings to the type the visitor
- * expects.  Breaks down for alternate types and type 'any', where the
- * visitor's expectation isn't clear.  Code visiting such types needs
- * to do the conversion itself, but only when using this keyval
- * visitor.  Awkward.  Alternate types without a string member don't
- * work at all.
+ * expects.  Breaks down for type 'any', where the visitor's
+ * expectation isn't clear.  Code visiting 'any' needs to do the
+ * conversion itself, but only when using this keyval visitor.
+ * Awkward.  Note that we carefully restrict alternate types to avoid
+ * similar ambiguity.
  *
  * Additional syntax for use with an implied key:
  *
-- 
2.7.4
