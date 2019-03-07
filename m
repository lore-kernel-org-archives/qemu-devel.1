Received: from eggs.gnu.org ([209.51.188.92]:36767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1yC5-0001MO-Of
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:56:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1yC4-0002V8-VK
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:56:37 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d]:44143)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1h1yC4-0002UX-Nt
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:56:36 -0500
Received: by mail-pf1-x42d.google.com with SMTP id a3so12127032pff.11
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 10:56:36 -0800 (PST)
Received: from cloudburst.twiddle.net (97-113-188-82.tukw.qwest.net.
	[97.113.188.82]) by smtp.gmail.com with ESMTPSA id
	g12sm8801973pgr.76.2019.03.07.10.56.34 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 07 Mar 2019 10:56:34 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  7 Mar 2019 10:56:19 -0800
Message-Id: <20190307185622.29026-10-richard.henderson@linaro.org>
In-Reply-To: <20190307185622.29026-1-richard.henderson@linaro.org>
References: <20190307185622.29026-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 09/12] decodetree: Produce clean output for
 an empty input file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This is interesting for bisection, where an output file is plumbed,
but does not yet have patterns.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 scripts/decodetree.py | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/scripts/decodetree.py b/scripts/decodetree.py
index d6f94d902f..57d4c9297e 100755
--- a/scripts/decodetree.py
+++ b/scripts/decodetree.py
@@ -1046,15 +1046,16 @@ def main():
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
