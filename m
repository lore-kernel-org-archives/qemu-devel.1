Received: from eggs.gnu.org ([209.51.188.92]:42943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h3GqZ-0002rK-84
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 05:03:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h3GqV-0005DE-Bu
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 05:03:47 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon, 11 Mar 2019 10:02:51 +0100
Message-Id: <20190311090322.21603-3-cohuck@redhat.com>
In-Reply-To: <20190311090322.21603-1-cohuck@redhat.com>
References: <20190311090322.21603-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 02/33] s390x/tcg: Define vector instruction
 formats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

These are the new instruction formats related to vector instructions as
up to the z14 (a.k.a. latest PoP).

As v2 appeares (like x2 in VRX) with d2/b2 in VRV, we have to assign it a
higher field number to avoid collisions.

Properly take care of the MSB (to be able to address 32 registers) for
each vector register field stored in the RXB field (Bit 36 - 30  for all
vector instructions). As we have 32 bit vector registers and the
"v" fields are only 4 bit in size, the 5th bit is stored in the RXB.
We use a new type to indicate that the MSB has to be fetched from the
RXB.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20190307121539.12842-2-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/insn-format.def | 25 +++++++++++++++++++++++
 target/s390x/translate.c     | 39 +++++++++++++++++++++++++++++++++++-
 2 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/target/s390x/insn-format.def b/target/s390x/insn-format.def
index 4297ff416589..6253edbd199e 100644
--- a/target/s390x/insn-format.def
+++ b/target/s390x/insn-format.def
@@ -54,3 +54,28 @@ F4(SS_e,  R(1, 8),     BD(2,16,20), R(3,12),     BD(4,32,36))
 F3(SS_f,  BD(1,16,20), L(2,8,8),    BD(2,32,36))
 F2(SSE,   BD(1,16,20), BD(2,32,36))
 F3(SSF,   BD(1,16,20), BD(2,32,36), R(3,8))
+F3(VRI_a, V(1,8),      I(2,16,16),  M(3,32))
+F4(VRI_b, V(1,8),      I(2,16,8),   I(3,24,8),   M(4,32))
+F4(VRI_c, V(1,8),      V(3,12),     I(2,16,16),  M(4,32))
+F5(VRI_d, V(1,8),      V(2,12),     V(3,16),     I(4,24,8),   M(5,32))
+F5(VRI_e, V(1,8),      V(2,12),     I(3,16,12),  M(5,28),     M(4,32))
+F5(VRI_f, V(1,8),      V(2,12),     V(3,16),     M(5,24),     I(4,28,8))
+F5(VRI_g, V(1,8),      V(2,12),     I(4,16,8),   M(5,24),     I(3,28,8))
+F3(VRI_h, V(1,8),      I(2,16,16),  I(3,32,4))
+F4(VRI_i, V(1,8),      R(2,12),     M(4,24),     I(3,28,8))
+F5(VRR_a, V(1,8),      V(2,12),     M(5,24),     M(4,28),     M(3,32))
+F5(VRR_b, V(1,8),      V(2,12),     V(3,16),     M(5,24),     M(4,32))
+F6(VRR_c, V(1,8),      V(2,12),     V(3,16),     M(6,24),     M(5,28),  M(4,32))
+F6(VRR_d, V(1,8),      V(2,12),     V(3,16),     M(5,20),     M(6,24),  V(4,32))
+F6(VRR_e, V(1,8),      V(2,12),     V(3,16),     M(6,20),     M(5,28),  V(4,32))
+F3(VRR_f, V(1,8),      R(2,12),     R(3,16))
+F1(VRR_g, V(1,12))
+F3(VRR_h, V(1,12),     V(2,16),     M(3,24))
+F3(VRR_i, R(1,8),      V(2,12),     M(3,24))
+F4(VRS_a, V(1,8),      V(3,12),     BD(2,16,20), M(4,32))
+F4(VRS_b, V(1,8),      R(3,12),     BD(2,16,20), M(4,32))
+F4(VRS_c, R(1,8),      V(3,12),     BD(2,16,20), M(4,32))
+F3(VRS_d, R(3,12),     BD(2,16,20), V(1,32))
+F4(VRV,   V(1,8),      V(2,12),     BD(2,16,20), M(3,32))
+F3(VRX,   V(1,8),      BXD(2),      M(3,32))
+F3(VSI,   I(3,8,8),    BD(2,16,20), V(1,32))
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 41fb466bb4fa..1d8030f8cd82 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -985,6 +985,7 @@ static void free_compare(DisasCompare *c)
 #define F3(N, X1, X2, X3)             F0(N)
 #define F4(N, X1, X2, X3, X4)         F0(N)
 #define F5(N, X1, X2, X3, X4, X5)     F0(N)
