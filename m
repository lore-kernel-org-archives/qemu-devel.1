Received: from eggs.gnu.org ([209.51.188.92]:40224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gpDTl-0005Se-Sc
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 09:38:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gpDTi-0007Ch-5g
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 09:38:09 -0500
From: David Hildenbrand <david@redhat.com>
Date: Thu, 31 Jan 2019 15:37:59 +0100
Message-Id: <20190131143759.3122-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1] s390x/tcg: Don't model FP registers as
 globals
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>

As floating point registers overlay some vector registers and we want
to make use of the general tcg_gvec infrastructure that assumes vectors
are not stored in globals but in memory, don't model flaoting point
registers as globals anymore. This is than similar to how arm handles
it.

Reading/writing a floating point register means reading/writing memory now.

Break up ugly in2_x2() handling that modifies both, in1 and in2 into
in1_x2l and in2_x2h. This makes things more readable. Also, in1_x1() is
ugly as it touches out/out2, get rid of that and use prep_x1() instead.

As we are no longer able to use the original global variables for
out/out2, we have to use new temporary variables and write from them to
the target registers using wout_ helpers.

E.g. an instruction that reads and writes x1 will use
- prep_x1 to get the values into out/out2
- wout_x1 to write the values from out/out2
This special handling is needed for x1 as it is often used along with
other inputs, so in1/in2 is already used.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/insn-data.def | 150 ++++++++++++++++++-------------------
 target/s390x/translate.c   | 133 +++++++++++++++++++-------------
 2 files changed, 158 insertions(+), 125 deletions(-)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 54e39df831..e275910dfa 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -33,10 +33,10 @@
     C(0xe308, AG,      RXY_a, Z,   r1, m2_64, r1, 0, add, adds64)
     C(0xe318, AGF,     RXY_a, Z,   r1, m2_32s, r1, 0, add, adds64)
     F(0xb30a, AEBR,    RRE,   Z,   e1, e2, new, e1, aeb, f32, IF_BFP)
-    F(0xb31a, ADBR,    RRE,   Z,   f1_o, f2_o, f1, 0, adb, f64, IF_BFP)
-    F(0xb34a, AXBR,    RRE,   Z,   0, x2_o, x1, 0, axb, f128, IF_BFP)
+    F(0xb31a, ADBR,    RRE,   Z,   f1, f2, new, f1, adb, f64, IF_BFP)
+    F(0xb34a, AXBR,    RRE,   Z,   x2l, x2h, x1, x1, axb, f128, IF_BFP)
     F(0xed0a, AEB,     RXE,   Z,   e1, m2_32u, new, e1, aeb, f32, IF_BFP)
-    F(0xed1a, ADB,     RXE,   Z,   f1_o, m2_64, f1, 0, adb, f64, IF_BFP)
+    F(0xed1a, ADB,     RXE,   Z,   f1, m2_64, new, f1, adb, f64, IF_BFP)
 /* ADD HIGH */
     C(0xb9c8, AHHHR,   RRF_a, HW,  r2_sr32, r3_sr32, new, r1_32h, add, adds32)
     C(0xb9d8, AHHLR,   RRF_a, HW,  r2_sr32, r3, new, r1_32h, add, adds32)
@@ -154,7 +154,7 @@
     C(0xb241, CKSM,    RRE,   Z,   r1_o, ra2, new, r1_32, cksm, 0)
 
 /* COPY SIGN */
-    F(0xb372, CPSDR,   RRF_b, FPSSH, f3_o, f2_o, f1, 0, cps, 0, IF_AFP1 | IF_AFP2 | IF_AFP3)
+    F(0xb372, CPSDR,   RRF_b, FPSSH, f3, f2, new, f1, cps, 0, IF_AFP1 | IF_AFP2 | IF_AFP3)
 
 /* COMPARE */
     C(0x1900, CR,      RR_a,  Z,   r1_o, r2_o, 0, 0, 0, cmps32)
@@ -165,16 +165,16 @@
     C(0xe320, CG,      RXY_a, Z,   r1_o, m2_64, 0, 0, 0, cmps64)
     C(0xe330, CGF,     RXY_a, Z,   r1_o, m2_32s, 0, 0, 0, cmps64)
     F(0xb309, CEBR,    RRE,   Z,   e1, e2, 0, 0, ceb, 0, IF_BFP)
-    F(0xb319, CDBR,    RRE,   Z,   f1_o, f2_o, 0, 0, cdb, 0, IF_BFP)
-    F(0xb349, CXBR,    RRE,   Z,   x1_o, x2_o, 0, 0, cxb, 0, IF_BFP)
+    F(0xb319, CDBR,    RRE,   Z,   f1, f2, 0, 0, cdb, 0, IF_BFP)
+    F(0xb349, CXBR,    RRE,   Z,   x2l, x2h, x1, 0, cxb, 0, IF_BFP)
     F(0xed09, CEB,     RXE,   Z,   e1, m2_32u, 0, 0, ceb, 0, IF_BFP)
-    F(0xed19, CDB,     RXE,   Z,   f1_o, m2_64, 0, 0, cdb, 0, IF_BFP)
+    F(0xed19, CDB,     RXE,   Z,   f1, m2_64, 0, 0, cdb, 0, IF_BFP)
 /* COMPARE AND SIGNAL */
     F(0xb308, KEBR,    RRE,   Z,   e1, e2, 0, 0, keb, 0, IF_BFP)
