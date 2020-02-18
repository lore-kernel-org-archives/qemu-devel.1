Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB59C34022
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 02:06:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 589C620801
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 02:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hcS2Gk4U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 589C620801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3sHa-0007W2-KA
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 21:06:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52876)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gshan@redhat.com>) id 1j3sFe-0004A7-LZ
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 21:04:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <gshan@redhat.com>) id 1j3sFc-0007Vh-N3
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 21:04:42 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31268
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <gshan@redhat.com>) id 1j3sFc-0007Uj-Jh
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 21:04:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581991480;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wRksyHHe95KC3+1qbA/sVMNiA344jsR7TqEcw4Fp6mA=;
 b=hcS2Gk4UXZZhAhlA/vrzm9ruRK/NR5ZKjupz/BDfpdYFgcLhZ+SQAJ0c1rDevIDR+dZuM+
 ZfTwM9H/kZ+R6voInlBHdth+IcSx1jCAX3qDz3WdJne8IKDpPwdSs2QD/TIXY5XAlRfmdq
 c7pQS5S7nagtfg2D0wPXyIqyRe7sg8A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-Xw3s_J_UMhiqMfTi9i5YwA-1; Mon, 17 Feb 2020 21:04:36 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0F2AE800EB2;
 Tue, 18 Feb 2020 02:04:35 +0000 (UTC)
Received: from localhost.localdomain.com (vpn2-54-110.bne.redhat.com
 [10.64.54.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E28B91BC6D;
 Tue, 18 Feb 2020 02:04:30 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Subject: [PATCH v4 1/3] target/arm: Support SError injection
Date: Tue, 18 Feb 2020 13:04:14 +1100
Message-Id: <20200218020416.50244-2-gshan@redhat.com>
In-Reply-To: <20200218020416.50244-1-gshan@redhat.com>
References: <20200218020416.50244-1-gshan@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: Xw3s_J_UMhiqMfTi9i5YwA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

This supports SError injection, which will be used by "virt" board to
simulating the behavior of NMI injection in next patch. As Peter Maydell
suggested, this adds a new interrupt (ARM_CPU_SERROR), which is parallel
to CPU_INTERRUPT_HARD. The backend depends on if kvm is enabled or not.
kvm_vcpu_ioctl(cpu, KVM_SET_VCPU_EVENTS) is leveraged to inject SError
or data abort to guest. When TCG is enabled, the behavior is simulated
by injecting SError and data abort to guest.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 target/arm/cpu.c      | 69 +++++++++++++++++++++++++++++++++++--------
 target/arm/cpu.h      | 20 ++++++++-----
 target/arm/helper.c   | 12 ++++++++
 target/arm/m_helper.c |  8 +++++
 target/arm/machine.c  |  3 +-
 5 files changed, 91 insertions(+), 21 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index de733aceeb..e5750080bc 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -78,7 +78,7 @@ static bool arm_cpu_has_work(CPUState *cs)
         && cs->interrupt_request &
         (CPU_INTERRUPT_FIQ | CPU_INTERRUPT_HARD
          | CPU_INTERRUPT_VFIQ | CPU_INTERRUPT_VIRQ
-         | CPU_INTERRUPT_EXITTB);
+         | CPU_INTERRUPT_SERROR | CPU_INTERRUPT_EXITTB);
 }
=20
 void arm_register_pre_el_change_hook(ARMCPU *cpu, ARMELChangeHookFn *hook,
@@ -449,6 +449,9 @@ static inline bool arm_excp_unmasked(CPUState *cs, unsi=
gned int excp_idx,
             return false;
         }
         return !(env->daif & PSTATE_I);
+    case EXCP_SERROR:
+       pstate_unmasked =3D !(env->daif & PSTATE_A);
+       break;
     default:
         g_assert_not_reached();
     }
@@ -538,6 +541,15 @@ bool arm_cpu_exec_interrupt(CPUState *cs, int interrup=
t_request)
=20
     /* The prioritization of interrupts is IMPLEMENTATION DEFINED. */
