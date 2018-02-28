Received: from eggs.gnu.org ([2001:4830:134:3::10]:46125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1er4u1-0000g3-Fr
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 11:48:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1er4tz-00073p-1M
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 11:48:25 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:39019)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1er4ty-00072W-SM
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 11:48:22 -0500
Received: by mail-pg0-x244.google.com with SMTP id w16so253009pgv.6
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 08:48:22 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 28 Feb 2018 08:48:14 -0800
Message-Id: <20180228164816.24110-3-richard.henderson@linaro.org>
In-Reply-To: <20180228164816.24110-1-richard.henderson@linaro.org>
References: <20180228164816.24110-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH] decodetree: Propagate return value from
 translate subroutines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org

Allow the translate subroutines to return false for invalid insns.

At present we can of course invoke an invalid insn exception from within
the translate subroutine, but in the short term this consolidates code.
In the long term it would allow the decodetree language to support
overlapping patterns for ISA extensions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---

Since this makes an ABI change to the translate functions called by the
decode function, let's make it now before there are any in-tree users.

My SVE branch over-decodes in quite a lot of cases -- e.g. things like
the 2-bit size field must be 1-3 for fp operands, and so size==0 is
unallocated.  Returning false for these cases allows the actual call
to unallocated_encoding to be done in one place instead of hundreds.

Longer term, I'm thinking of how to handle decode of overlapping ISA
extensions.  One could allow (specific) overlapping patterns and
prioritize them in some way (e.g. first in file is first matched).
My thought is that trans_insn_a would check a cpu feature bit and
return false if not enabled.  Then trans_insn_b would be given its
chance to handle the insn.


r~
---
 scripts/decodetree.py | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/scripts/decodetree.py b/scripts/decodetree.py
index 6a33f8f8dd..41301c84aa 100755
--- a/scripts/decodetree.py
+++ b/scripts/decodetree.py
@@ -461,7 +461,7 @@ class Pattern(General):
         global translate_prefix
         output('typedef ', self.base.base.struct_name(),
                ' arg_', self.name, ';\n')
-        output(translate_scope, 'void ', translate_prefix, '_', self.name,
+        output(translate_scope, 'bool ', translate_prefix, '_', self.name,
                '(DisasContext *ctx, arg_', self.name,
                ' *a, ', insntype, ' insn);\n')
 
@@ -474,9 +474,8 @@ class Pattern(General):
             output(ind, self.base.extract_name(), '(&u.f_', arg, ', insn);\n')
         for n, f in self.fields.items():
             output(ind, 'u.f_', arg, '.', n, ' = ', f.str_extract(), ';\n')
-        output(ind, translate_prefix, '_', self.name,
+        output(ind, 'return ', translate_prefix, '_', self.name,
                '(ctx, &u.f_', arg, ', insn);\n')
-        output(ind, 'return true;\n')
 # end Pattern
 
 
-- 
2.14.3
