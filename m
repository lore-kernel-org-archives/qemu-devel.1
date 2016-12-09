Received: from eggs.gnu.org ([2001:4830:134:3::10]:47586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cFK7q-0006Lj-24
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:18:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cFK7l-000303-2J
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:18:06 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43316
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cFK7k-0002zw-TT
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:18:00 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uB9CEN1L121219
	for <qemu-devel@nongnu.org>; Fri, 9 Dec 2016 07:18:00 -0500
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [125.16.236.9])
	by mx0b-001b2d01.pphosted.com with ESMTP id 277rtnkaum-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 09 Dec 2016 07:18:00 -0500
Received: from localhost
	by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Fri, 9 Dec 2016 17:47:57 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Fri,  9 Dec 2016 17:47:22 +0530
In-Reply-To: <1481285845-16415-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1481285845-16415-1-git-send-email-nikunj@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1481285845-16415-4-git-send-email-nikunj@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 3/6] target-ppc: implement stxvl instruction
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
---
 target-ppc/helper.h                 |  1 +
 target-ppc/mem_helper.c             | 29 +++++++++++++++++++++++++++++
 target-ppc/translate/vsx-impl.inc.c |  1 +
 target-ppc/translate/vsx-ops.inc.c  |  3 +++
 4 files changed, 34 insertions(+)

diff --git a/target-ppc/helper.h b/target-ppc/helper.h
index 6c44731..211313d 100644
--- a/target-ppc/helper.h
+++ b/target-ppc/helper.h
@@ -320,6 +320,7 @@ DEF_HELPER_3(stvewx, void, env, avr, tl)
 #if defined(TARGET_PPC64)
 DEF_HELPER_4(lxvl, void, env, tl, tl, tl)
 DEF_HELPER_4(lxvll, void, env, tl, tl, tl)
+DEF_HELPER_4(stxvl, void, env, tl, tl, tl)
 #endif
 DEF_HELPER_4(vsumsws, void, env, avr, avr, avr)
 DEF_HELPER_4(vsum2sws, void, env, avr, avr, avr)
diff --git a/target-ppc/mem_helper.c b/target-ppc/mem_helper.c
index da51465..2427b49 100644
--- a/target-ppc/mem_helper.c
+++ b/target-ppc/mem_helper.c
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
diff --git a/target-ppc/translate/vsx-impl.inc.c b/target-ppc/translate/v=
sx-impl.inc.c
index ce20579..5099d44 100644
--- a/target-ppc/translate/vsx-impl.inc.c
+++ b/target-ppc/translate/vsx-impl.inc.c
@@ -268,6 +268,7 @@ static void gen_##name(DisasContext *ctx)            =
           \
=20
 VSX_VECTOR_LOAD_STORE_LENGTH(lxvl)
 VSX_VECTOR_LOAD_STORE_LENGTH(lxvll)
+VSX_VECTOR_LOAD_STORE_LENGTH(stxvl)
 #endif
=20
 #define VSX_LOAD_SCALAR_DS(name, operation)                       \
diff --git a/target-ppc/translate/vsx-ops.inc.c b/target-ppc/translate/vs=
x-ops.inc.c
index c207804..3afded2 100644
--- a/target-ppc/translate/vsx-ops.inc.c
+++ b/target-ppc/translate/vsx-ops.inc.c
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
2.7.4
