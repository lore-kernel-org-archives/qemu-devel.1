Received: from eggs.gnu.org ([209.51.188.92]:36611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1yBz-0001Ck-3O
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:56:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1yBx-0002Mi-6g
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:56:31 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:41566)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1h1yBw-0002LG-Sz
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:56:29 -0500
Received: by mail-pg1-x542.google.com with SMTP id k11so10994184pgb.8
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 10:56:28 -0800 (PST)
Received: from cloudburst.twiddle.net (97-113-188-82.tukw.qwest.net.
	[97.113.188.82]) by smtp.gmail.com with ESMTPSA id
	g12sm8801973pgr.76.2019.03.07.10.56.25 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 07 Mar 2019 10:56:26 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  7 Mar 2019 10:56:12 -0800
Message-Id: <20190307185622.29026-3-richard.henderson@linaro.org>
In-Reply-To: <20190307185622.29026-1-richard.henderson@linaro.org>
References: <20190307185622.29026-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 02/12] decodetree: Move documentation to
 docs/devel/decodetree.rst
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

One great big block comment isn't the best way to document
the syntax of a language.

Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 MAINTAINERS               |   1 +
 docs/devel/decodetree.rst | 156 ++++++++++++++++++++++++++++++++++++++
 docs/devel/index.rst      |   2 +-
 scripts/decodetree.py     | 134 +-------------------------------
 4 files changed, 159 insertions(+), 134 deletions(-)
 create mode 100644 docs/devel/decodetree.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index af1df70be1..820024a808 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -118,6 +118,7 @@ F: exec.c
 F: accel/tcg/
 F: accel/stubs/tcg-stub.c
 F: scripts/decodetree.py
+F: docs/devel/decodetree.rst
 F: include/exec/cpu*.h
 F: include/exec/exec-all.h
 F: include/exec/helper*.h
diff --git a/docs/devel/decodetree.rst b/docs/devel/decodetree.rst
new file mode 100644
index 0000000000..d9be30b2db
--- /dev/null
+++ b/docs/devel/decodetree.rst
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
diff --git a/docs/devel/index.rst b/docs/devel/index.rst
index cd0fa6c9ba..6b9a6ba71c 100644
--- a/docs/devel/index.rst
+++ b/docs/devel/index.rst
@@ -18,4 +18,4 @@ Contents:
    migration
    stable-process
    testing
-
+   decodetree
diff --git a/scripts/decodetree.py b/scripts/decodetree.py
index e342d278b8..33e32ee87f 100755
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
+# See the syntax and semantics in docs/devel/decodetree.rst.
 #
 
 import os
-- 
2.17.2
