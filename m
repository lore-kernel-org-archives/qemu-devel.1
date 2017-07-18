Received: from eggs.gnu.org ([2001:4830:134:3::10]:43170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXKY9-0004Yz-Vp
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 00:55:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXKY8-0004BA-T9
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 00:55:58 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:34650)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXKY8-0004Ab-OT
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 00:55:56 -0400
Received: by mail-qk0-x241.google.com with SMTP id q66so1228915qki.1
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 21:55:56 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 18 Jul 2017 01:55:32 -0300
Message-Id: <20170718045540.16322-3-f4bug@amsat.org>
In-Reply-To: <20170718045540.16322-1-f4bug@amsat.org>
References: <20170718045540.16322-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 02/10] coccinelle: add a script to optimize
 tcg op using tcg_gen_extract()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Laurent Vivier <laurent@vivier.eu>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

The following thread was helpful while writing this script:

    https://github.com/coccinelle/coccinelle/issues/86

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 scripts/coccinelle/tcg_gen_extract.cocci | 107 +++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)
 create mode 100644 scripts/coccinelle/tcg_gen_extract.cocci

diff --git a/scripts/coccinelle/tcg_gen_extract.cocci b/scripts/coccinelle/tcg_gen_extract.cocci
new file mode 100644
index 0000000000..81e66a35ae
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
2.13.2
