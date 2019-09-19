Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B82C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 13:13:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBE7A20678
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 13:13:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBE7A20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAwFa-0005Fl-RH
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 09:13:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41418)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iAvsY-0006Ji-0r
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 08:49:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iAvlg-0001Ag-AL
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 08:42:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39282)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>)
 id 1iAvlg-00018z-0l; Thu, 19 Sep 2019 08:42:40 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5677210C0311;
 Thu, 19 Sep 2019 12:42:39 +0000 (UTC)
Received: from localhost (dhcp-192-230.str.redhat.com [10.33.192.230])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A18C65C1D4;
 Thu, 19 Sep 2019 12:42:33 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Sep 2019 14:40:59 +0200
Message-Id: <20190919124115.11510-19-cohuck@redhat.com>
In-Reply-To: <20190919124115.11510-1-cohuck@redhat.com>
References: <20190919124115.11510-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.65]); Thu, 19 Sep 2019 12:42:39 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 18/34] s390x/tcg: MVCS/MVCP: Use access_memmove()
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
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Hildenbrand <david@redhat.com>

As we are moving between address spaces, we can use access_memmove()
without checking for destructive overlaps (especially of real storage
locations):
    "Each storage operand is processed left to right. The
    storage-operand-consistency rules are the same as
    for MOVE (MVC), except that when the operands
    overlap in real storage, the use of the common real-
    storage locations is not necessarily recognized."

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/mem_helper.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index e50cec9263c2..6b85f44e2251 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -2086,8 +2086,9 @@ uint32_t HELPER(rrbe)(CPUS390XState *env, uint64_t =
r2)
 uint32_t HELPER(mvcs)(CPUS390XState *env, uint64_t l, uint64_t a1, uint6=
4_t a2)
 {
     const uint8_t psw_as =3D (env->psw.mask & PSW_MASK_ASC) >> PSW_SHIFT=
_ASC;
+    S390Access srca, desta;
     uintptr_t ra =3D GETPC();
-    int cc =3D 0, i;
+    int cc =3D 0;
=20
     HELPER_LOG("%s: %16" PRIx64 " %16" PRIx64 " %16" PRIx64 "\n",
                __func__, l, a1, a2);
@@ -2106,20 +2107,19 @@ uint32_t HELPER(mvcs)(CPUS390XState *env, uint64_=
t l, uint64_t a1, uint64_t a2)
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
+    srca =3D access_prepare(env, a2, l, MMU_DATA_LOAD, MMU_PRIMARY_IDX, =
ra);
+    desta =3D access_prepare(env, a1, l, MMU_DATA_STORE, MMU_SECONDARY_I=
DX, ra);
+    access_memmove(env, &desta, &srca, ra);
     return cc;
 }
=20
 uint32_t HELPER(mvcp)(CPUS390XState *env, uint64_t l, uint64_t a1, uint6=
4_t a2)
 {
     const uint8_t psw_as =3D (env->psw.mask & PSW_MASK_ASC) >> PSW_SHIFT=
_ASC;
+    S390Access srca, desta;
     uintptr_t ra =3D GETPC();
-    int cc =3D 0, i;
+    int cc =3D 0;
=20
     HELPER_LOG("%s: %16" PRIx64 " %16" PRIx64 " %16" PRIx64 "\n",
                __func__, l, a1, a2);
@@ -2138,12 +2138,10 @@ uint32_t HELPER(mvcp)(CPUS390XState *env, uint64_=
t l, uint64_t a1, uint64_t a2)
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
+    srca =3D access_prepare(env, a2, l, MMU_DATA_LOAD, MMU_SECONDARY_IDX=
, ra);
+    desta =3D access_prepare(env, a1, l, MMU_DATA_STORE, MMU_PRIMARY_IDX=
, ra);
+    access_memmove(env, &desta, &srca, ra);
     return cc;
 }
=20
--=20
2.20.1


