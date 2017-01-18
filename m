Received: from eggs.gnu.org ([2001:4830:134:3::10]:36679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cTysq-0006H3-2z
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 17:39:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cTysp-0002XI-2Q
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 17:39:12 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:33176)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1cTyso-0002Wu-Ph
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 17:39:11 -0500
Received: by mail-wm0-x241.google.com with SMTP id r144so7565917wme.0
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 14:39:10 -0800 (PST)
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Wed, 18 Jan 2017 23:38:16 +0100
Message-Id: <1484779123-18968-4-git-send-email-atar4qemu@gmail.com>
In-Reply-To: <1484779123-18968-1-git-send-email-atar4qemu@gmail.com>
References: <1484779123-18968-1-git-send-email-atar4qemu@gmail.com>
Subject: [Qemu-devel] [PULL 03/30] target-sparc: use explicit mmu register
 pointers
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

Use explicit register pointers while accessing D/I-MMU registers.
Call cpu_unassigned_access on access to missing registers.

Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
Reviewed-by: Richard Henderson <rth@twiddle.net>
---
 target/sparc/cpu.h         |  4 +++
 target/sparc/ldst_helper.c | 66 +++++++++++++++++++++++++++++++++++++---------
 2 files changed, 58 insertions(+), 12 deletions(-)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 1e65c94..10c9ac6 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -446,6 +446,8 @@ struct CPUSPARCState {
             uint64_t sfar;
             uint64_t tsb;
             uint64_t tag_access;
+            uint64_t virtual_watchpoint;
+            uint64_t physical_watchpoint;
         } immu;
     };
     union {
@@ -458,6 +460,8 @@ struct CPUSPARCState {
             uint64_t sfar;
             uint64_t tsb;
             uint64_t tag_access;
+            uint64_t virtual_watchpoint;
+            uint64_t physical_watchpoint;
         } dmmu;
     };
     SparcTLBEntry itlb[64];
diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index e479efd..20e202b 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -1220,14 +1220,25 @@ uint64_t helper_ld_asi(CPUSPARCState *env, target_ulong addr,
     case ASI_IMMU: /* I-MMU regs */
         {
             int reg = (addr >> 3) & 0xf;
-
-            if (reg == 0) {
-                /* I-TSB Tag Target register */
+            switch (reg) {
+            case 0:
+                /* 0x00 I-TSB Tag Target register */
                 ret = ultrasparc_tag_target(env->immu.tag_access);
-            } else {
-                ret = env->immuregs[reg];
+                break;
+            case 3: /* SFSR */
+                ret = env->immu.sfsr;
+                break;
+            case 5: /* TSB access */
+                ret = env->immu.tsb;
+                break;
+            case 6:
+                /* 0x30 I-TSB Tag Access register */
+                ret = env->immu.tag_access;
+                break;
+            default:
+                cpu_unassigned_access(cs, addr, false, false, 1, size);
+                ret = 0;
             }
-
             break;
         }
     case ASI_IMMU_TSB_8KB_PTR: /* I-MMU 8k TSB pointer */
@@ -1263,12 +1274,38 @@ uint64_t helper_ld_asi(CPUSPARCState *env, target_ulong addr,
     case ASI_DMMU: /* D-MMU regs */
         {
             int reg = (addr >> 3) & 0xf;
-
-            if (reg == 0) {
-                /* D-TSB Tag Target register */
+            switch (reg) {
+            case 0:
+                /* 0x00 D-TSB Tag Target register */
                 ret = ultrasparc_tag_target(env->dmmu.tag_access);
-            } else {
-                ret = env->dmmuregs[reg];
+                break;
+            case 1: /* 0x08 Primary Context */
+                ret = env->dmmu.mmu_primary_context;
+                break;
+            case 2: /* 0x10 Secondary Context */
+                ret = env->dmmu.mmu_secondary_context;
+                break;
+            case 3: /* SFSR */
+                ret = env->dmmu.sfsr;
+                break;
+            case 4: /* 0x20 SFAR */
+                ret = env->dmmu.sfar;
+                break;
+            case 5: /* 0x28 TSB access */
+                ret = env->dmmu.tsb;
+                break;
+            case 6: /* 0x30 D-TSB Tag Access register */
+                ret = env->dmmu.tag_access;
+                break;
+            case 7:
+                ret = env->dmmu.virtual_watchpoint;
+                break;
+            case 8:
+                ret = env->dmmu.physical_watchpoint;
+                break;
+            default:
+                cpu_unassigned_access(cs, addr, false, false, 1, size);
+                ret = 0;
             }
             break;
         }
@@ -1456,6 +1493,7 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, target_ulong val,
             case 8:
                 return;
             default:
+                cpu_unassigned_access(cs, addr, true, false, 1, size);
                 break;
             }
 
@@ -1526,9 +1564,13 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, target_ulong val,
                 env->dmmu.tag_access = val;
                 break;
             case 7: /* Virtual Watchpoint */
+                env->dmmu.virtual_watchpoint = val;
+                break;
             case 8: /* Physical Watchpoint */
+                env->dmmu.physical_watchpoint = val;
+                break;
             default:
-                env->dmmuregs[reg] = val;
+                cpu_unassigned_access(cs, addr, true, false, 1, size);
                 break;
             }
 
-- 
2.7.2
