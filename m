Received: from eggs.gnu.org ([2001:4830:134:3::10]:42249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fvM3i-0000Hi-9H
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 08:28:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fvM3e-0000aT-6s
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 08:28:22 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu, 30 Aug 2018 14:27:54 +0200
Message-Id: <20180830122756.13991-8-david@redhat.com>
In-Reply-To: <20180830122756.13991-1-david@redhat.com>
References: <20180830122756.13991-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 7/9] s390x/tcg: handle privileged
 instructions via flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>

Let's check this also at a central place.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/insn-data.def | 138 ++++++++++++++++++-------------------
 target/s390x/translate.c   |  83 ++--------------------
 2 files changed, 76 insertions(+), 145 deletions(-)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 506c3de1d7..fe52d7b81c 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -961,126 +961,126 @@
 
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
index a0c834ebb9..1ca6ef45a1 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -320,15 +320,6 @@ static inline void gen_trap(DisasContext *s)
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
@@ -1119,6 +1110,7 @@ typedef struct {
 #define IF_HFP3     0x0004      /* r3 points at fp reg for HFP instructions */
 #define IF_BFP      0x0008      /* binary floating point instruction */
 #define IF_DFP      0x0010      /* decimal floating point instruction */
+#define IF_PRIV     0x0020      /* priviledged instruction */
 
 struct DisasInsn {
     unsigned opc:16;
@@ -2046,7 +2038,6 @@ static DisasJumpType op_csp(DisasContext *s, DisasOps *o)
     /* Note that in1 = R1 (zero-extended expected value),
        out = R1 (original reg), out2 = R1+1 (new value).  */
 
-    check_privileged(s);
     addr = tcg_temp_new_i64();
     old = tcg_temp_new_i64();
     tcg_gen_andi_i64(addr, o->in2, -1ULL << (mop & MO_SIZE));
@@ -2170,7 +2161,6 @@ static DisasJumpType op_diag(DisasContext *s, DisasOps *o)
     TCGv_i32 r3 = tcg_const_i32(get_field(s->fields, r3));
     TCGv_i32 func_code = tcg_const_i32(get_field(s->fields, i2));
 
-    check_privileged(s);
     gen_helper_diag(cpu_env, r1, r3, func_code);
 
     tcg_temp_free_i32(func_code);
@@ -2434,7 +2424,6 @@ static DisasJumpType op_idte(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 m4;
 
-    check_privileged(s);
     if (s390_has_feat(S390_FEAT_LOCAL_TLB_CLEARING)) {
         m4 = tcg_const_i32(get_field(s->fields, m4));
     } else {
@@ -2449,7 +2438,6 @@ static DisasJumpType op_ipte(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 m4;
 
-    check_privileged(s);
     if (s390_has_feat(S390_FEAT_LOCAL_TLB_CLEARING)) {
         m4 = tcg_const_i32(get_field(s->fields, m4));
     } else {
@@ -2462,7 +2450,6 @@ static DisasJumpType op_ipte(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_iske(DisasContext *s, DisasOps *o)
 {
-    check_privileged(s);
     gen_helper_iske(o->out, cpu_env, o->in2);
     return DISAS_NEXT;
 }
@@ -2761,7 +2748,6 @@ static DisasJumpType op_lctl(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 r1 = tcg_const_i32(get_field(s->fields, r1));
     TCGv_i32 r3 = tcg_const_i32(get_field(s->fields, r3));
-    check_privileged(s);
     gen_helper_lctl(cpu_env, r1, o->in2, r3);
     tcg_temp_free_i32(r1);
     tcg_temp_free_i32(r3);
@@ -2773,7 +2759,6 @@ static DisasJumpType op_lctlg(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 r1 = tcg_const_i32(get_field(s->fields, r1));
     TCGv_i32 r3 = tcg_const_i32(get_field(s->fields, r3));
-    check_privileged(s);
     gen_helper_lctlg(cpu_env, r1, o->in2, r3);
     tcg_temp_free_i32(r1);
     tcg_temp_free_i32(r3);
@@ -2783,7 +2768,6 @@ static DisasJumpType op_lctlg(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_lra(DisasContext *s, DisasOps *o)
 {
-    check_privileged(s);
     gen_helper_lra(o->out, cpu_env, o->in2);
     set_cc_static(s);
     return DISAS_NEXT;
@@ -2791,8 +2775,6 @@ static DisasJumpType op_lra(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_lpp(DisasContext *s, DisasOps *o)
 {
-    check_privileged(s);
-
     tcg_gen_st_i64(o->in2, cpu_env, offsetof(CPUS390XState, pp));
     return DISAS_NEXT;
 }
@@ -2801,7 +2783,6 @@ static DisasJumpType op_lpsw(DisasContext *s, DisasOps *o)
 {
     TCGv_i64 t1, t2;
 
-    check_privileged(s);
     per_breaking_event(s);
 
     t1 = tcg_temp_new_i64();
@@ -2821,7 +2802,6 @@ static DisasJumpType op_lpswe(DisasContext *s, DisasOps *o)
 {
     TCGv_i64 t1, t2;
 
-    check_privileged(s);
     per_breaking_event(s);
 
     t1 = tcg_temp_new_i64();
@@ -3019,14 +2999,12 @@ static DisasJumpType op_lpq(DisasContext *s, DisasOps *o)
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
@@ -3185,7 +3163,6 @@ static DisasJumpType op_mvcos(DisasContext *s, DisasOps *o)
 static DisasJumpType op_mvcp(DisasContext *s, DisasOps *o)
 {
     int r1 = get_field(s->fields, l1);
-    check_privileged(s);
     gen_helper_mvcp(cc_op, cpu_env, regs[r1], o->addr1, o->in2);
     set_cc_static(s);
     return DISAS_NEXT;
@@ -3194,7 +3171,6 @@ static DisasJumpType op_mvcp(DisasContext *s, DisasOps *o)
 static DisasJumpType op_mvcs(DisasContext *s, DisasOps *o)
 {
     int r1 = get_field(s->fields, l1);
-    check_privileged(s);
     gen_helper_mvcs(cc_op, cpu_env, regs[r1], o->addr1, o->in2);
     set_cc_static(s);
     return DISAS_NEXT;
@@ -3480,7 +3456,6 @@ static DisasJumpType op_popcnt(DisasContext *s, DisasOps *o)
 #ifndef CONFIG_USER_ONLY
 static DisasJumpType op_ptlb(DisasContext *s, DisasOps *o)
 {
-    check_privileged(s);
     gen_helper_ptlb(cpu_env);
     return DISAS_NEXT;
 }
@@ -3671,7 +3646,6 @@ static DisasJumpType op_rll64(DisasContext *s, DisasOps *o)
 #ifndef CONFIG_USER_ONLY
 static DisasJumpType op_rrbe(DisasContext *s, DisasOps *o)
 {
-    check_privileged(s);
     gen_helper_rrbe(cc_op, cpu_env, o->in2);
     set_cc_static(s);
     return DISAS_NEXT;
@@ -3679,7 +3653,6 @@ static DisasJumpType op_rrbe(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_sacf(DisasContext *s, DisasOps *o)
 {
-    check_privileged(s);
     gen_helper_sacf(cpu_env, o->in2);
     /* Addressing mode has changed, so end the block.  */
     return DISAS_PC_STALE;
@@ -3769,7 +3742,6 @@ static DisasJumpType op_sqxb(DisasContext *s, DisasOps *o)
 #ifndef CONFIG_USER_ONLY
 static DisasJumpType op_servc(DisasContext *s, DisasOps *o)
 {
-    check_privileged(s);
     gen_helper_servc(cc_op, cpu_env, o->in2, o->in1);
     set_cc_static(s);
     return DISAS_NEXT;
@@ -3779,7 +3751,6 @@ static DisasJumpType op_sigp(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 r1 = tcg_const_i32(get_field(s->fields, r1));
     TCGv_i32 r3 = tcg_const_i32(get_field(s->fields, r3));
-    check_privileged(s);
     gen_helper_sigp(cc_op, cpu_env, o->in2, r1, r3);
     set_cc_static(s);
     tcg_temp_free_i32(r1);
@@ -3961,7 +3932,6 @@ static DisasJumpType op_ectg(DisasContext *s, DisasOps *o)
 #ifndef CONFIG_USER_ONLY
 static DisasJumpType op_spka(DisasContext *s, DisasOps *o)
 {
-    check_privileged(s);
     tcg_gen_shri_i64(o->in2, o->in2, 4);
     tcg_gen_deposit_i64(psw_mask, psw_mask, o->in2, PSW_SHIFT_KEY, 4);
     return DISAS_NEXT;
@@ -3969,14 +3939,12 @@ static DisasJumpType op_spka(DisasContext *s, DisasOps *o)
 
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
@@ -3984,7 +3952,6 @@ static DisasJumpType op_ssm(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_stap(DisasContext *s, DisasOps *o)
 {
-    check_privileged(s);
     tcg_gen_ld32u_i64(o->out, cpu_env, offsetof(CPUS390XState, core_id));
     return DISAS_NEXT;
 }
@@ -4026,7 +3993,6 @@ static DisasJumpType op_stcke(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_sck(DisasContext *s, DisasOps *o)
 {
-    check_privileged(s);
     tcg_gen_qemu_ld_i64(o->in1, o->addr1, get_mem_index(s), MO_TEQ | MO_ALIGN);
     gen_helper_sck(cc_op, cpu_env, o->in1);
     set_cc_static(s);
@@ -4035,21 +4001,18 @@ static DisasJumpType op_sck(DisasContext *s, DisasOps *o)
 
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
@@ -4058,7 +4021,6 @@ static DisasJumpType op_stctg(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 r1 = tcg_const_i32(get_field(s->fields, r1));
     TCGv_i32 r3 = tcg_const_i32(get_field(s->fields, r3));
-    check_privileged(s);
     gen_helper_stctg(cpu_env, r1, o->in2, r3);
     tcg_temp_free_i32(r1);
     tcg_temp_free_i32(r3);
@@ -4069,7 +4031,6 @@ static DisasJumpType op_stctl(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 r1 = tcg_const_i32(get_field(s->fields, r1));
     TCGv_i32 r3 = tcg_const_i32(get_field(s->fields, r3));
-    check_privileged(s);
     gen_helper_stctl(cpu_env, r1, o->in2, r3);
     tcg_temp_free_i32(r1);
     tcg_temp_free_i32(r3);
@@ -4078,35 +4039,30 @@ static DisasJumpType op_stctl(DisasContext *s, DisasOps *o)
 
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
@@ -4114,14 +4070,12 @@ static DisasJumpType op_stsi(DisasContext *s, DisasOps *o)
 
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
@@ -4129,7 +4083,6 @@ static DisasJumpType op_xsch(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_csch(DisasContext *s, DisasOps *o)
 {
-    check_privileged(s);
     gen_helper_csch(cpu_env, regs[1]);
     set_cc_static(s);
     return DISAS_NEXT;
@@ -4137,7 +4090,6 @@ static DisasJumpType op_csch(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_hsch(DisasContext *s, DisasOps *o)
 {
-    check_privileged(s);
     gen_helper_hsch(cpu_env, regs[1]);
     set_cc_static(s);
     return DISAS_NEXT;
@@ -4145,7 +4097,6 @@ static DisasJumpType op_hsch(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_msch(DisasContext *s, DisasOps *o)
 {
-    check_privileged(s);
     gen_helper_msch(cpu_env, regs[1], o->in2);
     set_cc_static(s);
     return DISAS_NEXT;
@@ -4153,7 +4104,6 @@ static DisasJumpType op_msch(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_rchp(DisasContext *s, DisasOps *o)
 {
-    check_privileged(s);
     gen_helper_rchp(cpu_env, regs[1]);
     set_cc_static(s);
     return DISAS_NEXT;
@@ -4161,7 +4111,6 @@ static DisasJumpType op_rchp(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_rsch(DisasContext *s, DisasOps *o)
 {
-    check_privileged(s);
     gen_helper_rsch(cpu_env, regs[1]);
     set_cc_static(s);
     return DISAS_NEXT;
@@ -4169,21 +4118,18 @@ static DisasJumpType op_rsch(DisasContext *s, DisasOps *o)
 
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
@@ -4191,14 +4137,12 @@ static DisasJumpType op_siga(DisasContext *s, DisasOps *o)
 
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
@@ -4206,7 +4150,6 @@ static DisasJumpType op_ssch(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_stsch(DisasContext *s, DisasOps *o)
 {
-    check_privileged(s);
     gen_helper_stsch(cpu_env, regs[1], o->in2);
     set_cc_static(s);
     return DISAS_NEXT;
@@ -4214,7 +4157,6 @@ static DisasJumpType op_stsch(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_stcrw(DisasContext *s, DisasOps *o)
 {
-    check_privileged(s);
     gen_helper_stcrw(cpu_env, o->in2);
     set_cc_static(s);
     return DISAS_NEXT;
@@ -4222,7 +4164,6 @@ static DisasJumpType op_stcrw(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_tpi(DisasContext *s, DisasOps *o)
 {
-    check_privileged(s);
     gen_helper_tpi(cc_op, cpu_env, o->addr1);
     set_cc_static(s);
     return DISAS_NEXT;
@@ -4230,7 +4171,6 @@ static DisasJumpType op_tpi(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_tsch(DisasContext *s, DisasOps *o)
 {
-    check_privileged(s);
     gen_helper_tsch(cpu_env, regs[1], o->in2);
     set_cc_static(s);
     return DISAS_NEXT;
@@ -4238,7 +4178,6 @@ static DisasJumpType op_tsch(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_chsc(DisasContext *s, DisasOps *o)
 {
-    check_privileged(s);
     gen_helper_chsc(cpu_env, o->in2);
     set_cc_static(s);
     return DISAS_NEXT;
@@ -4246,7 +4185,6 @@ static DisasJumpType op_chsc(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_stpx(DisasContext *s, DisasOps *o)
 {
-    check_privileged(s);
     tcg_gen_ld_i64(o->out, cpu_env, offsetof(CPUS390XState, psa));
     tcg_gen_andi_i64(o->out, o->out, 0x7fffe000);
     return DISAS_NEXT;
@@ -4257,8 +4195,6 @@ static DisasJumpType op_stnosm(DisasContext *s, DisasOps *o)
     uint64_t i2 = get_field(s->fields, i2);
     TCGv_i64 t;
 
-    check_privileged(s);
-
     /* It is important to do what the instruction name says: STORE THEN.
        If we let the output hook perform the store then if we fault and
        restart, we'll have the wrong SYSTEM MASK in place.  */
@@ -4280,14 +4216,12 @@ static DisasJumpType op_stnosm(DisasContext *s, DisasOps *o)
 
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
@@ -4553,7 +4487,6 @@ static DisasJumpType op_tcxb(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_testblock(DisasContext *s, DisasOps *o)
 {
-    check_privileged(s);
     gen_helper_testblock(cc_op, cpu_env, o->in2);
     set_cc_static(s);
     return DISAS_NEXT;
@@ -4811,7 +4744,6 @@ static DisasJumpType op_clp(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 r2 = tcg_const_i32(get_field(s->fields, r2));
 
-    check_privileged(s);
     gen_helper_clp(cpu_env, r2);
     tcg_temp_free_i32(r2);
     set_cc_static(s);
@@ -4823,7 +4755,6 @@ static DisasJumpType op_pcilg(DisasContext *s, DisasOps *o)
     TCGv_i32 r1 = tcg_const_i32(get_field(s->fields, r1));
     TCGv_i32 r2 = tcg_const_i32(get_field(s->fields, r2));
 
-    check_privileged(s);
     gen_helper_pcilg(cpu_env, r1, r2);
     tcg_temp_free_i32(r1);
     tcg_temp_free_i32(r2);
@@ -4836,7 +4767,6 @@ static DisasJumpType op_pcistg(DisasContext *s, DisasOps *o)
     TCGv_i32 r1 = tcg_const_i32(get_field(s->fields, r1));
     TCGv_i32 r2 = tcg_const_i32(get_field(s->fields, r2));
 
-    check_privileged(s);
     gen_helper_pcistg(cpu_env, r1, r2);
     tcg_temp_free_i32(r1);
     tcg_temp_free_i32(r2);
@@ -4849,7 +4779,6 @@ static DisasJumpType op_stpcifc(DisasContext *s, DisasOps *o)
     TCGv_i32 r1 = tcg_const_i32(get_field(s->fields, r1));
     TCGv_i32 ar = tcg_const_i32(get_field(s->fields, b2));
 
-    check_privileged(s);
     gen_helper_stpcifc(cpu_env, r1, o->addr1, ar);
     tcg_temp_free_i32(ar);
     tcg_temp_free_i32(r1);
@@ -4859,7 +4788,6 @@ static DisasJumpType op_stpcifc(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_sic(DisasContext *s, DisasOps *o)
 {
-    check_privileged(s);
     gen_helper_sic(cpu_env, o->in1, o->in2);
     return DISAS_NEXT;
 }
@@ -4869,7 +4797,6 @@ static DisasJumpType op_rpcit(DisasContext *s, DisasOps *o)
     TCGv_i32 r1 = tcg_const_i32(get_field(s->fields, r1));
     TCGv_i32 r2 = tcg_const_i32(get_field(s->fields, r2));
 
-    check_privileged(s);
     gen_helper_rpcit(cpu_env, r1, r2);
     tcg_temp_free_i32(r1);
     tcg_temp_free_i32(r2);
@@ -4883,7 +4810,6 @@ static DisasJumpType op_pcistb(DisasContext *s, DisasOps *o)
     TCGv_i32 r3 = tcg_const_i32(get_field(s->fields, r3));
     TCGv_i32 ar = tcg_const_i32(get_field(s->fields, b2));
 
-    check_privileged(s);
     gen_helper_pcistb(cpu_env, r1, r3, o->addr1, ar);
     tcg_temp_free_i32(ar);
     tcg_temp_free_i32(r1);
@@ -4897,7 +4823,6 @@ static DisasJumpType op_mpcifc(DisasContext *s, DisasOps *o)
     TCGv_i32 r1 = tcg_const_i32(get_field(s->fields, r1));
     TCGv_i32 ar = tcg_const_i32(get_field(s->fields, b2));
 
-    check_privileged(s);
     gen_helper_mpcifc(cpu_env, r1, o->addr1, ar);
     tcg_temp_free_i32(ar);
     tcg_temp_free_i32(r1);
@@ -6088,6 +6013,12 @@ static DisasJumpType translate_one(CPUS390XState *env, DisasContext *s)
 
     /* process flags */
     if (insn->flags) {
+        /* priviledged instruction */
+        if ((s->base.tb->flags & FLAG_MASK_PSTATE) && (insn->flags & IF_PRIV)) {
+            gen_program_exception(s, PGM_PRIVILEGED);
+            return DISAS_NORETURN;
+        }
+
         /* if AFP is not enabled, instructions and registers are forbidden */
         if (!(s->base.tb->flags & FLAG_MASK_AFP)) {
             uint8_t dxc = 0;
-- 
2.17.1
