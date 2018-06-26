Received: from eggs.gnu.org ([2001:4830:134:3::10]:57898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <robert.hu@linux.intel.com>) id 1fXlp8-0001iD-Gd
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 07:07:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <robert.hu@linux.intel.com>) id 1fXlp3-0002vk-Li
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 07:07:50 -0400
Received: from mga18.intel.com ([134.134.136.126]:52597)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <robert.hu@linux.intel.com>)
	id 1fXlp3-0002vX-BC
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 07:07:45 -0400
Message-ID: <1530011262.22880.6.camel@linux.intel.com>
From: Robert Hoo <robert.hu@linux.intel.com>
Date: Tue, 26 Jun 2018 19:07:42 +0800
In-Reply-To: <58ec011e-0f19-f882-abca-dd73bda95fe5@redhat.com>
References: <1529897961-134132-1-git-send-email-robert.hu@linux.intel.com>
	<1529897961-134132-3-git-send-email-robert.hu@linux.intel.com>
	<58ec011e-0f19-f882-abca-dd73bda95fe5@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/5] i386: Add CPUID bit and feature words
 for IA32_ARCH_CAPABILITIES MSR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, rth@twiddle.net, ehabkost@redhat.com

On Mon, 2018-06-25 at 14:06 +0200, Paolo Bonzini wrote:
> On 25/06/2018 05:39, Robert Hoo wrote:
> > Support of IA32_PRED_CMD MSR already be enumerated by same CPUID bit as
> > SPEC_CTRL.
> > 
> > Signed-off-by: Robert Hoo <robert.hu@linux.intel.com>
> > ---
> >  target/i386/cpu.c | 2 +-
> >  target/i386/cpu.h | 1 +
> >  2 files changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index 1e69e68..3134af4 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -896,7 +896,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
> >              NULL, NULL, NULL, NULL,
> >              NULL, NULL, NULL, NULL,
> >              NULL, NULL, "spec-ctrl", NULL,
> > -            NULL, NULL, NULL, "ssbd",
> > +            NULL, "arch-capabilities", NULL, "ssbd",
> >          },
> >          .cpuid_eax = 7,
> >          .cpuid_needs_ecx = true, .cpuid_ecx = 0,
> > diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> > index 734a73e..1ef2040 100644
> > --- a/target/i386/cpu.h
> > +++ b/target/i386/cpu.h
> > @@ -688,6 +688,7 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
> >  #define CPUID_7_0_EDX_AVX512_4VNNIW (1U << 2) /* AVX512 Neural Network Instructions */
> >  #define CPUID_7_0_EDX_AVX512_4FMAPS (1U << 3) /* AVX512 Multiply Accumulation Single Precision */
> >  #define CPUID_7_0_EDX_SPEC_CTRL     (1U << 26) /* Speculation Control */
> > +#define CPUID_7_0_EDX_ARCH_CAPABILITIES (1U << 29)  /*Arch Capabilities of RDCL_NO and IBRS_ALL*/
> >  #define CPUID_7_0_EDX_SPEC_CTRL_SSBD  (1U << 31) /* Speculative Store Bypass Disable */
> >  
> >  #define CPUID_8000_0008_EBX_IBPB    (1U << 12) /* Indirect Branch Prediction Barrier */
> > 
> 
> For migration to work, you need to add new "features" corresponding to
> the bits in the MSR, and include them in the Icelake-Server and
> Icelake-Client models.  Unfortunately there is no code for this in QEMU
> yet, though the API is there in KVM.
> 
> I have just sent the KVM patch to pass the MSR value down to QEMU ("KVM:
> VMX: support MSR_IA32_ARCH_CAPABILITIES as a feature MSR").
> 
Thanks Paolo.
> Paolo
