Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38335C34022
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 08:04:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0E1821D56
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 08:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LSmT5uO1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0E1821D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4KLV-0004UQ-5W
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 03:04:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54870)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maz@kernel.org>) id 1j4KKW-0003a0-VS
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 03:03:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <maz@kernel.org>) id 1j4KKV-0004GD-6V
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 03:03:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:37006)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <maz@kernel.org>)
 id 1j4KKR-0004Cz-4K; Wed, 19 Feb 2020 03:03:31 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A407621D56;
 Wed, 19 Feb 2020 08:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1582099409;
 bh=XKvbxnqDqqgvnETocVfhNBfhZu4quZNZYHFCf1GaV5M=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=LSmT5uO12PELk4nf7D77qtk0gbfe2ugUofQrtDm/70DnKFt/rNRNKfgkdIWJvBejU
 Sr3UqQWPVun1bgZ3YHMx7QrIgqxRCYM2HQsgOZ7z2pn3JS5KxMSmIv0Rf5yJhCsRwM
 pQPL9IRsjNg1VPhFSnMEYBAHKkz1kFe313dfeom8=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why) by disco-boy.misterjones.org with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1j4KKN-006S6Z-VQ; Wed, 19 Feb 2020 08:03:28 +0000
Date: Wed, 19 Feb 2020 08:03:26 +0000
From: Marc Zyngier <maz@kernel.org>
To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v4 1/3] target/arm: Support SError injection
Message-ID: <20200219080326.05d552ef@why>
In-Reply-To: <459ada75-b055-b2e2-ba5b-851f76c17f62@redhat.com>
References: <20200218020416.50244-1-gshan@redhat.com>
 <20200218020416.50244-2-gshan@redhat.com>
 <60f0303b0c8d3f9a124c2e5c25814de3@kernel.org>
 <459ada75-b055-b2e2-ba5b-851f76c17f62@redhat.com>
Organization: Approximate
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: gshan@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, richard.henderson@linaro.org, pbonzini@redhat.com,
 aik@ozlabs.ru, drjones@redhat.com, eric.auger@redhat.com, jthierry@redhat.com,
 shan.gavin@gmail.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 198.145.29.99
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
 aik@ozlabs.ru, richard.henderson@linaro.org, qemu-devel@nongnu.org,
 eric.auger@redhat.com, qemu-arm@nongnu.org, shan.gavin@gmail.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 19 Feb 2020 10:09:39 +1100
Gavin Shan <gshan@redhat.com> wrote:

> Hi Marc,
>=20
> On 2/19/20 3:28 AM, Marc Zyngier wrote:
> > On 2020-02-18 02:04, Gavin Shan wrote: =20
> >> This supports SError injection, which will be used by "virt" board to
> >> simulating the behavior of NMI injection in next patch. As Peter Mayde=
ll
> >> suggested, this adds a new interrupt (ARM_CPU_SERROR), which is parall=
el
> >> to CPU_INTERRUPT_HARD. The backend depends on if kvm is enabled or not.
> >> kvm_vcpu_ioctl(cpu, KVM_SET_VCPU_EVENTS) is leveraged to inject SError
> >> or data abort to guest. When TCG is enabled, the behavior is simulated
> >> by injecting SError and data abort to guest. =20
> >=20
> > s/and/or/ (you can't inject both at the same time).
> >  =20
>=20
> Absolutely, will be corrected in v5, which will be hold. I hope to receive
> comments from Peter and Richard before going to do another respin :)

Sure, there is no hurry at all.

