Received: from eggs.gnu.org ([2001:4830:134:3::10]:53236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gLzHf-0003JZ-6M
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 18:36:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gLzHb-0007Gi-Ui
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 18:36:51 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42819)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gLzHb-0007Ev-Lp
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 18:36:47 -0500
Received: by mail-wr1-x442.google.com with SMTP id u5-v6so2107301wrn.9
	for <qemu-devel@nongnu.org>; Sun, 11 Nov 2018 15:36:45 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 12 Nov 2018 00:36:21 +0100
Message-Id: <20181111233622.8976-11-f4bug@amsat.org>
In-Reply-To: <20181111233622.8976-1-f4bug@amsat.org>
References: <20181111233622.8976-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 10/11] scripts/decodetree: Add
 add_cond_check()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Peer Adelt <peer.adelt@hni.uni-paderborn.de>, Richard Henderson <rth@twiddle.net>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>

The '?' token allow to check for a condition.

This is useful to take the translate the instruction only if the
condition is valid.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 scripts/decodetree.py | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/scripts/decodetree.py b/scripts/decodetree.py
index 2450cc1a63..ba53ee589e 100755
--- a/scripts/decodetree.py
+++ b/scripts/decodetree.py
@@ -420,7 +420,7 @@ class Arguments:
 
 class General:
     """Common code between instruction formats and instruction patterns"""
-    def __init__(self, name, lineno, base, fixb, fixm, udfm, fldm, flds, chkfs):
+    def __init__(self, name, lineno, base, fixb, fixm, udfm, fldm, flds, chkfs, chkif):
         self.name = name
         self.file = input_file
         self.lineno = lineno
@@ -431,6 +431,7 @@ class General:
         self.fieldmask = fldm
         self.fields = flds
         self.check_funcs = chkfs
+        self.check_cond = chkif
 
     def __str__(self):
         r = self.name
@@ -483,6 +484,9 @@ class Pattern(General):
             output(ind, 'u.f_', arg, '.', n, ' = ', f.str_extract(), ';\n')
         for f, a in self.check_funcs:
             output(ind, 'check_', f, '(ctx, ', a, ');\n')
+        if self.check_cond:
+            output(ind, 'if (!(', self.check_cond, '))\n')
+            output(ind, '    return false;\n')
         output(ind, 'return ', translate_prefix, '_', self.name,
                '(ctx, &u.f_', arg, ');\n')
 # end Pattern
@@ -591,6 +595,10 @@ def add_func_check(lineno, chkfns, check_funcname, check_arg):
     return chkfns
 
 
+def add_cond_check(lineno, chkifs, condition):
+    return condition
+
+
 def infer_argument_set(flds):
     global arguments
     global decode_function
@@ -632,7 +640,7 @@ def infer_format(arg, fieldmask, flds):
     if not arg:
         arg = infer_argument_set(flds)
 
-    fmt = Format(name, 0, arg, 0, 0, 0, fieldmask, var_flds, [])
+    fmt = Format(name, 0, arg, 0, 0, 0, fieldmask, var_flds, [], None)
     formats[name] = fmt
 
     return (fmt, const_flds)
@@ -655,6 +663,7 @@ def parse_generic(lineno, is_format, name, toks):
     width = 0
     flds = {}
     chkfns = []
+    chkifs = None
     arg = None
     fmt = None
     for t in toks:
@@ -706,6 +715,13 @@ def parse_generic(lineno, is_format, name, toks):
             chkfns = add_func_check(lineno, chkfns, fname, farg)
             continue
 
+        # '?condition' calls if(condition).
+        if t[0] == '?':
+            cond = t[1:]
+            tt = t[1 + len(cond):]
+            chkifs = add_cond_check(lineno, chkifs, cond)
+            continue
+
         # Pattern of 0s, 1s, dots and dashes indicate required zeros,
         # required ones, or dont-cares.
         if re_fullmatch('[01.-]+', t):
@@ -768,7 +784,7 @@ def parse_generic(lineno, is_format, name, toks):
         if name in formats:
             error(lineno, 'duplicate format name', name)
         fmt = Format(name, lineno, arg, fixedbits, fixedmask,
-                     undefmask, fieldmask, flds, chkfns)
+                     undefmask, fieldmask, flds, chkfns, chkifs)
         formats[name] = fmt
     else:
         # Patterns can reference a format ...
@@ -795,7 +811,7 @@ def parse_generic(lineno, is_format, name, toks):
             if f not in flds.keys() and f not in fmt.fields.keys():
                 error(lineno, 'field {0} not initialized'.format(f))
         pat = Pattern(name, lineno, fmt, fixedbits, fixedmask,
-                      undefmask, fieldmask, flds, chkfns)
+                      undefmask, fieldmask, flds, chkfns, chkifs)
         patterns.append(pat)
 
     # Validate the masks that we have assembled.
-- 
2.17.2
