Received: from eggs.gnu.org ([2001:4830:134:3::10]:33045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f8XhB-0003OP-A2
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 16:59:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f8Xh7-0004nf-Bd
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 16:59:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52000)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1f8Xh7-0004dK-0Q
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 16:59:17 -0400
Date: Tue, 17 Apr 2018 17:59:13 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180417205913.GC29865@localhost.localdomain>
References: <1523953455-28053-1-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1523953455-28053-1-git-send-email-wanpengli@tencent.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RESEND v2] i386/kvm: add support for
 KVM_CAP_X86_DISABLE_EXITS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wanpeng Li <kernellwp@gmail.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>

On Tue, Apr 17, 2018 at 01:24:15AM -0700, Wanpeng Li wrote:
> From: Wanpeng Li <wanpengli@tencent.com>
>=20
> This patch adds support for KVM_CAP_X86_DISABLE_EXITS. Provides userspa=
ce with=20
> per-VM capability(KVM_CAP_X86_DISABLE_EXITS) to not intercept MWAIT/HLT=
/PAUSE=20
> in order that to improve latency in some workloads.
>=20
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.com>=20
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
>=20
>  linux-headers/linux/kvm.h |  6 +++++-
>  target/i386/cpu.h         |  2 ++
>  target/i386/kvm.c         | 16 ++++++++++++++++
>  3 files changed, 23 insertions(+), 1 deletion(-)
>=20
> diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
> index a167be8..857df15 100644
> --- a/linux-headers/linux/kvm.h
> +++ b/linux-headers/linux/kvm.h
> @@ -925,7 +925,7 @@ struct kvm_ppc_resize_hpt {
>  #define KVM_CAP_S390_GS 140
>  #define KVM_CAP_S390_AIS 141
>  #define KVM_CAP_SPAPR_TCE_VFIO 142
> -#define KVM_CAP_X86_GUEST_MWAIT 143
> +#define KVM_CAP_X86_DISABLE_EXITS 143
>  #define KVM_CAP_ARM_USER_IRQ 144
>  #define KVM_CAP_S390_CMMA_MIGRATION 145
>  #define KVM_CAP_PPC_FWNMI 146
> @@ -1508,6 +1508,10 @@ struct kvm_assigned_msix_entry {
>  #define KVM_X2APIC_API_USE_32BIT_IDS            (1ULL << 0)
>  #define KVM_X2APIC_API_DISABLE_BROADCAST_QUIRK  (1ULL << 1)
> =20
> +#define KVM_X86_DISABLE_EXITS_MWAIT          (1 << 0)
> +#define KVM_X86_DISABLE_EXITS_HLT            (1 << 1)
> +#define KVM_X86_DISABLE_EXITS_PAUSE          (1 << 2)
> +
>  /* Available with KVM_CAP_ARM_USER_IRQ */
> =20
>  /* Bits for run->s.regs.device_irq_level */
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 1b219fa..965de1b 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -685,6 +685,8 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
>  #define CPUID_7_0_EDX_AVX512_4FMAPS (1U << 3) /* AVX512 Multiply Accum=
ulation Single Precision */
>  #define CPUID_7_0_EDX_SPEC_CTRL     (1U << 26) /* Speculation Control =
*/
> =20
> +#define KVM_PV_UNHALT (1U << 7)
> +
>  #define KVM_HINTS_DEDICATED (1U << 0)
> =20
>  #define CPUID_8000_0008_EBX_IBPB    (1U << 12) /* Indirect Branch Pred=
iction Barrier */
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 6c49954..3e99830 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -1029,6 +1029,22 @@ int kvm_arch_init_vcpu(CPUState *cs)
>          }
>      }
> =20
> +    if (env->features[FEAT_KVM_HINTS] & KVM_HINTS_DEDICATED) {
> +        int disable_exits =3D kvm_check_extension(cs->kvm_state, KVM_C=
AP_X86_DISABLE_EXITS);
> +
> +        if (disable_exits) {
> +            disable_exits &=3D (KVM_X86_DISABLE_EXITS_MWAIT |
> +                              KVM_X86_DISABLE_EXITS_HLT |
> +                              KVM_X86_DISABLE_EXITS_PAUSE);
> +            if (env->user_features[FEAT_KVM] & KVM_PV_UNHALT) {
> +                disable_exits &=3D ~KVM_X86_DISABLE_EXITS_HLT;
> +            }

In the future, if we decide to enable kvm-pv-unhalt by default,
should "-cpu ...,kvm-hint-dedicated=3Don" disable kvm-pv-unhalt
automatically, or should we require an explicit
"kvm-hint-dedicated=3Don,kvm-pv-unhalt=3Doff" option?

For today's defaults, this patch solves the problem, only one
thing is missing before I give my R-b: we need to clearly
document what exactly are the consequences and requirements of
setting kvm-hint-dedicated=3Don (I'm not sure if the best place for
this is qemu-options.hx, x86_cpu_list(), or somewhere else).

> +        }
> +        if (kvm_vm_enable_cap(cs->kvm_state, KVM_CAP_X86_DISABLE_EXITS=
, 0, disable_exits)) {
> +            error_report("kvm: DISABLE EXITS not supported");
> +        }
> +    }
> +
>      qemu_add_vm_change_state_handler(cpu_update_state, env);
> =20
>      c =3D cpuid_find_entry(&cpuid_data.cpuid, 1, 0);
> --=20
> 2.7.4
>=20

--=20
Eduardo
