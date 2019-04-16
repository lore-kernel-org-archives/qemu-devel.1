Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B16C10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 19:12:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA16B2075B
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 19:12:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA16B2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41364 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGTVe-0003rq-Tm
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 15:12:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hGTDU-000586-4p
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 14:54:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hGTDS-0005WJ-22
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 14:53:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47256)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>)
	id 1hGTDO-0005OW-MS; Tue, 16 Apr 2019 14:53:56 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C74E0308339E;
	Tue, 16 Apr 2019 18:53:53 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-105.ams2.redhat.com [10.36.116.105])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 492645D707;
	Tue, 16 Apr 2019 18:53:52 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 16 Apr 2019 20:52:41 +0200
Message-Id: <20190416185301.25344-22-david@redhat.com>
In-Reply-To: <20190416185301.25344-1-david@redhat.com>
References: <20190416185301.25344-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Tue, 16 Apr 2019 18:53:53 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 21/41] s390x/tcg: Implement VECTOR NAND
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
Message-ID: <20190416185241.YJf29K2X05YRWmsJonJKNOxgPI2H1XrqGqdNe8T4FD0@z>

Part of vector enhancements facility 1, but easy to implement.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/insn-data.def      | 2 ++
 target/s390x/translate.c        | 1 +
 target/s390x/translate_vx.inc.c | 7 +++++++
 3 files changed, 10 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 2c794a2744..bc8b84e1c2 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1134,6 +1134,8 @@
     F(0xe7a7, VMO,     VRR_c, V,   0, 0, 0, 0, vm, 0, IF_VEC)
 /* VECTOR MULTIPLY LOGICAL ODD */
     F(0xe7a5, VMLO,    VRR_c, V,   0, 0, 0, 0, vm, 0, IF_VEC)
+/* VECTOR NAND */
+    F(0xe76e, VNN,     VRR_c, VE,  0, 0, 0, 0, vnn, 0, IF_VEC)
=20
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index a800aa9dc9..c6378b2b53 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -6099,6 +6099,7 @@ enum DisasInsnEnum {
 #define FAC_PCI         S390_FEAT_ZPCI /* z/PCI facility */
 #define FAC_AIS         S390_FEAT_ADAPTER_INT_SUPPRESSION
 #define FAC_V           S390_FEAT_VECTOR /* vector facility */
+#define FAC_VE          S390_FEAT_VECTOR_ENH /* vector enhancements faci=
lity 1 */
=20
 static const DisasInsn insn_info[] =3D {
 #include "insn-data.def"
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
index fddab1f47e..84ff58823f 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -1815,3 +1815,10 @@ static DisasJumpType op_vm(DisasContext *s, DisasO=
ps *o)
                get_field(s->fields, v3), fn);
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vnn(DisasContext *s, DisasOps *o)
+{
+    gen_gvec_fn_3(nand, ES_8, get_field(s->fields, v1),
+                  get_field(s->fields, v2), get_field(s->fields, v3));
+    return DISAS_NEXT;
+}
--=20
2.20.1


