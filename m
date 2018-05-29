Received: from eggs.gnu.org ([2001:4830:134:3::10]:37039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fNcDO-0001dv-SD
	for qemu-devel@nongnu.org; Tue, 29 May 2018 06:50:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fNcDN-00049M-VM
	for qemu-devel@nongnu.org; Tue, 29 May 2018 06:50:54 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:35396)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1fNcDN-000490-Nw
	for qemu-devel@nongnu.org; Tue, 29 May 2018 06:50:53 -0400
Received: by mail-wr0-x22a.google.com with SMTP id i14-v6so24685599wre.2
	for <qemu-devel@nongnu.org>; Tue, 29 May 2018 03:50:53 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Tue, 29 May 2018 12:49:56 +0200
Message-Id: <20180529105011.1914-24-edgar.iglesias@gmail.com>
In-Reply-To: <20180529105011.1914-1-edgar.iglesias@gmail.com>
References: <20180529105011.1914-1-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PULL v1 23/38] target-microblaze: Implement MFSE EAR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Implement MFSE EAR to enable access to the upper part of EAR.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/translate.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 504db88890..7475003847 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -459,7 +459,7 @@ static void dec_msr(DisasContext *dc)
     CPUState *cs = CPU(dc->cpu);
     TCGv_i32 t0, t1;
     unsigned int sr, rn;
-    bool to, clrset;
+    bool to, clrset, extended;
 
     sr = extract32(dc->imm, 0, 14);
     to = extract32(dc->imm, 14, 1);
@@ -467,6 +467,9 @@ static void dec_msr(DisasContext *dc)
     dc->type_b = 1;
     if (to) {
         dc->cpustate_changed = 1;
+        extended = extract32(dc->imm, 24, 1);
+    } else {
+        extended = extract32(dc->imm, 19, 1);
     }
 
     /* msrclr and msrset.  */
@@ -559,6 +562,10 @@ static void dec_msr(DisasContext *dc)
                 msr_read(dc, cpu_R[dc->rd]);
                 break;
             case SR_EAR:
+                if (extended) {
+                    tcg_gen_extrh_i64_i32(cpu_R[dc->rd], cpu_SR[sr]);
+                    break;
+                }
             case SR_ESR:
             case SR_FSR:
             case SR_BTR:
-- 
2.14.1
