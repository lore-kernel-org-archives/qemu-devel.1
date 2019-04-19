Received: from eggs.gnu.org ([209.51.188.92]:50593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nick.hudson@gmx.co.uk>) id 1hHafM-0004BD-Uh
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 17:03:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nick.hudson@gmx.co.uk>) id 1hHafL-0003po-IA
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 17:03:24 -0400
Received: from mout.gmx.net ([212.227.15.15]:38277)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <nick.hudson@gmx.co.uk>)
	id 1hHafL-0003pP-83
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 17:03:23 -0400
From: Nick Hudson <nick.hudson@gmx.co.uk>
Message-ID: <fd03477a-f688-c2ab-72c6-bca9a53fa291@gmx.co.uk>
Date: Fri, 19 Apr 2019 22:03:10 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v1 1/2] Implement the pcxl and pcxl2 Fast TLB
 Insert, instructions as used by NetBSD (and OpenBSD)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Richard Henderson <rth@twiddle.net>

Implement the pcxl and pcxl2 Fast TLB Insert instructions as used by NetBS=
D (and OpenBSD)

See
     https://parisc.wiki.kernel.org/images-parisc/a/a9/Pcxl2_ers.pdf
     page 13-9 (195/206)

Signed-off-by: Nick Hudson <skrll@netbsd.org>
=2D--
 target/hppa/insns.decode |  3 +++
 target/hppa/translate.c  | 54 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index 098370c2f0..f0dd71dd08 100644
=2D-- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -133,6 +133,9 @@ ixtlbx          000001 b:5 r:5 sp:2 0100000 addr:1 0 0=
0000      data=3D1
 ixtlbx          000001 b:5 r:5 ... 000000 addr:1 0 00000        \
                 sp=3D%assemble_sr3x data=3D0
 +# pcxl and pcxl2 Fast TLB Insert instructions
+ixtlbxf         000001 00000 r:5 00 0 data:1 01000 addr:1 0 00000
+
 pxtlbx          000001 b:5 x:5 sp:2 0100100 local:1 m:1 -----   data=3D1
 pxtlbx          000001 b:5 x:5 ... 000100 local:1 m:1 -----     \
                 sp=3D%assemble_sr3x data=3D0
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 43b74367ea..860a659818 100644
=2D-- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2518,6 +2518,60 @@ static bool trans_pxtlbx(DisasContext *ctx, arg_pxt=
lbx *a)
 #endif
 }
 +/* Implement the pcxl and pcxl2 Fast TLB Insert instructions.
+ * See
+ *     https://parisc.wiki.kernel.org/images-parisc/a/a9/Pcxl2_ers.pdf
+ *     page 13-9 (195/206) */
+static bool trans_ixtlbxf(DisasContext *ctx, arg_ixtlbxf *a)
+{
+    CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
+#ifndef CONFIG_USER_ONLY
+    TCGv_tl addr;
+    TCGv_reg reg;
+    TCGv_reg ar, sr;
+    TCGv_tl atl, stl;
+
+    nullify_over(ctx);
+
+//    if (not (pcx or pcxl2))
+//        return gen_illegal(ctx);
+
+    ar =3D get_temp(ctx);
+    sr =3D get_temp(ctx);
+    atl =3D get_temp_tl(ctx);
+    stl =3D get_temp_tl(ctx);
+    addr =3D get_temp_tl(ctx);
+
+
+    if (a->data) {
+        gen_helper_ixtlbxf_d(cpu_env);
+        tcg_gen_ld_reg(sr, cpu_env, offsetof(CPUHPPAState, cr[CR_ISR]));
+        tcg_gen_ld_reg(ar, cpu_env, offsetof(CPUHPPAState, cr[CR_IOR]));
+    } else {
+        gen_helper_ixtlbxf_i(cpu_env);
+        tcg_gen_ld_reg(sr, cpu_env, offsetof(CPUHPPAState, cr[CR_IIASQ]))=
;
+        tcg_gen_ld_reg(ar, cpu_env, offsetof(CPUHPPAState, cr[CR_IIAOQ]))=
;
+    }
+
+    tcg_gen_extu_reg_tl(atl, ar);
+    tcg_gen_extu_reg_tl(stl, sr);
+    tcg_gen_shli_i64(stl, stl, 32);
+    tcg_gen_or_tl(addr, atl, stl);
+    reg =3D load_gpr(ctx, a->r);
+    if (a->addr) {
+        gen_helper_itlba(cpu_env, addr, reg);
+    } else {
+        gen_helper_itlbp(cpu_env, addr, reg);
+    }
+
+    /* Exit TB for TLB change if mmu is enabled.  */
+    if (ctx->tb_flags & PSW_C) {
+        ctx->base.is_jmp =3D DISAS_IAQ_N_STALE;
+    }
+    return nullify_end(ctx);
+#endif
+}
+
 static bool trans_lpa(DisasContext *ctx, arg_ldst *a)
 {
     CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
=2D-
2.17.1
