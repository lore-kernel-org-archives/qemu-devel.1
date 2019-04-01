Received: from eggs.gnu.org ([209.51.188.92]:42157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB46G-0002tt-5W
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:04:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB46E-0004Rj-Qq
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:04:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52778
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hB46E-0004JA-HQ
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:04:10 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31L3pmx062123
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 17:03:58 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rkskgsy1t-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 17:03:54 -0400
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 1 Apr 2019 22:02:29 +0100
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  1 Apr 2019 15:58:37 -0500
In-Reply-To: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190401210011.16009-4-mdroth@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 03/97] target/arm: Reorganize SVE WHILE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, Peter Maydell <peter.maydell@linaro.org>

From: Richard Henderson <richard.henderson@linaro.org>

The pseudocode for this operation is an increment + compare loop,
so comparing <=3D the maximum integer produces an all-true predicate.

Rather than bound in both the inline code and the helper, pass the
helper the number of predicate bits to set instead of the number
of predicate elements to set.

Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Message-id: 20180801123111.3595-4-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit bbd0968c458d48e34a08b8694fa3309a9fe1c9e7)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 target/arm/sve_helper.c    |  5 ----
 target/arm/translate-sve.c | 49 +++++++++++++++++++++++++-------------
 2 files changed, 32 insertions(+), 22 deletions(-)

diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 9bd0694d55..87594a8adb 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -2846,11 +2846,6 @@ uint32_t HELPER(sve_while)(void *vd, uint32_t coun=
t, uint32_t pred_desc)
         return flags;
     }
=20
-    /* Scale from predicate element count to bits.  */
-    count <<=3D esz;
-    /* Bound to the bits in the predicate.  */
-    count =3D MIN(count, oprsz * 8);
-
     /* Set all of the requested bits.  */
     for (i =3D 0; i < count / 64; ++i) {
         d->p[i] =3D esz_mask;
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 9dd4c38bab..89efc80ee7 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -3173,19 +3173,19 @@ static bool trans_CTERM(DisasContext *s, arg_CTER=
M *a, uint32_t insn)
=20
 static bool trans_WHILE(DisasContext *s, arg_WHILE *a, uint32_t insn)
 {
-    if (!sve_access_check(s)) {
-        return true;
-    }
-
-    TCGv_i64 op0 =3D read_cpu_reg(s, a->rn, 1);
-    TCGv_i64 op1 =3D read_cpu_reg(s, a->rm, 1);
-    TCGv_i64 t0 =3D tcg_temp_new_i64();
-    TCGv_i64 t1 =3D tcg_temp_new_i64();
+    TCGv_i64 op0, op1, t0, t1, tmax;
     TCGv_i32 t2, t3;
     TCGv_ptr ptr;
     unsigned desc, vsz =3D vec_full_reg_size(s);
     TCGCond cond;
=20
+    if (!sve_access_check(s)) {
+        return true;
+    }
+
+    op0 =3D read_cpu_reg(s, a->rn, 1);
+    op1 =3D read_cpu_reg(s, a->rm, 1);
+
     if (!a->sf) {
         if (a->u) {
             tcg_gen_ext32u_i64(op0, op0);
@@ -3198,32 +3198,47 @@ static bool trans_WHILE(DisasContext *s, arg_WHIL=
E *a, uint32_t insn)
=20
     /* For the helper, compress the different conditions into a computat=
ion
      * of how many iterations for which the condition is true.
-     *
-     * This is slightly complicated by 0 <=3D UINT64_MAX, which is nomin=
ally
-     * 2**64 iterations, overflowing to 0.  Of course, predicate registe=
rs
-     * aren't that large, so any value >=3D predicate size is sufficient.
      */
+    t0 =3D tcg_temp_new_i64();
+    t1 =3D tcg_temp_new_i64();
     tcg_gen_sub_i64(t0, op1, op0);
=20
-    /* t0 =3D MIN(op1 - op0, vsz).  */
-    tcg_gen_movi_i64(t1, vsz);
-    tcg_gen_umin_i64(t0, t0, t1);
+    tmax =3D tcg_const_i64(vsz >> a->esz);
     if (a->eq) {
         /* Equality means one more iteration.  */
         tcg_gen_addi_i64(t0, t0, 1);
+
+        /* If op1 is max (un)signed integer (and the only time the addit=
ion
+         * above could overflow), then we produce an all-true predicate =
by
+         * setting the count to the vector length.  This is because the
+         * pseudocode is described as an increment + compare loop, and t=
he
+         * max integer would always compare true.
+         */
+        tcg_gen_movi_i64(t1, (a->sf
+                              ? (a->u ? UINT64_MAX : INT64_MAX)
+                              : (a->u ? UINT32_MAX : INT32_MAX)));
+        tcg_gen_movcond_i64(TCG_COND_EQ, t0, op1, t1, tmax, t0);
     }
=20
-    /* t0 =3D (condition true ? t0 : 0).  */
+    /* Bound to the maximum.  */
+    tcg_gen_umin_i64(t0, t0, tmax);
+    tcg_temp_free_i64(tmax);
+
+    /* Set the count to zero if the condition is false.  */
     cond =3D (a->u
             ? (a->eq ? TCG_COND_LEU : TCG_COND_LTU)
             : (a->eq ? TCG_COND_LE : TCG_COND_LT));
     tcg_gen_movi_i64(t1, 0);
     tcg_gen_movcond_i64(cond, t0, op0, op1, t0, t1);
+    tcg_temp_free_i64(t1);
=20
+    /* Since we're bounded, pass as a 32-bit type.  */
     t2 =3D tcg_temp_new_i32();
     tcg_gen_extrl_i64_i32(t2, t0);
     tcg_temp_free_i64(t0);
-    tcg_temp_free_i64(t1);
+
+    /* Scale elements to bits.  */
+    tcg_gen_shli_i32(t2, t2, a->esz);
=20
     desc =3D (vsz / 8) - 2;
     desc =3D deposit32(desc, SIMD_DATA_SHIFT, 2, a->esz);
--=20
2.17.1