=20
+    if (interrupt_request & CPU_INTERRUPT_SERROR) {
+        excp_idx =3D EXCP_SERROR;
+        target_el =3D arm_phys_excp_target_el(cs, excp_idx, cur_el, secure=
);
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
@@ -570,6 +582,7 @@ bool arm_cpu_exec_interrupt(CPUState *cs, int interrupt=
_request)
             goto found;
         }
     }
+
     return false;
=20
  found:
@@ -585,7 +598,7 @@ static bool arm_v7m_cpu_exec_interrupt(CPUState *cs, in=
t interrupt_request)
     CPUClass *cc =3D CPU_GET_CLASS(cs);
     ARMCPU *cpu =3D ARM_CPU(cs);
     CPUARMState *env =3D &cpu->env;
-    bool ret =3D false;
+    uint32_t excp_idx;
=20
     /* ARMv7-M interrupt masking works differently than -A or -R.
      * There is no FIQ/IRQ distinction. Instead of I and F bits
@@ -594,13 +607,26 @@ static bool arm_v7m_cpu_exec_interrupt(CPUState *cs, =
int interrupt_request)
      * (which depends on state like BASEPRI, FAULTMASK and the
      * currently active exception).
      */
-    if (interrupt_request & CPU_INTERRUPT_HARD
-        && (armv7m_nvic_can_take_pending_exception(env->nvic))) {
-        cs->exception_index =3D EXCP_IRQ;
-        cc->do_interrupt(cs);
-        ret =3D true;
+    if (!armv7m_nvic_can_take_pending_exception(env->nvic)) {
+        return false;
+    }
+
+    if (interrupt_request & CPU_INTERRUPT_SERROR) {
+        excp_idx =3D EXCP_SERROR;
+        goto found;
+    }
+
+    if (interrupt_request & CPU_INTERRUPT_HARD) {
+        excp_idx =3D EXCP_IRQ;
+        goto found;
     }
-    return ret;
+
+    return false;
+
+found:
+    cs->exception_index =3D excp_idx;
+    cc->do_interrupt(cs);
+    return true;
 }
 #endif
=20
@@ -656,7 +682,8 @@ static void arm_cpu_set_irq(void *opaque, int irq, int =
level)
         [ARM_CPU_IRQ] =3D CPU_INTERRUPT_HARD,
         [ARM_CPU_FIQ] =3D CPU_INTERRUPT_FIQ,
         [ARM_CPU_VIRQ] =3D CPU_INTERRUPT_VIRQ,
-        [ARM_CPU_VFIQ] =3D CPU_INTERRUPT_VFIQ
+        [ARM_CPU_VFIQ] =3D CPU_INTERRUPT_VFIQ,
+        [ARM_CPU_SERROR] =3D CPU_INTERRUPT_SERROR,
     };
=20
     if (level) {
@@ -676,6 +703,7 @@ static void arm_cpu_set_irq(void *opaque, int irq, int =
level)
         break;
     case ARM_CPU_IRQ:
     case ARM_CPU_FIQ:
+    case ARM_CPU_SERROR:
         if (level) {
             cpu_interrupt(cs, mask[irq]);
         } else {
@@ -693,8 +721,10 @@ static void arm_cpu_kvm_set_irq(void *opaque, int irq,=
 int level)
     ARMCPU *cpu =3D opaque;
     CPUARMState *env =3D &cpu->env;
     CPUState *cs =3D CPU(cpu);
+    struct kvm_vcpu_events events;
     uint32_t linestate_bit;
     int irq_id;
+    bool inject_irq =3D true;
=20
     switch (irq) {
     case ARM_CPU_IRQ:
@@ -705,6 +735,14 @@ static void arm_cpu_kvm_set_irq(void *opaque, int irq,=
 int level)
         irq_id =3D KVM_ARM_IRQ_CPU_FIQ;
         linestate_bit =3D CPU_INTERRUPT_FIQ;
         break;
+    case ARM_CPU_SERROR:
+        if (!kvm_has_vcpu_events()) {
+            return;
+        }
+
+        inject_irq =3D false;
+        linestate_bit =3D CPU_INTERRUPT_SERROR;
+        break;
     default:
         g_assert_not_reached();
     }
@@ -714,7 +752,14 @@ static void arm_cpu_kvm_set_irq(void *opaque, int irq,=
 int level)
     } else {
         env->irq_line_state &=3D ~linestate_bit;
     }
-    kvm_arm_set_irq(cs->cpu_index, KVM_ARM_IRQ_TYPE_CPU, irq_id, !!level);
+
+    if (inject_irq) {
+        kvm_arm_set_irq(cs->cpu_index, KVM_ARM_IRQ_TYPE_CPU, irq_id, !!lev=
el);
+    } else if (level) {
+        memset(&events, 0, sizeof(events));
+        events.exception.serror_pending =3D 1;
+        kvm_vcpu_ioctl(cs, KVM_SET_VCPU_EVENTS, &events);
+    }
 #endif
 }
