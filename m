Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6621AC282CE
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 10:57:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A3F22184B
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 10:57:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A3F22184B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46284 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEXOs-0007Zb-C4
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 06:57:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hEWsj-0002dl-Tj
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 06:24:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hEWdP-000767-3G
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 06:08:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55134)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>)
	id 1hEWdO-00075t-P7; Thu, 11 Apr 2019 06:08:43 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F0C943082133;
	Thu, 11 Apr 2019 10:08:41 +0000 (UTC)
Received: from t460s.redhat.com (unknown [10.36.118.43])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A34BA1001E82;
	Thu, 11 Apr 2019 10:08:40 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 11 Apr 2019 12:07:56 +0200
Message-Id: <20190411100836.646-2-david@redhat.com>
In-Reply-To: <20190411100836.646-1-david@redhat.com>
References: <20190411100836.646-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Thu, 11 Apr 2019 10:08:42 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v1 01/41] tcg: Implement tcg_gen_gvec_3i()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
	David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190411100756.LfZgAHzCfu2NQ9-wpsjrtrzFgvHQ4mhQgSX_FohIQBs@z>

Let's add tcg_gen_gvec_3i(), similar to tcg_gen_gvec_2i(), however
without introducing "gen_helper_gvec_3i *fnoi", as it isn't needed
for now.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 tcg/tcg-op-gvec.c | 139 ++++++++++++++++++++++++++++++++++++++++++++++
 tcg/tcg-op-gvec.h |  24 ++++++++
 2 files changed, 163 insertions(+)

diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 0996ef0812..f831adb4e7 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -663,6 +663,29 @@ static void expand_3_i32(uint32_t dofs, uint32_t aof=
s,
     tcg_temp_free_i32(t0);
 }
