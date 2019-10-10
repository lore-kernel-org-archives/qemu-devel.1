Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FDFEC10F14
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 11:59:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35DAF208C3
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 11:59:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35DAF208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIX6l-0008By-W7
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 07:59:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50837)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iIWkd-0006tH-Pn
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:37:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iIWkc-0006fZ-EL
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:36:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58152)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1iIWkc-0006fE-4W; Thu, 10 Oct 2019 07:36:58 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5931E81F07;
 Thu, 10 Oct 2019 11:36:57 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-138.ams2.redhat.com [10.36.117.138])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 83C235C1B5;
 Thu, 10 Oct 2019 11:36:55 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 31/31] s390x/tcg: MVCL: Exit to main loop if requested
Date: Thu, 10 Oct 2019 13:33:56 +0200
Message-Id: <20191010113356.5017-32-david@redhat.com>
In-Reply-To: <20191010113356.5017-1-david@redhat.com>
References: <20191010113356.5017-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Thu, 10 Oct 2019 11:36:57 +0000 (UTC)
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
 Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MVCL is interruptible and we should check for interrupts and process
them after writing back the variables to the registers. Let's check
for any exit requests and exit to the main loop. Introduce a new helper
function for that: cpu_loop_exit_requested().

When booting Fedora 30, I can see a handful of these exits and it seems
to work reliable. Also, Richard explained why this works correctly even
when MVCL is called via EXECUTE:

    (1) TB with EXECUTE runs, at address Ae
        - env->psw_addr stored with Ae.
        - helper_ex() runs, memory address Am computed
          from D2a(X2a,B2a) or from psw.addr+RI2.
        - env->ex_value stored with memory value modified by R1a

    (2) TB of executee runs,
        - env->ex_value stored with 0.
        - helper_mvcl() runs, using and updating R1b, R1b+1, R2b, R2b+1.

    (3a) helper_mvcl() completes,
         - TB of executee continues, psw.addr +=3D ilen.
         - Next instruction is the one following EXECUTE.

    (3b) helper_mvcl() exits to main loop,
         - cpu_loop_exit_restore() unwinds psw.addr =3D Ae.
         - Next instruction is the EXECUTE itself...
         - goto 1.

As the PoP mentiones that an interruptible instruction called via EXECUTE
should avoid modifying storage/registers that are used by EXECUTE itself,
it is fine to retrigger EXECUTE.

Cc: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/exec/exec-all.h   | 17 +++++++++++++++++
 target/s390x/mem_helper.c | 11 ++++++++++-
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 49db07ba0b..04795c49bf 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -72,6 +72,23 @@ void QEMU_NORETURN cpu_loop_exit(CPUState *cpu);
 void QEMU_NORETURN cpu_loop_exit_restore(CPUState *cpu, uintptr_t pc);
 void QEMU_NORETURN cpu_loop_exit_atomic(CPUState *cpu, uintptr_t pc);
=20
+/**
+ * cpu_loop_exit_requested:
+ * @cpu: The CPU state to be tested
+ *
+ * Indicate if somebody asked for a return of the CPU to the main loop
+ * (e.g., via cpu_exit() or cpu_interrupt()).
+ *
+ * This is helpful for architectures that support interruptible
+ * instructions. After writing back all state to registers/memory, this
+ * call can be used to check if it makes sense to return to the main loo=
p
+ * or to continue executing the interruptible instruction.
+ */
+static inline bool cpu_loop_exit_requested(CPUState *cpu)
+{
+    return (int32_t)atomic_read(&cpu_neg(cpu)->icount_decr.u32) < 0;
+}
+
 #if !defined(CONFIG_USER_ONLY)
 void cpu_reloading_memory_map(void);
 /**
diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 4254548935..2325767f17 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -1015,6 +1015,7 @@ uint32_t HELPER(mvcl)(CPUS390XState *env, uint32_t =
r1, uint32_t r2)
     uint64_t srclen =3D env->regs[r2 + 1] & 0xffffff;
     uint64_t src =3D get_address(env, r2);
     uint8_t pad =3D env->regs[r2 + 1] >> 24;
+    CPUState *cs =3D env_cpu(env);
     S390Access srca, desta;
     uint32_t cc, cur_len;
=20
@@ -1065,7 +1066,15 @@ uint32_t HELPER(mvcl)(CPUS390XState *env, uint32_t=
 r1, uint32_t r2)
         env->regs[r1 + 1] =3D deposit64(env->regs[r1 + 1], 0, 24, destle=
n);
         set_address_zero(env, r1, dest);
=20
-        /* TODO: Deliver interrupts. */
+        /*
+         * MVCL is interruptible. Return to the main loop if requested a=
fter
+         * writing back all state to registers. If no interrupt will get
+         * injected, we'll end up back in this handler and continue proc=
essing
+         * the remaining parts.
+         */
+        if (destlen && unlikely(cpu_loop_exit_requested(cs))) {
+            cpu_loop_exit_restore(cs, ra);
+        }
     }
     return cc;
 }
--=20
2.21.0


