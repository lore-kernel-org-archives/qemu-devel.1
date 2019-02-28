Received: from eggs.gnu.org ([209.51.188.92]:34060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gzEQY-00046y-4R
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 00:40:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gzEQX-0003rq-EY
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 00:40:14 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a]:43192)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gzEQX-0003oT-63
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 00:40:13 -0500
Received: by mail-pl1-x62a.google.com with SMTP id m10so9157948plt.10
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 21:40:11 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 27 Feb 2019 21:40:07 -0800
Message-Id: <20190228054007.779-1-richard.henderson@linaro.org>
In-Reply-To: <20190228052432.32571-1-richard.henderson@linaro.org>
References: <20190228052432.32571-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 9/8] decodetree: Produce clean output for an
 empty input file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: f4bug@amsat.org

This is interesting for bisection, where an output file is plumbed,
but does not yet have patterns.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---

One more small fix that should have gone with the v2 patchset.

---
 scripts/decodetree.py | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/scripts/decodetree.py b/scripts/decodetree.py
index 68979b73a0..1785769eec 100755
--- a/scripts/decodetree.py
+++ b/scripts/decodetree.py
@@ -1050,15 +1050,16 @@ def main():
            '(DisasContext *ctx, ', insntype, ' insn)\n{\n')
 
     i4 = str_indent(4)
-    output(i4, 'union {\n')
-    for n in sorted(arguments.keys()):
-        f = arguments[n]
-        output(i4, i4, f.struct_name(), ' f_', f.name, ';\n')
-    output(i4, '} u;\n\n')
 
-    t.output_code(4, False, 0, 0)
+    if len(allpatterns) != 0:
+        output(i4, 'union {\n')
+        for n in sorted(arguments.keys()):
+            f = arguments[n]
+            output(i4, i4, f.struct_name(), ' f_', f.name, ';\n')
+        output(i4, '} u;\n\n')
+        t.output_code(4, False, 0, 0)
+
     output(i4, 'return false;\n')
-
     output('}\n')
 
     if output_file:
-- 
2.17.2