=20
+static void expand_3i_i32(uint32_t dofs, uint32_t aofs, uint32_t bofs,
+                          uint32_t oprsz, int32_t c, bool load_dest,
+                          void (*fni)(TCGv_i32, TCGv_i32, TCGv_i32, int3=
2_t))
+{
+    TCGv_i32 t0 =3D tcg_temp_new_i32();
+    TCGv_i32 t1 =3D tcg_temp_new_i32();
+    TCGv_i32 t2 =3D tcg_temp_new_i32();
+    uint32_t i;
+
+    for (i =3D 0; i < oprsz; i +=3D 4) {
+        tcg_gen_ld_i32(t0, cpu_env, aofs + i);
+        tcg_gen_ld_i32(t1, cpu_env, bofs + i);
+        if (load_dest) {
+            tcg_gen_ld_i32(t2, cpu_env, dofs + i);
+        }
+        fni(t2, t0, t1, c);
+        tcg_gen_st_i32(t2, cpu_env, dofs + i);
+    }
+    tcg_temp_free_i32(t0);
+    tcg_temp_free_i32(t1);
+    tcg_temp_free_i32(t2);
+}
+
 /* Expand OPSZ bytes worth of three-operand operations using i32 element=
s.  */
 static void expand_4_i32(uint32_t dofs, uint32_t aofs, uint32_t bofs,
                          uint32_t cofs, uint32_t oprsz, bool write_aofs,
@@ -770,6 +793,29 @@ static void expand_3_i64(uint32_t dofs, uint32_t aof=
s,
     tcg_temp_free_i64(t0);
 }
=20
+static void expand_3i_i64(uint32_t dofs, uint32_t aofs, uint32_t bofs,
+                          uint32_t oprsz, int64_t c, bool load_dest,
+                          void (*fni)(TCGv_i64, TCGv_i64, TCGv_i64, int6=
4_t))
+{
+    TCGv_i64 t0 =3D tcg_temp_new_i64();
+    TCGv_i64 t1 =3D tcg_temp_new_i64();
+    TCGv_i64 t2 =3D tcg_temp_new_i64();
+    uint32_t i;
+
+    for (i =3D 0; i < oprsz; i +=3D 8) {
+        tcg_gen_ld_i64(t0, cpu_env, aofs + i);
+        tcg_gen_ld_i64(t1, cpu_env, bofs + i);
+        if (load_dest) {
+            tcg_gen_ld_i64(t2, cpu_env, dofs + i);
+        }
+        fni(t2, t0, t1, c);
+        tcg_gen_st_i64(t2, cpu_env, dofs + i);
+    }
+    tcg_temp_free_i64(t0);
+    tcg_temp_free_i64(t1);
+    tcg_temp_free_i64(t2);
+}
+
 /* Expand OPSZ bytes worth of three-operand operations using i64 element=
s.  */
 static void expand_4_i64(uint32_t dofs, uint32_t aofs, uint32_t bofs,
                          uint32_t cofs, uint32_t oprsz, bool write_aofs,
@@ -883,6 +929,35 @@ static void expand_3_vec(unsigned vece, uint32_t dof=
s, uint32_t aofs,
     tcg_temp_free_vec(t0);
 }
=20
+/*
+ * Expand OPSZ bytes worth of three-vector operands and an immediate ope=
rand
+ * using host vectors.
+ */
+static void expand_3i_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
+                          uint32_t bofs, uint32_t oprsz, uint32_t tysz,
+                          TCGType type, int64_t c, bool load_dest,
+                          void (*fni)(unsigned, TCGv_vec, TCGv_vec, TCGv=
_vec,
+                                      int64_t))
+{
+    TCGv_vec t0 =3D tcg_temp_new_vec(type);
+    TCGv_vec t1 =3D tcg_temp_new_vec(type);
+    TCGv_vec t2 =3D tcg_temp_new_vec(type);
+    uint32_t i;
+
+    for (i =3D 0; i < oprsz; i +=3D tysz) {
+        tcg_gen_ld_vec(t0, cpu_env, aofs + i);
+        tcg_gen_ld_vec(t1, cpu_env, bofs + i);
+        if (load_dest) {
+            tcg_gen_ld_vec(t2, cpu_env, dofs + i);
+        }
+        fni(vece, t2, t0, t1, c);
+        tcg_gen_st_vec(t2, cpu_env, dofs + i);
+    }
+    tcg_temp_free_vec(t0);
+    tcg_temp_free_vec(t1);
+    tcg_temp_free_vec(t2);
+}
+
 /* Expand OPSZ bytes worth of four-operand operations using host vectors=
.  */
 static void expand_4_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
                          uint32_t bofs, uint32_t cofs, uint32_t oprsz,
@@ -1174,6 +1249,70 @@ void tcg_gen_gvec_3(uint32_t dofs, uint32_t aofs, =
uint32_t bofs,
     }
 }
