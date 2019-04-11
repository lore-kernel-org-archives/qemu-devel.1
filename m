Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 648B0C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 10:26:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 366432133D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 10:26:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 366432133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45702 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEWuA-0004Uo-BO
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 06:26:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hEWs9-0002Xe-QY
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 06:23:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hEWey-0007oC-Nw
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 06:10:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35573)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>)
	id 1hEWey-0007ns-F2; Thu, 11 Apr 2019 06:10:20 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B8A21368FF;
	Thu, 11 Apr 2019 10:10:19 +0000 (UTC)
Received: from t460s.redhat.com (unknown [10.36.118.43])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6B07E1001E71;
	Thu, 11 Apr 2019 10:10:18 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 11 Apr 2019 12:08:35 +0200
Message-Id: <20190411100836.646-41-david@redhat.com>
In-Reply-To: <20190411100836.646-1-david@redhat.com>
References: <20190411100836.646-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Thu, 11 Apr 2019 10:10:19 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v1 40/41] s390x/tcg: Implement VECTOR SUM
 ACROSS WORD
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
Message-ID: <20190411100835.ZNsqieevVdo5SD2uMs8sSEm2FHurv_mFaSCh-w_brIg@z>

Similar to VECTOR SUM ACROSS DOUBLEWORD.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/insn-data.def      |  2 ++
 target/s390x/translate_vx.inc.c | 29 +++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 2483ee01d7..a52db41388 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1186,6 +1186,8 @@
     F(0xe765, VSUMG,   VRR_c, V,   0, 0, 0, 0, vsumg, 0, IF_VEC)
 /* VECTOR SUM ACROSS QUADWORD */
     F(0xe767, VSUMQ,   VRR_c, V,   0, 0, 0, 0, vsumq, 0, IF_VEC)
+/* VECTOR SUM ACROSS WORD */
+    F(0xe764, VSUM,    VRR_c, V,   0, 0, 0, 0, vsum, 0, IF_VEC)
=20
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
index 995c2b4461..59a9885892 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -2286,3 +2286,32 @@ static DisasJumpType op_vsumq(DisasContext *s, Dis=
asOps *o)
     tcg_temp_free_i64(tmpl);
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vsum(DisasContext *s, DisasOps *o)
+{
+    const uint8_t es =3D get_field(s->fields, m4);
+    TCGv_i32 sum, tmp;
+    uint8_t dst_idx;
+
+    if (es > ES_16) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
+    sum =3D tcg_temp_new_i32();
+    tmp =3D tcg_temp_new_i32();
+    for (dst_idx =3D 0; dst_idx < 4; dst_idx++) {
+        uint8_t idx =3D dst_idx * NUM_VEC_ELEMENTS(es) / 4;
+        const uint8_t max_idx =3D idx + NUM_VEC_ELEMENTS(es) / 4 - 1;
+
+        read_vec_element_i32(sum, get_field(s->fields, v3), max_idx, es)=
;
+        for (; idx <=3D max_idx; idx++) {
+            read_vec_element_i32(tmp, get_field(s->fields, v2), idx, es)=
;
+            tcg_gen_add_i32(sum, sum, tmp);
+        }
+        write_vec_element_i32(sum, get_field(s->fields, v1), dst_idx, ES=
_32);
+    }
+    tcg_temp_free_i32(sum);
+    tcg_temp_free_i32(tmp);
+    return DISAS_NEXT;
+}
--=20
2.20.1


