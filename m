Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 346E5C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 10:26:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEB6420674
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 10:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i1EbQHJS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEB6420674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCL2l-0006x0-2S
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 06:26:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39111)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1jCL25-0005Yg-DZ
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 06:25:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1jCL22-00030T-VE
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 06:25:40 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35504
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1jCL22-0002zI-Np
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 06:25:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584008737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G7jEyYLokTrruOrRCqepmYEHqJ5Ok6mSEIyyRqTgfXY=;
 b=i1EbQHJSoaFwD/NRX1d1IEzJgYmT45F5eNhEiAVa3/4yAG/aU+dygNbzFPVq+x6+FBvuvg
 x9EC9BfwkraDcFu6xe3sZ6q20f1U4nCECpL17o83zCP0QOCBpph6MLy3x+EaPLIbOryK7Y
 jKGxnDM2QUdVfwULszxW0CtuzWp/9xQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-SmhC-fIdPJ25Vq-0GBqtsg-1; Thu, 12 Mar 2020 06:25:35 -0400
X-MC-Unique: SmhC-fIdPJ25Vq-0GBqtsg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7A985107B791;
 Thu, 12 Mar 2020 10:25:34 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 963998F37D;
 Thu, 12 Mar 2020 10:25:32 +0000 (UTC)
Date: Thu, 12 Mar 2020 11:25:30 +0100
From: Andrew Jones <drjones@redhat.com>
To: Beata Michalska <beata.michalska@linaro.org>
Subject: Re: [PATCH v3 2/2] target/arm: kvm: Handle DABT with no valid ISS
Message-ID: <20200312102530.a55grtyfrnx2glj4@kamzik.brq.redhat.com>
References: <20200312003401.29017-1-beata.michalska@linaro.org>
 <20200312003401.29017-3-beata.michalska@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20200312003401.29017-3-beata.michalska@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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

On Thu, Mar 12, 2020 at 12:34:01AM +0000, Beata Michalska wrote:
> On ARMv7 & ARMv8 some load/store instructions might trigger a data abort
> exception with no valid ISS info to be decoded. The lack of decode info
> makes it at least tricky to emulate those instruction which is one of the
> (many) reasons why KVM will not even try to do so.
>=20
> Add support for handling those by requesting KVM to inject external
> dabt into the quest.
>=20
> Signed-off-by: Beata Michalska <beata.michalska@linaro.org>
> ---
>  target/arm/cpu.h     |  3 ++
>  target/arm/kvm.c     | 81 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  target/arm/kvm32.c   | 26 +++++++++++++++++
>  target/arm/kvm64.c   | 36 +++++++++++++++++++++++
>  target/arm/kvm_arm.h | 22 ++++++++++++++
>  5 files changed, 168 insertions(+)
>=20
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 4ffd991..45fdd2e 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -560,6 +560,9 @@ typedef struct CPUARMState {
>          uint64_t esr;
>      } serror;
> =20
> +    uint8_t ext_dabt_pending:1; /* Request for injecting ext DABT */
> +    uint8_t ext_dabt_raised:1; /* Tracking/verifying injection of ext DA=
BT */
> +

Why the bit-fields? We don't use them anywhere else in cpu.h, and that's
probably because they're not portable. We should just use bools.

