Received: from eggs.gnu.org ([2001:4830:134:3::10]:35200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fsOAV-00022s-O7
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 04:07:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fsO1h-000116-0K
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 03:58:03 -0400
From: David Hildenbrand <david@redhat.com>
Date: Wed, 22 Aug 2018 09:57:46 +0200
Message-Id: <20180822075750.12399-5-david@redhat.com>
In-Reply-To: <20180822075750.12399-1-david@redhat.com>
References: <20180822075750.12399-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 4/8] s390x/tcg: add instruction flags for
 floating point instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>

These flags allow us to later on detect if a DATA program interrupt
is to be injected, and which DXC (1,2,3) is to be used.

Interestingly, some support FP instructions are considered as HFP
instructions (I assume simply because they were available very early).

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/insn-data.def | 254 ++++++++++++++++++-------------------
 target/s390x/translate.c   |   8 ++
 2 files changed, 135 insertions(+), 127 deletions(-)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index ff4a6ceaf5..506c3de1d7 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -32,11 +32,11 @@
     C(0xb9e8, AGRK,    RRF_a, DO,  r2, r3, r1, 0, add, adds64)
     C(0xe308, AG,      RXY_a, Z,   r1, m2_64, r1, 0, add, adds64)
     C(0xe318, AGF,     RXY_a, Z,   r1, m2_32s, r1, 0, add, adds64)
-    C(0xb30a, AEBR,    RRE,   Z,   e1, e2, new, e1, aeb, f32)
-    C(0xb31a, ADBR,    RRE,   Z,   f1_o, f2_o, f1, 0, adb, f64)
-    C(0xb34a, AXBR,    RRE,   Z,   0, x2_o, x1, 0, axb, f128)
-    C(0xed0a, AEB,     RXE,   Z,   e1, m2_32u, new, e1, aeb, f32)
-    C(0xed1a, ADB,     RXE,   Z,   f1_o, m2_64, f1, 0, adb, f64)
+    F(0xb30a, AEBR,    RRE,   Z,   e1, e2, new, e1, aeb, f32, IF_BFP)
+    F(0xb31a, ADBR,    RRE,   Z,   f1_o, f2_o, f1, 0, adb, f64, IF_BFP)
+    F(0xb34a, AXBR,    RRE,   Z,   0, x2_o, x1, 0, axb, f128, IF_BFP)
+    F(0xed0a, AEB,     RXE,   Z,   e1, m2_32u, new, e1, aeb, f32, IF_BFP)
+    F(0xed1a, ADB,     RXE,   Z,   f1_o, m2_64, f1, 0, adb, f64, IF_BFP)
 /* ADD HIGH */
     C(0xb9c8, AHHHR,   RRF_a, HW,  r2_sr32, r3_sr32, new, r1_32h, add, adds32)
     C(0xb9d8, AHHLR,   RRF_a, HW,  r2_sr32, r3, new, r1_32h, add, adds32)
@@ -151,7 +151,7 @@
     C(0xb241, CKSM,    RRE,   Z,   r1_o, ra2, new, r1_32, cksm, 0)
 
 /* COPY SIGN */
-    C(0xb372, CPSDR,   RRF_b, FPSSH, f3_o, f2_o, f1, 0, cps, 0)
+    F(0xb372, CPSDR,   RRF_b, FPSSH, f3_o, f2_o, f1, 0, cps, 0, IF_HFP1 | IF_HFP2 | IF_HFP3)
 
 /* COMPARE */
     C(0x1900, CR,      RR_a,  Z,   r1_o, r2_o, 0, 0, 0, cmps32)
@@ -161,17 +161,17 @@
     C(0xb930, CGFR,    RRE,   Z,   r1_o, r2_32s, 0, 0, 0, cmps64)
     C(0xe320, CG,      RXY_a, Z,   r1_o, m2_64, 0, 0, 0, cmps64)
     C(0xe330, CGF,     RXY_a, Z,   r1_o, m2_32s, 0, 0, 0, cmps64)
-    C(0xb309, CEBR,    RRE,   Z,   e1, e2, 0, 0, ceb, 0)
-    C(0xb319, CDBR,    RRE,   Z,   f1_o, f2_o, 0, 0, cdb, 0)
-    C(0xb349, CXBR,    RRE,   Z,   x1_o, x2_o, 0, 0, cxb, 0)
-    C(0xed09, CEB,     RXE,   Z,   e1, m2_32u, 0, 0, ceb, 0)
-    C(0xed19, CDB,     RXE,   Z,   f1_o, m2_64, 0, 0, cdb, 0)
+    F(0xb309, CEBR,    RRE,   Z,   e1, e2, 0, 0, ceb, 0, IF_BFP)
+    F(0xb319, CDBR,    RRE,   Z,   f1_o, f2_o, 0, 0, cdb, 0, IF_BFP)
+    F(0xb349, CXBR,    RRE,   Z,   x1_o, x2_o, 0, 0, cxb, 0, IF_BFP)
+    F(0xed09, CEB,     RXE,   Z,   e1, m2_32u, 0, 0, ceb, 0, IF_BFP)
+    F(0xed19, CDB,     RXE,   Z,   f1_o, m2_64, 0, 0, cdb, 0, IF_BFP)
 /* COMPARE AND SIGNAL */
