Received: from eggs.gnu.org ([2001:4830:134:3::10]:53576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1g85aB-0000WH-H2
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 11:30:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1g85a8-0005ls-H2
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 11:30:31 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu,  4 Oct 2018 17:28:54 +0200
Message-Id: <20181004152857.14525-13-cohuck@redhat.com>
In-Reply-To: <20181004152857.14525-1-cohuck@redhat.com>
References: <20181004152857.14525-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 12/15] s390x/tcg: handle privileged instructions
 via flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

Let's check this also at a central place.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20180927130303.12236-8-david@redhat.com>
Acked-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/insn-data.def | 138 ++++++++++++++++++++++-----------------------
 target/s390x/translate.c   |  83 +++------------------------
 2 files changed, 76 insertions(+), 145 deletions(-)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 7be6e661fa..54e39df831 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -964,126 +964,126 @@
 
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
-    D(0xb250, CSP,     RRE,   Z,   r1_32u, ra2, r1_P, 0, csp, 0, MO_TEUL)
-    D(0xb98a, CSPG,    RRE, DAT_ENH, r1_o, ra2, r1_P, 0, csp, 0, MO_TEQ)
+    E(0xb250, CSP,     RRE,   Z,   r1_32u, ra2, r1_P, 0, csp, 0, MO_TEUL, IF_PRIV)
+    E(0xb98a, CSPG,    RRE, DAT_ENH, r1_o, ra2, r1_P, 0, csp, 0, MO_TEQ, IF_PRIV)
 /* DIAGNOSE (KVM hypercall) */
-    C(0x8300, DIAG,    RSI,   Z,   0, 0, 0, 0, diag, 0)
+    F(0x8300, DIAG,    RSI,   Z,   0, 0, 0, 0, diag, 0, IF_PRIV)
 /* INSERT STORAGE KEY EXTENDED */
-    C(0xb229, ISKE,    RRE,   Z,   0, r2_o, new, r1_8, iske, 0)
+    F(0xb229, ISKE,    RRE,   Z,   0, r2_o, new, r1_8, iske, 0, IF_PRIV)
 /* INVALIDATE DAT TABLE ENTRY */
-    C(0xb98e, IPDE,    RRF_b, Z,   r1_o, r2_o, 0, 0, idte, 0)
+    F(0xb98e, IPDE,    RRF_b, Z,   r1_o, r2_o, 0, 0, idte, 0, IF_PRIV)
 /* INVALIDATE PAGE TABLE ENTRY */
-    C(0xb221, IPTE,    RRF_a, Z,   r1_o, r2_o, 0, 0, ipte, 0)
+    F(0xb221, IPTE,    RRF_a, Z,   r1_o, r2_o, 0, 0, ipte, 0, IF_PRIV)
 /* LOAD CONTROL */
-    C(0xb700, LCTL,    RS_a,  Z,   0, a2, 0, 0, lctl, 0)
-    C(0xeb2f, LCTLG,   RSY_a, Z,   0, a2, 0, 0, lctlg, 0)
+    F(0xb700, LCTL,    RS_a,  Z,   0, a2, 0, 0, lctl, 0, IF_PRIV)
+    F(0xeb2f, LCTLG,   RSY_a, Z,   0, a2, 0, 0, lctlg, 0, IF_PRIV)
 /* LOAD PROGRAM PARAMETER */
-    C(0xb280, LPP,     S,   LPP,   0, m2_64, 0, 0, lpp, 0)
+    F(0xb280, LPP,     S,   LPP,   0, m2_64, 0, 0, lpp, 0, IF_PRIV)
 /* LOAD PSW */
-    C(0x8200, LPSW,    S,     Z,   0, a2, 0, 0, lpsw, 0)
+    F(0x8200, LPSW,    S,     Z,   0, a2, 0, 0, lpsw, 0, IF_PRIV)
 /* LOAD PSW EXTENDED */
-    C(0xb2b2, LPSWE,   S,     Z,   0, a2, 0, 0, lpswe, 0)
+    F(0xb2b2, LPSWE,   S,     Z,   0, a2, 0, 0, lpswe, 0, IF_PRIV)
 /* LOAD REAL ADDRESS */
-    C(0xb100, LRA,     RX_a,  Z,   0, a2, r1, 0, lra, 0)
-    C(0xe313, LRAY,    RXY_a, LD,  0, a2, r1, 0, lra, 0)
-    C(0xe303, LRAG,    RXY_a, Z,   0, a2, r1, 0, lra, 0)
+    F(0xb100, LRA,     RX_a,  Z,   0, a2, r1, 0, lra, 0, IF_PRIV)
+    F(0xe313, LRAY,    RXY_a, LD,  0, a2, r1, 0, lra, 0, IF_PRIV)
+    F(0xe303, LRAG,    RXY_a, Z,   0, a2, r1, 0, lra, 0, IF_PRIV)
 /* LOAD USING REAL ADDRESS */
-    C(0xb24b, LURA,    RRE,   Z,   0, r2, new, r1_32, lura, 0)
-    C(0xb905, LURAG,   RRE,   Z,   0, r2, r1, 0, lurag, 0)
+    F(0xb24b, LURA,    RRE,   Z,   0, r2, new, r1_32, lura, 0, IF_PRIV)
+    F(0xb905, LURAG,   RRE,   Z,   0, r2, r1, 0, lurag, 0, IF_PRIV)
 /* MOVE TO PRIMARY */