=20
+/* Expand a vector operation with three vectors and an immediate.  */
+void tcg_gen_gvec_3i(uint32_t dofs, uint32_t aofs, uint32_t bofs,
+                     uint32_t oprsz, uint32_t maxsz, int64_t c,
+                     const GVecGen3i *g)
+{
+    TCGType type;
+    uint32_t some;
+
+    check_size_align(oprsz, maxsz, dofs | aofs | bofs);
+    check_overlap_3(dofs, aofs, bofs, maxsz);
+
+    type =3D 0;
+    if (g->fniv) {
+        type =3D choose_vector_type(g->opc, g->vece, oprsz, g->prefer_i6=
4);
+    }
+    switch (type) {
+    case TCG_TYPE_V256:
+        /*
+         * Recall that ARM SVE allows vector sizes that are not a
+         * power of 2, but always a multiple of 16.  The intent is
+         * that e.g. size =3D=3D 80 would be expanded with 2x32 + 1x16.
+         */
+        some =3D QEMU_ALIGN_DOWN(oprsz, 32);
+        expand_3i_vec(g->vece, dofs, aofs, bofs, some, 32, TCG_TYPE_V256=
,
+                      c, g->load_dest, g->fniv);
+        if (some =3D=3D oprsz) {
+            break;
+        }
+        dofs +=3D some;
+        aofs +=3D some;
+        bofs +=3D some;
+        oprsz -=3D some;
+        maxsz -=3D some;
+        /* fallthru */
+    case TCG_TYPE_V128:
+        expand_3i_vec(g->vece, dofs, aofs, bofs, oprsz, 16, TCG_TYPE_V12=
8,
+                      c, g->load_dest, g->fniv);
+        break;
+    case TCG_TYPE_V64:
+        expand_3i_vec(g->vece, dofs, aofs, bofs, oprsz, 8, TCG_TYPE_V64,
+                      c, g->load_dest, g->fniv);
+        break;
+
+    case 0:
+        if (g->fni8 && check_size_impl(oprsz, 8)) {
+            expand_3i_i64(dofs, aofs, bofs, oprsz, c, g->load_dest, g->f=
ni8);
+        } else if (g->fni4 && check_size_impl(oprsz, 4)) {
+            expand_3i_i32(dofs, aofs, bofs, oprsz, c, g->load_dest, g->f=
ni4);
+        } else {
+            assert(g->fno !=3D NULL);
+            tcg_gen_gvec_3_ool(dofs, aofs, bofs, oprsz, maxsz, c, g->fno=
);
+            return;
+        }
+        break;
+
+    default:
+        g_assert_not_reached();
+    }
+
+    if (oprsz < maxsz) {
+        expand_clr(dofs + oprsz, maxsz - oprsz);
+    }
+}
+
 /* Expand a vector four-operand operation.  */
 void tcg_gen_gvec_4(uint32_t dofs, uint32_t aofs, uint32_t bofs, uint32_=
t cofs,
                     uint32_t oprsz, uint32_t maxsz, const GVecGen4 *g)
diff --git a/tcg/tcg-op-gvec.h b/tcg/tcg-op-gvec.h
index 850da32ded..c093243c4c 100644
--- a/tcg/tcg-op-gvec.h
+++ b/tcg/tcg-op-gvec.h
@@ -164,6 +164,27 @@ typedef struct {
     bool load_dest;
 } GVecGen3;
=20
+typedef struct {
+    /*
+     * Expand inline as a 64-bit or 32-bit integer. Only one of these wi=
ll be
+     * non-NULL.
+     */
+    void (*fni8)(TCGv_i64, TCGv_i64, TCGv_i64, int64_t);
+    void (*fni4)(TCGv_i32, TCGv_i32, TCGv_i32, int32_t);
+    /* Expand inline with a host vector type.  */
+    void (*fniv)(unsigned, TCGv_vec, TCGv_vec, TCGv_vec, int64_t);
+    /* Expand out-of-line helper w/descriptor, data in descriptor.  */
+    gen_helper_gvec_3 *fno;
+    /* The opcode, if any, to which this corresponds.  */
+    TCGOpcode opc;
+    /* The vector element size, if applicable.  */
+    uint8_t vece;
+    /* Prefer i64 to v64.  */
+    bool prefer_i64;
+    /* Load dest as a 3rd source operand.  */
+    bool load_dest;
+} GVecGen3i;
+
 typedef struct {
     /* Expand inline as a 64-bit or 32-bit integer.
        Only one of these will be non-NULL.  */
@@ -193,6 +214,9 @@ void tcg_gen_gvec_2s(uint32_t dofs, uint32_t aofs, ui=
nt32_t oprsz,
                      uint32_t maxsz, TCGv_i64 c, const GVecGen2s *);
 void tcg_gen_gvec_3(uint32_t dofs, uint32_t aofs, uint32_t bofs,
                     uint32_t oprsz, uint32_t maxsz, const GVecGen3 *);
+void tcg_gen_gvec_3i(uint32_t dofs, uint32_t aofs, uint32_t bofs,
+                     uint32_t oprsz, uint32_t maxsz, int64_t c,
+                     const GVecGen3i *);
 void tcg_gen_gvec_4(uint32_t dofs, uint32_t aofs, uint32_t bofs, uint32_=
t cofs,
                     uint32_t oprsz, uint32_t maxsz, const GVecGen4 *);
=20
--=20
2.20.1


