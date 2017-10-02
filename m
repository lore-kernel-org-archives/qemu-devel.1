Received: from eggs.gnu.org ([2001:4830:134:3::10]:38877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz2bg-000817-63
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz2bZ-0007u1-Er
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41498)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dz2bZ-0007tR-5N
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:01 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  2 Oct 2017 17:25:31 +0200
Message-Id: <20171002152552.27999-12-armbru@redhat.com>
In-Reply-To: <20171002152552.27999-1-armbru@redhat.com>
References: <20171002152552.27999-1-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 11/32] qapi: Drop the options to generate
 only .c or .h
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

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi-commands.py   |  4 ++--
 scripts/qapi-event.py      |  4 ++--
 scripts/qapi-introspect.py |  4 ++--
 scripts/qapi-types.py      |  4 ++--
 scripts/qapi-visit.py      |  4 ++--
 scripts/qapi.py            | 25 ++++---------------------
 6 files changed, 14 insertions(+), 31 deletions(-)

diff --git a/scripts/qapi-commands.py b/scripts/qapi-commands.py
index 974d0a4a80..56a1009564 100644
--- a/scripts/qapi-commands.py
+++ b/scripts/qapi-commands.py
@@ -253,7 +253,7 @@ class QAPISchemaGenCommandVisitor(QAPISchemaVisitor):
         self._regy += gen_register_command(name, success_response)
 
 