-    C(0xda00, MVCP,    SS_d,  Z,   la1, a2, 0, 0, mvcp, 0)
+    F(0xda00, MVCP,    SS_d,  Z,   la1, a2, 0, 0, mvcp, 0, IF_PRIV)
 /* MOVE TO SECONDARY */
-    C(0xdb00, MVCS,    SS_d,  Z,   la1, a2, 0, 0, mvcs, 0)
+    F(0xdb00, MVCS,    SS_d,  Z,   la1, a2, 0, 0, mvcs, 0, IF_PRIV)
 /* PURGE TLB */
-    C(0xb20d, PTLB,    S,     Z,   0, 0, 0, 0, ptlb, 0)
+    F(0xb20d, PTLB,    S,     Z,   0, 0, 0, 0, ptlb, 0, IF_PRIV)
 /* RESET REFERENCE BIT EXTENDED */
-    C(0xb22a, RRBE,    RRE,   Z,   0, r2_o, 0, 0, rrbe, 0)
+    F(0xb22a, RRBE,    RRE,   Z,   0, r2_o, 0, 0, rrbe, 0, IF_PRIV)
 /* SERVICE CALL LOGICAL PROCESSOR (PV hypercall) */
-    C(0xb220, SERVC,   RRE,   Z,   r1_o, r2_o, 0, 0, servc, 0)
+    F(0xb220, SERVC,   RRE,   Z,   r1_o, r2_o, 0, 0, servc, 0, IF_PRIV)
 /* SET ADDRESS SPACE CONTROL FAST */
-    C(0xb279, SACF,    S,     Z,   0, a2, 0, 0, sacf, 0)
+    F(0xb279, SACF,    S,     Z,   0, a2, 0, 0, sacf, 0, IF_PRIV)
 /* SET CLOCK */
-    C(0xb204, SCK,     S,     Z,   la2, 0, 0, 0, sck, 0)
+    F(0xb204, SCK,     S,     Z,   la2, 0, 0, 0, sck, 0, IF_PRIV)
 /* SET CLOCK COMPARATOR */
-    C(0xb206, SCKC,    S,     Z,   0, m2_64a, 0, 0, sckc, 0)
+    F(0xb206, SCKC,    S,     Z,   0, m2_64a, 0, 0, sckc, 0, IF_PRIV)
 /* SET CLOCK PROGRAMMABLE FIELD */
-    C(0x0107, SCKPF,   E,     Z,   0, 0, 0, 0, sckpf, 0)
+    F(0x0107, SCKPF,   E,     Z,   0, 0, 0, 0, sckpf, 0, IF_PRIV)
 /* SET CPU TIMER */
-    C(0xb208, SPT,     S,     Z,   0, m2_64a, 0, 0, spt, 0)
+    F(0xb208, SPT,     S,     Z,   0, m2_64a, 0, 0, spt, 0, IF_PRIV)
 /* SET PREFIX */
-    C(0xb210, SPX,     S,     Z,   0, m2_32ua, 0, 0, spx, 0)
+    F(0xb210, SPX,     S,     Z,   0, m2_32ua, 0, 0, spx, 0, IF_PRIV)
 /* SET PSW KEY FROM ADDRESS */
-    C(0xb20a, SPKA,    S,     Z,   0, a2, 0, 0, spka, 0)
+    F(0xb20a, SPKA,    S,     Z,   0, a2, 0, 0, spka, 0, IF_PRIV)
 /* SET STORAGE KEY EXTENDED */
-    C(0xb22b, SSKE,    RRF_c, Z,   r1_o, r2_o, 0, 0, sske, 0)
+    F(0xb22b, SSKE,    RRF_c, Z,   r1_o, r2_o, 0, 0, sske, 0, IF_PRIV)
 /* SET SYSTEM MASK */
-    C(0x8000, SSM,     S,     Z,   0, m2_8u, 0, 0, ssm, 0)
+    F(0x8000, SSM,     S,     Z,   0, m2_8u, 0, 0, ssm, 0, IF_PRIV)
 /* SIGNAL PROCESSOR */
-    C(0xae00, SIGP,    RS_a,  Z,   0, a2, 0, 0, sigp, 0)
+    F(0xae00, SIGP,    RS_a,  Z,   0, a2, 0, 0, sigp, 0, IF_PRIV)
 /* STORE CLOCK */
     C(0xb205, STCK,    S,     Z,   la2, 0, new, m1_64, stck, 0)
     C(0xb27c, STCKF,   S,     SCF, la2, 0, new, m1_64, stck, 0)
 /* STORE CLOCK EXTENDED */
     C(0xb278, STCKE,   S,     Z,   0, a2, 0, 0, stcke, 0)
 /* STORE CLOCK COMPARATOR */
-    C(0xb207, STCKC,   S,     Z,   la2, 0, new, m1_64a, stckc, 0)
+    F(0xb207, STCKC,   S,     Z,   la2, 0, new, m1_64a, stckc, 0, IF_PRIV)
 /* STORE CONTROL */
-    C(0xb600, STCTL,   RS_a,  Z,   0, a2, 0, 0, stctl, 0)
-    C(0xeb25, STCTG,   RSY_a, Z,   0, a2, 0, 0, stctg, 0)
+    F(0xb600, STCTL,   RS_a,  Z,   0, a2, 0, 0, stctl, 0, IF_PRIV)
+    F(0xeb25, STCTG,   RSY_a, Z,   0, a2, 0, 0, stctg, 0, IF_PRIV)
 /* STORE CPU ADDRESS */
