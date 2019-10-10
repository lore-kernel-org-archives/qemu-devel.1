Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD37C10F14
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:08:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2059620650
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:08:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2059620650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIXFY-0000pv-Mw
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 08:08:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50785)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iIWkZ-0006lx-Oq
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:36:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iIWkY-0006dx-GB
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:36:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44180)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1iIWkY-0006dl-7t; Thu, 10 Oct 2019 07:36:54 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6D16B970F1;
 Thu, 10 Oct 2019 11:36:53 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-138.ams2.redhat.com [10.36.117.138])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EB2E55C1B5;
 Thu, 10 Oct 2019 11:36:51 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 29/31] target/s390x: Remove ilen argument from
 trigger_pgm_exception
Date: Thu, 10 Oct 2019 13:33:54 +0200
Message-Id: <20191010113356.5017-30-david@redhat.com>
In-Reply-To: <20191010113356.5017-1-david@redhat.com>
References: <20191010113356.5017-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Thu, 10 Oct 2019 11:36:53 +0000 (UTC)
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

All but one caller passes ILEN_UNWIND, which is not stored.
For the one use case in s390_cpu_tlb_fill, set int_pgm_ilen
directly, simply to avoid the assert within do_program_interrupt.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20191001171614.8405-18-richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/excp_helper.c | 7 ++++---
 target/s390x/internal.h    | 2 +-
 target/s390x/interrupt.c   | 7 ++-----
 target/s390x/mmu_helper.c  | 2 +-
 4 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index c252e9a7d8..e70c20d363 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -42,7 +42,7 @@ void QEMU_NORETURN tcg_s390_program_interrupt(CPUS390XS=
tate *env,
     cpu_restore_state(cs, ra, true);
     qemu_log_mask(CPU_LOG_INT, "program interrupt at %#" PRIx64 "\n",
                   env->psw.addr);
-    trigger_pgm_exception(env, code, ILEN_UNWIND);
+    trigger_pgm_exception(env, code);
     cpu_loop_exit(cs);
 }
=20
@@ -96,7 +96,7 @@ bool s390_cpu_tlb_fill(CPUState *cs, vaddr address, int=
 size,
 {
     S390CPU *cpu =3D S390_CPU(cs);
=20
-    trigger_pgm_exception(&cpu->env, PGM_ADDRESSING, ILEN_UNWIND);
+    trigger_pgm_exception(&cpu->env, PGM_ADDRESSING);
     /* On real machines this value is dropped into LowMem.  Since this
        is userland, simply put this someplace that cpu_loop can find it.=
  */
     cpu->env.__excp_addr =3D address;
@@ -186,7 +186,8 @@ bool s390_cpu_tlb_fill(CPUState *cs, vaddr address, i=
nt size,
      * and so unwinding will not occur.  However, ILEN is also undefined
      * for that case -- we choose to set ILEN =3D 2.
      */
-    trigger_pgm_exception(env, excp, 2);
+    env->int_pgm_ilen =3D 2;
+    trigger_pgm_exception(env, excp);
     cpu_loop_exit_restore(cs, retaddr);
 }
=20
diff --git a/target/s390x/internal.h b/target/s390x/internal.h
index c993c3ef40..d37816104d 100644
--- a/target/s390x/internal.h
+++ b/target/s390x/internal.h
@@ -317,7 +317,7 @@ void cpu_unmap_lowcore(LowCore *lowcore);
=20
=20
 /* interrupt.c */
-void trigger_pgm_exception(CPUS390XState *env, uint32_t code, uint32_t i=
len);
+void trigger_pgm_exception(CPUS390XState *env, uint32_t code);
 void cpu_inject_clock_comparator(S390CPU *cpu);
 void cpu_inject_cpu_timer(S390CPU *cpu);
 void cpu_inject_emergency_signal(S390CPU *cpu, uint16_t src_cpu_addr);
diff --git a/target/s390x/interrupt.c b/target/s390x/interrupt.c
index 2b71e03914..4cdbbc8849 100644
--- a/target/s390x/interrupt.c
+++ b/target/s390x/interrupt.c
@@ -22,16 +22,13 @@
 #endif
=20
 /* Ensure to exit the TB after this call! */
-void trigger_pgm_exception(CPUS390XState *env, uint32_t code, uint32_t i=
len)
+void trigger_pgm_exception(CPUS390XState *env, uint32_t code)
 {
     CPUState *cs =3D env_cpu(env);
=20
     cs->exception_index =3D EXCP_PGM;
     env->int_pgm_code =3D code;
-    /* If ILEN_UNWIND, int_pgm_ilen already has the correct value.  */
-    if (ilen !=3D ILEN_UNWIND) {
-        env->int_pgm_ilen =3D ilen;
-    }
+    /* env->int_pgm_ilen is already set, or will be set during unwinding=
 */
 }
=20
 void s390_program_interrupt(CPUS390XState *env, uint32_t code, uintptr_t=
 ra)
diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index 09c74f17dd..90b81335f9 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -44,7 +44,7 @@ static void trigger_access_exception(CPUS390XState *env=
, uint32_t type,
         if (type !=3D PGM_ADDRESSING) {
             stq_phys(cs->as, env->psa + offsetof(LowCore, trans_exc_code=
), tec);
         }
-        trigger_pgm_exception(env, type, ILEN_UNWIND);
+        trigger_pgm_exception(env, type);
     }
 }
=20
--=20
2.21.0


