Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05602C10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 19:00:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1BD120663
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 19:00:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1BD120663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41113 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGTJb-00028i-2p
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 15:00:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hGTD4-0004hx-9h
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 14:53:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hGTD3-0004hY-2c
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 14:53:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37630)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>)
	id 1hGTD2-0004fH-Le; Tue, 16 Apr 2019 14:53:32 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E02FE81112;
	Tue, 16 Apr 2019 18:53:31 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-105.ams2.redhat.com [10.36.116.105])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 69A205D707;
	Tue, 16 Apr 2019 18:53:30 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 16 Apr 2019 20:52:30 +0200
Message-Id: <20190416185301.25344-11-david@redhat.com>
In-Reply-To: <20190416185301.25344-1-david@redhat.com>
References: <20190416185301.25344-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Tue, 16 Apr 2019 18:53:31 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 10/41] s390x/tcg: Implement VECTOR ELEMENT
 COMPARE *
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
Message-ID: <20190416185230.Z_8MY-gjyZd1JHs4MxidD6EUgPQlUG37B97SANMw0gI@z>

Fairly easy to implement, we can make use of the existing CC helpers
cmps64 and cmpu64 - we siply have to sign extend the elements.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/insn-data.def      |  4 ++++
 target/s390x/translate_vx.inc.c | 20 ++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 64459465c5..52e398f515 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1074,6 +1074,10 @@
     F(0xe7f0, VAVGL,   VRR_c, V,   0, 0, 0, 0, vavgl, 0, IF_VEC)
 /* VECTOR CHECKSUM */
     F(0xe766, VCKSM,   VRR_c, V,   0, 0, 0, 0, vcksm, 0, IF_VEC)
+/* VECTOR ELEMENT COMPARE */
+    F(0xe7db, VEC,     VRR_a, V,   0, 0, 0, 0, vec, cmps64, IF_VEC)
+/* VECTOR ELEMENT COMPARE LOGICAL */
+    F(0xe7d9, VECL,    VRR_a, V,   0, 0, 0, 0, vec, cmpu64, IF_VEC)
=20
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
index 0f90f981b6..3f29d3b67a 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -1365,3 +1365,23 @@ static DisasJumpType op_vcksm(DisasContext *s, Dis=
asOps *o)
     tcg_temp_free_i32(sum);
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vec(DisasContext *s, DisasOps *o)
+{
+    uint8_t es =3D get_field(s->fields, m3);
+    const uint8_t enr =3D NUM_VEC_ELEMENTS(es) / 2 - 1;
+
+    if (es > ES_64) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+    if (s->fields->op2 =3D=3D 0xdb) {
+        es |=3D MO_SIGN;
+    }
+
+    o->in1 =3D tcg_temp_new_i64();
+    o->in2 =3D tcg_temp_new_i64();
+    read_vec_element_i64(o->in1, get_field(s->fields, v1), enr, es);
+    read_vec_element_i64(o->in2, get_field(s->fields, v2), enr, es);
+    return DISAS_NEXT;
+}
--=20
2.20.1


