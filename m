Received: from eggs.gnu.org ([209.51.188.92]:58057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ysato@users.sourceforge.jp>) id 1gzyJa-00042S-Dc
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 01:40:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ysato@users.sourceforge.jp>) id 1gzyJS-0004Yc-LZ
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 01:40:02 -0500
Received: from mail03.asahi-net.or.jp ([202.224.55.15]:38393)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ysato@users.sourceforge.jp>) id 1gzyJI-0004LH-2x
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 01:39:49 -0500
From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Sat,  2 Mar 2019 15:39:26 +0900
Message-Id: <20190302063926.11488-1-ysato@users.sourceforge.jp>
In-Reply-To: <20190131210851.9842-1-richard.henderson@linaro.org>
References: <20190131210851.9842-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH] decodetree: Add DisasContext to function part
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>

OK. RX decoder works fine.

Since it is necessary to read additional bytes in the function
of the operand, we need to have DisasContext passed as an argument.

> %b2_li_2	18:2 !function=li
"li" read more extra byte. It use cpu_env in DisasContext.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 scripts/decodetree.py | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/scripts/decodetree.py b/scripts/decodetree.py
index e23d43e354..fa9a75ccad 100755
--- a/scripts/decodetree.py
+++ b/scripts/decodetree.py
@@ -387,7 +387,11 @@ class FunctionField:
         return self.func + '(' + str(self.base) + ')'
 
     def str_extract(self):
-        return self.func + '(' + self.base.str_extract() + ')'
+        if variablewidth:
+            ctx = 'ctx, '
+        else:
+            ctx = ''
+        return self.func + '(' + ctx + self.base.str_extract() + ')'
 
     def __eq__(self, other):
         return self.func == other.func and self.base == other.base
@@ -454,7 +458,11 @@ class Format(General):
         return 'extract_' + self.name
 
     def output_extract(self):
-        output('static void ', self.extract_name(), '(',
+        if variablewidth:
+            ctx_p = 'DisasContext *ctx, '
+        else:
+            ctx_p = ''
+        output('static void ', self.extract_name(), '(' + ctx_p,
                self.base.struct_name(), ' *a, ', insntype, ' insn)\n{\n')
         for n, f in self.fields.items():
             output('    a->', n, ' = ', f.str_extract(), ';\n')
@@ -468,10 +476,14 @@ class Pattern(General):
     def output_decl(self):
         global translate_scope
         global translate_prefix
+        if variablewidth:
+            ctx_p = 'DisasContext *ctx, '
+        else:
+            ctx_p = ''
         output('typedef ', self.base.base.struct_name(),
                ' arg_', self.name, ';\n')
         output(translate_scope, 'bool ', translate_prefix, '_', self.name,
-               '(DisasContext *ctx, arg_', self.name, ' *a);\n')
+               '(', ctx_p, 'arg_', self.name, ' *a);\n')
 
     def output_code(self, i, extracted, outerbits, outermask):
         global translate_prefix
@@ -479,7 +491,8 @@ class Pattern(General):
         arg = self.base.base.name
         output(ind, '/* ', self.file, ':', str(self.lineno), ' */\n')
         if not extracted:
-            output(ind, self.base.extract_name(), '(&u.f_', arg, ', insn);\n')
+            output(ind, self.base.extract_name(),
+                   '(ctx, &u.f_', arg, ', insn);\n')
         for n, f in self.fields.items():
             output(ind, 'u.f_', arg, '.', n, ' = ', f.str_extract(), ';\n')
         output(ind, 'return ', translate_prefix, '_', self.name,
@@ -890,11 +903,16 @@ class Tree:
     def output_code(self, i, extracted, outerbits, outermask):
         ind = str_indent(i)
 
+        if variablewidth:
+            ctx = 'ctx, '
+        else:
+            ctx = ''
         # If we identified all nodes below have the same format,
         # extract the fields now.
         if not extracted and self.base:
             output(ind, self.base.extract_name(),
-                   '(&u.f_', self.base.base.name, ', insn);\n')
+                   '(', ctx, '&u.f_', self.base.base.name,
+                   ', insn);\n')
             extracted = True
 
         # Attempt to aid the compiler in producing compact switch statements.
@@ -994,7 +1012,7 @@ class SizeTree:
         # If we need to load more bytes to test, do so now.
         if extracted < self.width:
             output(ind, 'insn = ', decode_function,
-                   '_load_bytes(s, insn, {0}, {1});\n'
+                   '_load_bytes(ctx, insn, {0}, {1});\n'
                    .format(extracted / 8, self.width / 8));
             extracted = self.width
 
@@ -1048,7 +1066,7 @@ class SizeLeaf:
         # If we need to load more bytes, do so now.
         if extracted < self.width:
             output(ind, 'insn = ', decode_function,
-                   '_load_bytes(s, insn, {0}, {1});\n'
+                   '_load_bytes(ctx, insn, {0}, {1});\n'
                    .format(extracted / 8, self.width / 8));
             extracted = self.width
         output(ind, 'return insn;\n')
-- 
2.11.0