-    C(0xb308, KEBR,    RRE,   Z,   e1, e2, 0, 0, keb, 0)
-    C(0xb318, KDBR,    RRE,   Z,   f1_o, f2_o, 0, 0, kdb, 0)
-    C(0xb348, KXBR,    RRE,   Z,   x1_o, x2_o, 0, 0, kxb, 0)
-    C(0xed08, KEB,     RXE,   Z,   e1, m2_32u, 0, 0, keb, 0)
-    C(0xed18, KDB,     RXE,   Z,   f1_o, m2_64, 0, 0, kdb, 0)
+    F(0xb308, KEBR,    RRE,   Z,   e1, e2, 0, 0, keb, 0, IF_BFP)
+    F(0xb318, KDBR,    RRE,   Z,   f1_o, f2_o, 0, 0, kdb, 0, IF_BFP)
+    F(0xb348, KXBR,    RRE,   Z,   x1_o, x2_o, 0, 0, kxb, 0, IF_BFP)
+    F(0xed08, KEB,     RXE,   Z,   e1, m2_32u, 0, 0, keb, 0, IF_BFP)
+    F(0xed18, KDB,     RXE,   Z,   f1_o, m2_64, 0, 0, kdb, 0, IF_BFP)
 /* COMPARE IMMEDIATE */
     C(0xc20d, CFI,     RIL_a, EI,  r1, i2, 0, 0, 0, cmps32)
     C(0xc20c, CGFI,    RIL_a, EI,  r1, i2, 0, 0, 0, cmps64)
@@ -288,33 +288,33 @@
     C(0x4e00, CVD,     RX_a,  Z,   r1_o, a2, 0, 0, cvd, 0)
     C(0xe326, CVDY,    RXY_a, LD,  r1_o, a2, 0, 0, cvd, 0)
 /* CONVERT TO FIXED */
-    C(0xb398, CFEBR,   RRF_e, Z,   0, e2, new, r1_32, cfeb, 0)
-    C(0xb399, CFDBR,   RRF_e, Z,   0, f2_o, new, r1_32, cfdb, 0)
-    C(0xb39a, CFXBR,   RRF_e, Z,   0, x2_o, new, r1_32, cfxb, 0)
-    C(0xb3a8, CGEBR,   RRF_e, Z,   0, e2, r1, 0, cgeb, 0)
-    C(0xb3a9, CGDBR,   RRF_e, Z,   0, f2_o, r1, 0, cgdb, 0)
-    C(0xb3aa, CGXBR,   RRF_e, Z,   0, x2_o, r1, 0, cgxb, 0)
+    F(0xb398, CFEBR,   RRF_e, Z,   0, e2, new, r1_32, cfeb, 0, IF_BFP)
+    F(0xb399, CFDBR,   RRF_e, Z,   0, f2_o, new, r1_32, cfdb, 0, IF_BFP)
+    F(0xb39a, CFXBR,   RRF_e, Z,   0, x2_o, new, r1_32, cfxb, 0, IF_BFP)
+    F(0xb3a8, CGEBR,   RRF_e, Z,   0, e2, r1, 0, cgeb, 0, IF_BFP)
+    F(0xb3a9, CGDBR,   RRF_e, Z,   0, f2_o, r1, 0, cgdb, 0, IF_BFP)
+    F(0xb3aa, CGXBR,   RRF_e, Z,   0, x2_o, r1, 0, cgxb, 0, IF_BFP)
 /* CONVERT FROM FIXED */
-    C(0xb394, CEFBR,   RRF_e, Z,   0, r2_32s, new, e1, cegb, 0)
-    C(0xb395, CDFBR,   RRF_e, Z,   0, r2_32s, f1, 0, cdgb, 0)
-    C(0xb396, CXFBR,   RRF_e, Z,   0, r2_32s, x1, 0, cxgb, 0)
-    C(0xb3a4, CEGBR,   RRF_e, Z,   0, r2_o, new, e1, cegb, 0)
-    C(0xb3a5, CDGBR,   RRF_e, Z,   0, r2_o, f1, 0, cdgb, 0)
-    C(0xb3a6, CXGBR,   RRF_e, Z,   0, r2_o, x1, 0, cxgb, 0)
+    F(0xb394, CEFBR,   RRF_e, Z,   0, r2_32s, new, e1, cegb, 0, IF_BFP)
+    F(0xb395, CDFBR,   RRF_e, Z,   0, r2_32s, f1, 0, cdgb, 0, IF_BFP)
+    F(0xb396, CXFBR,   RRF_e, Z,   0, r2_32s, x1, 0, cxgb, 0, IF_BFP)
+    F(0xb3a4, CEGBR,   RRF_e, Z,   0, r2_o, new, e1, cegb, 0, IF_BFP)
+    F(0xb3a5, CDGBR,   RRF_e, Z,   0, r2_o, f1, 0, cdgb, 0, IF_BFP)
+    F(0xb3a6, CXGBR,   RRF_e, Z,   0, r2_o, x1, 0, cxgb, 0, IF_BFP)
 /* CONVERT TO LOGICAL */
-    C(0xb39c, CLFEBR,  RRF_e, FPE, 0, e2, new, r1_32, clfeb, 0)
-    C(0xb39d, CLFDBR,  RRF_e, FPE, 0, f2_o, new, r1_32, clfdb, 0)
-    C(0xb39e, CLFXBR,  RRF_e, FPE, 0, x2_o, new, r1_32, clfxb, 0)
-    C(0xb3ac, CLGEBR,  RRF_e, FPE, 0, e2, r1, 0, clgeb, 0)
-    C(0xb3ad, CLGDBR,  RRF_e, FPE, 0, f2_o, r1, 0, clgdb, 0)
-    C(0xb3ae, CLGXBR,  RRF_e, FPE, 0, x2_o, r1, 0, clgxb, 0)
+    F(0xb39c, CLFEBR,  RRF_e, FPE, 0, e2, new, r1_32, clfeb, 0, IF_BFP)
+    F(0xb39d, CLFDBR,  RRF_e, FPE, 0, f2_o, new, r1_32, clfdb, 0, IF_BFP)
+    F(0xb39e, CLFXBR,  RRF_e, FPE, 0, x2_o, new, r1_32, clfxb, 0, IF_BFP)
+    F(0xb3ac, CLGEBR,  RRF_e, FPE, 0, e2, r1, 0, clgeb, 0, IF_BFP)
+    F(0xb3ad, CLGDBR,  RRF_e, FPE, 0, f2_o, r1, 0, clgdb, 0, IF_BFP)
+    F(0xb3ae, CLGXBR,  RRF_e, FPE, 0, x2_o, r1, 0, clgxb, 0, IF_BFP)
 /* CONVERT FROM LOGICAL */
