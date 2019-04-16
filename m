Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 496F9C10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 18:57:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B5B22063F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 18:57:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B5B22063F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41084 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGTGy-0008A0-6M
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 14:57:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hGTCh-0004P5-Ub
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 14:53:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hGTCg-0003r6-QQ
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 14:53:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54746)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>)
	id 1hGTCg-0003oI-EI; Tue, 16 Apr 2019 14:53:10 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B074F81F13;
	Tue, 16 Apr 2019 18:53:09 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-105.ams2.redhat.com [10.36.116.105])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1ADBA5D707;
	Tue, 16 Apr 2019 18:53:07 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 16 Apr 2019 20:52:22 +0200
Message-Id: <20190416185301.25344-3-david@redhat.com>
In-Reply-To: <20190416185301.25344-1-david@redhat.com>
References: <20190416185301.25344-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Tue, 16 Apr 2019 18:53:09 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 02/41] s390x/tcg: Implement VECTOR ADD
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
Cc: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190416185222.AxWHnZuTwVMhnH2vCEcgxlnlyp2ubsZ3xgEbeQxA3YQ@z>

Introduce two types of fancy new helpers that will be reused a couple of
times

1. gen_gvec_fn_3: Call an existing tcg_gen_gvec_X function with 3
   parameters, simplifying parameter passing
2. gen_gvec128_3_i64: Call a function that performs 128 bit calculations
   using two 64 bit values per vector.

Luckily, for VECTOR ADD we already have everything we need.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/insn-data.def      |  5 ++++
 target/s390x/translate_vx.inc.c | 52 +++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 71fa9b8d6c..74a0ccc770 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1054,6 +1054,11 @@
 /* VECTOR UNPACK LOGICAL LOW */
     F(0xe7d4, VUPLL,   VRR_a, V,   0, 0, 0, 0, vup, 0, IF_VEC)
=20
+/* =3D=3D=3D Vector Integer Instructions =3D=3D=3D */
+
+/* VECTOR ADD */
+    F(0xe7f3, VA,      VRR_c, V,   0, 0, 0, 0, va, 0, IF_VEC)
+
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
     E(0xb250, CSP,     RRE,   Z,   r1_32u, ra2, r1_P, 0, csp, 0, MO_TEUL=
, IF_PRIV)
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
index 76f9a5d939..2f84ea0511 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -157,6 +157,41 @@ static void get_vec_element_ptr_i64(TCGv_ptr ptr, ui=
nt8_t reg, TCGv_i64 enr,
                      16)
 #define gen_gvec_dup64i(v1, c) \
     tcg_gen_gvec_dup64i(vec_full_reg_offset(v1), 16, 16, c)
+#define gen_gvec_fn_3(fn, es, v1, v2, v3) \
+    tcg_gen_gvec_##fn(es, vec_full_reg_offset(v1), vec_full_reg_offset(v=
2), \
+                      vec_full_reg_offset(v3), 16, 16)
+
+/*
+ * Helper to carry out a 128 bit vector computation using 2 i64 values p=
er
+ * vector.
+ */
+typedef void (*gen_gvec128_3_i64_fn)(TCGv_i64 dl, TCGv_i64 dh, TCGv_i64 =
al,
+                                     TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 =
bh);
+static void gen_gvec128_3_i64(gen_gvec128_3_i64_fn fn, uint8_t d, uint8_=
t a,
+                              uint8_t b)
+{
+        TCGv_i64 dh =3D tcg_temp_new_i64();
+        TCGv_i64 dl =3D tcg_temp_new_i64();
+        TCGv_i64 ah =3D tcg_temp_new_i64();
+        TCGv_i64 al =3D tcg_temp_new_i64();
+        TCGv_i64 bh =3D tcg_temp_new_i64();
+        TCGv_i64 bl =3D tcg_temp_new_i64();
+
+        read_vec_element_i64(ah, a, 0, ES_64);
+        read_vec_element_i64(al, a, 1, ES_64);
+        read_vec_element_i64(bh, b, 0, ES_64);
+        read_vec_element_i64(bl, b, 1, ES_64);
+        fn(dl, dh, al, ah, bl, bh);
+        write_vec_element_i64(dh, d, 0, ES_64);
+        write_vec_element_i64(dl, d, 1, ES_64);
+
+        tcg_temp_free_i64(dh);
+        tcg_temp_free_i64(dl);
+        tcg_temp_free_i64(ah);
+        tcg_temp_free_i64(al);
+        tcg_temp_free_i64(bh);
+        tcg_temp_free_i64(bl);
+}
=20
 static void gen_gvec_dupi(uint8_t es, uint8_t reg, uint64_t c)
 {
@@ -933,3 +968,20 @@ static DisasJumpType op_vup(DisasContext *s, DisasOp=
s *o)
     tcg_temp_free_i64(tmp);
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_va(DisasContext *s, DisasOps *o)
+{
+    const uint8_t es =3D get_field(s->fields, m4);
+
+    if (es > ES_128) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    } else if (es =3D=3D ES_128) {
+        gen_gvec128_3_i64(tcg_gen_add2_i64, get_field(s->fields, v1),
+                          get_field(s->fields, v2), get_field(s->fields,=
 v3));
+        return DISAS_NEXT;
+    }
+    gen_gvec_fn_3(add, es, get_field(s->fields, v1), get_field(s->fields=
, v2),
+                  get_field(s->fields, v3));
+    return DISAS_NEXT;
+}
--=20
2.20.1


