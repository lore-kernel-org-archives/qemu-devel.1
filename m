Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C56CC34022
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 02:05:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05BB620836
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 02:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dj0GiijU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05BB620836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3sGc-0005nV-5M
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 21:05:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52905)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gshan@redhat.com>) id 1j3sFm-0004PO-DR
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 21:04:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <gshan@redhat.com>) id 1j3sFk-0007ee-OU
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 21:04:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53966
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <gshan@redhat.com>) id 1j3sFk-0007eL-Kt
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 21:04:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581991488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sXSJzLpXgKSN8mTc/ECvvQVL1nbmAD/SWUuXHQM2SvQ=;
 b=Dj0GiijUE7knbe0ZQwmkEtQI/9jygzzBYi+hMRGLxkHljnANhHphMXoBezzbpAU+FW6J+/
 4zIy+X4CxpS/8LWLrTLljnFMVeRkdvA46x28bCFT10WVFEsvfxp7oiffE3oH+7cZSz30dU
 8vj9t0EcIHBzz8g63BoyTb2yliYQKmk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-YZ9AsTeiMF6QEQ_ItGWIRA-1; Mon, 17 Feb 2020 21:04:45 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7DD82800D53;
 Tue, 18 Feb 2020 02:04:43 +0000 (UTC)
Received: from localhost.localdomain.com (vpn2-54-110.bne.redhat.com
 [10.64.54.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 443101BC6D;
 Tue, 18 Feb 2020 02:04:37 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Subject: [PATCH v4 2/3] target/arm: Support VSError injection
Date: Tue, 18 Feb 2020 13:04:15 +1100
Message-Id: <20200218020416.50244-3-gshan@redhat.com>
In-Reply-To: <20200218020416.50244-1-gshan@redhat.com>
References: <20200218020416.50244-1-gshan@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: YZ9AsTeiMF6QEQ_ItGWIRA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: peter.maydell@linaro.org, drjones@redhat.com, jthierry@redhat.com,
 aik@ozlabs.ru, maz@kernel.org, richard.henderson@linaro.org,
 eric.auger@redhat.com, shan.gavin@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This supports virtual SError injection, which can be used to inject
SError to guest running on the emulated hypervisor. The functionality
is enabled only when we're in non-secured mode and {HCR.TGE, HCR.AMO}
are set to {0, 1}. Also, it can be masked by PState.A bit. Apart from
that, the implementation is similar to VFIQ.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 target/arm/cpu.c       | 48 +++++++++++++++++++++++++++++++++++++++++-
 target/arm/cpu.h       | 13 +++++++-----
 target/arm/helper.c    | 20 +++++++++++++++++-
 target/arm/internals.h | 10 +++++++++
 target/arm/machine.c   |  2 +-
 5 files changed, 85 insertions(+), 8 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index e5750080bc..5969674941 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -78,7 +78,8 @@ static bool arm_cpu_has_work(CPUState *cs)
         && cs->interrupt_request &
         (CPU_INTERRUPT_FIQ | CPU_INTERRUPT_HARD
          | CPU_INTERRUPT_VFIQ | CPU_INTERRUPT_VIRQ
-         | CPU_INTERRUPT_SERROR | CPU_INTERRUPT_EXITTB);
+         | CPU_INTERRUPT_SERROR | CPU_INTERRUPT_VSERROR
+         | CPU_INTERRUPT_EXITTB);
 }
=20
 void arm_register_pre_el_change_hook(ARMCPU *cpu, ARMELChangeHookFn *hook,
@@ -452,6 +453,12 @@ static inline bool arm_excp_unmasked(CPUState *cs, uns=
igned int excp_idx,
     case EXCP_SERROR:
        pstate_unmasked =3D !(env->daif & PSTATE_A);
        break;
+    case EXCP_VSERROR:
+        if (secure || !(hcr_el2 & HCR_AMO) || (hcr_el2 & HCR_TGE)) {
+            /* VSError is only taken when hypervized and non-secure.  */
+            return false;
+        }
+        return !(env->daif & PSTATE_A);
     default:
         g_assert_not_reached();
     }
@@ -550,6 +557,15 @@ bool arm_cpu_exec_interrupt(CPUState *cs, int interrup=
t_request)
         }
     }
=20
+    if (interrupt_request & CPU_INTERRUPT_VSERROR) {
+        excp_idx =3D EXCP_VSERROR;
+        target_el =3D 1;
+        if (arm_excp_unmasked(cs, excp_idx, target_el,
+                              cur_el, secure, hcr_el2)) {
+            goto found;
+        }
+    }
+
     if (interrupt_request & CPU_INTERRUPT_FIQ) {
         excp_idx =3D EXCP_FIQ;
         target_el =3D arm_phys_excp_target_el(cs, excp_idx, cur_el, secure=
);
@@ -558,6 +574,7 @@ bool arm_cpu_exec_interrupt(CPUState *cs, int interrupt=
_request)
             goto found;
         }
     }
