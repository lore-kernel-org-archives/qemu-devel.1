Received: from eggs.gnu.org ([209.51.188.92]:48321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1h1xOh-0007CQ-IY
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:05:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1h1xOe-0006Dv-24
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:05:35 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Thu,  7 Mar 2019 18:05:16 +0000
Message-Id: <20190307180520.13868-4-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20190307180520.13868-1-mark.cave-ayland@ilande.co.uk>
References: <20190307180520.13868-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH v2 3/7] target/ppc: move Vsr* macros from
 internal.h to cpu.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, richard.henderson@linaro.org

It isn't possible to include internal.h from cpu.h so move the Vsr* macros
into cpu.h alongside the other VMX/VSX register access functions.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 target/ppc/cpu.h      | 20 ++++++++++++++++++++
 target/ppc/internal.h | 19 -------------------
 2 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 4a7df13c2d..d0580c6b6d 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -2563,6 +2563,26 @@ static inline bool lsw_reg_in_range(int start, int nregs, int rx)
 }
 
 /* Accessors for FP, VMX and VSX registers */
+#if defined(HOST_WORDS_BIGENDIAN)
+#define VsrB(i) u8[i]
+#define VsrSB(i) s8[i]
+#define VsrH(i) u16[i]
+#define VsrSH(i) s16[i]
+#define VsrW(i) u32[i]
+#define VsrSW(i) s32[i]
+#define VsrD(i) u64[i]
+#define VsrSD(i) s64[i]
+#else
+#define VsrB(i) u8[15 - (i)]
+#define VsrSB(i) s8[15 - (i)]
+#define VsrH(i) u16[7 - (i)]
+#define VsrSH(i) s16[7 - (i)]
+#define VsrW(i) u32[3 - (i)]
+#define VsrSW(i) s32[3 - (i)]
+#define VsrD(i) u64[1 - (i)]
+#define VsrSD(i) s64[1 - (i)]
+#endif
+
 static inline int fpr_offset(int i)
 {
     return offsetof(CPUPPCState, vsr[i].u64[0]);
diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index f26a71ffcf..3ebbdf4da4 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -204,25 +204,6 @@ EXTRACT_HELPER(IMM8, 11, 8);
 EXTRACT_HELPER(DCMX, 16, 7);
 EXTRACT_HELPER_SPLIT_3(DCMX_XV, 5, 16, 0, 1, 2, 5, 1, 6, 6);
 
-#if defined(HOST_WORDS_BIGENDIAN)
-#define VsrB(i) u8[i]
-#define VsrSB(i) s8[i]
-#define VsrH(i) u16[i]
-#define VsrSH(i) s16[i]
-#define VsrW(i) u32[i]
-#define VsrSW(i) s32[i]
-#define VsrD(i) u64[i]
-#define VsrSD(i) s64[i]
-#else
-#define VsrB(i) u8[15 - (i)]
-#define VsrSB(i) s8[15 - (i)]
-#define VsrH(i) u16[7 - (i)]
-#define VsrSH(i) s16[7 - (i)]
-#define VsrW(i) u32[3 - (i)]
-#define VsrSW(i) s32[3 - (i)]
-#define VsrD(i) u64[1 - (i)]
-#define VsrSD(i) s64[1 - (i)]
-#endif
 static inline void getVSR(int n, ppc_vsr_t *vsr, CPUPPCState *env)
 {
     vsr->VsrD(0) = env->vsr[n].u64[0];
-- 
2.11.0
