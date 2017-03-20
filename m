Received: from eggs.gnu.org ([2001:4830:134:3::10]:49344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cpx6b-0003l4-Cj
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 09:12:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cpx6U-0002cs-9J
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 09:12:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50510)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cpx6T-0002cV-WF
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 09:12:06 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 20 Mar 2017 14:11:54 +0100
Message-Id: <1490015515-25851-6-git-send-email-armbru@redhat.com>
In-Reply-To: <1490015515-25851-1-git-send-email-armbru@redhat.com>
References: <1490015515-25851-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9 5/6] tests/qapi-schema: Systematic
 positive doc comment tests
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

We have a number of negative tests, but we don't have systematic
positive coverage.  Fix that.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/Makefile.include          |  13 ++-
 tests/qapi-schema/doc-good.err  |   0
 tests/qapi-schema/doc-good.exit |   1 +
 tests/qapi-schema/doc-good.json | 136 ++++++++++++++++++++++
 tests/qapi-schema/doc-good.out  | 148 ++++++++++++++++++++++++
 tests/qapi-schema/doc-good.texi | 243 ++++++++++++++++++++++++++++++++++++++++
 6 files changed, 537 insertions(+), 4 deletions(-)
 create mode 100644 tests/qapi-schema/doc-good.err
 create mode 100644 tests/qapi-schema/doc-good.exit
 create mode 100644 tests/qapi-schema/doc-good.json
 create mode 100644 tests/qapi-schema/doc-good.out
 create mode 100644 tests/qapi-schema/doc-good.texi

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 402e71c..8b497c5 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -379,6 +379,7 @@ qapi-schema += doc-duplicated-since.json
 qapi-schema += doc-empty-arg.json
 qapi-schema += doc-empty-section.json
 qapi-schema += doc-empty-symbol.json
+qapi-schema += doc-good.json
 qapi-schema += doc-interleaved-section.json
 qapi-schema += doc-invalid-end.json
 qapi-schema += doc-invalid-end2.json
@@ -607,6 +608,9 @@ $(SRC_PATH)/tests/qapi-schema/qapi-schema-test.json $(SRC_PATH)/scripts/qapi-int
 		$(gen-out-type) -o tests -p "test-" $<, \
 		"GEN","$@")
 
+tests/qapi-schema/doc-good.test.texi: $(SRC_PATH)/tests/qapi-schema/doc-good.json $(SRC_PATH)/scripts/qapi2texi.py $(qapi-py)
+	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi2texi.py $< > $@,"GEN","$@")
+
 tests/test-string-output-visitor$(EXESUF): tests/test-string-output-visitor.o $(test-qapi-obj-y)
 tests/test-string-input-visitor$(EXESUF): tests/test-string-input-visitor.o $(test-qapi-obj-y)
 tests/test-qmp-event$(EXESUF): tests/test-qmp-event.o $(test-qapi-obj-y)
