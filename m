Received: from eggs.gnu.org ([2001:4830:134:3::10]:36857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cTyt2-0006Sq-Hb
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 17:39:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cTyt1-0002fK-Qo
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 17:39:24 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:33199)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1cTyt1-0002em-L7
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 17:39:23 -0500
Received: by mail-wm0-x244.google.com with SMTP id r144so7567091wme.0
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 14:39:23 -0800 (PST)
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Wed, 18 Jan 2017 23:38:22 +0100
Message-Id: <1484779123-18968-10-git-send-email-atar4qemu@gmail.com>
In-Reply-To: <1484779123-18968-1-git-send-email-atar4qemu@gmail.com>
References: <1484779123-18968-1-git-send-email-atar4qemu@gmail.com>
Subject: [Qemu-devel] [PULL 09/30] target-sparc: implement UltraSPARC-T1
 Strand status ASR
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

Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
Reviewed-by: Richard Henderson <rth@twiddle.net>
---
 target/sparc/translate.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 729f4e2..8902e44 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -3429,6 +3429,17 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                 case 0x19: /* System tick compare */
                     gen_store_gpr(dc, rd, cpu_stick_cmpr);
                     break;
+                case 0x1a: /* UltraSPARC-T1 Strand status */
+                    /* XXX HYPV check maybe not enough, UA2005 & UA2007 describe
+                     * this ASR as impl. dep
+                     */
+                    CHECK_IU_FEATURE(dc, HYPV);
+                    {
+                        TCGv t = gen_dest_gpr(dc, rd);
+                        tcg_gen_movi_tl(t, 1UL);
+                        gen_store_gpr(dc, rd, t);
+                    }
+                    break;
                 case 0x10: /* Performance Control */
                 case 0x11: /* Performance Instrumentation Counter */
                 case 0x12: /* Dispatch Control */
-- 
2.7.2