-    F(0xb318, KDBR,    RRE,   Z,   f1_o, f2_o, 0, 0, kdb, 0, IF_BFP)
-    F(0xb348, KXBR,    RRE,   Z,   x1_o, x2_o, 0, 0, kxb, 0, IF_BFP)
+    F(0xb318, KDBR,    RRE,   Z,   f1, f2, 0, 0, kdb, 0, IF_BFP)
+    F(0xb348, KXBR,    RRE,   Z,   x2l, x2h, x1, 0, kxb, 0, IF_BFP)
     F(0xed08, KEB,     RXE,   Z,   e1, m2_32u, 0, 0, keb, 0, IF_BFP)
-    F(0xed18, KDB,     RXE,   Z,   f1_o, m2_64, 0, 0, kdb, 0, IF_BFP)
+    F(0xed18, KDB,     RXE,   Z,   f1, m2_64, 0, 0, kdb, 0, IF_BFP)
 /* COMPARE IMMEDIATE */
     C(0xc20d, CFI,     RIL_a, EI,  r1, i2, 0, 0, 0, cmps32)
     C(0xc20c, CGFI,    RIL_a, EI,  r1, i2, 0, 0, 0, cmps64)
@@ -292,32 +292,32 @@
     C(0xe326, CVDY,    RXY_a, LD,  r1_o, a2, 0, 0, cvd, 0)
 /* CONVERT TO FIXED */
     F(0xb398, CFEBR,   RRF_e, Z,   0, e2, new, r1_32, cfeb, 0, IF_BFP)
-    F(0xb399, CFDBR,   RRF_e, Z,   0, f2_o, new, r1_32, cfdb, 0, IF_BFP)
-    F(0xb39a, CFXBR,   RRF_e, Z,   0, x2_o, new, r1_32, cfxb, 0, IF_BFP)
+    F(0xb399, CFDBR,   RRF_e, Z,   0, f2, new, r1_32, cfdb, 0, IF_BFP)
+    F(0xb39a, CFXBR,   RRF_e, Z,   x2l, x2h, new, r1_32, cfxb, 0, IF_BFP)
     F(0xb3a8, CGEBR,   RRF_e, Z,   0, e2, r1, 0, cgeb, 0, IF_BFP)
-    F(0xb3a9, CGDBR,   RRF_e, Z,   0, f2_o, r1, 0, cgdb, 0, IF_BFP)
-    F(0xb3aa, CGXBR,   RRF_e, Z,   0, x2_o, r1, 0, cgxb, 0, IF_BFP)
+    F(0xb3a9, CGDBR,   RRF_e, Z,   0, f2, r1, 0, cgdb, 0, IF_BFP)
+    F(0xb3aa, CGXBR,   RRF_e, Z,   x2l, x2h, r1, 0, cgxb, 0, IF_BFP)
 /* CONVERT FROM FIXED */
     F(0xb394, CEFBR,   RRF_e, Z,   0, r2_32s, new, e1, cegb, 0, IF_BFP)
-    F(0xb395, CDFBR,   RRF_e, Z,   0, r2_32s, f1, 0, cdgb, 0, IF_BFP)
-    F(0xb396, CXFBR,   RRF_e, Z,   0, r2_32s, x1, 0, cxgb, 0, IF_BFP)
+    F(0xb395, CDFBR,   RRF_e, Z,   0, r2_32s, new, f1, cdgb, 0, IF_BFP)
+    F(0xb396, CXFBR,   RRF_e, Z,   0, r2_32s, new_P, x1, cxgb, 0, IF_BFP)
     F(0xb3a4, CEGBR,   RRF_e, Z,   0, r2_o, new, e1, cegb, 0, IF_BFP)
-    F(0xb3a5, CDGBR,   RRF_e, Z,   0, r2_o, f1, 0, cdgb, 0, IF_BFP)
-    F(0xb3a6, CXGBR,   RRF_e, Z,   0, r2_o, x1, 0, cxgb, 0, IF_BFP)
+    F(0xb3a5, CDGBR,   RRF_e, Z,   0, r2_o, new, f1, cdgb, 0, IF_BFP)
+    F(0xb3a6, CXGBR,   RRF_e, Z,   0, r2_o, new_P, x1, cxgb, 0, IF_BFP)
 /* CONVERT TO LOGICAL */
     F(0xb39c, CLFEBR,  RRF_e, FPE, 0, e2, new, r1_32, clfeb, 0, IF_BFP)
-    F(0xb39d, CLFDBR,  RRF_e, FPE, 0, f2_o, new, r1_32, clfdb, 0, IF_BFP)
-    F(0xb39e, CLFXBR,  RRF_e, FPE, 0, x2_o, new, r1_32, clfxb, 0, IF_BFP)
+    F(0xb39d, CLFDBR,  RRF_e, FPE, 0, f2, new, r1_32, clfdb, 0, IF_BFP)
+    F(0xb39e, CLFXBR,  RRF_e, FPE, x2l, x2h, new, r1_32, clfxb, 0, IF_BFP)
     F(0xb3ac, CLGEBR,  RRF_e, FPE, 0, e2, r1, 0, clgeb, 0, IF_BFP)
-    F(0xb3ad, CLGDBR,  RRF_e, FPE, 0, f2_o, r1, 0, clgdb, 0, IF_BFP)
-    F(0xb3ae, CLGXBR,  RRF_e, FPE, 0, x2_o, r1, 0, clgxb, 0, IF_BFP)
+    F(0xb3ad, CLGDBR,  RRF_e, FPE, 0, f2, r1, 0, clgdb, 0, IF_BFP)
+    F(0xb3ae, CLGXBR,  RRF_e, FPE, x2l, x2h, r1, 0, clgxb, 0, IF_BFP)
 /* CONVERT FROM LOGICAL */
     F(0xb390, CELFBR,  RRF_e, FPE, 0, r2_32u, new, e1, celgb, 0, IF_BFP)
