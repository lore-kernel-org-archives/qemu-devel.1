Received: from eggs.gnu.org ([2001:4830:134:3::10]:46839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gHpOn-00034G-92
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 08:15:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gHpOj-0002fb-6X
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 08:15:01 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:54403)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gHpOf-0002Pb-Ed
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 08:14:55 -0400
Received: by mail-wm1-x331.google.com with SMTP id r63-v6so14918818wma.4
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 05:14:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 31 Oct 2018 12:14:41 +0000
Message-Id: <20181031121443.605-2-richard.henderson@linaro.org>
In-Reply-To: <20181031121443.605-1-richard.henderson@linaro.org>
References: <20181031121443.605-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 1/3] decodetree: Add !extern flag to
 argument sets
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

Allow argument sets to be shared between two decoders by avoiding
a re-declaration error.  Make sure that anonymous argument sets
and anonymous formats have unique names.

Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 scripts/decodetree.py | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/scripts/decodetree.py b/scripts/decodetree.py
index 457cffea90..28bbd4e3c1 100755
--- a/scripts/decodetree.py
+++ b/scripts/decodetree.py
@@ -63,13 +63,16 @@
 #
 # *** Argument set syntax:
 #
-# args_def    := '&' identifier ( args_elt )+
+# args_def    := '&' identifier ( args_elt )+ ( !extern )?
 # args_elt    := identifier
 #
 # Each args_elt defines an argument within the argument set.
 # Each argument set will be rendered as a C structure "arg_$name"
 # with each of the fields being one of the member arguments.
 #
+# If !extern is specified, the backing structure is assumed to
+# have been already declared, typically via a second decoder.
+#
 # Argument set examples:
 #
 #   &reg3       ra rb rc
@@ -167,6 +170,7 @@ input_file = ''
 output_file = None
 output_fd = None
 insntype = 'uint32_t'
+decode_function = 'decode'
 
 re_ident = '[a-zA-Z][a-zA-Z0-9_]*'
 
@@ -392,8 +396,9 @@ class FunctionField:
 
 class Arguments:
     """Class representing the extracted fields of a format"""
-    def __init__(self, nm, flds):
+    def __init__(self, nm, flds, extern):
         self.name = nm
+        self.extern = extern
         self.fields = sorted(flds)
 
     def __str__(self):
@@ -403,10 +408,11 @@ class Arguments:
         return 'arg_' + self.name
 
     def output_def(self):
-        output('typedef struct {\n')
-        for n in self.fields:
-            output('    int ', n, ';\n')
-        output('} ', self.struct_name(), ';\n\n')
+        if not self.extern:
+            output('typedef struct {\n')
+            for n in self.fields:
+                output('    int ', n, ';\n')
+            output('} ', self.struct_name(), ';\n\n')
 # end Arguments
 
 
@@ -540,7 +546,11 @@ def parse_arguments(lineno, name, toks):
     global re_ident
 
     flds = []
+    extern = False
     for t in toks:
+        if re_fullmatch('!extern', t):
+            extern = True
+            continue
         if not re_fullmatch(re_ident, t):
             error(lineno, 'invalid argument set token "{0}"'.format(t))
         if t in flds:
@@ -549,7 +559,7 @@ def parse_arguments(lineno, name, toks):
 
     if name in arguments:
         error(lineno, 'duplicate argument set', name)
-    arguments[name] = Arguments(name, flds)
+    arguments[name] = Arguments(name, flds, extern)
 # end parse_arguments
 
 
@@ -573,13 +583,14 @@ def add_field_byname(lineno, flds, new_name, old_name):
 
 def infer_argument_set(flds):
     global arguments
+    global decode_function
 
     for arg in arguments.values():
         if eq_fields_for_args(flds, arg.fields):
             return arg
 
-    name = str(len(arguments))
-    arg = Arguments(name, flds.keys())
+    name = decode_function + str(len(arguments))
+    arg = Arguments(name, flds.keys(), False)
     arguments[name] = arg
     return arg
 
@@ -587,6 +598,7 @@ def infer_argument_set(flds):
 def infer_format(arg, fieldmask, flds):
     global arguments
     global formats
+    global decode_function
 
     const_flds = {}
     var_flds = {}
@@ -606,7 +618,7 @@ def infer_format(arg, fieldmask, flds):
             continue
         return (fmt, const_flds)
 
-    name = 'Fmt_' + str(len(formats))
+    name = decode_function + '_Fmt_' + str(len(formats))
     if not arg:
         arg = infer_argument_set(flds)
 
@@ -971,8 +983,8 @@ def main():
     global insnwidth
     global insntype
     global insnmask
+    global decode_function
 
-    decode_function = 'decode'
     decode_scope = 'static '
 
     long_opts = ['decode=', 'translate=', 'output=', 'insnwidth=']
-- 
2.17.2
