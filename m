Received: from eggs.gnu.org ([2001:4830:134:3::10]:37100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cqilo-0006Wp-7O
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 12:05:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cqill-0001kk-LL
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 12:05:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58392)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cqill-0001jF-5T
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 12:05:53 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 16C4DC05B1C7
	for <qemu-devel@nongnu.org>; Wed, 22 Mar 2017 16:05:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-26.ams2.redhat.com
	[10.36.116.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5559A1713E
	for <qemu-devel@nongnu.org>; Wed, 22 Mar 2017 16:05:52 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 22 Mar 2017 17:05:41 +0100
Message-Id: <1490198748-4753-11-git-send-email-armbru@redhat.com>
In-Reply-To: <1490198748-4753-1-git-send-email-armbru@redhat.com>
References: <1490198748-4753-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL for-2.9 10/17] tests/qapi-schema: Systematic
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

We have a number of negative tests, but we don't have systematic
positive coverage.  Fix that.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <1490015515-25851-6-git-send-email-armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/Makefile.include          |  13 ++-
 tests/qapi-schema/doc-good.err  |   0
 tests/qapi-schema/doc-good.exit |   1 +
 tests/qapi-schema/doc-good.json | 136 ++++++++++++++++++++++
 tests/qapi-schema/doc-good.out  | 148 ++++++++++++++++++++++++
 tests/qapi-schema/doc-good.texi | 243 ++++++++++++++++++++++++++++++++++=
++++++
 6 files changed, 537 insertions(+), 4 deletions(-)
 create mode 100644 tests/qapi-schema/doc-good.err
 create mode 100644 tests/qapi-schema/doc-good.exit
 create mode 100644 tests/qapi-schema/doc-good.json
 create mode 100644 tests/qapi-schema/doc-good.out
 create mode 100644 tests/qapi-schema/doc-good.texi

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 86f9490..f3de81f 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -379,6 +379,7 @@ qapi-schema +=3D doc-duplicated-since.json
 qapi-schema +=3D doc-empty-arg.json
 qapi-schema +=3D doc-empty-section.json
 qapi-schema +=3D doc-empty-symbol.json
+qapi-schema +=3D doc-good.json
 qapi-schema +=3D doc-interleaved-section.json
 qapi-schema +=3D doc-invalid-end.json
 qapi-schema +=3D doc-invalid-end2.json
@@ -607,6 +608,9 @@ $(SRC_PATH)/tests/qapi-schema/qapi-schema-test.json $=
(SRC_PATH)/scripts/qapi-int
 		$(gen-out-type) -o tests -p "test-" $<, \
 		"GEN","$@")
=20
+tests/qapi-schema/doc-good.test.texi: $(SRC_PATH)/tests/qapi-schema/doc-=
good.json $(SRC_PATH)/scripts/qapi2texi.py $(qapi-py)
+	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi2texi.py $< > $@=
,"GEN","$@")
+
 tests/test-string-output-visitor$(EXESUF): tests/test-string-output-visi=
tor.o $(test-qapi-obj-y)
 tests/test-string-input-visitor$(EXESUF): tests/test-string-input-visito=
r.o $(test-qapi-obj-y)
 tests/test-qmp-event$(EXESUF): tests/test-qmp-event.o $(test-qapi-obj-y)
