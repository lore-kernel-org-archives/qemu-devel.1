Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 399ABCA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 09:05:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0466520873
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 09:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ip3joPZu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0466520873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMTca-0001Mp-2j
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 05:05:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59380)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iMTVS-0001O1-VR
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 04:57:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iMTVR-0008Jh-Pm
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 04:57:38 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32750
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1iMTVR-0008Iv-LE
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 04:57:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571648257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xxrTseFFVinnT6dz7W20NczKajlB+EKJ/qbB4WtneRk=;
 b=Ip3joPZuS+hBw/SAOWU7MJTrjc+joR1QiT7fh0LWQsdURMRwflOXa+VqvdW13oXL34X9Is
 eYnTof6bneQ60pCQujkV9QJyAd8fj8D9q+lSfDdcppM1HSPjVOGCdrKnL4O8lt+YjhnDYK
 UizT+cG8iQQloYXxvwKCmP7z712pBfk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-fHKPS4pVMSOqsSnMasbm6w-1; Mon, 21 Oct 2019 04:57:33 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C13E5107AD31;
 Mon, 21 Oct 2019 08:57:32 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-198.ams2.redhat.com [10.36.116.198])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 417495D717;
 Mon, 21 Oct 2019 08:57:31 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 6/6] s390x/tcg: Fix VECTOR SUBTRACT WITH BORROW COMPUTE
 BORROW INDICATION
Date: Mon, 21 Oct 2019 10:57:15 +0200
Message-Id: <20191021085715.3797-7-david@redhat.com>
In-Reply-To: <20191021085715.3797-1-david@redhat.com>
References: <20191021085715.3797-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: fHKPS4pVMSOqsSnMasbm6w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 Ivan Warren <ivan@vmfacility.fr>, Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The numbers are unsigned, the computation is wrong. "Each operand is
treated as an unsigned binary integer".
Let's implement as given in the PoP:

"A subtraction is performed by adding the contents of the second operand
 with the bitwise complement of the third operand along with a borrow
 indication from the rightmost bit of the fourth operand."

Reuse gen_accc2_i64().

Fixes: bc725e65152c ("s390x/tcg: Implement VECTOR SUBTRACT WITH BORROW COMP=
UTE BORROW INDICATION")
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/translate_vx.inc.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.in=
c.c
index fd746ba35f..71059f9ca0 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -2214,20 +2214,13 @@ static void gen_sbcbi2_i64(TCGv_i64 dl, TCGv_i64 dh=
, TCGv_i64 al, TCGv_i64 ah,
 {
     TCGv_i64 th =3D tcg_temp_new_i64();
     TCGv_i64 tl =3D tcg_temp_new_i64();
-    TCGv_i64 zero =3D tcg_const_i64(0);
=20
-    tcg_gen_andi_i64(tl, cl, 1);
-    tcg_gen_sub2_i64(tl, th, al, zero, tl, zero);
-    tcg_gen_sub2_i64(tl, th, tl, th, bl, zero);
-    tcg_gen_andi_i64(th, th, 1);
-    tcg_gen_sub2_i64(tl, th, ah, zero, th, zero);
-    tcg_gen_sub2_i64(tl, th, tl, th, bh, zero);
-    tcg_gen_andi_i64(dl, th, 1);
-    tcg_gen_mov_i64(dh, zero);
+    tcg_gen_not_i64(tl, bl);
+    tcg_gen_not_i64(th, bh);
+    gen_accc2_i64(dl, dh, al, ah, tl, th, cl, ch);
=20
     tcg_temp_free_i64(tl);
     tcg_temp_free_i64(th);
-    tcg_temp_free_i64(zero);
 }
=20
 static DisasJumpType op_vsbcbi(DisasContext *s, DisasOps *o)
--=20
2.21.0


