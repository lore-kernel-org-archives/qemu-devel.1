Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC0FCA9EA9
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 16:13:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7292621D7C
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 16:13:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7292621D7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLUsP-0000uR-4q
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 12:13:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49017)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iLUqL-0007Xb-7m
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 12:11:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iLUqJ-0007XS-95
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 12:11:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35194)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1iLUqF-0007TS-Aa; Fri, 18 Oct 2019 12:11:04 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 09D701017C0D;
 Fri, 18 Oct 2019 16:11:01 +0000 (UTC)
Received: from t460s.redhat.com (unknown [10.36.118.23])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 821F63DA3;
 Fri, 18 Oct 2019 16:10:59 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 5/6] s390x/tcg: Fix VECTOR SUBTRACT WITH BORROW INDICATION
Date: Fri, 18 Oct 2019 18:10:43 +0200
Message-Id: <20191018161044.6983-6-david@redhat.com>
In-Reply-To: <20191018161044.6983-1-david@redhat.com>
References: <20191018161044.6983-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.64]); Fri, 18 Oct 2019 16:11:01 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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

Testing this, there seems to be something messed up. We are dealing with
unsigned numbers. "Each operand is treated as an unsigned binary integer.=
"
Let's just implement as written in the PoP:

"A subtraction is performed by adding the contents of
 the second operand with the bitwise complement of
 the third operand along with a borrow indication from
 the rightmost bit position of the fourth operand and
 the result is placed in the first operand."

Fixes: 48390a7c2716 ("s390x/tcg: Implement VECTOR SUBTRACT WITH BORROW IN=
DICATION")
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/translate_vx.inc.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
index 40bcc1604e..87b5790db4 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -2207,12 +2207,18 @@ static void gen_sbi2_i64(TCGv_i64 dl, TCGv_i64 dh=
, TCGv_i64 al, TCGv_i64 ah,
                          TCGv_i64 bl, TCGv_i64 bh, TCGv_i64 cl, TCGv_i64=
 ch)
 {
     TCGv_i64 tl =3D tcg_temp_new_i64();
+    TCGv_i64 th =3D tcg_temp_new_i64();
+    TCGv_i64 t =3D tcg_temp_new_i64();
     TCGv_i64 zero =3D tcg_const_i64(0);
=20
-    tcg_gen_andi_i64(tl, cl, 1);
-    tcg_gen_sub2_i64(dl, dh, al, ah, bl, bh);
-    tcg_gen_sub2_i64(dl, dh, dl, dh, tl, zero);
+    tcg_gen_andi_i64(t, cl, 1);
+    tcg_gen_not_i64(tl, bl);
+    tcg_gen_not_i64(th, bh);
+    tcg_gen_add2_i64(dl, dh, al, ah, tl, th);
+    tcg_gen_add2_i64(dl, dh, dl, dh, t, zero);
     tcg_temp_free_i64(tl);
+    tcg_temp_free_i64(th);
+    tcg_temp_free_i64(t);
     tcg_temp_free_i64(zero);
 }
=20
--=20
2.21.0


