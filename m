Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A76EEC10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 19:00:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A4DB20663
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 19:00:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A4DB20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41111 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGTJW-00024D-Lv
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 15:00:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hGTCj-0004PT-KJ
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 14:53:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hGTCi-0003vk-EF
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 14:53:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37484)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>)
	id 1hGTCi-0003sy-4C; Tue, 16 Apr 2019 14:53:12 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 53EB48830F;
	Tue, 16 Apr 2019 18:53:11 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-105.ams2.redhat.com [10.36.116.105])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0509F5D707;
	Tue, 16 Apr 2019 18:53:09 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 16 Apr 2019 20:52:23 +0200
Message-Id: <20190416185301.25344-4-david@redhat.com>
In-Reply-To: <20190416185301.25344-1-david@redhat.com>
References: <20190416185301.25344-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Tue, 16 Apr 2019 18:53:11 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 03/41] s390x/tcg: Implement VECTOR ADD
 COMPUTE CARRY
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
Message-ID: <20190416185223.3u1JCj_xIHp4M9Uu6MnJtEJ2uJ8TV_KsKhWIWer8AwE@z>

128-bit handling courtesy of Richard H.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/insn-data.def      |  2 +
 target/s390x/translate_vx.inc.c | 94 +++++++++++++++++++++++++++++++++
 2 files changed, 96 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 74a0ccc770..f0e62b9aa8 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1058,6 +1058,8 @@
=20
 /* VECTOR ADD */
     F(0xe7f3, VA,      VRR_c, V,   0, 0, 0, 0, va, 0, IF_VEC)
+/* VECTOR ADD COMPUTE CARRY */
+    F(0xe7f1, VACC,    VRR_c, V,   0, 0, 0, 0, vacc, 0, IF_VEC)
=20
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
index 2f84ea0511..312c5f67be 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -136,6 +136,9 @@ static void get_vec_element_ptr_i64(TCGv_ptr ptr, uin=
t8_t reg, TCGv_i64 enr,
     tcg_temp_free_i64(tmp);
 }
=20
+#define gen_gvec_3(v1, v2, v3, gen) \
+    tcg_gen_gvec_3(vec_full_reg_offset(v1), vec_full_reg_offset(v2), \
+                   vec_full_reg_offset(v3), 16, 16, gen)
 #define gen_gvec_3_ool(v1, v2, v3, data, fn) \
     tcg_gen_gvec_3_ool(vec_full_reg_offset(v1), vec_full_reg_offset(v2),=
 \
                        vec_full_reg_offset(v3), 16, 16, data, fn)
@@ -985,3 +988,94 @@ static DisasJumpType op_va(DisasContext *s, DisasOps=
 *o)
                   get_field(s->fields, v3));
     return DISAS_NEXT;
 }
+
+static void gen_acc(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b, uint8_t es)
+{
+    const uint8_t msb_bit_nr =3D NUM_VEC_ELEMENT_BITS(es) - 1;
+    TCGv_i64 msb_mask =3D tcg_const_i64(dup_const(es, 1ull << msb_bit_nr=
));
+    TCGv_i64 t1 =3D tcg_temp_new_i64();
+    TCGv_i64 t2 =3D tcg_temp_new_i64();
+    TCGv_i64 t3 =3D tcg_temp_new_i64();
+
+    /* Calculate the carry into the MSB, ignoring the old MSBs */
+    tcg_gen_andc_i64(t1, a, msb_mask);
+    tcg_gen_andc_i64(t2, b, msb_mask);
+    tcg_gen_add_i64(t1, t1, t2);
+    /* Calculate the MSB without any carry into it */
+    tcg_gen_xor_i64(t3, a, b);
+    /* Calculate the carry out of the MSB in the MSB bit position */
+    tcg_gen_and_i64(d, a, b);
+    tcg_gen_and_i64(t1, t1, t3);
+    tcg_gen_or_i64(d, d, t1);
+    /* Isolate and shift the carry into position */
+    tcg_gen_and_i64(d, d, msb_mask);
+    tcg_gen_shri_i64(d, d, msb_bit_nr);
+
+    tcg_temp_free_i64(t1);
+    tcg_temp_free_i64(t2);
+    tcg_temp_free_i64(t3);
+}
+
+static void gen_acc8_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
+{
+    gen_acc(d, a, b, ES_8);
+}
+
+static void gen_acc16_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
+{
+    gen_acc(d, a, b, ES_16);
+}
+
+static void gen_acc32_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
+{
+    gen_acc(d, a, b, ES_32);
+}
+
+static void gen_acc_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
+{
+    TCGv_i64 t =3D tcg_temp_new_i64();
+
+    tcg_gen_add_i64(t, a, b);
+    tcg_gen_setcond_i64(TCG_COND_LTU, d, t, b);
+    tcg_temp_free_i64(t);
+}
+
+static void gen_acc2_i64(TCGv_i64 dl, TCGv_i64 dh, TCGv_i64 al,
+                         TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh)
+{
+    TCGv_i64 th =3D tcg_temp_new_i64();
+    TCGv_i64 tl =3D tcg_temp_new_i64();
+    TCGv_i64 zero =3D tcg_const_i64(0);
+
+    tcg_gen_add2_i64(tl, th, al, zero, bl, zero);
+    tcg_gen_add2_i64(tl, th, th, zero, ah, zero);
+    tcg_gen_add2_i64(tl, dl, tl, th, bh, zero);
+    tcg_gen_mov_i64(dh, zero);
+
+    tcg_temp_free_i64(th);
+    tcg_temp_free_i64(tl);
+    tcg_temp_free_i64(zero);
+}
+
+static DisasJumpType op_vacc(DisasContext *s, DisasOps *o)
+{
+    const uint8_t es =3D get_field(s->fields, m4);
+    static const GVecGen3 g[4] =3D {
+        { .fni8 =3D gen_acc8_i64, },
+        { .fni8 =3D gen_acc16_i64, },
+        { .fni8 =3D gen_acc32_i64, },
+        { .fni8 =3D gen_acc_i64, },
+    };
+
+    if (es > ES_128) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    } else if (es =3D=3D ES_128) {
+        gen_gvec128_3_i64(gen_acc2_i64, get_field(s->fields, v1),
+                          get_field(s->fields, v2), get_field(s->fields,=
 v3));
+        return DISAS_NEXT;
+    }
+    gen_gvec_3(get_field(s->fields, v1), get_field(s->fields, v2),
+               get_field(s->fields, v3), &g[es]);
+    return DISAS_NEXT;
+}
--=20
2.20.1