@@ -856,9 +860,6 @@ QEMU_IOTESTS_HELPERS-$(CONFIG_LINUX) =3D tests/qemu-i=
otests/socket_scm_helper$(EXE
 check-tests/qemu-iotests-quick.sh: tests/qemu-iotests-quick.sh qemu-img$=
(EXESUF) qemu-io$(EXESUF) $(QEMU_IOTESTS_HELPERS-y)
 	$<
=20
-.PHONY: check-tests/test-qapi.py
-check-tests/test-qapi.py: tests/test-qapi.py
-
 .PHONY: $(patsubst %, check-%, $(check-qapi-schema-y))
 $(patsubst %, check-%, $(check-qapi-schema-y)): check-%.json: $(SRC_PATH=
)/%.json
 	$(call quiet-command, PYTHONPATH=3D$(SRC_PATH)/scripts \
@@ -871,10 +872,14 @@ $(patsubst %, check-%, $(check-qapi-schema-y)): che=
ck-%.json: $(SRC_PATH)/%.json
 	@perl -p -e 's|\Q$(SRC_PATH)\E/||g' $*.test.err | diff -q $(SRC_PATH)/$=
*.err -
 	@diff -q $(SRC_PATH)/$*.exit $*.test.exit
=20
+.PHONY: check-tests/qapi-schema/doc-good.texi
+check-tests/qapi-schema/doc-good.texi: tests/qapi-schema/doc-good.test.t=
exi
+	@diff -q $(SRC_PATH)/tests/qapi-schema/doc-good.texi $<
+
 # Consolidated targets
=20
 .PHONY: check-qapi-schema check-qtest check-unit check check-clean
-check-qapi-schema: $(patsubst %,check-%, $(check-qapi-schema-y))
+check-qapi-schema: $(patsubst %,check-%, $(check-qapi-schema-y)) check-t=
ests/qapi-schema/doc-good.texi
 check-qtest: $(patsubst %,check-qtest-%, $(QTEST_TARGETS))
 check-unit: $(patsubst %,check-%, $(check-unit-y))
 check-block: $(patsubst %,check-%, $(check-block-y))
diff --git a/tests/qapi-schema/doc-good.err b/tests/qapi-schema/doc-good.=
err
new file mode 100644
index 0000000..e69de29
diff --git a/tests/qapi-schema/doc-good.exit b/tests/qapi-schema/doc-good=
.exit
new file mode 100644
index 0000000..573541a
--- /dev/null
+++ b/tests/qapi-schema/doc-good.exit
@@ -0,0 +1 @@
+0
diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-good=
.json
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
+# =3D Section
+#
+# =3D=3D Subsection
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
+# =3D=3D Produces *invalid* texinfo
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
+# =3D=3D Another subsection
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
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.=
out
new file mode 100644
index 0000000..70c1252
--- /dev/null
+++ b/tests/qapi-schema/doc-good.out
@@ -0,0 +1,148 @@
+object Base
+    member base1: Enum optional=3DFalse
+enum Enum ['one', 'two']
+object Object
+    base Base
+    tag base1
+    case one: Variant1
+    case two: Variant2
+enum QType ['none', 'qnull', 'qint', 'qstring', 'qdict', 'qlist', 'qfloa=
t', 'qbool']
+    prefix QTYPE
+object SugaredUnion
+    member type: SugaredUnionKind optional=3DFalse
+    tag type
+    case one: q_obj_Variant1-wrapper
+    case two: q_obj_Variant2-wrapper
+enum SugaredUnionKind ['one', 'two']
+object Variant1
+    member var1: str optional=3DFalse
+object Variant2
+command cmd q_obj_cmd-arg -> Object
+   gen=3DTrue success_response=3DTrue boxed=3DFalse
+command cmd-boxed Object -> None
+   gen=3DTrue success_response=3DTrue boxed=3DTrue
+object q_empty
+object q_obj_Variant1-wrapper
+    member data: Variant1 optional=3DFalse
+object q_obj_Variant2-wrapper
+    member data: Variant2 optional=3DFalse
+object q_obj_cmd-arg
+    member arg1: int optional=3DFalse
+    member arg2: str optional=3DTrue
+    member arg3: bool optional=3DFalse
+doc freeform
+    body=3D
+=3D Section
+
+=3D=3D Subsection
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
+doc symbol=3DEnum
+    body=3D
+=3D=3D Produces *invalid* texinfo
+    arg=3Done
+The _one_ {and only}
+    arg=3Dtwo
+
+    section=3D
+@two is undocumented
+doc symbol=3DBase
+    body=3D
+
+    arg=3Dbase1
+the first member
+doc symbol=3DVariant1
+    body=3D
+A paragraph
+
+Another paragraph (but no @var: line)
+    arg=3Dvar1
+
+doc symbol=3DVariant2
+    body=3D
+
+doc symbol=3DObject
+    body=3D
+
+doc symbol=3DSugaredUnion
+    body=3D
+
+    arg=3Dtype
+
+doc freeform
+    body=3D
+=3D=3D Another subsection
+doc symbol=3Dcmd
+    body=3D
+
+    arg=3Darg1
+the first argument
+    arg=3Darg2
+the second
+argument
+    arg=3Darg3
+
+    section=3DNote
+@arg3 is undocumented
+    section=3DReturns
+@Object
+    section=3DTODO
+frobnicate
+    section=3DNotes
+- Lorem ipsum dolor sit amet
+- Ut enim ad minim veniam
+
+Duis aute irure dolor
+    section=3DExample
+-> in
+<- out
+    section=3DExamples
+- *verbatim*
+- {braces}
+    section=3DSince
+2.10
+doc symbol=3Dcmd-boxed
+    body=3D
+If you're bored enough to read this, go see a video of boxed cats
+    section=3DExample
+-> in
+
+<- out
diff --git a/tests/qapi-schema/doc-good.texi b/tests/qapi-schema/doc-good=
.texi
new file mode 100644
index 0000000..1160aaf
--- /dev/null
+++ b/tests/qapi-schema/doc-good.texi
@@ -0,0 +1,243 @@
+@section Section
+
+@subsection Subsection
+
+@emph{strong}  @emph{with emphasis}=20
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
--=20
2.7.4
