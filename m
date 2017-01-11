Received: from eggs.gnu.org ([2001:4830:134:3::10]:54923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cRPO4-0006Ul-SL
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 15:20:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cRPO4-0000ye-0M
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 15:20:48 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:34035)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1cRPO3-0000yX-Q8
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 15:20:47 -0500
Received: by mail-wm0-x244.google.com with SMTP id c85so575133wmi.1
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 12:20:47 -0800 (PST)
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Wed, 11 Jan 2017 21:19:39 +0100
Message-Id: <3a6aaddd6f65e26b06e5616d9eeaddc7a62a2910.1484165352.git.atar4qemu@gmail.com>
In-Reply-To: <cover.1484165352.git.atar4qemu@gmail.com>
References: <cover.1484165352.git.atar4qemu@gmail.com>
In-Reply-To: <cover.1484165352.git.atar4qemu@gmail.com>
References: <cover.1484165352.git.atar4qemu@gmail.com>
Subject: [Qemu-devel] [PATCH v2 08/30] target-sparc: implement UA2005
 scratchpad registers
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
---
 target/sparc/asi.h         |  1 +
 target/sparc/cpu.h         |  1 +
 target/sparc/ldst_helper.c | 24 ++++++++++++++++++++++++
 3 files changed, 26 insertions(+)

diff --git a/target/sparc/asi.h b/target/sparc/asi.h
index c9a1849..d8d6284 100644
--- a/target/sparc/asi.h
+++ b/target/sparc/asi.h
@@ -211,6 +211,7 @@
 #define ASI_AFSR		0x4c /* Async fault status register	*/
 #define ASI_AFAR		0x4d /* Async fault address register	*/
 #define ASI_EC_TAG_DATA		0x4e /* E-cache tag/valid ram diag acc	*/
+#define ASI_HYP_SCRATCHPAD	0x4f /* (4V) Hypervisor scratchpad	*/
 #define ASI_IMMU		0x50 /* Insn-MMU main register space	*/
 #define ASI_IMMU_TSB_8KB_PTR	0x51 /* Insn-MMU 8KB TSB pointer reg	*/
 #define ASI_IMMU_TSB_64KB_PTR	0x52 /* Insn-MMU 64KB TSB pointer reg	*/
diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 7233140..113ae33 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -520,6 +520,7 @@ struct CPUSPARCState {
     uint32_t gl; // UA2005
     /* UA 2005 hyperprivileged registers */
     uint64_t hpstate, htstate[MAXTL_MAX], hintp, htba, hver, hstick_cmpr, ssr;
+    uint64_t scratch[8];
     CPUTimer *hstick; // UA 2005
     /* Interrupt vector registers */
     uint64_t ivec_status;
diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index 68eca86..387732d 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -1351,6 +1351,18 @@ uint64_t helper_ld_asi(CPUSPARCState *env, target_ulong addr,
             }
             break;
         }
+    case ASI_SCRATCHPAD: /* UA2005 privileged scratchpad */
+        if (unlikely((addr >= 0x20) && (addr < 0x30))) {
+            /* Hyperprivileged access only */
+            cpu_unassigned_access(cs, addr, false, false, 1, size);
+        }
+        /* fall through */
+    case ASI_HYP_SCRATCHPAD: /* UA2005 hyperprivileged scratchpad */
+        {
+            unsigned int i = (addr >> 3) & 0x7;
+            ret = env->scratch[i];
+            break;
+        }
     case ASI_DCACHE_DATA:     /* D-cache data */
     case ASI_DCACHE_TAG:      /* D-cache tag access */
     case ASI_ESTATE_ERROR_EN: /* E-cache error enable */
@@ -1603,6 +1615,18 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, target_ulong val,
     case ASI_INTR_RECEIVE: /* Interrupt data receive */
         env->ivec_status = val & 0x20;
         return;
+    case ASI_SCRATCHPAD: /* UA2005 privileged scratchpad */
+        if (unlikely((addr >= 0x20) && (addr < 0x30))) {
+            /* Hyperprivileged access only */
+            cpu_unassigned_access(cs, addr, true, false, 1, size);
+        }
+        /* fall through */
+    case ASI_HYP_SCRATCHPAD: /* UA2005 hyperprivileged scratchpad */
+        {
+            unsigned int i = (addr >> 3) & 0x7;
+            env->scratch[i] = val;
+            return;
+        }
     case ASI_DCACHE_DATA: /* D-cache data */
     case ASI_DCACHE_TAG: /* D-cache tag access */
     case ASI_ESTATE_ERROR_EN: /* E-cache error enable */
-- 
1.8.3.1
