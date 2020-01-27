Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA63C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 12:26:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F938206D4
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 12:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h9NksTVQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F938206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw3TL-0001eB-KY
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 07:26:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35440)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iw3OB-0000es-9k
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 07:21:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iw3O9-0006ul-3j
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 07:21:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44880
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iw3O8-0006uU-VI
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 07:21:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580127668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g7RuH5GiafUYcGO/Y8Mt8jZfLcnwM6fwDONt3sWDv/0=;
 b=h9NksTVQt6Bx23rqGXOuVjAmKgZHO1O21qkS+8WaUm0YyyMVXYTaEqtTfYB/2b5Hhb4USD
 6QxK6g2SZhVZ9ee/7txR5n/F4t34TrAypf+QyYBjdNwaQwf91FhKxSiYITozD0LBDmeYM1
 2QIXXC8NSAE6cVdbVLIACIjayuNsYoU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-UQaNrpweNOiOQw93jLa70w-1; Mon, 27 Jan 2020 07:21:03 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AE5D3800D41;
 Mon, 27 Jan 2020 12:21:02 +0000 (UTC)
Received: from localhost (ovpn-116-220.ams2.redhat.com [10.36.116.220])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4F37986441;
 Mon, 27 Jan 2020 12:21:02 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 13/15] target/s390x: Remove DisasFields argument from
 extract_insn
Date: Mon, 27 Jan 2020 13:20:14 +0100
Message-Id: <20200127122016.18752-14-cohuck@redhat.com>
In-Reply-To: <20200127122016.18752-1-cohuck@redhat.com>
References: <20200127122016.18752-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: UQaNrpweNOiOQw93jLa70w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

The separate pointer is now redundant.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200123232248.1800-6-richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/translate.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 3674fee10c83..0bd2073718ed 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -6183,8 +6183,7 @@ static void extract_field(DisasFields *o, const Disas=
Field *f, uint64_t insn)
 /* Lookup the insn at the current PC, extracting the operands into O and
    returning the info struct for the insn.  Returns NULL for invalid insn.=
  */
=20
-static const DisasInsn *extract_insn(CPUS390XState *env, DisasContext *s,
-                                     DisasFields *f)
+static const DisasInsn *extract_insn(CPUS390XState *env, DisasContext *s)
 {
     uint64_t insn, pc =3D s->base.pc_next;
     int op, op2, ilen;
@@ -6264,13 +6263,14 @@ static const DisasInsn *extract_insn(CPUS390XState =
*env, DisasContext *s,
         break;
     }
=20
-    memset(f, 0, sizeof(*f));
-    f->raw_insn =3D insn;
-    f->op =3D op;
-    f->op2 =3D op2;
+    memset(&s->fields, 0, sizeof(s->fields));
+    s->fields.raw_insn =3D insn;
+    s->fields.op =3D op;
+    s->fields.op2 =3D op2;
=20
     /* Lookup the instruction.  */
     info =3D lookup_opc(op << 8 | op2);
+    s->insn =3D info;
=20
     /* If we found it, extract the operands.  */
     if (info !=3D NULL) {
@@ -6278,7 +6278,7 @@ static const DisasInsn *extract_insn(CPUS390XState *e=
nv, DisasContext *s,
         int i;
=20
         for (i =3D 0; i < NUM_C_FIELD; ++i) {
-            extract_field(f, &format_info[fmt].op[i], insn);
+            extract_field(&s->fields, &format_info[fmt].op[i], insn);
         }
     }
     return info;
@@ -6302,10 +6302,7 @@ static DisasJumpType translate_one(CPUS390XState *en=
v, DisasContext *s)
     DisasOps o =3D {};
=20
     /* Search for the insn in the table.  */
-    insn =3D extract_insn(env, s, &s->fields);
-
-    /* Set up the strutures we use to communicate with the helpers. */
-    s->insn =3D insn;
+    insn =3D extract_insn(env, s);
=20
     /* Emit insn_start now that we know the ILEN.  */
     tcg_gen_insn_start(s->base.pc_next, s->cc_op, s->ilen);
--=20
2.21.1


