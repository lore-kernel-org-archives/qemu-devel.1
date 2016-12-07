Received: from eggs.gnu.org ([2001:4830:134:3::10]:52331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cEguS-0004tb-5q
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 13:25:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cEguO-0001q4-BP
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 13:25:40 -0500
Received: from 001b2d01.pphosted.com ([148.163.156.1]:36529
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cEguN-0001pn-RD
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 13:25:36 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uB7IJuVS057224
	for <qemu-devel@nongnu.org>; Wed, 7 Dec 2016 13:25:34 -0500
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 276m5xkugp-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 07 Dec 2016 13:25:34 -0500
Received: from localhost
	by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Wed, 7 Dec 2016 23:55:30 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Wed,  7 Dec 2016 23:54:57 +0530
In-Reply-To: <1481135102-20011-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1481135102-20011-1-git-send-email-nikunj@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1481135102-20011-5-git-send-email-nikunj@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v1 4/9] target-ppc: implement stxvll
 instructions
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

stxvll: Store VSX Vector Left-justified with Length

Vector (8-bit elements) in LE/BE:
+---+---+---+---+---+---+---+---+---+---+---+---+---+---+--+--+
|=E2=80=9CT=E2=80=9D|=E2=80=9Ch=E2=80=9D|=E2=80=9Ci=E2=80=9D|=E2=80=9Cs=E2=
=80=9D|=E2=80=9C =E2=80=9D|=E2=80=9Ci=E2=80=9D|=E2=80=9Cs=E2=80=9D|=E2=80=
=9C =E2=80=9D|=E2=80=9Ca=E2=80=9D|=E2=80=9C =E2=80=9D|=E2=80=9CT=E2=80=9D=
|=E2=80=9CE=E2=80=9D|=E2=80=9CS=E2=80=9D|=E2=80=9CT=E2=80=9D|00|00|
+---+---+---+---+---+---+---+---+---+---+---+---+---+---+--+--+

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
 target-ppc/mem_helper.c             | 18 ++++++++++++++++++
 target-ppc/translate/vsx-impl.inc.c |  1 +
 target-ppc/translate/vsx-ops.inc.c  |  1 +
 4 files changed, 21 insertions(+)

diff --git a/target-ppc/helper.h b/target-ppc/helper.h
index 5ddc96d..91bdfc3 100644
--- a/target-ppc/helper.h
+++ b/target-ppc/helper.h
@@ -320,6 +320,7 @@ DEF_HELPER_3(stvewx, void, env, avr, tl)
 DEF_HELPER_4(lxvl, void, env, tl, tl, tl)
 DEF_HELPER_4(lxvll, void, env, tl, tl, tl)
 DEF_HELPER_4(stxvl, void, env, tl, tl, tl)
+DEF_HELPER_4(stxvll, void, env, tl, tl, tl)
 DEF_HELPER_4(vsumsws, void, env, avr, avr, avr)
 DEF_HELPER_4(vsum2sws, void, env, avr, avr, avr)
 DEF_HELPER_4(vsum4sbs, void, env, avr, avr, avr)
diff --git a/target-ppc/mem_helper.c b/target-ppc/mem_helper.c
index 771c660..c603ef5 100644
--- a/target-ppc/mem_helper.c
+++ b/target-ppc/mem_helper.c
@@ -359,6 +359,24 @@ void helper_stxvl(CPUPPCState *env, target_ulong add=
r,
     }
 }
=20
+void helper_stxvll(CPUPPCState *env, target_ulong addr,
+                   target_ulong xt_num, target_ulong rb)
+{
+    int i;
+    ppc_vsr_t xt;
+    target_ulong nb =3D GET_NB(rb);
+
+    if (!nb) {
+        return;
+    }
+    getVSR(xt_num, &xt, env);
+    nb =3D (nb >=3D 16) ? 16 : nb;
+    for (i =3D 0; i < nb; i++) {
+        cpu_stb_data_ra(env, addr, xt.VsrB(i), GETPC());
+        addr =3D addr_add(env, addr, 1);
+    }
+}
+
 #undef HI_IDX
 #undef LO_IDX
 #undef GET_NB
diff --git a/target-ppc/translate/vsx-impl.inc.c b/target-ppc/translate/v=
sx-impl.inc.c
index 6d61285..c691141 100644
--- a/target-ppc/translate/vsx-impl.inc.c
+++ b/target-ppc/translate/vsx-impl.inc.c
@@ -268,6 +268,7 @@ static void gen_##name(DisasContext *ctx)            =
           \
 VSX_VECTOR_LOAD_STORE_LENGTH(lxvl)
 VSX_VECTOR_LOAD_STORE_LENGTH(lxvll)
 VSX_VECTOR_LOAD_STORE_LENGTH(stxvl)
+VSX_VECTOR_LOAD_STORE_LENGTH(stxvll)
=20
 #define VSX_LOAD_SCALAR_DS(name, operation)                       \
 static void gen_##name(DisasContext *ctx)                         \
diff --git a/target-ppc/translate/vsx-ops.inc.c b/target-ppc/translate/vs=
x-ops.inc.c
index 76eba3c..be446ae 100644
--- a/target-ppc/translate/vsx-ops.inc.c
+++ b/target-ppc/translate/vsx-ops.inc.c
@@ -24,6 +24,7 @@ GEN_HANDLER_E(stxvh8x, 0x1F, 0x0C, 0x1D, 0, PPC_NONE,  =
PPC2_ISA300),
 GEN_HANDLER_E(stxvb16x, 0x1F, 0x0C, 0x1F, 0, PPC_NONE, PPC2_ISA300),
 GEN_HANDLER_E(stxvx, 0x1F, 0x0C, 0x0C, 0, PPC_NONE, PPC2_ISA300),
 GEN_HANDLER_E(stxvl, 0x1F, 0x0D, 0x0C, 0, PPC_NONE, PPC2_ISA300),
+GEN_HANDLER_E(stxvll, 0x1F, 0x0D, 0x0D, 0, PPC_NONE, PPC2_ISA300),
=20
 GEN_HANDLER_E(mfvsrwz, 0x1F, 0x13, 0x03, 0x0000F800, PPC_NONE, PPC2_VSX2=
07),
 GEN_HANDLER_E(mtvsrwa, 0x1F, 0x13, 0x06, 0x0000F800, PPC_NONE, PPC2_VSX2=
07),
--=20
2.7.4
