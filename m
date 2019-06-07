Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9FE3C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 11:07:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90F8E20665
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 11:07:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90F8E20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48418 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZCiZ-0004Xs-Qj
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 07:07:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55821)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <cohuck@redhat.com>) id 1hZBaG-0003cN-2E
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:54:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1hZBa9-0003z2-LA
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:54:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59330)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>)
 id 1hZBa2-0003l2-2q; Fri, 07 Jun 2019 05:54:41 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BFADF5F793;
 Fri,  7 Jun 2019 09:54:34 +0000 (UTC)
Received: from localhost (dhcp-192-191.str.redhat.com [10.33.192.191])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5677E8187D;
 Fri,  7 Jun 2019 09:54:32 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  7 Jun 2019 11:52:36 +0200
Message-Id: <20190607095237.11364-35-cohuck@redhat.com>
In-Reply-To: <20190607095237.11364-1-cohuck@redhat.com>
References: <20190607095237.11364-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Fri, 07 Jun 2019 09:54:34 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 34/35] s390x/tcg: Use tcg_gen_gvec_bitsel for
 VECTOR SELECT
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
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

This replaces the target-specific implementations for VSEL.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/translate_vx.inc.c | 38 ++++++---------------------------
 1 file changed, 6 insertions(+), 32 deletions(-)

diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
index 69c675e41187..7b1d31cba5cf 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -245,6 +245,9 @@ static void get_vec_element_ptr_i64(TCGv_ptr ptr, uin=
t8_t reg, TCGv_i64 enr,
 #define gen_gvec_fn_3(fn, es, v1, v2, v3) \
     tcg_gen_gvec_##fn(es, vec_full_reg_offset(v1), vec_full_reg_offset(v=
2), \
                       vec_full_reg_offset(v3), 16, 16)
+#define gen_gvec_fn_4(fn, es, v1, v2, v3, v4) \
+    tcg_gen_gvec_##fn(es, vec_full_reg_offset(v1), vec_full_reg_offset(v=
2), \
+                      vec_full_reg_offset(v3), vec_full_reg_offset(v4), =
16, 16)
=20
 /*
  * Helper to carry out a 128 bit vector computation using 2 i64 values p=
er
@@ -915,40 +918,11 @@ static DisasJumpType op_vsce(DisasContext *s, Disas=
Ops *o)
     return DISAS_NEXT;
 }
=20
-static void gen_sel_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b, TCGv_i64 c)
-{
-    TCGv_i64 t =3D tcg_temp_new_i64();
-
-    /* bit in c not set -> copy bit from b */
-    tcg_gen_andc_i64(t, b, c);
-    /* bit in c set -> copy bit from a */
-    tcg_gen_and_i64(d, a, c);
-    /* merge the results */
-    tcg_gen_or_i64(d, d, t);
-    tcg_temp_free_i64(t);
-}
-
-static void gen_sel_vec(unsigned vece, TCGv_vec d, TCGv_vec a, TCGv_vec =
b,
-                        TCGv_vec c)
-{
-    TCGv_vec t =3D tcg_temp_new_vec_matching(d);
-
-    tcg_gen_andc_vec(vece, t, b, c);
-    tcg_gen_and_vec(vece, d, a, c);
-    tcg_gen_or_vec(vece, d, d, t);
-    tcg_temp_free_vec(t);
-}
-
 static DisasJumpType op_vsel(DisasContext *s, DisasOps *o)
 {
-    static const GVecGen4 gvec_op =3D {
-        .fni8 =3D gen_sel_i64,
-        .fniv =3D gen_sel_vec,
-        .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
-    };
-
-    gen_gvec_4(get_field(s->fields, v1), get_field(s->fields, v2),
-               get_field(s->fields, v3), get_field(s->fields, v4), &gvec=
_op);
+    gen_gvec_fn_4(bitsel, ES_8, get_field(s->fields, v1),
+                  get_field(s->fields, v4), get_field(s->fields, v2),
+                  get_field(s->fields, v3));
     return DISAS_NEXT;
 }
=20
--=20
2.20.1


