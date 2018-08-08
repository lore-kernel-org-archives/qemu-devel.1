Received: from eggs.gnu.org ([2001:4830:134:3::10]:35420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fnNka-0004Vx-Bb
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:39:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fnNkX-0006rs-N3
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:39:40 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:44737)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fnNkX-0006q9-Eo
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:39:37 -0400
Received: by mail-wr1-x42e.google.com with SMTP id r16-v6so1865389wrt.11
	for <qemu-devel@nongnu.org>; Wed, 08 Aug 2018 05:39:37 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed,  8 Aug 2018 13:39:31 +0100
Message-Id: <20180808123934.17450-2-alex.bennee@linaro.org>
In-Reply-To: <20180808123934.17450-1-alex.bennee@linaro.org>
References: <20180808123934.17450-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 1/4] scripts/decodetree.py: add a
 disassembly generator (HACK!)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, richard.henderson@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>

Given our issues with failing disassembly we could try and re-use the
decode tree data to output what instruction is being decoded. This
will be used if registered as a fall-back for when the "proper"
disassembler fails to decode an instruction.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 scripts/decodetree.py | 52 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 46 insertions(+), 6 deletions(-)

diff --git a/scripts/decodetree.py b/scripts/decodetree.py
index 277f9a9bba..f4b4318c96 100755
--- a/scripts/decodetree.py
+++ b/scripts/decodetree.py
@@ -169,6 +169,7 @@ input_file = ''
 output_file = None
 output_fd = None
 insntype = 'uint32_t'
+disassemble = False
 
 re_ident = '[a-zA-Z][a-zA-Z0-9_]*'
 
@@ -467,6 +468,7 @@ class Pattern(General):
 
     def output_code(self, i, extracted, outerbits, outermask):
         global translate_prefix
+        global disassemble
         ind = str_indent(i)
         arg = self.base.base.name
         output(ind, '/* line ', str(self.lineno), ' */\n')
@@ -474,8 +476,34 @@ class Pattern(General):
             output(ind, self.base.extract_name(), '(&u.f_', arg, ', insn);\n')
         for n, f in self.fields.items():
             output(ind, 'u.f_', arg, '.', n, ' = ', f.str_extract(), ';\n')
-        output(ind, 'return ', translate_prefix, '_', self.name,
-               '(ctx, &u.f_', arg, ', insn);\n')
+        output(ind, 'return ', translate_prefix, '_', self.name)
+        if disassemble:
+            output("(dstr, maxd, ")
+        else:
+            output("(ctx, ")
+
+        output('&u.f_', arg)
+
+        if disassemble:
+            output(");\n")
+        else:
+            output(', insn);\n')
+
+    def output_formatter(self):
+        global translate_prefix
+        arg = self.base.base.name
+        output('/* line ', str(self.lineno), ' */\n')
+        output('typedef ', self.base.base.struct_name(),
+               ' arg_', self.name, ';\n')
+        output(translate_scope, 'bool ', translate_prefix, '_', self.name,
+               '(char *ptr, size_t n, arg_', self.name, ' *a)\n')
+        output("{\n")
+        output(str_indent(4), 'snprintf(ptr, n, "', self.name)
+        # fill in arguments here
+        output('"); \n')
+        output(str_indent(4), "return true;\n")
+        output("}\n")
+
 # end Pattern
 
 
@@ -973,11 +1001,12 @@ def main():
     global insnwidth
     global insntype
     global insnmask
+    global disassemble
 
     decode_function = 'decode'
     decode_scope = 'static '
 
-    long_opts = ['decode=', 'translate=', 'output=', 'insnwidth=']
+    long_opts = ['decode=', 'translate=', 'output=', 'insnwidth=', 'disassemble']
     try:
         (opts, args) = getopt.getopt(sys.argv[1:], 'o:w:', long_opts)
     except getopt.GetoptError as err:
@@ -998,6 +1027,8 @@ def main():
                 insnmask = 0xffff
             elif insnwidth != 32:
                 error(0, 'cannot handle insns of width', insnwidth)
+        elif o == '--disassemble':
+            disassemble = True
         else:
             assert False, 'unhandled option'
 
@@ -1031,7 +1062,10 @@ def main():
             if i.base.base != p.base.base:
                 error(0, i.name, ' has conflicting argument sets')
         else:
-            i.output_decl()
+            if disassemble:
+                i.output_formatter()
+            else:
+                i.output_decl()
             out_pats[i.name] = i
     output('\n')
 
@@ -1039,8 +1073,14 @@ def main():
         f = formats[n]
         f.output_extract()
 
-    output(decode_scope, 'bool ', decode_function,
-           '(DisasContext *ctx, ', insntype, ' insn)\n{\n')
+    output(decode_scope, 'bool ', decode_function)
+
+    if disassemble:
+        output("(char *dstr, size_t maxd, ")
+    else:
+        output('(DisasContext *ctx, ')
+
+    output(insntype, ' insn)\n{\n')
 
     i4 = str_indent(4)
     output(i4, 'union {\n')
-- 
2.17.1