>      /* State of our input IRQ/FIQ/VIRQ/VFIQ lines */
>      uint32_t irq_line_state;
> =20
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 85860e6..8b7b708 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -39,6 +39,7 @@ const KVMCapabilityInfo kvm_arch_required_capabilities[=
] =3D {
> =20
>  static bool cap_has_mp_state;
>  static bool cap_has_inject_serror_esr;
> +static bool cap_has_inject_ext_dabt;
> =20
>  static ARMHostCPUFeatures arm_host_cpu_features;
> =20
> @@ -244,6 +245,16 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>          ret =3D -EINVAL;
>      }
> =20
> +    if (kvm_check_extension(s, KVM_CAP_ARM_NISV_TO_USER)) {
> +        if (kvm_vm_enable_cap(s, KVM_CAP_ARM_NISV_TO_USER, 0)) {
> +            warn_report("Failed to enable DABT NISV cap");
> +        } else {
> +            /* Set status for supporting the external dabt injection */
> +            cap_has_inject_ext_dabt =3D kvm_check_extension(s,
> +                                    KVM_CAP_ARM_INJECT_EXT_DABT);
> +        }
> +    }
> +
>      return ret;
>  }
> =20
> @@ -703,9 +714,20 @@ int kvm_put_vcpu_events(ARMCPU *cpu)
>          events.exception.serror_esr =3D env->serror.esr;
>      }
> =20
> +    if (cap_has_inject_ext_dabt) {
> +        events.exception.ext_dabt_pending =3D env->ext_dabt_pending;
> +    }
> +
>      ret =3D kvm_vcpu_ioctl(CPU(cpu), KVM_SET_VCPU_EVENTS, &events);
>      if (ret) {
>          error_report("failed to put vcpu events");
> +    } else if (env->ext_dabt_pending) {
> +        /*
> +         * Mark that the external DABT has been injected,
> +         * if one has been requested
> +         */
> +        env->ext_dabt_raised =3D env->ext_dabt_pending;
> +        env->ext_dabt_pending =3D 0;
>      }
> =20
>      return ret;
> @@ -737,6 +759,30 @@ int kvm_get_vcpu_events(ARMCPU *cpu)
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

I'm still not convinced that QEMU needs to add workarounds for broken KVM,
when KVM can be fixed, and even is already fixed. If you really want to
keep it, then can you break this patch into two, splitting the dabt
injection out from the workaround?

> +         * when injected abort was misconfigured to be
> +         * an IMPLEMENTATION DEFINED exception (for 32-bit EL1)
> +         */
> +        if (!arm_feature(env, ARM_FEATURE_AARCH64) &&
> +            unlikely(kvm_arm_verify_ext_dabt_pending(cs))) {
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
> +
>  }
> =20
>  MemTxAttrs kvm_arch_post_run(CPUState *cs, struct kvm_run *run)
> @@ -819,6 +865,11 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_ru=
n *run)
>              ret =3D EXCP_DEBUG;
>          } /* otherwise return to guest */
>          break;
> +    case KVM_EXIT_ARM_NISV:
> +        /* External DABT with no valid iss to decode */
> +        ret =3D kvm_arm_handle_dabt_nisv(cs, run->arm_nisv.esr_iss,
> +                                       run->arm_nisv.fault_ipa);
> +        break;
>      default:
>          qemu_log_mask(LOG_UNIMP, "%s: un-handled exit reason %d\n",
>                        __func__, run->exit_reason);
> @@ -953,3 +1004,33 @@ int kvm_arch_msi_data_to_gsi(uint32_t data)
>  {
>      return (data - 32) & 0xffff;
>  }
> +
> +int kvm_arm_handle_dabt_nisv(CPUState *cs, uint64_t esr_iss,
> +                             uint64_t fault_ipa)
> +{
> +    ARMCPU *cpu =3D ARM_CPU(cs);
> +    CPUARMState *env =3D &cpu->env;
> +
> +   /*
> +    * ISS [23:14] is invalid so there is a limited info
> +    * on what has just happened so the only *useful* thing that can
> +    * be retrieved from ISS is WnR & DFSC (though in some cases WnR
> +    * might be less of a value as well)
> +    */
> +
> +    /*
> +     * Set pending ext dabt and trigger SET_EVENTS so that
> +     * KVM can inject the abort
> +     */
> +    if (cap_has_inject_ext_dabt) {
> +        kvm_cpu_synchronize_state(cs);
> +        env->ext_dabt_pending =3D 1;
> +    } else {
> +        error_report("Data abort exception triggered by guest memory acc=
ess "
> +                     "at physical address: 0x"  TARGET_FMT_lx,
> +                     (target_ulong)fault_ipa);
> +        error_printf("KVM unable to emulate faulting instruction.\n");

return -1;

> +    }
> +
> +    return cap_has_inject_ext_dabt ? 0 : -1;

return 0;

> +}
> diff --git a/target/arm/kvm32.c b/target/arm/kvm32.c
> index f271181..4795a7d 100644
> --- a/target/arm/kvm32.c
> +++ b/target/arm/kvm32.c
> @@ -564,3 +564,29 @@ void kvm_arm_pmu_init(CPUState *cs)
>  {
>      qemu_log_mask(LOG_UNIMP, "%s: not implemented\n", __func__);
>  }
> +
> +
> +#define ARM_REG_DFSR  ARM_CP15_REG32(0, 5, 0, 0)
> +#define ARM_REG_TTBCR ARM_CP15_REG32(0, 2, 0, 2)
> +
> +#define DFSR_FSC(v)   (((v) >> 6 | (v)) & 0x1F)
> +#define DFSC_EXTABT(lpae) (lpae) ? 0x10 : 0x08
> +
> +int kvm_arm_verify_ext_dabt_pending(CPUState *cs)
> +{
> +    uint32_t dfsr_val;
> +
> +    if (!kvm_get_one_reg(cs, ARM_REG_DFSR, &dfsr_val)) {
> +

extra line

> +        ARMCPU *cpu =3D ARM_CPU(cs);
> +        CPUARMState *env =3D &cpu->env;
> +        uint32_t ttbcr;
> +        int lpae =3D 0;
> +
> +        if (!kvm_get_one_reg(cs, ARM_REG_TTBCR, &ttbcr)) {
> +            lpae =3D arm_feature(env, ARM_FEATURE_LPAE) && (ttbcr & TTBC=
R_EAE);
> +        }
> +        return DFSR_FSC(dfsr_val) !=3D DFSC_EXTABT(lpae);
> +    }
> +    return 1;
> +}
> diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
> index be5b31c..2f8ffc6 100644
> --- a/target/arm/kvm64.c
> +++ b/target/arm/kvm64.c
> @@ -1430,3 +1430,39 @@ bool kvm_arm_handle_debug(CPUState *cs, struct kvm=
_debug_exit_arch *debug_exit)
> =20
>      return false;
>  }
> +
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
> +int kvm_arm_verify_ext_dabt_pending(CPUState *cs)
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
> +

