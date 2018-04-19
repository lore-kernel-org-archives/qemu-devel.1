Received: from eggs.gnu.org ([2001:4830:134:3::10]:39456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1f97dE-0006Kp-N0
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 07:21:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1f97d9-00082q-TU
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 07:21:40 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:35004)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1f97d9-00081U-Ln
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 07:21:35 -0400
Received: by mail-lf0-x243.google.com with SMTP id r125-v6so273179lfe.2
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 04:21:35 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Thu, 19 Apr 2018 13:21:27 +0200
Message-Id: <20180419112131.16932-2-edgar.iglesias@gmail.com>
In-Reply-To: <20180419112131.16932-1-edgar.iglesias@gmail.com>
References: <20180419112131.16932-1-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v1 1/5] target-microblaze: Respect MSR.PVR as
 read-only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, sai.pavan.boddu@xilinx.com, alistair@alistair23.me, frasse.iglesias@gmail.com, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Respect MSR.PVR as read-only. We were wrongly overwriting the PVR bit.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/cpu.h       | 4 +++-
 target/microblaze/translate.c | 8 +-------
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 5be71bc320..0eb9e2b8e2 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -59,6 +59,8 @@ typedef struct CPUMBState CPUMBState;
 #define SR_EDR   0xd
 
 /* MSR flags.  */
+#define MSR_PVR_SHIFT 10
+
 #define MSR_BE  (1<<0) /* 0x001 */
 #define MSR_IE  (1<<1) /* 0x002 */
 #define MSR_C   (1<<2) /* 0x004 */
@@ -69,7 +71,7 @@ typedef struct CPUMBState CPUMBState;
 #define MSR_DCE (1<<7) /* 0x080 */
 #define MSR_EE  (1<<8) /* 0x100 */
 #define MSR_EIP (1<<9) /* 0x200 */
-#define MSR_PVR (1<<10) /* 0x400 */
+#define MSR_PVR (1 << MSR_PVR_SHIFT)
 #define MSR_CC  (1<<31)
 
 /* Machine State Register (MSR) Fields */
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 7628b0e25b..df62563815 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -417,15 +417,9 @@ static inline void msr_read(DisasContext *dc, TCGv d)
 
 static inline void msr_write(DisasContext *dc, TCGv v)
 {
-    TCGv t;
-
-    t = tcg_temp_new();
     dc->cpustate_changed = 1;
     /* PVR bit is not writable.  */
-    tcg_gen_andi_tl(t, v, ~MSR_PVR);
-    tcg_gen_andi_tl(cpu_SR[SR_MSR], cpu_SR[SR_MSR], MSR_PVR);
-    tcg_gen_or_tl(cpu_SR[SR_MSR], cpu_SR[SR_MSR], v);
-    tcg_temp_free(t);
+    tcg_gen_deposit_tl(cpu_SR[SR_MSR], v, cpu_SR[SR_MSR], MSR_PVR_SHIFT, 1);
 }
 
 static void dec_msr(DisasContext *dc)
-- 
2.14.1
