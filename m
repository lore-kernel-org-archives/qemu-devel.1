Received: from eggs.gnu.org ([2001:4830:134:3::10]:46406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUk3-0002zi-2Q
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:03:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUjz-0006XN-MK
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:03:51 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 12 Jan 2017 13:02:47 +1100
Message-Id: <20170112020327.24882-28-david@gibson.dropbear.id.au>
In-Reply-To: <20170112020327.24882-1-david@gibson.dropbear.id.au>
References: <20170112020327.24882-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 27/67] target-ppc: implement lxvl instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

lxvl: Load VSX Vector with Length

Little/Big-endian Storage:
+---+---+---+---+---+---+---+---+---+---+---+---+---+---+--+--+
|=E2=80=9CT=E2=80=9D|=E2=80=9Ch=E2=80=9D|=E2=80=9Ci=E2=80=9D|=E2=80=9Cs=E2=
=80=9D|=E2=80=9C =E2=80=9D|=E2=80=9Ci=E2=80=9D|=E2=80=9Cs=E2=80=9D|=E2=80=
=9C =E2=80=9D|=E2=80=9Ca=E2=80=9D|=E2=80=9C =E2=80=9D|=E2=80=9CT=E2=80=9D=
|=E2=80=9CE=E2=80=9D|=E2=80=9CS=E2=80=9D|=E2=80=9CT=E2=80=9D|FF|FF|
+---+---+---+---+---+---+---+---+---+---+---+---+---+---+--+--+

Loading 14 bytes results in:

Vector (8-bit elements) in BE:
+---+---+---+---+---+---+---+---+---+---+---+---+---+---+--+--+
|=E2=80=9CT=E2=80=9D|=E2=80=9Ch=E2=80=9D|=E2=80=9Ci=E2=80=9D|=E2=80=9Cs=E2=
=80=9D|=E2=80=9C =E2=80=9D|=E2=80=9Ci=E2=80=9D|=E2=80=9Cs=E2=80=9D|=E2=80=
=9C =E2=80=9D|=E2=80=9Ca=E2=80=9D|=E2=80=9C =E2=80=9D|=E2=80=9CT=E2=80=9D=
|=E2=80=9CE=E2=80=9D|=E2=80=9CS=E2=80=9D|=E2=80=9CT=E2=80=9D|00|00|
+---+---+---+---+---+---+---+---+---+---+---+---+---+---+--+--+

Vector (8-bit elements) in LE:
+--+--+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
|00|00|=E2=80=9CT=E2=80=9D|=E2=80=9CS=E2=80=9D|=E2=80=9CE=E2=80=9D|=E2=80=
=9CT=E2=80=9D|=E2=80=9C =E2=80=9D|=E2=80=9Ca=E2=80=9D|=E2=80=9C =E2=80=9D=
|=E2=80=9Cs=E2=80=9D|=E2=80=9Ci=E2=80=9D|=E2=80=9C =E2=80=9D|=E2=80=9Cs=E2=
=80=9D|=E2=80=9Ci=E2=80=9D|"h"|"T"|
+--+--+---+---+---+---+---+---+---+---+---+---+---+---+---+---+

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/helper.h                 |  3 +++
 target/ppc/mem_helper.c             | 35 +++++++++++++++++++++++++++++++=
++++
 target/ppc/translate/vsx-impl.inc.c | 29 +++++++++++++++++++++++++++++
 target/ppc/translate/vsx-ops.inc.c  |  3 +++
 4 files changed, 70 insertions(+)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index c3df982..16ed2c1 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -317,6 +317,9 @@ DEF_HELPER_3(lvewx, void, env, avr, tl)
 DEF_HELPER_3(stvebx, void, env, avr, tl)
 DEF_HELPER_3(stvehx, void, env, avr, tl)
 DEF_HELPER_3(stvewx, void, env, avr, tl)
+#if defined(TARGET_PPC64)
+DEF_HELPER_4(lxvl, void, env, tl, tl, tl)
+#endif
 DEF_HELPER_4(vsumsws, void, env, avr, avr, avr)
 DEF_HELPER_4(vsum2sws, void, env, avr, avr, avr)
 DEF_HELPER_4(vsum4sbs, void, env, avr, avr, avr)
diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
index 1ab8a6e..c4ddc5b 100644
--- a/target/ppc/mem_helper.c
+++ b/target/ppc/mem_helper.c
@@ -24,6 +24,7 @@
=20
 #include "helper_regs.h"
 #include "exec/cpu_ldst.h"
+#include "internal.h"
=20
 //#define DEBUG_OP
=20
@@ -284,6 +285,40 @@ STVE(stvewx, cpu_stl_data_ra, bswap32, u32)
 #undef I
 #undef LVE