-    C(0xb212, STAP,    S,     Z,   la2, 0, new, m1_16a, stap, 0)
+    F(0xb212, STAP,    S,     Z,   la2, 0, new, m1_16a, stap, 0, IF_PRIV)
 /* STORE CPU ID */
-    C(0xb202, STIDP,   S,     Z,   la2, 0, new, m1_64a, stidp, 0)
+    F(0xb202, STIDP,   S,     Z,   la2, 0, new, m1_64a, stidp, 0, IF_PRIV)
 /* STORE CPU TIMER */
-    C(0xb209, STPT,    S,     Z,   la2, 0, new, m1_64a, stpt, 0)
+    F(0xb209, STPT,    S,     Z,   la2, 0, new, m1_64a, stpt, 0, IF_PRIV)
 /* STORE FACILITY LIST */
-    C(0xb2b1, STFL,    S,     Z,   0, 0, 0, 0, stfl, 0)
+    F(0xb2b1, STFL,    S,     Z,   0, 0, 0, 0, stfl, 0, IF_PRIV)
 /* STORE PREFIX */
-    C(0xb211, STPX,    S,     Z,   la2, 0, new, m1_32a, stpx, 0)
+    F(0xb211, STPX,    S,     Z,   la2, 0, new, m1_32a, stpx, 0, IF_PRIV)
 /* STORE SYSTEM INFORMATION */
-    C(0xb27d, STSI,    S,     Z,   0, a2, 0, 0, stsi, 0)
+    F(0xb27d, STSI,    S,     Z,   0, a2, 0, 0, stsi, 0, IF_PRIV)
 /* STORE THEN AND SYSTEM MASK */
-    C(0xac00, STNSM,   SI,    Z,   la1, 0, 0, 0, stnosm, 0)
+    F(0xac00, STNSM,   SI,    Z,   la1, 0, 0, 0, stnosm, 0, IF_PRIV)
 /* STORE THEN OR SYSTEM MASK */
-    C(0xad00, STOSM,   SI,    Z,   la1, 0, 0, 0, stnosm, 0)
+    F(0xad00, STOSM,   SI,    Z,   la1, 0, 0, 0, stnosm, 0, IF_PRIV)
 /* STORE USING REAL ADDRESS */
-    C(0xb246, STURA,   RRE,   Z,   r1_o, r2_o, 0, 0, stura, 0)
-    C(0xb925, STURG,   RRE,   Z,   r1_o, r2_o, 0, 0, sturg, 0)
+    F(0xb246, STURA,   RRE,   Z,   r1_o, r2_o, 0, 0, stura, 0, IF_PRIV)
+    F(0xb925, STURG,   RRE,   Z,   r1_o, r2_o, 0, 0, sturg, 0, IF_PRIV)
 /* TEST BLOCK */
-    C(0xb22c, TB,      RRE,   Z,   0, r2_o, 0, 0, testblock, 0)
+    F(0xb22c, TB,      RRE,   Z,   0, r2_o, 0, 0, testblock, 0, IF_PRIV)
 /* TEST PROTECTION */
     C(0xe501, TPROT,   SSE,   Z,   la1, a2, 0, 0, tprot, 0)
 
 /* CCW I/O Instructions */
-    C(0xb276, XSCH,    S,     Z,   0, 0, 0, 0, xsch, 0)
-    C(0xb230, CSCH,    S,     Z,   0, 0, 0, 0, csch, 0)
-    C(0xb231, HSCH,    S,     Z,   0, 0, 0, 0, hsch, 0)
-    C(0xb232, MSCH,    S,     Z,   0, insn, 0, 0, msch, 0)
-    C(0xb23b, RCHP,    S,     Z,   0, 0, 0, 0, rchp, 0)
-    C(0xb238, RSCH,    S,     Z,   0, 0, 0, 0, rsch, 0)
-    C(0xb237, SAL,     S,     Z,   0, 0, 0, 0, sal, 0)
-    C(0xb23c, SCHM,    S,     Z,   0, insn, 0, 0, schm, 0)
-    C(0xb274, SIGA,    S,     Z,   0, 0, 0, 0, siga, 0)
-    C(0xb23a, STCPS,   S,     Z,   0, 0, 0, 0, stcps, 0)
-    C(0xb233, SSCH,    S,     Z,   0, insn, 0, 0, ssch, 0)
-    C(0xb239, STCRW,   S,     Z,   0, insn, 0, 0, stcrw, 0)
-    C(0xb234, STSCH,   S,     Z,   0, insn, 0, 0, stsch, 0)
-    C(0xb236, TPI ,    S,     Z,   la2, 0, 0, 0, tpi, 0)
-    C(0xb235, TSCH,    S,     Z,   0, insn, 0, 0, tsch, 0)
+    F(0xb276, XSCH,    S,     Z,   0, 0, 0, 0, xsch, 0, IF_PRIV)
+    F(0xb230, CSCH,    S,     Z,   0, 0, 0, 0, csch, 0, IF_PRIV)
+    F(0xb231, HSCH,    S,     Z,   0, 0, 0, 0, hsch, 0, IF_PRIV)
+    F(0xb232, MSCH,    S,     Z,   0, insn, 0, 0, msch, 0, IF_PRIV)
+    F(0xb23b, RCHP,    S,     Z,   0, 0, 0, 0, rchp, 0, IF_PRIV)
+    F(0xb238, RSCH,    S,     Z,   0, 0, 0, 0, rsch, 0, IF_PRIV)
+    F(0xb237, SAL,     S,     Z,   0, 0, 0, 0, sal, 0, IF_PRIV)
+    F(0xb23c, SCHM,    S,     Z,   0, insn, 0, 0, schm, 0, IF_PRIV)
+    F(0xb274, SIGA,    S,     Z,   0, 0, 0, 0, siga, 0, IF_PRIV)
+    F(0xb23a, STCPS,   S,     Z,   0, 0, 0, 0, stcps, 0, IF_PRIV)
+    F(0xb233, SSCH,    S,     Z,   0, insn, 0, 0, ssch, 0, IF_PRIV)
+    F(0xb239, STCRW,   S,     Z,   0, insn, 0, 0, stcrw, 0, IF_PRIV)
+    F(0xb234, STSCH,   S,     Z,   0, insn, 0, 0, stsch, 0, IF_PRIV)
+    F(0xb236, TPI ,    S,     Z,   la2, 0, 0, 0, tpi, 0, IF_PRIV)
+    F(0xb235, TSCH,    S,     Z,   0, insn, 0, 0, tsch, 0, IF_PRIV)
     /* ??? Not listed in PoO ninth edition, but there's a linux driver that
        uses it: "A CHSC subchannel is usually present on LPAR only."  */
