Received: from eggs.gnu.org ([2001:4830:134:3::10]:56883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d2TIO-0001hR-44
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 22:00:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d2TIN-0003bu-6C
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 22:00:08 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 24 Apr 2017 11:59:26 +1000
Message-Id: <20170424015927.8933-47-david@gibson.dropbear.id.au>
In-Reply-To: <20170424015927.8933-1-david@gibson.dropbear.id.au>
References: <20170424015927.8933-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 46/47] e500,
 book3s: mfspr 259: Register mapped/aliased SPRG3 user read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, Bernhard Kaindl <bernhard.kaindl@thalesgroup.com>, David Gibson <david@gibson.dropbear.id.au>

From: Bernhard Kaindl <bernhard.kaindl@thalesgroup.com>

This patch registers mfspr 259 for Book3S and e500 family cores
following this research:

mfspr 259 provides read-only mapped user access to SPRG3(SPR 275) accordi=
ng to:

- PowerISA 2.02, Book III (documents implementation starting with POWER4+=
 @ p20)
- IBM PowerPC 970MP RISC Microprocessor User's Manual v2.1, page 48
- Amit Singh: "Mac OS X Internals: A Systems Approach" on 970 and 970FX c=
ores:
  He demonstrates mfspr 259 reading TLS data from Mac OS X on G5 on page =
588
- NXP documents it in the Core Reference Manuals of: e500, e500mc and e55=
00
- getcpu() of the 32 & 64-bit Book3S Linux vDSOs use it to read the core =
number

mfspr 259 does not appear to be implemented in these cores according to:

- 74xx series: MPC7410/MPC7400 and MPC7450 RISC Microprocessor Reference =
Manuals
- 4xx series:  PPC440 Processor User's Manual, Revision 1.09 by AMCC
- 750 series:  IBM PowerPC 750CL RISC Microprocessor User's Manual
- e200 series: e200z4 Power Architecture=C3=A2 Core Reference Manual

Implementation: gen_spr_usprg3() is called from init_proc_book3s_common()
(covers the 970 and POWER cores) and init_proc_e500() (covers the e500 fa=
mily)
to register spr_read_ureg() in the same way which it already provides
the mapped SPR access for SPR_USPRG4-7 in gen_spr_usprgh() for cores
which have the same read-only mapped SPRG register access for SPRG4-7.

Verified using Linux by pinning a thread to a core and checking sched_get=
cpu()
using qemu-system-ppc64 -M pseries -cpu POWER8 using MTTCG on a x86_64 ho=
st.

Signed-off-by: Bernhard Kaindl <bernhard.kaindl@thalesgroup.com>
Reviewed-by: Stefan Resch <stefan.resch@thalesgroup.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/translate_init.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index 77e5463..0ecf541 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -1640,6 +1640,14 @@ static void spr_write_booke_pid (DisasContext *ctx=
, int sprn, int gprn)
 }
 #endif
=20
+static void gen_spr_usprg3 (CPUPPCState *env)
+{
+    spr_register(env, SPR_USPRG3, "USPRG3",
+                 &spr_read_ureg, SPR_NOACCESS,
+                 &spr_read_ureg, SPR_NOACCESS,
+                 0x00000000);
+}
+
 static void gen_spr_usprgh (CPUPPCState *env)
 {
     spr_register(env, SPR_USPRG4, "USPRG4",
@@ -4914,6 +4922,7 @@ static void init_proc_e500 (CPUPPCState *env, int v=
ersion)
             break;
     }
     gen_spr_BookE(env, ivor_mask);
+    gen_spr_usprg3(env);
     /* Processor identification */
     spr_register(env, SPR_BOOKE_PIR, "PIR",
                  SPR_NOACCESS, SPR_NOACCESS,
@@ -8245,6 +8254,7 @@ static void init_proc_book3s_common(CPUPPCState *en=
v)
 {
     gen_spr_ne_601(env);
     gen_tbl(env);
+    gen_spr_usprg3(env);
     gen_spr_book3s_altivec(env);
     gen_spr_book3s_pmu_sup(env);
     gen_spr_book3s_pmu_user(env);
--=20
2.9.3
