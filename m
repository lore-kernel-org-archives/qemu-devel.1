Received: from eggs.gnu.org ([2001:4830:134:3::10]:35704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cR8VI-0006gR-5c
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:19:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cR8VH-0003YI-Dx
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:19:08 -0500
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:35097)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cR8VH-0003X8-8j
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:19:07 -0500
Received: by mail-pf0-x242.google.com with SMTP id f144so12526548pfa.2
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 18:19:07 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 10 Jan 2017 18:18:08 -0800
Message-Id: <20170111021820.24416-54-rth@twiddle.net>
In-Reply-To: <20170111021820.24416-1-rth@twiddle.net>
References: <20170111021820.24416-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 53/65] target-xtensa: Use clrsb helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/xtensa/translate.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 5c719a4..5a93705 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -1372,16 +1372,7 @@ static void disas_xtensa_insn(CPUXtensaState *env, DisasContext *dc)
                 case 14: /*NSAu*/
                     HAS_OPTION(XTENSA_OPTION_MISC_OP_NSA);
                     if (gen_window_check2(dc, RRR_S, RRR_T)) {
-                        TCGv_i32 t0 = tcg_temp_new_i32();
-
-                        /* if (v & 0x80000000) v = ~v; */
-                        tcg_gen_sari_i32(t0, cpu_R[RRR_S], 31);
-                        tcg_gen_xor_i32(t0, t0, cpu_R[RRR_S]);
-
-                        /* r = (v ? clz(v) : 32) - 1; */
-                        tcg_gen_clzi_i32(t0, t0, 32);
-                        tcg_gen_subi_i32(cpu_R[RRR_T], t0, 1);
-                        tcg_temp_free_i32(t0);
+                        tcg_gen_clrsb_i32(cpu_R[RRR_T], cpu_R[RRR_S]);
                     }
                     break;
 
-- 
2.9.3
