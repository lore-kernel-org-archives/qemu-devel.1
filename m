Received: from eggs.gnu.org ([208.118.235.92]:55980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehdMe-0002k9-CO
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:36:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehdLV-0004dr-KC
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:34:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58932)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ehdLU-0004cB-VR
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:33:45 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  2 Feb 2018 14:03:16 +0100
Message-Id: <20180202130336.24719-2-armbru@redhat.com>
In-Reply-To: <20180202130336.24719-1-armbru@redhat.com>
References: <20180202130336.24719-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 01/21] qapi: Streamline boilerplate comment
 generation
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

Every generator has separate boilerplate for .h and .c, and their
differences are boring.  All of them repeat the license note.

Reduce the repetition as follows.  Move common text like the license
note to common open_output(), next to the existintg common text there.
For each generator, replace the two separate descriptions by a single
one.

While there, emit an "automatically generated" note into generated
documentation, too.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi-commands.py        | 26 +++-----------------------
 scripts/qapi-event.py           | 26 +++-----------------------
 scripts/qapi-introspect.py      | 21 ++-------------------
 scripts/qapi-types.py           | 26 +++-----------------------
 scripts/qapi-visit.py           | 26 +++-----------------------
 scripts/qapi.py                 | 31 ++++++++++++++++++-------------
 scripts/qapi2texi.py            |  3 ++-
 tests/qapi-schema/doc-good.texi |  3 ++-
 8 files changed, 36 insertions(+), 126 deletions(-)

diff --git a/scripts/qapi-commands.py b/scripts/qapi-commands.py
index 26c56c5062..25ac52503a 100644
--- a/scripts/qapi-commands.py
+++ b/scripts/qapi-commands.py
@@ -255,38 +255,18 @@ class QAPISchemaGenCommandVisitor(QAPISchemaVisitor):
 
 (input_file, output_dir, do_c, do_h, prefix, opts) = parse_command_line()
 
-c_comment = '''
-/*
- * schema-defined QMP->QAPI command dispatch
+blurb = '''
+ * Schema-defined QAPI/QMP commands
  *
  * Copyright IBM, Corp. 2011
  *
  * Authors:
  *  Anthony Liguori   <aliguori@us.ibm.com>
- *
- * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
- * See the COPYING.LIB file in the top-level directory.
- *
- */
-'''
-h_comment = '''
-/*
- * schema-defined QAPI function prototypes
- *
- * Copyright IBM, Corp. 2011
- *
- * Authors:
- *  Anthony Liguori   <aliguori@us.ibm.com>
- *
- * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
- * See the COPYING.LIB file in the top-level directory.
- *
- */
 '''
 
 (fdef, fdecl) = open_output(output_dir, do_c, do_h, prefix,
                             'qmp-marshal.c', 'qmp-commands.h',
-                            c_comment, h_comment)
+                            blurb)
 
 fdef.write(mcgen('''
 
diff --git a/scripts/qapi-event.py b/scripts/qapi-event.py
index 9d7134658d..31faedc689 100644
--- a/scripts/qapi-event.py
+++ b/scripts/qapi-event.py
@@ -171,38 +171,18 @@ class QAPISchemaGenEventVisitor(QAPISchemaVisitor):
 
 (input_file, output_dir, do_c, do_h, prefix, dummy) = parse_command_line()
 
-c_comment = '''
-/*
- * schema-defined QAPI event functions
+blurb = '''
+ * Schema-defined QAPI/QMP events
  *
  * Copyright (c) 2014 Wenchao Xia
  *
  * Authors:
  *  Wenchao Xia   <wenchaoqemu@gmail.com>
- *
- * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
- * See the COPYING.LIB file in the top-level directory.
- *
- */
-'''
-h_comment = '''
-/*
- * schema-defined QAPI event functions
- *
- * Copyright (c) 2014 Wenchao Xia
- *
- * Authors:
- *  Wenchao Xia  <wenchaoqemu@gmail.com>
- *
- * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
- * See the COPYING.LIB file in the top-level directory.
- *
- */
 '''
 
 (fdef, fdecl) = open_output(output_dir, do_c, do_h, prefix,
                             'qapi-event.c', 'qapi-event.h',
-                            c_comment, h_comment)
+                            blurb)
 
 fdef.write(mcgen('''
 #include "qemu/osdep.h"
diff --git a/scripts/qapi-introspect.py b/scripts/qapi-introspect.py
index 032bcea491..83da2bdb94 100644
--- a/scripts/qapi-introspect.py
+++ b/scripts/qapi-introspect.py
@@ -176,32 +176,15 @@ for o, a in opts:
     if o in ('-u', '--unmask-non-abi-names'):
         opt_unmask = True
 
-c_comment = '''
-/*
+blurb = '''
  * QAPI/QMP schema introspection
  *
  * Copyright (C) 2015 Red Hat, Inc.
- *
- * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
- * See the COPYING.LIB file in the top-level directory.
- *
- */
-'''
-h_comment = '''
-/*
- * QAPI/QMP schema introspection
- *
- * Copyright (C) 2015 Red Hat, Inc.
- *
- * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
- * See the COPYING.LIB file in the top-level directory.
- *
- */
 '''
 
 (fdef, fdecl) = open_output(output_dir, do_c, do_h, prefix,
                             'qmp-introspect.c', 'qmp-introspect.h',
-                            c_comment, h_comment)
+                            blurb)
 
 fdef.write(mcgen('''
 #include "qemu/osdep.h"
