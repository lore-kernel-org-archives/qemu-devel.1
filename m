Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD1B7CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 16:16:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9653E21852
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 16:16:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9653E21852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLUvP-0004aE-2U
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 12:16:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48924)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iLUq8-0007N5-Vw
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 12:10:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iLUq7-0007QY-Kx
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 12:10:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56346)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1iLUq7-0007P7-Fb; Fri, 18 Oct 2019 12:10:55 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B669419D04A;
 Fri, 18 Oct 2019 16:10:53 +0000 (UTC)
Received: from t460s.redhat.com (unknown [10.36.118.23])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 381791C92A;
 Fri, 18 Oct 2019 16:10:52 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 1/6] s390x/tcg: Fix VECTOR MULTIPLY LOGICAL ODD
Date: Fri, 18 Oct 2019 18:10:39 +0200
Message-Id: <20191018161044.6983-2-david@redhat.com>
In-Reply-To: <20191018161044.6983-1-david@redhat.com>
References: <20191018161044.6983-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Fri, 18 Oct 2019 16:10:53 +0000 (UTC)
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

We have to read from odd offsets.

Fixes: 2bf3ee38f1f8 ("s390x/tcg: Implement VECTOR MULTIPLY *")
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/vec_int_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/s390x/vec_int_helper.c b/target/s390x/vec_int_helper.=
c
index 68eaae407b..03ae8631d9 100644
--- a/target/s390x/vec_int_helper.c
+++ b/target/s390x/vec_int_helper.c
@@ -488,7 +488,7 @@ void HELPER(gvec_vmlo##BITS)(void *v1, const void *v2=
, const void *v3,         \
 {                                                                       =
       \
     int i, j;                                                           =
       \
                                                                         =
       \
-    for (i =3D 0, j =3D 0; i < (128 / TBITS); i++, j +=3D 2) {          =
             \
+    for (i =3D 0, j =3D 1; i < (128 / TBITS); i++, j +=3D 2) {          =
             \
         const uint##TBITS##_t a =3D s390_vec_read_element##BITS(v2, j); =
         \
         const uint##TBITS##_t b =3D s390_vec_read_element##BITS(v3, j); =
         \
                                                                         =
       \
--=20
2.21.0


