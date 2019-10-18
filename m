Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47242CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 16:16:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C627205C9
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 16:16:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C627205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLUvL-0004We-P7
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 12:16:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48939)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iLUqA-0007N8-0G
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 12:10:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iLUq8-0007RY-VS
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 12:10:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52394)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1iLUq8-0007Qf-Ar; Fri, 18 Oct 2019 12:10:56 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8F1E210CC1E6;
 Fri, 18 Oct 2019 16:10:55 +0000 (UTC)
Received: from t460s.redhat.com (unknown [10.36.118.23])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0DA493DB4;
 Fri, 18 Oct 2019 16:10:53 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 2/6] s390x/tcg: Fix VECTOR MULTIPLY AND ADD *
Date: Fri, 18 Oct 2019 18:10:40 +0200
Message-Id: <20191018161044.6983-3-david@redhat.com>
In-Reply-To: <20191018161044.6983-1-david@redhat.com>
References: <20191018161044.6983-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.65]); Fri, 18 Oct 2019 16:10:55 +0000 (UTC)
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

We missed that we always read a "double-wide even-odd element
pair of the fourth operand". Fix it in all four variants.

Fixes: 1b430aec4157 ("s390x/tcg: Implement VECTOR MULTIPLY AND ADD *")
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/vec_int_helper.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/s390x/vec_int_helper.c b/target/s390x/vec_int_helper.=
c
index 03ae8631d9..1b3aaecbdb 100644
--- a/target/s390x/vec_int_helper.c
+++ b/target/s390x/vec_int_helper.c
@@ -336,7 +336,7 @@ void HELPER(gvec_vmae##BITS)(void *v1, const void *v2=
, const void *v3,         \
     for (i =3D 0, j =3D 0; i < (128 / TBITS); i++, j +=3D 2) {          =
             \
         int##TBITS##_t a =3D (int##BITS##_t)s390_vec_read_element##BITS(=
v2, j);  \
         int##TBITS##_t b =3D (int##BITS##_t)s390_vec_read_element##BITS(=
v3, j);  \
-        int##TBITS##_t c =3D (int##BITS##_t)s390_vec_read_element##BITS(=
v4, j);  \
+        int##TBITS##_t c =3D s390_vec_read_element##TBITS(v4, i);       =
         \
                                                                         =
       \
         s390_vec_write_element##TBITS(v1, i, a * b + c);                =
       \
     }                                                                   =
       \
@@ -354,7 +354,7 @@ void HELPER(gvec_vmale##BITS)(void *v1, const void *v=
2, const void *v3,        \
     for (i =3D 0, j =3D 0; i < (128 / TBITS); i++, j +=3D 2) {          =
             \
         uint##TBITS##_t a =3D s390_vec_read_element##BITS(v2, j);       =
         \
         uint##TBITS##_t b =3D s390_vec_read_element##BITS(v3, j);       =
         \
-        uint##TBITS##_t c =3D s390_vec_read_element##BITS(v4, j);       =
         \
+        uint##TBITS##_t c =3D s390_vec_read_element##TBITS(v4, i);      =
         \
                                                                         =
       \
         s390_vec_write_element##TBITS(v1, i, a * b + c);                =
       \
     }                                                                   =
       \
@@ -372,7 +372,7 @@ void HELPER(gvec_vmao##BITS)(void *v1, const void *v2=
, const void *v3,         \
     for (i =3D 0, j =3D 1; i < (128 / TBITS); i++, j +=3D 2) {          =
             \
         int##TBITS##_t a =3D (int##BITS##_t)s390_vec_read_element##BITS(=
v2, j);  \
         int##TBITS##_t b =3D (int##BITS##_t)s390_vec_read_element##BITS(=
v3, j);  \
-        int##TBITS##_t c =3D (int##BITS##_t)s390_vec_read_element##BITS(=
v4, j);  \
+        int##TBITS##_t c =3D s390_vec_read_element##TBITS(v4, i);       =
         \
                                                                         =
       \
         s390_vec_write_element##TBITS(v1, i, a * b + c);                =
       \
     }                                                                   =
       \
@@ -390,7 +390,7 @@ void HELPER(gvec_vmalo##BITS)(void *v1, const void *v=
2, const void *v3,        \
     for (i =3D 0, j =3D 1; i < (128 / TBITS); i++, j +=3D 2) {          =
             \
         uint##TBITS##_t a =3D s390_vec_read_element##BITS(v2, j);       =
         \
         uint##TBITS##_t b =3D s390_vec_read_element##BITS(v3, j);       =
         \
-        uint##TBITS##_t c =3D s390_vec_read_element##BITS(v4, j);       =
         \
+        uint##TBITS##_t c =3D s390_vec_read_element##TBITS(v4, i);      =
         \
                                                                         =
       \
         s390_vec_write_element##TBITS(v1, i, a * b + c);                =
       \
     }                                                                   =
       \
--=20
2.21.0


