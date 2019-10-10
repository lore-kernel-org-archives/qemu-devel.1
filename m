Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF5EEC4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 11:57:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9624A208C3
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 11:57:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9624A208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIX4A-0005fH-4U
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 07:57:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50694)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iIWkO-0006RZ-M4
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:36:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iIWkN-0006aU-EB
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:36:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:6238)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1iIWkN-0006aN-8t; Thu, 10 Oct 2019 07:36:43 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 82D8189AC2;
 Thu, 10 Oct 2019 11:36:42 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-138.ams2.redhat.com [10.36.117.138])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4BB515C22C;
 Thu, 10 Oct 2019 11:36:32 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 25/31] target/s390x: Rely on unwinding in s390_cpu_tlb_fill
Date: Thu, 10 Oct 2019 13:33:50 +0200
Message-Id: <20191010113356.5017-26-david@redhat.com>
In-Reply-To: <20191010113356.5017-1-david@redhat.com>
References: <20191010113356.5017-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Thu, 10 Oct 2019 11:36:42 +0000 (UTC)
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

We currently set ilen to AUTO, then overwrite that during
unwinding, then overwrite that for the code access case.

This can be simplified to setting ilen to our arbitrary
value for the (undefined) code access case, then rely on
unwinding to overwrite that with the correct value for
the data access case.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20191001171614.8405-14-richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/excp_helper.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index 98a1ee8317..8ce992e639 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -96,7 +96,7 @@ bool s390_cpu_tlb_fill(CPUState *cs, vaddr address, int=
 size,
 {
     S390CPU *cpu =3D S390_CPU(cs);
=20
-    trigger_pgm_exception(&cpu->env, PGM_ADDRESSING, ILEN_AUTO);
+    trigger_pgm_exception(&cpu->env, PGM_ADDRESSING, ILEN_UNWIND);
     /* On real machines this value is dropped into LowMem.  Since this
        is userland, simply put this someplace that cpu_loop can find it.=
  */
     cpu->env.__excp_addr =3D address;
@@ -179,24 +179,15 @@ bool s390_cpu_tlb_fill(CPUState *cs, vaddr address,=
 int size,
         stq_phys(env_cpu(env)->as,
                  env->psa + offsetof(LowCore, trans_exc_code), tec);
     }
-    trigger_pgm_exception(env, excp, ILEN_AUTO);
-    cpu_restore_state(cs, retaddr, true);
=20
     /*
-     * The ILC value for code accesses is undefined.  The important
-     * thing here is to *not* leave env->int_pgm_ilen set to ILEN_AUTO,
-     * which would cause do_program_interrupt to attempt to read from
-     * env->psw.addr again.  C.f. the condition in trigger_page_fault,
-     * but is not universally applied.
-     *
-     * ??? If we remove ILEN_AUTO, by moving the computation of ILEN
-     * into cpu_restore_state, then we may remove this entirely.
+     * For data accesses, ILEN will be filled in from the unwind info,
+     * within cpu_loop_exit_restore.  For code accesses, retaddr =3D=3D =
0,
+     * and so unwinding will not occur.  However, ILEN is also undefined
+     * for that case -- we choose to set ILEN =3D 2.
      */
-    if (access_type =3D=3D MMU_INST_FETCH) {
-        env->int_pgm_ilen =3D 2;
-    }
-
-    cpu_loop_exit(cs);
+    trigger_pgm_exception(env, excp, 2);
+    cpu_loop_exit_restore(cs, retaddr);
 }
=20
 static void do_program_interrupt(CPUS390XState *env)
--=20
2.21.0