-    F(0xb391, CDLFBR,  RRF_e, FPE, 0, r2_32u, f1, 0, cdlgb, 0, IF_BFP)
-    F(0xb392, CXLFBR,  RRF_e, FPE, 0, r2_32u, x1, 0, cxlgb, 0, IF_BFP)
+    F(0xb391, CDLFBR,  RRF_e, FPE, 0, r2_32u, new, f1, cdlgb, 0, IF_BFP)
+    F(0xb392, CXLFBR,  RRF_e, FPE, 0, r2_32u, new_P, x1, cxlgb, 0, IF_BFP)
     F(0xb3a0, CELGBR,  RRF_e, FPE, 0, r2_o, new, e1, celgb, 0, IF_BFP)
-    F(0xb3a1, CDLGBR,  RRF_e, FPE, 0, r2_o, f1, 0, cdlgb, 0, IF_BFP)
-    F(0xb3a2, CXLGBR,  RRF_e, FPE, 0, r2_o, x1, 0, cxlgb, 0, IF_BFP)
+    F(0xb3a1, CDLGBR,  RRF_e, FPE, 0, r2_o, new, f1, cdlgb, 0, IF_BFP)
+    F(0xb3a2, CXLGBR,  RRF_e, FPE, 0, r2_o, new_P, x1, cxlgb, 0, IF_BFP)
 
 /* CONVERT UTF-8 TO UTF-16 */
     D(0xb2a7, CU12,    RRF_c, Z,   0, 0, 0, 0, cuXX, 0, 12)
@@ -336,10 +336,10 @@
     C(0x1d00, DR,      RR_a,  Z,   r1_D32, r2_32s, new_P, r1_P32, divs32, 0)
     C(0x5d00, D,       RX_a,  Z,   r1_D32, m2_32s, new_P, r1_P32, divs32, 0)
     F(0xb30d, DEBR,    RRE,   Z,   e1, e2, new, e1, deb, 0, IF_BFP)
-    F(0xb31d, DDBR,    RRE,   Z,   f1_o, f2_o, f1, 0, ddb, 0, IF_BFP)
-    F(0xb34d, DXBR,    RRE,   Z,   0, x2_o, x1, 0, dxb, 0, IF_BFP)
+    F(0xb31d, DDBR,    RRE,   Z,   f1, f2, new, f1, ddb, 0, IF_BFP)
+    F(0xb34d, DXBR,    RRE,   Z,   x2l, x2h, x1, x1, dxb, 0, IF_BFP)
     F(0xed0d, DEB,     RXE,   Z,   e1, m2_32u, new, e1, deb, 0, IF_BFP)
-    F(0xed1d, DDB,     RXE,   Z,   f1_o, m2_64, f1, 0, ddb, 0, IF_BFP)
+    F(0xed1d, DDB,     RXE,   Z,   f1, m2_64, new, f1, ddb, 0, IF_BFP)
 /* DIVIDE LOGICAL */
     C(0xb997, DLR,     RRE,   Z,   r1_D32, r2_32u, new_P, r1_P32, divu32, 0)
     C(0xe397, DL,      RXY_a, Z,   r1_D32, m2_32u, new_P, r1_P32, divu32, 0)
@@ -410,13 +410,13 @@
     C(0xb914, LGFR,    RRE,   Z,   0, r2_32s, 0, r1, mov2, 0)
     C(0xe304, LG,      RXY_a, Z,   0, a2, r1, 0, ld64, 0)
     C(0xe314, LGF,     RXY_a, Z,   0, a2, r1, 0, ld32s, 0)
-    F(0x2800, LDR,     RR_a,  Z,   0, f2_o, 0, f1, mov2, 0, IF_AFP1 | IF_AFP2)
+    F(0x2800, LDR,     RR_a,  Z,   0, f2, 0, f1, mov2, 0, IF_AFP1 | IF_AFP2)
     F(0x6800, LD,      RX_a,  Z,   0, m2_64, 0, f1, mov2, 0, IF_AFP1)
     F(0xed65, LDY,     RXY_a, LD,  0, m2_64, 0, f1, mov2, 0, IF_AFP1)
     F(0x3800, LER,     RR_a,  Z,   0, e2, 0, cond_e1e2, mov2, 0, IF_AFP1 | IF_AFP2)
     F(0x7800, LE,      RX_a,  Z,   0, m2_32u, 0, e1, mov2, 0, IF_AFP1)
     F(0xed64, LEY,     RXY_a, LD,  0, m2_32u, 0, e1, mov2, 0, IF_AFP1)
-    F(0xb365, LXR,     RRE,   Z,   0, x2_o, 0, x1, movx, 0, IF_AFP1)
+    F(0xb365, LXR,     RRE,   Z,   x2l, x2h, 0, x1, movx, 0, IF_AFP1)
 /* LOAD IMMEDIATE */
     C(0xc001, LGFI,    RIL_a, EI,  0, i2, 0, r1, mov2, 0)
 /* LOAD RELATIVE LONG */
@@ -454,8 +454,8 @@
     C(0xe302, LTG,     RXY_a, EI,  0, a2, r1, 0, ld64, s64)
     C(0xe332, LTGF,    RXY_a, GIE, 0, a2, r1, 0, ld32s, s64)
     F(0xb302, LTEBR,   RRE,   Z,   0, e2, 0, cond_e1e2, mov2, f32, IF_BFP)
