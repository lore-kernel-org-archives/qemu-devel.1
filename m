Received: from eggs.gnu.org ([2001:4830:134:3::10]:46498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUk5-00032T-0G
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:03:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUk2-0006by-Jy
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:03:53 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 12 Jan 2017 13:02:48 +1100
Message-Id: <20170112020327.24882-29-david@gibson.dropbear.id.au>
In-Reply-To: <20170112020327.24882-1-david@gibson.dropbear.id.au>
References: <20170112020327.24882-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 28/67] target-ppc: implement lxvll instruction
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
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/helper.h                 | 1 +
 target/ppc/mem_helper.c             | 1 +
 target/ppc/translate/vsx-impl.inc.c | 1 +
 target/ppc/translate/vsx-ops.inc.c  | 1 +
 4 files changed, 4 insertions(+)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 16ed2c1..6c44731 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -319,6 +319,7 @@ DEF_HELPER_3(stvehx, void, env, avr, tl)
 DEF_HELPER_3(stvewx, void, env, avr, tl)
 #if defined(TARGET_PPC64)
 DEF_HELPER_4(lxvl, void, env, tl, tl, tl)
+DEF_HELPER_4(lxvll, void, env, tl, tl, tl)
 #endif
 DEF_HELPER_4(vsumsws, void, env, avr, avr, avr)
 DEF_HELPER_4(vsum2sws, void, env, avr, avr, avr)
diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
index c4ddc5b..da51465 100644
--- a/target/ppc/mem_helper.c
+++ b/target/ppc/mem_helper.c
@@ -315,6 +315,7 @@ void helper_##name(CPUPPCState *env, target_ulong add=
r,                 \
 }
=20
 VSX_LXVL(lxvl, 0)
+VSX_LXVL(lxvll, 1)
 #undef VSX_LXVL
 #undef GET_NB
 #endif /* TARGET_PPC64 */
diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/v=
sx-impl.inc.c
index 1f64fb7..ce20579 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -267,6 +267,7 @@ static void gen_##name(DisasContext *ctx)            =
           \
 }
=20
 VSX_VECTOR_LOAD_STORE_LENGTH(lxvl)
+VSX_VECTOR_LOAD_STORE_LENGTH(lxvll)
 #endif
=20
 #define VSX_LOAD_SCALAR_DS(name, operation)                       \
diff --git a/target/ppc/translate/vsx-ops.inc.c b/target/ppc/translate/vs=
x-ops.inc.c
index 62a0afc..c207804 100644
--- a/target/ppc/translate/vsx-ops.inc.c
+++ b/target/ppc/translate/vsx-ops.inc.c
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
2.9.3
