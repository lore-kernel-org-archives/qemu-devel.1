Received: from eggs.gnu.org ([2001:4830:134:3::10]:37423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fHG3B-0005n5-ML
	for qemu-devel@nongnu.org; Fri, 11 May 2018 17:58:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fHG37-0003Oe-P2
	for qemu-devel@nongnu.org; Fri, 11 May 2018 17:58:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54478 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fHG37-0003OU-JD
	for qemu-devel@nongnu.org; Fri, 11 May 2018 17:58:01 -0400
Date: Sat, 12 May 2018 00:57:59 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180512005735-mutt-send-email-mst@kernel.org>
References: <1523953455-28053-1-git-send-email-wanpengli@tencent.com>
	<20180417201904-mutt-send-email-mst@kernel.org>
	<CANRm+CxGRxrpybqjqicauF2ROZs7+76uReMBmpNRdzM=dDWUZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANRm+CxGRxrpybqjqicauF2ROZs7+76uReMBmpNRdzM=dDWUZg@mail.gmail.com>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>

On Wed, Apr 18, 2018 at 09:09:19AM +0800, Wanpeng Li wrote:
> 2018-04-18 2:08 GMT+08:00 Michael S. Tsirkin <mst@redhat.com>:
> > On Tue, Apr 17, 2018 at 01:24:15AM -0700, Wanpeng Li wrote:
> >> From: Wanpeng Li <wanpengli@tencent.com>
> >>
> >> This patch adds support for KVM_CAP_X86_DISABLE_EXITS. Provides user=
space with
> >> per-VM capability(KVM_CAP_X86_DISABLE_EXITS) to not intercept MWAIT/=
HLT/PAUSE
> >> in order that to improve latency in some workloads.
> >>
> >> Cc: Paolo Bonzini <pbonzini@redhat.com>
> >> Cc: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.com>
> >> Cc: Eduardo Habkost <ehabkost@redhat.com>
> >> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> >> ---
> >>
> >>  linux-headers/linux/kvm.h |  6 +++++-
> >>  target/i386/cpu.h         |  2 ++
> >>  target/i386/kvm.c         | 16 ++++++++++++++++
> >>  3 files changed, 23 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
> >> index a167be8..857df15 100644
> >> --- a/linux-headers/linux/kvm.h
> >> +++ b/linux-headers/linux/kvm.h
> >> @@ -925,7 +925,7 @@ struct kvm_ppc_resize_hpt {
> >>  #define KVM_CAP_S390_GS 140
> >>  #define KVM_CAP_S390_AIS 141
> >>  #define KVM_CAP_SPAPR_TCE_VFIO 142
> >> -#define KVM_CAP_X86_GUEST_MWAIT 143
> >> +#define KVM_CAP_X86_DISABLE_EXITS 143
> >>  #define KVM_CAP_ARM_USER_IRQ 144
> >>  #define KVM_CAP_S390_CMMA_MIGRATION 145
> >>  #define KVM_CAP_PPC_FWNMI 146
> >> @@ -1508,6 +1508,10 @@ struct kvm_assigned_msix_entry {
> >>  #define KVM_X2APIC_API_USE_32BIT_IDS            (1ULL << 0)
> >>  #define KVM_X2APIC_API_DISABLE_BROADCAST_QUIRK  (1ULL << 1)
> >>
> >> +#define KVM_X86_DISABLE_EXITS_MWAIT          (1 << 0)
> >> +#define KVM_X86_DISABLE_EXITS_HLT            (1 << 1)
> >> +#define KVM_X86_DISABLE_EXITS_PAUSE          (1 << 2)
> >> +
> >>  /* Available with KVM_CAP_ARM_USER_IRQ */
> >>
> >>  /* Bits for run->s.regs.device_irq_level */
> >> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> >> index 1b219fa..965de1b 100644
> >> --- a/target/i386/cpu.h
> >> +++ b/target/i386/cpu.h
> >> @@ -685,6 +685,8 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS]=
;
> >>  #define CPUID_7_0_EDX_AVX512_4FMAPS (1U << 3) /* AVX512 Multiply Ac=
cumulation Single Precision */
> >>  #define CPUID_7_0_EDX_SPEC_CTRL     (1U << 26) /* Speculation Contr=
ol */
> >>
> >> +#define KVM_PV_UNHALT (1U << 7)
> >> +
> >
> > Why don't we use KVM_FEATURE_PV_UNHALT from kvm_para.h?
> >
> >>  #define KVM_HINTS_DEDICATED (1U << 0)
> >>
> >
> > BTW I wonder whether we should switch to a value from
> > kvm_para.h? I'll send a version to do it, pls take a look.
>=20
> Yeah, your patchset looks good.
>=20
> Regards,
> Wanpeng Li

Do you plan to rebase your patch and upstream it or do you expect me to
do it?

> >
> >
> >>  #define CPUID_8000_0008_EBX_IBPB    (1U << 12) /* Indirect Branch P=
rediction Barrier */
> >> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> >> index 6c49954..3e99830 100644
> >> --- a/target/i386/kvm.c
> >> +++ b/target/i386/kvm.c
> >> @@ -1029,6 +1029,22 @@ int kvm_arch_init_vcpu(CPUState *cs)
> >>          }
> >>      }
> >>
> >> +    if (env->features[FEAT_KVM_HINTS] & KVM_HINTS_DEDICATED) {
> >> +        int disable_exits =3D kvm_check_extension(cs->kvm_state, KV=
M_CAP_X86_DISABLE_EXITS);
> >> +
> >> +        if (disable_exits) {
> >> +            disable_exits &=3D (KVM_X86_DISABLE_EXITS_MWAIT |
> >> +                              KVM_X86_DISABLE_EXITS_HLT |
> >> +                              KVM_X86_DISABLE_EXITS_PAUSE);
> >> +            if (env->user_features[FEAT_KVM] & KVM_PV_UNHALT) {
> >> +                disable_exits &=3D ~KVM_X86_DISABLE_EXITS_HLT;
> >> +            }
> >> +        }
> >> +        if (kvm_vm_enable_cap(cs->kvm_state, KVM_CAP_X86_DISABLE_EX=
ITS, 0, disable_exits)) {
> >> +            error_report("kvm: DISABLE EXITS not supported");
> >> +        }
> >> +    }
> >> +
> >>      qemu_add_vm_change_state_handler(cpu_update_state, env);
> >>
> >>      c =3D cpuid_find_entry(&cpuid_data.cpuid, 1, 0);
> >> --
> >> 2.7.4
