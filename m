Received: from eggs.gnu.org ([2001:4830:134:3::10]:52330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d8bP8-0000Ix-U6
	for qemu-devel@nongnu.org; Wed, 10 May 2017 19:52:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d8bP5-0007y3-1v
	for qemu-devel@nongnu.org; Wed, 10 May 2017 19:52:27 -0400
Received: from mail-qt0-x22a.google.com ([2607:f8b0:400d:c0d::22a]:33412)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d8bP4-0007xo-SS
	for qemu-devel@nongnu.org; Wed, 10 May 2017 19:52:22 -0400
Received: by mail-qt0-x22a.google.com with SMTP id t26so5392724qtg.0
	for <qemu-devel@nongnu.org>; Wed, 10 May 2017 16:52:22 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 10 May 2017 20:52:04 -0300
Message-Id: <20170510235204.9657-1-f4bug@amsat.org>
In-Reply-To: <0f1f5bcd-815a-c070-5ba7-281f5a0ee146@twiddle.net>
References: <0f1f5bcd-815a-c070-5ba7-281f5a0ee146@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH v2] coccinelle: add a script to optimize
 tcg op using tcg_gen_extract()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Apply this script using:

$ docker run -v `pwd`:`pwd` -w `pwd` petersenna/coccinelle \
    --sp-file scripts/coccinelle/tcg_gen_extract.cocci \
    --macro-file scripts/cocci-macro-file.h \
    --dir target \
    --in-place

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---

This is a new version of the coccinelle script addressing Richard comments and
trying to do it correctly. Also changed license to GPLv2+.

The first rule matches, it calls a python2 script that basically checks the
target_ulong is not overflowed: (msk << ofs) >> sizeof(target_ulong) == 0 

I think this is enough but if I'm wrong I can try to do as Richard suggested
(counting the low bits).

If this rule fails, there is no further processing, else the 3rd rule doing the
patch is called.
I couldn't figure still how to reuse args from rule2 in rule3 so it is mostly a
copy of rule1.

I also don't know yet how to process target-generic functions (ending _tl
instead of _32 or _64) eventually the correct --include-option may resolve this.

Applied it verified the ARM/M68K/PPC patches (2,3,5,7 from serie v1).
The other archs weren't patched since they use _tl generic functions.

I apologize for my python!

Regards,

Phil.

 scripts/coccinelle/tcg_gen_extract.cocci | 61 ++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 scripts/coccinelle/tcg_gen_extract.cocci

diff --git a/scripts/coccinelle/tcg_gen_extract.cocci b/scripts/coccinelle/tcg_gen_extract.cocci
new file mode 100644
index 0000000000..d75ef7d98c
--- /dev/null
+++ b/scripts/coccinelle/tcg_gen_extract.cocci
@@ -0,0 +1,61 @@
+// optimize TCG using extract op
+//
+// Copyright: (C) 2017 Philippe Mathieu-Daudé. GPLv2+.
+// Confidence: Low
+// Options: --macro-file scripts/cocci-macro-file.h
+
+@match@ // match shri*+andi* pattern, calls script check_len_correct
+identifier ret, arg;
+constant ofs, len;
+identifier tcg_gen_shri =~ "^tcg_gen_shri_";
+identifier tcg_gen_andi =~ "^tcg_gen_andi_";
+position p;
+@@
+(
+tcg_gen_shri(ret, arg, ofs);
+tcg_gen_andi(ret, ret, len);@p
+)
+
+@script:python check_len_correct@
+ret_s << match.ret;
+arg_s << match.arg;
+ofs_s << match.ofs;
+msk_s << match.len;
+shr_s << match.tcg_gen_shri;
+and_s << match.tcg_gen_andi;
+@@
+try:
+    # only eval integer, no #define like 'SR_M'
+    ofs = long(ofs_s, 0)
+    msk = long(msk_s, 0)
+    # get op_size: 32/64
+    shr_sz = int(shr_s[-2:])
+    and_sz = int(and_s[-2:])
+    # op_size shr<and allowed
+    # check overflow
+    if shr_sz > and_sz or (msk << ofs) >> and_sz:
+        cocci.include_match(False) # no further process
+except ValueError: # op_size: "tl" not handled yet
+    cocci.include_match(False) # no further process
+
+@use_extract depends on check_len_correct@ // ofs/len are valid, we can replace
+identifier ret, arg;
+constant ofs, len;
+@@
+(
+// from Nikunj A Dadhania comment:
+// http://lists.nongnu.org/archive/html/qemu-devel/2017-02/msg05211.html
+-tcg_gen_shri_tl(ret, arg, ofs);
+-tcg_gen_andi_tl(ret, ret, len);
++tcg_gen_extract_tl(ret, arg, ofs, len);
+|
+// from Aurelien Jarno comment:
+// http://lists.nongnu.org/archive/html/qemu-devel/2017-05/msg01466.html
+-tcg_gen_shri_i32(ret, arg, ofs);
+-tcg_gen_andi_i32(ret, ret, len);
++tcg_gen_extract_i32(ret, arg, ofs, len);
+|
+-tcg_gen_shri_i64(ret, arg, ofs);
+-tcg_gen_andi_i64(ret, ret, len);
++tcg_gen_extract_i64(ret, arg, ofs, len);
+)
-- 
2.11.0
