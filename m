Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74939C43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 14:42:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 457F220656
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 14:42:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 457F220656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52283 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMCvI-0003Id-Ek
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 10:42:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hMCRB-0001Dq-Ss
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:11:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hMCRA-0007au-Vw
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:11:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51846)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>)
	id 1hMCRA-0007a9-Qb; Thu, 02 May 2019 10:11:48 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1ADC4C057E3A;
	Thu,  2 May 2019 14:11:48 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-88.ams2.redhat.com [10.36.117.88])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B705C3793;
	Thu,  2 May 2019 14:11:46 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu,  2 May 2019 16:10:15 +0200
Message-Id: <20190502141019.6385-37-david@redhat.com>
In-Reply-To: <20190502141019.6385-1-david@redhat.com>
References: <20190502141019.6385-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Thu, 02 May 2019 14:11:48 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 36/40] s390x/tcg: Implement VECTOR SUBTRACT
 WITH BORROW COMPUTE BORROW INDICATION
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
Message-ID: <20190502141015.ZrlF0QlYC7mgxBsqMl5Jwe5UJfXc-cXCZ5XYoa0myig@z>

Mostly courtesy of Richard H.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/insn-data.def      |  2 ++
 target/s390x/translate_vx.inc.c | 34 +++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index a60d8531dc..a8d90517f6 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1180,6 +1180,8 @@
     F(0xe7f5, VSCBI,   VRR_c, V,   0, 0, 0, 0, vscbi, 0, IF_VEC)
 /* VECTOR SUBTRACT WITH BORROW INDICATION */
     F(0xe7bf, VSBI,    VRR_d, V,   0, 0, 0, 0, vsbi, 0, IF_VEC)
+/* VECTOR SUBTRACT WITH BORROW COMPUTE BORROW INDICATION */
+    F(0xe7bd, VSBCBI,  VRR_d, V,   0, 0, 0, 0, vsbcbi, 0, IF_VEC)
=20
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
index 6e9cbe4c1a..b0b4d3640e 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -2214,3 +2214,37 @@ static DisasJumpType op_vsbi(DisasContext *s, Disa=
sOps *o)
                       get_field(s->fields, v4));
     return DISAS_NEXT;
 }
+
+static void gen_sbcbi2_i64(TCGv_i64 dl, TCGv_i64 dh, TCGv_i64 al, TCGv_i=
64 ah,
+                           TCGv_i64 bl, TCGv_i64 bh, TCGv_i64 cl, TCGv_i=
64 ch)
+{
+    TCGv_i64 th =3D tcg_temp_new_i64();
+    TCGv_i64 tl =3D tcg_temp_new_i64();
+    TCGv_i64 zero =3D tcg_const_i64(0);
+
+    tcg_gen_andi_i64(tl, cl, 1);
+    tcg_gen_sub2_i64(tl, th, al, zero, tl, zero);
+    tcg_gen_sub2_i64(tl, th, tl, th, bl, zero);
+    tcg_gen_andi_i64(th, th, 1);
+    tcg_gen_sub2_i64(tl, th, ah, zero, th, zero);
+    tcg_gen_sub2_i64(tl, th, tl, th, bh, zero);
+    tcg_gen_andi_i64(dl, th, 1);
+    tcg_gen_mov_i64(dh, zero);
+
+    tcg_temp_free_i64(tl);
+    tcg_temp_free_i64(th);
+    tcg_temp_free_i64(zero);
+}
+
+static DisasJumpType op_vsbcbi(DisasContext *s, DisasOps *o)
+{
+    if (get_field(s->fields, m5) !=3D ES_128) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
+    gen_gvec128_4_i64(gen_sbcbi2_i64, get_field(s->fields, v1),
+                      get_field(s->fields, v2), get_field(s->fields, v3)=
,
+                      get_field(s->fields, v4));
+    return DISAS_NEXT;
+}
--=20
2.20.1


