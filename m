Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7210CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 09:58:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 914C2214B2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 09:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gF+aS/xo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 914C2214B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMqvY-0000d3-AB
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 05:58:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59430)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iMqsZ-0005y4-9F
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 05:55:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iMqsY-0005mW-3b
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 05:55:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31253
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iMqsX-0005mJ-VI
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 05:55:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571738101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=un2KTAVd6ZU2512JadUGRYADd4HKwD1YIwHJQjkJQ5E=;
 b=gF+aS/xoSaJocIc+TNrNm8j47FEGfbIOnLFw5X+dvXqZ9qWYtFJl74B2eMkgdy/iDDaVOF
 4MBesdKVZEZdtp2ImP6CZItDxZA+9e0+Q8Wveq9YRe6dOwh5grRtUywi8rENkpWbIRIylR
 K5DhPzOzlrNCh8NF7Jm7i/JfoEWApKI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-V6W5uMdqPiKAIDC40xrl9g-1; Tue, 22 Oct 2019 05:54:59 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB865476;
 Tue, 22 Oct 2019 09:54:58 +0000 (UTC)
Received: from localhost (dhcp-192-218.str.redhat.com [10.33.192.218])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CF8931001B39;
 Tue, 22 Oct 2019 09:54:55 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 7/9] s390x/tcg: Fix VECTOR SUBTRACT WITH BORROW INDICATION
Date: Tue, 22 Oct 2019 11:54:26 +0200
Message-Id: <20191022095428.20780-8-cohuck@redhat.com>
In-Reply-To: <20191022095428.20780-1-cohuck@redhat.com>
References: <20191022095428.20780-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: V6W5uMdqPiKAIDC40xrl9g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Hildenbrand <david@redhat.com>

Testing this, there seems to be something messed up. We are dealing with
unsigned numbers. "Each operand is treated as an unsigned binary integer."
Let's just implement as written in the PoP:

"A subtraction is performed by adding the contents of
 the second operand with the bitwise complement of
 the third operand along with a borrow indication from
 the rightmost bit position of the fourth operand and
 the result is placed in the first operand."

We can reuse gen_ac2_i64().

Fixes: 48390a7c2716 ("s390x/tcg: Implement VECTOR SUBTRACT WITH BORROW INDI=
CATION")
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20191021085715.3797-6-david@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/translate_vx.inc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.in=
c.c
index 6032021d82e7..fd746ba35fb6 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -2187,13 +2187,13 @@ static void gen_sbi2_i64(TCGv_i64 dl, TCGv_i64 dh, =
TCGv_i64 al, TCGv_i64 ah,
                          TCGv_i64 bl, TCGv_i64 bh, TCGv_i64 cl, TCGv_i64 c=
h)
 {
     TCGv_i64 tl =3D tcg_temp_new_i64();
-    TCGv_i64 zero =3D tcg_const_i64(0);
+    TCGv_i64 th =3D tcg_temp_new_i64();
=20
-    tcg_gen_andi_i64(tl, cl, 1);
-    tcg_gen_sub2_i64(dl, dh, al, ah, bl, bh);
-    tcg_gen_sub2_i64(dl, dh, dl, dh, tl, zero);
+    tcg_gen_not_i64(tl, bl);
+    tcg_gen_not_i64(th, bh);
+    gen_ac2_i64(dl, dh, al, ah, tl, th, cl, ch);
     tcg_temp_free_i64(tl);
-    tcg_temp_free_i64(zero);
+    tcg_temp_free_i64(th);
 }
=20
 static DisasJumpType op_vsbi(DisasContext *s, DisasOps *o)
--=20
2.21.0


