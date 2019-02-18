Received: from eggs.gnu.org ([209.51.188.92]:39596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvjyD-0006oP-Eh
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:32:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvjxw-0003GP-NH
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:32:23 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 19 Feb 2019 01:30:42 +1100
Message-Id: <20190218143049.17142-37-david@gibson.dropbear.id.au>
In-Reply-To: <20190218143049.17142-1-david@gibson.dropbear.id.au>
References: <20190218143049.17142-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 36/43] target/ppc: Use helper_mtvscr for reset
 and gdb
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

Not setting flush_to_zero from gdb_set_avr_reg was a bug.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Message-Id: <20190215100058.20015-11-mark.cave-ayland@ilande.co.uk>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/translate_init.inc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.=
inc.c
index c9985c0d22..ee574b342e 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -601,10 +601,9 @@ static void spr_write_excp_vector(DisasContext *ctx,=
 int sprn, int gprn)
=20
 static inline void vscr_init(CPUPPCState *env, uint32_t val)
 {
-    env->vscr =3D val;
     /* Altivec always uses round-to-nearest */
     set_float_rounding_mode(float_round_nearest_even, &env->vec_status);
-    set_flush_to_zero(vscr_nj, &env->vec_status);
+    helper_mtvscr(env, val);
 }
=20
 #ifdef CONFIG_USER_ONLY
@@ -9603,7 +9602,7 @@ static int gdb_set_avr_reg(CPUPPCState *env, uint8_=
t *mem_buf, int n)
     }
     if (n =3D=3D 32) {
         ppc_maybe_bswap_register(env, mem_buf, 4);
-        env->vscr =3D ldl_p(mem_buf);
+        helper_mtvscr(env, ldl_p(mem_buf));
         return 4;
     }
     if (n =3D=3D 33) {
--=20
2.20.1
