Received: from eggs.gnu.org ([2001:4830:134:3::10]:36962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cTytB-0006ae-I0
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 17:39:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cTyt9-0002lv-98
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 17:39:33 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:36232)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1cTyt9-0002ko-1X
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 17:39:31 -0500
Received: by mail-wm0-x242.google.com with SMTP id r126so7539126wmr.3
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 14:39:30 -0800 (PST)
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Wed, 18 Jan 2017 23:38:26 +0100
Message-Id: <1484779123-18968-14-git-send-email-atar4qemu@gmail.com>
In-Reply-To: <1484779123-18968-1-git-send-email-atar4qemu@gmail.com>
References: <1484779123-18968-1-git-send-email-atar4qemu@gmail.com>
Subject: [Qemu-devel] [PULL 13/30] target-sparc: implement UA2005 rdhpstate
 and wrhpstate instructions
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
 target/sparc/translate.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index a40c974..399a8ac 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -3468,7 +3468,8 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                 rs1 = GET_FIELD(insn, 13, 17);
                 switch (rs1) {
                 case 0: // hpstate
-                    // gen_op_rdhpstate();
+                    tcg_gen_ld_i64(cpu_dst, cpu_env,
+                                   offsetof(CPUSPARCState, hpstate));
                     break;
                 case 1: // htstate
                     // gen_op_rdhtstate();
@@ -4592,7 +4593,9 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                             tcg_gen_xor_tl(cpu_tmp0, cpu_src1, cpu_src2);
                             switch (rd) {
                             case 0: // hpstate
-                                // XXX gen_op_wrhpstate();
+                                tcg_gen_st_i64(cpu_tmp0, cpu_env,
+                                               offsetof(CPUSPARCState,
+                                                        hpstate));
                                 save_state(dc);
                                 gen_op_next_insn();
                                 tcg_gen_exit_tb(0);
-- 
2.7.2
