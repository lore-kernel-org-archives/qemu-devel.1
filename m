Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 985F4C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 17:48:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A517206B6
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 17:48:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A517206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39553 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSmOT-0004IA-G6
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 13:48:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hSlmc-0004d8-U6
	for qemu-devel@nongnu.org; Mon, 20 May 2019 13:09:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hSlmb-0004Ux-7Q
	for qemu-devel@nongnu.org; Mon, 20 May 2019 13:09:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:10905)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>)
	id 1hSlma-0004UL-W8; Mon, 20 May 2019 13:09:05 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6412F30842AC;
	Mon, 20 May 2019 17:08:58 +0000 (UTC)
Received: from localhost (ovpn-204-110.brq.redhat.com [10.40.204.110])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id CE25560BFC;
	Mon, 20 May 2019 17:08:53 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 May 2019 19:02:41 +0200
Message-Id: <20190520170302.13643-34-cohuck@redhat.com>
In-Reply-To: <20190520170302.13643-1-cohuck@redhat.com>
References: <20190520170302.13643-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Mon, 20 May 2019 17:09:03 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 33/54] s390x/tcg: Implement VECTOR ELEMENT SHIFT
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
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Hildenbrand <david@redhat.com>

We can use all the fancy new vector helpers implemented by Richard.

One important thing to take care of is always to properly mask of
unused bits from the shift count.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/insn-data.def      |  9 ++++
 target/s390x/translate_vx.inc.c | 84 +++++++++++++++++++++++++++++++++
 2 files changed, 93 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 59c323a7962d..f4b67bda7eb2 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1151,6 +1151,15 @@
     F(0xe733, VERLL,   VRS_a, V,   la2, 0, 0, 0, verll, 0, IF_VEC)
 /* VECTOR ELEMENT ROTATE AND INSERT UNDER MASK */
     F(0xe772, VERIM,   VRI_d, V,   0, 0, 0, 0, verim, 0, IF_VEC)
+/* VECTOR ELEMENT SHIFT LEFT */
+    F(0xe770, VESLV,   VRR_c, V,   0, 0, 0, 0, vesv, 0, IF_VEC)
+    F(0xe730, VESL,    VRS_a, V,   la2, 0, 0, 0, ves, 0, IF_VEC)
+/* VECTOR ELEMENT SHIFT RIGHT ARITHMETIC */
+    F(0xe77a, VESRAV,  VRR_c, V,   0, 0, 0, 0, vesv, 0, IF_VEC)
+    F(0xe73a, VESRA,   VRS_a, V,   la2, 0, 0, 0, ves, 0, IF_VEC)
+/* VECTOR ELEMENT SHIFT RIGHT LOGICAL */
+    F(0xe778, VESRLV,  VRR_c, V,   0, 0, 0, 0, vesv, 0, IF_VEC)
+    F(0xe738, VESRL,   VRS_a, V,   la2, 0, 0, 0, ves, 0, IF_VEC)
=20
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
index a2de139cfcf3..15353096c0b8 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -218,6 +218,12 @@ static void get_vec_element_ptr_i64(TCGv_ptr ptr, ui=
nt8_t reg, TCGv_i64 enr,
 #define gen_gvec_fn_2(fn, es, v1, v2) \
     tcg_gen_gvec_##fn(es, vec_full_reg_offset(v1), vec_full_reg_offset(v=
2), \
                       16, 16)
+#define gen_gvec_fn_2i(fn, es, v1, v2, c) \
+    tcg_gen_gvec_##fn(es, vec_full_reg_offset(v1), vec_full_reg_offset(v=
2), \
+                      c, 16, 16)
+#define gen_gvec_fn_2s(fn, es, v1, v2, s) \
+    tcg_gen_gvec_##fn(es, vec_full_reg_offset(v1), vec_full_reg_offset(v=
2), \
+                      s, 16, 16)
 #define gen_gvec_fn_3(fn, es, v1, v2, v3) \
     tcg_gen_gvec_##fn(es, vec_full_reg_offset(v1), vec_full_reg_offset(v=
2), \
                       vec_full_reg_offset(v3), 16, 16)
@@ -1956,3 +1962,81 @@ static DisasJumpType op_verim(DisasContext *s, Dis=
asOps *o)
                 get_field(s->fields, v3), i4, &g[es]);
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vesv(DisasContext *s, DisasOps *o)
+{
+    const uint8_t es =3D get_field(s->fields, m4);
+    const uint8_t v1 =3D get_field(s->fields, v1);
+    const uint8_t v2 =3D get_field(s->fields, v2);
+    const uint8_t v3 =3D get_field(s->fields, v3);
+
+    if (es > ES_64) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
+    switch (s->fields->op2) {
+    case 0x70:
+        gen_gvec_fn_3(shlv, es, v1, v2, v3);
+        break;
+    case 0x7a:
+        gen_gvec_fn_3(sarv, es, v1, v2, v3);
+        break;
+    case 0x78:
+        gen_gvec_fn_3(shrv, es, v1, v2, v3);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    return DISAS_NEXT;
+}
+
+static DisasJumpType op_ves(DisasContext *s, DisasOps *o)
+{
+    const uint8_t es =3D get_field(s->fields, m4);
+    const uint8_t d2 =3D get_field(s->fields, d2) &
+                       (NUM_VEC_ELEMENT_BITS(es) - 1);
+    const uint8_t v1 =3D get_field(s->fields, v1);
+    const uint8_t v3 =3D get_field(s->fields, v3);
+    TCGv_i32 shift;
+
+    if (es > ES_64) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
+    if (likely(!get_field(s->fields, b2))) {
+        switch (s->fields->op2) {
+        case 0x30:
+            gen_gvec_fn_2i(shli, es, v1, v3, d2);
+            break;
+        case 0x3a:
+            gen_gvec_fn_2i(sari, es, v1, v3, d2);
+            break;
+        case 0x38:
+            gen_gvec_fn_2i(shri, es, v1, v3, d2);
+            break;
+        default:
+            g_assert_not_reached();
+        }
+    } else {
+        shift =3D tcg_temp_new_i32();
+        tcg_gen_extrl_i64_i32(shift, o->addr1);
+        tcg_gen_andi_i32(shift, shift, NUM_VEC_ELEMENT_BITS(es) - 1);
+        switch (s->fields->op2) {
+        case 0x30:
+            gen_gvec_fn_2s(shls, es, v1, v3, shift);
+            break;
+        case 0x3a:
+            gen_gvec_fn_2s(sars, es, v1, v3, shift);
+            break;
+        case 0x38:
+            gen_gvec_fn_2s(shrs, es, v1, v3, shift);
+            break;
+        default:
+            g_assert_not_reached();
+        }
+        tcg_temp_free_i32(shift);
+    }
+    return DISAS_NEXT;
+}
--=20
2.20.1


