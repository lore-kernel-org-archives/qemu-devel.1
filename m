Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675F3C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 10:37:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37A5E20881
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 10:37:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37A5E20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46007 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRaEX-0005JM-BF
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 06:37:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hRa6L-0006QX-Cy
	for qemu-devel@nongnu.org; Fri, 17 May 2019 06:28:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hRa25-0005N2-T6
	for qemu-devel@nongnu.org; Fri, 17 May 2019 06:24:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43830)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>)
	id 1hRa25-0005Md-Nu; Fri, 17 May 2019 06:24:09 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0EC20C070E18;
	Fri, 17 May 2019 10:24:09 +0000 (UTC)
Received: from t460s.redhat.com (unknown [10.36.118.100])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 87C9134910;
	Fri, 17 May 2019 10:24:07 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 17 May 2019 12:21:40 +0200
Message-Id: <20190517102145.21812-36-david@redhat.com>
In-Reply-To: <20190517102145.21812-1-david@redhat.com>
References: <20190517102145.21812-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Fri, 17 May 2019 10:24:09 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL SUBSYSTEM s390x 35/40] s390x/tcg: Implement
 VECTOR SUBTRACT WITH BORROW INDICATION
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

Fairly easy as only 128-bit handling is required. Simply perform the
subtraction and then subtract the borrow.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/insn-data.def      |  2 ++
 target/s390x/translate_vx.inc.c | 26 ++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 94de3c9c7d..a60d8531dc 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1178,6 +1178,8 @@
     F(0xe7f7, VS,      VRR_c, V,   0, 0, 0, 0, vs, 0, IF_VEC)
 /* VECTOR SUBTRACT COMPUTE BORROW INDICATION */
     F(0xe7f5, VSCBI,   VRR_c, V,   0, 0, 0, 0, vscbi, 0, IF_VEC)
+/* VECTOR SUBTRACT WITH BORROW INDICATION */
+    F(0xe7bf, VSBI,    VRR_d, V,   0, 0, 0, 0, vsbi, 0, IF_VEC)
=20
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
index b7052f73f8..66a938a909 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -2192,3 +2192,29 @@ static DisasJumpType op_vscbi(DisasContext *s, Dis=
asOps *o)
                get_field(s->fields, v3), &g[es]);
     return DISAS_NEXT;
 }
+
+static void gen_sbi2_i64(TCGv_i64 dl, TCGv_i64 dh, TCGv_i64 al, TCGv_i64=
 ah,
+                         TCGv_i64 bl, TCGv_i64 bh, TCGv_i64 cl, TCGv_i64=
 ch)
+{
+    TCGv_i64 tl =3D tcg_temp_new_i64();
+    TCGv_i64 zero =3D tcg_const_i64(0);
+
+    tcg_gen_andi_i64(tl, cl, 1);
+    tcg_gen_sub2_i64(dl, dh, al, ah, bl, bh);
+    tcg_gen_sub2_i64(dl, dh, dl, dh, tl, zero);
+    tcg_temp_free_i64(tl);
+    tcg_temp_free_i64(zero);
+}
+
+static DisasJumpType op_vsbi(DisasContext *s, DisasOps *o)
+{
+    if (get_field(s->fields, m5) !=3D ES_128) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
+    gen_gvec128_4_i64(gen_sbi2_i64, get_field(s->fields, v1),
+                      get_field(s->fields, v2), get_field(s->fields, v3)=
,
+                      get_field(s->fields, v4));
+    return DISAS_NEXT;
+}
--=20
2.20.1


