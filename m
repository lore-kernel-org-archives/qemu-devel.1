Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7264C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:02:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C4CC20650
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:02:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C4CC20650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIX9g-0002PH-5F
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 08:02:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50671)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iIWkE-0006AW-5p
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:36:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iIWkD-0006YT-0v
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:36:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33724)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1iIWkC-0006Y6-R9; Thu, 10 Oct 2019 07:36:32 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 03D9B88FFF7;
 Thu, 10 Oct 2019 11:36:32 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-138.ams2.redhat.com [10.36.117.138])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3B0E65C1B5;
 Thu, 10 Oct 2019 11:36:21 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 24/31] target/s390x: Simplify helper_lra
Date: Thu, 10 Oct 2019 13:33:49 +0200
Message-Id: <20191010113356.5017-25-david@redhat.com>
In-Reply-To: <20191010113356.5017-1-david@redhat.com>
References: <20191010113356.5017-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.68]); Thu, 10 Oct 2019 11:36:32 +0000 (UTC)
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

We currently call trigger_pgm_exception to set cs->exception_index
and env->int_pgm_code and then read the values back and then
reset cs->exception_index so that the exception is not delivered.

Instead, use the exception type that we already have directly
without ever triggering an exception that must be suppressed.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20191001171614.8405-13-richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/mem_helper.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index e15aa296dd..4254548935 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -2361,34 +2361,23 @@ void HELPER(sturg)(CPUS390XState *env, uint64_t a=
ddr, uint64_t v1)
 /* load real address */
 uint64_t HELPER(lra)(CPUS390XState *env, uint64_t addr)
 {
-    CPUState *cs =3D env_cpu(env);
-    uint32_t cc =3D 0;
     uint64_t asc =3D env->psw.mask & PSW_MASK_ASC;
     uint64_t ret, tec;
-    int old_exc, flags, exc;
+    int flags, exc, cc;
=20
     /* XXX incomplete - has more corner cases */
     if (!(env->psw.mask & PSW_MASK_64) && (addr >> 32)) {
         tcg_s390_program_interrupt(env, PGM_SPECIAL_OP, GETPC());
     }
=20
-    old_exc =3D cs->exception_index;
     exc =3D mmu_translate(env, addr, 0, asc, &ret, &flags, &tec);
     if (exc) {
-        /*
-         * We don't care about ILEN or TEC, as we're not going to
-         * deliver the exception -- thus resetting exception_index below=
.
-         * TODO: clean this up.
-         */
-        trigger_pgm_exception(env, exc, ILEN_UNWIND);
         cc =3D 3;
-    }
-    if (cs->exception_index =3D=3D EXCP_PGM) {
-        ret =3D env->int_pgm_code | 0x80000000;
+        ret =3D exc | 0x80000000;
     } else {
+        cc =3D 0;
         ret |=3D addr & ~TARGET_PAGE_MASK;
     }
-    cs->exception_index =3D old_exc;
=20
     env->cc_op =3D cc;
     return ret;
--=20
2.21.0


