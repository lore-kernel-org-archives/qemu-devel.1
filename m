Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F629CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 10:04:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 288FC214B2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 10:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JNK5/SNK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 288FC214B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMr1D-0006Nc-M2
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 06:03:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59315)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iMqsM-0005bX-2g
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 05:54:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iMqsL-0005eK-1H
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 05:54:49 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32551
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iMqsK-0005eA-UN
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 05:54:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571738088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jFPWykuMsgieWlJGsSu8oB7ApcBbSMC9vXFxrVCBi0o=;
 b=JNK5/SNKnwkrsoqYwd7Gh/SI2OcaqJ8XK/p1LSIGvKAGsUjllhPAYTjwWweYW15sPQqyvN
 HjLSEmPK3pouEGS5XhPYGoN0wtGG2CpqYH53vke0/XIJrqubWiWyHXXaxhavOVs6NCgVAG
 Q/VLEnoITBiSYMGD/1+BFUH0G1yXfgc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-FCPtEwf3NmeIaphByN-zWQ-1; Tue, 22 Oct 2019 05:54:45 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2FB47800D53;
 Tue, 22 Oct 2019 09:54:44 +0000 (UTC)
Received: from localhost (dhcp-192-218.str.redhat.com [10.33.192.218])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8ED8660126;
 Tue, 22 Oct 2019 09:54:41 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 3/9] s390x/tcg: Fix VECTOR MULTIPLY LOGICAL ODD
Date: Tue, 22 Oct 2019 11:54:22 +0200
Message-Id: <20191022095428.20780-4-cohuck@redhat.com>
In-Reply-To: <20191022095428.20780-1-cohuck@redhat.com>
References: <20191022095428.20780-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: FCPtEwf3NmeIaphByN-zWQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Hildenbrand <david@redhat.com>

We have to read from odd offsets.

Fixes: 2bf3ee38f1f8 ("s390x/tcg: Implement VECTOR MULTIPLY *")
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20191021085715.3797-2-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/vec_int_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/s390x/vec_int_helper.c b/target/s390x/vec_int_helper.c
index 68eaae407b47..03ae8631d958 100644
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


