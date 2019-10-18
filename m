Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D117CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 16:16:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54DB0205C9
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 16:16:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54DB0205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLUvO-0004ZD-0J
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 12:16:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49065)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iLUqP-0007bP-Ui
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 12:11:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iLUqL-0007Yz-6X
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 12:11:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40240)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1iLUqL-0007Uy-0D; Fri, 18 Oct 2019 12:11:09 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D424418C4276;
 Fri, 18 Oct 2019 16:11:02 +0000 (UTC)
Received: from t460s.redhat.com (unknown [10.36.118.23])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 54A963DB4;
 Fri, 18 Oct 2019 16:11:01 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 6/6] s390x/tcg: Fix VECTOR SUBTRACT WITH BORROW COMPUTE
 BORROW INDICATION
Date: Fri, 18 Oct 2019 18:10:44 +0200
Message-Id: <20191018161044.6983-7-david@redhat.com>
In-Reply-To: <20191018161044.6983-1-david@redhat.com>
References: <20191018161044.6983-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.62]); Fri, 18 Oct 2019 16:11:02 +0000 (UTC)
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

The numbers are unsigned, the computation is wrong. "Each operand is
treated as an unsigned binary integer".
Let's implement as given in the PoP:

"A subtraction is performed by adding the contents of the second operand
 with the bitwise complement of the third operand along with a borrow
 indication from the rightmost bit of the fourth operand."

Fixes: bc725e65152c ("s390x/tcg: Implement VECTOR SUBTRACT WITH BORROW CO=
MPUTE BORROW INDICATION")
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/translate_vx.inc.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
index 87b5790db4..2015af9012 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -2240,17 +2240,30 @@ static void gen_sbcbi2_i64(TCGv_i64 dl, TCGv_i64 =
dh, TCGv_i64 al, TCGv_i64 ah,
 {
     TCGv_i64 th =3D tcg_temp_new_i64();
     TCGv_i64 tl =3D tcg_temp_new_i64();
+    TCGv_i64 sh =3D tcg_temp_new_i64();
+    TCGv_i64 sl =3D tcg_temp_new_i64();
     TCGv_i64 zero =3D tcg_const_i64(0);
=20
     tcg_gen_andi_i64(tl, cl, 1);
-    tcg_gen_sub2_i64(tl, th, al, zero, tl, zero);
-    tcg_gen_sub2_i64(tl, th, tl, th, bl, zero);
+    tcg_gen_not_i64(sl, bl);
+    tcg_gen_not_i64(sh, bh);
+
+    /* Add the borrow to the low doubleword of a */
+    tcg_gen_add2_i64(tl, th, al, zero, tl, zero);
+    /* Add the bit-wise complement of b to the low doubleword */
+    tcg_gen_add2_i64(tl, th, tl, th, sl, zero);
+    /* Isolate the carry to the high doubleword */
     tcg_gen_andi_i64(th, th, 1);
-    tcg_gen_sub2_i64(tl, th, ah, zero, th, zero);
-    tcg_gen_sub2_i64(tl, th, tl, th, bh, zero);
+    /* Add the carry to the high doubleword of a */
+    tcg_gen_add2_i64(tl, th, ah, zero, th, zero);
+    /* Add the bit-wise complement of b to the high doubleword */
+    tcg_gen_add2_i64(tl, th, tl, th, sh, zero);
+    /* Isolate the carry to the next doubleword */
     tcg_gen_andi_i64(dl, th, 1);
     tcg_gen_mov_i64(dh, zero);
=20
+    tcg_temp_free_i64(sl);
+    tcg_temp_free_i64(sh);
     tcg_temp_free_i64(tl);
     tcg_temp_free_i64(th);
     tcg_temp_free_i64(zero);
--=20
2.21.0