-    C(0xb390, CELFBR,  RRF_e, FPE, 0, r2_32u, new, e1, celgb, 0)
-    C(0xb391, CDLFBR,  RRF_e, FPE, 0, r2_32u, f1, 0, cdlgb, 0)
-    C(0xb392, CXLFBR,  RRF_e, FPE, 0, r2_32u, x1, 0, cxlgb, 0)
-    C(0xb3a0, CELGBR,  RRF_e, FPE, 0, r2_o, new, e1, celgb, 0)
-    C(0xb3a1, CDLGBR,  RRF_e, FPE, 0, r2_o, f1, 0, cdlgb, 0)
-    C(0xb3a2, CXLGBR,  RRF_e, FPE, 0, r2_o, x1, 0, cxlgb, 0)
+    F(0xb390, CELFBR,  RRF_e, FPE, 0, r2_32u, new, e1, celgb, 0, IF_BFP)
+    F(0xb391, CDLFBR,  RRF_e, FPE, 0, r2_32u, f1, 0, cdlgb, 0, IF_BFP)
+    F(0xb392, CXLFBR,  RRF_e, FPE, 0, r2_32u, x1, 0, cxlgb, 0, IF_BFP)
+    F(0xb3a0, CELGBR,  RRF_e, FPE, 0, r2_o, new, e1, celgb, 0, IF_BFP)
+    F(0xb3a1, CDLGBR,  RRF_e, FPE, 0, r2_o, f1, 0, cdlgb, 0, IF_BFP)
+    F(0xb3a2, CXLGBR,  RRF_e, FPE, 0, r2_o, x1, 0, cxlgb, 0, IF_BFP)
 
 /* CONVERT UTF-8 TO UTF-16 */
     D(0xb2a7, CU12,    RRF_c, Z,   0, 0, 0, 0, cuXX, 0, 12)
@@ -332,11 +332,11 @@
 /* DIVIDE */
     C(0x1d00, DR,      RR_a,  Z,   r1_D32, r2_32s, new_P, r1_P32, divs32, 0)
     C(0x5d00, D,       RX_a,  Z,   r1_D32, m2_32s, new_P, r1_P32, divs32, 0)
-    C(0xb30d, DEBR,    RRE,   Z,   e1, e2, new, e1, deb, 0)
-    C(0xb31d, DDBR,    RRE,   Z,   f1_o, f2_o, f1, 0, ddb, 0)
-    C(0xb34d, DXBR,    RRE,   Z,   0, x2_o, x1, 0, dxb, 0)
-    C(0xed0d, DEB,     RXE,   Z,   e1, m2_32u, new, e1, deb, 0)
-    C(0xed1d, DDB,     RXE,   Z,   f1_o, m2_64, f1, 0, ddb, 0)
+    F(0xb30d, DEBR,    RRE,   Z,   e1, e2, new, e1, deb, 0, IF_BFP)
+    F(0xb31d, DDBR,    RRE,   Z,   f1_o, f2_o, f1, 0, ddb, 0, IF_BFP)
+    F(0xb34d, DXBR,    RRE,   Z,   0, x2_o, x1, 0, dxb, 0, IF_BFP)
+    F(0xed0d, DEB,     RXE,   Z,   e1, m2_32u, new, e1, deb, 0, IF_BFP)
+    F(0xed1d, DDB,     RXE,   Z,   f1_o, m2_64, f1, 0, ddb, 0, IF_BFP)
 /* DIVIDE LOGICAL */
     C(0xb997, DLR,     RRE,   Z,   r1_D32, r2_32u, new_P, r1_P32, divu32, 0)
     C(0xe397, DL,      RXY_a, Z,   r1_D32, m2_32u, new_P, r1_P32, divu32, 0)
@@ -375,7 +375,7 @@
 /* EXTRACT CPU TIME */
     C(0xc801, ECTG,    SSF,   ECT, 0, 0, 0, 0, ectg, 0)
 /* EXTRACT FPC */
-    C(0xb38c, EFPC,    RRE,   Z,   0, 0, new, r1_32, efpc, 0)
+    F(0xb38c, EFPC,    RRE,   Z,   0, 0, new, r1_32, efpc, 0, IF_BFP)
 /* EXTRACT PSW */
     C(0xb98d, EPSW,    RRE,   Z,   0, 0, 0, 0, epsw, 0)
 
@@ -407,13 +407,13 @@
     C(0xb914, LGFR,    RRE,   Z,   0, r2_32s, 0, r1, mov2, 0)
     C(0xe304, LG,      RXY_a, Z,   0, a2, r1, 0, ld64, 0)
     C(0xe314, LGF,     RXY_a, Z,   0, a2, r1, 0, ld32s, 0)
