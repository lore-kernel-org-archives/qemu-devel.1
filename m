Received: from eggs.gnu.org ([2001:4830:134:3::10]:44362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fYbgl-0007gO-0Q
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 14:30:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fYbgh-0000SF-PT
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 14:30:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53504)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fYbgh-0000QY-Io
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 14:30:35 -0400
Date: Thu, 28 Jun 2018 15:30:33 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180628183033.GF914@localhost.localdomain>
References: <1529897961-134132-1-git-send-email-robert.hu@linux.intel.com>
	<1529897961-134132-3-git-send-email-robert.hu@linux.intel.com>
	<58ec011e-0f19-f882-abca-dd73bda95fe5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58ec011e-0f19-f882-abca-dd73bda95fe5@redhat.com>
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
Cc: Robert Hoo <robert.hu@linux.intel.com>, qemu-devel@nongnu.org, rth@twiddle.net, robert.hu@intel.com

On Mon, Jun 25, 2018 at 02:06:15PM +0200, Paolo Bonzini wrote:
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

Will all Icelake VCPUs of a given model have the same value on
MSR_IA32_ARCH_CAPABILITIES?

If not, we can't choose a value that will work on all cases, and
it will require management software to be smarter and explicitly
configure some of the MSR bits on the command-line.

-- 
Eduardo