-    F(0xb312, LTDBR,   RRE,   Z,   0, f2_o, 0, f1, mov2, f64, IF_BFP)
-    F(0xb342, LTXBR,   RRE,   Z,   0, x2_o, 0, x1, movx, f128, IF_BFP)
+    F(0xb312, LTDBR,   RRE,   Z,   0, f2, 0, f1, mov2, f64, IF_BFP)
+    F(0xb342, LTXBR,   RRE,   Z,   x2l, x2h, 0, x1, movx, f128, IF_BFP)
 /* LOAD AND TRAP */
     C(0xe39f, LAT,     RXY_a, LAT, 0, m2_32u, r1, 0, lat, 0)
     C(0xe385, LGAT,    RXY_a, LAT, 0, a2, r1, 0, lgat, 0)
@@ -476,9 +476,9 @@
     C(0xb903, LCGR,    RRE,   Z,   0, r2, r1, 0, neg, neg64)
     C(0xb913, LCGFR,   RRE,   Z,   0, r2_32s, r1, 0, neg, neg64)
     F(0xb303, LCEBR,   RRE,   Z,   0, e2, new, e1, negf32, f32, IF_BFP)
-    F(0xb313, LCDBR,   RRE,   Z,   0, f2_o, f1, 0, negf64, f64, IF_BFP)
-    F(0xb343, LCXBR,   RRE,   Z,   0, x2_o, x1, 0, negf128, f128, IF_BFP)
-    F(0xb373, LCDFR,   RRE,   FPSSH, 0, f2_o, f1, 0, negf64, 0, IF_AFP1 | IF_AFP2)
+    F(0xb313, LCDBR,   RRE,   Z,   0, f2, new, f1, negf64, f64, IF_BFP)
+    F(0xb343, LCXBR,   RRE,   Z,   x2l, x2h, new_P, x1, negf128, f128, IF_BFP)
+    F(0xb373, LCDFR,   RRE,   FPSSH, 0, f2, new, f1, negf64, 0, IF_AFP1 | IF_AFP2)
 /* LOAD HALFWORD */
     C(0xb927, LHR,     RRE,   EI,  0, r2_16s, 0, r1_32, mov2, 0)
     C(0xb907, LGHR,    RRE,   EI,  0, r2_16s, 0, r1, mov2, 0)
@@ -537,15 +537,15 @@
 /* LOAD FPR FROM GR */
     F(0xb3c1, LDGR,    RRE,   FPRGR, 0, r2_o, 0, f1, mov2, 0, IF_AFP1)
 /* LOAD GR FROM FPR */
-    F(0xb3cd, LGDR,    RRE,   FPRGR, 0, f2_o, 0, r1, mov2, 0, IF_AFP2)
+    F(0xb3cd, LGDR,    RRE,   FPRGR, 0, f2, 0, r1, mov2, 0, IF_AFP2)
 /* LOAD NEGATIVE */
     C(0x1100, LNR,     RR_a,  Z,   0, r2_32s, new, r1_32, nabs, nabs32)
     C(0xb901, LNGR,    RRE,   Z,   0, r2, r1, 0, nabs, nabs64)
     C(0xb911, LNGFR,   RRE,   Z,   0, r2_32s, r1, 0, nabs, nabs64)
     F(0xb301, LNEBR,   RRE,   Z,   0, e2, new, e1, nabsf32, f32, IF_BFP)
-    F(0xb311, LNDBR,   RRE,   Z,   0, f2_o, f1, 0, nabsf64, f64, IF_BFP)
-    F(0xb341, LNXBR,   RRE,   Z,   0, x2_o, x1, 0, nabsf128, f128, IF_BFP)
-    F(0xb371, LNDFR,   RRE,   FPSSH, 0, f2_o, f1, 0, nabsf64, 0, IF_AFP1 | IF_AFP2)
+    F(0xb311, LNDBR,   RRE,   Z,   0, f2, new, f1, nabsf64, f64, IF_BFP)
+    F(0xb341, LNXBR,   RRE,   Z,   x2l, x2h, new_P, x1, nabsf128, f128, IF_BFP)
+    F(0xb371, LNDFR,   RRE,   FPSSH, 0, f2, new, f1, nabsf64, 0, IF_AFP1 | IF_AFP2)
 /* LOAD ON CONDITION */
     C(0xb9f2, LOCR,    RRF_c, LOC, r1, r2, new, r1_32, loc, 0)
     C(0xb9e2, LOCGR,   RRF_c, LOC, r1, r2, r1, 0, loc, 0)
@@ -568,9 +568,9 @@
     C(0xb900, LPGR,    RRE,   Z,   0, r2, r1, 0, abs, abs64)
     C(0xb910, LPGFR,   RRE,   Z,   0, r2_32s, r1, 0, abs, abs64)
     F(0xb300, LPEBR,   RRE,   Z,   0, e2, new, e1, absf32, f32, IF_BFP)
-    F(0xb310, LPDBR,   RRE,   Z,   0, f2_o, f1, 0, absf64, f64, IF_BFP)
-    F(0xb340, LPXBR,   RRE,   Z,   0, x2_o, x1, 0, absf128, f128, IF_BFP)
-    F(0xb370, LPDFR,   RRE,   FPSSH, 0, f2_o, f1, 0, absf64, 0, IF_AFP1 | IF_AFP2)
+    F(0xb310, LPDBR,   RRE,   Z,   0, f2, new, f1, absf64, f64, IF_BFP)
+    F(0xb340, LPXBR,   RRE,   Z,   x2l, x2h, new_P, x1, absf128, f128, IF_BFP)
+    F(0xb370, LPDFR,   RRE,   FPSSH, 0, f2, new, f1, absf64, 0, IF_AFP1 | IF_AFP2)
 /* LOAD REVERSED */
     C(0xb91f, LRVR,    RRE,   Z,   0, r2_32u, new, r1_32, rev32, 0)
     C(0xb90f, LRVGR,   RRE,   Z,   0, r2_o, r1, 0, rev64, 0)
