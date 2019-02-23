Received: from eggs.gnu.org ([209.51.188.92]:45444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gxgkB-0000PU-VC
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 18:30:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gxgk9-0007MK-EF
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 18:30:07 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431]:42745)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gxgk9-0007Dt-0N
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 18:30:05 -0500
Received: by mail-pf1-x431.google.com with SMTP id n74so2756248pfi.9
	for <qemu-devel@nongnu.org>; Sat, 23 Feb 2019 15:30:00 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 23 Feb 2019 15:29:49 -0800
Message-Id: <20190223232954.7185-3-richard.henderson@linaro.org>
In-Reply-To: <20190223232954.7185-1-richard.henderson@linaro.org>
References: <20190223232954.7185-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 2/5] decodetree: Move documentation to
 docs/decodetree.rst
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kbastian@mail.uni-paderborn.de, f4bug@amsat.org

One great big block comment isn't the best way to document
the syntax of a language.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 MAINTAINERS           |   1 +
 docs/decodetree.rst   | 156 ++++++++++++++++++++++++++++++++++++++++++
 scripts/decodetree.py | 134 +-----------------------------------
 3 files changed, 158 insertions(+), 133 deletions(-)
 create mode 100644 docs/decodetree.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index ad007748b9..fc7cddb873 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -118,6 +118,7 @@ F: exec.c
 F: accel/tcg/
 F: accel/stubs/tcg-stub.c
 F: scripts/decodetree.py
+F: docs/decodetree.rst
 F: include/exec/cpu*.h
 F: include/exec/exec-all.h
 F: include/exec/helper*.h
