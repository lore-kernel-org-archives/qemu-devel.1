Received: from eggs.gnu.org ([209.51.188.92]:43116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2toW-0001OH-Sr
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:28:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2toV-0001d5-Na
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:28:08 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Sun, 10 Mar 2019 19:26:43 +1100
Message-Id: <20190310082703.1245-41-david@gibson.dropbear.id.au>
In-Reply-To: <20190310082703.1245-1-david@gibson.dropbear.id.au>
References: <20190310082703.1245-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 40/60] target/ppc: introduce vsr64_offset() to
 simplify get_cpu_vsr{l, h}() and set_cpu_vsr{l, h}()
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

Now that all VSX registers are stored in host endian order, there is no n=
eed
to go via different accessors depending upon the register number. Instead=
 we
introduce vsr64_offset() and use it directly from within get_cpu_vsr{l,h}=
() and
set_cpu_vsr{l,h}().

This also allows us to rewrite avr64_offset() and fpr_offset() in terms o=
f the
new vsr64_offset() function to more clearly express the relationship betw=
een the
VSX, FPR and VMX registers, and also remove vsrl_offset() which is no lon=
ger
required.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-Id: <20190307180520.13868-8-mark.cave-ayland@ilande.co.uk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/cpu.h                    | 20 ++++++++---------
 target/ppc/translate/vsx-impl.inc.c | 34 ++++-------------------------
 2 files changed, 14 insertions(+), 40 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 8905edbfd0..c1fce44303 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -2583,34 +2583,34 @@ static inline bool lsw_reg_in_range(int start, in=
t nregs, int rx)
 #define VsrSD(i) s64[1 - (i)]
 #endif
=20
-static inline int fpr_offset(int i)
+static inline int vsr64_offset(int i, bool high)
 {
-    return offsetof(CPUPPCState, vsr[i].VsrD(0));
+    return offsetof(CPUPPCState, vsr[i].VsrD(high ? 0 : 1));
 }
=20
-static inline uint64_t *cpu_fpr_ptr(CPUPPCState *env, int i)
+static inline int vsr_full_offset(int i)
 {
-    return (uint64_t *)((uintptr_t)env + fpr_offset(i));
+    return offsetof(CPUPPCState, vsr[i].u64[0]);
 }
=20
-static inline int vsrl_offset(int i)
+static inline int fpr_offset(int i)
 {
-    return offsetof(CPUPPCState, vsr[i].VsrD(1));
+    return vsr64_offset(i, true);
 }
=20
-static inline int vsr_full_offset(int i)
+static inline uint64_t *cpu_fpr_ptr(CPUPPCState *env, int i)
 {
-    return offsetof(CPUPPCState, vsr[i].u64[0]);
+    return (uint64_t *)((uintptr_t)env + fpr_offset(i));
 }
=20
 static inline uint64_t *cpu_vsrl_ptr(CPUPPCState *env, int i)
 {
-    return (uint64_t *)((uintptr_t)env + vsrl_offset(i));
+    return (uint64_t *)((uintptr_t)env + vsr64_offset(i, false));
 }
=20
 static inline long avr64_offset(int i, bool high)
 {
-    return offsetof(CPUPPCState, vsr[32 + i].VsrD(high ? 0 : 1));
+    return vsr64_offset(i + 32, high);
 }
=20
 static inline int avr_full_offset(int i)
diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/v=
sx-impl.inc.c
index 7d02a235e7..95a269fff0 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -1,49 +1,23 @@
 /***                           VSX extension                            =
   ***/
=20
-static inline void get_vsrl(TCGv_i64 dst, int n)
-{
-    tcg_gen_ld_i64(dst, cpu_env, vsrl_offset(n));
-}
-
-static inline void set_vsrl(int n, TCGv_i64 src)
-{
-    tcg_gen_st_i64(src, cpu_env, vsrl_offset(n));
-}
-
 static inline void get_cpu_vsrh(TCGv_i64 dst, int n)
 {
-    if (n < 32) {
-        get_fpr(dst, n);
-    } else {
-        get_avr64(dst, n - 32, true);
-    }
+    tcg_gen_ld_i64(dst, cpu_env, vsr64_offset(n, true));
 }
=20
 static inline void get_cpu_vsrl(TCGv_i64 dst, int n)
 {
-    if (n < 32) {
-        get_vsrl(dst, n);
-    } else {
-        get_avr64(dst, n - 32, false);
-    }
+    tcg_gen_ld_i64(dst, cpu_env, vsr64_offset(n, false));
 }
=20
 static inline void set_cpu_vsrh(int n, TCGv_i64 src)
 {
-    if (n < 32) {
-        set_fpr(n, src);
-    } else {
-        set_avr64(n - 32, src, true);
-    }
+    tcg_gen_st_i64(src, cpu_env, vsr64_offset(n, true));
 }
=20
 static inline void set_cpu_vsrl(int n, TCGv_i64 src)
 {
-    if (n < 32) {
-        set_vsrl(n, src);
-    } else {
-        set_avr64(n - 32, src, false);
-    }
+    tcg_gen_st_i64(src, cpu_env, vsr64_offset(n, false));
 }
=20
 #define VSX_LOAD_SCALAR(name, operation)                      \
--=20
2.20.1