extra line

> +            uint64_t ttbcr;
> +
> +            if (!kvm_get_one_reg(cs, ARM64_REG_TCR_EL1, &ttbcr)) {
> +                lpae =3D arm_feature(env, ARM_FEATURE_LPAE)
> +                        && (ttbcr & TTBCR_EAE);
> +            }
> +        }
> +        return ESR_DFSC(aarch64_mode, dfsr_val) !=3D
> +                ESR_DFSC_EXTABT(aarch64_mode, lpae) ;
                  ^ extra space

> +    }
> +    return 1;
> +}
> diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
> index ae9e075..777c9bf 100644
> --- a/target/arm/kvm_arm.h
> +++ b/target/arm/kvm_arm.h
> @@ -450,6 +450,28 @@ struct kvm_guest_debug_arch;
>  void kvm_arm_copy_hw_debug_data(struct kvm_guest_debug_arch *ptr);
> =20
>  /**
> + * kvm_arm_handle_dabt_nisv
                              ^ missing :
> + * @cs: CPUState
> + * @esr_iss: ISS encoding (limited) for the exception from Data Abort
> + *           ISV bit set to '0b0' -> no valid instruction syndrome
> + * @fault_ipa: faulting address for the synch data abort
> + *
> + * Returns: 0 if the exception has been handled
                                                  , < 0 otherwise

> + */
> +int kvm_arm_handle_dabt_nisv(CPUState *cs, uint64_t esr_iss,
> +                             uint64_t fault_ipa);
> +
> +/**
> + * kvm_arm_verify_ext_dabt_pending
                                     ^ missing :
> + * @cs: CPUState
> + *
> + * Verify the fault status code wrt the Ext DABT injection
> + *
> + * Returns: 0 if the fault status code is as expected, non-zero otherwis=
e

I'd return a boolean from a function like this, true when verified and
false otherwise.

> + */
> +int kvm_arm_verify_ext_dabt_pending(CPUState *cs);
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

Thanks,
drew=20


