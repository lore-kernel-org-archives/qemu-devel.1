Received: from eggs.gnu.org ([2001:4830:134:3::10]:38947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz2bj-00084G-0h
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz2bf-00080z-20
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38356)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dz2be-0007zy-Pz
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:06 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  2 Oct 2017 17:25:46 +0200
Message-Id: <20171002152552.27999-27-armbru@redhat.com>
In-Reply-To: <20171002152552.27999-1-armbru@redhat.com>
References: <20171002152552.27999-1-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 26/32] qapi2texi: Include command line
 options information
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, marcandre.lureau@redhat.com, eblake@redhat.com
List-ID: <qemu-devel.nongnu.org>

Make generated QEMU QMP reference cover command line options in
addition to QMP commands and events.  Simple, but pushes the QMP
reference beyond QMP.  Perhaps options documentation should be
separate.  Perhaps not for the same reason QMP and command line are
defined in the same schema: they share many types.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi2texi.py            | 15 ++++++++++++++
 tests/qapi-schema/doc-good.json | 24 ++++++++++++++++++++++
 tests/qapi-schema/doc-good.out  | 45 +++++++++++++++++++++++++++++++++++++++++
 tests/qapi-schema/doc-good.texi | 45 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 129 insertions(+)

diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
index 0e099ebaa2..c638b82631 100755
--- a/scripts/qapi2texi.py
+++ b/scripts/qapi2texi.py
@@ -253,6 +253,21 @@ class QAPISchemaGenDocVisitor(qapi.QAPISchemaVisitor):
                             name=doc.symbol,
                             body=texi_entity(doc, 'Arguments'))
 
+    def visit_option(self, name, info, arg_type, short, implied_key,
+                     boxed, help):
+        doc = self.cur_doc
+        if self.out:
+            self.out += '\n'
+        if boxed:
+            body = texi_body(doc)
+            body += '\n@b{Arguments:} the members of @code{%s}' % arg_type.name
+            body += texi_sections(doc)
+        else:
+            body = texi_entity(doc, 'Arguments')
+        self.out += MSG_FMT(type='Option',
+                            name=doc.symbol,
+                            body=body)
+
     def symbol(self, doc, entity):
         if self.out:
             self.out += '\n'
diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-good.json
index d3ddf828ef..eba8acd50d 100644
--- a/tests/qapi-schema/doc-good.json
+++ b/tests/qapi-schema/doc-good.json
@@ -151,3 +151,27 @@
 ##
 { 'command': 'cmd-boxed', 'boxed': true,
   'data': 'Object' }
+
+##
+# @--help:
+# Display help and exit.
+##
+{ 'option': '--help', 'short': 'h' , 'help': null }
+
+##
+# @--opt-arg-str:
+# TODO support documenting simple option argument
+##
+{ 'option': '--opt-arg-str', 'data': 'str' , 'help': null }
+
+##
+# @--opt-arg-struct:
+# @s: a string
+# @i: an integer
+##
+{ 'option': '--opt-arg-struct', 'data': { 's': 'str', '*i': 'int' } , 'help': null }
+
+##
+# @--opt-arg-boxed:
+##
+{ 'option': '--opt-arg-boxed', 'data': 'Base', 'boxed': true , 'help': null }
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.out
index f609c5d5f5..bb4ffa0918 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -1,3 +1,20 @@
+option --help None
+    short=h
+    boxed=False
+    help=
+
+option --opt-arg-boxed Base
+    boxed=True
+    help=
+
+option --opt-arg-str str
+    boxed=False
+    help=
+
+option --opt-arg-struct q_obj_opt-arg-struct-optarg
+    boxed=False
+    help=
+
 object Base
     member base1: Enum optional=False
 enum Enum ['one', 'two']
@@ -6,6 +23,15 @@ object Object
     tag base1
     case one: Variant1
     case two: Variant2
+object QAPIOption
+    member type: QAPIOptionKind optional=False
+    member idx: int32 optional=False
+    member cnt: int32 optional=False
+    tag type
+    case opt-arg-boxed: Base
+    case opt-arg-str: q_obj_str-wrapper
+    case opt-arg-struct: q_obj_opt-arg-struct-optarg
+enum QAPIOptionKind ['help', 'opt-arg-boxed', 'opt-arg-str', 'opt-arg-struct']
 object SugaredUnion
     member type: SugaredUnionKind optional=False
     tag type
@@ -27,6 +53,9 @@ object q_obj_cmd-arg
     member arg1: int optional=False
     member arg2: str optional=True
     member arg3: bool optional=False
+object q_obj_opt-arg-struct-optarg
+    member s: str optional=False
+    member i: int optional=True
 doc freeform
     body=
 = Section
@@ -161,3 +190,19 @@ If you're bored enough to read this, go see a video of boxed cats
 -> in
 
 <- out
+doc symbol=--help
+    body=
+Display help and exit.
+doc symbol=--opt-arg-str
+    body=
+TODO support documenting simple option argument
+doc symbol=--opt-arg-struct
+    body=
+
+    arg=s
+a string
+    arg=i
+an integer
+doc symbol=--opt-arg-boxed
+    body=
+
diff --git a/tests/qapi-schema/doc-good.texi b/tests/qapi-schema/doc-good.texi
index 4a9162c2a2..fd46358008 100644
--- a/tests/qapi-schema/doc-good.texi
+++ b/tests/qapi-schema/doc-good.texi
@@ -241,3 +241,48 @@ If you're bored enough to read this, go see a video of boxed cats
 @end deftypefn
 
 
+
+
+@deftypefn Option {} --help
+
+Display help and exit.
+
+@end deftypefn
+
+
+
+
+@deftypefn Option {} --opt-arg-str
+
+TODO support documenting simple option argument
+
+@end deftypefn
+
+
+
+
+@deftypefn Option {} --opt-arg-struct
+
+
+
+@b{Arguments:}
+@table @asis
+@item @code{s: string}
+a string
+@item @code{i: int} (optional)
+an integer
+@end table
+
+@end deftypefn
+
+
+
+
+@deftypefn Option {} --opt-arg-boxed
+
+
+
+@b{Arguments:} the members of @code{Base}
+@end deftypefn
+
+
-- 
2.13.6