diff --git a/docs/decodetree.rst b/docs/decodetree.rst
new file mode 100644
index 0000000000..d9be30b2db
--- /dev/null
+++ b/docs/decodetree.rst
@@ -0,0 +1,156 @@
+========================
+Decodetree Specification
+========================
+
+A *decodetree* is built from instruction *patterns*.  A pattern may
+represent a single architectural instruction or a group of same, depending
+on what is convenient for further processing.
+
+Each pattern has both *fixedbits* and *fixedmask*, the combination of which
+describes the condition under which the pattern is matched::
+
+  (insn & fixedmask) == fixedbits
+
+Each pattern may have *fields*, which are extracted from the insn and
+passed along to the translator.  Examples of such are registers,
+immediates, and sub-opcodes.
+
+In support of patterns, one may declare *fields*, *argument sets*, and
+*formats*, each of which may be re-used to simplify further definitions.
+
+Fields
+======
+
+Syntax::
+
+  field_def     := '%' identifier ( unnamed_field )+ ( !function=identifier )?
+  unnamed_field := number ':' ( 's' ) number
+
+For *unnamed_field*, the first number is the least-significant bit position
+of the field and the second number is the length of the field.  If the 's' is
+present, the field is considered signed.  If multiple ``unnamed_fields`` are
+present, they are concatenated.  In this way one can define disjoint fields.
+
+If ``!function`` is specified, the concatenated result is passed through the
+named function, taking and returning an integral value.
+
+FIXME: the fields of the structure into which this result will be stored
+is restricted to ``int``.  Which means that we cannot expand 64-bit items.
+
+Field examples:
+
++---------------------------+---------------------------------------------+
+| Input                     | Generated code                              |
++===========================+=============================================+
+| %disp   0:s16             | sextract(i, 0, 16)                          |
++---------------------------+---------------------------------------------+
+| %imm9   16:6 10:3         | extract(i, 16, 6) << 3 | extract(i, 10, 3)  |
++---------------------------+---------------------------------------------+
+| %disp12 0:s1 1:1 2:10     | sextract(i, 0, 1) << 11 |                   |
+|                           |    extract(i, 1, 1) << 10 |                 |
+|                           |    extract(i, 2, 10)                        |
++---------------------------+---------------------------------------------+
+| %shimm8 5:s8 13:1         | expand_shimm8(sextract(i, 5, 8) << 1 |      |
+|   !function=expand_shimm8 |               extract(i, 13, 1))            |
++---------------------------+---------------------------------------------+
+
+Argument Sets
+=============
+
+Syntax::
+
+  args_def    := '&' identifier ( args_elt )+ ( !extern )?
+  args_elt    := identifier
+
+Each *args_elt* defines an argument within the argument set.
+Each argument set will be rendered as a C structure "arg_$name"
+with each of the fields being one of the member arguments.
+
+If ``!extern`` is specified, the backing structure is assumed
+to have been already declared, typically via a second decoder.
+
+Argument set examples::
+
+  &reg3       ra rb rc
+  &loadstore  reg base offset
+
+
+Formats
+=======
+
+Syntax::
+
+  fmt_def      := '@' identifier ( fmt_elt )+
+  fmt_elt      := fixedbit_elt | field_elt | field_ref | args_ref
+  fixedbit_elt := [01.-]+
+  field_elt    := identifier ':' 's'? number
+  field_ref    := '%' identifier | identifier '=' '%' identifier
+  args_ref     := '&' identifier
+
+Defining a format is a handy way to avoid replicating groups of fields
+across many instruction patterns.
+
+A *fixedbit_elt* describes a contiguous sequence of bits that must
+be 1, 0, or don't care.  The difference between '.' and '-'
+is that '.' means that the bit will be covered with a field or a
+final 0 or 1 from the pattern, and '-' means that the bit is really
+ignored by the cpu and will not be specified.
+
+A *field_elt* describes a simple field only given a width; the position of
+the field is implied by its position with respect to other *fixedbit_elt*
+and *field_elt*.
+
+If any *fixedbit_elt* or *field_elt* appear, then all bits must be defined.
+Padding with a *fixedbit_elt* of all '.' is an easy way to accomplish that.
+
+A *field_ref* incorporates a field by reference.  This is the only way to
+add a complex field to a format.  A field may be renamed in the process
+via assignment to another identifier.  This is intended to allow the
+same argument set be used with disjoint named fields.
+
+A single *args_ref* may specify an argument set to use for the format.
+The set of fields in the format must be a subset of the arguments in
+the argument set.  If an argument set is not specified, one will be
+inferred from the set of fields.
+
+It is recommended, but not required, that all *field_ref* and *args_ref*
+appear at the end of the line, not interleaving with *fixedbit_elf* or
+*field_elt*.
+
+Format examples::
+
+  @opr    ...... ra:5 rb:5 ... 0 ....... rc:5
+  @opi    ...... ra:5 lit:8    1 ....... rc:5
+
+Patterns
+========
+
+Syntax::
+
+  pat_def      := identifier ( pat_elt )+
+  pat_elt      := fixedbit_elt | field_elt | field_ref | args_ref | fmt_ref | const_elt
+  fmt_ref      := '@' identifier
+  const_elt    := identifier '=' number
+
+The *fixedbit_elt* and *field_elt* specifiers are unchanged from formats.
+A pattern that does not specify a named format will have one inferred
+from a referenced argument set (if present) and the set of fields.
+
+A *const_elt* allows a argument to be set to a constant value.  This may
+come in handy when fields overlap between patterns and one has to
+include the values in the *fixedbit_elt* instead.
+
+The decoder will call a translator function for each pattern matched.
+
+Pattern examples::
+
+  addl_r   010000 ..... ..... .... 0000000 ..... @opr
+  addl_i   010000 ..... ..... .... 0000000 ..... @opi
+
+which will, in part, invoke::
+
+  trans_addl_r(ctx, &arg_opr, insn)
+
+and::
+
+  trans_addl_i(ctx, &arg_opi, insn)
diff --git a/scripts/decodetree.py b/scripts/decodetree.py
index e342d278b8..ba203aeccd 100755
--- a/scripts/decodetree.py
+++ b/scripts/decodetree.py
@@ -17,139 +17,7 @@
 
 #
 # Generate a decoding tree from a specification file.
