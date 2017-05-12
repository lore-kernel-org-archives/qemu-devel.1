Received: from eggs.gnu.org ([2001:4830:134:3::10]:47208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d91ND-0006U2-0A
	for qemu-devel@nongnu.org; Thu, 11 May 2017 23:36:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d91NB-0003bN-Tp
	for qemu-devel@nongnu.org; Thu, 11 May 2017 23:36:11 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:35783)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d91NB-0003bE-Pl
	for qemu-devel@nongnu.org; Thu, 11 May 2017 23:36:09 -0400
Received: by mail-qk0-x243.google.com with SMTP id k74so6323280qke.2
	for <qemu-devel@nongnu.org>; Thu, 11 May 2017 20:36:09 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 12 May 2017 00:35:39 -0300
Message-Id: <20170512033543.6789-2-f4bug@amsat.org>
In-Reply-To: <20170512033543.6789-1-f4bug@amsat.org>
References: <20170512033543.6789-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH v3 1/5] coccinelle: add a script to
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
 scripts/coccinelle/tcg_gen_extract.cocci | 71 ++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100644 scripts/coccinelle/tcg_gen_extract.cocci

diff --git a/scripts/coccinelle/tcg_gen_extract.cocci b/scripts/coccinelle/tcg_gen_extract.cocci
new file mode 100644
index 0000000000..4823073005
--- /dev/null
+++ b/scripts/coccinelle/tcg_gen_extract.cocci
@@ -0,0 +1,71 @@
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
+@match@ // match shri*+andi* pattern, calls script verify_len
+identifier ret, arg;
+constant ofs, len;
+identifier shr_fn =~ "^tcg_gen_shri_";
+identifier and_fn =~ "^tcg_gen_andi_";
+position shr_p;
+position and_p;
+@@
+(
+shr_fn@shr_p(ret, arg, ofs);
+and_fn@and_p(ret, ret, len);
+)
+
+@script:python verify_len@
+ret_s << match.ret;
+len_s << match.len;
+shr_s << match.shr_fn;
+and_s << match.and_fn;
+shr_p << match.shr_p;
+extract_fn;
+@@
+print "candidate at %s:%s" % (shr_p[0].file, shr_p[0].line)
+len_fn=len("tcg_gen_shri_")
+shr_sz=shr_s[len_fn:]
+and_sz=and_s[len_fn:]
+# TODO: op_size shr<and allowed?
+is_same_op_size = shr_sz == and_sz
+print "  op_size: %s/%s (%s)" % (shr_sz, and_sz, "same" if is_same_op_size else "DIFFERENT")
+is_optimizable = False
+if is_same_op_size:
+    try: # only eval integer, no #define like 'SR_M' (cpp did this, else some headers are missing).
+        len_v = long(len_s.strip("UL"), 0)
+        low_bits = 0
+        while (len_v & (1 << low_bits)):
+            low_bits += 1
+        print "  low_bits:", low_bits, "(value: 0x%x)" % ((1 << low_bits) - 1)
+        print "  len: 0x%x" % len_v
+        is_optimizable = ((1 << low_bits) - 1) == len_v # check low_bits
+        print "  len_bits %s= low_bits" % ("=" if is_optimizable else "!")
+        print "  candidate", "IS" if is_optimizable else "is NOT", "optimizable"
+        coccinelle.extract_fn = "tcg_gen_extract_" + and_sz
+    except:
+        print "  ERROR (check included headers?)"
+    cocci.include_match(is_optimizable)
+print
+
+@replacement depends on verify_len@
+identifier match.ret, match.arg;
+constant match.ofs, match.len;
+identifier match.shr_fn;
+identifier match.and_fn;
+position match.shr_p;
+position match.and_p;
+identifier verify_len.extract_fn;
+@@
+-shr_fn@shr_p(ret, arg, ofs);
+-and_fn@and_p(ret, ret, len);
++extract_fn(ret, arg, ofs, len);
-- 
2.11.0