-    C(0x2800, LDR,     RR_a,  Z,   0, f2_o, 0, f1, mov2, 0)
-    C(0x6800, LD,      RX_a,  Z,   0, m2_64, 0, f1, mov2, 0)
-    C(0xed65, LDY,     RXY_a, LD,  0, m2_64, 0, f1, mov2, 0)
-    C(0x3800, LER,     RR_a,  Z,   0, e2, 0, cond_e1e2, mov2, 0)
-    C(0x7800, LE,      RX_a,  Z,   0, m2_32u, 0, e1, mov2, 0)
-    C(0xed64, LEY,     RXY_a, LD,  0, m2_32u, 0, e1, mov2, 0)
-    C(0xb365, LXR,     RRE,   Z,   0, x2_o, 0, x1, movx, 0)
+    F(0x2800, LDR,     RR_a,  Z,   0, f2_o, 0, f1, mov2, 0, IF_HFP1 | IF_HFP2)
+    F(0x6800, LD,      RX_a,  Z,   0, m2_64, 0, f1, mov2, 0, IF_HFP1)
+    F(0xed65, LDY,     RXY_a, LD,  0, m2_64, 0, f1, mov2, 0, IF_HFP1)
+    F(0x3800, LER,     RR_a,  Z,   0, e2, 0, cond_e1e2, mov2, 0, IF_HFP1 | IF_HFP2)
+    F(0x7800, LE,      RX_a,  Z,   0, m2_32u, 0, e1, mov2, 0, IF_HFP1)
+    F(0xed64, LEY,     RXY_a, LD,  0, m2_32u, 0, e1, mov2, 0, IF_HFP1)
+    F(0xb365, LXR,     RRE,   Z,   0, x2_o, 0, x1, movx, 0, IF_HFP1)
 /* LOAD IMMEDIATE */
     C(0xc001, LGFI,    RIL_a, EI,  0, i2, 0, r1, mov2, 0)
 /* LOAD RELATIVE LONG */
@@ -450,9 +450,9 @@
     C(0xe312, LT,      RXY_a, EI,  0, a2, new, r1_32, ld32s, s64)
     C(0xe302, LTG,     RXY_a, EI,  0, a2, r1, 0, ld64, s64)
     C(0xe332, LTGF,    RXY_a, GIE, 0, a2, r1, 0, ld32s, s64)
-    C(0xb302, LTEBR,   RRE,   Z,   0, e2, 0, cond_e1e2, mov2, f32)
-    C(0xb312, LTDBR,   RRE,   Z,   0, f2_o, 0, f1, mov2, f64)
-    C(0xb342, LTXBR,   RRE,   Z,   0, x2_o, 0, x1, movx, f128)
+    F(0xb302, LTEBR,   RRE,   Z,   0, e2, 0, cond_e1e2, mov2, f32, IF_BFP)
+    F(0xb312, LTDBR,   RRE,   Z,   0, f2_o, 0, f1, mov2, f64, IF_BFP)
+    F(0xb342, LTXBR,   RRE,   Z,   0, x2_o, 0, x1, movx, f128, IF_BFP)
 /* LOAD AND TRAP */
     C(0xe39f, LAT,     RXY_a, LAT, 0, m2_32u, r1, 0, lat, 0)
     C(0xe385, LGAT,    RXY_a, LAT, 0, a2, r1, 0, lgat, 0)
@@ -472,10 +472,10 @@
     C(0x1300, LCR,     RR_a,  Z,   0, r2, new, r1_32, neg, neg32)
     C(0xb903, LCGR,    RRE,   Z,   0, r2, r1, 0, neg, neg64)
     C(0xb913, LCGFR,   RRE,   Z,   0, r2_32s, r1, 0, neg, neg64)
-    C(0xb303, LCEBR,   RRE,   Z,   0, e2, new, e1, negf32, f32)
-    C(0xb313, LCDBR,   RRE,   Z,   0, f2_o, f1, 0, negf64, f64)
-    C(0xb343, LCXBR,   RRE,   Z,   0, x2_o, x1, 0, negf128, f128)
-    C(0xb373, LCDFR,   RRE,   FPSSH, 0, f2_o, f1, 0, negf64, 0)
+    F(0xb303, LCEBR,   RRE,   Z,   0, e2, new, e1, negf32, f32, IF_BFP)
+    F(0xb313, LCDBR,   RRE,   Z,   0, f2_o, f1, 0, negf64, f64, IF_BFP)
+    F(0xb343, LCXBR,   RRE,   Z,   0, x2_o, x1, 0, negf128, f128, IF_BFP)
+    F(0xb373, LCDFR,   RRE,   FPSSH, 0, f2_o, f1, 0, negf64, 0, IF_HFP1 | IF_HFP2)
 /* LOAD HALFWORD */
     C(0xb927, LHR,     RRE,   EI,  0, r2_16s, 0, r1_32, mov2, 0)
     C(0xb907, LGHR,    RRE,   EI,  0, r2_16s, 0, r1, mov2, 0)
@@ -532,17 +532,17 @@
     C(0xe39c, LLGTAT,  RXY_a, LAT, 0, m2_32u, r1, 0, llgtat, 0)
 
 /* LOAD FPR FROM GR */
-    C(0xb3c1, LDGR,    RRE,   FPRGR, 0, r2_o, 0, f1, mov2, 0)
+    F(0xb3c1, LDGR,    RRE,   FPRGR, 0, r2_o, 0, f1, mov2, 0, IF_HFP1)
 /* LOAD GR FROM FPR */
-    C(0xb3cd, LGDR,    RRE,   FPRGR, 0, f2_o, 0, r1, mov2, 0)
+    F(0xb3cd, LGDR,    RRE,   FPRGR, 0, f2_o, 0, r1, mov2, 0, IF_HFP2)
 /* LOAD NEGATIVE */
     C(0x1100, LNR,     RR_a,  Z,   0, r2_32s, new, r1_32, nabs, nabs32)
     C(0xb901, LNGR,    RRE,   Z,   0, r2, r1, 0, nabs, nabs64)
     C(0xb911, LNGFR,   RRE,   Z,   0, r2_32s, r1, 0, nabs, nabs64)
