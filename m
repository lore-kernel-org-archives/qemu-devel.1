Received: from eggs.gnu.org ([2001:4830:134:3::10]:43755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gG6iH-0007ia-HB
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 14:20:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gG6iE-0000Iu-By
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 14:20:01 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41774)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gG6iD-0000H6-VH
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 14:19:58 -0400
Received: by mail-wr1-x443.google.com with SMTP id x12-v6so2254013wrw.8
	for <qemu-devel@nongnu.org>; Fri, 26 Oct 2018 11:19:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 26 Oct 2018 19:19:52 +0100
Message-Id: <20181026181952.8255-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH] decodetree: Allow multiple input files
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

Bastian, I think this makes splitting the decode file even nicer.
No temp file in the build tree, and better error messages.

The makefile fragment now becomes e.g.

target/riscv/decode_insn32.inc.c: $(decode32-y) $(DECODETREE)
        $(call quiet-command, \
          $(PYTHON) $(DECODETREE) -o $@ --decode decode_insn32 $(decode32-y), \
          "GEN", $(TARGET_DIR)$@)

Also, I think that the rv64g insns should be in insn32-64.decode,
mirroring insn16-64.decode, and leaving insn64.decode free for an
actual 64-bit instruction word, as aluded to in the "Extending RISC-V"
section of the manual.

I've included this with the other two pending decodetree patches at

  https://github.com/rth7680/qemu.git decodetree


r~

---
 scripts/decodetree.py | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/scripts/decodetree.py b/scripts/decodetree.py
index c0bb447095..f60f1b0ab6 100755
--- a/scripts/decodetree.py
+++ b/scripts/decodetree.py
@@ -177,15 +177,15 @@ decode_function = 'decode'
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
@@ -197,6 +197,8 @@ def error(lineno, *args):
         os.remove(output_file)
     exit(1)
 
+def error(lineno, *args):
+    error_with_file(input_file, lineno, args)
 
 def output(*args):
     global output_fd
@@ -422,6 +424,7 @@ class General:
     """Common code between instruction formats and instruction patterns"""
     def __init__(self, name, lineno, base, fixb, fixm, udfm, fldm, flds):
         self.name = name
+        self.file = input_file
         self.lineno = lineno
         self.base = base
         self.fixedbits = fixb
@@ -474,7 +477,7 @@ class Pattern(General):
         global translate_prefix
         ind = str_indent(i)
         arg = self.base.base.name
-        output(ind, '/* line ', str(self.lineno), ' */\n')
+        output(ind, '/* ', self.file, ':', str(self.lineno), ' */\n')
         if not extracted:
             output(ind, self.base.extract_name(), '(&u.f_', arg, ', insn);\n')
         for n, f in self.fields.items():
@@ -922,8 +925,9 @@ def build_tree(pats, outerbits, outermask):
     if innermask == 0:
         pnames = []
         for p in pats:
-            pnames.append(p.name + ':' + str(p.lineno))
-        error(pats[0].lineno, 'overlapping patterns:', pnames)
+            pnames.append(p.name + ':' + p.file + ':' + str(p.lineno))
+        error_with_file(pats[0].file, pats[0].lineno,
+                        'overlapping patterns:', pnames)
 
     fullmask = outermask | innermask
 
@@ -1014,10 +1018,11 @@ def main():
 
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
