Received: from eggs.gnu.org ([209.51.188.92]:43259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2tor-0001gi-1B
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:28:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2toq-0001o3-1R
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:28:28 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Sun, 10 Mar 2019 19:26:41 +1100
Message-Id: <20190310082703.1245-39-david@gibson.dropbear.id.au>
In-Reply-To: <20190310082703.1245-1-david@gibson.dropbear.id.au>
References: <20190310082703.1245-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 38/60] target/ppc: improve avr64_offset() and
 use it to simplify get_avr64()/set_avr64()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Richard Henderson <richard.henderson@linaro.org>, David Gibson <david@gibson.dropbear.id.au>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

By using the VsrD macro in avr64_offset() the same offset calculation can=
 be
used regardless of the host endian. This allows get_avr64() and set_avr64=
() to
be simplified accordingly.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-Id: <20190307180520.13868-6-mark.cave-ayland@ilande.co.uk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/cpu.h                    |  5 +++++
 target/ppc/translate.c              | 16 ++--------------
 target/ppc/translate/vmx-impl.inc.c |  5 -----
 3 files changed, 7 insertions(+), 19 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index caddbd012c..3050982707 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -2608,6 +2608,11 @@ static inline uint64_t *cpu_vsrl_ptr(CPUPPCState *=
env, int i)
     return (uint64_t *)((uintptr_t)env + vsrl_offset(i));
 }
=20
+static inline long avr64_offset(int i, bool high)
+{
+    return offsetof(CPUPPCState, vsr[32 + i].VsrD(high ? 0 : 1));
+}
+
 static inline int avr_full_offset(int i)
 {
     return vsr_full_offset(i + 32);
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 668d4cf75a..98b37cebc2 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -6687,24 +6687,12 @@ static inline void set_fpr(int regno, TCGv_i64 sr=
c)
=20
 static inline void get_avr64(TCGv_i64 dst, int regno, bool high)
 {
-#ifdef HOST_WORDS_BIGENDIAN
-    tcg_gen_ld_i64(dst, cpu_env, offsetof(CPUPPCState,
-                                          vsr[32 + regno].u64[(high ? 0 =
: 1)]));
-#else
-    tcg_gen_ld_i64(dst, cpu_env, offsetof(CPUPPCState,
-                                          vsr[32 + regno].u64[(high ? 1 =
: 0)]));
-#endif
+    tcg_gen_ld_i64(dst, cpu_env, avr64_offset(regno, high));
 }
=20
 static inline void set_avr64(int regno, TCGv_i64 src, bool high)
 {
-#ifdef HOST_WORDS_BIGENDIAN
-    tcg_gen_st_i64(src, cpu_env, offsetof(CPUPPCState,
-                                          vsr[32 + regno].u64[(high ? 0 =
: 1)]));
-#else
-    tcg_gen_st_i64(src, cpu_env, offsetof(CPUPPCState,
-                                          vsr[32 + regno].u64[(high ? 1 =
: 0)]));
-#endif
+    tcg_gen_st_i64(src, cpu_env, avr64_offset(regno, high));
 }
=20
 #include "translate/fp-impl.inc.c"
diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/v=
mx-impl.inc.c
index 4e5d0bc0e0..eb10c533ca 100644
--- a/target/ppc/translate/vmx-impl.inc.c
+++ b/target/ppc/translate/vmx-impl.inc.c
@@ -14,11 +14,6 @@ static inline TCGv_ptr gen_avr_ptr(int reg)
     return r;
 }
=20
-static inline long avr64_offset(int reg, bool high)
-{
-    return offsetof(CPUPPCState, vsr[32 + reg].u64[(high ? 0 : 1)]);
-}
-
 #define GEN_VR_LDX(name, opc2, opc3)                                    =
      \
 static void glue(gen_, name)(DisasContext *ctx)                         =
              \
 {                                                                       =
      \
--=20
2.20.1
