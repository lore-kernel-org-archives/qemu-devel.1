Received: from eggs.gnu.org ([2001:4830:134:3::10]:56911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1d6525-0001iO-DQ
	for qemu-devel@nongnu.org; Wed, 03 May 2017 20:54:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1d6522-00063u-8f
	for qemu-devel@nongnu.org; Wed, 03 May 2017 20:54:13 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:33759)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1d6522-00063d-2n
	for qemu-devel@nongnu.org; Wed, 03 May 2017 20:54:10 -0400
Received: by mail-pg0-x243.google.com with SMTP id s62so798242pgc.0
	for <qemu-devel@nongnu.org>; Wed, 03 May 2017 17:54:09 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
Date: Thu,  4 May 2017 09:53:25 +0900
Message-Id: <48a1b62baaf45e4d8d5ffac77647f7e898d7f7f1.1493858877.git.shorne@gmail.com>
In-Reply-To: <cover.1493858877.git.shorne@gmail.com>
References: <cover.1493858877.git.shorne@gmail.com>
In-Reply-To: <cover.1493858877.git.shorne@gmail.com>
References: <cover.1493858877.git.shorne@gmail.com>
Subject: [Qemu-devel] [PULL v2 10/11] target/openrisc: Remove duplicate
 features property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Development <qemu-devel@nongnu.org>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Stafford Horne <shorne@gmail.com>

The features property has stored the exact same thing as the cpucfgr
spr. Remove the feature enum and property as it is not needed.

In order to preserve the behavior or keeping features accross reset this
patch moves cpucfgr into the non reset region of the state struct.  Since
the cpucfgr is read only this means we only need to sset cpucfgr once
during class init.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 target/openrisc/cpu.c | 17 +++--------------
 target/openrisc/cpu.h | 16 ++--------------
 2 files changed, 5 insertions(+), 28 deletions(-)

diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index 6c1ed07..c9b3f22 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -52,7 +52,6 @@ static void openrisc_cpu_reset(CPUState *s)
     s->exception_index = -1;
 
     cpu->env.upr = UPR_UP | UPR_DMP | UPR_IMP | UPR_PICP | UPR_TTP;
-    cpu->env.cpucfgr = CPUCFGR_OB32S | CPUCFGR_OF32S | CPUCFGR_NSGF;
     cpu->env.dmmucfgr = (DMMUCFGR_NTW & (0 << 2)) | (DMMUCFGR_NTS & (6 << 2));
     cpu->env.immucfgr = (IMMUCFGR_NTW & (0 << 2)) | (IMMUCFGR_NTS & (6 << 2));
 
@@ -65,12 +64,6 @@ static void openrisc_cpu_reset(CPUState *s)
 #endif
 }
 
-static inline void set_feature(OpenRISCCPU *cpu, int feature)
-{
-    cpu->feature |= feature;
-    cpu->env.cpucfgr = cpu->feature;
-}
-
 static void openrisc_cpu_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
@@ -132,19 +125,15 @@ static void or1200_initfn(Object *obj)
 {
     OpenRISCCPU *cpu = OPENRISC_CPU(obj);
 
-    set_feature(cpu, OPENRISC_FEATURE_NSGF);
-    set_feature(cpu, OPENRISC_FEATURE_OB32S);
-    set_feature(cpu, OPENRISC_FEATURE_OF32S);
-    set_feature(cpu, OPENRISC_FEATURE_EVBAR);
+    cpu->env.cpucfgr = CPUCFGR_NSGF | CPUCFGR_OB32S | CPUCFGR_OF32S |
+                       CPUCFGR_EVBARP;
 }
 
 static void openrisc_any_initfn(Object *obj)
 {
     OpenRISCCPU *cpu = OPENRISC_CPU(obj);
 
-    set_feature(cpu, OPENRISC_FEATURE_NSGF);
-    set_feature(cpu, OPENRISC_FEATURE_OB32S);
-    set_feature(cpu, OPENRISC_FEATURE_EVBAR);
+    cpu->env.cpucfgr = CPUCFGR_NSGF | CPUCFGR_OB32S | CPUCFGR_EVBARP;
 }
 
 typedef struct OpenRISCCPUInfo {
diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index e159b22..938ccc3 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -196,18 +196,6 @@ enum {
     SR_SCE = (1 << 17),
 };
 
-/* OpenRISC Hardware Capabilities */
-enum {
-    OPENRISC_FEATURE_NSGF = (15 << 0),
-    OPENRISC_FEATURE_CGF = (1 << 4),
-    OPENRISC_FEATURE_OB32S = (1 << 5),
-    OPENRISC_FEATURE_OB64S = (1 << 6),
-    OPENRISC_FEATURE_OF32S = (1 << 7),
-    OPENRISC_FEATURE_OF64S = (1 << 8),
-    OPENRISC_FEATURE_OV64S = (1 << 9),
-    OPENRISC_FEATURE_EVBAR = (1 << 12),
-};
-
 /* Tick Timer Mode Register */
 enum {
     TTMR_TP = (0xfffffff),
@@ -292,7 +280,6 @@ typedef struct CPUOpenRISCState {
     uint32_t sr;              /* Supervisor register, without SR_{F,CY,OV} */
     uint32_t vr;              /* Version register */
     uint32_t upr;             /* Unit presence register */
-    uint32_t cpucfgr;         /* CPU configure register */
     uint32_t dmmucfgr;        /* DMMU configure register */
     uint32_t immucfgr;        /* IMMU configure register */
     uint32_t esr;             /* Exception supervisor register */
@@ -311,6 +298,8 @@ typedef struct CPUOpenRISCState {
     CPU_COMMON
 
     /* Fields from here on are preserved across CPU reset. */
+    uint32_t cpucfgr;         /* CPU configure register */
+
 #ifndef CONFIG_USER_ONLY
     CPUOpenRISCTLBContext * tlb;
 
@@ -337,7 +326,6 @@ typedef struct OpenRISCCPU {
 
     CPUOpenRISCState env;
 
-    uint32_t feature;       /* CPU Capabilities */
 } OpenRISCCPU;
 
 static inline OpenRISCCPU *openrisc_env_get_cpu(CPUOpenRISCState *env)
-- 
2.9.3