diff --git a/scripts/qapi-types.py b/scripts/qapi-types.py
index 7e3051dbb9..86afc57f92 100644
--- a/scripts/qapi-types.py
+++ b/scripts/qapi-types.py
@@ -250,39 +250,19 @@ for o, a in opts:
     if o in ('-b', '--builtins'):
         do_builtins = True
 
-c_comment = '''
-/*
- * deallocation functions for schema-defined QAPI types
+blurb = '''
+ * Schema-defined QAPI types
  *
  * Copyright IBM, Corp. 2011
  *
  * Authors:
  *  Anthony Liguori   <aliguori@us.ibm.com>
  *  Michael Roth      <mdroth@linux.vnet.ibm.com>
- *
- * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
- * See the COPYING.LIB file in the top-level directory.
- *
- */
-'''
-h_comment = '''
-/*
- * schema-defined QAPI types
- *
- * Copyright IBM, Corp. 2011
- *
- * Authors:
- *  Anthony Liguori   <aliguori@us.ibm.com>
- *
- * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
- * See the COPYING.LIB file in the top-level directory.
- *
- */
 '''
 
 (fdef, fdecl) = open_output(output_dir, do_c, do_h, prefix,
                             'qapi-types.c', 'qapi-types.h',
-                            c_comment, h_comment)
+                            blurb)
 
 fdef.write(mcgen('''
 #include "qemu/osdep.h"
diff --git a/scripts/qapi-visit.py b/scripts/qapi-visit.py
index 7e1cfc13f0..9f7127e548 100644
--- a/scripts/qapi-visit.py
+++ b/scripts/qapi-visit.py
@@ -334,38 +334,18 @@ for o, a in opts:
     if o in ('-b', '--builtins'):
         do_builtins = True
 
-c_comment = '''
-/*
- * schema-defined QAPI visitor functions
+blurb = '''
+ * Schema-defined QAPI visitors
  *
  * Copyright IBM, Corp. 2011
  *
  * Authors:
  *  Anthony Liguori   <aliguori@us.ibm.com>
- *
- * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
- * See the COPYING.LIB file in the top-level directory.
- *
- */
-'''
-h_comment = '''
-/*
- * schema-defined QAPI visitor functions
- *
- * Copyright IBM, Corp. 2011
- *
- * Authors:
- *  Anthony Liguori   <aliguori@us.ibm.com>
- *
- * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
- * See the COPYING.LIB file in the top-level directory.
- *
- */
 '''
 
 (fdef, fdecl) = open_output(output_dir, do_c, do_h, prefix,
                             'qapi-visit.c', 'qapi-visit.h',
-                            c_comment, h_comment)
+                            blurb)
 
 fdef.write(mcgen('''
 #include "qemu/osdep.h"
diff --git a/scripts/qapi.py b/scripts/qapi.py
index 43a54bf40f..2e4b2bc9eb 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -1975,11 +1975,21 @@ def parse_command_line(extra_options='', extra_long_options=[]):
 #
 
 
-def open_output(output_dir, do_c, do_h, prefix, c_file, h_file,
-                c_comment, h_comment):
+def open_output(output_dir, do_c, do_h, prefix, c_file, h_file, blurb):
     guard = guardname(prefix + h_file)
     c_file = output_dir + prefix + c_file
     h_file = output_dir + prefix + h_file
+    comment = mcgen('''/* AUTOMATICALLY GENERATED, DO NOT MODIFY */
+
+/*
+%(blurb)s
+ *
+ * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
+ * See the COPYING.LIB file in the top-level directory.
+ */
+
+''',
+                    blurb=blurb.strip('\n'))
 
     if output_dir:
         try:
@@ -1998,27 +2008,22 @@ def open_output(output_dir, do_c, do_h, prefix, c_file, h_file,
     fdef = maybe_open(do_c, c_file, 'w')
     fdecl = maybe_open(do_h, h_file, 'w')
 
-    fdef.write(mcgen('''
-/* AUTOMATICALLY GENERATED, DO NOT MODIFY */
-%(comment)s
-''',
-                     comment=c_comment))
-
+    fdef.write(comment)
+    fdecl.write(comment)
     fdecl.write(mcgen('''
-/* AUTOMATICALLY GENERATED, DO NOT MODIFY */
-%(comment)s
 #ifndef %(guard)s
 #define %(guard)s
 
 ''',
-                      comment=h_comment, guard=guard))
+                      guard=guard))
 
     return (fdef, fdecl)
 
 
 def close_output(fdef, fdecl):
-    fdecl.write('''
+    fdecl.write(mcgen('''
+
 #endif
-''')
+'''))
     fdecl.close()
     fdef.close()
diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
index 92e2af2cd6..924b374cd3 100755
--- a/scripts/qapi2texi.py
+++ b/scripts/qapi2texi.py
@@ -282,7 +282,8 @@ def main(argv):
         print >>sys.stderr, ("%s: need pragma 'doc-required' "
                              "to generate documentation" % argv[0])
         sys.exit(1)
-    print texi_schema(schema)
+    print '@c AUTOMATICALLY GENERATED, DO NOT MODIFY\n'
+    print texi_schema(schema),
 
 
 if __name__ == '__main__':
diff --git a/tests/qapi-schema/doc-good.texi b/tests/qapi-schema/doc-good.texi
index 1778312581..0aed2300a5 100644
--- a/tests/qapi-schema/doc-good.texi
+++ b/tests/qapi-schema/doc-good.texi
@@ -1,3 +1,5 @@
+@c AUTOMATICALLY GENERATED, DO NOT MODIFY
+
 @section Section
 
 @subsection Subsection
@@ -231,4 +233,3 @@ If you're bored enough to read this, go see a video of boxed cats
 
 @end deftypefn
 
-
-- 
2.13.6
