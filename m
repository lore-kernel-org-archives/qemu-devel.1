Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF849C43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 14:21:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4CBC206DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 14:21:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4CBC206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51886 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMCaj-0000mz-Qp
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 10:21:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hMCQS-0008JH-MZ
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:11:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hMCQR-0006t0-Pv
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:11:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:31130)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>)
	id 1hMCQR-0006sf-KR; Thu, 02 May 2019 10:11:03 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E2F1330832C5;
	Thu,  2 May 2019 14:11:02 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-88.ams2.redhat.com [10.36.117.88])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 29E7D3793;
	Thu,  2 May 2019 14:10:59 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu,  2 May 2019 16:09:55 +0200
Message-Id: <20190502141019.6385-17-david@redhat.com>
In-Reply-To: <20190502141019.6385-1-david@redhat.com>
References: <20190502141019.6385-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Thu, 02 May 2019 14:11:02 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 16/40] s390x/tcg: Implement VECTOR LOAD
 POSITIVE
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
Message-ID: <20190502140955.VyJhb8XZc1NvL0aI8U0dAMygGf6rooevhAD9bdK3m3s@z>

Similar to VECTOR LOAD COMPLEMENT.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/insn-data.def      |  2 ++
 target/s390x/translate_vx.inc.c | 13 +++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 07868ff082..fc8886ff42 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1096,6 +1096,8 @@
     F(0xe7bc, VGFMA,   VRR_d, V,   0, 0, 0, 0, vgfma, 0, IF_VEC)
 /* VECTOR LOAD COMPLEMENT */
     F(0xe7de, VLC,     VRR_a, V,   0, 0, 0, 0, vlc, 0, IF_VEC)
+/* VECTOR LOAD POSITIVE */
+    F(0xe7df, VLP,     VRR_a, V,   0, 0, 0, 0, vlp, 0, IF_VEC)
=20
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
index e3cc200679..c2a3dbae32 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -1533,3 +1533,16 @@ static DisasJumpType op_vlc(DisasContext *s, Disas=
Ops *o)
     gen_gvec_fn_2(neg, es, get_field(s->fields, v1), get_field(s->fields=
, v2));
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vlp(DisasContext *s, DisasOps *o)
+{
+    const uint8_t es =3D get_field(s->fields, m3);
+
+    if (es > ES_64) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
+    gen_gvec_fn_2(abs, es, get_field(s->fields, v1), get_field(s->fields=
, v2));
+    return DISAS_NEXT;
+}
--=20
2.20.1


