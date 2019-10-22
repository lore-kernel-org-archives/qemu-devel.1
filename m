Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD8ECC47E49
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 10:01:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7213E2064B
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 10:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SlFPso1m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7213E2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMqyh-0003eK-1l
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 06:01:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59357)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iMqsQ-0005jo-VU
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 05:54:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iMqsP-0005hH-Fv
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 05:54:54 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:59260
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iMqsP-0005gx-CD
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 05:54:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571738092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7KCr6i+4t+ywkOlX6JJoUgDJqdx6D7ofzVIFs9U50pA=;
 b=SlFPso1m2deNuX/znAY5jN2zbTmXB1tHxZ6copAAZfF2feRG/EA+HYx/NxcKeZBq++lhYq
 yhPxn7SuBPddIbv8BjV2jFaOrIrG1W6QtuwoPOM9EcHmc3QFTdEoZ4XowUBZ1FulsSBBSP
 fLNKVSvo5fofrYHnkErqBoHLWAM8vj4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-7Y4BkShwNT2ve26Kejgd6w-1; Tue, 22 Oct 2019 05:54:49 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4956C1800D6A;
 Tue, 22 Oct 2019 09:54:48 +0000 (UTC)
Received: from localhost (dhcp-192-218.str.redhat.com [10.33.192.218])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A0F7E194B2;
 Tue, 22 Oct 2019 09:54:45 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 4/9] s390x/tcg: Fix VECTOR MULTIPLY AND ADD *
Date: Tue, 22 Oct 2019 11:54:23 +0200
Message-Id: <20191022095428.20780-5-cohuck@redhat.com>
In-Reply-To: <20191022095428.20780-1-cohuck@redhat.com>
References: <20191022095428.20780-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 7Y4BkShwNT2ve26Kejgd6w-1
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

We missed that we always read a "double-wide even-odd element
pair of the fourth operand". Fix it in all four variants.

Fixes: 1b430aec4157 ("s390x/tcg: Implement VECTOR MULTIPLY AND ADD *")
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20191021085715.3797-3-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/vec_int_helper.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/s390x/vec_int_helper.c b/target/s390x/vec_int_helper.c
index 03ae8631d958..1b3aaecbdb3d 100644
--- a/target/s390x/vec_int_helper.c
+++ b/target/s390x/vec_int_helper.c
@@ -336,7 +336,7 @@ void HELPER(gvec_vmae##BITS)(void *v1, const void *v2, =
const void *v3,         \
     for (i =3D 0, j =3D 0; i < (128 / TBITS); i++, j +=3D 2) {            =
           \
         int##TBITS##_t a =3D (int##BITS##_t)s390_vec_read_element##BITS(v2=
, j);  \
         int##TBITS##_t b =3D (int##BITS##_t)s390_vec_read_element##BITS(v3=
, j);  \
-        int##TBITS##_t c =3D (int##BITS##_t)s390_vec_read_element##BITS(v4=
, j);  \
+        int##TBITS##_t c =3D s390_vec_read_element##TBITS(v4, i);         =
       \
                                                                           =
     \
         s390_vec_write_element##TBITS(v1, i, a * b + c);                  =
     \
     }                                                                     =
     \
@@ -354,7 +354,7 @@ void HELPER(gvec_vmale##BITS)(void *v1, const void *v2,=
 const void *v3,        \
     for (i =3D 0, j =3D 0; i < (128 / TBITS); i++, j +=3D 2) {            =
           \
         uint##TBITS##_t a =3D s390_vec_read_element##BITS(v2, j);         =
       \
         uint##TBITS##_t b =3D s390_vec_read_element##BITS(v3, j);         =
       \
-        uint##TBITS##_t c =3D s390_vec_read_element##BITS(v4, j);         =
       \
+        uint##TBITS##_t c =3D s390_vec_read_element##TBITS(v4, i);        =
       \
                                                                           =
     \
         s390_vec_write_element##TBITS(v1, i, a * b + c);                  =
     \
     }                                                                     =
     \
@@ -372,7 +372,7 @@ void HELPER(gvec_vmao##BITS)(void *v1, const void *v2, =
const void *v3,         \
     for (i =3D 0, j =3D 1; i < (128 / TBITS); i++, j +=3D 2) {            =
           \
         int##TBITS##_t a =3D (int##BITS##_t)s390_vec_read_element##BITS(v2=
, j);  \
         int##TBITS##_t b =3D (int##BITS##_t)s390_vec_read_element##BITS(v3=
, j);  \
-        int##TBITS##_t c =3D (int##BITS##_t)s390_vec_read_element##BITS(v4=
, j);  \
+        int##TBITS##_t c =3D s390_vec_read_element##TBITS(v4, i);         =
       \
                                                                           =
     \
         s390_vec_write_element##TBITS(v1, i, a * b + c);                  =
     \
     }                                                                     =
     \
@@ -390,7 +390,7 @@ void HELPER(gvec_vmalo##BITS)(void *v1, const void *v2,=
 const void *v3,        \
     for (i =3D 0, j =3D 1; i < (128 / TBITS); i++, j +=3D 2) {            =
           \
         uint##TBITS##_t a =3D s390_vec_read_element##BITS(v2, j);         =
       \
         uint##TBITS##_t b =3D s390_vec_read_element##BITS(v3, j);         =
       \
-        uint##TBITS##_t c =3D s390_vec_read_element##BITS(v4, j);         =
       \
+        uint##TBITS##_t c =3D s390_vec_read_element##TBITS(v4, i);        =
       \
                                                                           =
     \
         s390_vec_write_element##TBITS(v1, i, a * b + c);                  =
     \
     }                                                                     =
     \
--=20
2.21.0


