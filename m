Received: from eggs.gnu.org ([2001:4830:134:3::10]:46479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUk4-00031z-Jq
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:03:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUk2-0006bP-6h
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:03:52 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 12 Jan 2017 13:02:49 +1100
Message-Id: <20170112020327.24882-30-david@gibson.dropbear.id.au>
In-Reply-To: <20170112020327.24882-1-david@gibson.dropbear.id.au>
References: <20170112020327.24882-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 29/67] target-ppc: implement stxvl instruction
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

stxvl: Store VSX Vector with Length

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

Storing 14 bytes would result in following Little/Big-endian Storage:
+---+---+---+---+---+---+---+---+---+---+---+---+---+---+--+--+
|=E2=80=9CT=E2=80=9D|=E2=80=9Ch=E2=80=9D|=E2=80=9Ci=E2=80=9D|=E2=80=9Cs=E2=
=80=9D|=E2=80=9C =E2=80=9D|=E2=80=9Ci=E2=80=9D|=E2=80=9Cs=E2=80=9D|=E2=80=
=9C =E2=80=9D|=E2=80=9Ca=E2=80=9D|=E2=80=9C =E2=80=9D|=E2=80=9CT=E2=80=9D=
|=E2=80=9CE=E2=80=9D|=E2=80=9CS=E2=80=9D|=E2=80=9CT=E2=80=9D|FF|FF|
+---+---+---+---+---+---+---+---+---+---+---+---+---+---+--+--+

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/helper.h                 |  1 +
 target/ppc/mem_helper.c             | 29 +++++++++++++++++++++++++++++
 target/ppc/translate/vsx-impl.inc.c |  1 +
 target/ppc/translate/vsx-ops.inc.c  |  3 +++
 4 files changed, 34 insertions(+)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 6c44731..211313d 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -320,6 +320,7 @@ DEF_HELPER_3(stvewx, void, env, avr, tl)
 #if defined(TARGET_PPC64)
 DEF_HELPER_4(lxvl, void, env, tl, tl, tl)
 DEF_HELPER_4(lxvll, void, env, tl, tl, tl)
+DEF_HELPER_4(stxvl, void, env, tl, tl, tl)
 #endif
 DEF_HELPER_4(vsumsws, void, env, avr, avr, avr)
 DEF_HELPER_4(vsum2sws, void, env, avr, avr, avr)
diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
index da51465..2427b49 100644
--- a/target/ppc/mem_helper.c
+++ b/target/ppc/mem_helper.c
@@ -317,6 +317,35 @@ void helper_##name(CPUPPCState *env, target_ulong ad=
dr,                 \
 VSX_LXVL(lxvl, 0)
 VSX_LXVL(lxvll, 1)
 #undef VSX_LXVL
+
+#define VSX_STXVL(name, lj)                                       \
+void helper_##name(CPUPPCState *env, target_ulong addr,           \
+                   target_ulong xt_num, target_ulong rb)          \
+{                                                                 \
+    int i;                                                        \
+    ppc_vsr_t xt;                                                 \
+    target_ulong nb =3D GET_NB(rb);                                 \
+                                                                  \
+    if (!nb) {                                                    \
+        return;                                                   \
+    }                                                             \
+    getVSR(xt_num, &xt, env);                                     \
+    nb =3D (nb >=3D 16) ? 16 : nb;                                    \
+    if (msr_le && !lj) {                                          \
+        for (i =3D 16; i > 16 - nb; i--) {                          \
+            cpu_stb_data_ra(env, addr, xt.VsrB(i - 1), GETPC());  \
+            addr =3D addr_add(env, addr, 1);                        \
+        }                                                         \
+    } else {                                                      \
+        for (i =3D 0; i < nb; i++) {                                \
+            cpu_stb_data_ra(env, addr, xt.VsrB(i), GETPC());      \
+            addr =3D addr_add(env, addr, 1);                        \
+        }                                                         \
+    }                                                             \
+}
+
+VSX_STXVL(stxvl, 0)
+#undef VSX_STXVL
 #undef GET_NB
 #endif /* TARGET_PPC64 */
=20
diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/v=
sx-impl.inc.c
index ce20579..5099d44 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -268,6 +268,7 @@ static void gen_##name(DisasContext *ctx)            =
           \
=20
 VSX_VECTOR_LOAD_STORE_LENGTH(lxvl)
 VSX_VECTOR_LOAD_STORE_LENGTH(lxvll)
+VSX_VECTOR_LOAD_STORE_LENGTH(stxvl)
 #endif
=20
 #define VSX_LOAD_SCALAR_DS(name, operation)                       \
diff --git a/target/ppc/translate/vsx-ops.inc.c b/target/ppc/translate/vs=
x-ops.inc.c
index c207804..3afded2 100644
--- a/target/ppc/translate/vsx-ops.inc.c
+++ b/target/ppc/translate/vsx-ops.inc.c
@@ -25,6 +25,9 @@ GEN_HANDLER_E(stxvw4x, 0x1F, 0xC, 0x1C, 0, PPC_NONE, PP=
C2_VSX),
 GEN_HANDLER_E(stxvh8x, 0x1F, 0x0C, 0x1D, 0, PPC_NONE,  PPC2_ISA300),
 GEN_HANDLER_E(stxvb16x, 0x1F, 0x0C, 0x1F, 0, PPC_NONE, PPC2_ISA300),
 GEN_HANDLER_E(stxvx, 0x1F, 0x0C, 0x0C, 0, PPC_NONE, PPC2_ISA300),
+#if defined(TARGET_PPC64)
+GEN_HANDLER_E(stxvl, 0x1F, 0x0D, 0x0C, 0, PPC_NONE, PPC2_ISA300),
+#endif
=20
 GEN_HANDLER_E(mfvsrwz, 0x1F, 0x13, 0x03, 0x0000F800, PPC_NONE, PPC2_VSX2=
07),
 GEN_HANDLER_E(mtvsrwa, 0x1F, 0x13, 0x06, 0x0000F800, PPC_NONE, PPC2_VSX2=
07),
--=20
2.9.3