-    C(0xb25f, CHSC,  RRE,     Z,   0, insn, 0, 0, chsc, 0)
+    F(0xb25f, CHSC,  RRE,     Z,   0, insn, 0, 0, chsc, 0, IF_PRIV)
 
 /* zPCI Instructions */
     /* None of these instructions are documented in the PoP, so this is all
        based upon target/s390x/kvm.c and Linux code and likely incomplete */
-    C(0xebd0, PCISTB, RSY_a, PCI, la2, 0, 0, 0, pcistb, 0)
-    C(0xebd1, SIC, RSY_a, AIS, r1, r3, 0, 0, sic, 0)
-    C(0xb9a0, CLP, RRF_c, PCI, 0, 0, 0, 0, clp, 0)
-    C(0xb9d0, PCISTG, RRE, PCI, 0, 0, 0, 0, pcistg, 0)
-    C(0xb9d2, PCILG, RRE, PCI, 0, 0, 0, 0, pcilg, 0)
-    C(0xb9d3, RPCIT, RRE, PCI, 0, 0, 0, 0, rpcit, 0)
-    C(0xe3d0, MPCIFC, RXY_a, PCI, la2, 0, 0, 0, mpcifc, 0)
-    C(0xe3d4, STPCIFC, RXY_a, PCI, la2, 0, 0, 0, stpcifc, 0)
+    F(0xebd0, PCISTB, RSY_a, PCI, la2, 0, 0, 0, pcistb, 0, IF_PRIV)
+    F(0xebd1, SIC, RSY_a, AIS, r1, r3, 0, 0, sic, 0, IF_PRIV)
+    F(0xb9a0, CLP, RRF_c, PCI, 0, 0, 0, 0, clp, 0, IF_PRIV)
+    F(0xb9d0, PCISTG, RRE, PCI, 0, 0, 0, 0, pcistg, 0, IF_PRIV)
+    F(0xb9d2, PCILG, RRE, PCI, 0, 0, 0, 0, pcilg, 0, IF_PRIV)
+    F(0xb9d3, RPCIT, RRE, PCI, 0, 0, 0, 0, rpcit, 0, IF_PRIV)
+    F(0xe3d0, MPCIFC, RXY_a, PCI, la2, 0, 0, 0, mpcifc, 0, IF_PRIV)
+    F(0xe3d4, STPCIFC, RXY_a, PCI, la2, 0, 0, 0, stpcifc, 0, IF_PRIV)
 
 #endif /* CONFIG_USER_ONLY */
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 67049975fa..f93ad20951 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -327,15 +327,6 @@ static inline void gen_trap(DisasContext *s)
     gen_data_exception(0xff);
 }
 
