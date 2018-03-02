Received: from eggs.gnu.org ([2001:4830:134:3::10]:43261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eriWU-0002kx-6C
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:06:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eriWT-0004kr-9d
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:06:46 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46746)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eriWT-0004jE-29
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:06:45 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eriWR-0001JE-Th
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 11:06:43 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  2 Mar 2018 11:06:05 +0000
Message-Id: <20180302110640.28004-5-peter.maydell@linaro.org>
In-Reply-To: <20180302110640.28004-1-peter.maydell@linaro.org>
References: <20180302110640.28004-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 04/39] decodetree: Propagate return value from
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

From: Richard Henderson <richard.henderson@linaro.org>

Allow the translate subroutines to return false for invalid insns.

At present we can of course invoke an invalid insn exception from within
the translate subroutine, but in the short term this consolidates code.
In the long term it would allow the decodetree language to support
overlapping patterns for ISA extensions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180227232618.2908-1-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
2.16.2
