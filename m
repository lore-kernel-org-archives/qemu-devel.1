Received: from eggs.gnu.org ([209.51.188.92]:39913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvjyY-00078K-9K
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:32:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvjyW-0003Yy-IR
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:32:54 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 19 Feb 2019 01:30:47 +1100
Message-Id: <20190218143049.17142-42-david@gibson.dropbear.id.au>
In-Reply-To: <20190218143049.17142-1-david@gibson.dropbear.id.au>
References: <20190218143049.17142-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 41/43] target/ppc: Split out VSCR_SAT to a
 vector field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, Richard Henderson <richard.henderson@linaro.org>, David Gibson <david@gibson.dropbear.id.au>

From: Richard Henderson <richard.henderson@linaro.org>

Change the representation of VSCR_SAT such that it is easy
to set from vector code.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Message-Id: <20190215100058.20015-16-mark.cave-ayland@ilande.co.uk>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/cpu.h        |  4 +++-
 target/ppc/int_helper.c | 11 ++++++++---
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 1c883fa836..325ebbeb98 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1052,10 +1052,12 @@ struct CPUPPCState {
     /* Special purpose registers */
     target_ulong spr[1024];
     ppc_spr_t spr_cb[1024];
-    /* Vector status and control register */
+    /* Vector status and control register, minus VSCR_SAT.  */
     uint32_t vscr;
     /* VSX registers (including FP and AVR) */
     ppc_vsr_t vsr[64] QEMU_ALIGNED(16);
+    /* Non-zero if and only if VSCR_SAT should be set.  */
+    ppc_vsr_t vscr_sat QEMU_ALIGNED(16);
     /* SPE registers */
     uint64_t spe_acc;
     uint32_t spe_fscr;
diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index 1d8a4b530b..6ad596a08b 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -459,18 +459,23 @@ void helper_lvsr(ppc_avr_t *r, target_ulong sh)
=20
 void helper_mtvscr(CPUPPCState *env, uint32_t vscr)
 {
-    env->vscr =3D vscr;
+    env->vscr =3D vscr & ~(1u << VSCR_SAT);
+    /* Which bit we set is completely arbitrary, but clear the rest.  */
+    env->vscr_sat.u64[0] =3D vscr & (1u << VSCR_SAT);
+    env->vscr_sat.u64[1] =3D 0;
     set_flush_to_zero((vscr >> VSCR_NJ) & 1, &env->vec_status);
 }
=20
 uint32_t helper_mfvscr(CPUPPCState *env)
 {
-    return env->vscr;
+    uint32_t sat =3D (env->vscr_sat.u64[0] | env->vscr_sat.u64[1]) !=3D =
0;
+    return env->vscr | (sat << VSCR_SAT);
 }
=20
 static inline void set_vscr_sat(CPUPPCState *env)
 {
-    env->vscr |=3D 1 << VSCR_SAT;
+    /* The choice of non-zero value is arbitrary.  */
+    env->vscr_sat.u32[0] =3D 1;
 }
=20
 void helper_vaddcuw(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
--=20
2.20.1
