Received: from eggs.gnu.org ([2001:4830:134:3::10]:44108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fG6TQ-0008OK-Kz
	for qemu-devel@nongnu.org; Tue, 08 May 2018 13:32:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fG6TP-0005S9-RO
	for qemu-devel@nongnu.org; Tue, 08 May 2018 13:32:24 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:43841)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1fG6TP-0005RW-JA
	for qemu-devel@nongnu.org; Tue, 08 May 2018 13:32:23 -0400
Received: by mail-lf0-x241.google.com with SMTP id g12-v6so47036263lfb.10
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 10:32:23 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Tue,  8 May 2018 19:31:34 +0200
Message-Id: <20180508173152.29327-19-edgar.iglesias@gmail.com>
In-Reply-To: <20180508173152.29327-1-edgar.iglesias@gmail.com>
References: <20180508173152.29327-1-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v2 18/36] target-microblaze: dec_msr: Reuse
 more code when reg-decoding
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org, frederic.konrad@adacore.com, alistair@alistair23.me, frasse.iglesias@gmail.com, sai.pavan.boddu@xilinx.com, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Reuse more code when decoding register numbers.

No functional changes.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/translate.c | 38 +++++++++-----------------------------
 1 file changed, 9 insertions(+), 29 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 0593aff692..0582568992 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -531,11 +531,9 @@ static void dec_msr(DisasContext *dc)
             case 1:
                 msr_write(dc, cpu_R[dc->ra]);
                 break;
-            case 0x3:
-                tcg_gen_mov_i32(cpu_SR[SR_EAR], cpu_R[dc->ra]);
-                break;
-            case 0x5:
-                tcg_gen_mov_i32(cpu_SR[SR_ESR], cpu_R[dc->ra]);
+            case SR_EAR:
+            case SR_ESR:
+                tcg_gen_mov_i32(cpu_SR[sr], cpu_R[dc->ra]);
                 break;
             case 0x7:
                 tcg_gen_andi_i32(cpu_SR[SR_FSR], cpu_R[dc->ra], 31);
@@ -562,17 +560,11 @@ static void dec_msr(DisasContext *dc)
             case 1:
                 msr_read(dc, cpu_R[dc->rd]);
                 break;
-            case 0x3:
-                tcg_gen_mov_i32(cpu_R[dc->rd], cpu_SR[SR_EAR]);
-                break;
-            case 0x5:
-                tcg_gen_mov_i32(cpu_R[dc->rd], cpu_SR[SR_ESR]);
-                break;
-             case 0x7:
-                tcg_gen_mov_i32(cpu_R[dc->rd], cpu_SR[SR_FSR]);
-                break;
-            case 0xb:
-                tcg_gen_mov_i32(cpu_R[dc->rd], cpu_SR[SR_BTR]);
+            case SR_EAR:
+            case SR_ESR:
+            case SR_FSR:
+            case SR_BTR:
+                tcg_gen_mov_i32(cpu_R[dc->rd], cpu_SR[sr]);
                 break;
             case 0x800:
                 tcg_gen_ld_i32(cpu_R[dc->rd],
@@ -582,19 +574,7 @@ static void dec_msr(DisasContext *dc)
                 tcg_gen_ld_i32(cpu_R[dc->rd],
                                cpu_env, offsetof(CPUMBState, shr));
                 break;
-            case 0x2000:
-            case 0x2001:
-            case 0x2002:
-            case 0x2003:
-            case 0x2004:
-            case 0x2005:
-            case 0x2006:
-            case 0x2007:
-            case 0x2008:
-            case 0x2009:
-            case 0x200a:
-            case 0x200b:
-            case 0x200c:
+            case 0x2000 ... 0x200c:
                 rn = sr & 0xf;
                 tcg_gen_ld_i32(cpu_R[dc->rd],
                               cpu_env, offsetof(CPUMBState, pvr.regs[rn]));
-- 
2.14.1
