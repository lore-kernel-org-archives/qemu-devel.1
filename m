Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95687C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 17:53:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73922206B6
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 17:53:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73922206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39649 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSmTf-00007S-Lc
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 13:53:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hSlog-0006za-Qi
	for qemu-devel@nongnu.org; Mon, 20 May 2019 13:11:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hSloe-0005Zf-Th
	for qemu-devel@nongnu.org; Mon, 20 May 2019 13:11:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47018)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>)
	id 1hSlod-0005Yj-AW; Mon, 20 May 2019 13:11:11 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B482D356EA;
	Mon, 20 May 2019 17:10:57 +0000 (UTC)
Received: from localhost (ovpn-204-110.brq.redhat.com [10.40.204.110])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C099460BFC;
	Mon, 20 May 2019 17:10:38 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 May 2019 19:02:51 +0200
Message-Id: <20190520170302.13643-44-cohuck@redhat.com>
In-Reply-To: <20190520170302.13643-1-cohuck@redhat.com>
References: <20190520170302.13643-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Mon, 20 May 2019 17:11:00 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 43/54] s390x/tcg: Implement VECTOR SUM ACROSS
 QUADWORD
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

Similar to VECTOR SUM ACROSS DOUBLEWORD, however without a loop and
using 128-bit calculations.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/insn-data.def      |  2 ++
 target/s390x/translate_vx.inc.c | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index dd370030824e..2483ee01d7fe 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1184,6 +1184,8 @@
     F(0xe7bd, VSBCBI,  VRR_d, V,   0, 0, 0, 0, vsbcbi, 0, IF_VEC)
 /* VECTOR SUM ACROSS DOUBLEWORD */
     F(0xe765, VSUMG,   VRR_c, V,   0, 0, 0, 0, vsumg, 0, IF_VEC)
+/* VECTOR SUM ACROSS QUADWORD */
+    F(0xe767, VSUMQ,   VRR_c, V,   0, 0, 0, 0, vsumq, 0, IF_VEC)
=20
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
index 7b4efee5c0a2..16bfbfce5738 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -2281,3 +2281,35 @@ static DisasJumpType op_vsumg(DisasContext *s, Dis=
asOps *o)
     tcg_temp_free_i64(tmp);
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vsumq(DisasContext *s, DisasOps *o)
+{
+    const uint8_t es =3D get_field(s->fields, m4);
+    const uint8_t max_idx =3D NUM_VEC_ELEMENTS(es) - 1;
+    TCGv_i64 sumh, suml, zero, tmpl;
+    uint8_t idx;
+
+    if (es < ES_32 || es > ES_64) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
+    sumh =3D tcg_const_i64(0);
+    suml =3D tcg_temp_new_i64();
+    zero =3D tcg_const_i64(0);
+    tmpl =3D tcg_temp_new_i64();
+
+    read_vec_element_i64(suml, get_field(s->fields, v3), max_idx, es);
+    for (idx =3D 0; idx <=3D max_idx; idx++) {
+        read_vec_element_i64(tmpl, get_field(s->fields, v2), idx, es);
+        tcg_gen_add2_i64(suml, sumh, suml, sumh, tmpl, zero);
+    }
+    write_vec_element_i64(sumh, get_field(s->fields, v1), 0, ES_64);
+    write_vec_element_i64(suml, get_field(s->fields, v1), 1, ES_64);
+
+    tcg_temp_free_i64(sumh);
+    tcg_temp_free_i64(suml);
+    tcg_temp_free_i64(zero);
+    tcg_temp_free_i64(tmpl);
+    return DISAS_NEXT;
+}
--=20
2.20.1


