Received: from eggs.gnu.org ([2001:4830:134:3::10]:32979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d8Xs5-00086o-ME
	for qemu-devel@nongnu.org; Wed, 10 May 2017 16:06:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d8Xs4-0006OW-IC
	for qemu-devel@nongnu.org; Wed, 10 May 2017 16:06:05 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:33264)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d8Xs3-0006OP-TT
	for qemu-devel@nongnu.org; Wed, 10 May 2017 16:06:04 -0400
Received: by mail-qt0-x243.google.com with SMTP id a46so278095qte.0
	for <qemu-devel@nongnu.org>; Wed, 10 May 2017 13:06:03 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 10 May 2017 17:05:28 -0300
Message-Id: <20170510200535.13268-2-f4bug@amsat.org>
In-Reply-To: <20170510200535.13268-1-f4bug@amsat.org>
References: <20170510200535.13268-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 1/8] coccinelle: add a script to optimize tcg
 op using tcg_gen_extract()
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

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 scripts/coccinelle/tcg_gen_extract.cocci | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 scripts/coccinelle/tcg_gen_extract.cocci

diff --git a/scripts/coccinelle/tcg_gen_extract.cocci b/scripts/coccinelle/tcg_gen_extract.cocci
new file mode 100644
index 0000000000..4080f97cc7
--- /dev/null
+++ b/scripts/coccinelle/tcg_gen_extract.cocci
@@ -0,0 +1,26 @@
+// optimize TCG using extract op
+//
+// Copyright: (C) 2017 Philippe Mathieu-Daudé. GPLv2.
+// Confidence: High
+// Options: --macro-file scripts/cocci-macro-file.h
+@@
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
