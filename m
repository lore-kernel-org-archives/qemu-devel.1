Received: from eggs.gnu.org ([2001:4830:134:3::10]:35941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1cSs8d-0001mn-Ln
	for qemu-devel@nongnu.org; Sun, 15 Jan 2017 16:14:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1cSs8b-0003pL-IJ
	for qemu-devel@nongnu.org; Sun, 15 Jan 2017 16:14:55 -0500
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:33170)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1cSs8b-0003pA-Ax
	for qemu-devel@nongnu.org; Sun, 15 Jan 2017 16:14:53 -0500
Received: by mail-pf0-x244.google.com with SMTP id e4so2472154pfg.0
	for <qemu-devel@nongnu.org>; Sun, 15 Jan 2017 13:14:53 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Sun, 15 Jan 2017 13:14:37 -0800
Message-Id: <1484514878-11828-2-git-send-email-jcmvbkbc@gmail.com>
In-Reply-To: <1484514878-11828-1-git-send-email-jcmvbkbc@gmail.com>
References: <1484514878-11828-1-git-send-email-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 1/2] target/xtensa: implement MEMCTL SR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>

MEMCTL SR controls zero overhead loop buffer and number of ways enabled
in L1 caches.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/cpu.c          |  1 +
 target/xtensa/cpu.h          | 19 +++++++++++++++++++
 target/xtensa/helper.h       |  1 +
 target/xtensa/op_helper.c    | 24 ++++++++++++++++++++++++
 target/xtensa/overlay_tool.h | 15 +++++++++++++++
 target/xtensa/translate.c    |  8 ++++++++
 6 files changed, 68 insertions(+)

diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 1c18892..811d878 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -66,6 +66,7 @@ static void xtensa_cpu_reset(CPUState *s)
             XTENSA_OPTION_INTERRUPT) ? 0x1f : 0x10;
     env->sregs[VECBASE] = env->config->vecbase;
     env->sregs[IBREAKENABLE] = 0;
+    env->sregs[MEMCTL] = MEMCTL_IL0EN & env->config->memctl_mask;
     env->sregs[CACHEATTR] = 0x22222222;
     env->sregs[ATOMCTL] = xtensa_option_enabled(env->config,
             XTENSA_OPTION_ATOMCTL) ? 0x28 : 0x15;
diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index a10f1ef..9a130bd 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -129,6 +129,7 @@ enum {
     ITLBCFG = 91,
     DTLBCFG = 92,
     IBREAKENABLE = 96,
+    MEMCTL = 97,
     CACHEATTR = 98,
     ATOMCTL = 99,
     IBREAKA = 128,
@@ -189,6 +190,20 @@ enum {
 #define DBREAKC_SB_LB (DBREAKC_SB | DBREAKC_LB)
 #define DBREAKC_MASK 0x3f
 
+#define MEMCTL_INIT 0x00800000
+#define MEMCTL_IUSEWAYS_SHIFT 18
+#define MEMCTL_IUSEWAYS_LEN 5
+#define MEMCTL_IUSEWAYS_MASK 0x007c0000
+#define MEMCTL_DALLOCWAYS_SHIFT 13
+#define MEMCTL_DALLOCWAYS_LEN 5
+#define MEMCTL_DALLOCWAYS_MASK 0x0003e000
+#define MEMCTL_DUSEWAYS_SHIFT 8
+#define MEMCTL_DUSEWAYS_LEN 5
+#define MEMCTL_DUSEWAYS_MASK 0x00001f00
+#define MEMCTL_ISNP 0x4
+#define MEMCTL_DSNP 0x2
+#define MEMCTL_IL0EN 0x1
+
 #define MAX_NAREG 64
 #define MAX_NINTERRUPT 32
 #define MAX_NLEVEL 6
@@ -332,6 +347,10 @@ struct XtensaConfig {
     unsigned nibreak;
     unsigned ndbreak;
 
+    unsigned icache_ways;
+    unsigned dcache_ways;
+    uint32_t memctl_mask;
+
     uint32_t configid[2];
 
     uint32_t clock_freq_khz;
diff --git a/target/xtensa/helper.h b/target/xtensa/helper.h
index 427bdc7..7e14741 100644
--- a/target/xtensa/helper.h
+++ b/target/xtensa/helper.h
@@ -23,6 +23,7 @@ DEF_HELPER_2(wsr_ccount, void, env, i32)
 DEF_HELPER_2(update_ccompare, void, env, i32)
 DEF_HELPER_1(check_interrupts, void, env)
 DEF_HELPER_3(check_atomctl, void, env, i32, i32)
+DEF_HELPER_2(wsr_memctl, void, env, i32)
 
 DEF_HELPER_2(itlb_hit_test, void, env, i32)
 DEF_HELPER_2(wsr_rasid, void, env, i32)
diff --git a/target/xtensa/op_helper.c b/target/xtensa/op_helper.c
index 864a8f6..989578a 100644
--- a/target/xtensa/op_helper.c
+++ b/target/xtensa/op_helper.c
@@ -506,6 +506,30 @@ void HELPER(check_atomctl)(CPUXtensaState *env, uint32_t pc, uint32_t vaddr)
     }
 }
 
+void HELPER(wsr_memctl)(CPUXtensaState *env, uint32_t v)
+{
+    if (xtensa_option_enabled(env->config, XTENSA_OPTION_ICACHE)) {
+        if (extract32(v, MEMCTL_IUSEWAYS_SHIFT, MEMCTL_IUSEWAYS_LEN) >
+            env->config->icache_ways) {
+            deposit32(v, MEMCTL_IUSEWAYS_SHIFT, MEMCTL_IUSEWAYS_LEN,
+                      env->config->icache_ways);
+        }
+    }
+    if (xtensa_option_enabled(env->config, XTENSA_OPTION_DCACHE)) {
+        if (extract32(v, MEMCTL_DUSEWAYS_SHIFT, MEMCTL_DUSEWAYS_LEN) >
+            env->config->dcache_ways) {
+            deposit32(v, MEMCTL_DUSEWAYS_SHIFT, MEMCTL_DUSEWAYS_LEN,
+                      env->config->dcache_ways);
+        }
+        if (extract32(v, MEMCTL_DALLOCWAYS_SHIFT, MEMCTL_DALLOCWAYS_LEN) >
+            env->config->dcache_ways) {
+            deposit32(v, MEMCTL_DALLOCWAYS_SHIFT, MEMCTL_DALLOCWAYS_LEN,
+                      env->config->dcache_ways);
+        }
+    }
+    env->sregs[MEMCTL] = v & env->config->memctl_mask;
+}
+
 void HELPER(wsr_rasid)(CPUXtensaState *env, uint32_t v)
 {
     XtensaCPU *cpu = xtensa_env_get_cpu(env);
diff --git a/target/xtensa/overlay_tool.h b/target/xtensa/overlay_tool.h
index b73fd14..bf36b5c 100644
--- a/target/xtensa/overlay_tool.h
+++ b/target/xtensa/overlay_tool.h
@@ -59,6 +59,10 @@
 #define XCHAL_HW_MIN_VERSION 0
 #endif
 
+#ifndef XCHAL_LOOP_BUFFER_SIZE
+#define XCHAL_LOOP_BUFFER_SIZE 0
+#endif
+
 #define XCHAL_OPTION(xchal, qemu) ((xchal) ? XTENSA_OPTION_BIT(qemu) : 0)
 
 #define XTENSA_OPTIONS ( \
@@ -343,6 +347,16 @@
     .nibreak = XCHAL_NUM_IBREAK, \
     .ndbreak = XCHAL_NUM_DBREAK
 
+#define CACHE_SECTION \
+    .icache_ways = XCHAL_ICACHE_WAYS, \
+    .dcache_ways = XCHAL_DCACHE_WAYS, \
+    .memctl_mask = \
+        (XCHAL_ICACHE_SIZE ? MEMCTL_IUSEWAYS_MASK : 0) | \
+        (XCHAL_DCACHE_SIZE ? \
+         MEMCTL_DALLOCWAYS_MASK | MEMCTL_DUSEWAYS_MASK : 0) | \
+        MEMCTL_ISNP | MEMCTL_DSNP | \
+        (XCHAL_HAVE_LOOPS && XCHAL_LOOP_BUFFER_SIZE ? MEMCTL_IL0EN : 0)
+
 #define CONFIG_SECTION \
     .configid = { \
         XCHAL_HW_CONFIGID0, \
@@ -357,6 +371,7 @@
     INTERRUPTS_SECTION, \
     TLB_SECTION, \
     DEBUG_SECTION, \
+    CACHE_SECTION, \
     CONFIG_SECTION
 
 
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 7a198fa..c541b59 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -133,6 +133,7 @@ static const XtensaReg sregnames[256] = {
     [ITLBCFG] = XTENSA_REG("ITLBCFG", XTENSA_OPTION_MMU),
     [DTLBCFG] = XTENSA_REG("DTLBCFG", XTENSA_OPTION_MMU),
     [IBREAKENABLE] = XTENSA_REG("IBREAKENABLE", XTENSA_OPTION_DEBUG),
+    [MEMCTL] = XTENSA_REG_BITS("MEMCTL", XTENSA_OPTION_ALL),
     [CACHEATTR] = XTENSA_REG("CACHEATTR", XTENSA_OPTION_CACHEATTR),
     [ATOMCTL] = XTENSA_REG("ATOMCTL", XTENSA_OPTION_ATOMCTL),
     [IBREAKA] = XTENSA_REG("IBREAKA0", XTENSA_OPTION_DEBUG),
@@ -637,6 +638,12 @@ static bool gen_wsr_ibreakenable(DisasContext *dc, uint32_t sr, TCGv_i32 v)
     return true;
 }
 
+static bool gen_wsr_memctl(DisasContext *dc, uint32_t sr, TCGv_i32 v)
+{
+    gen_helper_wsr_memctl(cpu_env, v);
+    return false;
+}
+
 static bool gen_wsr_atomctl(DisasContext *dc, uint32_t sr, TCGv_i32 v)
 {
     tcg_gen_andi_i32(cpu_SR[sr], v, 0x3f);
@@ -821,6 +828,7 @@ static bool gen_wsr(DisasContext *dc, uint32_t sr, TCGv_i32 s)
         [ITLBCFG] = gen_wsr_tlbcfg,
         [DTLBCFG] = gen_wsr_tlbcfg,
         [IBREAKENABLE] = gen_wsr_ibreakenable,
+        [MEMCTL] = gen_wsr_memctl,
         [ATOMCTL] = gen_wsr_atomctl,
         [IBREAKA] = gen_wsr_ibreaka,
         [IBREAKA + 1] = gen_wsr_ibreaka,
-- 
2.1.4
