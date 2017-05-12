Received: from eggs.gnu.org ([2001:4830:134:3::10]:44792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d9K9F-0008Ol-6Q
	for qemu-devel@nongnu.org; Fri, 12 May 2017 19:39:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d9K9D-0002Tu-RG
	for qemu-devel@nongnu.org; Fri, 12 May 2017 19:39:01 -0400
Received: from mail-qt0-x22a.google.com ([2607:f8b0:400d:c0d::22a]:36462)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d9K9D-0002T7-Lm
	for qemu-devel@nongnu.org; Fri, 12 May 2017 19:38:59 -0400
Received: by mail-qt0-x22a.google.com with SMTP id f55so11050777qta.3
	for <qemu-devel@nongnu.org>; Fri, 12 May 2017 16:38:59 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 12 May 2017 20:38:38 -0300
Message-Id: <20170512233843.27713-2-f4bug@amsat.org>
In-Reply-To: <20170512233843.27713-1-f4bug@amsat.org>
References: <20170512233843.27713-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH v4 1/6] coccinelle: add a script to
 optimize tcg op using tcg_gen_extract()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Markus Elfring <elfring@users.sourceforge.net>, Julia Lawall <julia.lawall@lip6.fr>, Nicolas Palix <nicolas.palix@imag.fr>

If you have coccinelle installed you can apply this script using:

    $ spatch \
        --macro-file scripts/cocci-macro-file.h \
        --dir target --in-place

You can also use directly Peter Senna Tschudin docker image (easier):

    $ docker run -v `pwd`:`pwd` -w `pwd` petersenna/coccinelle \
        --sp-file scripts/coccinelle/tcg_gen_extract.cocci \
        --macro-file scripts/cocci-macro-file.h \
        --dir target --in-place

Then verified that no manual touchups are required.

The following thread was helpful while writing this script:

    https://github.com/coccinelle/coccinelle/issues/86

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 scripts/coccinelle/tcg_gen_extract.cocci | 103 +++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)
 create mode 100644 scripts/coccinelle/tcg_gen_extract.cocci

diff --git a/scripts/coccinelle/tcg_gen_extract.cocci b/scripts/coccinelle/tcg_gen_extract.cocci
new file mode 100644
index 0000000000..37546834ee
--- /dev/null
+++ b/scripts/coccinelle/tcg_gen_extract.cocci
@@ -0,0 +1,103 @@
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
+// Coccinelle helpful issue:
+// https://github.com/coccinelle/coccinelle/issues/86
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
+@match@ // depends on never match_and_check_reg_used@
+metavariable ret, arg;
+constant ofs, msk;
+expression tcg_arg;
+identifier tcg_func =~ "^tcg_gen_";
+position shr_p, and_p;
+@@
+(
+    tcg_gen_shri_i32@shr_p
+|
+    tcg_gen_shri_i64@shr_p
+|
+    tcg_gen_shri_tl@shr_p
+)(ret, arg, ofs);
+<...
+tcg_func(tcg_arg, ...);
+...>
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
+tcg_func << match.tcg_func;
+tcg_arg << match.tcg_arg;
+extract_len;
+@@
+is_optimizable = False
+debug("candidate at %s:%s" % (shr_p[0].file, shr_p[0].line))
+if tcg_arg == ret_s:
+        debug("  %s() modifies argument '%s'" % (tcg_func, ret_s))
+else:
+    debug("candidate at %s:%s" % (shr_p[0].file, shr_p[0].line))
+    try: # only eval integer, no #define like 'SR_M' (cpp did this, else some headers are missing).
+        msk_v = long(msk_s.strip("UL"), 0)
+        msk_b = low_bits_count(msk_v)
+        if msk_b == 0:
+            debug("  value: 0x%x low_bits: %d" % (msk_v, msk_b))
+        else:
+            debug("  value: 0x%x low_bits: %d [Mersenne prime: 0x%x]" % (msk_v, msk_b, Mn(msk_b)))
+            is_optimizable = Mn(msk_b) == msk_v # check low_bits
+            coccinelle.extract_len = "%d" % msk_b
+        debug("  candidate %s optimizable" % ("IS" if is_optimizable else "is NOT"))
+    except:
+        debug("  ERROR (check included headers?)")
+cocci.include_match(is_optimizable)
+debug()
+
+@replacement depends on verify_len@
+metavariable match.ret, match.arg;
+constant match.ofs, match.msk;
+position match.shr_p, match.and_p;
+identifier verify_len.extract_len;
+@@
+(
+-tcg_gen_shri_i32@shr_p(ret, arg, ofs);
++tcg_gen_extract_i32(ret, arg, ofs, extract_len);
+...
+-tcg_gen_andi_i32@and_p(ret, ret, msk);
+|
+-tcg_gen_shri_i64@shr_p(ret, arg, ofs);
++tcg_gen_extract_i64(ret, arg, ofs, extract_len);
+...
+-tcg_gen_andi_i64@and_p(ret, ret, msk);
+|
+-tcg_gen_shri_tl@shr_p(ret, arg, ofs);
++tcg_gen_extract_tl(ret, arg, ofs, extract_len);
+...
+-tcg_gen_andi_tl@and_p(ret, ret, msk);
+)
-- 
2.11.0