@@ -588,20 +588,20 @@
     F(0xb2bd, LFAS,    S,     IEEEE_SIM, 0, m2_32u, 0, 0, sfas, 0, IF_DFP)
 /* LOAD FP INTEGER */
     F(0xb357, FIEBR,   RRF_e, Z,   0, e2, new, e1, fieb, 0, IF_BFP)
-    F(0xb35f, FIDBR,   RRF_e, Z,   0, f2_o, f1, 0, fidb, 0, IF_BFP)
-    F(0xb347, FIXBR,   RRF_e, Z,   0, x2_o, x1, 0, fixb, 0, IF_BFP)
+    F(0xb35f, FIDBR,   RRF_e, Z,   0, f2, new, f1, fidb, 0, IF_BFP)
+    F(0xb347, FIXBR,   RRF_e, Z,   x2l, x2h, new_P, x1, fixb, 0, IF_BFP)
 
 /* LOAD LENGTHENED */
-    F(0xb304, LDEBR,   RRE,   Z,   0, e2, f1, 0, ldeb, 0, IF_BFP)
-    F(0xb305, LXDBR,   RRE,   Z,   0, f2_o, x1, 0, lxdb, 0, IF_BFP)
-    F(0xb306, LXEBR,   RRE,   Z,   0, e2, x1, 0, lxeb, 0, IF_BFP)
-    F(0xed04, LDEB,    RXE,   Z,   0, m2_32u, f1, 0, ldeb, 0, IF_BFP)
-    F(0xed05, LXDB,    RXE,   Z,   0, m2_64, x1, 0, lxdb, 0, IF_BFP)
-    F(0xed06, LXEB,    RXE,   Z,   0, m2_32u, x1, 0, lxeb, 0, IF_BFP)
+    F(0xb304, LDEBR,   RRE,   Z,   0, e2, new, f1, ldeb, 0, IF_BFP)
+    F(0xb305, LXDBR,   RRE,   Z,   0, f2, new_P, x1, lxdb, 0, IF_BFP)
+    F(0xb306, LXEBR,   RRE,   Z,   0, e2, new_P, x1, lxeb, 0, IF_BFP)
+    F(0xed04, LDEB,    RXE,   Z,   0, m2_32u, new, f1, ldeb, 0, IF_BFP)
+    F(0xed05, LXDB,    RXE,   Z,   0, m2_64, new_P, x1, lxdb, 0, IF_BFP)
+    F(0xed06, LXEB,    RXE,   Z,   0, m2_32u, new_P, x1, lxeb, 0, IF_BFP)
 /* LOAD ROUNDED */
-    F(0xb344, LEDBR,   RRE,   Z,   0, f2_o, new, e1, ledb, 0, IF_BFP)
-    F(0xb345, LDXBR,   RRE,   Z,   0, x2_o, f1, 0, ldxb, 0, IF_BFP)
-    F(0xb346, LEXBR,   RRE,   Z,   0, x2_o, new, e1, lexb, 0, IF_BFP)
+    F(0xb344, LEDBR,   RRE,   Z,   0, f2, new, e1, ledb, 0, IF_BFP)
+    F(0xb345, LDXBR,   RRE,   Z,   x2l, x2h, new, f1, ldxb, 0, IF_BFP)
+    F(0xb346, LEXBR,   RRE,   Z,   x2l, x2h, new, e1, lexb, 0, IF_BFP)
 
 /* LOAD MULTIPLE */
     C(0x9800, LM,      RS_a,  Z,   0, a2, 0, 0, lm32, 0)
@@ -648,14 +648,14 @@
     C(0x5c00, M,       RX_a,  Z,   r1p1_32s, m2_32s, new, r1_D32, mul, 0)
     C(0xe35c, MFY,     RXY_a, GIE, r1p1_32s, m2_32s, new, r1_D32, mul, 0)
     F(0xb317, MEEBR,   RRE,   Z,   e1, e2, new, e1, meeb, 0, IF_BFP)
-    F(0xb31c, MDBR,    RRE,   Z,   f1_o, f2_o, f1, 0, mdb, 0, IF_BFP)
-    F(0xb34c, MXBR,    RRE,   Z,   0, x2_o, x1, 0, mxb, 0, IF_BFP)
-    F(0xb30c, MDEBR,   RRE,   Z,   f1_o, e2, f1, 0, mdeb, 0, IF_BFP)
-    F(0xb307, MXDBR,   RRE,   Z,   0, f2_o, x1, 0, mxdb, 0, IF_BFP)
+    F(0xb31c, MDBR,    RRE,   Z,   f1, f2, new, f1, mdb, 0, IF_BFP)
+    F(0xb34c, MXBR,    RRE,   Z,   x2l, x2h, x1, x1, mxb, 0, IF_BFP)
+    F(0xb30c, MDEBR,   RRE,   Z,   f1, e2, new, f1, mdeb, 0, IF_BFP)
+    F(0xb307, MXDBR,   RRE,   Z,   0, f2, x1, x1, mxdb, 0, IF_BFP)
     F(0xed17, MEEB,    RXE,   Z,   e1, m2_32u, new, e1, meeb, 0, IF_BFP)
