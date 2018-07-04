Received: from eggs.gnu.org ([2001:4830:134:3::10]:40509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1famLL-0005p4-HP
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 14:17:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1famLI-0001OC-Vj
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 14:17:31 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:35348 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1famLI-0001Mg-KK
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 14:17:28 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Wed,  4 Jul 2018 20:17:15 +0200
Message-Id: <1530728238-5608-6-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1530728238-5608-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1530728238-5608-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v2 5/8] target/mips: Add CP0 BadInstrX register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

From: Stefan Markovic <stefan.markovic@wavecomp.com>

Add CP0 BadInstrX register. This register will be used in nanoMIPS.

Signed-off-by: Stefan Markovic <stefan.markovic@wavecomp.com>
Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@wavecomp.com>
---
 target/mips/cpu.h       |  1 +
 target/mips/machine.c   |  5 +++--
 target/mips/translate.c | 20 +++++++++++++++++++-
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index edbb66d..8ccbc21 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -323,6 +323,7 @@ struct CPUMIPSState {
     target_ulong CP0_BadVAddr;
     uint32_t CP0_BadInstr;
     uint32_t CP0_BadInstrP;
+    uint32_t CP0_BadInstrX;
     int32_t CP0_Count;
     target_ulong CP0_EntryHi;
 #define CP0EnHi_EHINV 10
diff --git a/target/mips/machine.c b/target/mips/machine.c
index 20100d5..5ba78ac 100644
--- a/target/mips/machine.c
+++ b/target/mips/machine.c
@@ -212,8 +212,8 @@ const VMStateDescription vmstate_tlb = {
 
 const VMStateDescription vmstate_mips_cpu = {
     .name = "cpu",
-    .version_id = 10,
-    .minimum_version_id = 10,
+    .version_id = 11,
+    .minimum_version_id = 11,
     .post_load = cpu_post_load,
     .fields = (VMStateField[]) {
         /* Active TC */
@@ -266,6 +266,7 @@ const VMStateDescription vmstate_mips_cpu = {
         VMSTATE_UINTTL(env.CP0_BadVAddr, MIPSCPU),
         VMSTATE_UINT32(env.CP0_BadInstr, MIPSCPU),
         VMSTATE_UINT32(env.CP0_BadInstrP, MIPSCPU),
+        VMSTATE_UINT32(env.CP0_BadInstrX, MIPSCPU),
         VMSTATE_INT32(env.CP0_Count, MIPSCPU),
         VMSTATE_UINTTL(env.CP0_EntryHi, MIPSCPU),
         VMSTATE_INT32(env.CP0_Compare, MIPSCPU),
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 91ac32e..0582e68 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -5315,7 +5315,12 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_BadInstrP));
             rn = "BadInstrP";
             break;
-        default:
+        case 3:
+            CP0_CHECK(ctx->bi);
+            gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_BadInstrX));
+            rn = "BadInstrX";
+            break;
+       default:
             goto cp0_unimplemented;
         }
         break;
@@ -6006,6 +6011,10 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             /* ignored */
             rn = "BadInstrP";
             break;
+        case 3:
+            /* ignored */
+            rn = "BadInstrX";
+            break;
         default:
             goto cp0_unimplemented;
         }
@@ -6711,6 +6720,11 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_BadInstrP));
             rn = "BadInstrP";
             break;
+        case 3:
+            CP0_CHECK(ctx->bi);
+            gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_BadInstrX));
+            rn = "BadInstrX";
+            break;
         default:
             goto cp0_unimplemented;
         }
@@ -7385,6 +7399,10 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             /* ignored */
             rn = "BadInstrP";
             break;
+        case 3:
+            /* ignored */
+            rn = "BadInstrX";
+            break;
         default:
             goto cp0_unimplemented;
         }
-- 
2.7.4
