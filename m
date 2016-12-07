Received: from eggs.gnu.org ([2001:4830:134:3::10]:52260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cEguJ-0004mD-5o
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 13:25:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cEguE-0001oS-Ph
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 13:25:31 -0500
Received: from 001b2d01.pphosted.com ([148.163.156.1]:48325
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cEguE-0001o2-G9
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 13:25:26 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uB7IK0B2003165
	for <qemu-devel@nongnu.org>; Wed, 7 Dec 2016 13:25:25 -0500
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [125.16.236.9])
	by mx0a-001b2d01.pphosted.com with ESMTP id 276mpmjcc5-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 07 Dec 2016 13:25:25 -0500
Received: from localhost
	by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Wed, 7 Dec 2016 23:55:21 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Wed,  7 Dec 2016 23:54:55 +0530
In-Reply-To: <1481135102-20011-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1481135102-20011-1-git-send-email-nikunj@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1481135102-20011-3-git-send-email-nikunj@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v1 2/9] target-ppc: implement lxvll instruction
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

lxvll: Load VSX Vector Left-justified with Length

Little/Big-endian Storage:
+---+---+---+---+---+---+---+---+---+---+---+---+---+---+--+--+
|=E2=80=9CT=E2=80=9D|=E2=80=9Ch=E2=80=9D|=E2=80=9Ci=E2=80=9D|=E2=80=9Cs=E2=
=80=9D|=E2=80=9C =E2=80=9D|=E2=80=9Ci=E2=80=9D|=E2=80=9Cs=E2=80=9D|=E2=80=
=9C =E2=80=9D|=E2=80=9Ca=E2=80=9D|=E2=80=9C =E2=80=9D|=E2=80=9CT=E2=80=9D=
|=E2=80=9CE=E2=80=9D|=E2=80=9CS=E2=80=9D|=E2=80=9CT=E2=80=9D|FF|FF|
+---+---+---+---+---+---+---+---+---+---+---+---+---+---+--+--+

Loading 14 bytes to vector (8-bit elements) in BE/LE:
+---+---+---+---+---+---+---+---+---+---+---+---+---+---+--+--+
|=E2=80=9CT=E2=80=9D|=E2=80=9Ch=E2=80=9D|=E2=80=9Ci=E2=80=9D|=E2=80=9Cs=E2=
=80=9D|=E2=80=9C =E2=80=9D|=E2=80=9Ci=E2=80=9D|=E2=80=9Cs=E2=80=9D|=E2=80=
=9C =E2=80=9D|=E2=80=9Ca=E2=80=9D|=E2=80=9C =E2=80=9D|=E2=80=9CT=E2=80=9D=
|=E2=80=9CE=E2=80=9D|=E2=80=9CS=E2=80=9D|=E2=80=9CT=E2=80=9D|00|00|
+---+---+---+---+---+---+---+---+---+---+---+---+---+---+--+--+

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
---
 target-ppc/helper.h                 |  1 +
 target-ppc/mem_helper.c             | 18 ++++++++++++++++++
 target-ppc/translate/vsx-impl.inc.c |  1 +
 target-ppc/translate/vsx-ops.inc.c  |  1 +
 4 files changed, 21 insertions(+)

diff --git a/target-ppc/helper.h b/target-ppc/helper.h
index d9ccafd..67c8b71 100644
--- a/target-ppc/helper.h
+++ b/target-ppc/helper.h
@@ -318,6 +318,7 @@ DEF_HELPER_3(stvebx, void, env, avr, tl)
 DEF_HELPER_3(stvehx, void, env, avr, tl)
 DEF_HELPER_3(stvewx, void, env, avr, tl)
 DEF_HELPER_4(lxvl, void, env, tl, tl, tl)
+DEF_HELPER_4(lxvll, void, env, tl, tl, tl)
 DEF_HELPER_4(vsumsws, void, env, avr, avr, avr)
 DEF_HELPER_4(vsum2sws, void, env, avr, avr, avr)
 DEF_HELPER_4(vsum4sbs, void, env, avr, avr, avr)
diff --git a/target-ppc/mem_helper.c b/target-ppc/mem_helper.c
index 54447a7..08fd90d 100644
--- a/target-ppc/mem_helper.c
+++ b/target-ppc/mem_helper.c
@@ -316,6 +316,24 @@ void helper_lxvl(CPUPPCState *env, target_ulong addr=
,
     putVSR(xt_num, &xt, env);
 }
=20
+void helper_lxvll(CPUPPCState *env, target_ulong addr,
+                  target_ulong xt_num, target_ulong rb)
+{
+    int i;
+    ppc_vsr_t xt;
+    uint64_t nb =3D GET_NB(rb);
+
+    xt.s128 =3D int128_zero();
+    if (nb) {
+        nb =3D (nb >=3D 16) ? 16 : nb;
+        for (i =3D 0; i < nb; i++) {
+            xt.VsrB(i) =3D cpu_ldub_data_ra(env, addr, GETPC());
+            addr =3D addr_add(env, addr, 1);
+        }
+    }
+    putVSR(xt_num, &xt, env);
+}
+
 #undef HI_IDX
 #undef LO_IDX
 #undef GET_NB
diff --git a/target-ppc/translate/vsx-impl.inc.c b/target-ppc/translate/v=
sx-impl.inc.c
index 6bd70a0..ee884cf 100644
--- a/target-ppc/translate/vsx-impl.inc.c
+++ b/target-ppc/translate/vsx-impl.inc.c
@@ -266,6 +266,7 @@ static void gen_##name(DisasContext *ctx)            =
           \
 }
=20
 VSX_VECTOR_LOAD_STORE_LENGTH(lxvl)
+VSX_VECTOR_LOAD_STORE_LENGTH(lxvll)
=20
 #define VSX_LOAD_SCALAR_DS(name, operation)                       \
 static void gen_##name(DisasContext *ctx)                         \
diff --git a/target-ppc/translate/vsx-ops.inc.c b/target-ppc/translate/vs=
x-ops.inc.c
index 4940ab2..88f46d9 100644
--- a/target-ppc/translate/vsx-ops.inc.c
+++ b/target-ppc/translate/vsx-ops.inc.c
@@ -11,6 +11,7 @@ GEN_HANDLER_E(lxvh8x, 0x1F, 0x0C, 0x19, 0, PPC_NONE,  P=
PC2_ISA300),
 GEN_HANDLER_E(lxvb16x, 0x1F, 0x0C, 0x1B, 0, PPC_NONE, PPC2_ISA300),
 GEN_HANDLER_E(lxvx, 0x1F, 0x0C, 0x08, 0x00000040, PPC_NONE, PPC2_ISA300)=
,
 GEN_HANDLER_E(lxvl, 0x1F, 0x0D, 0x08, 0, PPC_NONE, PPC2_ISA300),
+GEN_HANDLER_E(lxvll, 0x1F, 0x0D, 0x09, 0, PPC_NONE, PPC2_ISA300),
=20
 GEN_HANDLER_E(stxsdx, 0x1F, 0xC, 0x16, 0, PPC_NONE, PPC2_VSX),
 GEN_HANDLER_E(stxsibx, 0x1F, 0xD, 0x1C, 0, PPC_NONE, PPC2_ISA300),
--=20
2.7.4