-    F(0xed1c, MDB,     RXE,   Z,   f1_o, m2_64, f1, 0, mdb, 0, IF_BFP)
-    F(0xed0c, MDEB,    RXE,   Z,   f1_o, m2_32u, f1, 0, mdeb, 0, IF_BFP)
-    F(0xed07, MXDB,    RXE,   Z,   0, m2_64, x1, 0, mxdb, 0, IF_BFP)
+    F(0xed1c, MDB,     RXE,   Z,   f1, m2_64, new, f1, mdb, 0, IF_BFP)
+    F(0xed0c, MDEB,    RXE,   Z,   f1, m2_32u, new, f1, mdeb, 0, IF_BFP)
+    F(0xed07, MXDB,    RXE,   Z,   0, m2_64, x1, x1, mxdb, 0, IF_BFP)
 /* MULTIPLY HALFWORD */
     C(0x4c00, MH,      RX_a,  Z,   r1_o, m2_16s, new, r1_32, mul, 0)
     C(0xe37c, MHY,     RXY_a, GIE, r1_o, m2_16s, new, r1_32, mul, 0)
@@ -681,14 +681,14 @@
 
 /* MULTIPLY AND ADD */
     F(0xb30e, MAEBR,   RRD,   Z,   e1, e2, new, e1, maeb, 0, IF_BFP)
-    F(0xb31e, MADBR,   RRD,   Z,   f1_o, f2_o, f1, 0, madb, 0, IF_BFP)
+    F(0xb31e, MADBR,   RRD,   Z,   f1, f2, new, f1, madb, 0, IF_BFP)
     F(0xed0e, MAEB,    RXF,   Z,   e1, m2_32u, new, e1, maeb, 0, IF_BFP)
-    F(0xed1e, MADB,    RXF,   Z,   f1_o, m2_64, f1, 0, madb, 0, IF_BFP)
+    F(0xed1e, MADB,    RXF,   Z,   f1, m2_64, new, f1, madb, 0, IF_BFP)
 /* MULTIPLY AND SUBTRACT */
     F(0xb30f, MSEBR,   RRD,   Z,   e1, e2, new, e1, mseb, 0, IF_BFP)
-    F(0xb31f, MSDBR,   RRD,   Z,   f1_o, f2_o, f1, 0, msdb, 0, IF_BFP)
+    F(0xb31f, MSDBR,   RRD,   Z,   f1, f2, new, f1, msdb, 0, IF_BFP)
     F(0xed0f, MSEB,    RXF,   Z,   e1, m2_32u, new, e1, mseb, 0, IF_BFP)
-    F(0xed1f, MSDB,    RXF,   Z,   f1_o, m2_64, f1, 0, msdb, 0, IF_BFP)
+    F(0xed1f, MSDB,    RXF,   Z,   f1, m2_64, new, f1, msdb, 0, IF_BFP)
 
 /* OR */
     C(0x1600, OR,      RR_a,  Z,   r1, r2, new, r1_32, or, nz32)
@@ -793,17 +793,17 @@
 
 /* SQUARE ROOT */
     F(0xb314, SQEBR,   RRE,   Z,   0, e2, new, e1, sqeb, 0, IF_BFP)
-    F(0xb315, SQDBR,   RRE,   Z,   0, f2_o, f1, 0, sqdb, 0, IF_BFP)
-    F(0xb316, SQXBR,   RRE,   Z,   0, x2_o, x1, 0, sqxb, 0, IF_BFP)
+    F(0xb315, SQDBR,   RRE,   Z,   0, f2, new, f1, sqdb, 0, IF_BFP)
+    F(0xb316, SQXBR,   RRE,   Z,   x2l, x2h, new, x1, sqxb, 0, IF_BFP)
     F(0xed14, SQEB,    RXE,   Z,   0, m2_32u, new, e1, sqeb, 0, IF_BFP)
-    F(0xed15, SQDB,    RXE,   Z,   0, m2_64, f1, 0, sqdb, 0, IF_BFP)
+    F(0xed15, SQDB,    RXE,   Z,   0, m2_64, new, f1, sqdb, 0, IF_BFP)
 
 /* STORE */
     C(0x5000, ST,      RX_a,  Z,   r1_o, a2, 0, 0, st32, 0)
     C(0xe350, STY,     RXY_a, LD,  r1_o, a2, 0, 0, st32, 0)
     C(0xe324, STG,     RXY_a, Z,   r1_o, a2, 0, 0, st64, 0)
-    F(0x6000, STD,     RX_a,  Z,   f1_o, a2, 0, 0, st64, 0, IF_AFP1)
-    F(0xed67, STDY,    RXY_a, LD,  f1_o, a2, 0, 0, st64, 0, IF_AFP1)
+    F(0x6000, STD,     RX_a,  Z,   f1, a2, 0, 0, st64, 0, IF_AFP1)
+    F(0xed67, STDY,    RXY_a, LD,  f1, a2, 0, 0, st64, 0, IF_AFP1)
     F(0x7000, STE,     RX_a,  Z,   e1, a2, 0, 0, st32, 0, IF_AFP1)
     F(0xed66, STEY,    RXY_a, LD,  e1, a2, 0, 0, st32, 0, IF_AFP1)
 /* STORE RELATIVE LONG */
@@ -865,10 +865,10 @@
     C(0xe309, SG,      RXY_a, Z,   r1, m2_64, r1, 0, sub, subs64)
     C(0xe319, SGF,     RXY_a, Z,   r1, m2_32s, r1, 0, sub, subs64)
     F(0xb30b, SEBR,    RRE,   Z,   e1, e2, new, e1, seb, f32, IF_BFP)
-    F(0xb31b, SDBR,    RRE,   Z,   f1_o, f2_o, f1, 0, sdb, f64, IF_BFP)
-    F(0xb34b, SXBR,    RRE,   Z,   0, x2_o, x1, 0, sxb, f128, IF_BFP)
+    F(0xb31b, SDBR,    RRE,   Z,   f1, f2, new, f1, sdb, f64, IF_BFP)
+    F(0xb34b, SXBR,    RRE,   Z,   x2l, x2h, x1, x1, sxb, f128, IF_BFP)
     F(0xed0b, SEB,     RXE,   Z,   e1, m2_32u, new, e1, seb, f32, IF_BFP)
