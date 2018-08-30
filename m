Received: from eggs.gnu.org ([2001:4830:134:3::10]:42175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fvM3e-0000Eh-5H
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 08:28:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fvM3Y-0000XC-9a
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 08:28:15 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu, 30 Aug 2018 14:27:51 +0200
Message-Id: <20180830122756.13991-5-david@redhat.com>
In-Reply-To: <20180830122756.13991-1-david@redhat.com>
References: <20180830122756.13991-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 4/9] s390x/tcg: support flags for
 instructions
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

Storing flags for instructions allows us to efficiently verify certain
properties at a central point. Examples might later be handling if
AFP is disabled in CR0, we are not in problem state, or if vector
instructions are disabled in CR0.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/insn-data.def |  3 +++
 target/s390x/translate.c   | 22 ++++++++++++++++------
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 5c6f33ed9c..ff4a6ceaf5 100644
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
index fa8468f0e1..e9cbeb2a1b 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -1114,6 +1114,7 @@ typedef struct {
 
 struct DisasInsn {
     unsigned opc:16;
+    unsigned flags:16;
     DisasFormat fmt:8;
     unsigned fac:8;
     unsigned spec:8;
@@ -5796,17 +5797,24 @@ static void in2_insn(DisasContext *s, DisasFields *f, DisasOps *o)
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
@@ -5877,8 +5885,8 @@ static const DisasInsn insn_info[] = {
 #include "insn-data.def"
 };
 
-#undef D
-#define D(OPC, NM, FT, FC, I1, I2, P, W, OP, CC, D) \
+#undef E
+#define E(OPC, NM, FT, FC, I1, I2, P, W, OP, CC, D, FL) \
     case OPC: return &insn_info[insn_ ## NM];
 
 static const DisasInsn *lookup_opc(uint16_t opc)
@@ -5890,6 +5898,8 @@ static const DisasInsn *lookup_opc(uint16_t opc)
     }
 }
 
+#undef F
+#undef E
 #undef D
 #undef C
 
-- 
2.17.1
