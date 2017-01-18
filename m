Received: from eggs.gnu.org ([2001:4830:134:3::10]:37311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cTytZ-0006yU-KJ
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 17:39:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cTytZ-00033k-0P
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 17:39:57 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:33255)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1cTytY-00033B-Q9
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 17:39:56 -0500
Received: by mail-wm0-x241.google.com with SMTP id r144so7569830wme.0
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 14:39:56 -0800 (PST)
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Wed, 18 Jan 2017 23:38:40 +0100
Message-Id: <1484779123-18968-28-git-send-email-atar4qemu@gmail.com>
In-Reply-To: <1484779123-18968-1-git-send-email-atar4qemu@gmail.com>
References: <1484779123-18968-1-git-send-email-atar4qemu@gmail.com>
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
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, mark.cave-ayland@ilande.co.uk, rth@twiddle.net, Artyom Tarasenko <atar4qemu@gmail.com>

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
index 0f20ed0..655060c 100644
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
2.7.2