-    C(0xb301, LNEBR,   RRE,   Z,   0, e2, new, e1, nabsf32, f32)
-    C(0xb311, LNDBR,   RRE,   Z,   0, f2_o, f1, 0, nabsf64, f64)
-    C(0xb341, LNXBR,   RRE,   Z,   0, x2_o, x1, 0, nabsf128, f128)
-    C(0xb371, LNDFR,   RRE,   FPSSH, 0, f2_o, f1, 0, nabsf64, 0)
+    F(0xb301, LNEBR,   RRE,   Z,   0, e2, new, e1, nabsf32, f32, IF_BFP)
+    F(0xb311, LNDBR,   RRE,   Z,   0, f2_o, f1, 0, nabsf64, f64, IF_BFP)
+    F(0xb341, LNXBR,   RRE,   Z,   0, x2_o, x1, 0, nabsf128, f128, IF_BFP)
+    F(0xb371, LNDFR,   RRE,   FPSSH, 0, f2_o, f1, 0, nabsf64, 0, IF_HFP1 | IF_HFP2)
 /* LOAD ON CONDITION */
     C(0xb9f2, LOCR,    RRF_c, LOC, r1, r2, new, r1_32, loc, 0)
     C(0xb9e2, LOCGR,   RRF_c, LOC, r1, r2, r1, 0, loc, 0)
@@ -564,10 +564,10 @@
     C(0x1000, LPR,     RR_a,  Z,   0, r2_32s, new, r1_32, abs, abs32)
     C(0xb900, LPGR,    RRE,   Z,   0, r2, r1, 0, abs, abs64)
     C(0xb910, LPGFR,   RRE,   Z,   0, r2_32s, r1, 0, abs, abs64)
-    C(0xb300, LPEBR,   RRE,   Z,   0, e2, new, e1, absf32, f32)
-    C(0xb310, LPDBR,   RRE,   Z,   0, f2_o, f1, 0, absf64, f64)
-    C(0xb340, LPXBR,   RRE,   Z,   0, x2_o, x1, 0, absf128, f128)
-    C(0xb370, LPDFR,   RRE,   FPSSH, 0, f2_o, f1, 0, absf64, 0)
+    F(0xb300, LPEBR,   RRE,   Z,   0, e2, new, e1, absf32, f32, IF_BFP)
+    F(0xb310, LPDBR,   RRE,   Z,   0, f2_o, f1, 0, absf64, f64, IF_BFP)
+    F(0xb340, LPXBR,   RRE,   Z,   0, x2_o, x1, 0, absf128, f128, IF_BFP)
+    F(0xb370, LPDFR,   RRE,   FPSSH, 0, f2_o, f1, 0, absf64, 0, IF_HFP1 | IF_HFP2)
 /* LOAD REVERSED */
     C(0xb91f, LRVR,    RRE,   Z,   0, r2_32u, new, r1_32, rev32, 0)
     C(0xb90f, LRVGR,   RRE,   Z,   0, r2_o, r1, 0, rev64, 0)
@@ -575,30 +575,30 @@
     C(0xe31e, LRV,     RXY_a, Z,   0, m2_32u, new, r1_32, rev32, 0)
     C(0xe30f, LRVG,    RXY_a, Z,   0, m2_64, r1, 0, rev64, 0)
 /* LOAD ZERO */
-    C(0xb374, LZER,    RRE,   Z,   0, 0, 0, e1, zero, 0)
-    C(0xb375, LZDR,    RRE,   Z,   0, 0, 0, f1, zero, 0)
-    C(0xb376, LZXR,    RRE,   Z,   0, 0, 0, x1, zero2, 0)
+    F(0xb374, LZER,    RRE,   Z,   0, 0, 0, e1, zero, 0, IF_HFP1)
+    F(0xb375, LZDR,    RRE,   Z,   0, 0, 0, f1, zero, 0, IF_HFP1)
+    F(0xb376, LZXR,    RRE,   Z,   0, 0, 0, x1, zero2, 0, IF_HFP1)
 
 /* LOAD FPC */
-    C(0xb29d, LFPC,    S,     Z,   0, m2_32u, 0, 0, sfpc, 0)
+    F(0xb29d, LFPC,    S,     Z,   0, m2_32u, 0, 0, sfpc, 0, IF_BFP)
 /* LOAD FPC AND SIGNAL */
-    C(0xb2bd, LFAS,    S,     IEEEE_SIM, 0, m2_32u, 0, 0, sfas, 0)
+    F(0xb2bd, LFAS,    S,     IEEEE_SIM, 0, m2_32u, 0, 0, sfas, 0, IF_DFP)
 /* LOAD FP INTEGER */
-    C(0xb357, FIEBR,   RRF_e, Z,   0, e2, new, e1, fieb, 0)
-    C(0xb35f, FIDBR,   RRF_e, Z,   0, f2_o, f1, 0, fidb, 0)
-    C(0xb347, FIXBR,   RRF_e, Z,   0, x2_o, x1, 0, fixb, 0)
+    F(0xb357, FIEBR,   RRF_e, Z,   0, e2, new, e1, fieb, 0, IF_BFP)
+    F(0xb35f, FIDBR,   RRF_e, Z,   0, f2_o, f1, 0, fidb, 0, IF_BFP)
+    F(0xb347, FIXBR,   RRF_e, Z,   0, x2_o, x1, 0, fixb, 0, IF_BFP)
 
 /* LOAD LENGTHENED */
