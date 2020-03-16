Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B7CC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 13:16:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D70E20663
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 13:16:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D70E20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDpb9-0005D1-Mq
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 09:16:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42086)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jiangyifei@huawei.com>) id 1jDo7j-00060Q-V8
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 07:41:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jiangyifei@huawei.com>) id 1jDo7i-0002EO-EX
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 07:41:35 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3205 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jiangyifei@huawei.com>)
 id 1jDo7h-00015Z-W8
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 07:41:34 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 0A6A62163B4CE083E49F;
 Mon, 16 Mar 2020 19:41:26 +0800 (CST)
Received: from huawei.com (10.133.201.158) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Mon, 16 Mar 2020
 19:41:18 +0800
From: Yifei Jiang <jiangyifei@huawei.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH 1/2] tcg: avoid integer overflow
Date: Mon, 16 Mar 2020 19:40:49 +0800
Message-ID: <20200316114050.3167-2-jiangyifei@huawei.com>
X-Mailer: git-send-email 2.23.0.windows.1
In-Reply-To: <20200316114050.3167-1-jiangyifei@huawei.com>
References: <20200316114050.3167-1-jiangyifei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.201.158]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.190
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: zhang.zhanghailiang@huawei.com, limingwang@huawei.com,
 victor.zhangxiaofeng@huawei.com, Yifei Jiang <jiangyifei@huawei.com>,
 Euler Robot <euler.robot@huawei.com>, pbonzini@redhat.com, rth@twiddle.net,
 dengkai1@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This fixes coverity issues 75234842, etc.,:
    2221    tcg_gen_andi_i64(t, t, dup_const(vece, 1));
CID 75234842: (OVERFLOW_BEFORE_WIDEN)
    2222. overflow_before_widen: Potentially overflowing expression "1 <<=
 nbit" with type "int" (32 bits, signed) is evaluated using 32-bit arithm=
etic, and then used in a context that expects an expression of type "int6=
4_t" (64 bits, signed).
    2222    tcg_gen_muli_i64(t, t, (1 << nbit) - 1);

Signed-off-by: Yifei Jiang <jiangyifei@huawei.com>
Signed-off-by: Mingwang Li <limingwang@huawei.com>
Reported-by: Euler Robot <euler.robot@huawei.com>
---
 tcg/tcg-op-gvec.c | 18 +++++++++---------
 tcg/tcg-op-vec.c  |  4 ++--
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 327d9588e0..3aeb049a46 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -2219,7 +2219,7 @@ static void gen_absv_mask(TCGv_i64 d, TCGv_i64 b, u=
nsigned vece)
     /* Create -1 for each negative element.  */
     tcg_gen_shri_i64(t, b, nbit - 1);
     tcg_gen_andi_i64(t, t, dup_const(vece, 1));
-    tcg_gen_muli_i64(t, t, (1 << nbit) - 1);
+    tcg_gen_muli_i64(t, t, ((int64_t)1 << nbit) - 1);
=20
     /*
      * Invert (via xor -1) and add one (via sub -1).
@@ -2528,7 +2528,7 @@ void tcg_gen_gvec_shli(unsigned vece, uint32_t dofs=
, uint32_t aofs,
     };
=20
     tcg_debug_assert(vece <=3D MO_64);
-    tcg_debug_assert(shift >=3D 0 && shift < (8 << vece));
+    tcg_debug_assert(shift >=3D 0 && shift < ((int64_t)8 << vece));
     if (shift =3D=3D 0) {
         tcg_gen_gvec_mov(vece, dofs, aofs, oprsz, maxsz);
     } else {
@@ -2579,7 +2579,7 @@ void tcg_gen_gvec_shri(unsigned vece, uint32_t dofs=
, uint32_t aofs,
     };
=20
     tcg_debug_assert(vece <=3D MO_64);
-    tcg_debug_assert(shift >=3D 0 && shift < (8 << vece));
+    tcg_debug_assert(shift >=3D 0 && shift < ((int64_t)8 << vece));
     if (shift =3D=3D 0) {
         tcg_gen_gvec_mov(vece, dofs, aofs, oprsz, maxsz);
     } else {
@@ -2595,7 +2595,7 @@ void tcg_gen_vec_sar8i_i64(TCGv_i64 d, TCGv_i64 a, =
int64_t c)
=20
     tcg_gen_shri_i64(d, a, c);
     tcg_gen_andi_i64(s, d, s_mask);  /* isolate (shifted) sign bit */
