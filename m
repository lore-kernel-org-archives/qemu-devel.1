Received: from eggs.gnu.org ([2001:4830:134:3::10]:52240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cEguG-0004ju-8p
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 13:25:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cEguB-0001mR-9Z
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 13:25:28 -0500
Received: from 001b2d01.pphosted.com ([148.163.156.1]:40561
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cEguA-0001m8-W7
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 13:25:23 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uB7IKWV3071574
	for <qemu-devel@nongnu.org>; Wed, 7 Dec 2016 13:25:22 -0500
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 276nmypr3u-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 07 Dec 2016 13:25:21 -0500
Received: from localhost
	by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Wed, 7 Dec 2016 23:55:18 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Wed,  7 Dec 2016 23:54:54 +0530
In-Reply-To: <1481135102-20011-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1481135102-20011-1-git-send-email-nikunj@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1481135102-20011-2-git-send-email-nikunj@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v1 1/9] target-ppc: implement lxvl instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net
Cc: qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com

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
---
 target-ppc/helper.h                 |  1 +
 target-ppc/mem_helper.c             | 33 +++++++++++++++++++++++++++++++=
++
 target-ppc/translate/vsx-impl.inc.c | 27 +++++++++++++++++++++++++++
 target-ppc/translate/vsx-ops.inc.c  |  1 +
 4 files changed, 62 insertions(+)

diff --git a/target-ppc/helper.h b/target-ppc/helper.h
index bc39efb..d9ccafd 100644
--- a/target-ppc/helper.h
+++ b/target-ppc/helper.h
@@ -317,6 +317,7 @@ DEF_HELPER_3(lvewx, void, env, avr, tl)
 DEF_HELPER_3(stvebx, void, env, avr, tl)
 DEF_HELPER_3(stvehx, void, env, avr, tl)
 DEF_HELPER_3(stvewx, void, env, avr, tl)
+DEF_HELPER_4(lxvl, void, env, tl, tl, tl)
 DEF_HELPER_4(vsumsws, void, env, avr, avr, avr)
 DEF_HELPER_4(vsum2sws, void, env, avr, avr, avr)
 DEF_HELPER_4(vsum4sbs, void, env, avr, avr, avr)
diff --git a/target-ppc/mem_helper.c b/target-ppc/mem_helper.c
index 1ab8a6e..54447a7 100644
--- a/target-ppc/mem_helper.c
+++ b/target-ppc/mem_helper.c
@@ -24,6 +24,7 @@
=20
 #include "helper_regs.h"
 #include "exec/cpu_ldst.h"
+#include "internal.h"
=20
 //#define DEBUG_OP
=20
@@ -284,8 +285,40 @@ STVE(stvewx, cpu_stl_data_ra, bswap32, u32)
 #undef I
 #undef LVE
=20
+#ifdef TARGET_PPC64
+#define GET_NB(rb) ((rb >> 56) & 0xFF)
+#else
+#define GET_NB(rb) ((rb >> 24) & 0xFF)
+#endif
+
+void helper_lxvl(CPUPPCState *env, target_ulong addr,
+                 target_ulong xt_num, target_ulong rb)
+{
+    int i;
+    ppc_vsr_t xt;
+    uint64_t nb =3D GET_NB(rb);
+
+    xt.s128 =3D int128_zero();
+    if (nb) {
+        nb =3D (nb >=3D 16) ? 16 : nb;
+        if (msr_le) {
+            for (i =3D 16; i > 16 - nb; i--) {
+                xt.VsrB(i - 1) =3D cpu_ldub_data_ra(env, addr, GETPC());
+                addr =3D addr_add(env, addr, 1);
+            }
+        } else {
+            for (i =3D 0; i < nb; i++) {
+                xt.VsrB(i) =3D cpu_ldub_data_ra(env, addr, GETPC());
+                addr =3D addr_add(env, addr, 1);
+            }
+        }
+    }
+    putVSR(xt_num, &xt, env);
+}
+
 #undef HI_IDX
 #undef LO_IDX
+#undef GET_NB
=20
 void helper_tbegin(CPUPPCState *env)
 {
diff --git a/target-ppc/translate/vsx-impl.inc.c b/target-ppc/translate/v=
sx-impl.inc.c
index 808ee48..6bd70a0 100644
--- a/target-ppc/translate/vsx-impl.inc.c
+++ b/target-ppc/translate/vsx-impl.inc.c
@@ -240,6 +240,33 @@ VSX_VECTOR_LOAD_STORE(stxv, st_i64, 0)
 VSX_VECTOR_LOAD_STORE(lxvx, ld_i64, 1)
 VSX_VECTOR_LOAD_STORE(stxvx, st_i64, 1)
=20
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
+
 #define VSX_LOAD_SCALAR_DS(name, operation)                       \
 static void gen_##name(DisasContext *ctx)                         \
 {                                                                 \
diff --git a/target-ppc/translate/vsx-ops.inc.c b/target-ppc/translate/vs=
x-ops.inc.c
index daf6a56..4940ab2 100644
--- a/target-ppc/translate/vsx-ops.inc.c
+++ b/target-ppc/translate/vsx-ops.inc.c
@@ -10,6 +10,7 @@ GEN_HANDLER_E(lxvw4x, 0x1F, 0x0C, 0x18, 0, PPC_NONE, PP=
C2_VSX),
 GEN_HANDLER_E(lxvh8x, 0x1F, 0x0C, 0x19, 0, PPC_NONE,  PPC2_ISA300),
 GEN_HANDLER_E(lxvb16x, 0x1F, 0x0C, 0x1B, 0, PPC_NONE, PPC2_ISA300),
 GEN_HANDLER_E(lxvx, 0x1F, 0x0C, 0x08, 0x00000040, PPC_NONE, PPC2_ISA300)=
,
+GEN_HANDLER_E(lxvl, 0x1F, 0x0D, 0x08, 0, PPC_NONE, PPC2_ISA300),
=20
 GEN_HANDLER_E(stxsdx, 0x1F, 0xC, 0x16, 0, PPC_NONE, PPC2_VSX),
 GEN_HANDLER_E(stxsibx, 0x1F, 0xD, 0x1C, 0, PPC_NONE, PPC2_ISA300),
--=20
2.7.4
