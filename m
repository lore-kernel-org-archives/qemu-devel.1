Received: from eggs.gnu.org ([209.51.188.92]:36717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1yC3-0001Jd-EG
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:56:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1yC1-0002RX-Jm
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:56:35 -0500
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536]:46591)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1h1yC1-0002QW-9E
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:56:33 -0500
Received: by mail-pg1-x536.google.com with SMTP id 196so11977817pgf.13
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 10:56:33 -0800 (PST)
Received: from cloudburst.twiddle.net (97-113-188-82.tukw.qwest.net.
	[97.113.188.82]) by smtp.gmail.com with ESMTPSA id
	g12sm8801973pgr.76.2019.03.07.10.56.30 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 07 Mar 2019 10:56:31 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  7 Mar 2019 10:56:16 -0800
Message-Id: <20190307185622.29026-7-richard.henderson@linaro.org>
In-Reply-To: <20190307185622.29026-1-richard.henderson@linaro.org>
References: <20190307185622.29026-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 06/12] decodetree: Allow grouping of
 overlapping patterns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 docs/devel/decodetree.rst                     |  58 +++++++
 scripts/decodetree.py                         | 162 +++++++++++++++---
 .../decode/err_pattern_group_overlap1.decode  |   6 +
 3 files changed, 204 insertions(+), 22 deletions(-)
 create mode 100644 tests/decode/err_pattern_group_overlap1.decode

diff --git a/docs/devel/decodetree.rst b/docs/devel/decodetree.rst
index 62cb7f687c..44ac621ea8 100644
--- a/docs/devel/decodetree.rst
+++ b/docs/devel/decodetree.rst
@@ -161,3 +161,61 @@ which will, in part, invoke::
 and::
 
   trans_addl_i(ctx, &arg_opi, insn)
+
+Pattern Groups
+==============
+
+Syntax::
+
+  group    := '{' ( pat_def | group )+ '}'
+
+A *group* begins with a lone open-brace, with all subsequent lines
+indented two spaces, and ending with a lone close-brace.  Groups
+may be nested, increasing the required indentation of the lines
+within the nested group to two spaces per nesting level.
+
+Unlike ungrouped patterns, grouped patterns are allowed to overlap.
+Conflicts are resolved by selecting the patterns in order.  If all
+of the fixedbits for a pattern match, its translate function will
+be called.  If the translate function returns false, then subsequent
+patterns within the group will be matched.
+
+The following example from PA-RISC shows specialization of the *or*
+instruction::
+
+  {
+    {
+      nop   000010 ----- ----- 0000 001001 0 00000
+      copy  000010 00000 r1:5  0000 001001 0 rt:5
+    }
+    or      000010 rt2:5 r1:5  cf:4 001001 0 rt:5
+  }
+
+When the *cf* field is zero, the instruction has no side effects,
+and may be specialized.  When the *rt* field is zero, the output
+is discarded and so the instruction has no effect.  When the *rt2*
+field is zero, the operation is ``reg[rt] | 0`` and so encodes
+the canonical register copy operation.
+
+The output from the generator might look like::
+
+  switch (insn & 0xfc000fe0) {
+  case 0x08000240:
+    /* 000010.. ........ ....0010 010..... */
+    if ((insn & 0x0000f000) == 0x00000000) {
+        /* 000010.. ........ 00000010 010..... */
+        if ((insn & 0x0000001f) == 0x00000000) {
+            /* 000010.. ........ 00000010 01000000 */
+            extract_decode_Fmt_0(&u.f_decode0, insn);
+            if (trans_nop(ctx, &u.f_decode0)) return true;
+        }
+        if ((insn & 0x03e00000) == 0x00000000) {
+            /* 00001000 000..... 00000010 010..... */
+            extract_decode_Fmt_1(&u.f_decode1, insn);
+            if (trans_copy(ctx, &u.f_decode1)) return true;
+        }
+    }
+    extract_decode_Fmt_2(&u.f_decode2, insn);
+    if (trans_or(ctx, &u.f_decode2)) return true;
+    return false;
+  }
diff --git a/scripts/decodetree.py b/scripts/decodetree.py
index cc5fa1a8ab..c4e8cb52f7 100755
--- a/scripts/decodetree.py
+++ b/scripts/decodetree.py
@@ -31,6 +31,7 @@ fields = {}
 arguments = {}
 formats = {}
 patterns = []