+
     if (interrupt_request & CPU_INTERRUPT_HARD) {
         excp_idx =3D EXCP_IRQ;
         target_el =3D arm_phys_excp_target_el(cs, excp_idx, cur_el, secure=
);
@@ -566,6 +583,7 @@ bool arm_cpu_exec_interrupt(CPUState *cs, int interrupt=
_request)
             goto found;
         }
     }
+
     if (interrupt_request & CPU_INTERRUPT_VIRQ) {
         excp_idx =3D EXCP_VIRQ;
         target_el =3D 1;
@@ -574,6 +592,7 @@ bool arm_cpu_exec_interrupt(CPUState *cs, int interrupt=
_request)
             goto found;
         }
     }
+
     if (interrupt_request & CPU_INTERRUPT_VFIQ) {
         excp_idx =3D EXCP_VFIQ;
         target_el =3D 1;
@@ -672,6 +691,28 @@ void arm_cpu_update_vfiq(ARMCPU *cpu)
     }
 }
=20
+void arm_cpu_update_vserror(ARMCPU *cpu)
+{
+    /*
+     * Update the interrupt level for virtual SError, which is the logical
+     * OR of the HCR_EL2.VSE bit and the input line level from the GIC.
+     */
+    CPUARMState *env =3D &cpu->env;
+    CPUState *cs =3D CPU(cpu);
+
+    bool new_state =3D (env->cp15.hcr_el2 & HCR_VSE) ||
+        (env->irq_line_state & CPU_INTERRUPT_VSERROR);
+
+    if (new_state !=3D ((cs->interrupt_request & CPU_INTERRUPT_VSERROR) !=
=3D 0)) {
+        if (new_state) {
+            cpu_interrupt(cs, CPU_INTERRUPT_VSERROR);
+        } else {
+            cpu_reset_interrupt(cs, CPU_INTERRUPT_VSERROR);
+        }
+    }
+}
+
+
 #ifndef CONFIG_USER_ONLY
 static void arm_cpu_set_irq(void *opaque, int irq, int level)
 {
@@ -684,6 +725,7 @@ static void arm_cpu_set_irq(void *opaque, int irq, int =
level)
         [ARM_CPU_VIRQ] =3D CPU_INTERRUPT_VIRQ,
         [ARM_CPU_VFIQ] =3D CPU_INTERRUPT_VFIQ,
         [ARM_CPU_SERROR] =3D CPU_INTERRUPT_SERROR,
+        [ARM_CPU_VSERROR] =3D CPU_INTERRUPT_VSERROR,
     };
=20
     if (level) {
@@ -710,6 +752,10 @@ static void arm_cpu_set_irq(void *opaque, int irq, int=
 level)
             cpu_reset_interrupt(cs, mask[irq]);
         }
         break;
+    case ARM_CPU_VSERROR:
+        assert(arm_feature(env, ARM_FEATURE_EL2));
+        arm_cpu_update_vserror(cpu);
+        break;
     default:
         g_assert_not_reached();
     }
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 23e9f7ee2d..30056c6dbc 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -50,6 +50,7 @@
 #define EXCP_LSERR          21   /* v8M LSERR SecureFault */
 #define EXCP_UNALIGNED      22   /* v7M UNALIGNED UsageFault */
 #define EXCP_SERROR         23   /* SError Interrupt */
+#define EXCP_VSERROR        24   /* Virtual SError Interrupt */
 /* NB: add new EXCP_ defines to the array in arm_log_exception() too */
=20
 #define ARMV7M_EXCP_RESET   1
@@ -80,10 +81,11 @@ enum {
 };
=20
 /* ARM-specific interrupt pending bits.  */
