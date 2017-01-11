Received: from eggs.gnu.org ([2001:4830:134:3::10]:55249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cRPOg-00077W-Q9
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 15:21:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cRPOf-0001U3-W6
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 15:21:26 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:35323)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1cRPOf-0001Sx-Pm
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 15:21:25 -0500
Received: by mail-wm0-x241.google.com with SMTP id l2so570795wml.2
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 12:21:25 -0800 (PST)
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Wed, 11 Jan 2017 21:19:58 +0100
Message-Id: <e38038f9bdd055002b01d71181fc7013c5c88b6a.1484165352.git.atar4qemu@gmail.com>
In-Reply-To: <cover.1484165352.git.atar4qemu@gmail.com>
References: <cover.1484165352.git.atar4qemu@gmail.com>
In-Reply-To: <cover.1484165352.git.atar4qemu@gmail.com>
References: <cover.1484165352.git.atar4qemu@gmail.com>
Subject: [Qemu-devel] [PATCH v2 27/30] target-sparc: add ST_BLKINIT_ ASIs
 for UA2005+ CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>

In OpenSPARC T1+ TWINX ASIs in store instructions are aliased
with Block Initializing Store ASIs.

"UltraSPARC T1 Supplement Draft D2.1, 14 May 2007" describes them
in the chapter "5.9 Block Initializing Store ASIs"

Integer stores of all sizes are allowed with these ASIs.

Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
---
 target/sparc/translate.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 53c327d..e929169 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2321,8 +2321,19 @@ static void gen_st_asi(DisasContext *dc, TCGv src, TCGv addr,
     case GET_ASI_EXCP:
         break;
     case GET_ASI_DTWINX: /* Reserved for stda.  */
+#ifndef TARGET_SPARC64
         gen_exception(dc, TT_ILL_INSN);
         break;
+#else
+        if (!(dc->def->features & CPU_FEATURE_HYPV)) {
+            /* Pre OpenSPARC CPUs don't have these */
+            gen_exception(dc, TT_ILL_INSN);
+            return;
+        }
+        /* in OpenSPARC T1+ CPUs TWINX ASIs in store instructions
+         * are ST_BLKINIT_ ASIs */
+        /* fall through */
+#endif
     case GET_ASI_DIRECT:
         gen_address_mask(dc, addr);
         tcg_gen_qemu_st_tl(src, addr, da.mem_idx, da.memop);
-- 
1.8.3.1