-#ifndef CONFIG_USER_ONLY
-static void check_privileged(DisasContext *s)
-{
-    if (s->base.tb->flags & FLAG_MASK_PSTATE) {
-        gen_program_exception(s, PGM_PRIVILEGED);
-    }
-}
-#endif
-
 static TCGv_i64 get_address(DisasContext *s, int x2, int b2, int d2)
 {
     TCGv_i64 tmp = tcg_temp_new_i64();
@@ -1126,6 +1117,7 @@ typedef struct {
 #define IF_AFP3     0x0004      /* r3 is a fp reg for HFP/FPS instructions */
 #define IF_BFP      0x0008      /* binary floating point instruction */
 #define IF_DFP      0x0010      /* decimal floating point instruction */
+#define IF_PRIV     0x0020      /* privileged instruction */
 
 struct DisasInsn {
     unsigned opc:16;
@@ -2086,7 +2078,6 @@ static DisasJumpType op_csp(DisasContext *s, DisasOps *o)
     /* Note that in1 = R1 (zero-extended expected value),
        out = R1 (original reg), out2 = R1+1 (new value).  */
 
-    check_privileged(s);
     addr = tcg_temp_new_i64();
     old = tcg_temp_new_i64();
     tcg_gen_andi_i64(addr, o->in2, -1ULL << (mop & MO_SIZE));
@@ -2210,7 +2201,6 @@ static DisasJumpType op_diag(DisasContext *s, DisasOps *o)
     TCGv_i32 r3 = tcg_const_i32(get_field(s->fields, r3));
     TCGv_i32 func_code = tcg_const_i32(get_field(s->fields, i2));
 
-    check_privileged(s);
     gen_helper_diag(cpu_env, r1, r3, func_code);
 
     tcg_temp_free_i32(func_code);
@@ -2471,7 +2461,6 @@ static DisasJumpType op_idte(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 m4;
 
-    check_privileged(s);
     if (s390_has_feat(S390_FEAT_LOCAL_TLB_CLEARING)) {
         m4 = tcg_const_i32(get_field(s->fields, m4));
     } else {
@@ -2486,7 +2475,6 @@ static DisasJumpType op_ipte(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 m4;
 
-    check_privileged(s);
     if (s390_has_feat(S390_FEAT_LOCAL_TLB_CLEARING)) {
         m4 = tcg_const_i32(get_field(s->fields, m4));
     } else {
@@ -2499,7 +2487,6 @@ static DisasJumpType op_ipte(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_iske(DisasContext *s, DisasOps *o)
 {
-    check_privileged(s);
     gen_helper_iske(o->out, cpu_env, o->in2);
     return DISAS_NEXT;
 }
@@ -2798,7 +2785,6 @@ static DisasJumpType op_lctl(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 r1 = tcg_const_i32(get_field(s->fields, r1));
     TCGv_i32 r3 = tcg_const_i32(get_field(s->fields, r3));
-    check_privileged(s);
     gen_helper_lctl(cpu_env, r1, o->in2, r3);
     tcg_temp_free_i32(r1);
     tcg_temp_free_i32(r3);
@@ -2810,7 +2796,6 @@ static DisasJumpType op_lctlg(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 r1 = tcg_const_i32(get_field(s->fields, r1));
     TCGv_i32 r3 = tcg_const_i32(get_field(s->fields, r3));
-    check_privileged(s);
     gen_helper_lctlg(cpu_env, r1, o->in2, r3);
     tcg_temp_free_i32(r1);
     tcg_temp_free_i32(r3);
@@ -2820,7 +2805,6 @@ static DisasJumpType op_lctlg(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_lra(DisasContext *s, DisasOps *o)
 {
-    check_privileged(s);
     gen_helper_lra(o->out, cpu_env, o->in2);
     set_cc_static(s);
     return DISAS_NEXT;
@@ -2828,8 +2812,6 @@ static DisasJumpType op_lra(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_lpp(DisasContext *s, DisasOps *o)
 {
-    check_privileged(s);
-
     tcg_gen_st_i64(o->in2, cpu_env, offsetof(CPUS390XState, pp));
     return DISAS_NEXT;
 }
@@ -2838,7 +2820,6 @@ static DisasJumpType op_lpsw(DisasContext *s, DisasOps *o)
 {
     TCGv_i64 t1, t2;
 
-    check_privileged(s);
     per_breaking_event(s);
 
     t1 = tcg_temp_new_i64();
@@ -2859,7 +2840,6 @@ static DisasJumpType op_lpswe(DisasContext *s, DisasOps *o)
 {
     TCGv_i64 t1, t2;
 
-    check_privileged(s);
     per_breaking_event(s);
 
     t1 = tcg_temp_new_i64();
@@ -3058,14 +3038,12 @@ static DisasJumpType op_lpq(DisasContext *s, DisasOps *o)
 #ifndef CONFIG_USER_ONLY
 static DisasJumpType op_lura(DisasContext *s, DisasOps *o)
 {
-    check_privileged(s);
     gen_helper_lura(o->out, cpu_env, o->in2);
     return DISAS_NEXT;
 }
 
 static DisasJumpType op_lurag(DisasContext *s, DisasOps *o)
 {
-    check_privileged(s);
     gen_helper_lurag(o->out, cpu_env, o->in2);
     return DISAS_NEXT;
 }
@@ -3224,7 +3202,6 @@ static DisasJumpType op_mvcos(DisasContext *s, DisasOps *o)
 static DisasJumpType op_mvcp(DisasContext *s, DisasOps *o)
 {
     int r1 = get_field(s->fields, l1);
-    check_privileged(s);
     gen_helper_mvcp(cc_op, cpu_env, regs[r1], o->addr1, o->in2);
     set_cc_static(s);
     return DISAS_NEXT;
@@ -3233,7 +3210,6 @@ static DisasJumpType op_mvcp(DisasContext *s, DisasOps *o)
 static DisasJumpType op_mvcs(DisasContext *s, DisasOps *o)
 {
     int r1 = get_field(s->fields, l1);
-    check_privileged(s);
     gen_helper_mvcs(cc_op, cpu_env, regs[r1], o->addr1, o->in2);
     set_cc_static(s);
     return DISAS_NEXT;
@@ -3519,7 +3495,6 @@ static DisasJumpType op_popcnt(DisasContext *s, DisasOps *o)
 #ifndef CONFIG_USER_ONLY
 static DisasJumpType op_ptlb(DisasContext *s, DisasOps *o)
 {
-    check_privileged(s);
     gen_helper_ptlb(cpu_env);
     return DISAS_NEXT;
 }
@@ -3710,7 +3685,6 @@ static DisasJumpType op_rll64(DisasContext *s, DisasOps *o)
 #ifndef CONFIG_USER_ONLY
 static DisasJumpType op_rrbe(DisasContext *s, DisasOps *o)
 {
-    check_privileged(s);
     gen_helper_rrbe(cc_op, cpu_env, o->in2);
     set_cc_static(s);
     return DISAS_NEXT;
@@ -3718,7 +3692,6 @@ static DisasJumpType op_rrbe(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_sacf(DisasContext *s, DisasOps *o)
 {
-    check_privileged(s);
     gen_helper_sacf(cpu_env, o->in2);
     /* Addressing mode has changed, so end the block.  */
     return DISAS_PC_STALE;
@@ -3808,7 +3781,6 @@ static DisasJumpType op_sqxb(DisasContext *s, DisasOps *o)
 #ifndef CONFIG_USER_ONLY
 static DisasJumpType op_servc(DisasContext *s, DisasOps *o)
 {
-    check_privileged(s);
     gen_helper_servc(cc_op, cpu_env, o->in2, o->in1);
     set_cc_static(s);
     return DISAS_NEXT;
@@ -3818,7 +3790,6 @@ static DisasJumpType op_sigp(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 r1 = tcg_const_i32(get_field(s->fields, r1));
     TCGv_i32 r3 = tcg_const_i32(get_field(s->fields, r3));
-    check_privileged(s);
     gen_helper_sigp(cc_op, cpu_env, o->in2, r1, r3);
     set_cc_static(s);
     tcg_temp_free_i32(r1);
@@ -4000,7 +3971,6 @@ static DisasJumpType op_ectg(DisasContext *s, DisasOps *o)
 #ifndef CONFIG_USER_ONLY
 static DisasJumpType op_spka(DisasContext *s, DisasOps *o)
 {
-    check_privileged(s);
     tcg_gen_shri_i64(o->in2, o->in2, 4);
     tcg_gen_deposit_i64(psw_mask, psw_mask, o->in2, PSW_SHIFT_KEY, 4);
     return DISAS_NEXT;
@@ -4008,14 +3978,12 @@ static DisasJumpType op_spka(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_sske(DisasContext *s, DisasOps *o)
 {
-    check_privileged(s);
     gen_helper_sske(cpu_env, o->in1, o->in2);
     return DISAS_NEXT;
 }
 
 static DisasJumpType op_ssm(DisasContext *s, DisasOps *o)
 {
-    check_privileged(s);
     tcg_gen_deposit_i64(psw_mask, psw_mask, o->in2, 56, 8);
     /* Exit to main loop to reevaluate s390_cpu_exec_interrupt.  */
     return DISAS_PC_STALE_NOCHAIN;
@@ -4023,7 +3991,6 @@ static DisasJumpType op_ssm(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_stap(DisasContext *s, DisasOps *o)
 {
-    check_privileged(s);
     tcg_gen_ld32u_i64(o->out, cpu_env, offsetof(CPUS390XState, core_id));
     return DISAS_NEXT;
 }
@@ -4065,7 +4032,6 @@ static DisasJumpType op_stcke(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_sck(DisasContext *s, DisasOps *o)
 {
-    check_privileged(s);
     tcg_gen_qemu_ld_i64(o->in1, o->addr1, get_mem_index(s), MO_TEQ | MO_ALIGN);
     gen_helper_sck(cc_op, cpu_env, o->in1);
     set_cc_static(s);
@@ -4074,21 +4040,18 @@ static DisasJumpType op_sck(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_sckc(DisasContext *s, DisasOps *o)
 {
-    check_privileged(s);
     gen_helper_sckc(cpu_env, o->in2);
     return DISAS_NEXT;
 }
 
 static DisasJumpType op_sckpf(DisasContext *s, DisasOps *o)
 {
-    check_privileged(s);
     gen_helper_sckpf(cpu_env, regs[0]);
     return DISAS_NEXT;
 }
 
 static DisasJumpType op_stckc(DisasContext *s, DisasOps *o)
 {
-    check_privileged(s);
     gen_helper_stckc(o->out, cpu_env);
     return DISAS_NEXT;
 }
@@ -4097,7 +4060,6 @@ static DisasJumpType op_stctg(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 r1 = tcg_const_i32(get_field(s->fields, r1));
     TCGv_i32 r3 = tcg_const_i32(get_field(s->fields, r3));
-    check_privileged(s);
     gen_helper_stctg(cpu_env, r1, o->in2, r3);
     tcg_temp_free_i32(r1);
     tcg_temp_free_i32(r3);
@@ -4108,7 +4070,6 @@ static DisasJumpType op_stctl(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 r1 = tcg_const_i32(get_field(s->fields, r1));
     TCGv_i32 r3 = tcg_const_i32(get_field(s->fields, r3));
-    check_privileged(s);
     gen_helper_stctl(cpu_env, r1, o->in2, r3);
     tcg_temp_free_i32(r1);
     tcg_temp_free_i32(r3);
@@ -4117,35 +4078,30 @@ static DisasJumpType op_stctl(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_stidp(DisasContext *s, DisasOps *o)
 {
-    check_privileged(s);
     tcg_gen_ld_i64(o->out, cpu_env, offsetof(CPUS390XState, cpuid));
     return DISAS_NEXT;
 }
 
 static DisasJumpType op_spt(DisasContext *s, DisasOps *o)
 {
-    check_privileged(s);
     gen_helper_spt(cpu_env, o->in2);
     return DISAS_NEXT;
 }
 
 static DisasJumpType op_stfl(DisasContext *s, DisasOps *o)
 {
-    check_privileged(s);
     gen_helper_stfl(cpu_env);
     return DISAS_NEXT;
 }
 
 static DisasJumpType op_stpt(DisasContext *s, DisasOps *o)
 {
-    check_privileged(s);
     gen_helper_stpt(o->out, cpu_env);
     return DISAS_NEXT;
 }
 
 static DisasJumpType op_stsi(DisasContext *s, DisasOps *o)
 {
-    check_privileged(s);
     gen_helper_stsi(cc_op, cpu_env, o->in2, regs[0], regs[1]);
     set_cc_static(s);
     return DISAS_NEXT;
@@ -4153,14 +4109,12 @@ static DisasJumpType op_stsi(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_spx(DisasContext *s, DisasOps *o)
 {
-    check_privileged(s);
     gen_helper_spx(cpu_env, o->in2);
     return DISAS_NEXT;
 }
 
 static DisasJumpType op_xsch(DisasContext *s, DisasOps *o)
 {
-    check_privileged(s);
     gen_helper_xsch(cpu_env, regs[1]);
     set_cc_static(s);
     return DISAS_NEXT;
@@ -4168,7 +4122,6 @@ static DisasJumpType op_xsch(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_csch(DisasContext *s, DisasOps *o)
 {
-    check_privileged(s);
     gen_helper_csch(cpu_env, regs[1]);
     set_cc_static(s);
     return DISAS_NEXT;
@@ -4176,7 +4129,6 @@ static DisasJumpType op_csch(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_hsch(DisasContext *s, DisasOps *o)
 {
-    check_privileged(s);
     gen_helper_hsch(cpu_env, regs[1]);
     set_cc_static(s);
     return DISAS_NEXT;
@@ -4184,7 +4136,6 @@ static DisasJumpType op_hsch(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_msch(DisasContext *s, DisasOps *o)
 {
-    check_privileged(s);
     gen_helper_msch(cpu_env, regs[1], o->in2);
     set_cc_static(s);
     return DISAS_NEXT;
@@ -4192,7 +4143,6 @@ static DisasJumpType op_msch(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_rchp(DisasContext *s, DisasOps *o)
 {
-    check_privileged(s);
     gen_helper_rchp(cpu_env, regs[1]);
     set_cc_static(s);
     return DISAS_NEXT;
@@ -4200,7 +4150,6 @@ static DisasJumpType op_rchp(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_rsch(DisasContext *s, DisasOps *o)
 {
-    check_privileged(s);
     gen_helper_rsch(cpu_env, regs[1]);
     set_cc_static(s);
     return DISAS_NEXT;
@@ -4208,21 +4157,18 @@ static DisasJumpType op_rsch(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_sal(DisasContext *s, DisasOps *o)
 {
-    check_privileged(s);
     gen_helper_sal(cpu_env, regs[1]);
     return DISAS_NEXT;
 }
 
 static DisasJumpType op_schm(DisasContext *s, DisasOps *o)
 {
-    check_privileged(s);
     gen_helper_schm(cpu_env, regs[1], regs[2], o->in2);
     return DISAS_NEXT;
 }
 
 static DisasJumpType op_siga(DisasContext *s, DisasOps *o)
 {
-    check_privileged(s);
     /* From KVM code: Not provided, set CC = 3 for subchannel not operational */
     gen_op_movi_cc(s, 3);
     return DISAS_NEXT;
@@ -4230,14 +4176,12 @@ static DisasJumpType op_siga(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_stcps(DisasContext *s, DisasOps *o)
 {
-    check_privileged(s);
     /* The instruction is suppressed if not provided. */
     return DISAS_NEXT;
 }
 
 static DisasJumpType op_ssch(DisasContext *s, DisasOps *o)
 {
-    check_privileged(s);
     gen_helper_ssch(cpu_env, regs[1], o->in2);
     set_cc_static(s);
     return DISAS_NEXT;
@@ -4245,7 +4189,6 @@ static DisasJumpType op_ssch(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_stsch(DisasContext *s, DisasOps *o)
 {
-    check_privileged(s);
     gen_helper_stsch(cpu_env, regs[1], o->in2);
     set_cc_static(s);
     return DISAS_NEXT;
@@ -4253,7 +4196,6 @@ static DisasJumpType op_stsch(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_stcrw(DisasContext *s, DisasOps *o)
 {
-    check_privileged(s);
     gen_helper_stcrw(cpu_env, o->in2);
     set_cc_static(s);
     return DISAS_NEXT;
@@ -4261,7 +4203,6 @@ static DisasJumpType op_stcrw(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_tpi(DisasContext *s, DisasOps *o)
 {
-    check_privileged(s);
     gen_helper_tpi(cc_op, cpu_env, o->addr1);
     set_cc_static(s);
     return DISAS_NEXT;
@@ -4269,7 +4210,6 @@ static DisasJumpType op_tpi(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_tsch(DisasContext *s, DisasOps *o)
 {
-    check_privileged(s);
     gen_helper_tsch(cpu_env, regs[1], o->in2);
     set_cc_static(s);
     return DISAS_NEXT;
@@ -4277,7 +4217,6 @@ static DisasJumpType op_tsch(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_chsc(DisasContext *s, DisasOps *o)
 {
-    check_privileged(s);
     gen_helper_chsc(cpu_env, o->in2);
     set_cc_static(s);
     return DISAS_NEXT;
@@ -4285,7 +4224,6 @@ static DisasJumpType op_chsc(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_stpx(DisasContext *s, DisasOps *o)
 {
-    check_privileged(s);
     tcg_gen_ld_i64(o->out, cpu_env, offsetof(CPUS390XState, psa));
     tcg_gen_andi_i64(o->out, o->out, 0x7fffe000);
     return DISAS_NEXT;
@@ -4296,8 +4234,6 @@ static DisasJumpType op_stnosm(DisasContext *s, DisasOps *o)
     uint64_t i2 = get_field(s->fields, i2);
     TCGv_i64 t;
 
-    check_privileged(s);
-
     /* It is important to do what the instruction name says: STORE THEN.
        If we let the output hook perform the store then if we fault and
        restart, we'll have the wrong SYSTEM MASK in place.  */
@@ -4319,14 +4255,12 @@ static DisasJumpType op_stnosm(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_stura(DisasContext *s, DisasOps *o)
 {
-    check_privileged(s);
     gen_helper_stura(cpu_env, o->in2, o->in1);
     return DISAS_NEXT;
 }
 
 static DisasJumpType op_sturg(DisasContext *s, DisasOps *o)
 {
-    check_privileged(s);
     gen_helper_sturg(cpu_env, o->in2, o->in1);
     return DISAS_NEXT;
 }
@@ -4592,7 +4526,6 @@ static DisasJumpType op_tcxb(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_testblock(DisasContext *s, DisasOps *o)
 {
-    check_privileged(s);
     gen_helper_testblock(cc_op, cpu_env, o->in2);
     set_cc_static(s);
     return DISAS_NEXT;
@@ -4850,7 +4783,6 @@ static DisasJumpType op_clp(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 r2 = tcg_const_i32(get_field(s->fields, r2));
 
-    check_privileged(s);
     gen_helper_clp(cpu_env, r2);
     tcg_temp_free_i32(r2);
     set_cc_static(s);
@@ -4862,7 +4794,6 @@ static DisasJumpType op_pcilg(DisasContext *s, DisasOps *o)
     TCGv_i32 r1 = tcg_const_i32(get_field(s->fields, r1));
     TCGv_i32 r2 = tcg_const_i32(get_field(s->fields, r2));
 
-    check_privileged(s);
     gen_helper_pcilg(cpu_env, r1, r2);
     tcg_temp_free_i32(r1);
     tcg_temp_free_i32(r2);
@@ -4875,7 +4806,6 @@ static DisasJumpType op_pcistg(DisasContext *s, DisasOps *o)
     TCGv_i32 r1 = tcg_const_i32(get_field(s->fields, r1));
     TCGv_i32 r2 = tcg_const_i32(get_field(s->fields, r2));
 
-    check_privileged(s);
     gen_helper_pcistg(cpu_env, r1, r2);
     tcg_temp_free_i32(r1);
     tcg_temp_free_i32(r2);
@@ -4888,7 +4818,6 @@ static DisasJumpType op_stpcifc(DisasContext *s, DisasOps *o)
     TCGv_i32 r1 = tcg_const_i32(get_field(s->fields, r1));
     TCGv_i32 ar = tcg_const_i32(get_field(s->fields, b2));
 
-    check_privileged(s);
     gen_helper_stpcifc(cpu_env, r1, o->addr1, ar);
     tcg_temp_free_i32(ar);
     tcg_temp_free_i32(r1);
@@ -4898,7 +4827,6 @@ static DisasJumpType op_stpcifc(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_sic(DisasContext *s, DisasOps *o)
 {
-    check_privileged(s);
     gen_helper_sic(cpu_env, o->in1, o->in2);
     return DISAS_NEXT;
 }
@@ -4908,7 +4836,6 @@ static DisasJumpType op_rpcit(DisasContext *s, DisasOps *o)
     TCGv_i32 r1 = tcg_const_i32(get_field(s->fields, r1));
     TCGv_i32 r2 = tcg_const_i32(get_field(s->fields, r2));
 
-    check_privileged(s);
     gen_helper_rpcit(cpu_env, r1, r2);
     tcg_temp_free_i32(r1);
     tcg_temp_free_i32(r2);
@@ -4922,7 +4849,6 @@ static DisasJumpType op_pcistb(DisasContext *s, DisasOps *o)
     TCGv_i32 r3 = tcg_const_i32(get_field(s->fields, r3));
     TCGv_i32 ar = tcg_const_i32(get_field(s->fields, b2));
 
-    check_privileged(s);
     gen_helper_pcistb(cpu_env, r1, r3, o->addr1, ar);
     tcg_temp_free_i32(ar);
     tcg_temp_free_i32(r1);
@@ -4936,7 +4862,6 @@ static DisasJumpType op_mpcifc(DisasContext *s, DisasOps *o)
     TCGv_i32 r1 = tcg_const_i32(get_field(s->fields, r1));
     TCGv_i32 ar = tcg_const_i32(get_field(s->fields, b2));
 
-    check_privileged(s);
     gen_helper_mpcifc(cpu_env, r1, o->addr1, ar);
     tcg_temp_free_i32(ar);
     tcg_temp_free_i32(r1);
@@ -6127,6 +6052,12 @@ static DisasJumpType translate_one(CPUS390XState *env, DisasContext *s)
 
     /* process flags */
     if (insn->flags) {
+        /* privileged instruction */
+        if ((s->base.tb->flags & FLAG_MASK_PSTATE) && (insn->flags & IF_PRIV)) {
+            gen_program_exception(s, PGM_PRIVILEGED);
+            return DISAS_NORETURN;
+        }
+
         /* if AFP is not enabled, instructions and registers are forbidden */
         if (!(s->base.tb->flags & FLAG_MASK_AFP)) {
             uint8_t dxc = 0;
-- 
2.14.4
