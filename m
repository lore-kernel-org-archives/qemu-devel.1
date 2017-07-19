Received: from eggs.gnu.org ([2001:4830:134:3::10]:41559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXh3U-0003NQ-CJ
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:57:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXh3T-00028L-5T
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:57:48 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:35312)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXh3S-000287-VW
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:57:47 -0400
Received: by mail-pg0-x243.google.com with SMTP id d193so5425435pgc.2
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 21:57:46 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 18 Jul 2017 18:57:13 -1000
Message-Id: <20170719045722.25492-6-rth@twiddle.net>
In-Reply-To: <20170719045722.25492-1-rth@twiddle.net>
References: <20170719045722.25492-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 05/14] coccinelle: add a script to optimize tcg
 op using tcg_gen_extract()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

The following thread was helpful while writing this script:

    https://github.com/coccinelle/coccinelle/issues/86

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20170718045540.16322-3-f4bug@amsat.org>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 scripts/coccinelle/tcg_gen_extract.cocci | 107 +++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)
 create mode 100644 scripts/coccinelle/tcg_gen_extract.cocci

diff --git a/scripts/coccinelle/tcg_gen_extract.cocci b/scripts/coccinelle/tcg_gen_extract.cocci
new file mode 100644
index 0000000..81e66a3
--- /dev/null
+++ b/scripts/coccinelle/tcg_gen_extract.cocci
@@ -0,0 +1,107 @@
+// optimize TCG using extract op
+//
+// Copyright: (C) 2017 Philippe Mathieu-Daudé. GPLv2+.
+// Confidence: High
+// Options: --macro-file scripts/cocci-macro-file.h
+//
+// Nikunj A Dadhania optimization:
+// http://lists.nongnu.org/archive/html/qemu-devel/2017-02/msg05211.html
+// Aurelien Jarno optimization:
+// http://lists.nongnu.org/archive/html/qemu-devel/2017-05/msg01466.html
+//
+// This script can be run either using spatch locally or via a docker image:
+//
+// $ spatch \
+//     --macro-file scripts/cocci-macro-file.h \
+//     --sp-file scripts/coccinelle/tcg_gen_extract.cocci \
+//     --keep-comments --in-place \
+//     --use-gitgrep --dir target
+//
+// $ docker run --rm -v `pwd`:`pwd` -w `pwd` philmd/coccinelle \
+//     --macro-file scripts/cocci-macro-file.h \
+//     --sp-file scripts/coccinelle/tcg_gen_extract.cocci \
+//     --keep-comments --in-place \
+//     --use-gitgrep --dir target
+
+@initialize:python@
+@@
+import sys
+fd = sys.stderr
+def debug(msg="", trailer="\n"):
+    fd.write("[DBG] " + msg + trailer)
+def low_bits_count(value):
+    bits_count = 0
+    while (value & (1 << bits_count)):
+        bits_count += 1
+    return bits_count
+def Mn(order): # Mersenne number
+    return (1 << order) - 1
+
+@match@
+identifier ret;
+metavariable arg;
+constant ofs, msk;
+position shr_p, and_p;
+@@
+(
+    tcg_gen_shri_i32@shr_p
+|
+    tcg_gen_shri_i64@shr_p
+|
+    tcg_gen_shri_tl@shr_p
+)(ret, arg, ofs);
+...  WHEN != ret
+(
+    tcg_gen_andi_i32@and_p
+|
+    tcg_gen_andi_i64@and_p
+|
+    tcg_gen_andi_tl@and_p
+)(ret, ret, msk);
+
+@script:python verify_len depends on match@
+ret_s << match.ret;
+msk_s << match.msk;
+shr_p << match.shr_p;
+extract_len;
+@@
+is_optimizable = False
+debug("candidate at %s:%s" % (shr_p[0].file, shr_p[0].line))
+try: # only eval integer, no #define like 'SR_M' (cpp did this, else some headers are missing).
+    msk_v = long(msk_s.strip("UL"), 0)
+    msk_b = low_bits_count(msk_v)
+    if msk_b == 0:
+        debug("  value: 0x%x low_bits: %d" % (msk_v, msk_b))
+    else:
+        debug("  value: 0x%x low_bits: %d [Mersenne number: 0x%x]" % (msk_v, msk_b, Mn(msk_b)))
+        is_optimizable = Mn(msk_b) == msk_v # check low_bits
+        coccinelle.extract_len = "%d" % msk_b
+    debug("  candidate %s optimizable" % ("IS" if is_optimizable else "is NOT"))
+except:
+    debug("  ERROR (check included headers?)")
+cocci.include_match(is_optimizable)
+debug()
+
+@replacement depends on verify_len@
+identifier match.ret;
+metavariable match.arg;
+constant match.ofs, match.msk;
+position match.shr_p, match.and_p;
+identifier verify_len.extract_len;
+@@
+(
+-tcg_gen_shri_i32@shr_p(ret, arg, ofs);
++tcg_gen_extract_i32(ret, arg, ofs, extract_len);
+...  WHEN != ret
+-tcg_gen_andi_i32@and_p(ret, ret, msk);
+|
+-tcg_gen_shri_i64@shr_p(ret, arg, ofs);
++tcg_gen_extract_i64(ret, arg, ofs, extract_len);
+...  WHEN != ret
+-tcg_gen_andi_i64@and_p(ret, ret, msk);
+|
+-tcg_gen_shri_tl@shr_p(ret, arg, ofs);
++tcg_gen_extract_tl(ret, arg, ofs, extract_len);
+...  WHEN != ret
+-tcg_gen_andi_tl@and_p(ret, ret, msk);
+)
-- 
2.9.4