+allpatterns = []
 
 translate_prefix = 'trans'
 translate_scope = 'static '
@@ -300,13 +301,7 @@ class General:
         self.fields = flds
 
     def __str__(self):
-        r = self.name
-        if self.base:
-            r = r + ' ' + self.base.name
-        else:
-            r = r + ' ' + str(self.fields)
-        r = r + ' ' + str_match_bits(self.fixedbits, self.fixedmask)
-        return r
+        return self.name + ' ' + str_match_bits(self.fixedbits, self.fixedmask)
 
     def str1(self, i):
         return str_indent(i) + self.__str__()
@@ -353,6 +348,47 @@ class Pattern(General):
 # end Pattern
 
 
+class MultiPattern(General):
+    """Class representing an overlapping set of instruction patterns"""
+
+    def __init__(self, lineno, pats, fixb, fixm, udfm):
+        self.file = input_file
+        self.lineno = lineno
+        self.pats = pats
+        self.base = None
+        self.fixedbits = fixb
+        self.fixedmask = fixm
+        self.undefmask = udfm
+
+    def __str__(self):
+        r = "{"
+        for p in self.pats:
+           r = r + ' ' + str(p)
+        return r + "}"
+
+    def output_decl(self):
+        for p in self.pats:
+            p.output_decl()
+
+    def output_code(self, i, extracted, outerbits, outermask):
+        global translate_prefix
+        ind = str_indent(i)
+        for p in self.pats:
+            if outermask != p.fixedmask:
+                innermask = p.fixedmask & ~outermask
+                innerbits = p.fixedbits & ~outermask
+                output(ind, 'if ((insn & ',
+                       '0x{0:08x}) == 0x{1:08x}'.format(innermask, innerbits),
+                       ') {\n')
+                output(ind, '    /* ',
+                       str_match_bits(p.fixedbits, p.fixedmask), ' */\n')
+                p.output_code(i + 4, extracted, p.fixedbits, p.fixedmask)
+                output(ind, '}\n')
+            else:
+                p.output_code(i, extracted, p.fixedbits, p.fixedmask)
+#end MultiPattern
+
+
 def parse_field(lineno, name, toks):
     """Parse one instruction field from TOKS at LINENO"""
     global fields
@@ -505,6 +541,7 @@ def parse_generic(lineno, is_format, name, toks):
     global arguments
     global formats
     global patterns
+    global allpatterns
     global re_ident
     global insnwidth
     global insnmask
@@ -649,6 +686,7 @@ def parse_generic(lineno, is_format, name, toks):
         pat = Pattern(name, lineno, fmt, fixedbits, fixedmask,
                       undefmask, fieldmask, flds)
         patterns.append(pat)
+        allpatterns.append(pat)
 
     # Validate the masks that we have assembled.
     if fieldmask & fixedmask:
@@ -667,17 +705,63 @@ def parse_generic(lineno, is_format, name, toks):
                           .format(allbits ^ insnmask))
 # end parse_general
 
+def build_multi_pattern(lineno, pats):
+    """Validate the Patterns going into a MultiPattern."""
+    global patterns
+    global insnmask
+
+    if len(pats) < 2:
+        error(lineno, 'less than two patterns within braces')
+
+    fixedmask = insnmask
+    undefmask = insnmask
+
+    # Collect fixed/undefmask for all of the children.
+    # Move the defining lineno back to that of the first child.
+    for p in pats:
+        fixedmask &= p.fixedmask
+        undefmask &= p.undefmask
+        if p.lineno < lineno:
+            lineno = p.lineno
+
+    if fixedmask == 0:
+        error(lineno, 'no overlap in patterns within braces')
+
+    fixedbits = None
+    for p in pats:
+        thisbits = p.fixedbits & fixedmask
+        if fixedbits is None:
+            fixedbits = thisbits
+        elif fixedbits != thisbits:
+            error(p.lineno, 'fixedbits mismatch within braces',
+                  '(0x{0:08x} != 0x{1:08x})'.format(thisbits, fixedbits))
+
+    mp = MultiPattern(lineno, pats, fixedbits, fixedmask, undefmask)
+    patterns.append(mp)
+# end build_multi_pattern
 
 def parse_file(f):
     """Parse all of the patterns within a file"""
 
+    global patterns
+
     # Read all of the lines of the file.  Concatenate lines
     # ending in backslash; discard empty lines and comments.
     toks = []
     lineno = 0
