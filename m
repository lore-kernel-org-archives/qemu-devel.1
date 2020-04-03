Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1082CC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 08:45:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE02A2080C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 08:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DXfGoMMT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE02A2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKHxS-00043w-Sm
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 04:45:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47913)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1jKHwU-0003Vs-SY
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 04:44:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1jKHwS-0000BT-Pt
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 04:44:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40945
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1jKHwS-00007F-IF
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 04:44:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585903483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uf9wKHGw2CHCijLZ/Myf9ROWae1a3BjiAkVTXxyMyH8=;
 b=DXfGoMMTAqHJT9YnfWByG/zLXBVtg2aqnaZRhIOMdgaxf/BEUgdhgMDAi3B/Lw5uyjwrRO
 r5lbP1pRnLmW5E34i/9FaoCaxpTD9Ohaw+uV0WiCcAo2IxRnfUtW6o9m570WBGp95+u42I
 d01utSda0lJVAMXtH0FP/l+NiGTX2a4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-zPUkWU-FO0SX7DK2Z8SNCw-1; Fri, 03 Apr 2020 04:44:42 -0400
X-MC-Unique: zPUkWU-FO0SX7DK2Z8SNCw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 62F428018A1;
 Fri,  3 Apr 2020 08:44:40 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.193.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 70A7B6EF97;
 Fri,  3 Apr 2020 08:44:38 +0000 (UTC)
Date: Fri, 3 Apr 2020 10:44:35 +0200
From: Andrew Jones <drjones@redhat.com>
To: Beata Michalska <beata.michalska@linaro.org>
Subject: Re: [PATCH v4 2/2] target/arm: kvm: Handle potential issue with dabt
 injection
Message-ID: <20200403084435.zvfewiivn7orsnll@kamzik.brq.redhat.com>
References: <20200323113227.3169-1-beata.michalska@linaro.org>
 <20200323113227.3169-3-beata.michalska@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20200323113227.3169-3-beata.michalska@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, Christoffer.Dall@arm.com,
 qemu-arm@nongnu.org, pbonzini@redhat.com, kvmarm@lists.cs.columbia.edu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Mar 23, 2020 at 11:32:27AM +0000, Beata Michalska wrote:
> Injecting external data abort through KVM might trigger
> an issue on kernels that do not get updated to include the KVM fix.
> For those and aarch32 guests, the injected abort gets misconfigured
> to be an implementation defined exception. This leads to the guest
> repeatedly re-running the faulting instruction.
>=20
> Add support for handling that case.
> [
>   Fixed-by: 018f22f95e8a
> =09('KVM: arm: Fix DFSR setting for non-LPAE aarch32 guests')
>   Fixed-by: 21aecdbd7f3a
> =09('KVM: arm: Make inject_abt32() inject an external abort instead')
> ]
>=20
> Signed-off-by: Beata Michalska <beata.michalska@linaro.org>
> ---
>  target/arm/cpu.h     |  1 +
>  target/arm/kvm.c     | 30 +++++++++++++++++++++++++++++-
>  target/arm/kvm32.c   | 25 +++++++++++++++++++++++++
>  target/arm/kvm64.c   | 34 ++++++++++++++++++++++++++++++++++
>  target/arm/kvm_arm.h | 10 ++++++++++
>  5 files changed, 99 insertions(+), 1 deletion(-)
>=20
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 4f834c1..868afc6 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -561,6 +561,7 @@ typedef struct CPUARMState {
>      } serror;
> =20
>      uint8_t ext_dabt_pending; /* Request for injecting ext DABT */
> +    uint8_t ext_dabt_raised; /* Tracking/verifying injection of ext DABT=
 */
> =20
>      /* State of our input IRQ/FIQ/VIRQ/VFIQ lines */
>      uint32_t irq_line_state;
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index c088589..58ad734 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -721,7 +721,12 @@ int kvm_put_vcpu_events(ARMCPU *cpu)
>      ret =3D kvm_vcpu_ioctl(CPU(cpu), KVM_SET_VCPU_EVENTS, &events);
>      if (ret) {
>          error_report("failed to put vcpu events");
> -    } else {
> +    } else if (env->ext_dabt_pending) {
> +        /*
> +         * Mark that the external DABT has been injected,
> +         * if one has been requested
> +         */
> +        env->ext_dabt_raised =3D env->ext_dabt_pending;
>          /* Clear instantly if the call was successful */
>          env->ext_dabt_pending =3D 0;
>      }
> @@ -755,6 +760,29 @@ int kvm_get_vcpu_events(ARMCPU *cpu)
> =20
>  void kvm_arch_pre_run(CPUState *cs, struct kvm_run *run)
>  {
> +    ARMCPU *cpu =3D ARM_CPU(cs);
> +    CPUARMState *env =3D &cpu->env;
> +
> +    if (unlikely(env->ext_dabt_raised)) {
> +        /*
> +         * Verifying that the ext DABT has been properly injected,
> +         * otherwise risking indefinitely re-running the faulting instru=
ction
> +         * Covering a very narrow case for kernels 5.5..5.5.4
> +         * when injected abort was misconfigured to be
> +         * an IMPLEMENTATION DEFINED exception (for 32-bit EL1)
> +         */
> +        if (!arm_feature(env, ARM_FEATURE_AARCH64) &&
> +            unlikely(!kvm_arm_verify_ext_dabt_pending(cs))) {
> +
> +            error_report("Data abort exception with no valid ISS generat=
ed by "
> +                   "guest memory access. KVM unable to emulate faulting =
"
> +                   "instruction. Failed to inject an external data abort=
 "
> +                   "into the guest.");
> +            abort();
> +       }
> +       /* Clear the status */
> +       env->ext_dabt_raised =3D 0;
> +    }
>  }
> =20
>  MemTxAttrs kvm_arch_post_run(CPUState *cs, struct kvm_run *run)
> diff --git a/target/arm/kvm32.c b/target/arm/kvm32.c
> index f271181..86c4fe7 100644
> --- a/target/arm/kvm32.c
> +++ b/target/arm/kvm32.c
> @@ -564,3 +564,28 @@ void kvm_arm_pmu_init(CPUState *cs)
>  {
>      qemu_log_mask(LOG_UNIMP, "%s: not implemented\n", __func__);
>  }
> +
> +#define ARM_REG_DFSR  ARM_CP15_REG32(0, 5, 0, 0)
> +#define ARM_REG_TTBCR ARM_CP15_REG32(0, 2, 0, 2)
> +
> +#define DFSR_FSC(v)   (((v) >> 6 | (v)) & 0x1F)
> +#define DFSC_EXTABT(lpae) (lpae) ? 0x10 : 0x08