-    tcg_gen_muli_i64(s, s, (2 << c) - 2); /* replicate isolated signs */
+    tcg_gen_muli_i64(s, s, ((int64_t)2 << c) - 2); /* replicate isolated=
 signs */
     tcg_gen_andi_i64(d, d, c_mask);  /* clear out bits above sign  */
     tcg_gen_or_i64(d, d, s);         /* include sign extension */
     tcg_temp_free_i64(s);
@@ -2610,7 +2610,7 @@ void tcg_gen_vec_sar16i_i64(TCGv_i64 d, TCGv_i64 a,=
 int64_t c)
     tcg_gen_shri_i64(d, a, c);
     tcg_gen_andi_i64(s, d, s_mask);  /* isolate (shifted) sign bit */
     tcg_gen_andi_i64(d, d, c_mask);  /* clear out bits above sign  */
-    tcg_gen_muli_i64(s, s, (2 << c) - 2); /* replicate isolated signs */
+    tcg_gen_muli_i64(s, s, ((int64_t)2 << c) - 2); /* replicate isolated=
 signs */
     tcg_gen_or_i64(d, d, s);         /* include sign extension */
     tcg_temp_free_i64(s);
 }
@@ -2644,7 +2644,7 @@ void tcg_gen_gvec_sari(unsigned vece, uint32_t dofs=
, uint32_t aofs,
     };
=20
     tcg_debug_assert(vece <=3D MO_64);
-    tcg_debug_assert(shift >=3D 0 && shift < (8 << vece));
+    tcg_debug_assert(shift >=3D 0 && shift < ((int64_t)8 << vece));
     if (shift =3D=3D 0) {
         tcg_gen_gvec_mov(vece, dofs, aofs, oprsz, maxsz);
     } else {
@@ -2881,7 +2881,7 @@ static void tcg_gen_shlv_mod_vec(unsigned vece, TCG=
v_vec d,
 {
     TCGv_vec t =3D tcg_temp_new_vec_matching(d);
=20
-    tcg_gen_dupi_vec(vece, t, (8 << vece) - 1);
+    tcg_gen_dupi_vec(vece, t, ((uint64_t)8 << vece) - 1);
     tcg_gen_and_vec(vece, t, t, b);
     tcg_gen_shlv_vec(vece, d, a, t);
     tcg_temp_free_vec(t);
@@ -2944,7 +2944,7 @@ static void tcg_gen_shrv_mod_vec(unsigned vece, TCG=
v_vec d,
 {
     TCGv_vec t =3D tcg_temp_new_vec_matching(d);
=20
-    tcg_gen_dupi_vec(vece, t, (8 << vece) - 1);
+    tcg_gen_dupi_vec(vece, t, ((uint64_t)8 << vece) - 1);
     tcg_gen_and_vec(vece, t, t, b);
     tcg_gen_shrv_vec(vece, d, a, t);
     tcg_temp_free_vec(t);
@@ -3007,7 +3007,7 @@ static void tcg_gen_sarv_mod_vec(unsigned vece, TCG=
v_vec d,
 {
     TCGv_vec t =3D tcg_temp_new_vec_matching(d);
=20
-    tcg_gen_dupi_vec(vece, t, (8 << vece) - 1);
+    tcg_gen_dupi_vec(vece, t, ((uint64_t)8 << vece) - 1);
     tcg_gen_and_vec(vece, t, t, b);
     tcg_gen_sarv_vec(vece, d, a, t);
     tcg_temp_free_vec(t);
diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
index b6937e8d64..4cf1dc4e8e 100644
--- a/tcg/tcg-op-vec.c
+++ b/tcg/tcg-op-vec.c
@@ -483,7 +483,7 @@ void tcg_gen_abs_vec(unsigned vece, TCGv_vec r, TCGv_=
vec a)
             tcg_gen_smax_vec(vece, r, a, t);
         } else {
             if (tcg_can_emit_vec_op(INDEX_op_sari_vec, type, vece) > 0) =
{
-                tcg_gen_sari_vec(vece, t, a, (8 << vece) - 1);
+                tcg_gen_sari_vec(vece, t, a, ((int64_t)8 << vece) - 1);
             } else {
                 do_dupi_vec(t, MO_REG, 0);
                 tcg_gen_cmp_vec(TCG_COND_LT, vece, t, a, t);
@@ -508,7 +508,7 @@ static void do_shifti(TCGOpcode opc, unsigned vece,
     int can;
=20
     tcg_debug_assert(at->base_type =3D=3D type);
-    tcg_debug_assert(i >=3D 0 && i < (8 << vece));
+    tcg_debug_assert(i >=3D 0 && i < ((int64_t)8 << vece));
     tcg_assert_listed_vecop(opc);
=20
     if (i =3D=3D 0) {
--=20
2.19.1