-(input_file, output_dir, do_c, do_h, prefix, opts) = parse_command_line()
+(input_file, output_dir, prefix, opts) = parse_command_line()
 
 c_comment = '''
 /*
@@ -284,7 +284,7 @@ h_comment = '''
  */
 '''
 
-(fdef, fdecl) = open_output(output_dir, do_c, do_h, prefix,
+(fdef, fdecl) = open_output(output_dir, prefix,
                             'qmp-marshal.c', 'qmp-commands.h',
                             c_comment, h_comment)
 
diff --git a/scripts/qapi-event.py b/scripts/qapi-event.py
index 07b4b70199..0a308e6b69 100644
--- a/scripts/qapi-event.py
+++ b/scripts/qapi-event.py
@@ -169,7 +169,7 @@ class QAPISchemaGenEventVisitor(QAPISchemaVisitor):
         self._event_names.append(name)
 
 
-(input_file, output_dir, do_c, do_h, prefix, dummy) = parse_command_line()
+(input_file, output_dir, prefix, dummy) = parse_command_line()
 
 c_comment = '''
 /*
@@ -200,7 +200,7 @@ h_comment = '''
  */
 '''
 
-(fdef, fdecl) = open_output(output_dir, do_c, do_h, prefix,
+(fdef, fdecl) = open_output(output_dir, prefix,
                             'qapi-event.c', 'qapi-event.h',
                             c_comment, h_comment)
 
diff --git a/scripts/qapi-introspect.py b/scripts/qapi-introspect.py
index 032bcea491..c2e46182c8 100644
--- a/scripts/qapi-introspect.py
+++ b/scripts/qapi-introspect.py
@@ -169,7 +169,7 @@ const char %(c_name)s[] = %(c_string)s;
 # We normally mask them, because they're not QMP wire ABI
 opt_unmask = False
 
-(input_file, output_dir, do_c, do_h, prefix, opts) = \
+(input_file, output_dir, prefix, opts) = \
     parse_command_line('u', ['unmask-non-abi-names'])
 
 for o, a in opts:
@@ -199,7 +199,7 @@ h_comment = '''
  */
 '''
 
-(fdef, fdecl) = open_output(output_dir, do_c, do_h, prefix,
+(fdef, fdecl) = open_output(output_dir, prefix,
                             'qmp-introspect.c', 'qmp-introspect.h',
                             c_comment, h_comment)
 
diff --git a/scripts/qapi-types.py b/scripts/qapi-types.py
index 7e3051dbb9..dc7dd08512 100644
--- a/scripts/qapi-types.py
+++ b/scripts/qapi-types.py
@@ -243,7 +243,7 @@ class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
 # QAPISchemaGenTypeVisitor.visit_end().
 do_builtins = False
 
-(input_file, output_dir, do_c, do_h, prefix, opts) = \
+(input_file, output_dir, prefix, opts) = \
     parse_command_line('b', ['builtins'])
 
 for o, a in opts:
@@ -280,7 +280,7 @@ h_comment = '''
  */
 '''
 
-(fdef, fdecl) = open_output(output_dir, do_c, do_h, prefix,
+(fdef, fdecl) = open_output(output_dir, prefix,
                             'qapi-types.c', 'qapi-types.h',
                             c_comment, h_comment)
 
diff --git a/scripts/qapi-visit.py b/scripts/qapi-visit.py
index 7e1cfc13f0..9757911d2d 100644
--- a/scripts/qapi-visit.py
+++ b/scripts/qapi-visit.py
@@ -327,7 +327,7 @@ class QAPISchemaGenVisitVisitor(QAPISchemaVisitor):
 # QAPISchemaGenVisitVisitor.visit_end().
 do_builtins = False
 
-(input_file, output_dir, do_c, do_h, prefix, opts) = \
+(input_file, output_dir, prefix, opts) = \
     parse_command_line('b', ['builtins'])
 
 for o, a in opts:
@@ -363,7 +363,7 @@ h_comment = '''
  */
 '''
 
-(fdef, fdecl) = open_output(output_dir, do_c, do_h, prefix,
+(fdef, fdecl) = open_output(output_dir, prefix,
                             'qapi-visit.c', 'qapi-visit.h',
                             c_comment, h_comment)
 
diff --git a/scripts/qapi.py b/scripts/qapi.py
index 8f9c5666bd..5434987108 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -1931,8 +1931,6 @@ def parse_command_line(extra_options='', extra_long_options=[]):
 
     output_dir = ''
     prefix = ''
-    do_c = False
-    do_h = False
     extra_opts = []
 
     for oa in opts:
@@ -1947,30 +1945,22 @@ def parse_command_line(extra_options='', extra_long_options=[]):
             prefix = a
         elif o in ('-o', '--output-dir'):
             output_dir = a + '/'
-        elif o in ('-c', '--source'):
-            do_c = True
-        elif o in ('-h', '--header'):
-            do_h = True
         else:
             extra_opts.append(oa)
 
-    if not do_c and not do_h:
-        do_c = True
-        do_h = True
-
     if len(args) != 1:
         print >>sys.stderr, "%s: need exactly one argument" % sys.argv[0]
         sys.exit(1)
     fname = args[0]
 
-    return (fname, output_dir, do_c, do_h, prefix, extra_opts)
+    return (fname, output_dir, prefix, extra_opts)
 
 #
 # Generate output files with boilerplate
 #
 
 
-def open_output(output_dir, do_c, do_h, prefix, c_file, h_file,
+def open_output(output_dir, prefix, c_file, h_file,
                 c_comment, h_comment):
     guard = guardname(prefix + h_file)
     c_file = output_dir + prefix + c_file
@@ -1983,15 +1973,8 @@ def open_output(output_dir, do_c, do_h, prefix, c_file, h_file,
             if e.errno != errno.EEXIST:
                 raise
 
-    def maybe_open(really, name, opt):
-        if really:
-            return open(name, opt)
-        else:
-            import StringIO
-            return StringIO.StringIO()
-
-    fdef = maybe_open(do_c, c_file, 'w')
-    fdecl = maybe_open(do_h, h_file, 'w')
+    fdef = open(c_file, 'w')
+    fdecl = open(h_file, 'w')
 
     fdef.write(mcgen('''
 /* AUTOMATICALLY GENERATED, DO NOT MODIFY */
-- 
2.13.6