=20
+#ifdef TARGET_PPC64
+#define GET_NB(rb) ((rb >> 56) & 0xFF)
+
+#define VSX_LXVL(name, lj)                                              =
\
+void helper_##name(CPUPPCState *env, target_ulong addr,                 =
\
+                   target_ulong xt_num, target_ulong rb)                =
\
+{                                                                       =
\
+    int i;                                                              =
\
+    ppc_vsr_t xt;                                                       =
\
+    uint64_t nb =3D GET_NB(rb);                                         =
  \
+                                                                        =
\
+    xt.s128 =3D int128_zero();                                          =
  \
+    if (nb) {                                                           =
\
+        nb =3D (nb >=3D 16) ? 16 : nb;                                  =
    \
+        if (msr_le && !lj) {                                            =
\
+            for (i =3D 16; i > 16 - nb; i--) {                          =
  \
+                xt.VsrB(i - 1) =3D cpu_ldub_data_ra(env, addr, GETPC());=
  \
+                addr =3D addr_add(env, addr, 1);                        =
  \
+            }                                                           =
\
+        } else {                                                        =
\
+            for (i =3D 0; i < nb; i++) {                                =
  \
+                xt.VsrB(i) =3D cpu_ldub_data_ra(env, addr, GETPC());    =
  \
+                addr =3D addr_add(env, addr, 1);                        =
  \
+            }                                                           =
\
+        }                                                               =
\
+    }                                                                   =
\
+    putVSR(xt_num, &xt, env);                                           =
\
+}
+
+VSX_LXVL(lxvl, 0)
+#undef VSX_LXVL
+#undef GET_NB
+#endif /* TARGET_PPC64 */
+
 #undef HI_IDX
 #undef LO_IDX
=20
diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/v=
sx-impl.inc.c
index 7000035..1f64fb7 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -240,6 +240,35 @@ VSX_VECTOR_LOAD_STORE(stxv, st_i64, 0)
 VSX_VECTOR_LOAD_STORE(lxvx, ld_i64, 1)
 VSX_VECTOR_LOAD_STORE(stxvx, st_i64, 1)
=20
+#ifdef TARGET_PPC64
+#define VSX_VECTOR_LOAD_STORE_LENGTH(name)                      \
+static void gen_##name(DisasContext *ctx)                       \
+{                                                               \
+    TCGv EA, xt;                                                \
+                                                                \
+    if (xT(ctx->opcode) < 32) {                                 \
+        if (unlikely(!ctx->vsx_enabled)) {                      \
+            gen_exception(ctx, POWERPC_EXCP_VSXU);              \
+            return;                                             \
+        }                                                       \
+    } else {                                                    \
+        if (unlikely(!ctx->altivec_enabled)) {                  \
+            gen_exception(ctx, POWERPC_EXCP_VPU);               \
+            return;                                             \
+        }                                                       \
+    }                                                           \
+    EA =3D tcg_temp_new();                                        \
+    xt =3D tcg_const_tl(xT(ctx->opcode));                         \
+    gen_set_access_type(ctx, ACCESS_INT);                       \
+    gen_addr_register(ctx, EA);                                 \
+    gen_helper_##name(cpu_env, EA, xt, cpu_gpr[rB(ctx->opcode)]); \
+    tcg_temp_free(EA);                                          \
+    tcg_temp_free(xt);                                          \
+}
+
+VSX_VECTOR_LOAD_STORE_LENGTH(lxvl)
+#endif
+
 #define VSX_LOAD_SCALAR_DS(name, operation)                       \
 static void gen_##name(DisasContext *ctx)                         \
 {                                                                 \
diff --git a/target/ppc/translate/vsx-ops.inc.c b/target/ppc/translate/vs=
x-ops.inc.c
index f684066..62a0afc 100644
--- a/target/ppc/translate/vsx-ops.inc.c
+++ b/target/ppc/translate/vsx-ops.inc.c
@@ -10,6 +10,9 @@ GEN_HANDLER_E(lxvw4x, 0x1F, 0x0C, 0x18, 0, PPC_NONE, PP=
C2_VSX),
 GEN_HANDLER_E(lxvh8x, 0x1F, 0x0C, 0x19, 0, PPC_NONE,  PPC2_ISA300),
 GEN_HANDLER_E(lxvb16x, 0x1F, 0x0C, 0x1B, 0, PPC_NONE, PPC2_ISA300),
 GEN_HANDLER_E(lxvx, 0x1F, 0x0C, 0x08, 0x00000040, PPC_NONE, PPC2_ISA300)=
,
+#if defined(TARGET_PPC64)
+GEN_HANDLER_E(lxvl, 0x1F, 0x0D, 0x08, 0, PPC_NONE, PPC2_ISA300),
+#endif
=20
 GEN_HANDLER_E(stxsdx, 0x1F, 0xC, 0x16, 0, PPC_NONE, PPC2_VSX),
 GEN_HANDLER_E(stxsibx, 0x1F, 0xD, 0x1C, 0, PPC_NONE, PPC2_ISA300),
--=20
2.9.3
