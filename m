Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F850C34031
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 23:10:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26EB024125
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 23:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F8+1ZJ6e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26EB024125
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4C0w-0002AT-D8
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 18:10:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43044)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gshan@redhat.com>) id 1j4C07-0001bv-BN
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 18:10:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <gshan@redhat.com>) id 1j4C04-00071D-HI
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 18:09:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41751
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <gshan@redhat.com>) id 1j4C04-0006rx-Ak
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 18:09:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582067395;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sM3QoGqNTjmuG9QGlqh7NY7lACW/YD79UbkFbqdXlIA=;
 b=F8+1ZJ6eZf+5/5f2Hb1DZwtOWgNkFRv2Eck7batWvvt13mKZ13hqeRoh/l2O7aks4/xDh0
 i7pziQNRLexWJrXu/2htBLX/VKYKD03tZDdI+bG+Di2F48z0No69cF+9mZ8k8N+Nxst46C
 PONg/cy3QcZorgLlMWl5NU8IVM1wmwo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-VGp9eeWOPVWqe2QKknckEw-1; Tue, 18 Feb 2020 18:09:53 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F16C613E4;
 Tue, 18 Feb 2020 23:09:51 +0000 (UTC)
Received: from localhost.localdomain (vpn2-54-93.bne.redhat.com [10.64.54.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4092B90526;
 Tue, 18 Feb 2020 23:09:42 +0000 (UTC)
Subject: Re: [PATCH v4 1/3] target/arm: Support SError injection
To: Marc Zyngier <maz@kernel.org>
References: <20200218020416.50244-1-gshan@redhat.com>
 <20200218020416.50244-2-gshan@redhat.com>
 <60f0303b0c8d3f9a124c2e5c25814de3@kernel.org>
From: Gavin Shan <gshan@redhat.com>
Message-ID: <459ada75-b055-b2e2-ba5b-851f76c17f62@redhat.com>
Date: Wed, 19 Feb 2020 10:09:39 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <60f0303b0c8d3f9a124c2e5c25814de3@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: VGp9eeWOPVWqe2QKknckEw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
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
Reply-To: Gavin Shan <gshan@redhat.com>
Cc: peter.maydell@linaro.org, drjones@redhat.com, jthierry@redhat.com,
 aik@ozlabs.ru, richard.henderson@linaro.org, qemu-devel@nongnu.org,
 eric.auger@redhat.com, qemu-arm@nongnu.org, shan.gavin@gmail.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Marc,

On 2/19/20 3:28 AM, Marc Zyngier wrote:
> On 2020-02-18 02:04, Gavin Shan wrote:
>> This supports SError injection, which will be used by "virt" board to
>> simulating the behavior of NMI injection in next patch. As Peter Maydell
>> suggested, this adds a new interrupt (ARM_CPU_SERROR), which is parallel
>> to CPU_INTERRUPT_HARD. The backend depends on if kvm is enabled or not.
>> kvm_vcpu_ioctl(cpu, KVM_SET_VCPU_EVENTS) is leveraged to inject SError
>> or data abort to guest. When TCG is enabled, the behavior is simulated
>> by injecting SError and data abort to guest.
>=20
> s/and/or/ (you can't inject both at the same time).
>=20

Absolutely, will be corrected in v5, which will be hold. I hope to receive
comments from Peter and Richard before going to do another respin :)

>>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>> =A0target/arm/cpu.c=A0=A0=A0=A0=A0 | 69 ++++++++++++++++++++++++++++++++=
+++--------
>> =A0target/arm/cpu.h=A0=A0=A0=A0=A0 | 20 ++++++++-----
>> =A0target/arm/helper.c=A0=A0 | 12 ++++++++
>> =A0target/arm/m_helper.c |=A0 8 +++++
>> =A0target/arm/machine.c=A0 |=A0 3 +-
>> =A05 files changed, 91 insertions(+), 21 deletions(-)
>>
>> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
>> index de733aceeb..e5750080bc 100644
>> --- a/target/arm/cpu.c
>> +++ b/target/arm/cpu.c
>> @@ -78,7 +78,7 @@ static bool arm_cpu_has_work(CPUState *cs)
>> =A0=A0=A0=A0=A0=A0=A0=A0 && cs->interrupt_request &
>> =A0=A0=A0=A0=A0=A0=A0=A0 (CPU_INTERRUPT_FIQ | CPU_INTERRUPT_HARD
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 | CPU_INTERRUPT_VFIQ | CPU_INTERRUPT_VIRQ
>> -=A0=A0=A0=A0=A0=A0=A0=A0 | CPU_INTERRUPT_EXITTB);
>> +=A0=A0=A0=A0=A0=A0=A0=A0 | CPU_INTERRUPT_SERROR | CPU_INTERRUPT_EXITTB)=
;
>> =A0}
>>
>> =A0void arm_register_pre_el_change_hook(ARMCPU *cpu, ARMELChangeHookFn *=
hook,
>> @@ -449,6 +449,9 @@ static inline bool arm_excp_unmasked(CPUState *cs,
>> unsigned int excp_idx,
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return false;
>> =A0=A0=A0=A0=A0=A0=A0=A0 }
>> =A0=A0=A0=A0=A0=A0=A0=A0 return !(env->daif & PSTATE_I);
>> +=A0=A0=A0 case EXCP_SERROR:
>> +=A0=A0=A0=A0=A0=A0 pstate_unmasked =3D !(env->daif & PSTATE_A);
>> +=A0=A0=A0=A0=A0=A0 break;
>=20
> nit: Consider keeping the physical interrupts together, as they are close=
ly
> related.
>=20

Sorry, I didn't get the point. Maybe you're suggesting something like below=
?
If yes, I'm not sure if it's necessary.

     pstate_unmasked =3D !(env->daif & (PSTATE_A | PSTATE_I));

I think PSTATE_A is enough to mask out SError according to ARMv8 architectu=
re
reference manual (D1.7), as below:

    A, I, F Asynchronous exception mask bits:
    A
       SError interrupt mask bit.
    I
       IRQ interrupt mask bit.
    F
       FIQ interrupt mask bit.

>> =A0=A0=A0=A0 default:
>> =A0=A0=A0=A0=A0=A0=A0=A0 g_assert_not_reached();
>> =A0=A0=A0=A0 }
>> @@ -538,6 +541,15 @@ bool arm_cpu_exec_interrupt(CPUState *cs, int
>> interrupt_request)
>>
>> =A0=A0=A0=A0 /* The prioritization of interrupts is IMPLEMENTATION DEFIN=
ED. */
>>
>> +=A0=A0=A0 if (interrupt_request & CPU_INTERRUPT_SERROR) {
>> +=A0=A0=A0=A0=A0=A0=A0 excp_idx =3D EXCP_SERROR;
>> +=A0=A0=A0=A0=A0=A0=A0 target_el =3D arm_phys_excp_target_el(cs, excp_id=
x, cur_el, secure);
>> +=A0=A0=A0=A0=A0=A0=A0 if (arm_excp_unmasked(cs, excp_idx, target_el,
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 cur_el, secure, hcr_el2)) {
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto found;
>> +=A0=A0=A0=A0=A0=A0=A0 }
>> +=A0=A0=A0 }
>> +
>> =A0=A0=A0=A0 if (interrupt_request & CPU_INTERRUPT_FIQ) {
>> =A0=A0=A0=A0=A0=A0=A0=A0 excp_idx =3D EXCP_FIQ;
>> =A0=A0=A0=A0=A0=A0=A0=A0 target_el =3D arm_phys_excp_target_el(cs, excp_=
idx, cur_el, secure);
>> @@ -570,6 +582,7 @@ bool arm_cpu_exec_interrupt(CPUState *cs, int
>> interrupt_request)
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto found;
>> =A0=A0=A0=A0=A0=A0=A0=A0 }
>> =A0=A0=A0=A0 }
>> +
>> =A0=A0=A0=A0 return false;
>>
>> =A0 found:
>> @@ -585,7 +598,7 @@ static bool arm_v7m_cpu_exec_interrupt(CPUState
>> *cs, int interrupt_request)
>> =A0=A0=A0=A0 CPUClass *cc =3D CPU_GET_CLASS(cs);
>> =A0=A0=A0=A0 ARMCPU *cpu =3D ARM_CPU(cs);
>> =A0=A0=A0=A0 CPUARMState *env =3D &cpu->env;
>> -=A0=A0=A0 bool ret =3D false;
>> +=A0=A0=A0 uint32_t excp_idx;
>>
>> =A0=A0=A0=A0 /* ARMv7-M interrupt masking works differently than -A or -=
R.
>> =A0=A0=A0=A0=A0 * There is no FIQ/IRQ distinction. Instead of I and F bi=
ts
>> @@ -594,13 +607,26 @@ static bool arm_v7m_cpu_exec_interrupt(CPUState
>> *cs, int interrupt_request)
>> =A0=A0=A0=A0=A0 * (which depends on state like BASEPRI, FAULTMASK and th=
e
>> =A0=A0=A0=A0=A0 * currently active exception).
>> =A0=A0=A0=A0=A0 */
>> -=A0=A0=A0 if (interrupt_request & CPU_INTERRUPT_HARD
>> -=A0=A0=A0=A0=A0=A0=A0 && (armv7m_nvic_can_take_pending_exception(env->n=
vic))) {
>> -=A0=A0=A0=A0=A0=A0=A0 cs->exception_index =3D EXCP_IRQ;
>> -=A0=A0=A0=A0=A0=A0=A0 cc->do_interrupt(cs);
>> -=A0=A0=A0=A0=A0=A0=A0 ret =3D true;
>> +=A0=A0=A0 if (!armv7m_nvic_can_take_pending_exception(env->nvic)) {
>> +=A0=A0=A0=A0=A0=A0=A0 return false;
>> +=A0=A0=A0 }
>> +
>> +=A0=A0=A0 if (interrupt_request & CPU_INTERRUPT_SERROR) {
>> +=A0=A0=A0=A0=A0=A0=A0 excp_idx =3D EXCP_SERROR;
>> +=A0=A0=A0=A0=A0=A0=A0 goto found;
>> +=A0=A0=A0 }
>> +
>> +=A0=A0=A0 if (interrupt_request & CPU_INTERRUPT_HARD) {
>> +=A0=A0=A0=A0=A0=A0=A0 excp_idx =3D EXCP_IRQ;
>> +=A0=A0=A0=A0=A0=A0=A0 goto found;
>> =A0=A0=A0=A0 }
>> -=A0=A0=A0 return ret;
>> +
>> +=A0=A0=A0 return false;
>> +
>> +found:
>> +=A0=A0=A0 cs->exception_index =3D excp_idx;
>> +=A0=A0=A0 cc->do_interrupt(cs);
>> +=A0=A0=A0 return true;
>> =A0}
>> =A0#endif
>>
>> @@ -656,7 +682,8 @@ static void arm_cpu_set_irq(void *opaque, int irq,
>> int level)
>> =A0=A0=A0=A0=A0=A0=A0=A0 [ARM_CPU_IRQ] =3D CPU_INTERRUPT_HARD,
>> =A0=A0=A0=A0=A0=A0=A0=A0 [ARM_CPU_FIQ] =3D CPU_INTERRUPT_FIQ,
>> =A0=A0=A0=A0=A0=A0=A0=A0 [ARM_CPU_VIRQ] =3D CPU_INTERRUPT_VIRQ,
>> -=A0=A0=A0=A0=A0=A0=A0 [ARM_CPU_VFIQ] =3D CPU_INTERRUPT_VFIQ
>> +=A0=A0=A0=A0=A0=A0=A0 [ARM_CPU_VFIQ] =3D CPU_INTERRUPT_VFIQ,
>> +=A0=A0=A0=A0=A0=A0=A0 [ARM_CPU_SERROR] =3D CPU_INTERRUPT_SERROR,
>> =A0=A0=A0=A0 };
>>
>> =A0=A0=A0=A0 if (level) {
>> @@ -676,6 +703,7 @@ static void arm_cpu_set_irq(void *opaque, int irq,
>> int level)
>> =A0=A0=A0=A0=A0=A0=A0=A0 break;
>> =A0=A0=A0=A0 case ARM_CPU_IRQ:
>> =A0=A0=A0=A0 case ARM_CPU_FIQ:
>> +=A0=A0=A0 case ARM_CPU_SERROR:
>> =A0=A0=A0=A0=A0=A0=A0=A0 if (level) {
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cpu_interrupt(cs, mask[irq]);
>> =A0=A0=A0=A0=A0=A0=A0=A0 } else {
>> @@ -693,8 +721,10 @@ static void arm_cpu_kvm_set_irq(void *opaque, int
>> irq, int level)
>> =A0=A0=A0=A0 ARMCPU *cpu =3D opaque;
>> =A0=A0=A0=A0 CPUARMState *env =3D &cpu->env;
>> =A0=A0=A0=A0 CPUState *cs =3D CPU(cpu);
>> +=A0=A0=A0 struct kvm_vcpu_events events;
>> =A0=A0=A0=A0 uint32_t linestate_bit;
>> =A0=A0=A0=A0 int irq_id;
>> +=A0=A0=A0 bool inject_irq =3D true;
>>
>> =A0=A0=A0=A0 switch (irq) {
>> =A0=A0=A0=A0 case ARM_CPU_IRQ:
>> @@ -705,6 +735,14 @@ static void arm_cpu_kvm_set_irq(void *opaque, int
>> irq, int level)
>> =A0=A0=A0=A0=A0=A0=A0=A0 irq_id =3D KVM_ARM_IRQ_CPU_FIQ;
>> =A0=A0=A0=A0=A0=A0=A0=A0 linestate_bit =3D CPU_INTERRUPT_FIQ;
>> =A0=A0=A0=A0=A0=A0=A0=A0 break;
>> +=A0=A0=A0 case ARM_CPU_SERROR:
>> +=A0=A0=A0=A0=A0=A0=A0 if (!kvm_has_vcpu_events()) {
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return;
>> +=A0=A0=A0=A0=A0=A0=A0 }
>> +
>> +=A0=A0=A0=A0=A0=A0=A0 inject_irq =3D false;
>> +=A0=A0=A0=A0=A0=A0=A0 linestate_bit =3D CPU_INTERRUPT_SERROR;
>> +=A0=A0=A0=A0=A0=A0=A0 break;
>> =A0=A0=A0=A0 default:
>> =A0=A0=A0=A0=A0=A0=A0=A0 g_assert_not_reached();
>> =A0=A0=A0=A0 }
>> @@ -714,7 +752,14 @@ static void arm_cpu_kvm_set_irq(void *opaque, int
>> irq, int level)
>> =A0=A0=A0=A0 } else {
>> =A0=A0=A0=A0=A0=A0=A0=A0 env->irq_line_state &=3D ~linestate_bit;
>> =A0=A0=A0=A0 }
>> -=A0=A0=A0 kvm_arm_set_irq(cs->cpu_index, KVM_ARM_IRQ_TYPE_CPU, irq_id, =
!!level);
>> +
>> +=A0=A0=A0 if (inject_irq) {
>=20
> You could just have (linestate_bit !=3D CPU_INTERRUPT_SERROR) here, and n=
ot have
> inject_irq at all.
>=20

Sure, will be improved in v5.

>> +=A0=A0=A0=A0=A0=A0=A0 kvm_arm_set_irq(cs->cpu_index, KVM_ARM_IRQ_TYPE_C=
PU, irq_id, !!level);
>> +=A0=A0=A0 } else if (level) {
>=20
> Is there any case where you'd call this function with a SError and level =
=3D=3D 0?
> And even if it happens, you could exit early in the above switch statemen=
t.
>=20

The combination of SError and level =3D=3D 0 isn't existing for now, meanin=
g the
SError is always coming with level =3D=3D 1. We can't exit early in above s=
witch
statement because env->irq_line_state needs to be updated accordingly.

>> +=A0=A0=A0=A0=A0=A0=A0 memset(&events, 0, sizeof(events));
>> +=A0=A0=A0=A0=A0=A0=A0 events.exception.serror_pending =3D 1;
>> +=A0=A0=A0=A0=A0=A0=A0 kvm_vcpu_ioctl(cs, KVM_SET_VCPU_EVENTS, &events);
>> +=A0=A0=A0 }
>> =A0#endif
>> =A0}
>>
>> @@ -1064,9 +1109,9 @@ static void arm_cpu_initfn(Object *obj)
>> =A0=A0=A0=A0=A0=A0=A0=A0 /* VIRQ and VFIQ are unused with KVM but we add=
 them to maintain
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 * the same interface as non-KVM CPUs.
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 */
>> -=A0=A0=A0=A0=A0=A0=A0 qdev_init_gpio_in(DEVICE(cpu), arm_cpu_kvm_set_ir=
q, 4);
>> +=A0=A0=A0=A0=A0=A0=A0 qdev_init_gpio_in(DEVICE(cpu), arm_cpu_kvm_set_ir=
q, ARM_CPU_NUM_IRQ);
>> =A0=A0=A0=A0 } else {
>> -=A0=A0=A0=A0=A0=A0=A0 qdev_init_gpio_in(DEVICE(cpu), arm_cpu_set_irq, 4=
);
>> +=A0=A0=A0=A0=A0=A0=A0 qdev_init_gpio_in(DEVICE(cpu), arm_cpu_set_irq, A=
RM_CPU_NUM_IRQ);
>> =A0=A0=A0=A0 }
>>
>> =A0=A0=A0=A0 qdev_init_gpio_out(DEVICE(cpu), cpu->gt_timer_outputs,
>> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
>> index e943ffe8a9..23e9f7ee2d 100644
>> --- a/target/arm/cpu.h
>> +++ b/target/arm/cpu.h
>> @@ -49,6 +49,7 @@
>> =A0#define EXCP_LAZYFP=A0=A0=A0=A0=A0=A0=A0=A0 20=A0=A0 /* v7M fault dur=
ing lazy FP stacking */
>> =A0#define EXCP_LSERR=A0=A0=A0=A0=A0=A0=A0=A0=A0 21=A0=A0 /* v8M LSERR S=
ecureFault */
>> =A0#define EXCP_UNALIGNED=A0=A0=A0=A0=A0 22=A0=A0 /* v7M UNALIGNED Usage=
Fault */
>> +#define EXCP_SERROR=A0=A0=A0=A0=A0=A0=A0=A0 23=A0=A0 /* SError Interrup=
t */
>> =A0/* NB: add new EXCP_ defines to the array in arm_log_exception() too =
*/
>>
>> =A0#define ARMV7M_EXCP_RESET=A0=A0 1
>> @@ -79,9 +80,10 @@ enum {
>> =A0};
>>
>> =A0/* ARM-specific interrupt pending bits.=A0 */
>> -#define CPU_INTERRUPT_FIQ=A0=A0 CPU_INTERRUPT_TGT_EXT_1
>> -#define CPU_INTERRUPT_VIRQ=A0 CPU_INTERRUPT_TGT_EXT_2
>> -#define CPU_INTERRUPT_VFIQ=A0 CPU_INTERRUPT_TGT_EXT_3
>> +#define CPU_INTERRUPT_FIQ=A0=A0=A0=A0 CPU_INTERRUPT_TGT_EXT_1
>> +#define CPU_INTERRUPT_VIRQ=A0=A0=A0 CPU_INTERRUPT_TGT_EXT_2
>> +#define CPU_INTERRUPT_VFIQ=A0=A0=A0 CPU_INTERRUPT_TGT_EXT_3
>> +#define CPU_INTERRUPT_SERROR=A0 CPU_INTERRUPT_TGT_EXT_4
>>
>> =A0/* The usual mapping for an AArch64 system register to its AArch32
>> =A0 * counterpart is for the 32 bit world to have access to the lower
>> @@ -97,11 +99,13 @@ enum {
>> =A0#define offsetofhigh32(S, M) (offsetof(S, M) + sizeof(uint32_t))
>> =A0#endif
>>
>> -/* Meanings of the ARMCPU object's four inbound GPIO lines */
>> -#define ARM_CPU_IRQ 0
>> -#define ARM_CPU_FIQ 1
>> -#define ARM_CPU_VIRQ 2
>> -#define ARM_CPU_VFIQ 3
>> +/* ARMCPU object's inbound GPIO lines */
>> +#define ARM_CPU_IRQ=A0=A0=A0=A0 0
>> +#define ARM_CPU_FIQ=A0=A0=A0=A0 1
>> +#define ARM_CPU_VIRQ=A0=A0=A0 2
>> +#define ARM_CPU_VFIQ=A0=A0=A0 3
>> +#define ARM_CPU_SERROR=A0 4
>> +#define ARM_CPU_NUM_IRQ 5
>=20
> This probably should be turned into an enum, given that it is going to
> grow again on the following patch.
>=20

Nice idea, will do in v5.

>>
>> =A0/* ARM-specific extra insn start words:
>> =A0 * 1: Conditional execution bits
>> diff --git a/target/arm/helper.c b/target/arm/helper.c
>> index 366dbcf460..3f00af4c41 100644
>> --- a/target/arm/helper.c
>> +++ b/target/arm/helper.c
>> @@ -1969,6 +1969,12 @@ static uint64_t isr_read(CPUARMState *env,
>> const ARMCPRegInfo *ri)
>> =A0=A0=A0=A0=A0=A0=A0=A0 }
>> =A0=A0=A0=A0 }
>>
>> +=A0=A0=A0 if (!allow_virt || !(hcr_el2 & HCR_AMO)) {
>=20
> nit: It would be nicer to write this as
>=20
>  =A0=A0=A0=A0=A0=A0 if (!(allow_virt && (hcr_el2 & HCR_AMO)))
>=20
> which fits the current code better, and makes a slightly less ugly
> rewrite in the following patch.
>=20

Yeah, I had code as suggested, but changed to the code as-is.
Anyway, will change accordingly in v5.

>> +=A0=A0=A0=A0=A0=A0=A0 if (cs->interrupt_request & CPU_INTERRUPT_SERROR)=
 {
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret |=3D CPSR_A;
>> +=A0=A0=A0=A0=A0=A0=A0 }
>> +=A0=A0=A0 }
>> +
>> =A0=A0=A0=A0 /* External aborts are not possible in QEMU so A bit is alw=
ays clear */
>=20
> nit: this comment seems obsolete now.
>=20

Yep, will be corrected in v5.

Thanks,
Gavin