+#define F6(N, X1, X2, X3, X4, X5, X6) F0(N)
 
 typedef enum {
 #include "insn-format.def"
@@ -996,6 +997,7 @@ typedef enum {
 #undef F3
 #undef F4
 #undef F5
+#undef F6
 
 /* Define a structure to hold the decoded fields.  We'll store each inside
    an array indexed by an enum.  In order to conserve memory, we'll arrange
@@ -1010,6 +1012,8 @@ enum DisasFieldIndexO {
     FLD_O_m1,
     FLD_O_m3,
     FLD_O_m4,
+    FLD_O_m5,
+    FLD_O_m6,
     FLD_O_b1,
     FLD_O_b2,
     FLD_O_b4,
@@ -1023,7 +1027,11 @@ enum DisasFieldIndexO {
     FLD_O_i2,
     FLD_O_i3,
     FLD_O_i4,
-    FLD_O_i5
+    FLD_O_i5,
+    FLD_O_v1,
+    FLD_O_v2,
+    FLD_O_v3,
+    FLD_O_v4,
 };
 
 enum DisasFieldIndexC {
@@ -1031,6 +1039,7 @@ enum DisasFieldIndexC {
     FLD_C_m1 = 0,
     FLD_C_b1 = 0,
     FLD_C_i1 = 0,
+    FLD_C_v1 = 0,
 
     FLD_C_r2 = 1,
     FLD_C_b2 = 1,
@@ -1039,20 +1048,25 @@ enum DisasFieldIndexC {
     FLD_C_r3 = 2,
     FLD_C_m3 = 2,
     FLD_C_i3 = 2,
+    FLD_C_v3 = 2,
 
     FLD_C_m4 = 3,
     FLD_C_b4 = 3,
     FLD_C_i4 = 3,
     FLD_C_l1 = 3,
+    FLD_C_v4 = 3,
 
     FLD_C_i5 = 4,
     FLD_C_d1 = 4,
+    FLD_C_m5 = 4,
 
     FLD_C_d2 = 5,
+    FLD_C_m6 = 5,
 
     FLD_C_d4 = 6,
     FLD_C_x2 = 6,
     FLD_C_l2 = 6,
+    FLD_C_v2 = 6,
 
     NUM_C_FIELD = 7
 };
@@ -1097,6 +1111,7 @@ typedef struct DisasFormatInfo {
 
 #define R(N, B)       {  B,  4, 0, FLD_C_r##N, FLD_O_r##N }
 #define M(N, B)       {  B,  4, 0, FLD_C_m##N, FLD_O_m##N }
+#define V(N, B)       {  B,  4, 3, FLD_C_v##N, FLD_O_v##N }
 #define BD(N, BB, BD) { BB,  4, 0, FLD_C_b##N, FLD_O_b##N }, \
                       { BD, 12, 0, FLD_C_d##N, FLD_O_d##N }
 #define BXD(N)        { 16,  4, 0, FLD_C_b##N, FLD_O_b##N }, \
@@ -1116,6 +1131,7 @@ typedef struct DisasFormatInfo {
 #define F3(N, X1, X2, X3)         { { X1, X2, X3 } },
 #define F4(N, X1, X2, X3, X4)     { { X1, X2, X3, X4 } },
 #define F5(N, X1, X2, X3, X4, X5) { { X1, X2, X3, X4, X5 } },
+#define F6(N, X1, X2, X3, X4, X5, X6)       { { X1, X2, X3, X4, X5, X6 } },
 
 static const DisasFormatInfo format_info[] = {
 #include "insn-format.def"
@@ -1127,8 +1143,10 @@ static const DisasFormatInfo format_info[] = {
 #undef F3
 #undef F4
 #undef F5
+#undef F6
 #undef R
 #undef M
+#undef V
 #undef BD
 #undef BXD
 #undef BDL
@@ -6119,6 +6137,25 @@ static void extract_field(DisasFields *o, const DisasField *f, uint64_t insn)
     case 2: /* dl+dh split, signed 20 bit. */
         r = ((int8_t)r << 12) | (r >> 8);
         break;
+    case 3: /* MSB stored in RXB */
+        g_assert(f->size == 4);
+        switch (f->beg) {
+        case 8:
+            r |= extract64(insn, 63 - 36, 1) << 4;
+            break;
+        case 12:
+            r |= extract64(insn, 63 - 37, 1) << 4;
+            break;
+        case 16:
+            r |= extract64(insn, 63 - 38, 1) << 4;
+            break;
+        case 32:
+            r |= extract64(insn, 63 - 39, 1) << 4;
+            break;
+        default:
+            g_assert_not_reached();
+        }
+        break;
     default:
         abort();
     }
-- 
2.17.2