-    C(0xb304, LDEBR,   RRE,   Z,   0, e2, f1, 0, ldeb, 0)
-    C(0xb305, LXDBR,   RRE,   Z,   0, f2_o, x1, 0, lxdb, 0)
-    C(0xb306, LXEBR,   RRE,   Z,   0, e2, x1, 0, lxeb, 0)
-    C(0xed04, LDEB,    RXE,   Z,   0, m2_32u, f1, 0, ldeb, 0)
-    C(0xed05, LXDB,    RXE,   Z,   0, m2_64, x1, 0, lxdb, 0)
-    C(0xed06, LXEB,    RXE,   Z,   0, m2_32u, x1, 0, lxeb, 0)
+    F(0xb304, LDEBR,   RRE,   Z,   0, e2, f1, 0, ldeb, 0, IF_BFP)
+    F(0xb305, LXDBR,   RRE,   Z,   0, f2_o, x1, 0, lxdb, 0, IF_BFP)
+    F(0xb306, LXEBR,   RRE,   Z,   0, e2, x1, 0, lxeb, 0, IF_BFP)
+    F(0xed04, LDEB,    RXE,   Z,   0, m2_32u, f1, 0, ldeb, 0, IF_BFP)
+    F(0xed05, LXDB,    RXE,   Z,   0, m2_64, x1, 0, lxdb, 0, IF_BFP)
+    F(0xed06, LXEB,    RXE,   Z,   0, m2_32u, x1, 0, lxeb, 0, IF_BFP)
 /* LOAD ROUNDED */
-    C(0xb344, LEDBR,   RRE,   Z,   0, f2_o, new, e1, ledb, 0)
-    C(0xb345, LDXBR,   RRE,   Z,   0, x2_o, f1, 0, ldxb, 0)
-    C(0xb346, LEXBR,   RRE,   Z,   0, x2_o, new, e1, lexb, 0)
+    F(0xb344, LEDBR,   RRE,   Z,   0, f2_o, new, e1, ledb, 0, IF_BFP)
+    F(0xb345, LDXBR,   RRE,   Z,   0, x2_o, f1, 0, ldxb, 0, IF_BFP)
+    F(0xb346, LEXBR,   RRE,   Z,   0, x2_o, new, e1, lexb, 0, IF_BFP)
 
 /* LOAD MULTIPLE */
     C(0x9800, LM,      RS_a,  Z,   0, a2, 0, 0, lm32, 0)
@@ -644,15 +644,15 @@
     C(0x1c00, MR,      RR_a,  Z,   r1p1_32s, r2_32s, new, r1_D32, mul, 0)
     C(0x5c00, M,       RX_a,  Z,   r1p1_32s, m2_32s, new, r1_D32, mul, 0)
     C(0xe35c, MFY,     RXY_a, GIE, r1p1_32s, m2_32s, new, r1_D32, mul, 0)
-    C(0xb317, MEEBR,   RRE,   Z,   e1, e2, new, e1, meeb, 0)
-    C(0xb31c, MDBR,    RRE,   Z,   f1_o, f2_o, f1, 0, mdb, 0)
-    C(0xb34c, MXBR,    RRE,   Z,   0, x2_o, x1, 0, mxb, 0)
-    C(0xb30c, MDEBR,   RRE,   Z,   f1_o, e2, f1, 0, mdeb, 0)
-    C(0xb307, MXDBR,   RRE,   Z,   0, f2_o, x1, 0, mxdb, 0)
-    C(0xed17, MEEB,    RXE,   Z,   e1, m2_32u, new, e1, meeb, 0)
-    C(0xed1c, MDB,     RXE,   Z,   f1_o, m2_64, f1, 0, mdb, 0)
-    C(0xed0c, MDEB,    RXE,   Z,   f1_o, m2_32u, f1, 0, mdeb, 0)
-    C(0xed07, MXDB,    RXE,   Z,   0, m2_64, x1, 0, mxdb, 0)
+    F(0xb317, MEEBR,   RRE,   Z,   e1, e2, new, e1, meeb, 0, IF_BFP)
+    F(0xb31c, MDBR,    RRE,   Z,   f1_o, f2_o, f1, 0, mdb, 0, IF_BFP)
+    F(0xb34c, MXBR,    RRE,   Z,   0, x2_o, x1, 0, mxb, 0, IF_BFP)
+    F(0xb30c, MDEBR,   RRE,   Z,   f1_o, e2, f1, 0, mdeb, 0, IF_BFP)
+    F(0xb307, MXDBR,   RRE,   Z,   0, f2_o, x1, 0, mxdb, 0, IF_BFP)
+    F(0xed17, MEEB,    RXE,   Z,   e1, m2_32u, new, e1, meeb, 0, IF_BFP)
+    F(0xed1c, MDB,     RXE,   Z,   f1_o, m2_64, f1, 0, mdb, 0, IF_BFP)
+    F(0xed0c, MDEB,    RXE,   Z,   f1_o, m2_32u, f1, 0, mdeb, 0, IF_BFP)
+    F(0xed07, MXDB,    RXE,   Z,   0, m2_64, x1, 0, mxdb, 0, IF_BFP)
 /* MULTIPLY HALFWORD */
     C(0x4c00, MH,      RX_a,  Z,   r1_o, m2_16s, new, r1_32, mul, 0)
     C(0xe37c, MHY,     RXY_a, GIE, r1_o, m2_16s, new, r1_32, mul, 0)
@@ -677,15 +677,15 @@
     C(0xc200, MSGFI,   RIL_a, GIE, r1_o, i2, r1, 0, mul, 0)
 
 /* MULTIPLY AND ADD */