=20
@@ -1064,9 +1109,9 @@ static void arm_cpu_initfn(Object *obj)
         /* VIRQ and VFIQ are unused with KVM but we add them to maintain
          * the same interface as non-KVM CPUs.
          */
-        qdev_init_gpio_in(DEVICE(cpu), arm_cpu_kvm_set_irq, 4);
+        qdev_init_gpio_in(DEVICE(cpu), arm_cpu_kvm_set_irq, ARM_CPU_NUM_IR=
Q);
     } else {
-        qdev_init_gpio_in(DEVICE(cpu), arm_cpu_set_irq, 4);
+        qdev_init_gpio_in(DEVICE(cpu), arm_cpu_set_irq, ARM_CPU_NUM_IRQ);
     }
=20
     qdev_init_gpio_out(DEVICE(cpu), cpu->gt_timer_outputs,
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index e943ffe8a9..23e9f7ee2d 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -49,6 +49,7 @@
 #define EXCP_LAZYFP         20   /* v7M fault during lazy FP stacking */
 #define EXCP_LSERR          21   /* v8M LSERR SecureFault */
 #define EXCP_UNALIGNED      22   /* v7M UNALIGNED UsageFault */
+#define EXCP_SERROR         23   /* SError Interrupt */
 /* NB: add new EXCP_ defines to the array in arm_log_exception() too */
=20
 #define ARMV7M_EXCP_RESET   1
@@ -79,9 +80,10 @@ enum {
 };
=20
 /* ARM-specific interrupt pending bits.  */
-#define CPU_INTERRUPT_FIQ   CPU_INTERRUPT_TGT_EXT_1
-#define CPU_INTERRUPT_VIRQ  CPU_INTERRUPT_TGT_EXT_2
-#define CPU_INTERRUPT_VFIQ  CPU_INTERRUPT_TGT_EXT_3
+#define CPU_INTERRUPT_FIQ     CPU_INTERRUPT_TGT_EXT_1
+#define CPU_INTERRUPT_VIRQ    CPU_INTERRUPT_TGT_EXT_2
+#define CPU_INTERRUPT_VFIQ    CPU_INTERRUPT_TGT_EXT_3
+#define CPU_INTERRUPT_SERROR  CPU_INTERRUPT_TGT_EXT_4
=20
 /* The usual mapping for an AArch64 system register to its AArch32
  * counterpart is for the 32 bit world to have access to the lower
@@ -97,11 +99,13 @@ enum {
 #define offsetofhigh32(S, M) (offsetof(S, M) + sizeof(uint32_t))
 #endif
=20
-/* Meanings of the ARMCPU object's four inbound GPIO lines */
-#define ARM_CPU_IRQ 0
-#define ARM_CPU_FIQ 1
-#define ARM_CPU_VIRQ 2
-#define ARM_CPU_VFIQ 3
+/* ARMCPU object's inbound GPIO lines */
+#define ARM_CPU_IRQ     0
+#define ARM_CPU_FIQ     1
+#define ARM_CPU_VIRQ    2
+#define ARM_CPU_VFIQ    3
+#define ARM_CPU_SERROR  4
+#define ARM_CPU_NUM_IRQ 5
=20
 /* ARM-specific extra insn start words:
  * 1: Conditional execution bits
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 366dbcf460..3f00af4c41 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1969,6 +1969,12 @@ static uint64_t isr_read(CPUARMState *env, const ARM=
CPRegInfo *ri)
         }
     }
=20
+    if (!allow_virt || !(hcr_el2 & HCR_AMO)) {
+        if (cs->interrupt_request & CPU_INTERRUPT_SERROR) {
+            ret |=3D CPSR_A;
+        }
+    }
+
     /* External aborts are not possible in QEMU so A bit is always clear *=
/
     return ret;
 }
@@ -8598,6 +8604,7 @@ void arm_log_exception(int idx)
             [EXCP_LAZYFP] =3D "v7M exception during lazy FP stacking",
             [EXCP_LSERR] =3D "v8M LSERR UsageFault",
             [EXCP_UNALIGNED] =3D "v7M UNALIGNED UsageFault",
+            [EXCP_SERROR] =3D "SError Interrupt",
         };
=20
         if (idx >=3D 0 && idx < ARRAY_SIZE(excnames)) {
@@ -8923,6 +8930,7 @@ static void arm_cpu_do_interrupt_aarch32_hyp(CPUState=
 *cs)
         addr =3D 0x0c;
         break;
     case EXCP_DATA_ABORT:
+    case EXCP_SERROR:
         env->cp15.dfar_s =3D env->exception.vaddress;
         qemu_log_mask(CPU_LOG_INT, "...with HDFAR 0x%x\n",
                       (uint32_t)env->exception.vaddress);
@@ -9051,6 +9059,7 @@ static void arm_cpu_do_interrupt_aarch32(CPUState *cs=
)
         offset =3D 4;
         break;
     case EXCP_DATA_ABORT:
+    case EXCP_SERROR:
         A32_BANKED_CURRENT_REG_SET(env, dfsr, env->exception.fsr);
         A32_BANKED_CURRENT_REG_SET(env, dfar, env->exception.vaddress);
         qemu_log_mask(CPU_LOG_INT, "...with DFSR 0x%x DFAR 0x%x\n",
@@ -9213,6 +9222,9 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs=
)
     case EXCP_VFIQ:
         addr +=3D 0x100;
         break;
+    case EXCP_SERROR:
+        addr +=3D 0x180;
+        break;
     default:
         cpu_abort(cs, "Unhandled exception 0x%x\n", cs->exception_index);
     }
diff --git a/target/arm/m_helper.c b/target/arm/m_helper.c
index 33d414a684..a7271cc386 100644
--- a/target/arm/m_helper.c
+++ b/target/arm/m_helper.c
@@ -2211,6 +2211,14 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
          * v7m_preserve_fp_state() helper function.
          */
         break;
+    case EXCP_SERROR:
+        env->v7m.cfsr[M_REG_NS] |=3D
+            (R_V7M_CFSR_PRECISERR_MASK | R_V7M_CFSR_BFARVALID_MASK);
+        env->v7m.bfar =3D env->exception.vaddress;
+        qemu_log_mask(CPU_LOG_INT,
+                      "...with CFSR.PRECISERR and BFAR 0x%x\n",
+                      env->v7m.bfar);
+        break;
     default:
         cpu_abort(cs, "Unhandled exception 0x%x\n", cs->exception_index);
         return; /* Never happens.  Keep compiler happy.  */
diff --git a/target/arm/machine.c b/target/arm/machine.c
index 241890ac8c..e2ad2f156e 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -714,7 +714,8 @@ static int cpu_post_load(void *opaque, int version_id)
=20
         env->irq_line_state =3D cs->interrupt_request &
             (CPU_INTERRUPT_HARD | CPU_INTERRUPT_FIQ |
-             CPU_INTERRUPT_VIRQ | CPU_INTERRUPT_VFIQ);
+             CPU_INTERRUPT_VIRQ | CPU_INTERRUPT_VFIQ |
+             CPU_INTERRUPT_SERROR);
     }
=20
     /* Update the values list from the incoming migration data.
--=20
2.23.0


