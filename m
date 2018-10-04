Received: from eggs.gnu.org ([2001:4830:134:3::10]:53304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1g85Zc-0008Qk-Es
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 11:29:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1g85Zb-0005E4-Ai
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 11:29:56 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu,  4 Oct 2018 17:28:51 +0200
Message-Id: <20181004152857.14525-10-cohuck@redhat.com>
In-Reply-To: <20181004152857.14525-1-cohuck@redhat.com>
References: <20181004152857.14525-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 09/15] s390x/tcg: support flags for instructions
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

Storing flags for instructions allows us to efficiently verify certain
properties at a central point. Examples might later be handling if
AFP is disabled in CR0, we are not in problem state, or if vector
instructions are disabled in CR0.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20180927130303.12236-5-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/insn-data.def |  3 +++
 target/s390x/translate.c   | 22 ++++++++++++++++------
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 9c7b434fca..7ab28b7f2d 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -3,6 +3,8 @@
  *
  *  C(OPC,    NAME,    FMT,   FAC, I1, I2, P, W, OP, CC)
  *  D(OPC,    NAME,    FMT,   FAC, I1, I2, P, W, OP, CC, DATA)
+ *  E(OPC,    NAME,    FMT,   FAC, I1, I2, P, W, OP, CC, DATA, FLAGS)
+ *  F(OPC,    NAME,    FMT,   FAC, I1, I2, P, W, OP, CC, FLAGS)
  *
  *  OPC  = (op << 8) | op2 where op is the major, op2 the minor opcode
  *  NAME = name of the opcode, used internally
@@ -15,6 +17,7 @@
  *  OP   = func op_xx does the bulk of the operation
  *  CC   = func cout_xx defines how cc should get set
  *  DATA = immediate argument to op_xx function
+ *  FLAGS = categorize the type of instruction (e.g. for advanced checks)
  *
  *  The helpers get called in order: I1, I2, P, OP, W, CC
  */
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 43b736335f..146a817ce2 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -1121,6 +1121,7 @@ typedef struct {
 
 struct DisasInsn {
     unsigned opc:16;
+    unsigned flags:16;
     DisasFormat fmt:8;
     unsigned fac:8;
     unsigned spec:8;
@@ -5835,17 +5836,24 @@ static void in2_insn(DisasContext *s, DisasFields *f, DisasOps *o)
    search tree, rather than us having to post-process the table.  */
 
 #define C(OPC, NM, FT, FC, I1, I2, P, W, OP, CC) \
-    D(OPC, NM, FT, FC, I1, I2, P, W, OP, CC, 0)
+    E(OPC, NM, FT, FC, I1, I2, P, W, OP, CC, 0, 0)
 
-#define D(OPC, NM, FT, FC, I1, I2, P, W, OP, CC, D) insn_ ## NM,
+#define D(OPC, NM, FT, FC, I1, I2, P, W, OP, CC, D) \
+    E(OPC, NM, FT, FC, I1, I2, P, W, OP, CC, D, 0)
+
+#define F(OPC, NM, FT, FC, I1, I2, P, W, OP, CC, FL) \
+    E(OPC, NM, FT, FC, I1, I2, P, W, OP, CC, 0, FL)
+
+#define E(OPC, NM, FT, FC, I1, I2, P, W, OP, CC, D, FL) insn_ ## NM,
 
 enum DisasInsnEnum {
 #include "insn-data.def"
 };
 
-#undef D
-#define D(OPC, NM, FT, FC, I1, I2, P, W, OP, CC, D) {                       \
+#undef E
+#define E(OPC, NM, FT, FC, I1, I2, P, W, OP, CC, D, FL) {                   \
     .opc = OPC,                                                             \
+    .flags = FL,                                                            \
     .fmt = FMT_##FT,                                                        \
     .fac = FAC_##FC,                                                        \
     .spec = SPEC_in1_##I1 | SPEC_in2_##I2 | SPEC_prep_##P | SPEC_wout_##W,  \
@@ -5916,8 +5924,8 @@ static const DisasInsn insn_info[] = {
 #include "insn-data.def"
 };
 
-#undef D
-#define D(OPC, NM, FT, FC, I1, I2, P, W, OP, CC, D) \
+#undef E
+#define E(OPC, NM, FT, FC, I1, I2, P, W, OP, CC, D, FL) \
     case OPC: return &insn_info[insn_ ## NM];
 
 static const DisasInsn *lookup_opc(uint16_t opc)
@@ -5929,6 +5937,8 @@ static const DisasInsn *lookup_opc(uint16_t opc)
     }
 }
 
+#undef F
+#undef E
 #undef D
 #undef C
 
-- 
2.14.4
