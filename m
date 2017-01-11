Received: from eggs.gnu.org ([2001:4830:134:3::10]:55015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cRPOE-0006eC-VA
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 15:20:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cRPOE-00012B-7U
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 15:20:59 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:33731)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1cRPOE-000116-1Z
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 15:20:58 -0500
Received: by mail-wm0-x241.google.com with SMTP id r144so587501wme.0
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 12:20:57 -0800 (PST)
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Wed, 11 Jan 2017 21:19:44 +0100
Message-Id: <0fcf7eca7c2d3e6bef7846027857da3bd681645d.1484165352.git.atar4qemu@gmail.com>
In-Reply-To: <cover.1484165352.git.atar4qemu@gmail.com>
References: <cover.1484165352.git.atar4qemu@gmail.com>
In-Reply-To: <cover.1484165352.git.atar4qemu@gmail.com>
References: <cover.1484165352.git.atar4qemu@gmail.com>
Subject: [Qemu-devel] [PATCH v2 13/30] target-sparc: implement UA2005
 rdhpstate and wrhpstate instructions
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

Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
Reviewed-by: Richard Henderson <rth@twiddle.net>
---
 target/sparc/translate.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 68677d3..7e399a3 100644
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
1.8.3.1
