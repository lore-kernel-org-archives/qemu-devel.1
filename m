Received: from eggs.gnu.org ([2001:4830:134:3::10]:47569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cFK7n-0006EW-Vw
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:18:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cFK7j-0002zU-13
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:18:03 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50362)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cFK7i-0002z9-OS
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:17:58 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uB9CEDeE066917
	for <qemu-devel@nongnu.org>; Fri, 9 Dec 2016 07:17:56 -0500
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
	by mx0a-001b2d01.pphosted.com with ESMTP id 277rtmueyb-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 09 Dec 2016 07:17:56 -0500
Received: from localhost
	by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Fri, 9 Dec 2016 17:47:53 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Fri,  9 Dec 2016 17:47:21 +0530
In-Reply-To: <1481285845-16415-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1481285845-16415-1-git-send-email-nikunj@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1481285845-16415-3-git-send-email-nikunj@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 2/6] target-ppc: implement lxvll instruction
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
 target-ppc/helper.h                 | 1 +
 target-ppc/mem_helper.c             | 1 +
 target-ppc/translate/vsx-impl.inc.c | 1 +
 target-ppc/translate/vsx-ops.inc.c  | 1 +
 4 files changed, 4 insertions(+)

diff --git a/target-ppc/helper.h b/target-ppc/helper.h
index 16ed2c1..6c44731 100644
--- a/target-ppc/helper.h
+++ b/target-ppc/helper.h
@@ -319,6 +319,7 @@ DEF_HELPER_3(stvehx, void, env, avr, tl)
 DEF_HELPER_3(stvewx, void, env, avr, tl)
 #if defined(TARGET_PPC64)
 DEF_HELPER_4(lxvl, void, env, tl, tl, tl)
+DEF_HELPER_4(lxvll, void, env, tl, tl, tl)
 #endif
 DEF_HELPER_4(vsumsws, void, env, avr, avr, avr)
 DEF_HELPER_4(vsum2sws, void, env, avr, avr, avr)
diff --git a/target-ppc/mem_helper.c b/target-ppc/mem_helper.c
index c4ddc5b..da51465 100644
--- a/target-ppc/mem_helper.c
+++ b/target-ppc/mem_helper.c
@@ -315,6 +315,7 @@ void helper_##name(CPUPPCState *env, target_ulong add=
r,                 \
 }
=20
 VSX_LXVL(lxvl, 0)
+VSX_LXVL(lxvll, 1)
 #undef VSX_LXVL
 #undef GET_NB
 #endif /* TARGET_PPC64 */
diff --git a/target-ppc/translate/vsx-impl.inc.c b/target-ppc/translate/v=
sx-impl.inc.c
index 1f64fb7..ce20579 100644
--- a/target-ppc/translate/vsx-impl.inc.c
+++ b/target-ppc/translate/vsx-impl.inc.c
@@ -267,6 +267,7 @@ static void gen_##name(DisasContext *ctx)            =
           \
 }
=20
 VSX_VECTOR_LOAD_STORE_LENGTH(lxvl)
+VSX_VECTOR_LOAD_STORE_LENGTH(lxvll)
 #endif
=20
 #define VSX_LOAD_SCALAR_DS(name, operation)                       \
diff --git a/target-ppc/translate/vsx-ops.inc.c b/target-ppc/translate/vs=
x-ops.inc.c
index 62a0afc..c207804 100644
--- a/target-ppc/translate/vsx-ops.inc.c
+++ b/target-ppc/translate/vsx-ops.inc.c
@@ -12,6 +12,7 @@ GEN_HANDLER_E(lxvb16x, 0x1F, 0x0C, 0x1B, 0, PPC_NONE, P=
PC2_ISA300),
 GEN_HANDLER_E(lxvx, 0x1F, 0x0C, 0x08, 0x00000040, PPC_NONE, PPC2_ISA300)=
,
 #if defined(TARGET_PPC64)
 GEN_HANDLER_E(lxvl, 0x1F, 0x0D, 0x08, 0, PPC_NONE, PPC2_ISA300),
+GEN_HANDLER_E(lxvll, 0x1F, 0x0D, 0x09, 0, PPC_NONE, PPC2_ISA300),
 #endif
=20
 GEN_HANDLER_E(stxsdx, 0x1F, 0xC, 0x16, 0, PPC_NONE, PPC2_VSX),
--=20
2.7.4
