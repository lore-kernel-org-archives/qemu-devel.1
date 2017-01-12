Received: from eggs.gnu.org ([2001:4830:134:3::10]:55522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cRVZ1-0007y5-BQ
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:56:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cRVZ0-0006n7-8f
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:56:31 -0500
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:34626)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cRVZ0-0006mw-4V
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:56:30 -0500
Received: by mail-qk0-x243.google.com with SMTP id e1so952077qkh.1
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 18:56:29 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Wed, 11 Jan 2017 18:55:49 -0800
Message-Id: <20170112025606.27332-14-rth@twiddle.net>
In-Reply-To: <20170112025606.27332-1-rth@twiddle.net>
References: <20170112025606.27332-1-rth@twiddle.net>
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
To: qemu-devel@nongnu.org
Cc: atar4qemu@gmail.com, mark.cave-ayland@ilande.co.uk, peter.maydell@linaro.org

From: Artyom Tarasenko <atar4qemu@gmail.com>

Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Message-Id: <0fcf7eca7c2d3e6bef7846027857da3bd681645d.1484165352.git.atar4qemu@gmail.com>
Signed-off-by: Richard Henderson <rth@twiddle.net>
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
2.9.3