-#
-# The tree is built from instruction "patterns".  A pattern may represent
-# a single architectural instruction or a group of same, depending on what
-# is convenient for further processing.
-#
-# Each pattern has "fixedbits" & "fixedmask", the combination of which
-# describes the condition under which the pattern is matched:
-#
-#   (insn & fixedmask) == fixedbits
-#
-# Each pattern may have "fields", which are extracted from the insn and
-# passed along to the translator.  Examples of such are registers,
-# immediates, and sub-opcodes.
-#
-# In support of patterns, one may declare fields, argument sets, and
-# formats, each of which may be re-used to simplify further definitions.
-#
-# *** Field syntax:
-#
-# field_def     := '%' identifier ( unnamed_field )+ ( !function=identifier )?
-# unnamed_field := number ':' ( 's' ) number
-#
-# For unnamed_field, the first number is the least-significant bit position of
-# the field and the second number is the length of the field.  If the 's' is
-# present, the field is considered signed.  If multiple unnamed_fields are
-# present, they are concatenated.  In this way one can define disjoint fields.
-#
-# If !function is specified, the concatenated result is passed through the
-# named function, taking and returning an integral value.
-#
-# FIXME: the fields of the structure into which this result will be stored
-# is restricted to "int".  Which means that we cannot expand 64-bit items.
-#
-# Field examples:
-#
-#   %disp   0:s16          -- sextract(i, 0, 16)
-#   %imm9   16:6 10:3      -- extract(i, 16, 6) << 3 | extract(i, 10, 3)
-#   %disp12 0:s1 1:1 2:10  -- sextract(i, 0, 1) << 11
-#                             | extract(i, 1, 1) << 10
-#                             | extract(i, 2, 10)
-#   %shimm8 5:s8 13:1 !function=expand_shimm8
-#                          -- expand_shimm8(sextract(i, 5, 8) << 1
-#                                           | extract(i, 13, 1))
-#
-# *** Argument set syntax:
-#
-# args_def    := '&' identifier ( args_elt )+ ( !extern )?
-# args_elt    := identifier
-#
-# Each args_elt defines an argument within the argument set.
-# Each argument set will be rendered as a C structure "arg_$name"
-# with each of the fields being one of the member arguments.
-#
-# If !extern is specified, the backing structure is assumed to
-# have been already declared, typically via a second decoder.
-#
-# Argument set examples:
-#
-#   &reg3       ra rb rc
-#   &loadstore  reg base offset
-#
-# *** Format syntax:
-#
-# fmt_def      := '@' identifier ( fmt_elt )+
-# fmt_elt      := fixedbit_elt | field_elt | field_ref | args_ref
-# fixedbit_elt := [01.-]+
-# field_elt    := identifier ':' 's'? number
-# field_ref    := '%' identifier | identifier '=' '%' identifier
-# args_ref     := '&' identifier
-#
-# Defining a format is a handy way to avoid replicating groups of fields
-# across many instruction patterns.
-#
-# A fixedbit_elt describes a contiguous sequence of bits that must
-# be 1, 0, [.-] for don't care.  The difference between '.' and '-'
-# is that '.' means that the bit will be covered with a field or a
-# final [01] from the pattern, and '-' means that the bit is really
-# ignored by the cpu and will not be specified.
-#
-# A field_elt describes a simple field only given a width; the position of
-# the field is implied by its position with respect to other fixedbit_elt
-# and field_elt.
-#
-# If any fixedbit_elt or field_elt appear then all bits must be defined.
-# Padding with a fixedbit_elt of all '.' is an easy way to accomplish that.
-#
-# A field_ref incorporates a field by reference.  This is the only way to
-# add a complex field to a format.  A field may be renamed in the process
-# via assignment to another identifier.  This is intended to allow the
-# same argument set be used with disjoint named fields.
-#
-# A single args_ref may specify an argument set to use for the format.
-# The set of fields in the format must be a subset of the arguments in
-# the argument set.  If an argument set is not specified, one will be
-# inferred from the set of fields.
-#
-# It is recommended, but not required, that all field_ref and args_ref
-# appear at the end of the line, not interleaving with fixedbit_elf or
-# field_elt.
-#
-# Format examples:
-#
-#   @opr    ...... ra:5 rb:5 ... 0 ....... rc:5
-#   @opi    ...... ra:5 lit:8    1 ....... rc:5
-#
-# *** Pattern syntax:
-#
-# pat_def      := identifier ( pat_elt )+
-# pat_elt      := fixedbit_elt | field_elt | field_ref
-#               | args_ref | fmt_ref | const_elt
-# fmt_ref      := '@' identifier
-# const_elt    := identifier '=' number
-#
-# The fixedbit_elt and field_elt specifiers are unchanged from formats.
-# A pattern that does not specify a named format will have one inferred
-# from a referenced argument set (if present) and the set of fields.
-#
-# A const_elt allows a argument to be set to a constant value.  This may
-# come in handy when fields overlap between patterns and one has to
-# include the values in the fixedbit_elt instead.
-#
-# The decoder will call a translator function for each pattern matched.
-#
-# Pattern examples:
-#
-#   addl_r   010000 ..... ..... .... 0000000 ..... @opr
-#   addl_i   010000 ..... ..... .... 0000000 ..... @opi
-#
-# which will, in part, invoke
-#
-#   trans_addl_r(ctx, &arg_opr, insn)
-# and
-#   trans_addl_i(ctx, &arg_opi, insn)
+# See the syntax and semantics in docs/decodetree.rst.
 #
 
 import os
-- 
2.17.2
