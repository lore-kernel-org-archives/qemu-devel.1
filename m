Received: from eggs.gnu.org ([209.51.188.92]:43256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2tor-0001gf-0E
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:28:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2toq-0001ny-15
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:28:28 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Sun, 10 Mar 2019 19:26:37 +1100
Message-Id: <20190310082703.1245-35-david@gibson.dropbear.id.au>
In-Reply-To: <20190310082703.1245-1-david@gibson.dropbear.id.au>
References: <20190310082703.1245-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 34/60] target/ppc: introduce single fpr_offset()
 function
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

Instead of having multiple copies of the offset calculation logic, move i=
t to a
single fpr_offset() function.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20190307180520.13868-2-mark.cave-ayland@ilande.co.uk>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/cpu.h       | 7 ++++++-
 target/ppc/translate.c | 4 ++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 81763d72f9..15e053becd 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -2563,9 +2563,14 @@ static inline bool lsw_reg_in_range(int start, int=
 nregs, int rx)
 }
=20
 /* Accessors for FP, VMX and VSX registers */
+static inline int fpr_offset(int i)
+{
+    return offsetof(CPUPPCState, vsr[i].u64[0]);
+}
+
 static inline uint64_t *cpu_fpr_ptr(CPUPPCState *env, int i)
 {
-    return &env->vsr[i].u64[0];
+    return (uint64_t *)((uintptr_t)env + fpr_offset(i));
 }
=20
 static inline uint64_t *cpu_vsrl_ptr(CPUPPCState *env, int i)
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index b156be4d98..668d4cf75a 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -6677,12 +6677,12 @@ GEN_TM_PRIV_NOOP(trechkpt);
=20
 static inline void get_fpr(TCGv_i64 dst, int regno)
 {
-    tcg_gen_ld_i64(dst, cpu_env, offsetof(CPUPPCState, vsr[regno].u64[0]=
));
+    tcg_gen_ld_i64(dst, cpu_env, fpr_offset(regno));
 }
=20
 static inline void set_fpr(int regno, TCGv_i64 src)
 {
-    tcg_gen_st_i64(src, cpu_env, offsetof(CPUPPCState, vsr[regno].u64[0]=
));
+    tcg_gen_st_i64(src, cpu_env, fpr_offset(regno));
 }
=20
 static inline void get_avr64(TCGv_i64 dst, int regno, bool high)
--=20
2.20.1
