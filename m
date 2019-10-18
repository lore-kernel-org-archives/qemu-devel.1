Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C79CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 16:19:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB0A5205C9
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 16:19:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB0A5205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLUyb-0007W5-Ll
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 12:19:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48979)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iLUqF-0007T4-BX
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 12:11:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iLUqA-0007Se-Iu
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 12:11:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53458)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1iLUqA-0007Rx-5O; Fri, 18 Oct 2019 12:10:58 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6354418CCEE2;
 Fri, 18 Oct 2019 16:10:57 +0000 (UTC)
Received: from t460s.redhat.com (unknown [10.36.118.23])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D95383DB4;
 Fri, 18 Oct 2019 16:10:55 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 3/6] s390x/tcg: Fix VECTOR SHIFT RIGHT ARITHMETIC BY BYTE
Date: Fri, 18 Oct 2019 18:10:41 +0200
Message-Id: <20191018161044.6983-4-david@redhat.com>
In-Reply-To: <20191018161044.6983-1-david@redhat.com>
References: <20191018161044.6983-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Fri, 18 Oct 2019 16:10:57 +0000 (UTC)
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

We forgot to propagate the highest bit accross the high doubleword in
two cases (shift >=3D64).

Fixes: 5f724887e3dd ("s390x/tcg: Implement VECTOR SHIFT RIGHT ARITHMETIC"=
)
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/vec_int_helper.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/s390x/vec_int_helper.c b/target/s390x/vec_int_helper.=
c
index 1b3aaecbdb..d38405848f 100644
--- a/target/s390x/vec_int_helper.c
+++ b/target/s390x/vec_int_helper.c
@@ -70,15 +70,17 @@ static void s390_vec_sar(S390Vector *d, const S390Vec=
tor *a, uint64_t count)
         d->doubleword[0] =3D a->doubleword[0];
         d->doubleword[1] =3D a->doubleword[1];
     } else if (count =3D=3D 64) {
+        tmp =3D (int64_t)a->doubleword[0] >> 63;
         d->doubleword[1] =3D a->doubleword[0];
-        d->doubleword[0] =3D 0;
+        d->doubleword[0] =3D tmp;
     } else if (count < 64) {
         tmp =3D a->doubleword[1] >> count;
         d->doubleword[1] =3D deposit64(tmp, 64 - count, count, a->double=
word[0]);
         d->doubleword[0] =3D (int64_t)a->doubleword[0] >> count;
     } else {
+        tmp =3D (int64_t)a->doubleword[0] >> 63;
         d->doubleword[1] =3D (int64_t)a->doubleword[0] >> (count - 64);
-        d->doubleword[0] =3D 0;
+        d->doubleword[0] =3D tmp;
     }
 }
=20
--=20
2.21.0


