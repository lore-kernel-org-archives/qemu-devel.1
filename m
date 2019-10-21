Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D22CA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 09:03:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E37120873
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 09:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FYBeHPw9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E37120873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMTaf-0006z0-CW
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 05:03:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59244)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iMTVK-0001Ae-5g
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 04:57:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iMTVH-0008De-5e
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 04:57:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55378
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1iMTVH-0008D4-1b
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 04:57:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571648246;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L6wFx65ZMu/HCNWJsK+5QSfFpB7ABzBFCVZWDSbh/bo=;
 b=FYBeHPw94vLYVWehyx7Mheq0VrqFynRPMkLxeowXquwflIen56zQspkSNsrMktrqb8R+YQ
 kTuuBvPcUQeIBt9LLk3S0dW8WUfz+qXE3w6KD7kTwOYqlk3tjss+70Rwynqo1lrKF/SpEY
 KGB9/lqaJ6OA7j9QBQWnJhhQ7s2eyu4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-AseNvGrXOHezlbmYDtPvYw-1; Mon, 21 Oct 2019 04:57:23 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F2B4F1800DD0;
 Mon, 21 Oct 2019 08:57:21 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-198.ams2.redhat.com [10.36.116.198])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 759875D6B0;
 Mon, 21 Oct 2019 08:57:20 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/6] s390x/tcg: Fix VECTOR MULTIPLY LOGICAL ODD
Date: Mon, 21 Oct 2019 10:57:10 +0200
Message-Id: <20191021085715.3797-2-david@redhat.com>
In-Reply-To: <20191021085715.3797-1-david@redhat.com>
References: <20191021085715.3797-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: AseNvGrXOHezlbmYDtPvYw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 Ivan Warren <ivan@vmfacility.fr>, Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We have to read from odd offsets.

Fixes: 2bf3ee38f1f8 ("s390x/tcg: Implement VECTOR MULTIPLY *")
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/vec_int_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/s390x/vec_int_helper.c b/target/s390x/vec_int_helper.c
index 68eaae407b..03ae8631d9 100644
--- a/target/s390x/vec_int_helper.c
+++ b/target/s390x/vec_int_helper.c
@@ -488,7 +488,7 @@ void HELPER(gvec_vmlo##BITS)(void *v1, const void *v2, =
const void *v3,         \
 {                                                                         =
     \
     int i, j;                                                             =
     \
                                                                           =
     \
-    for (i =3D 0, j =3D 0; i < (128 / TBITS); i++, j +=3D 2) {            =
           \
+    for (i =3D 0, j =3D 1; i < (128 / TBITS); i++, j +=3D 2) {            =
           \
         const uint##TBITS##_t a =3D s390_vec_read_element##BITS(v2, j);   =
       \
         const uint##TBITS##_t b =3D s390_vec_read_element##BITS(v3, j);   =
       \
                                                                           =
     \
--=20
2.21.0


