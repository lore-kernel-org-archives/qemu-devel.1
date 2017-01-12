Received: from eggs.gnu.org ([2001:4830:134:3::10]:55745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cRVZL-0000YR-Un
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:56:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cRVZL-0006st-5K
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:56:52 -0500
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:36410)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cRVZL-0006sn-1L
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:56:51 -0500
Received: by mail-qk0-x241.google.com with SMTP id a20so940793qkc.3
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 18:56:50 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Wed, 11 Jan 2017 18:56:03 -0800
Message-Id: <20170112025606.27332-28-rth@twiddle.net>
In-Reply-To: <20170112025606.27332-1-rth@twiddle.net>
References: <20170112025606.27332-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 27/30] target-sparc: add ST_BLKINIT_ ASIs for
 UA2005+ CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: atar4qemu@gmail.com, mark.cave-ayland@ilande.co.uk, peter.maydell@linaro.org

From: Artyom Tarasenko <atar4qemu@gmail.com>

In OpenSPARC T1+ TWINX ASIs in store instructions are aliased
with Block Initializing Store ASIs.

"UltraSPARC T1 Supplement Draft D2.1, 14 May 2007" describes them
in the chapter "5.9 Block Initializing Store ASIs"

Integer stores of all sizes are allowed with these ASIs.

Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
Message-Id: <e38038f9bdd055002b01d71181fc7013c5c88b6a.1484165352.git.atar4qemu@gmail.com>
Signed-off-by: Richard Henderson <rth@twiddle.net>
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
2.9.3
