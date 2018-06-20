Received: from eggs.gnu.org ([2001:4830:134:3::10]:36173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@mips.com>) id 1fVbyq-0007Ut-Mr
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:12:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@mips.com>) id 1fVbyn-0006wW-Fh
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:12:56 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:43058)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Yongbok.Kim@mips.com>)
	id 1fVbyn-0006pp-5e
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:12:53 -0400
From: Yongbok Kim <yongbok.kim@mips.com>
Date: Wed, 20 Jun 2018 13:06:09 +0100
Message-ID: <20180620120620.12806-25-yongbok.kim@mips.com>
In-Reply-To: <20180620120620.12806-1-yongbok.kim@mips.com>
References: <20180620120620.12806-1-yongbok.kim@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 24/35] target/mips: Add nanoMIPS CP0_BadInstrX
 register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, Aleksandar.Markovic@mips.com, James.Hogan@mips.com, Paul.Burton@mips.com, Matthew.Fortune@mips.com, Stefan.Markovic@mips.com

From: Stefan Markovic <stefan.markovic@rt-rk.com>

Add nanoMIPS CP0_BadInstrX register

Signed-off-by: Stefan Markovic <stefan.markovic@rt-rk.com>
Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
---
 target/mips/cpu.h       |  1 +
 target/mips/helper.c    |  6 ++++++
 target/mips/machine.c   |  1 +
 target/mips/translate.c | 18 ++++++++++++++++++
 4 files changed, 26 insertions(+)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 18f193d..c87184f 100644
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
diff --git a/target/mips/helper.c b/target/mips/helper.c
index 5299f21..9535131 100644
--- a/target/mips/helper.c
+++ b/target/mips/helper.c
@@ -695,6 +695,12 @@ static inline void set_badinstr_registers(CPUMIPSState *env)
                 instr |= cpu_lduw_code(env, env->active_tc.PC + 2);
             }
             env->CP0_BadInstr = instr;
+
+            if ((env->insn_flags & ISA_NANOMIPS32) &&
+                ((instr & 0xFC000000) == 0x60000000)) {
+                instr = cpu_lduw_code(env, env->active_tc.PC + 4) << 16;
+                env->CP0_BadInstrX = instr;
+            }
         }
         if ((env->CP0_Config3 & (1 << CP0C3_BP)) &&
             (env->hflags & MIPS_HFLAG_BMASK)) {
diff --git a/target/mips/machine.c b/target/mips/machine.c
index 20100d5..58f3255 100644
--- a/target/mips/machine.c
+++ b/target/mips/machine.c
@@ -266,6 +266,7 @@ const VMStateDescription vmstate_mips_cpu = {
         VMSTATE_UINTTL(env.CP0_BadVAddr, MIPSCPU),
         VMSTATE_UINT32(env.CP0_BadInstr, MIPSCPU),
         VMSTATE_UINT32(env.CP0_BadInstrP, MIPSCPU),
+        VMSTATE_UINT32(env.CP0_BadInstrX, MIPSCPU),
         VMSTATE_INT32(env.CP0_Count, MIPSCPU),
         VMSTATE_UINTTL(env.CP0_EntryHi, MIPSCPU),
         VMSTATE_INT32(env.CP0_Compare, MIPSCPU),
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 8c20ba3..ece2293 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -5429,6 +5429,11 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
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
@@ -6098,6 +6103,10 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
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
@@ -6781,6 +6790,11 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
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
@@ -7433,6 +7447,10 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
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
1.9.1