>=20
> >>
> >> Signed-off-by: Gavin Shan <gshan@redhat.com>
> >> ---
> >> =C2=A0target/arm/cpu.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 69 ++++++++++++=
++++++++++++++++++++ =20
> +++--------
> >> =C2=A0target/arm/cpu.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 20 ++++++++-----
> >> =C2=A0target/arm/helper.c=C2=A0=C2=A0 | 12 ++++++++
> >> =C2=A0target/arm/m_helper.c |=C2=A0 8 +++++
> >> =C2=A0target/arm/machine.c=C2=A0 |=C2=A0 3 +-
> >> =C2=A05 files changed, 91 insertions(+), 21 deletions(-)
> >>
> >> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> >> index de733aceeb..e5750080bc 100644
> >> --- a/target/arm/cpu.c
> >> +++ b/target/arm/cpu.c
> >> @@ -78,7 +78,7 @@ static bool arm_cpu_has_work(CPUState *cs)
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 && cs->interrupt_requ=
est &
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (CPU_INTERRUPT_FIQ | =
CPU_INTERRUPT_HARD
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | CPU_INTERRUPT=
_VFIQ | CPU_INTERRUPT_VIRQ
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | CPU_INTERRUPT_EXIT=
TB);
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | CPU_INTERRUPT_SERR=
OR | CPU_INTERRUPT_EXITTB) =20
> ;
> >> =C2=A0}
> >>
> >> =C2=A0void arm_register_pre_el_change_hook(ARMCPU *cpu, ARMELChangeHoo=
kFn * =20
> hook,
> >> @@ -449,6 +449,9 @@ static inline bool arm_excp_unmasked(CPUState *cs,
> >> unsigned int excp_idx,
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return false;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return !(env->daif & =
PSTATE_I);
> >> +=C2=A0=C2=A0=C2=A0 case EXCP_SERROR:
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pstate_unmasked =3D !(env->daif =
& PSTATE_A);
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break; =20
> >=20
> > nit: Consider keeping the physical interrupts together, as they are clo=
se =20
> ly
> > related.
> >  =20
>=20
> Sorry, I didn't get the point. Maybe you're suggesting something like bel=
ow
> ?
> If yes, I'm not sure if it's necessary.
>=20
>      pstate_unmasked =3D !(env->daif & (PSTATE_A | PSTATE_I));
>=20
> I think PSTATE_A is enough to mask out SError according to ARMv8 architec=
tu
> re
> reference manual (D1.7), as below:
>=20
>     A, I, F Asynchronous exception mask bits:
>     A
>        SError interrupt mask bit.
>     I
>        IRQ interrupt mask bit.
>     F
>        FIQ interrupt mask bit.

No, all I'm suggesting is that you keep the cases for IRQ, FIQ and
SError close together in the switch statement, instead of placing
SError after the virtual interrupts. Given that they use the same code
pattern, it makes sense to order them this way. But as I said, this is
a nit, and not something that affects the outcome of this code.

> >> =C2=A0=C2=A0=C2=A0=C2=A0 default:
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_assert_not_reached(=
);
> >> =C2=A0=C2=A0=C2=A0=C2=A0 }
> >> @@ -538,6 +541,15 @@ bool arm_cpu_exec_interrupt(CPUState *cs, int
> >> interrupt_request)
> >>
> >> =C2=A0=C2=A0=C2=A0=C2=A0 /* The prioritization of interrupts is IMPLEM=
ENTATION DEFIN =20
> ED. */
> >>
> >> +=C2=A0=C2=A0=C2=A0 if (interrupt_request & CPU_INTERRUPT_SERROR) {
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 excp_idx =3D EXCP_SERROR;
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 target_el =3D arm_phys_exc=
p_target_el(cs, excp_id =20
> x, cur_el, secure);
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (arm_excp_unmasked(cs, =
excp_idx, target_el,
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cur_el, secure, hcr_el2)) {
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 go=
to found;
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >> +=C2=A0=C2=A0=C2=A0 }
> >> +
> >> =C2=A0=C2=A0=C2=A0=C2=A0 if (interrupt_request & CPU_INTERRUPT_FIQ) {
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 excp_idx =3D EXCP_FIQ;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 target_el =3D arm_phy=
s_excp_target_el(cs, excp_ =20
> idx, cur_el, secure);
> >> @@ -570,6 +582,7 @@ bool arm_cpu_exec_interrupt(CPUState *cs, int
> >> interrupt_request)
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 goto found;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >> =C2=A0=C2=A0=C2=A0=C2=A0 }
> >> +
> >> =C2=A0=C2=A0=C2=A0=C2=A0 return false;
> >>
> >> =C2=A0 found:
> >> @@ -585,7 +598,7 @@ static bool arm_v7m_cpu_exec_interrupt(CPUState
> >> *cs, int interrupt_request)
> >> =C2=A0=C2=A0=C2=A0=C2=A0 CPUClass *cc =3D CPU_GET_CLASS(cs);
> >> =C2=A0=C2=A0=C2=A0=C2=A0 ARMCPU *cpu =3D ARM_CPU(cs);
> >> =C2=A0=C2=A0=C2=A0=C2=A0 CPUARMState *env =3D &cpu->env;
> >> -=C2=A0=C2=A0=C2=A0 bool ret =3D false;
> >> +=C2=A0=C2=A0=C2=A0 uint32_t excp_idx;
> >>
> >> =C2=A0=C2=A0=C2=A0=C2=A0 /* ARMv7-M interrupt masking works differentl=
y than -A or - =20
> R.
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * There is no FIQ/IRQ distinction. Inst=
ead of I and F bi =20
> ts
> >> @@ -594,13 +607,26 @@ static bool arm_v7m_cpu_exec_interrupt(CPUState
> >> *cs, int interrupt_request)
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * (which depends on state like BASEPRI,=
 FAULTMASK and th =20
> e
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * currently active exception).
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> >> -=C2=A0=C2=A0=C2=A0 if (interrupt_request & CPU_INTERRUPT_HARD
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 && (armv7m_nvic_can_take_p=
ending_exception(env->n =20
> vic))) {
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cs->exception_index =3D EX=
CP_IRQ;
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cc->do_interrupt(cs);
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D true;
> >> +=C2=A0=C2=A0=C2=A0 if (!armv7m_nvic_can_take_pending_exception(env->n=
vic)) {
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
> >> +=C2=A0=C2=A0=C2=A0 }
> >> +
> >> +=C2=A0=C2=A0=C2=A0 if (interrupt_request & CPU_INTERRUPT_SERROR) {
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 excp_idx =3D EXCP_SERROR;
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto found;
> >> +=C2=A0=C2=A0=C2=A0 }
> >> +
> >> +=C2=A0=C2=A0=C2=A0 if (interrupt_request & CPU_INTERRUPT_HARD) {
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 excp_idx =3D EXCP_IRQ;
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto found;
> >> =C2=A0=C2=A0=C2=A0=C2=A0 }
> >> -=C2=A0=C2=A0=C2=A0 return ret;
> >> +
> >> +=C2=A0=C2=A0=C2=A0 return false;
> >> +
> >> +found:
> >> +=C2=A0=C2=A0=C2=A0 cs->exception_index =3D excp_idx;
> >> +=C2=A0=C2=A0=C2=A0 cc->do_interrupt(cs);
> >> +=C2=A0=C2=A0=C2=A0 return true;
> >> =C2=A0}
> >> =C2=A0#endif
> >>
> >> @@ -656,7 +682,8 @@ static void arm_cpu_set_irq(void *opaque, int irq,
> >> int level)
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ARM_CPU_IRQ] =3D CPU=
_INTERRUPT_HARD,
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ARM_CPU_FIQ] =3D CPU=
_INTERRUPT_FIQ,
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ARM_CPU_VIRQ] =3D CP=
U_INTERRUPT_VIRQ,
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ARM_CPU_VFIQ] =3D CPU_INT=
ERRUPT_VFIQ
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ARM_CPU_VFIQ] =3D CPU_INT=
ERRUPT_VFIQ,
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ARM_CPU_SERROR] =3D CPU_I=
NTERRUPT_SERROR,
> >> =C2=A0=C2=A0=C2=A0=C2=A0 };
> >>
> >> =C2=A0=C2=A0=C2=A0=C2=A0 if (level) {
> >> @@ -676,6 +703,7 @@ static void arm_cpu_set_irq(void *opaque, int irq,
> >> int level)
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> >> =C2=A0=C2=A0=C2=A0=C2=A0 case ARM_CPU_IRQ:
> >> =C2=A0=C2=A0=C2=A0=C2=A0 case ARM_CPU_FIQ:
> >> +=C2=A0=C2=A0=C2=A0 case ARM_CPU_SERROR:
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (level) {
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 cpu_interrupt(cs, mask[irq]);
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
> >> @@ -693,8 +721,10 @@ static void arm_cpu_kvm_set_irq(void *opaque, int
> >> irq, int level)
> >> =C2=A0=C2=A0=C2=A0=C2=A0 ARMCPU *cpu =3D opaque;
> >> =C2=A0=C2=A0=C2=A0=C2=A0 CPUARMState *env =3D &cpu->env;
> >> =C2=A0=C2=A0=C2=A0=C2=A0 CPUState *cs =3D CPU(cpu);
> >> +=C2=A0=C2=A0=C2=A0 struct kvm_vcpu_events events;
> >> =C2=A0=C2=A0=C2=A0=C2=A0 uint32_t linestate_bit;
> >> =C2=A0=C2=A0=C2=A0=C2=A0 int irq_id;
> >> +=C2=A0=C2=A0=C2=A0 bool inject_irq =3D true;
> >>
> >> =C2=A0=C2=A0=C2=A0=C2=A0 switch (irq) {
> >> =C2=A0=C2=A0=C2=A0=C2=A0 case ARM_CPU_IRQ:
> >> @@ -705,6 +735,14 @@ static void arm_cpu_kvm_set_irq(void *opaque, int
> >> irq, int level)
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 irq_id =3D KVM_ARM_IR=
Q_CPU_FIQ;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 linestate_bit =3D CPU=
_INTERRUPT_FIQ;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> >> +=C2=A0=C2=A0=C2=A0 case ARM_CPU_SERROR:
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!kvm_has_vcpu_events()=
) {
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn;
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >> +
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inject_irq =3D false;
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 linestate_bit =3D CPU_INTE=
RRUPT_SERROR;
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> >> =C2=A0=C2=A0=C2=A0=C2=A0 default:
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_assert_not_reached(=
);
> >> =C2=A0=C2=A0=C2=A0=C2=A0 }
> >> @@ -714,7 +752,14 @@ static void arm_cpu_kvm_set_irq(void *opaque, int
> >> irq, int level)
> >> =C2=A0=C2=A0=C2=A0=C2=A0 } else {
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->irq_line_state &=
=3D ~linestate_bit;
> >> =C2=A0=C2=A0=C2=A0=C2=A0 }
> >> -=C2=A0=C2=A0=C2=A0 kvm_arm_set_irq(cs->cpu_index, KVM_ARM_IRQ_TYPE_CP=
U, irq_id, !!level);
> >> +
> >> +=C2=A0=C2=A0=C2=A0 if (inject_irq) { =20
> >=20
> > You could just have (linestate_bit !=3D CPU_INTERRUPT_SERROR) here, and=
 n =20
> ot have
> > inject_irq at all.
> >  =20
>=20
> Sure, will be improved in v5.
>=20
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kvm_arm_set_irq(cs->cpu_in=
dex, KVM_ARM_IRQ_TYPE_C =20
> PU, irq_id, !!level);
> >> +=C2=A0=C2=A0=C2=A0 } else if (level) { =20
> >=20
> > Is there any case where you'd call this function with a SError and leve=
l =3D=3D 0?
> > And even if it happens, you could exit early in the above switch statem=
en =20
> t.
> >  =20
>=20
> The combination of SError and level =3D=3D 0 isn't existing for now,
> meaning the SError is always coming with level =3D=3D 1. We can't exit
> early in above s witch statement because env->irq_line_state needs to
> be updated accordingly.

I'm not sure level=3D=3D0 makes much sense. A common implementation of
SError is as an edge interrupt (it is consumed by being handled, and
you can't "retire" it). I'm not familiar enough with QEMU's interrupt
delivery mechanism, but I'd expect SError to differ significantly from
IRQ/FIQ in that respect.

	M.
--=20
Jazz is not dead. It just smells funny...

