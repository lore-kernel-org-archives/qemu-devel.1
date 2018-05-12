Received: from eggs.gnu.org ([2001:4830:134:3::10]:34781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kernellwp@gmail.com>) id 1fHIjI-0000wK-4j
	for qemu-devel@nongnu.org; Fri, 11 May 2018 20:49:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kernellwp@gmail.com>) id 1fHIjH-000568-3R
	for qemu-devel@nongnu.org; Fri, 11 May 2018 20:49:44 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:38045)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kernellwp@gmail.com>) id 1fHIjG-00055w-UG
	for qemu-devel@nongnu.org; Fri, 11 May 2018 20:49:43 -0400
Received: by mail-ot0-x243.google.com with SMTP id n3-v6so8198945ota.5
	for <qemu-devel@nongnu.org>; Fri, 11 May 2018 17:49:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180512005735-mutt-send-email-mst@kernel.org>
References: <1523953455-28053-1-git-send-email-wanpengli@tencent.com>
	<20180417201904-mutt-send-email-mst@kernel.org>
	<CANRm+CxGRxrpybqjqicauF2ROZs7+76uReMBmpNRdzM=dDWUZg@mail.gmail.com>
	<20180512005735-mutt-send-email-mst@kernel.org>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Sat, 12 May 2018 08:49:41 +0800
Message-ID: <CANRm+CxY0GmHmpVf+SXBofKMuRWpF9iOnk8xnyU4Dh=2o2s4SA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>

2018-05-12 5:57 GMT+08:00 Michael S. Tsirkin <mst@redhat.com>:
> On Wed, Apr 18, 2018 at 09:09:19AM +0800, Wanpeng Li wrote:
>> 2018-04-18 2:08 GMT+08:00 Michael S. Tsirkin <mst@redhat.com>:
>> > On Tue, Apr 17, 2018 at 01:24:15AM -0700, Wanpeng Li wrote:
>> >> From: Wanpeng Li <wanpengli@tencent.com>
>> >>
>> >> This patch adds support for KVM_CAP_X86_DISABLE_EXITS. Provides users=
pace with
>> >> per-VM capability(KVM_CAP_X86_DISABLE_EXITS) to not intercept MWAIT/H=
LT/PAUSE
>> >> in order that to improve latency in some workloads.
>> >>
>> >> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> >> Cc: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.com>
>> >> Cc: Eduardo Habkost <ehabkost@redhat.com>
>> >> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
>> >> ---
>> >>
>> >>  linux-headers/linux/kvm.h |  6 +++++-
>> >>  target/i386/cpu.h         |  2 ++
>> >>  target/i386/kvm.c         | 16 ++++++++++++++++
>> >>  3 files changed, 23 insertions(+), 1 deletion(-)
>> >>
>> >> diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
>> >> index a167be8..857df15 100644
>> >> --- a/linux-headers/linux/kvm.h
>> >> +++ b/linux-headers/linux/kvm.h
>> >> @@ -925,7 +925,7 @@ struct kvm_ppc_resize_hpt {
>> >>  #define KVM_CAP_S390_GS 140
>> >>  #define KVM_CAP_S390_AIS 141
>> >>  #define KVM_CAP_SPAPR_TCE_VFIO 142
>> >> -#define KVM_CAP_X86_GUEST_MWAIT 143
>> >> +#define KVM_CAP_X86_DISABLE_EXITS 143
>> >>  #define KVM_CAP_ARM_USER_IRQ 144
>> >>  #define KVM_CAP_S390_CMMA_MIGRATION 145
>> >>  #define KVM_CAP_PPC_FWNMI 146
>> >> @@ -1508,6 +1508,10 @@ struct kvm_assigned_msix_entry {
>> >>  #define KVM_X2APIC_API_USE_32BIT_IDS            (1ULL << 0)
>> >>  #define KVM_X2APIC_API_DISABLE_BROADCAST_QUIRK  (1ULL << 1)
>> >>
>> >> +#define KVM_X86_DISABLE_EXITS_MWAIT          (1 << 0)
>> >> +#define KVM_X86_DISABLE_EXITS_HLT            (1 << 1)
>> >> +#define KVM_X86_DISABLE_EXITS_PAUSE          (1 << 2)
>> >> +
>> >>  /* Available with KVM_CAP_ARM_USER_IRQ */
>> >>
>> >>  /* Bits for run->s.regs.device_irq_level */
>> >> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
>> >> index 1b219fa..965de1b 100644
>> >> --- a/target/i386/cpu.h
>> >> +++ b/target/i386/cpu.h
>> >> @@ -685,6 +685,8 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
>> >>  #define CPUID_7_0_EDX_AVX512_4FMAPS (1U << 3) /* AVX512 Multiply Acc=
umulation Single Precision */
>> >>  #define CPUID_7_0_EDX_SPEC_CTRL     (1U << 26) /* Speculation Contro=
l */
>> >>
>> >> +#define KVM_PV_UNHALT (1U << 7)
>> >> +
>> >
>> > Why don't we use KVM_FEATURE_PV_UNHALT from kvm_para.h?
>> >
>> >>  #define KVM_HINTS_DEDICATED (1U << 0)
>> >>
>> >
>> > BTW I wonder whether we should switch to a value from
>> > kvm_para.h? I'll send a version to do it, pls take a look.
>>
>> Yeah, your patchset looks good.
>>
>> Regards,
>> Wanpeng Li
>
> Do you plan to rebase your patch and upstream it or do you expect me to
> do it?

You can pick it since I am too busy recently. Thanks Michael!

Regards,
Wanpeng Li
