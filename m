Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2685EC10F14
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:01:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0D8120650
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:01:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0D8120650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIX7u-0000rj-NW
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 08:01:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50768)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iIWkY-0006jk-N8
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:36:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iIWkW-0006dI-Jw
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:36:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45262)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1iIWkW-0006cu-E9; Thu, 10 Oct 2019 07:36:52 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A1DC4883C24;
 Thu, 10 Oct 2019 11:36:51 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-138.ams2.redhat.com [10.36.117.138])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2C32A5C1B5;
 Thu, 10 Oct 2019 11:36:50 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 28/31] target/s390x: Remove ilen argument from
 trigger_access_exception
Date: Thu, 10 Oct 2019 13:33:53 +0200
Message-Id: <20191010113356.5017-29-david@redhat.com>
In-Reply-To: <20191010113356.5017-1-david@redhat.com>
References: <20191010113356.5017-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.69]); Thu, 10 Oct 2019 11:36:51 +0000 (UTC)
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

The single caller passes ILEN_UNWIND; pass that along to
trigger_pgm_exception directly.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20191001171614.8405-17-richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/mmu_helper.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index df58fb73ba..09c74f17dd 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -33,7 +33,7 @@
 #define FS_WRITE 0x400
=20
 static void trigger_access_exception(CPUS390XState *env, uint32_t type,
-                                     uint32_t ilen, uint64_t tec)
+                                     uint64_t tec)
 {
     S390CPU *cpu =3D env_archcpu(env);
=20
@@ -44,7 +44,7 @@ static void trigger_access_exception(CPUS390XState *env=
, uint32_t type,
         if (type !=3D PGM_ADDRESSING) {
             stq_phys(cs->as, env->psa + offsetof(LowCore, trans_exc_code=
), tec);
         }
-        trigger_pgm_exception(env, type, ilen);
+        trigger_pgm_exception(env, type, ILEN_UNWIND);
     }
 }
=20
@@ -510,7 +510,7 @@ int s390_cpu_virt_mem_rw(S390CPU *cpu, vaddr laddr, u=
int8_t ar, void *hostbuf,
=20
     ret =3D translate_pages(cpu, laddr, nr_pages, pages, is_write, &tec)=
;
     if (ret) {
-        trigger_access_exception(&cpu->env, ret, ILEN_UNWIND, tec);
+        trigger_access_exception(&cpu->env, ret, tec);
     } else if (hostbuf !=3D NULL) {
         /* Copy data by stepping through the area page by page */
         for (i =3D 0; i < nr_pages; i++) {
--=20
2.21.0


