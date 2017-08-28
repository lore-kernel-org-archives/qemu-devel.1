Received: from eggs.gnu.org ([2001:4830:134:3::10]:41996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sergio.g.delreal@gmail.com>) id 1dm9Ix-0004rn-ND
	for qemu-devel@nongnu.org; Sun, 27 Aug 2017 21:57:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sergio.g.delreal@gmail.com>) id 1dm9Iw-00010z-FS
	for qemu-devel@nongnu.org; Sun, 27 Aug 2017 21:57:31 -0400
Received: from mail-vk0-x242.google.com ([2607:f8b0:400c:c05::242]:38039)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sergio.g.delreal@gmail.com>)
	id 1dm9Iw-00010k-9m
	for qemu-devel@nongnu.org; Sun, 27 Aug 2017 21:57:30 -0400
Received: by mail-vk0-x242.google.com with SMTP id w84so1879879vkd.5
	for <qemu-devel@nongnu.org>; Sun, 27 Aug 2017 18:57:30 -0700 (PDT)
From: Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>
Date: Sun, 27 Aug 2017 20:56:44 -0500
Message-Id: <20170828015654.2530-5-Sergio.G.DelReal@gmail.com>
In-Reply-To: <20170828015654.2530-1-Sergio.G.DelReal@gmail.com>
References: <20170828015654.2530-1-Sergio.G.DelReal@gmail.com>
Subject: [Qemu-devel] [PATCH 04/14] hvf: add fields to CPUState and
 CPUX86State; add definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Sergio Andres Gomez Del Real <Sergio.G.DelReal@gmail.com>

This commit adds some fields specific to hvf in CPUState and
CPUX86State. It also adds some handy #defines.

Signed-off-by: Sergio Andres Gomez Del Real <Sergio.G.DelReal@gmail.com>
---
 include/qom/cpu.h |  8 ++++++++
 target/i386/cpu.h | 23 +++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 25eefea7ab..c46eb61240 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -407,6 +407,14 @@ struct CPUState {
      * unnecessary flushes.
      */
     uint16_t pending_tlb_flush;
+
+    // HVF
+    bool hvf_vcpu_dirty;
+    uint64_t hvf_fd; // fd of vcpu created by HVF
+    // Supporting data structures for VMCS capabilities
+    // and x86 emulation state
+    struct hvf_vcpu_caps* hvf_caps;
+    struct hvf_x86_state* hvf_x86;
 };
 
 QTAILQ_HEAD(CPUTailQ, CPUState);
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 051867399b..7d90f08b98 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -82,15 +82,19 @@
 #define R_GS 5
 
 /* segment descriptor fields */
+#define DESC_G_SHIFT    23
 #define DESC_G_MASK     (1 << 23)
 #define DESC_B_SHIFT    22
 #define DESC_B_MASK     (1 << DESC_B_SHIFT)
 #define DESC_L_SHIFT    21 /* x86_64 only : 64 bit code segment */
 #define DESC_L_MASK     (1 << DESC_L_SHIFT)
+#define DESC_AVL_SHIFT  20
 #define DESC_AVL_MASK   (1 << 20)
+#define DESC_P_SHIFT    15
 #define DESC_P_MASK     (1 << 15)
 #define DESC_DPL_SHIFT  13
 #define DESC_DPL_MASK   (3 << DESC_DPL_SHIFT)
+#define DESC_S_SHIFT    12
 #define DESC_S_MASK     (1 << 12)
 #define DESC_TYPE_SHIFT 8
 #define DESC_TYPE_MASK  (15 << DESC_TYPE_SHIFT)
@@ -631,6 +635,7 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
 #define CPUID_7_0_EBX_AVX512BW (1U << 30) /* AVX-512 Byte and Word Instructions */
 #define CPUID_7_0_EBX_AVX512VL (1U << 31) /* AVX-512 Vector Length Extensions */
 
+#define CPUID_7_0_ECX_AVX512BMI (1U << 1)
 #define CPUID_7_0_ECX_VBMI     (1U << 1)  /* AVX-512 Vector Byte Manipulation Instrs */
 #define CPUID_7_0_ECX_UMIP     (1U << 2)
 #define CPUID_7_0_ECX_PKU      (1U << 3)
@@ -806,6 +811,20 @@ typedef struct SegmentCache {
         float64  _d_##n[(bits)/64]; \
     }
 
+typedef union {
+    uint8_t _b[16];
+    uint16_t _w[8];
+    uint32_t _l[4];
+    uint64_t _q[2];
+} XMMReg;
+
+typedef union {
+    uint8_t _b[32];
+    uint16_t _w[16];
+    uint32_t _l[8];
+    uint64_t _q[4];
+} YMMReg;
+
 typedef MMREG_UNION(ZMMReg, 512) ZMMReg;
 typedef MMREG_UNION(MMXReg, 64)  MMXReg;
 
@@ -1041,7 +1060,11 @@ typedef struct CPUX86State {
     ZMMReg xmm_t0;
     MMXReg mmx_t0;
 
+    XMMReg ymmh_regs[CPU_NB_REGS];
+
     uint64_t opmask_regs[NB_OPMASK_REGS];
+    YMMReg zmmh_regs[CPU_NB_REGS];
+    ZMMReg hi16_zmm_regs[CPU_NB_REGS];
 
     /* sysenter registers */
     uint32_t sysenter_cs;
-- 
2.14.1
