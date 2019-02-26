Received: from eggs.gnu.org ([209.51.188.92]:57855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyUkq-000518-SZ
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 23:54:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyUko-0002U2-W9
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 23:54:08 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 26 Feb 2019 15:52:39 +1100
Message-Id: <20190226045304.25618-26-david@gibson.dropbear.id.au>
In-Reply-To: <20190226045304.25618-1-david@gibson.dropbear.id.au>
References: <20190226045304.25618-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 25/50] target/ppc: Flush the TLB locally when
 the LPIDR is written
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: gkurz@kaod.org, clg@kaod.org, lvivier@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Gibson <david@gibson.dropbear.id.au>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Our TCG TLB only tags whether it's a HV vs a guest access, so it must
be flushed when the LPIDR is changed.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20190215170029.15641-10-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/helper.h             |  1 +
 target/ppc/misc_helper.c        | 15 +++++++++++++++
 target/ppc/translate_init.inc.c |  7 ++++++-
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 18910d18a4..638a6e99c4 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -689,6 +689,7 @@ DEF_HELPER_2(store_ptcr, void, env, tl)
 #endif
 DEF_HELPER_2(store_sdr1, void, env, tl)
 DEF_HELPER_2(store_pidr, void, env, tl)
+DEF_HELPER_2(store_lpidr, void, env, tl)
 DEF_HELPER_FLAGS_2(store_tbl, TCG_CALL_NO_RWG, void, env, tl)
 DEF_HELPER_FLAGS_2(store_tbu, TCG_CALL_NO_RWG, void, env, tl)
 DEF_HELPER_FLAGS_2(store_atbl, TCG_CALL_NO_RWG, void, env, tl)
diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
index b884930096..c65d1ade15 100644
--- a/target/ppc/misc_helper.c
+++ b/target/ppc/misc_helper.c
@@ -117,6 +117,21 @@ void helper_store_pidr(CPUPPCState *env, target_ulon=
g val)
     tlb_flush(CPU(cpu));
 }
=20
+void helper_store_lpidr(CPUPPCState *env, target_ulong val)
+{
+    PowerPCCPU *cpu =3D ppc_env_get_cpu(env);
+
+    env->spr[SPR_LPIDR] =3D val;
+
+    /*
+     * We need to flush the TLB on LPID changes as we only tag HV vs
+     * guest in TCG TLB. Also the quadrants means the HV will
+     * potentially access and cache entries for the current LPID as
+     * well.
+     */
+    tlb_flush(CPU(cpu));
+}
+
 void helper_store_hid0_601(CPUPPCState *env, target_ulong val)
 {
     target_ulong hid0;
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.=
inc.c
index 965c5273a6..58542c0fe0 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -408,6 +408,11 @@ static void spr_write_pidr(DisasContext *ctx, int sp=
rn, int gprn)
     gen_helper_store_pidr(cpu_env, cpu_gpr[gprn]);
 }
=20
+static void spr_write_lpidr(DisasContext *ctx, int sprn, int gprn)
+{
+    gen_helper_store_lpidr(cpu_env, cpu_gpr[gprn]);
+}
+
 static void spr_read_hior(DisasContext *ctx, int gprn, int sprn)
 {
     tcg_gen_ld_tl(cpu_gpr[gprn], cpu_env, offsetof(CPUPPCState, excp_pre=
fix));
@@ -7885,7 +7890,7 @@ static void gen_spr_book3s_ids(CPUPPCState *env)
     spr_register_hv(env, SPR_LPIDR, "LPIDR",
                  SPR_NOACCESS, SPR_NOACCESS,
                  SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
+                 &spr_read_generic, &spr_write_lpidr,
                  0x00000000);
     spr_register_hv(env, SPR_HFSCR, "HFSCR",
                  SPR_NOACCESS, SPR_NOACCESS,
--=20
2.20.1