We should put () around the whole ?: expression when it's in a macro

> +
> +bool kvm_arm_verify_ext_dabt_pending(CPUState *cs)
> +{
> +    uint32_t dfsr_val;
> +
> +    if (!kvm_get_one_reg(cs, ARM_REG_DFSR, &dfsr_val)) {
> +        ARMCPU *cpu =3D ARM_CPU(cs);
> +        CPUARMState *env =3D &cpu->env;
> +        uint32_t ttbcr;
> +        int lpae =3D 0;
> +
> +        if (!kvm_get_one_reg(cs, ARM_REG_TTBCR, &ttbcr)) {
> +            lpae =3D arm_feature(env, ARM_FEATURE_LPAE) && (ttbcr & TTBC=
R_EAE);
> +        }
> +        return !(DFSR_FSC(dfsr_val) !=3D DFSC_EXTABT(lpae));

 !(a !=3D b) is a convoluted way to write a =3D=3D b

> +    }
> +    return false;
> +}
> +
> diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
> index be5b31c..18594e9 100644
> --- a/target/arm/kvm64.c
> +++ b/target/arm/kvm64.c
> @@ -1430,3 +1430,37 @@ bool kvm_arm_handle_debug(CPUState *cs, struct kvm=
_debug_exit_arch *debug_exit)
> =20
>      return false;
>  }
> +
> +#define ARM64_REG_ESR_EL1 ARM64_SYS_REG(3, 0, 5, 2, 0)
> +#define ARM64_REG_TCR_EL1 ARM64_SYS_REG(3, 0, 2, 0, 2)
> +
> +#define ESR_DFSC(aarch64, v)    \
> +    ((aarch64) ? ((v) & 0x3F)   \
> +               : (((v) >> 6 | (v)) & 0x1F))
> +
> +#define ESR_DFSC_EXTABT(aarch64, lpae) \
> +    ((aarch64) ? 0x10 : (lpae) ? 0x10 : 0x8)
> +
> +bool kvm_arm_verify_ext_dabt_pending(CPUState *cs)
> +{
> +    uint64_t dfsr_val;
> +
> +    if (!kvm_get_one_reg(cs, ARM64_REG_ESR_EL1, &dfsr_val)) {
> +        ARMCPU *cpu =3D ARM_CPU(cs);
> +        CPUARMState *env =3D &cpu->env;
> +        int aarch64_mode =3D arm_feature(env, ARM_FEATURE_AARCH64);
> +        int lpae =3D 0;
> +
> +        if (!aarch64_mode) {
> +            uint64_t ttbcr;
> +
> +            if (!kvm_get_one_reg(cs, ARM64_REG_TCR_EL1, &ttbcr)) {
> +                lpae =3D arm_feature(env, ARM_FEATURE_LPAE)
> +                        && (ttbcr & TTBCR_EAE);
> +            }
> +        }
> +        return !(ESR_DFSC(aarch64_mode, dfsr_val) !=3D
> +                ESR_DFSC_EXTABT(aarch64_mode, lpae));

a =3D=3D b, please

> +    }
> +    return false;
> +}
> diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
> index 39472d5..f2dc6a2 100644
> --- a/target/arm/kvm_arm.h
> +++ b/target/arm/kvm_arm.h
> @@ -461,6 +461,16 @@ void kvm_arm_copy_hw_debug_data(struct kvm_guest_deb=
ug_arch *ptr);
>  int kvm_arm_handle_dabt_nisv(CPUState *cs, uint64_t esr_iss,
>                               uint64_t fault_ipa);
>  /**
> + * kvm_arm_verify_ext_dabt_pending:
> + * @cs: CPUState
> + *
> + * Verify the fault status code wrt the Ext DABT injection
> + *
> + * Returns: true if the fault status code is as expected, false otherwis=
e
> + */
> +bool kvm_arm_verify_ext_dabt_pending(CPUState *cs);
> +
> +/**
>   * its_class_name:
>   *
>   * Return the ITS class name to use depending on whether KVM acceleratio=
n
> --=20
> 2.7.4
>=20
>

I'll leave the decision to take this KVM bug workaround patch at all to Pet=
er,
and I didn't actually review whether or not kvm_arm_verify_ext_dabt_pending
is doing what it claims it's doing, so I'm reluctant to give an r-b on
this patch. But, as far as the code goes, besides the comments above, it
looks fine to me.

Thanks,
drew