@@ -856,9 +860,6 @@ QEMU_IOTESTS_HELPERS-$(CONFIG_LINUX) = tests/qemu-iotests/socket_scm_helper$(EXE
 check-tests/qemu-iotests-quick.sh: tests/qemu-iotests-quick.sh qemu-img$(EXESUF) qemu-io$(EXESUF) $(QEMU_IOTESTS_HELPERS-y)
 	$<
 
-.PHONY: check-tests/test-qapi.py
-check-tests/test-qapi.py: tests/test-qapi.py
-
 .PHONY: $(patsubst %, check-%, $(check-qapi-schema-y))
 $(patsubst %, check-%, $(check-qapi-schema-y)): check-%.json: $(SRC_PATH)/%.json
 	$(call quiet-command, PYTHONPATH=$(SRC_PATH)/scripts \
@@ -871,10 +872,14 @@ $(patsubst %, check-%, $(check-qapi-schema-y)): check-%.json: $(SRC_PATH)/%.json
 	@perl -p -e 's|\Q$(SRC_PATH)\E/||g' $*.test.err | diff -q $(SRC_PATH)/$*.err -
 	@diff -q $(SRC_PATH)/$*.exit $*.test.exit
 
+.PHONY: check-tests/qapi-schema/doc-good.texi
+check-tests/qapi-schema/doc-good.texi: tests/qapi-schema/doc-good.test.texi
+	@diff -q $(SRC_PATH)/tests/qapi-schema/doc-good.texi $<
+
 # Consolidated targets
 
 .PHONY: check-qapi-schema check-qtest check-unit check check-clean
-check-qapi-schema: $(patsubst %,check-%, $(check-qapi-schema-y))
+check-qapi-schema: $(patsubst %,check-%, $(check-qapi-schema-y)) check-tests/qapi-schema/doc-good.texi
 check-qtest: $(patsubst %,check-qtest-%, $(QTEST_TARGETS))
 check-unit: $(patsubst %,check-%, $(check-unit-y))
 check-block: $(patsubst %,check-%, $(check-block-y))
diff --git a/tests/qapi-schema/doc-good.err b/tests/qapi-schema/doc-good.err
new file mode 100644
index 0000000..e69de29
diff --git a/tests/qapi-schema/doc-good.exit b/tests/qapi-schema/doc-good.exit
new file mode 100644
index 0000000..573541a
--- /dev/null
+++ b/tests/qapi-schema/doc-good.exit
@@ -0,0 +1 @@
+0
diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-good.json
new file mode 100644
index 0000000..cfdc0a8
--- /dev/null
+++ b/tests/qapi-schema/doc-good.json
@@ -0,0 +1,136 @@
+# -*- Mode: Python -*-
+# Positive QAPI doc comment tests
+
+{ 'pragma': { 'doc-required': true } }
+
+##
+# = Section
+#
+# == Subsection
+#
+# *strong* _with emphasis_
+# @var {in braces}
+# * List item one
+# - Two, multiple
+#   lines
+#
+# 3. Three
+# Still in list
+#
+#   Not in list
+# - Second list
+# Note: still in list
+#
+# Note: not in list
+# 1. Third list
+#    is numbered
+#
+# - another item
+#
+# | example
+# | multiple lines
+#
+# Returns: the King
+# Since: the first age
+# Notes:
+#
+# 1. Lorem ipsum dolor sit amet
+#
+# 2. Ut enim ad minim veniam
+#
+# Duis aute irure dolor
+#
+# Example:
+#
+# -> in
+# <- out
+# Examples:
+# - *verbatim*
+# - {braces}
+##
+
+##
+# @Enum:
+# == Produces *invalid* texinfo
+# @one: The _one_ {and only}
+#
+# @two is undocumented
+##
+{ 'enum': 'Enum', 'data': [ 'one', 'two' ] }
+
+##
+# @Base:
+# @base1:
+#   the first member
+##
+{ 'struct': 'Base', 'data': { 'base1': 'Enum' } }
+
+##
+# @Variant1:
+# A paragraph
+#
+# Another paragraph (but no @var: line)
+##
+{ 'struct': 'Variant1', 'data': { 'var1': 'str' } }
+
+##
+# @Variant2:
+##
+{ 'struct': 'Variant2', 'data': {} }
+
+##
+# @Object:
+##
+{ 'union': 'Object',
+  'base': 'Base',
+  'discriminator': 'base1',
+  'data': { 'one': 'Variant1', 'two': 'Variant2' } }
+
+##
+# @SugaredUnion:
+##
+{ 'union': 'SugaredUnion',
+  'data': { 'one': 'Variant1', 'two': 'Variant2' } }
+
+##
+# == Another subsection
+##
+
+##
+# @cmd:
+# @arg1: the first argument
+#
+# @arg2: the second
+# argument
+# Note: @arg3 is undocumented
+# Returns: @Object
+# TODO: frobnicate
+# Notes:
+# - Lorem ipsum dolor sit amet
+# - Ut enim ad minim veniam
+#
+# Duis aute irure dolor
+# Example:
+#
+# -> in
+# <- out
+# Examples:
+# - *verbatim*
+# - {braces}
+# Since: 2.10
+##
+{ 'command': 'cmd',
+  'data': { 'arg1': 'int', '*arg2': 'str', 'arg3': 'bool' },
+  'returns': 'Object' }
+
+##
+# @cmd-boxed:
+# If you're bored enough to read this, go see a video of boxed cats
+# Example:
+#
+# -> in
+#
+# <- out
+##
+{ 'command': 'cmd-boxed', 'boxed': true,
+  'data': 'Object' }
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.out
new file mode 100644
index 0000000..70c1252
--- /dev/null
+++ b/tests/qapi-schema/doc-good.out
@@ -0,0 +1,148 @@
+object Base
+    member base1: Enum optional=False
+enum Enum ['one', 'two']
+object Object
+    base Base
+    tag base1
+    case one: Variant1
+    case two: Variant2
+enum QType ['none', 'qnull', 'qint', 'qstring', 'qdict', 'qlist', 'qfloat', 'qbool']
+    prefix QTYPE
+object SugaredUnion
+    member type: SugaredUnionKind optional=False
+    tag type
+    case one: q_obj_Variant1-wrapper
+    case two: q_obj_Variant2-wrapper
+enum SugaredUnionKind ['one', 'two']
+object Variant1
+    member var1: str optional=False
+object Variant2
+command cmd q_obj_cmd-arg -> Object
+   gen=True success_response=True boxed=False
+command cmd-boxed Object -> None
+   gen=True success_response=True boxed=True
+object q_empty
+object q_obj_Variant1-wrapper
+    member data: Variant1 optional=False
+object q_obj_Variant2-wrapper
+    member data: Variant2 optional=False
+object q_obj_cmd-arg
+    member arg1: int optional=False
+    member arg2: str optional=True
+    member arg3: bool optional=False
+doc freeform
+    body=
+= Section
+
+== Subsection
+
+*strong* _with emphasis_
+@var {in braces}
+* List item one
+- Two, multiple
+lines
+
+3. Three
+Still in list
+
+Not in list
+- Second list
+Note: still in list
+
+Note: not in list
+1. Third list
+is numbered
+
+- another item
+
+| example
+| multiple lines
+
+Returns: the King
+Since: the first age
+Notes:
+
+1. Lorem ipsum dolor sit amet
+
+2. Ut enim ad minim veniam
+
+Duis aute irure dolor
+
+Example:
+
+-> in
+<- out
+Examples:
+- *verbatim*
+- {braces}
+doc symbol=Enum
+    body=
+== Produces *invalid* texinfo
+    arg=one
+The _one_ {and only}
+    arg=two
+
+    section=
+@two is undocumented
+doc symbol=Base
+    body=
+
+    arg=base1
+the first member
+doc symbol=Variant1
+    body=
+A paragraph
+
+Another paragraph (but no @var: line)
+    arg=var1
+
+doc symbol=Variant2
+    body=
+
+doc symbol=Object
+    body=
+
+doc symbol=SugaredUnion
+    body=
+
+    arg=type
+
+doc freeform
+    body=
+== Another subsection
+doc symbol=cmd
+    body=
+
+    arg=arg1
+the first argument
+    arg=arg2
+the second
+argument
+    arg=arg3
+
+    section=Note
+@arg3 is undocumented
+    section=Returns
+@Object
+    section=TODO
+frobnicate
+    section=Notes
+- Lorem ipsum dolor sit amet
+- Ut enim ad minim veniam
+
+Duis aute irure dolor
+    section=Example
+-> in
+<- out
+    section=Examples
+- *verbatim*
+- {braces}
+    section=Since
+2.10
+doc symbol=cmd-boxed
+    body=
+If you're bored enough to read this, go see a video of boxed cats
+    section=Example
+-> in
+
+<- out
diff --git a/tests/qapi-schema/doc-good.texi b/tests/qapi-schema/doc-good.texi
new file mode 100644
index 0000000..1160aaf
--- /dev/null
+++ b/tests/qapi-schema/doc-good.texi
@@ -0,0 +1,243 @@
+@section Section
+
+@subsection Subsection
+
+@emph{strong}  @emph{with emphasis} 
+@code{var} @{in braces@}
+@itemize @bullet
+@item
+List item one
+@item
+Two, multiple
+lines
+
+@item
+Three
+Still in list
+
+@end itemize
+
+Not in list
+@itemize @minus
+@item
+Second list
+Note: still in list
+
+@end itemize
+
+Note: not in list
+@enumerate
+@item
+Third list
+is numbered
+
+@item
+another item
+
+@example
+example
+@end example
+
+@example
+multiple lines
+@end example
+
+
+@end enumerate
+
+Returns: the King
+Since: the first age
+Notes:
+
+@enumerate
+@item
+Lorem ipsum dolor sit amet
+
+@item
+Ut enim ad minim veniam
+
+@end enumerate
+
+Duis aute irure dolor
+
+Example:
+
+-> in
+<- out
+Examples:
+@itemize @minus
+@item
+@emph{verbatim}
+@item
+@{braces@}
+@end itemize
+
+
+
+@deftp {Enum} Enum
+
+@subsection Produces @emph{invalid} texinfo
+
+@b{Values:}
+@table @asis
+@item @code{one}
+The  @emph{one}  @{and only@}
+@item @code{two}
+Not documented
+@end table
+@code{two} is undocumented
+
+@end deftp
+
+
+
+@deftp {Object} Base
+
+
+
+@b{Members:}
+@table @asis
+@item @code{base1: Enum}
+the first member
+@end table
+
+
+@end deftp
+
+
+
+@deftp {Object} Variant1
+
+A paragraph
+
+Another paragraph (but no @code{var}: line)
+
+@b{Members:}
+@table @asis
+@item @code{var1: string}
+Not documented
+@end table
+
+
+@end deftp
+
+
+
+@deftp {Object} Variant2
+
+
+
+
+@end deftp
+
+
+
+@deftp {Object} Object
+
+
+
+@b{Members:}
+@table @asis
+@item The members of @code{Base}
+@item The members of @code{Variant1} when @code{base1} is @t{"one"}
+@item The members of @code{Variant2} when @code{base1} is @t{"two"}
+@end table
+
+
+@end deftp
+
+
+
+@deftp {Object} SugaredUnion
+
+
+
+@b{Members:}
+@table @asis
+@item @code{type}
+One of @t{"one"}, @t{"two"}
+@item @code{data: Variant1} when @code{type} is @t{"one"}
+@item @code{data: Variant2} when @code{type} is @t{"two"}
+@end table
+
+
+@end deftp
+
+
+@subsection Another subsection
+
+
+@deftypefn Command {} cmd
+
+
+
+@b{Arguments:}
+@table @asis
+@item @code{arg1: int}
+the first argument
+@item @code{arg2: string} (optional)
+the second
+argument
+@item @code{arg3: boolean}
+Not documented
+@end table
+
+
+@b{Note:}
+@code{arg3} is undocumented
+
+@b{Returns:}
+@code{Object}
+
+@b{TODO:}
+frobnicate
+
+@b{Notes:}
+@itemize @minus
+@item
+Lorem ipsum dolor sit amet
+@item
+Ut enim ad minim veniam
+
+@end itemize
+
+Duis aute irure dolor
+
+@b{Example:}
+@example
+-> in
+<- out
+@end example
+
+
+@b{Examples:}
+@example
+- *verbatim*
+- @{braces@}
+@end example
+
+
+@b{Since:}
+2.10
+
+@end deftypefn
+
+
+
+@deftypefn Command {} cmd-boxed
+
+If you're bored enough to read this, go see a video of boxed cats
+
+@b{Arguments:} the members of @code{Object}
+
+@b{Example:}
+@example
+-> in
+
+<- out
+@end example
+
+
+@end deftypefn
+
+
-- 
2.7.4
