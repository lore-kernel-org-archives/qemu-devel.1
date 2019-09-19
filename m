Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA5AC3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 13:27:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 225622196F
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 13:27:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 225622196F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAwTK-0004db-Ao
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 09:27:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41882)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iAvss-000702-Ov
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 08:50:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iAvkT-0007gZ-1B
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 08:41:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:23288)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>)
 id 1iAvkS-0007f8-QP; Thu, 19 Sep 2019 08:41:24 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E0C633CBC1;
 Thu, 19 Sep 2019 12:41:23 +0000 (UTC)
Received: from localhost (dhcp-192-230.str.redhat.com [10.33.192.230])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2162660933;
 Thu, 19 Sep 2019 12:41:20 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Sep 2019 14:40:42 +0200
Message-Id: <20190919124115.11510-2-cohuck@redhat.com>
In-Reply-To: <20190919124115.11510-1-cohuck@redhat.com>
References: <20190919124115.11510-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Thu, 19 Sep 2019 12:41:23 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 01/34] s390x/tcg: Reset exception_index to -1
 instead of 0
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

We use the marker "-1" for "no exception". s390_cpu_do_interrupt() might
get confused by that.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/mem_helper.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 29fcce426e35..39ee9b3175ca 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -1747,7 +1747,7 @@ uint32_t HELPER(tprot)(CPUS390XState *env, uint64_t=
 a1, uint64_t a2)
=20
     if (env->int_pgm_code =3D=3D PGM_PROTECTION) {
         /* retry if reading is possible */
-        cs->exception_index =3D 0;
+        cs->exception_index =3D -1;
         if (!s390_cpu_virt_mem_check_read(cpu, a1, 0, 1)) {
             /* Fetching permitted; storing not permitted */
             return 1;
@@ -1757,7 +1757,7 @@ uint32_t HELPER(tprot)(CPUS390XState *env, uint64_t=
 a1, uint64_t a2)
     switch (env->int_pgm_code) {
     case PGM_PROTECTION:
         /* Fetching not permitted; storing not permitted */
-        cs->exception_index =3D 0;
+        cs->exception_index =3D -1;
         return 2;
     case PGM_ADDRESSING:
     case PGM_TRANS_SPEC:
@@ -1767,7 +1767,7 @@ uint32_t HELPER(tprot)(CPUS390XState *env, uint64_t=
 a1, uint64_t a2)
     }
=20
     /* Translation not available */
-    cs->exception_index =3D 0;
+    cs->exception_index =3D -1;
     return 3;
 }
=20
--=20
2.20.1


