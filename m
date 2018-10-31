Received: from eggs.gnu.org ([2001:4830:134:3::10]:56327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gHtkY-0005Xz-8a
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:53:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gHtkV-0008Oo-Jt
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:53:46 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:51838)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gHtkV-0008FD-6U
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:53:43 -0400
Received: by mail-wm1-x32e.google.com with SMTP id w7-v6so4784125wmc.1
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 09:53:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 31 Oct 2018 16:53:21 +0000
Message-Id: <20181031165321.4422-4-richard.henderson@linaro.org>
In-Reply-To: <20181031165321.4422-1-richard.henderson@linaro.org>
References: <20181031165321.4422-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 3/3] decodetree: Allow multiple input files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

While it would be possible to concatenate input files with make,
passing the original input files to decodetree.py allows us to
generate error messages which allows compilation environments
(read: emacs) to next-error to the correct input file.

Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 scripts/decodetree.py | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/scripts/decodetree.py b/scripts/decodetree.py
index 6670d58cc1..4a3d46e4a7 100755
--- a/scripts/decodetree.py
+++ b/scripts/decodetree.py
@@ -175,15 +175,15 @@ decode_function = 'decode'
 re_ident = '[a-zA-Z][a-zA-Z0-9_]*'
 
 
-def error(lineno, *args):
+def error_with_file(file, lineno, *args):
     """Print an error message from file:line and args and exit."""
     global output_file
     global output_fd
 
     if lineno:
-        r = '{0}:{1}: error:'.format(input_file, lineno)
+        r = '{0}:{1}: error:'.format(file, lineno)
     elif input_file:
-        r = '{0}: error:'.format(input_file)
+        r = '{0}: error:'.format(file)
     else:
         r = 'error:'
     for a in args:
@@ -195,6 +195,8 @@ def error(lineno, *args):
         os.remove(output_file)
     exit(1)
 
+def error(lineno, *args):
+    error_with_file(input_file, lineno, args)
 
 def output(*args):
     global output_fd
@@ -420,6 +422,7 @@ class General:
     """Common code between instruction formats and instruction patterns"""
     def __init__(self, name, lineno, base, fixb, fixm, udfm, fldm, flds):
         self.name = name
+        self.file = input_file
         self.lineno = lineno
         self.base = base
         self.fixedbits = fixb
@@ -472,7 +475,7 @@ class Pattern(General):
         global translate_prefix
         ind = str_indent(i)
         arg = self.base.base.name
-        output(ind, '/* line ', str(self.lineno), ' */\n')
+        output(ind, '/* ', self.file, ':', str(self.lineno), ' */\n')
         if not extracted:
             output(ind, self.base.extract_name(), '(&u.f_', arg, ', insn);\n')
         for n, f in self.fields.items():
@@ -920,8 +923,9 @@ def build_tree(pats, outerbits, outermask):
     if innermask == 0:
         pnames = []
         for p in pats:
-            pnames.append(p.name + ':' + str(p.lineno))
-        error(pats[0].lineno, 'overlapping patterns:', pnames)
+            pnames.append(p.name + ':' + p.file + ':' + str(p.lineno))
+        error_with_file(pats[0].file, pats[0].lineno,
+                        'overlapping patterns:', pnames)
 
     fullmask = outermask | innermask
 
@@ -1012,10 +1016,11 @@ def main():
 
     if len(args) < 1:
         error(0, 'missing input file')
-    input_file = args[0]
-    f = open(input_file, 'r')
-    parse_file(f)
-    f.close()
+    for filename in args:
+        input_file = filename
+        f = open(filename, 'r')
+        parse_file(f)
+        f.close()
 
     t = build_tree(patterns, 0, 0)
     prop_format(t)
-- 
2.17.2
