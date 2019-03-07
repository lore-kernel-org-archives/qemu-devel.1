Received: from eggs.gnu.org ([209.51.188.92]:48318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1h1xOh-0007CN-Hp
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:05:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1h1xOf-0006FV-E6
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:05:35 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Thu,  7 Mar 2019 18:05:18 +0000
Message-Id: <20190307180520.13868-6-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20190307180520.13868-1-mark.cave-ayland@ilande.co.uk>
References: <20190307180520.13868-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH v2 5/7] target/ppc: improve avr64_offset() and
 use it to simplify get_avr64()/set_avr64()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, richard.henderson@linaro.org

By using the VsrD macro in avr64_offset() the same offset calculation can be
used regardless of the host endian. This allows get_avr64() and set_avr64() to
be simplified accordingly.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 target/ppc/cpu.h                    |  5 +++++
 target/ppc/translate.c              | 16 ++--------------
 target/ppc/translate/vmx-impl.inc.c |  5 -----
 3 files changed, 7 insertions(+), 19 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 2a2792306f..aebb6c01ee 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -2608,6 +2608,11 @@ static inline uint64_t *cpu_vsrl_ptr(CPUPPCState *env, int i)
     return (uint64_t *)((uintptr_t)env + vsrl_offset(i));
 }
 
+static inline long avr64_offset(int i, bool high)
+{
+    return offsetof(CPUPPCState, vsr[32 + i].VsrD(high ? 0 : 1));
+}
+
 static inline int avr_full_offset(int i)
 {
     return vsr_full_offset(i + 32);
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 3b1992faf1..a6cff20daf 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -6687,24 +6687,12 @@ static inline void set_fpr(int regno, TCGv_i64 src)
 
 static inline void get_avr64(TCGv_i64 dst, int regno, bool high)
 {
-#ifdef HOST_WORDS_BIGENDIAN
-    tcg_gen_ld_i64(dst, cpu_env, offsetof(CPUPPCState,
-                                          vsr[32 + regno].u64[(high ? 0 : 1)]));
-#else
-    tcg_gen_ld_i64(dst, cpu_env, offsetof(CPUPPCState,
-                                          vsr[32 + regno].u64[(high ? 1 : 0)]));
-#endif
+    tcg_gen_ld_i64(dst, cpu_env, avr64_offset(regno, high));
 }
 
 static inline void set_avr64(int regno, TCGv_i64 src, bool high)
 {
-#ifdef HOST_WORDS_BIGENDIAN
-    tcg_gen_st_i64(src, cpu_env, offsetof(CPUPPCState,
-                                          vsr[32 + regno].u64[(high ? 0 : 1)]));
-#else
-    tcg_gen_st_i64(src, cpu_env, offsetof(CPUPPCState,
-                                          vsr[32 + regno].u64[(high ? 1 : 0)]));
-#endif
+    tcg_gen_st_i64(src, cpu_env, avr64_offset(regno, high));
 }
 
 #include "translate/fp-impl.inc.c"
diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/vmx-impl.inc.c
index 4e5d0bc0e0..eb10c533ca 100644
--- a/target/ppc/translate/vmx-impl.inc.c
+++ b/target/ppc/translate/vmx-impl.inc.c
@@ -14,11 +14,6 @@ static inline TCGv_ptr gen_avr_ptr(int reg)
     return r;
 }
 
-static inline long avr64_offset(int reg, bool high)
-{
-    return offsetof(CPUPPCState, vsr[32 + reg].u64[(high ? 0 : 1)]);
-}
-
 #define GEN_VR_LDX(name, opc2, opc3)                                          \
 static void glue(gen_, name)(DisasContext *ctx)                                       \
 {                                                                             \
-- 
2.11.0
