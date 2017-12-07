Received: from eggs.gnu.org ([2001:4830:134:3::10]:39560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eMzRR-0004ir-PW
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 11:54:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eMzRN-0007Bn-7M
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 11:54:33 -0500
From: David Hildenbrand <david@redhat.com>
Date: Thu,  7 Dec 2017 17:53:48 +0100
Message-Id: <20171207165355.7559-4-david@redhat.com>
In-Reply-To: <20171207165355.7559-1-david@redhat.com>
References: <20171207165355.7559-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 for-2.12 03/10] s390x/tcg: implement
 Interlocked-Access Facility 2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>

With this facility, OI/OIY, NI/NIY and XI/XIY are atomic. All operate on
one byte (MO_UB).

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cpu_models.c  |  1 +
 target/s390x/insn-data.def | 12 ++++++------
 target/s390x/translate.c   | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index c4c37b3b15..94d24e423d 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -842,6 +842,7 @@ static void add_qemu_cpu_model_features(S390FeatBitmap fbm)
         S390_FEAT_STFLE_45,
         S390_FEAT_STFLE_49,
         S390_FEAT_LOCAL_TLB_CLEARING,
+        S390_FEAT_INTERLOCKED_ACCESS_2,
         S390_FEAT_STFLE_53,
         S390_FEAT_MSA_EXT_5,
         S390_FEAT_MSA_EXT_3,
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 166ee7c80b..4e6dd6e348 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -99,8 +99,8 @@
     D(0xa505, NIHL,    RI_a,  Z,   r1_o, i2_16u, r1, 0, andi, 0, 0x1020)
     D(0xa506, NILH,    RI_a,  Z,   r1_o, i2_16u, r1, 0, andi, 0, 0x1010)
     D(0xa507, NILL,    RI_a,  Z,   r1_o, i2_16u, r1, 0, andi, 0, 0x1000)
-    C(0x9400, NI,      SI,    Z,   m1_8u, i2_8u, new, m1_8, and, nz64)
-    C(0xeb54, NIY,     SIY,   LD,  m1_8u, i2_8u, new, m1_8, and, nz64)
+    C(0x9400, NI,      SI,    Z,   la1, i2_8u, new, 0, ni, nz64)
+    C(0xeb54, NIY,     SIY,   LD,  la1, i2_8u, new, 0, ni, nz64)
 
 /* BRANCH AND SAVE */
     C(0x0d00, BASR,    RR_a,  Z,   0, r2_nz, r1, 0, bas, 0)
@@ -357,8 +357,8 @@
 /* EXCLUSIVE OR IMMEDIATE */
     D(0xc006, XIHF,    RIL_a, EI,  r1_o, i2_32u, r1, 0, xori, 0, 0x2020)
     D(0xc007, XILF,    RIL_a, EI,  r1_o, i2_32u, r1, 0, xori, 0, 0x2000)
-    C(0x9700, XI,      SI,    Z,   m1_8u, i2_8u, new, m1_8, xor, nz64)
-    C(0xeb57, XIY,     SIY,   LD,  m1_8u, i2_8u, new, m1_8, xor, nz64)
+    C(0x9700, XI,      SI,    Z,   la1, i2_8u, new, 0, xi, nz64)
+    C(0xeb57, XIY,     SIY,   LD,  la1, i2_8u, new, 0, xi, nz64)
 
 /* EXECUTE */
     C(0x4400, EX,      RX_a,  Z,   0, a2, 0, 0, ex, 0)
@@ -698,8 +698,8 @@
     D(0xa509, OIHL,    RI_a,  Z,   r1_o, i2_16u, r1, 0, ori, 0, 0x1020)
     D(0xa50a, OILH,    RI_a,  Z,   r1_o, i2_16u, r1, 0, ori, 0, 0x1010)
     D(0xa50b, OILL,    RI_a,  Z,   r1_o, i2_16u, r1, 0, ori, 0, 0x1000)
-    C(0x9600, OI,      SI,    Z,   m1_8u, i2_8u, new, m1_8, or, nz64)
-    C(0xeb56, OIY,     SIY,   LD,  m1_8u, i2_8u, new, m1_8, or, nz64)
+    C(0x9600, OI,      SI,    Z,   la1, i2_8u, new, 0, oi, nz64)
+    C(0xeb56, OIY,     SIY,   LD,  la1, i2_8u, new, 0, oi, nz64)
 
 /* PACK */
     /* Really format SS_b, but we pack both lengths into one argument
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 79d2ee650c..edfe51b5c3 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -1417,6 +1417,17 @@ static ExitStatus op_andi(DisasContext *s, DisasOps *o)
     return NO_EXIT;
 }
 
+static ExitStatus op_ni(DisasContext *s, DisasOps *o)
+{
+    o->in1 = tcg_temp_new_i64();
+    /* Perform the atomic operation in memory. */
+    tcg_gen_atomic_fetch_and_i64(o->in1, o->addr1, o->in2, get_mem_index(s),
+                                 MO_UB);
+    /* We need to recompute the operation for setting CC.  */
+    tcg_gen_and_i64(o->out, o->in1, o->in2);
+    return NO_EXIT;
+}
+
 static ExitStatus op_bas(DisasContext *s, DisasOps *o)
 {
     tcg_gen_movi_i64(o->out, pc_to_link_info(s, s->next_pc));
@@ -3368,6 +3379,17 @@ static ExitStatus op_ori(DisasContext *s, DisasOps *o)
     return NO_EXIT;
 }
 
+static ExitStatus op_oi(DisasContext *s, DisasOps *o)
+{
+    o->in1 = tcg_temp_new_i64();
+    /* Perform the atomic operation in memory. */
+    tcg_gen_atomic_fetch_or_i64(o->in1, o->addr1, o->in2, get_mem_index(s),
+                                MO_UB);
+    /* We need to recompute the operation for setting CC.  */
+    tcg_gen_or_i64(o->out, o->in1, o->in2);
+    return NO_EXIT;
+}
+
 static ExitStatus op_pack(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 l = tcg_const_i32(get_field(s->fields, l1));
@@ -4633,6 +4655,17 @@ static ExitStatus op_xori(DisasContext *s, DisasOps *o)
     return NO_EXIT;
 }
 
+static ExitStatus op_xi(DisasContext *s, DisasOps *o)
+{
+    o->in1 = tcg_temp_new_i64();
+    /* Perform the atomic operation in memory. */
+    tcg_gen_atomic_fetch_xor_i64(o->in1, o->addr1, o->in2, get_mem_index(s),
+                                 MO_UB);
+    /* We need to recompute the operation for setting CC.  */
+    tcg_gen_xor_i64(o->out, o->in1, o->in2);
+    return NO_EXIT;
+}
+
 static ExitStatus op_zero(DisasContext *s, DisasOps *o)
 {
     o->out = tcg_const_i64(0);
-- 
2.14.3
