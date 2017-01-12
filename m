Received: from eggs.gnu.org ([2001:4830:134:3::10]:55464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cRVYv-0007sQ-Vt
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:56:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cRVYv-0006lj-2h
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:56:26 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:35137)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cRVYu-0006lT-UW
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:56:24 -0500
Received: by mail-qt0-x241.google.com with SMTP id f4so837965qte.2
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 18:56:24 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Wed, 11 Jan 2017 18:55:45 -0800
Message-Id: <20170112025606.27332-10-rth@twiddle.net>
In-Reply-To: <20170112025606.27332-1-rth@twiddle.net>
References: <20170112025606.27332-1-rth@twiddle.net>
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
To: qemu-devel@nongnu.org
Cc: atar4qemu@gmail.com, mark.cave-ayland@ilande.co.uk, peter.maydell@linaro.org

From: Artyom Tarasenko <atar4qemu@gmail.com>

Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Message-Id: <b6e87ef140bad7b6442f8665275bed540ec85096.1484165352.git.atar4qemu@gmail.com>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/sparc/translate.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 0b0cde1..b898898 100644
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
2.9.3
