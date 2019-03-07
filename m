Received: from eggs.gnu.org ([209.51.188.92]:36681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1yC0-0001F3-UW
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:56:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1yC0-0002Pn-2R
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:56:32 -0500
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c]:45863)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1h1yBz-0002P3-RE
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:56:32 -0500
Received: by mail-pg1-x52c.google.com with SMTP id 125so11734010pgc.12
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 10:56:31 -0800 (PST)
Received: from cloudburst.twiddle.net (97-113-188-82.tukw.qwest.net.
	[97.113.188.82]) by smtp.gmail.com with ESMTPSA id
	g12sm8801973pgr.76.2019.03.07.10.56.29 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 07 Mar 2019 10:56:29 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  7 Mar 2019 10:56:15 -0800
Message-Id: <20190307185622.29026-6-richard.henderson@linaro.org>
In-Reply-To: <20190307185622.29026-1-richard.henderson@linaro.org>
References: <20190307185622.29026-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 05/12] decodetree: Do not unconditionaly
 return from Pattern.output_code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

As a consequence, the 'return false' gets pushed up one level.

This will allow us to perform some other action when the
translator returns failure.

Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 scripts/decodetree.py | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/scripts/decodetree.py b/scripts/decodetree.py
index e26d8253f2..cc5fa1a8ab 100755
--- a/scripts/decodetree.py
+++ b/scripts/decodetree.py
@@ -348,8 +348,8 @@ class Pattern(General):
             output(ind, self.base.extract_name(), '(&u.f_', arg, ', insn);\n')
         for n, f in self.fields.items():
             output(ind, 'u.f_', arg, '.', n, ' = ', f.str_extract(), ';\n')
-        output(ind, 'return ', translate_prefix, '_', self.name,
-               '(ctx, &u.f_', arg, ');\n')
+        output(ind, 'if (', translate_prefix, '_', self.name,
+               '(ctx, &u.f_', arg, ')) return true;\n')
 # end Pattern
 
 
@@ -777,8 +777,8 @@ class Tree:
             output(ind, '    /* ',
                    str_match_bits(innerbits, innermask), ' */\n')
             s.output_code(i + 4, extracted, innerbits, innermask)
+            output(ind, '    return false;\n')
         output(ind, '}\n')
-        output(ind, 'return false;\n')
 # end Tree
 
 
@@ -932,6 +932,7 @@ def main():
     output(i4, '} u;\n\n')
 
     t.output_code(4, False, 0, 0)
+    output(i4, 'return false;\n')
 
     output('}\n')
 
-- 
2.17.2