-    C(0xb30e, MAEBR,   RRD,   Z,   e1, e2, new, e1, maeb, 0)
-    C(0xb31e, MADBR,   RRD,   Z,   f1_o, f2_o, f1, 0, madb, 0)
-    C(0xed0e, MAEB,    RXF,   Z,   e1, m2_32u, new, e1, maeb, 0)
-    C(0xed1e, MADB,    RXF,   Z,   f1_o, m2_64, f1, 0, madb, 0)
+    F(0xb30e, MAEBR,   RRD,   Z,   e1, e2, new, e1, maeb, 0, IF_BFP)
+    F(0xb31e, MADBR,   RRD,   Z,   f1_o, f2_o, f1, 0, madb, 0, IF_BFP)
+    F(0xed0e, MAEB,    RXF,   Z,   e1, m2_32u, new, e1, maeb, 0, IF_BFP)
+    F(0xed1e, MADB,    RXF,   Z,   f1_o, m2_64, f1, 0, madb, 0, IF_BFP)
 /* MULTIPLY AND SUBTRACT */
-    C(0xb30f, MSEBR,   RRD,   Z,   e1, e2, new, e1, mseb, 0)
-    C(0xb31f, MSDBR,   RRD,   Z,   f1_o, f2_o, f1, 0, msdb, 0)
-    C(0xed0f, MSEB,    RXF,   Z,   e1, m2_32u, new, e1, mseb, 0)
-    C(0xed1f, MSDB,    RXF,   Z,   f1_o, m2_64, f1, 0, msdb, 0)
+    F(0xb30f, MSEBR,   RRD,   Z,   e1, e2, new, e1, mseb, 0, IF_BFP)
+    F(0xb31f, MSDBR,   RRD,   Z,   f1_o, f2_o, f1, 0, msdb, 0, IF_BFP)
+    F(0xed0f, MSEB,    RXF,   Z,   e1, m2_32u, new, e1, mseb, 0, IF_BFP)
+    F(0xed1f, MSDB,    RXF,   Z,   f1_o, m2_64, f1, 0, msdb, 0, IF_BFP)
 
 /* OR */
     C(0x1600, OR,      RR_a,  Z,   r1, r2, new, r1_32, or, nz32)
@@ -752,14 +752,14 @@
     D(0x010d, SAM31,   E,     Z,   0, 0, 0, 0, sam, 0, 1)
     D(0x010e, SAM64,   E,     Z,   0, 0, 0, 0, sam, 0, 3)
 /* SET FPC */
-    C(0xb384, SFPC,    RRE,   Z,   0, r1_o, 0, 0, sfpc, 0)
+    F(0xb384, SFPC,    RRE,   Z,   0, r1_o, 0, 0, sfpc, 0, IF_BFP)
 /* SET FPC AND SIGNAL */
-    C(0xb385, SFASR,   RRE,   IEEEE_SIM, 0, r1_o, 0, 0, sfas, 0)
+    F(0xb385, SFASR,   RRE,   IEEEE_SIM, 0, r1_o, 0, 0, sfas, 0, IF_DFP)
 /* SET BFP ROUNDING MODE */
-    C(0xb299, SRNM,    S,     Z,   0, 0, 0, 0, srnm, 0)
-    C(0xb2b8, SRNMB,   S,     FPE, 0, 0, 0, 0, srnm, 0)
+    F(0xb299, SRNM,    S,     Z,   0, 0, 0, 0, srnm, 0, IF_BFP)
+    F(0xb2b8, SRNMB,   S,     FPE, 0, 0, 0, 0, srnm, 0, IF_BFP)
 /* SET DFP ROUNDING MODE */
-    C(0xb2b9, SRNMT,   S,     DFPR, 0, 0, 0, 0, srnm, 0)
+    F(0xb2b9, SRNMT,   S,     DFPR, 0, 0, 0, 0, srnm, 0, IF_DFP)
 /* SET PROGRAM MASK */
     C(0x0400, SPM,     RR_a,  Z,   r1, 0, 0, 0, spm, 0)
 
@@ -789,20 +789,20 @@
     C(0x8c00, SRDL,    RS_a,  Z,   r1_D32, sh64, new, r1_D32, srl, 0)
 
 /* SQUARE ROOT */
-    C(0xb314, SQEBR,   RRE,   Z,   0, e2, new, e1, sqeb, 0)
-    C(0xb315, SQDBR,   RRE,   Z,   0, f2_o, f1, 0, sqdb, 0)
-    C(0xb316, SQXBR,   RRE,   Z,   0, x2_o, x1, 0, sqxb, 0)
-    C(0xed14, SQEB,    RXE,   Z,   0, m2_32u, new, e1, sqeb, 0)
-    C(0xed15, SQDB,    RXE,   Z,   0, m2_64, f1, 0, sqdb, 0)
+    F(0xb314, SQEBR,   RRE,   Z,   0, e2, new, e1, sqeb, 0, IF_BFP)
+    F(0xb315, SQDBR,   RRE,   Z,   0, f2_o, f1, 0, sqdb, 0, IF_BFP)
+    F(0xb316, SQXBR,   RRE,   Z,   0, x2_o, x1, 0, sqxb, 0, IF_BFP)
+    F(0xed14, SQEB,    RXE,   Z,   0, m2_32u, new, e1, sqeb, 0, IF_BFP)
+    F(0xed15, SQDB,    RXE,   Z,   0, m2_64, f1, 0, sqdb, 0, IF_BFP)
 
 /* STORE */
     C(0x5000, ST,      RX_a,  Z,   r1_o, a2, 0, 0, st32, 0)
     C(0xe350, STY,     RXY_a, LD,  r1_o, a2, 0, 0, st32, 0)
     C(0xe324, STG,     RXY_a, Z,   r1_o, a2, 0, 0, st64, 0)
