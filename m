Received: from eggs.gnu.org ([2001:4830:134:3::10]:37077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cTytM-0006kl-07
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 17:39:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cTytK-0002t2-KC
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 17:39:44 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:34327)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1cTytK-0002sX-Aj
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 17:39:42 -0500
Received: by mail-wm0-x244.google.com with SMTP id c85so7558355wmi.1
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 14:39:42 -0800 (PST)
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Wed, 18 Jan 2017 23:38:32 +0100
Message-Id: <1484779123-18968-20-git-send-email-atar4qemu@gmail.com>
In-Reply-To: <1484779123-18968-1-git-send-email-atar4qemu@gmail.com>
References: <1484779123-18968-1-git-send-email-atar4qemu@gmail.com>
Subject: [Qemu-devel] [PULL 19/30] target-sparc: use SparcV9MMU type for
 sparc64 I/D-MMUs
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

Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
---
 linux-user/main.c          |  2 +-
 target/sparc/cpu.h         | 48 +++++++++++++++++-----------------------------
 target/sparc/ldst_helper.c |  8 ++++----
 target/sparc/machine.c     |  4 ++--
 4 files changed, 25 insertions(+), 37 deletions(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index c1d5eb4..94a636f 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -1166,7 +1166,7 @@ void cpu_loop (CPUSPARCState *env)
                 /* XXX: check env->error_code */
                 info.si_code = TARGET_SEGV_MAPERR;
                 if (trapnr == TT_DFAULT)
-                    info._sifields._sigfault._addr = env->dmmuregs[4];
+                    info._sifields._sigfault._addr = env->dmmu.mmuregs[4];
                 else
                     info._sifields._sigfault._addr = cpu_tsptr(env)->tpc;
                 queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 53afa18..c92bd25 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -404,7 +404,22 @@ struct CPUTimer
 typedef struct CPUTimer CPUTimer;
 
 typedef struct CPUSPARCState CPUSPARCState;
-
+#if defined(TARGET_SPARC64)
+typedef union {
+   uint64_t mmuregs[16];
+   struct {
+    uint64_t tsb_tag_target;
+    uint64_t mmu_primary_context;
+    uint64_t mmu_secondary_context;
+    uint64_t sfsr;
+    uint64_t sfar;
+    uint64_t tsb;
+    uint64_t tag_access;
+    uint64_t virtual_watchpoint;
+    uint64_t physical_watchpoint;
+   };
+} SparcV9MMU;
+#endif
 struct CPUSPARCState {
     target_ulong gregs[8]; /* general registers */
     target_ulong *regwptr; /* pointer to current register window */
@@ -457,35 +472,8 @@ struct CPUSPARCState {
     uint64_t lsu;
 #define DMMU_E 0x8
 #define IMMU_E 0x4
-    //typedef struct SparcMMU
-    union {
-        uint64_t immuregs[16];
-        struct {
-            uint64_t tsb_tag_target;
-            uint64_t unused_mmu_primary_context;   // use DMMU
-            uint64_t unused_mmu_secondary_context; // use DMMU
-            uint64_t sfsr;
-            uint64_t sfar;
-            uint64_t tsb;
-            uint64_t tag_access;
-            uint64_t virtual_watchpoint;
-            uint64_t physical_watchpoint;
-        } immu;
-    };
-    union {
-        uint64_t dmmuregs[16];
-        struct {
-            uint64_t tsb_tag_target;
-            uint64_t mmu_primary_context;
-            uint64_t mmu_secondary_context;
-            uint64_t sfsr;
-            uint64_t sfar;
-            uint64_t tsb;
-            uint64_t tag_access;
-            uint64_t virtual_watchpoint;
-            uint64_t physical_watchpoint;
-        } dmmu;
-    };
+    SparcV9MMU immu;
+    SparcV9MMU dmmu;
     SparcTLBEntry itlb[64];
     SparcTLBEntry dtlb[64];
     uint32_t mmu_version;
diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index 029120d..a96b031 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -1483,7 +1483,7 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, target_ulong val,
             int reg = (addr >> 3) & 0xf;
             uint64_t oldreg;
 
-            oldreg = env->immuregs[reg];
+            oldreg = env->immu.mmuregs[reg];
             switch (reg) {
             case 0: /* RO */
                 return;
@@ -1514,7 +1514,7 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, target_ulong val,
                 break;
             }
 
-            if (oldreg != env->immuregs[reg]) {
+            if (oldreg != env->immu.mmuregs[reg]) {
                 DPRINTF_MMU("immu change reg[%d]: 0x%016" PRIx64 " -> 0x%016"
                             PRIx64 "\n", reg, oldreg, env->immuregs[reg]);
             }
@@ -1548,7 +1548,7 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, target_ulong val,
             int reg = (addr >> 3) & 0xf;
             uint64_t oldreg;
 
-            oldreg = env->dmmuregs[reg];
+            oldreg = env->dmmu.mmuregs[reg];
             switch (reg) {
             case 0: /* RO */
             case 4:
@@ -1591,7 +1591,7 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, target_ulong val,
                 break;
             }
 
-            if (oldreg != env->dmmuregs[reg]) {
+            if (oldreg != env->dmmu.mmuregs[reg]) {
                 DPRINTF_MMU("dmmu change reg[%d]: 0x%016" PRIx64 " -> 0x%016"
                             PRIx64 "\n", reg, oldreg, env->dmmuregs[reg]);
             }
diff --git a/target/sparc/machine.c b/target/sparc/machine.c
index aea6397..39e262c 100644
--- a/target/sparc/machine.c
+++ b/target/sparc/machine.c
@@ -148,8 +148,8 @@ const VMStateDescription vmstate_sparc_cpu = {
         VMSTATE_UINT64_ARRAY(env.mmubpregs, SPARCCPU, 4),
 #else
         VMSTATE_UINT64(env.lsu, SPARCCPU),
-        VMSTATE_UINT64_ARRAY(env.immuregs, SPARCCPU, 16),
-        VMSTATE_UINT64_ARRAY(env.dmmuregs, SPARCCPU, 16),
+        VMSTATE_UINT64_ARRAY(env.immu.mmuregs, SPARCCPU, 16),
+        VMSTATE_UINT64_ARRAY(env.dmmu.mmuregs, SPARCCPU, 16),
         VMSTATE_STRUCT_ARRAY(env.itlb, SPARCCPU, 64, 0,
                              vmstate_tlb_entry, SparcTLBEntry),
         VMSTATE_STRUCT_ARRAY(env.dtlb, SPARCCPU, 64, 0,
-- 
2.7.2
