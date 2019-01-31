Received: from eggs.gnu.org ([209.51.188.92]:39225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gpJZy-0000j3-NQ
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 16:08:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gpJZx-0008C1-Mj
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 16:08:58 -0500
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531]:47002)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gpJZx-00088K-6m
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 16:08:57 -0500
Received: by mail-pg1-x531.google.com with SMTP id w7so1869994pgp.13
	for <qemu-devel@nongnu.org>; Thu, 31 Jan 2019 13:08:56 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 31 Jan 2019 13:08:50 -0800
Message-Id: <20190131210851.9842-2-richard.henderson@linaro.org>
In-Reply-To: <20190131210851.9842-1-richard.henderson@linaro.org>
References: <20190131210851.9842-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 1/2] decodetree: Initial support for
 variable-length ISAs
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

Assuming that the ISA clearly describes how to determine
the length of the instruction, and the ISA has a reasonable
maximum instruction length, the input to the decoder can be
right-justified in an appropriate insn word.

This is not 100% convenient, as out-of-line %fields are
numbered relative to the maximum instruction length, but
this appears to still be usable.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 scripts/decodetree.py | 38 ++++++++++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/scripts/decodetree.py b/scripts/decodetree.py
index 2f8b5a1c92..5fb0acaa15 100755
--- a/scripts/decodetree.py
+++ b/scripts/decodetree.py
@@ -159,6 +159,7 @@ import getopt
 
 insnwidth = 32
 insnmask = 0xffffffff
+variablewidth = False
 fields = {}
 arguments = {}
 formats = {}
@@ -420,7 +421,7 @@ class Arguments:
 
 class General:
     """Common code between instruction formats and instruction patterns"""
-    def __init__(self, name, lineno, base, fixb, fixm, udfm, fldm, flds):
+    def __init__(self, name, lineno, base, fixb, fixm, udfm, fldm, flds, w):
         self.name = name
         self.file = input_file
         self.lineno = lineno
@@ -430,6 +431,7 @@ class General:
         self.undefmask = udfm
         self.fieldmask = fldm
         self.fields = flds
+        self.width = w
 
     def __str__(self):
         r = self.name
@@ -597,7 +599,7 @@ def infer_argument_set(flds):
     return arg
 
 
-def infer_format(arg, fieldmask, flds):
+def infer_format(arg, fieldmask, flds, width):
     global arguments
     global formats
     global decode_function
@@ -616,6 +618,8 @@ def infer_format(arg, fieldmask, flds):
             continue
         if fieldmask != fmt.fieldmask:
             continue
+        if width != fmt.width:
+            continue
         if not eq_fields_for_fmts(flds, fmt.fields):
             continue
         return (fmt, const_flds)
@@ -624,7 +628,7 @@ def infer_format(arg, fieldmask, flds):
     if not arg:
         arg = infer_argument_set(flds)
 
-    fmt = Format(name, 0, arg, 0, 0, 0, fieldmask, var_flds)
+    fmt = Format(name, 0, arg, 0, 0, 0, fieldmask, var_flds, width)
     formats[name] = fmt
 
     return (fmt, const_flds)
@@ -640,6 +644,7 @@ def parse_generic(lineno, is_format, name, toks):
     global re_ident
     global insnwidth
     global insnmask
+    global variablewidth
 
     fixedmask = 0
     fixedbits = 0
@@ -725,8 +730,15 @@ def parse_generic(lineno, is_format, name, toks):
             error(lineno, 'invalid token "{0}"'.format(t))
         width += shift
 
+    if variablewidth and width < insnwidth and width % 8 == 0:
+        shift = insnwidth - width
+        fixedbits <<= shift
+        fixedmask <<= shift
+        undefmask <<= shift
+        undefmask |= (1 << shift) - 1
+
     # We should have filled in all of the bits of the instruction.
-    if not (is_format and width == 0) and width != insnwidth:
+    elif not (is_format and width == 0) and width != insnwidth:
         error(lineno, 'definition has {0} bits'.format(width))
 
     # Do not check for fields overlaping fields; one valid usage
@@ -752,7 +764,7 @@ def parse_generic(lineno, is_format, name, toks):
         if name in formats:
             error(lineno, 'duplicate format name', name)
         fmt = Format(name, lineno, arg, fixedbits, fixedmask,
-                     undefmask, fieldmask, flds)
+                     undefmask, fieldmask, flds, width)
         formats[name] = fmt
     else:
         # Patterns can reference a format ...
@@ -762,12 +774,14 @@ def parse_generic(lineno, is_format, name, toks):
                 error(lineno, 'pattern specifies both format and argument set')
             if fixedmask & fmt.fixedmask:
                 error(lineno, 'pattern fixed bits overlap format fixed bits')
+            if width != fmt.width:
+                error(lineno, 'pattern uses format of different width')
             fieldmask |= fmt.fieldmask
             fixedbits |= fmt.fixedbits
             fixedmask |= fmt.fixedmask
             undefmask |= fmt.undefmask
         else:
-            (fmt, flds) = infer_format(arg, fieldmask, flds)
+            (fmt, flds) = infer_format(arg, fieldmask, flds, width)
         arg = fmt.base
         for f in flds.keys():
             if f not in arg.fields:
@@ -779,7 +793,7 @@ def parse_generic(lineno, is_format, name, toks):
             if f not in flds.keys() and f not in fmt.fields.keys():
                 error(lineno, 'field {0} not initialized'.format(f))
         pat = Pattern(name, lineno, fmt, fixedbits, fixedmask,
-                      undefmask, fieldmask, flds)
+                      undefmask, fieldmask, flds, width)
         patterns.append(pat)
 
     # Validate the masks that we have assembled.
@@ -987,12 +1001,14 @@ def main():
     global insntype
     global insnmask
     global decode_function
+    global variablewidth
 
     decode_scope = 'static '
 
-    long_opts = ['decode=', 'translate=', 'output=', 'insnwidth=']
+    long_opts = ['decode=', 'translate=',
+                 'output=', 'insnwidth=', 'varinsnwidth=']
     try:
-        (opts, args) = getopt.getopt(sys.argv[1:], 'o:w:', long_opts)
+        (opts, args) = getopt.getopt(sys.argv[1:], 'o:vw:', long_opts)
     except getopt.GetoptError as err:
         error(0, err)
     for o, a in opts:
@@ -1004,7 +1020,9 @@ def main():
         elif o == '--translate':
             translate_prefix = a
             translate_scope = ''
-        elif o in ('-w', '--insnwidth'):
+        elif o in ('-w', '--insnwidth', '--varinsnwidth'):
+            if o == '--varinsnwidth':
+                variablewidth = True
             insnwidth = int(a)
             if insnwidth == 16:
                 insntype = 'uint16_t'
-- 
2.17.2