-    F(0xed1b, SDB,     RXE,   Z,   f1_o, m2_64, f1, 0, sdb, f64, IF_BFP)
+    F(0xed1b, SDB,     RXE,   Z,   f1, m2_64, new, f1, sdb, f64, IF_BFP)
 /* SUBTRACT HALFWORD */
     C(0x4b00, SH,      RX_a,  Z,   r1, m2_16s, new, r1_32, sub, subs32)
     C(0xe37b, SHY,     RXY_a, LD,  r1, m2_16s, new, r1_32, sub, subs32)
@@ -908,8 +908,8 @@
 
 /* TEST DATA CLASS */
     F(0xed10, TCEB,    RXE,   Z,   e1, a2, 0, 0, tceb, 0, IF_BFP)
-    F(0xed11, TCDB,    RXE,   Z,   f1_o, a2, 0, 0, tcdb, 0, IF_BFP)
-    F(0xed12, TCXB,    RXE,   Z,   x1_o, a2, 0, 0, tcxb, 0, IF_BFP)
+    F(0xed11, TCDB,    RXE,   Z,   f1, a2, 0, 0, tcdb, 0, IF_BFP)
+    F(0xed12, TCXB,    RXE,   Z,   0, a2, x1, 0, tcxb, 0, IF_BFP)
 
 /* TEST DECIMAL */
     C(0xebc0, TP,      RSL,   E2,  la1, 0, 0, 0, tp, 0)
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index b5bd56b7ee..13dee2800b 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -111,9 +111,8 @@ static TCGv_i64 cc_src;
 static TCGv_i64 cc_dst;
 static TCGv_i64 cc_vr;
 
-static char cpu_reg_names[32][4];
+static char cpu_reg_names[16][4];
 static TCGv_i64 regs[16];
-static TCGv_i64 fregs[16];
 
 void s390x_translate_init(void)
 {
@@ -144,13 +143,53 @@ void s390x_translate_init(void)
                                      offsetof(CPUS390XState, regs[i]),
                                      cpu_reg_names[i]);
     }
+}
 
-    for (i = 0; i < 16; i++) {
-        snprintf(cpu_reg_names[i + 16], sizeof(cpu_reg_names[0]), "f%d", i);
-        fregs[i] = tcg_global_mem_new(cpu_env,
-                                      offsetof(CPUS390XState, vregs[i][0].d),
-                                      cpu_reg_names[i + 16]);
-    }
+static inline int vec_reg_offset(uint8_t reg, uint8_t enr, TCGMemOp size)
+{
+    const uint8_t es = 1 << size;
+    int offs = enr * es;
+
+    g_assert(reg < 32);
+    /*
+     * vregs[n][0] is the lowest 8 byte and vregs[n][1] the highest 8 byte
+     * of the 16 byte vector, on both, little and big endian systems.
+     *
+     * Big Endian (target/possible host)
+     * B:  [ 0][ 1][ 2][ 3][ 4][ 5][ 6][ 7] - [ 8][ 9][10][11][12][13][14][15]
+     * HW: [     0][     1][     2][     3] - [     4][     5][     6][     7]
+     * W:  [             0][             1] - [             2][             3]
+     * DW: [                             0] - [                             1]
+     *
+     * Little Endian (possible host)
+     * B:  [ 7][ 6][ 5][ 4][ 3][ 2][ 1][ 0] - [15][14][13][12][11][10][ 9][ 8]
+     * HW: [     3][     2][     1][     0] - [     7][     6][     5][     4]
+     * W:  [             1][             0] - [             3][             2]
+     * DW: [                             0] - [                             1]
+     *
+     * For 16 byte elements, the two 8 byte halves will not form a host
+     * int128 if the host is little endian, since they're in the wrong order.
+     * Some operations (e.g. xor) do not care. For operations like addition,
+     * the two 8 byte elements have to be loaded separately. Let's force all
+     * 16 byte operations to handle it in a special way.
+     */
+    g_assert(size <= MO_64);
+#ifndef HOST_WORDS_BIGENDIAN
+    offs ^= (8 - es);
+#endif
+    return offs + offsetof(CPUS390XState, vregs[reg][0].d);
+}
+
+static inline int freg64_offset(uint8_t reg)
+{
+    g_assert(reg < 16);
+    return vec_reg_offset(reg, 0, MO_64);
+}
+
+static inline int freg32_offset(uint8_t reg)
+{
+    g_assert(reg < 16);
+    return vec_reg_offset(reg, 0, MO_32);
 }
 
 static TCGv_i64 load_reg(int reg)
@@ -160,10 +199,19 @@ static TCGv_i64 load_reg(int reg)
     return r;
 }
 
+static TCGv_i64 load_freg(int reg)
+{
+    TCGv_i64 r = tcg_temp_new_i64();
+
+    tcg_gen_ld_i64(r, cpu_env, freg64_offset(reg));
+    return r;
+}
+
 static TCGv_i64 load_freg32_i64(int reg)
 {
     TCGv_i64 r = tcg_temp_new_i64();
-    tcg_gen_shri_i64(r, fregs[reg], 32);
+
+    tcg_gen_ld32u_i64(r, cpu_env, freg32_offset(reg));
     return r;
 }
 
@@ -174,7 +222,7 @@ static void store_reg(int reg, TCGv_i64 v)
 
 static void store_freg(int reg, TCGv_i64 v)
 {
-    tcg_gen_mov_i64(fregs[reg], v);
+    tcg_gen_st_i64(v, cpu_env, freg64_offset(reg));
 }
 
 static void store_reg32_i64(int reg, TCGv_i64 v)
