Received: from eggs.gnu.org ([209.51.188.92]:39231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gpJZz-0000j8-0l
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 16:09:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gpJZx-0008CE-RY
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 16:08:59 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:46599)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gpJZx-0008BI-Jp
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 16:08:57 -0500
Received: by mail-pg1-x541.google.com with SMTP id w7so1870018pgp.13
	for <qemu-devel@nongnu.org>; Thu, 31 Jan 2019 13:08:57 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 31 Jan 2019 13:08:51 -0800
Message-Id: <20190131210851.9842-3-richard.henderson@linaro.org>
In-Reply-To: <20190131210851.9842-1-richard.henderson@linaro.org>
References: <20190131210851.9842-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 2/2] decodetree: Expand a decode_load function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ysato@users.sourceforge.jp

Read the instruction, loading no more bytes than necessary.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 scripts/decodetree.py | 175 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 172 insertions(+), 3 deletions(-)

diff --git a/scripts/decodetree.py b/scripts/decodetree.py
index 5fb0acaa15..05b6b3d18b 100755
--- a/scripts/decodetree.py
+++ b/scripts/decodetree.py
@@ -966,6 +966,147 @@ def build_tree(pats, outerbits, outermask):
 # end build_tree
 
 
+class SizeTree:
+    """Class representing a node in a size decode tree"""
+
+    def __init__(self, m, w):
+        self.mask = m
+        self.subs = []
+        self.base = None
+        self.width = w
+
+    def str1(self, i):
+        ind = str_indent(i)
+        r = '{0}{1:08x}'.format(ind, self.mask)
+        r += ' [\n'
+        for (b, s) in self.subs:
+            r += '{0}  {1:08x}:\n'.format(ind, b)
+            r += s.str1(i + 4) + '\n'
+        r += ind + ']'
+        return r
+
+    def __str__(self):
+        return self.str1(0)
+
+    def output_code(self, i, extracted, outerbits, outermask):
+        ind = str_indent(i)
+
+        # If we need to load more bytes to test, do so now.
+        if extracted < self.width:
+            output(ind, 'insn = ', decode_function,
+                   '_load_bytes(s, insn, {0}, {1});\n'
+                   .format(extracted / 8, self.width / 8));
+            extracted = self.width
+
+        # Attempt to aid the compiler in producing compact switch statements.
+        # If the bits in the mask are contiguous, extract them.
+        sh = is_contiguous(self.mask)
+        if sh > 0:
+            # Propagate SH down into the local functions.
+            def str_switch(b, sh=sh):
+                return '(insn >> {0}) & 0x{1:x}'.format(sh, b >> sh)
+
+            def str_case(b, sh=sh):
+                return '0x{0:x}'.format(b >> sh)
+        else:
+            def str_switch(b):
+                return 'insn & 0x{0:08x}'.format(b)
+
+            def str_case(b):
+                return '0x{0:08x}'.format(b)
+
+        output(ind, 'switch (', str_switch(self.mask), ') {\n')
+        for b, s in sorted(self.subs):
+            innermask = outermask | self.mask
+            innerbits = outerbits | b
+            output(ind, 'case ', str_case(b), ':\n')
+            output(ind, '    /* ',
+                   str_match_bits(innerbits, innermask), ' */\n')
+            s.output_code(i + 4, extracted, innerbits, innermask)
+        output(ind, '}\n')
+        output(ind, 'return insn;\n')
+# end SizeTree
+
+class SizeLeaf:
+    """Class representing a leaf node in a size decode tree"""
+
+    def __init__(self, m, w):
+        self.mask = m
+        self.width = w
+
+    def str1(self, i):
+        ind = str_indent(i)
+        return '{0}{1:08x}'.format(ind, self.mask)
+
+    def __str__(self):
+        return self.str1(0)
+
+    def output_code(self, i, extracted, outerbits, outermask):
+        global decode_function
+        ind = str_indent(i)
+
+        # If we need to load more bytes, do so now.
+        if extracted < self.width:
+            output(ind, 'insn = ', decode_function,
+                   '_load_bytes(s, insn, {0}, {1});\n'
+                   .format(extracted / 8, self.width / 8));
+            extracted = self.width
+        output(ind, 'return insn;\n')
+# end SizeLeaf
+
+
+def build_size_tree(pats, width, outerbits, outermask):
+    global insnwidth
+
+    # Collect the mask of bits that are fixed in this width
+    innermask = 0xff << (insnwidth - width)
+    innermask &= ~outermask
+    minwidth = None
+    onewidth = True
+    for i in pats:
+        innermask &= i.fixedmask
+        if minwidth is None:
+            minwidth = i.width
+        elif minwidth != i.width:
+            onewidth = False;
+            if minwidth < i.width:
+                minwidth = i.width
+
+    if onewidth:
+        return SizeLeaf(innermask, minwidth)
+
+    if innermask == 0:
+        if width < minwidth:
+            return build_size_tree(pats, width + 8, outerbits, outermask)
+
+        pnames = []
+        for p in pats:
+            pnames.append(p.name + ':' + p.file + ':' + str(p.lineno))
+        error_with_file(pats[0].file, pats[0].lineno,
+                        'overlapping patterns size {0}:'.format(width), pnames)
+
+    bins = {}
+    for i in pats:
+        fb = i.fixedbits & innermask
+        if fb in bins:
+            bins[fb].append(i)
+        else:
+            bins[fb] = [i]
+
+    fullmask = outermask | innermask
+    lens = sorted(bins.keys())
+    if len(lens) == 1:
+        b = lens[0]
+        return build_size_tree(bins[b], width + 8, b | outerbits, fullmask)
+
+    r = SizeTree(innermask, width)
+    for b, l in bins.items():
+        s = build_size_tree(l, width, b | outerbits, fullmask)
+        r.subs.append((b, s))
+    return r
+# end build_size_tree
+
+
 def prop_format(tree):
     """Propagate Format objects into the decode tree"""
 
@@ -988,6 +1129,23 @@ def prop_format(tree):
 # end prop_format
 
 
+def prop_size(tree):
+    """Propagate minimum widths up the decode size tree"""
+
+    if isinstance(tree, SizeTree):
+        min = None
+        for (b, s) in tree.subs:
+            width = prop_size(s)
+            if min is None or min > width:
+                min = width
+        assert min >= tree.width
+        tree.width = min
+    else:
+        min = tree.width
+    return min
+# end prop_size
+
+
 def main():
     global arguments
     global formats
@@ -1040,8 +1198,12 @@ def main():
         parse_file(f)
         f.close()
 
-    t = build_tree(patterns, 0, 0)
-    prop_format(t)
+    if variablewidth:
+        stree = build_size_tree(patterns, 8, 0, 0)
+        prop_size(stree)
+
+    dtree = build_tree(patterns, 0, 0)
+    prop_format(dtree)
 
     if output_file:
         output_fd = open(output_file, 'w')
@@ -1081,10 +1243,17 @@ def main():
         output(i4, i4, f.struct_name(), ' f_', f.name, ';\n')
     output(i4, '} u;\n\n')
 
-    t.output_code(4, False, 0, 0)
+    dtree.output_code(4, False, 0, 0)
 
     output('}\n')
 
+    if variablewidth:
+        output('\n', decode_scope, insntype, ' ', decode_function,
+               '_load(DisasContext *ctx)\n{\n',
+               '    ', insntype, ' insn = 0;\n\n')
+        stree.output_code(4, 0, 0, 0)
+        output('}\n')
+
     if output_file:
         output_fd.close()
 # end main
-- 
2.17.2
