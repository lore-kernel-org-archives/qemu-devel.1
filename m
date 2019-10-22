Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E30CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 10:07:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31D2220700
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 10:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I2nVdcVp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31D2220700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMr50-00035g-Dq
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 06:07:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59413)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iMqsW-0005tj-O6
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 05:55:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iMqsV-0005ld-JM
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 05:55:00 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:53886
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iMqsV-0005lT-GQ
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 05:54:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571738099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T3B9vjpMKr00h9ZEq7Qqnt/7Ax1ma0913f7VWKa9L4o=;
 b=I2nVdcVpaSsmLN5EovJj7wFlcbrWRCB1G1TZStCIgk+pmV7KXk0j1bUbOOYUID/We5u9lJ
 P6Zn6ryXrRqX6AFhHCKN+HMl63M1kBATL3mH7D4xnSxwfdQfmuLCQpA1MKh+uElDnkvD5x
 UUt5KuThXTmiOM+6OdSar01m0+5tuQY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-YLae7-Y9PqqU0yODuFMXDQ-1; Tue, 22 Oct 2019 05:54:55 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5918C5E4;
 Tue, 22 Oct 2019 09:54:54 +0000 (UTC)
Received: from localhost (dhcp-192-218.str.redhat.com [10.33.192.218])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A01FB60856;
 Tue, 22 Oct 2019 09:54:51 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 6/9] s390x/tcg: Fix VECTOR SUBTRACT COMPUTE BORROW INDICATION
Date: Tue, 22 Oct 2019 11:54:25 +0200
Message-Id: <20191022095428.20780-7-cohuck@redhat.com>
In-Reply-To: <20191022095428.20780-1-cohuck@redhat.com>
References: <20191022095428.20780-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: YLae7-Y9PqqU0yODuFMXDQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Hildenbrand <david@redhat.com>

Looks like my idea of what a "borrow" is was wrong. The PoP says:

 "If the resulting subtraction results in a carry out of bit zero, a value
 of one is placed in the corresponding element of the first operand;
 otherwise, a value of zero is placed in the corresponding element"

As clarified by Richard, all we have to do is invert the result.

Fixes: 1ee2d7ba72f6 ("s390x/tcg: Implement VECTOR SUBTRACT COMPUTE BORROW I=
NDICATION")
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20191021085715.3797-5-david@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/translate_vx.inc.c | 7 ++++---
 target/s390x/vec_int_helper.c   | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.in=
c.c
index 5ce7bfb0afc5..6032021d82e7 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -2132,12 +2132,12 @@ static DisasJumpType op_vs(DisasContext *s, DisasOp=
s *o)
=20
 static void gen_scbi_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
 {
-    tcg_gen_setcond_i32(TCG_COND_LTU, d, a, b);
+    tcg_gen_setcond_i32(TCG_COND_GEU, d, a, b);
 }
=20
 static void gen_scbi_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
 {
-    tcg_gen_setcond_i64(TCG_COND_LTU, d, a, b);
+    tcg_gen_setcond_i64(TCG_COND_GEU, d, a, b);
 }
=20
 static void gen_scbi2_i64(TCGv_i64 dl, TCGv_i64 dh, TCGv_i64 al,
@@ -2151,7 +2151,8 @@ static void gen_scbi2_i64(TCGv_i64 dl, TCGv_i64 dh, T=
CGv_i64 al,
     tcg_gen_andi_i64(th, th, 1);
     tcg_gen_sub2_i64(tl, th, ah, zero, th, zero);
     tcg_gen_sub2_i64(tl, th, tl, th, bh, zero);
-    tcg_gen_andi_i64(dl, th, 1);
+    /* "invert" the result: -1 -> 0; 0 -> 1 */
+    tcg_gen_addi_i64(dl, th, 1);
     tcg_gen_mov_i64(dh, zero);
=20
     tcg_temp_free_i64(th);
diff --git a/target/s390x/vec_int_helper.c b/target/s390x/vec_int_helper.c
index d38405848fed..0d6bc13dd603 100644
--- a/target/s390x/vec_int_helper.c
+++ b/target/s390x/vec_int_helper.c
@@ -593,7 +593,7 @@ void HELPER(gvec_vscbi##BITS)(void *v1, const void *v2,=
 const void *v3,        \
         const uint##BITS##_t a =3D s390_vec_read_element##BITS(v2, i);    =
       \
         const uint##BITS##_t b =3D s390_vec_read_element##BITS(v3, i);    =
       \
                                                                           =
     \
-        s390_vec_write_element##BITS(v1, i, a < b);                       =
     \
+        s390_vec_write_element##BITS(v1, i, a >=3D b);                    =
       \
     }                                                                     =
     \
 }
 DEF_VSCBI(8)
--=20
2.21.0


