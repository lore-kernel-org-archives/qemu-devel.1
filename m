Received: from eggs.gnu.org ([2001:4830:134:3::10]:46841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gHpOn-00034H-93
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 08:15:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gHpOj-0002fV-5A
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 08:15:01 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:43413)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gHpOf-0002Ri-Gn
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 08:14:55 -0400
Received: by mail-wr1-x42f.google.com with SMTP id t10-v6so16213054wrn.10
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 05:14:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 31 Oct 2018 12:14:43 +0000
Message-Id: <20181031121443.605-4-richard.henderson@linaro.org>
In-Reply-To: <20181031121443.605-1-richard.henderson@linaro.org>
References: <20181031121443.605-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 3/3] decodetree: Allow multiple input files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kbastian@mail.uni-paderborn.de

While it would be possible to concatenate input files with make,
passing the original input files to decodetree.py allows us to
generate error messages which allows compilation environments
(read: emacs) to next-error to the correct input file.

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
