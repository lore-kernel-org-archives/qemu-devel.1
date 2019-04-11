Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 128C6C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 10:55:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAE81217D4
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 10:55:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAE81217D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46199 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEXMQ-0005El-VH
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 06:55:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hEWsh-00039p-VW
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 06:24:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hEWdW-00078e-9V
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 06:08:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:16001)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>)
	id 1hEWdV-00078L-Uf; Thu, 11 Apr 2019 06:08:50 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3ED6A3097063;
	Thu, 11 Apr 2019 10:08:49 +0000 (UTC)
Received: from t460s.redhat.com (unknown [10.36.118.43])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E36FB1001E71;
	Thu, 11 Apr 2019 10:08:47 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 11 Apr 2019 12:07:59 +0200
Message-Id: <20190411100836.646-5-david@redhat.com>
In-Reply-To: <20190411100836.646-1-david@redhat.com>
References: <20190411100836.646-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Thu, 11 Apr 2019 10:08:49 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v1 04/41] s390x/tcg: Implement VECTOR ADD WITH
 CARRY
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
Message-ID: <20190411100759.51t0ijyh_KzDFtPV7gNl_wt0Jgo5F8XuW6y0sAgn9fw@z>

Only slightly ugly, perform two additions. At least it is only supported
for 128 bit elements.

Introduce gen_gvec128_4_i64() similar to gen_gvec128_3_i64().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/insn-data.def      |  2 ++
 target/s390x/translate_vx.inc.c | 63 +++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index f0e62b9aa8..38d1e22a6d 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1060,6 +1060,8 @@
     F(0xe7f3, VA,      VRR_c, V,   0, 0, 0, 0, va, 0, IF_VEC)
 /* VECTOR ADD COMPUTE CARRY */
     F(0xe7f1, VACC,    VRR_c, V,   0, 0, 0, 0, vacc, 0, IF_VEC)
+/* VECTOR ADD WITH CARRY */
+    F(0xe7bb, VAC,     VRR_d, V,   0, 0, 0, 0, vac, 0, IF_VEC)
=20
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
index c3bc47f1a9..111b0b7c69 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -196,6 +196,41 @@ static void gen_gvec128_3_i64(gen_gvec128_3_i64_fn f=
n, uint8_t d, uint8_t a,
         tcg_temp_free_i64(bl);
 }
=20
+typedef void (*gen_gvec128_4_i64_fn)(TCGv_i64 dl, TCGv_i64 dh, TCGv_i64 =
al,
+                                     TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 =
bh,
+                                     TCGv_i64 cl, TCGv_i64 ch);
+static void gen_gvec128_4_i64(gen_gvec128_4_i64_fn fn, uint8_t d, uint8_=
t a,
+                              uint8_t b, uint8_t c)
+{
+        TCGv_i64 dh =3D tcg_temp_new_i64();
+        TCGv_i64 dl =3D tcg_temp_new_i64();
+        TCGv_i64 ah =3D tcg_temp_new_i64();
+        TCGv_i64 al =3D tcg_temp_new_i64();
+        TCGv_i64 bh =3D tcg_temp_new_i64();
+        TCGv_i64 bl =3D tcg_temp_new_i64();
+        TCGv_i64 ch =3D tcg_temp_new_i64();
+        TCGv_i64 cl =3D tcg_temp_new_i64();
+
+        read_vec_element_i64(ah, a, 0, ES_64);
+        read_vec_element_i64(al, a, 1, ES_64);
+        read_vec_element_i64(bh, b, 0, ES_64);
+        read_vec_element_i64(bl, b, 1, ES_64);
+        read_vec_element_i64(ch, c, 0, ES_64);
+        read_vec_element_i64(cl, c, 1, ES_64);
+        fn(dl, dh, al, ah, bl, bh, cl, ch);
+        write_vec_element_i64(dh, d, 0, ES_64);
+        write_vec_element_i64(dl, d, 1, ES_64);
+
+        tcg_temp_free_i64(dh);
+        tcg_temp_free_i64(dl);
+        tcg_temp_free_i64(ah);
+        tcg_temp_free_i64(al);
+        tcg_temp_free_i64(bh);
+        tcg_temp_free_i64(bl);
+        tcg_temp_free_i64(ch);
+        tcg_temp_free_i64(cl);
+}
+
 static void gen_gvec_dupi(uint8_t es, uint8_t reg, uint64_t c)
 {
     switch (es) {
@@ -1059,3 +1094,31 @@ static DisasJumpType op_vacc(DisasContext *s, Disa=
sOps *o)
                get_field(s->fields, v3), &g[es]);
     return DISAS_NEXT;
 }
+
+static void gen_ac2_i64(TCGv_i64 dl, TCGv_i64 dh, TCGv_i64 al, TCGv_i64 =
ah,
+                        TCGv_i64 bl, TCGv_i64 bh, TCGv_i64 cl, TCGv_i64 =
ch)
+{
+    TCGv_i64 tl =3D tcg_temp_new_i64();
+    TCGv_i64 th =3D tcg_const_i64(0);
+
+    /* extract the carry only */
+    tcg_gen_extract_i64(tl, cl, 0, 1);
+    tcg_gen_add2_i64(dl, dh, al, ah, bl, bh);
+    tcg_gen_add2_i64(dl, dh, dl, dh, tl, th);
+
+    tcg_temp_free_i64(tl);
+    tcg_temp_free_i64(th);
+}
+
+static DisasJumpType op_vac(DisasContext *s, DisasOps *o)
+{
+    if (get_field(s->fields, m5) !=3D ES_128) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
+    gen_gvec128_4_i64(gen_ac2_i64, get_field(s->fields, v1),
+                      get_field(s->fields, v2), get_field(s->fields, v3)=
,
+                      get_field(s->fields, v4));
+    return DISAS_NEXT;
+}
--=20
2.20.1