@@ -190,7 +238,7 @@ static void store_reg32h_i64(int reg, TCGv_i64 v)
 
 static void store_freg32_i64(int reg, TCGv_i64 v)
 {
-    tcg_gen_deposit_i64(fregs[reg], fregs[reg], v, 32, 32);
+    tcg_gen_st32_i64(v, cpu_env, freg32_offset(reg));
 }
 
 static void return_low128(TCGv_i64 dest)
@@ -3325,8 +3373,9 @@ static DisasJumpType op_maeb(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_madb(DisasContext *s, DisasOps *o)
 {
-    int r3 = get_field(s->fields, r3);
-    gen_helper_madb(o->out, cpu_env, o->in1, o->in2, fregs[r3]);
+    TCGv_i64 r3 = load_freg(get_field(s->fields, r3));
+    gen_helper_madb(o->out, cpu_env, o->in1, o->in2, r3);
+    tcg_temp_free_i64(r3);
     return DISAS_NEXT;
 }
 
@@ -3340,8 +3389,9 @@ static DisasJumpType op_mseb(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_msdb(DisasContext *s, DisasOps *o)
 {
-    int r3 = get_field(s->fields, r3);
-    gen_helper_msdb(o->out, cpu_env, o->in1, o->in2, fregs[r3]);
+    TCGv_i64 r3 = load_freg(get_field(s->fields, r3));
+    gen_helper_msdb(o->out, cpu_env, o->in1, o->in2, r3);
+    tcg_temp_free_i64(r3);
     return DISAS_NEXT;
 }
 
@@ -5085,19 +5135,11 @@ static void prep_r1_P(DisasContext *s, DisasFields *f, DisasOps *o)
 }
 #define SPEC_prep_r1_P SPEC_r1_even
 
-static void prep_f1(DisasContext *s, DisasFields *f, DisasOps *o)
-{
-    o->out = fregs[get_field(f, r1)];
-    o->g_out = true;
-}
-#define SPEC_prep_f1 0
-
+/* Whenever we need x1 in addition to other inputs, we'll load it to out/out2 */
 static void prep_x1(DisasContext *s, DisasFields *f, DisasOps *o)
 {
-    int r1 = get_field(f, r1);
-    o->out = fregs[r1];
-    o->out2 = fregs[r1 + 2];
-    o->g_out = o->g_out2 = true;
+    o->out = load_freg(get_field(f, r1));
+    o->out2 = load_freg(get_field(f, r1) + 2);
 }
 #define SPEC_prep_x1 SPEC_r1_f128
 
@@ -5393,28 +5435,23 @@ static void in1_e1(DisasContext *s, DisasFields *f, DisasOps *o)
 }
 #define SPEC_in1_e1 0
 
-static void in1_f1_o(DisasContext *s, DisasFields *f, DisasOps *o)
+static void in1_f1(DisasContext *s, DisasFields *f, DisasOps *o)
 {
-    o->in1 = fregs[get_field(f, r1)];
-    o->g_in1 = true;
+    o->in1 = load_freg(get_field(f, r1));
 }
-#define SPEC_in1_f1_o 0
+#define SPEC_in1_f1 0
 
-static void in1_x1_o(DisasContext *s, DisasFields *f, DisasOps *o)
+static void in1_x2l(DisasContext *s, DisasFields *f, DisasOps *o)
 {
-    int r1 = get_field(f, r1);
-    o->out = fregs[r1];
-    o->out2 = fregs[r1 + 2];
-    o->g_out = o->g_out2 = true;
+    o->in1 = load_freg(get_field(f, r2));
 }
-#define SPEC_in1_x1_o SPEC_r1_f128
+#define SPEC_in1_x2l SPEC_r2_f128
 
-static void in1_f3_o(DisasContext *s, DisasFields *f, DisasOps *o)
+static void in1_f3(DisasContext *s, DisasFields *f, DisasOps *o)
 {
-    o->in1 = fregs[get_field(f, r3)];
-    o->g_in1 = true;
+    o->in1 = load_freg(get_field(f, r3));
 }
-#define SPEC_in1_f3_o 0
+#define SPEC_in1_f3 0
 
 static void in1_la1(DisasContext *s, DisasFields *f, DisasOps *o)
 {
@@ -5599,21 +5636,17 @@ static void in2_e2(DisasContext *s, DisasFields *f, DisasOps *o)
 }
 #define SPEC_in2_e2 0
 
-static void in2_f2_o(DisasContext *s, DisasFields *f, DisasOps *o)
+static void in2_f2(DisasContext *s, DisasFields *f, DisasOps *o)
 {
-    o->in2 = fregs[get_field(f, r2)];
-    o->g_in2 = true;
+    o->in2 = load_freg(get_field(f, r2));
 }
-#define SPEC_in2_f2_o 0
+#define SPEC_in2_f2 0
 
-static void in2_x2_o(DisasContext *s, DisasFields *f, DisasOps *o)
+static void in2_x2h(DisasContext *s, DisasFields *f, DisasOps *o)
 {
-    int r2 = get_field(f, r2);
-    o->in1 = fregs[r2];
-    o->in2 = fregs[r2 + 2];
-    o->g_in1 = o->g_in2 = true;
+    o->in2 = load_freg(get_field(f, r2) + 2);
 }
-#define SPEC_in2_x2_o SPEC_r2_f128
+#define SPEC_in2_x2h SPEC_r2_f128
 
 static void in2_ra2(DisasContext *s, DisasFields *f, DisasOps *o)
 {
-- 
2.17.2
