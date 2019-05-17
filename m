Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80AB4C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 10:46:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F18F2087B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 10:46:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F18F2087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46178 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRaO1-0004wX-Hg
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 06:46:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hRa6T-0006TZ-UG
	for qemu-devel@nongnu.org; Fri, 17 May 2019 06:28:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hRa1d-00056X-8g
	for qemu-devel@nongnu.org; Fri, 17 May 2019 06:23:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60868)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>)
	id 1hRa1d-000568-3X; Fri, 17 May 2019 06:23:41 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 67DA43086201;
	Fri, 17 May 2019 10:23:40 +0000 (UTC)
Received: from t460s.redhat.com (unknown [10.36.118.100])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B751734913;
	Fri, 17 May 2019 10:23:36 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 17 May 2019 12:21:26 +0200
Message-Id: <20190517102145.21812-22-david@redhat.com>
In-Reply-To: <20190517102145.21812-1-david@redhat.com>
References: <20190517102145.21812-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Fri, 17 May 2019 10:23:40 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL SUBSYSTEM s390x 21/40] s390x/tcg: Implement
 VECTOR NOR
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/insn-data.def      | 2 ++
 target/s390x/translate_vx.inc.c | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index bc8b84e1c2..4983867a44 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1136,6 +1136,8 @@
     F(0xe7a5, VMLO,    VRR_c, V,   0, 0, 0, 0, vm, 0, IF_VEC)
 /* VECTOR NAND */
     F(0xe76e, VNN,     VRR_c, VE,  0, 0, 0, 0, vnn, 0, IF_VEC)
+/* VECTOR NOR */
+    F(0xe76b, VNO,     VRR_c, V,   0, 0, 0, 0, vno, 0, IF_VEC)
=20
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
index 7fcb7085e5..0578ff5999 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -1798,3 +1798,10 @@ static DisasJumpType op_vnn(DisasContext *s, Disas=
Ops *o)
                   get_field(s->fields, v2), get_field(s->fields, v3));
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vno(DisasContext *s, DisasOps *o)
+{
+    gen_gvec_fn_3(nor, ES_8, get_field(s->fields, v1), get_field(s->fiel=
ds, v2),
+                  get_field(s->fields, v3));
+    return DISAS_NEXT;
+}
--=20
2.20.1