-    C(0x6000, STD,     RX_a,  Z,   f1_o, a2, 0, 0, st64, 0)
-    C(0xed67, STDY,    RXY_a, LD,  f1_o, a2, 0, 0, st64, 0)
-    C(0x7000, STE,     RX_a,  Z,   e1, a2, 0, 0, st32, 0)
-    C(0xed66, STEY,    RXY_a, LD,  e1, a2, 0, 0, st32, 0)
+    F(0x6000, STD,     RX_a,  Z,   f1_o, a2, 0, 0, st64, 0, IF_HFP1)
+    F(0xed67, STDY,    RXY_a, LD,  f1_o, a2, 0, 0, st64, 0, IF_HFP1)
+    F(0x7000, STE,     RX_a,  Z,   e1, a2, 0, 0, st32, 0, IF_HFP1)
+    F(0xed66, STEY,    RXY_a, LD,  e1, a2, 0, 0, st32, 0, IF_HFP1)
 /* STORE RELATIVE LONG */
     C(0xc40f, STRL,    RIL_b, GIE, r1_o, ri2, 0, 0, st32, 0)
     C(0xc40b, STGRL,   RIL_b, GIE, r1_o, ri2, 0, 0, st64, 0)
@@ -837,7 +837,7 @@
 /* STORE FACILITY LIST EXTENDED */
     C(0xb2b0, STFLE,   S,  SFLE,   0, a2, 0, 0, stfle, 0)
 /* STORE FPC */
-    C(0xb29c, STFPC,   S,     Z,   0, a2, new, m2_32, efpc, 0)
+    F(0xb29c, STFPC,   S,     Z,   0, a2, new, m2_32, efpc, 0, IF_BFP)
 
 /* STORE MULTIPLE */
     D(0x9000, STM,     RS_a,  Z,   0, a2, 0, 0, stm, 0, 4)
@@ -861,11 +861,11 @@
     C(0xb9e9, SGRK,    RRF_a, DO,  r2, r3, r1, 0, sub, subs64)
     C(0xe309, SG,      RXY_a, Z,   r1, m2_64, r1, 0, sub, subs64)
     C(0xe319, SGF,     RXY_a, Z,   r1, m2_32s, r1, 0, sub, subs64)
-    C(0xb30b, SEBR,    RRE,   Z,   e1, e2, new, e1, seb, f32)
-    C(0xb31b, SDBR,    RRE,   Z,   f1_o, f2_o, f1, 0, sdb, f64)
-    C(0xb34b, SXBR,    RRE,   Z,   0, x2_o, x1, 0, sxb, f128)
-    C(0xed0b, SEB,     RXE,   Z,   e1, m2_32u, new, e1, seb, f32)
-    C(0xed1b, SDB,     RXE,   Z,   f1_o, m2_64, f1, 0, sdb, f64)
+    F(0xb30b, SEBR,    RRE,   Z,   e1, e2, new, e1, seb, f32, IF_BFP)
+    F(0xb31b, SDBR,    RRE,   Z,   f1_o, f2_o, f1, 0, sdb, f64, IF_BFP)
+    F(0xb34b, SXBR,    RRE,   Z,   0, x2_o, x1, 0, sxb, f128, IF_BFP)
+    F(0xed0b, SEB,     RXE,   Z,   e1, m2_32u, new, e1, seb, f32, IF_BFP)
+    F(0xed1b, SDB,     RXE,   Z,   f1_o, m2_64, f1, 0, sdb, f64, IF_BFP)
 /* SUBTRACT HALFWORD */
     C(0x4b00, SH,      RX_a,  Z,   r1, m2_16s, new, r1_32, sub, subs32)
     C(0xe37b, SHY,     RXY_a, LD,  r1, m2_16s, new, r1_32, sub, subs32)
@@ -904,9 +904,9 @@
     C(0x9300, TS,      S,     Z,   0, a2, 0, 0, ts, 0)
 
 /* TEST DATA CLASS */
-    C(0xed10, TCEB,    RXE,   Z,   e1, a2, 0, 0, tceb, 0)
-    C(0xed11, TCDB,    RXE,   Z,   f1_o, a2, 0, 0, tcdb, 0)
-    C(0xed12, TCXB,    RXE,   Z,   x1_o, a2, 0, 0, tcxb, 0)
+    F(0xed10, TCEB,    RXE,   Z,   e1, a2, 0, 0, tceb, 0, IF_BFP)
+    F(0xed11, TCDB,    RXE,   Z,   f1_o, a2, 0, 0, tcdb, 0, IF_BFP)
+    F(0xed12, TCXB,    RXE,   Z,   x1_o, a2, 0, 0, tcxb, 0, IF_BFP)
 
 /* TEST DECIMAL */
     C(0xebc0, TP,      RSL,   E2,  la1, 0, 0, 0, tp, 0)
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index e9cbeb2a1b..8322c81e90 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -1112,6 +1112,14 @@ typedef struct {
 /* We are exiting the TB to the main loop.  */
 #define DISAS_PC_STALE_NOCHAIN  DISAS_TARGET_4
 
+
+/* Instruction flags */
+#define IF_HFP1     0x0001      /* r1 points at fp reg for HFP instructions */
+#define IF_HFP2     0x0002      /* r2 points at fp reg for HFP instructions */
+#define IF_HFP3     0x0004      /* r3 points at fp reg for HFP instructions */
+#define IF_BFP      0x0008      /* binary floating point instruction */
+#define IF_DFP      0x0010      /* decimal floating point instruction */
+
 struct DisasInsn {
     unsigned opc:16;
     unsigned flags:16;
-- 
2.17.1
