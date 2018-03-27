Received: from eggs.gnu.org ([2001:4830:134:3::10]:42116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1f0uUt-0008Tp-Oy
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 15:43:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1f0uUp-0006qX-5g
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 15:43:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43728 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1f0uUp-0006px-0J
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 15:43:03 -0400
Date: Tue, 27 Mar 2018 22:42:56 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180327224058-mutt-send-email-mst@kernel.org>
References: <1521211002-4529-1-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1521211002-4529-1-git-send-email-wanpengli@tencent.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] i386/kvm: add support for
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
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On Fri, Mar 16, 2018 at 07:36:42AM -0700, Wanpeng Li wrote:
> From: Wanpeng Li <wanpengli@tencent.com>
>=20
> This patch adds support for KVM_CAP_X86_DISABLE_EXITS. Provides userspa=
ce with=20
> per-VM capability(KVM_CAP_X86_DISABLE_EXITS) to not intercept MWAIT/HLT=
/PAUSE=20
> in order that to improve latency in some workloads.
>=20
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
>  linux-headers/linux/kvm.h |  6 +++++-
>  target/i386/kvm.c         | 12 ++++++++++++
>  2 files changed, 17 insertions(+), 1 deletion(-)
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
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index d23fff1..95ed9eb 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -999,6 +999,18 @@ int kvm_arch_init_vcpu(CPUState *cs)
>          }
>      }
> =20
> +    if (env->features[FEAT_KVM_HINTS] & KVM_HINTS_DEDICATED) {
> +        int disable_exits =3D kvm_check_extension(cs->kvm_state, KVM_C=
AP_X86_DISABLE_EXITS);
> +        if (disable_exits) {
> +            disable_exits &=3D (KVM_X86_DISABLE_EXITS_MWAIT |
> +                              KVM_X86_DISABLE_EXITS_HLT |
> +                              KVM_X86_DISABLE_EXITS_PAUSE);
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

Why not a bit per capability?
I can see how someone might want to disable mwait exists
but not the rest of them.

> --=20
> 2.7.4
