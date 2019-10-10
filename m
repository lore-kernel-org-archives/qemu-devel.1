Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE20C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 11:51:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 710D9206A1
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 11:51:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 710D9206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIWyh-0006cr-5W
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 07:51:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50289)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iIWib-00046n-GT
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:34:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iIWia-0005wE-4b
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:34:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59158)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1iIWiZ-0005vo-SW; Thu, 10 Oct 2019 07:34:52 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1A5DD18C8902;
 Thu, 10 Oct 2019 11:34:51 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-138.ams2.redhat.com [10.36.117.138])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ED1D05C1B5;
 Thu, 10 Oct 2019 11:34:47 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 14/31] target/s390x: Remove ilen parameter from
 tcg_s390_program_interrupt
Date: Thu, 10 Oct 2019 13:33:39 +0200
Message-Id: <20191010113356.5017-15-david@redhat.com>
In-Reply-To: <20191010113356.5017-1-david@redhat.com>
References: <20191010113356.5017-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.70]); Thu, 10 Oct 2019 11:34:51 +0000 (UTC)
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

Since we begin the operation with an unwind, we have the proper
value of ilen immediately available.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20191001171614.8405-3-richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/excp_helper.c | 10 +++++-----
 target/s390x/interrupt.c   |  2 +-
 target/s390x/tcg-stub.c    |  4 ++--
 target/s390x/tcg_s390x.h   |  4 ++--
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index 892f659d5a..eb55e5ef53 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -34,15 +34,15 @@
 #include "hw/boards.h"
 #endif
=20
-void QEMU_NORETURN tcg_s390_program_interrupt(CPUS390XState *env, uint32=
_t code,
-                                              int ilen, uintptr_t ra)
+void QEMU_NORETURN tcg_s390_program_interrupt(CPUS390XState *env,
+                                              uint32_t code, uintptr_t r=
a)
 {
     CPUState *cs =3D env_cpu(env);
=20
     cpu_restore_state(cs, ra, true);
     qemu_log_mask(CPU_LOG_INT, "program interrupt at %#" PRIx64 "\n",
                   env->psw.addr);
-    trigger_pgm_exception(env, code, ilen);
+    trigger_pgm_exception(env, code, ILEN_UNWIND);
     cpu_loop_exit(cs);
 }
=20
@@ -60,7 +60,7 @@ void QEMU_NORETURN tcg_s390_data_exception(CPUS390XStat=
e *env, uint32_t dxc,
     if (env->cregs[0] & CR0_AFP) {
         env->fpc =3D deposit32(env->fpc, 8, 8, dxc);
     }
-    tcg_s390_program_interrupt(env, PGM_DATA, ILEN_AUTO, ra);
+    tcg_s390_program_interrupt(env, PGM_DATA, ra);
 }
=20
 void QEMU_NORETURN tcg_s390_vector_exception(CPUS390XState *env, uint32_=
t vxc,
@@ -75,7 +75,7 @@ void QEMU_NORETURN tcg_s390_vector_exception(CPUS390XSt=
ate *env, uint32_t vxc,
=20
     /* Always store the VXC into the FPC, without AFP it is undefined */
     env->fpc =3D deposit32(env->fpc, 8, 8, vxc);
-    tcg_s390_program_interrupt(env, PGM_VECTOR_PROCESSING, ILEN_AUTO, ra=
);
+    tcg_s390_program_interrupt(env, PGM_VECTOR_PROCESSING, ra);
 }
=20
 void HELPER(data_exception)(CPUS390XState *env, uint32_t dxc)
diff --git a/target/s390x/interrupt.c b/target/s390x/interrupt.c
index 30a9fb8852..b798e2ecbe 100644
--- a/target/s390x/interrupt.c
+++ b/target/s390x/interrupt.c
@@ -40,7 +40,7 @@ void s390_program_interrupt(CPUS390XState *env, uint32_=
t code, int ilen,
     if (kvm_enabled()) {
         kvm_s390_program_interrupt(env_archcpu(env), code);
     } else if (tcg_enabled()) {
-        tcg_s390_program_interrupt(env, code, ilen, ra);
+        tcg_s390_program_interrupt(env, code, ra);
     } else {
         g_assert_not_reached();
     }
diff --git a/target/s390x/tcg-stub.c b/target/s390x/tcg-stub.c
index 32adb7276a..d22c898802 100644
--- a/target/s390x/tcg-stub.c
+++ b/target/s390x/tcg-stub.c
@@ -18,8 +18,8 @@
 void tcg_s390_tod_updated(CPUState *cs, run_on_cpu_data opaque)
 {
 }
-void QEMU_NORETURN tcg_s390_program_interrupt(CPUS390XState *env, uint32=
_t code,
-                                              int ilen, uintptr_t ra)
+void QEMU_NORETURN tcg_s390_program_interrupt(CPUS390XState *env,
+                                              uint32_t code, uintptr_t r=
a)
 {
     g_assert_not_reached();
 }
diff --git a/target/s390x/tcg_s390x.h b/target/s390x/tcg_s390x.h
index 2813f9d48e..2f54ccb027 100644
--- a/target/s390x/tcg_s390x.h
+++ b/target/s390x/tcg_s390x.h
@@ -14,8 +14,8 @@
 #define TCG_S390X_H
=20
 void tcg_s390_tod_updated(CPUState *cs, run_on_cpu_data opaque);
-void QEMU_NORETURN tcg_s390_program_interrupt(CPUS390XState *env, uint32=
_t code,
-                                              int ilen, uintptr_t ra);
+void QEMU_NORETURN tcg_s390_program_interrupt(CPUS390XState *env,
+                                              uint32_t code, uintptr_t r=
a);
 void QEMU_NORETURN tcg_s390_data_exception(CPUS390XState *env, uint32_t =
dxc,
                                            uintptr_t ra);
 void QEMU_NORETURN tcg_s390_vector_exception(CPUS390XState *env, uint32_=
t vxc,
--=20
2.21.0