+    nesting = 0
+    saved_pats = []
+
     for line in f:
         lineno += 1
 
+        # Expand and strip spaces, to find indent.
+        line = line.rstrip()
+        line = line.expandtabs()
+        len1 = len(line)
+        line = line.lstrip()
+        len2 = len(line)
+
         # Discard comments
         end = line.find('#')
         if end >= 0:
@@ -687,10 +771,18 @@ def parse_file(f):
         if len(toks) != 0:
             # Next line after continuation
             toks.extend(t)
-        elif len(t) == 0:
-            # Empty line
-            continue
         else:
+            # Allow completely blank lines.
+            if len1 == 0:
+                continue
+            indent = len1 - len2
+            # Empty line due to comment.
+            if len(t) == 0:
+                # Indentation must be correct, even for comment lines.
+                if indent != nesting:
+                    error(lineno, 'indentation ', indent, ' != ', nesting)
+                continue
+            start_lineno = lineno
             toks = t
 
         # Continuation?
@@ -698,21 +790,47 @@ def parse_file(f):
             toks.pop()
             continue
 
-        if len(toks) < 2:
-            error(lineno, 'short line')
-
         name = toks[0]
         del toks[0]
 
+        # End nesting?
+        if name == '}':
+            if nesting == 0:
+                error(start_lineno, 'mismatched close brace')
+            if len(toks) != 0:
+                error(start_lineno, 'extra tokens after close brace')
+            nesting -= 2
+            if indent != nesting:
+                error(start_lineno, 'indentation ', indent, ' != ', nesting)
+            pats = patterns
+            patterns = saved_pats.pop()
+            build_multi_pattern(lineno, pats)
+            toks = []
+            continue
+
+        # Everything else should have current indentation.
+        if indent != nesting:
+            error(start_lineno, 'indentation ', indent, ' != ', nesting)
+
+        # Start nesting?
+        if name == '{':
+            if len(toks) != 0:
+                error(start_lineno, 'extra tokens after open brace')
+            saved_pats.append(patterns)
+            patterns = []
+            nesting += 2
+            toks = []
+            continue
+
         # Determine the type of object needing to be parsed.
         if name[0] == '%':
-            parse_field(lineno, name[1:], toks)
+            parse_field(start_lineno, name[1:], toks)
         elif name[0] == '&':
-            parse_arguments(lineno, name[1:], toks)
+            parse_arguments(start_lineno, name[1:], toks)
         elif name[0] == '@':
-            parse_generic(lineno, True, name[1:], toks)
+            parse_generic(start_lineno, True, name[1:], toks)
         else:
-            parse_generic(lineno, False, name, toks)
+            parse_generic(start_lineno, False, name, toks)
         toks = []
 # end parse_file
 
@@ -789,11 +907,10 @@ def build_tree(pats, outerbits, outermask):
         innermask &= i.fixedmask
 
     if innermask == 0:
-        pnames = []
+        text = 'overlapping patterns:'
         for p in pats:
-            pnames.append(p.name + ':' + p.file + ':' + str(p.lineno))
-        error_with_file(pats[0].file, pats[0].lineno,
-                        'overlapping patterns:', pnames)
+            text += '\n' + p.file + ':' + str(p.lineno) + ': ' + str(p)
+        error_with_file(pats[0].file, pats[0].lineno, text)
 
     fullmask = outermask | innermask
 
@@ -846,6 +963,7 @@ def main():
     global arguments
     global formats
     global patterns
+    global allpatterns
     global translate_scope
     global translate_prefix
     global output_fd
@@ -907,7 +1025,7 @@ def main():
     # Make sure that the argument sets are the same, and declare the
     # function only once.
     out_pats = {}
-    for i in patterns:
+    for i in allpatterns:
         if i.name in out_pats:
             p = out_pats[i.name]
             if i.base.base != p.base.base:
diff --git a/tests/decode/err_pattern_group_overlap1.decode b/tests/decode/err_pattern_group_overlap1.decode
new file mode 100644
index 0000000000..ebe3030d26
--- /dev/null
+++ b/tests/decode/err_pattern_group_overlap1.decode
@@ -0,0 +1,6 @@
+one	00000000000000000000000000000000
+{
+  two	0000000000000000000000000000000 s:1
+  three 000000000000000000000000000000 s:1 0
+}
+
-- 
2.17.2
