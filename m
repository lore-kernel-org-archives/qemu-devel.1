Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1553EC04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 11:02:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3EA120656
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 11:02:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3EA120656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46448 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRad3-0001yR-0v
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 07:02:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hRa6n-0006QX-9z
	for qemu-devel@nongnu.org; Fri, 17 May 2019 06:29:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hRa0j-0004RZ-Mj
	for qemu-devel@nongnu.org; Fri, 17 May 2019 06:22:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38696)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>)
	id 1hRa0i-0004Qy-B4; Fri, 17 May 2019 06:22:45 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8B94D9F736;
	Fri, 17 May 2019 10:22:43 +0000 (UTC)
Received: from t460s.redhat.com (unknown [10.36.118.100])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0FEF638E09;
	Fri, 17 May 2019 10:22:39 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 17 May 2019 12:21:10 +0200
Message-Id: <20190517102145.21812-6-david@redhat.com>
In-Reply-To: <20190517102145.21812-1-david@redhat.com>
References: <20190517102145.21812-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Fri, 17 May 2019 10:22:43 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL SUBSYSTEM s390x 05/40] s390x/tcg: Implement
 VECTOR AND (WITH COMPLEMENT)
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

Easy, as we can reuse existing gvec helpers.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/insn-data.def      |  4 ++++
 target/s390x/translate_vx.inc.c | 14 ++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index a531b21908..456d5597ca 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1064,6 +1064,10 @@
     F(0xe7bb, VAC,     VRR_d, V,   0, 0, 0, 0, vac, 0, IF_VEC)
 /* VECTOR ADD WITH CARRY COMPUTE CARRY */
     F(0xe7b9, VACCC,   VRR_d, V,   0, 0, 0, 0, vaccc, 0, IF_VEC)
+/* VECTOR AND */
+    F(0xe768, VN,      VRR_c, V,   0, 0, 0, 0, vn, 0, IF_VEC)
+/* VECTOR AND WITH COMPLEMENT */
+    F(0xe769, VNC,     VRR_c, V,   0, 0, 0, 0, vnc, 0, IF_VEC)
=20
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
index 46b3fe0292..8b4bdb2d21 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -1178,3 +1178,17 @@ static DisasJumpType op_vaccc(DisasContext *s, Dis=
asOps *o)
                       get_field(s->fields, v4));
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vn(DisasContext *s, DisasOps *o)
+{
+    gen_gvec_fn_3(and, ES_8, get_field(s->fields, v1), get_field(s->fiel=
ds, v2),
+                  get_field(s->fields, v3));
+    return DISAS_NEXT;
+}
+
+static DisasJumpType op_vnc(DisasContext *s, DisasOps *o)
+{
+    gen_gvec_fn_3(andc, ES_8, get_field(s->fields, v1),
+                  get_field(s->fields, v2), get_field(s->fields, v3));
+    return DISAS_NEXT;
+}
--=20
2.20.1


