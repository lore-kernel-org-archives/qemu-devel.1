Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 245A9C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 08:11:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 063D92084F
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 08:11:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 063D92084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i69LH-0002cv-Jd
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 04:11:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42339)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1i698i-0004BD-KA
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 03:58:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1i698h-0003T7-CU
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 03:58:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42128)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1i698h-0003SW-60; Fri, 06 Sep 2019 03:58:39 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7AE6E18012F2;
 Fri,  6 Sep 2019 07:58:38 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-162.ams2.redhat.com [10.36.117.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D0C6F1001955;
 Fri,  6 Sep 2019 07:58:36 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri,  6 Sep 2019 09:57:39 +0200
Message-Id: <20190906075750.14791-18-david@redhat.com>
In-Reply-To: <20190906075750.14791-1-david@redhat.com>
References: <20190906075750.14791-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Fri, 06 Sep 2019 07:58:38 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 17/28] s390x/tcg: MVCS/MVCP: Use
 access_memmove_idx()
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
Cc: Florian Weimer <fweimer@redhat.com>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Stefano Brivio <sbrivio@redhat.com>, qemu-s390x@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As we are moving between address spaces, we can use access_memmove_idx()
without checking for destructive overlaps (especially of real storage
locations):
    "Each storage operand is processed left to right. The
    storage-operand-consistency rules are the same as
    for MOVE (MVC), except that when the operands
    overlap in real storage, the use of the common real-
    storage locations is not necessarily recognized."

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/mem_helper.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index db678ddf47..2607dd1677 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -2049,7 +2049,7 @@ uint32_t HELPER(mvcs)(CPUS390XState *env, uint64_t =
l, uint64_t a1, uint64_t a2)
 {
     const uint8_t psw_as =3D (env->psw.mask & PSW_MASK_ASC) >> PSW_SHIFT=
_ASC;
     uintptr_t ra =3D GETPC();
-    int cc =3D 0, i;
+    int cc =3D 0;
=20
     HELPER_LOG("%s: %16" PRIx64 " %16" PRIx64 " %16" PRIx64 "\n",
                __func__, l, a1, a2);
@@ -2068,12 +2068,8 @@ uint32_t HELPER(mvcs)(CPUS390XState *env, uint64_t=
 l, uint64_t a1, uint64_t a2)
         return cc;
     }
=20
-    /* XXX replace w/ memcpy */
-    for (i =3D 0; i < l; i++) {
-        uint8_t x =3D cpu_ldub_primary_ra(env, a2 + i, ra);
-        cpu_stb_secondary_ra(env, a1 + i, x, ra);
-    }
-
+    /* TODO: Access key handling */
+    access_memmove_idx(env, a1, a2, l, MMU_SECONDARY_IDX, MMU_PRIMARY_ID=
X, ra);
     return cc;
 }
=20
@@ -2081,7 +2077,7 @@ uint32_t HELPER(mvcp)(CPUS390XState *env, uint64_t =
l, uint64_t a1, uint64_t a2)
 {
     const uint8_t psw_as =3D (env->psw.mask & PSW_MASK_ASC) >> PSW_SHIFT=
_ASC;
     uintptr_t ra =3D GETPC();
-    int cc =3D 0, i;
+    int cc =3D 0;
=20
     HELPER_LOG("%s: %16" PRIx64 " %16" PRIx64 " %16" PRIx64 "\n",
                __func__, l, a1, a2);
@@ -2100,12 +2096,8 @@ uint32_t HELPER(mvcp)(CPUS390XState *env, uint64_t=
 l, uint64_t a1, uint64_t a2)
         return cc;
     }
=20
-    /* XXX replace w/ memcpy */
-    for (i =3D 0; i < l; i++) {
-        uint8_t x =3D cpu_ldub_secondary_ra(env, a2 + i, ra);
-        cpu_stb_primary_ra(env, a1 + i, x, ra);
-    }
-
+    /* TODO: Access key handling */
+    access_memmove_idx(env, a1, a2, l, MMU_PRIMARY_IDX, MMU_SECONDARY_ID=
X, ra);
     return cc;
 }
=20
--=20
2.21.0


