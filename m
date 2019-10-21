Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D91CCCA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 08:59:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6E81206C2
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 08:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J/6mbrv9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6E81206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMTX5-0003OM-Cw
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 04:59:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59338)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iMTVR-0001Kh-AS
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 04:57:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iMTVQ-0008HX-6L
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 04:57:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29856
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1iMTVQ-0008G1-0R
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 04:57:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571648252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FHlWXoHCnrB0OHhFNh6r59f33Iy5i10scQU1TwDX6JM=;
 b=J/6mbrv9CoNsAzUsLpqzyUhhHKirRK0M2XtfsNK3pItJYq50gGUGddY5y4I6bybrtnVgcG
 p6WzOKUoHQtFvEjxG9iUsoUZLyIi5rJy/+yXm7KDNgM7drrah2BqAEZaaNCpt6bz+MjBr+
 UKAt0Gi5rpR2081wZUr9p3aKS/EgDfI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-xmXgOX7PO56xVTk7WEeFPw-1; Mon, 21 Oct 2019 04:57:28 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4BF4E1005516;
 Mon, 21 Oct 2019 08:57:27 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-198.ams2.redhat.com [10.36.116.198])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1B3A15D6B0;
 Mon, 21 Oct 2019 08:57:23 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/6] s390x/tcg: Fix VECTOR SHIFT RIGHT ARITHMETIC BY BYTE
Date: Mon, 21 Oct 2019 10:57:12 +0200
Message-Id: <20191021085715.3797-4-david@redhat.com>
In-Reply-To: <20191021085715.3797-1-david@redhat.com>
References: <20191021085715.3797-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: xmXgOX7PO56xVTk7WEeFPw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

Fixes: 5f724887e3dd ("s390x/tcg: Implement VECTOR SHIFT RIGHT ARITHMETIC")
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/vec_int_helper.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/s390x/vec_int_helper.c b/target/s390x/vec_int_helper.c
index 1b3aaecbdb..d38405848f 100644
--- a/target/s390x/vec_int_helper.c
+++ b/target/s390x/vec_int_helper.c
@@ -70,15 +70,17 @@ static void s390_vec_sar(S390Vector *d, const S390Vecto=
r *a, uint64_t count)
         d->doubleword[0] =3D a->doubleword[0];
         d->doubleword[1] =3D a->doubleword[1];
     } else if (count =3D=3D 64) {
+        tmp =3D (int64_t)a->doubleword[0] >> 63;
         d->doubleword[1] =3D a->doubleword[0];
-        d->doubleword[0] =3D 0;
+        d->doubleword[0] =3D tmp;
     } else if (count < 64) {
         tmp =3D a->doubleword[1] >> count;
         d->doubleword[1] =3D deposit64(tmp, 64 - count, count, a->doublewo=
rd[0]);
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