-#define CPU_INTERRUPT_FIQ     CPU_INTERRUPT_TGT_EXT_1
-#define CPU_INTERRUPT_VIRQ    CPU_INTERRUPT_TGT_EXT_2
-#define CPU_INTERRUPT_VFIQ    CPU_INTERRUPT_TGT_EXT_3
-#define CPU_INTERRUPT_SERROR  CPU_INTERRUPT_TGT_EXT_4
+#define CPU_INTERRUPT_FIQ     CPU_INTERRUPT_TGT_EXT_0
+#define CPU_INTERRUPT_VIRQ    CPU_INTERRUPT_TGT_EXT_1
+#define CPU_INTERRUPT_VFIQ    CPU_INTERRUPT_TGT_EXT_2
+#define CPU_INTERRUPT_SERROR  CPU_INTERRUPT_TGT_EXT_3
+#define CPU_INTERRUPT_VSERROR CPU_INTERRUPT_TGT_EXT_4
=20
 /* The usual mapping for an AArch64 system register to its AArch32
  * counterpart is for the 32 bit world to have access to the lower
@@ -105,7 +107,8 @@ enum {
 #define ARM_CPU_VIRQ    2
 #define ARM_CPU_VFIQ    3
 #define ARM_CPU_SERROR  4
-#define ARM_CPU_NUM_IRQ 5
+#define ARM_CPU_VSERROR 5
+#define ARM_CPU_NUM_IRQ 6
=20
 /* ARM-specific extra insn start words:
  * 1: Conditional execution bits
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 3f00af4c41..7fa6653f10 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1969,7 +1969,11 @@ static uint64_t isr_read(CPUARMState *env, const ARM=
CPRegInfo *ri)
         }
     }
=20
-    if (!allow_virt || !(hcr_el2 & HCR_AMO)) {
+    if (allow_virt && (hcr_el2 & HCR_AMO)) {
+        if (cs->interrupt_request & CPU_INTERRUPT_VSERROR) {
+            ret |=3D CPSR_A;
+        }
+    } else {
         if (cs->interrupt_request & CPU_INTERRUPT_SERROR) {
             ret |=3D CPSR_A;
         }
@@ -5103,6 +5107,7 @@ static void hcr_write(CPUARMState *env, const ARMCPRe=
gInfo *ri, uint64_t value)
     g_assert(qemu_mutex_iothread_locked());
     arm_cpu_update_virq(cpu);
     arm_cpu_update_vfiq(cpu);
+    arm_cpu_update_vserror(cpu);
 }
=20
 static void hcr_writehigh(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -8605,6 +8610,7 @@ void arm_log_exception(int idx)
             [EXCP_LSERR] =3D "v8M LSERR UsageFault",
             [EXCP_UNALIGNED] =3D "v7M UNALIGNED UsageFault",
             [EXCP_SERROR] =3D "SError Interrupt",
+            [EXCP_VSERROR] =3D "Virtual SError Interrupt",
         };
=20
         if (idx >=3D 0 && idx < ARRAY_SIZE(excnames)) {
@@ -9113,6 +9119,17 @@ static void arm_cpu_do_interrupt_aarch32(CPUState *c=
s)
         mask =3D CPSR_A | CPSR_I | CPSR_F;
         offset =3D 0;
         break;
+    case EXCP_VSERROR:
+        A32_BANKED_CURRENT_REG_SET(env, dfsr, env->exception.fsr);
+        A32_BANKED_CURRENT_REG_SET(env, dfar, env->exception.vaddress);
+        qemu_log_mask(CPU_LOG_INT, "...with DFSR 0x%x DFAR 0x%x\n",
+                      env->exception.fsr,
+                      (uint32_t)env->exception.vaddress);
+        new_mode =3D ARM_CPU_MODE_ABT;
+        addr =3D 0x10;
+        mask =3D CPSR_A | CPSR_I;
+        offset =3D 8;
+        break;
     default:
         cpu_abort(cs, "Unhandled exception 0x%x\n", cs->exception_index);
         return; /* Never happens.  Keep compiler happy.  */
@@ -9223,6 +9240,7 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs=
)
         addr +=3D 0x100;
         break;
     case EXCP_SERROR:
+    case EXCP_VSERROR:
         addr +=3D 0x180;
         break;
     default:
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 58c4d707c5..4625bf984e 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1023,6 +1023,16 @@ void arm_cpu_update_virq(ARMCPU *cpu);
  */
 void arm_cpu_update_vfiq(ARMCPU *cpu);
=20
+/**
+ * arm_cpu_update_vserror: Update CPU_INTERRUPT_VSERROR interrupt
+ *
+ * Update the CPU_INTERRUPT_VSERROR bit in cs->interrupt_request, followin=
g
+ * a change to either the input virtual SError line from the GIC or the
+ * HCR_EL2.VSE bit. Must be called with the iothread lock held.
+ */
+void arm_cpu_update_vserror(ARMCPU *cpu);
+
+
 /**
  * arm_mmu_idx_el:
  * @env: The cpu environment
diff --git a/target/arm/machine.c b/target/arm/machine.c
index e2ad2f156e..1bc9319f9b 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -715,7 +715,7 @@ static int cpu_post_load(void *opaque, int version_id)
         env->irq_line_state =3D cs->interrupt_request &
             (CPU_INTERRUPT_HARD | CPU_INTERRUPT_FIQ |
              CPU_INTERRUPT_VIRQ | CPU_INTERRUPT_VFIQ |
-             CPU_INTERRUPT_SERROR);
+             CPU_INTERRUPT_SERROR | CPU_INTERRUPT_VSERROR);
     }
=20
     /* Update the values list from the incoming migration data.
--=20
2.23.0


