Received: from eggs.gnu.org ([2001:4830:134:3::10]:42025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fMBfb-0006YX-Bd
	for qemu-devel@nongnu.org; Fri, 25 May 2018 08:18:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fMBfX-0006pj-Gg
	for qemu-devel@nongnu.org; Fri, 25 May 2018 08:18:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38890 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fMBfX-0006pP-BZ
	for qemu-devel@nongnu.org; Fri, 25 May 2018 08:18:03 -0400
Date: Fri, 25 May 2018 15:18:02 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180525151719-mutt-send-email-mst@kernel.org>
References: <1527086545-68024-1-git-send-email-mst@redhat.com>
	<1527086545-68024-8-git-send-email-mst@redhat.com>
	<CAFEAcA9JwWR29YSBKGS1fmmOE=wrSQY+OeJxQc4kmAEHRXUzWQ@mail.gmail.com>
	<CAFEAcA9mAMCznsf1hao2PFziXnATrCxa8Of33NckUGXxFU6yEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9mAMCznsf1hao2PFziXnATrCxa8Of33NckUGXxFU6yEQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 07/28] x86/cpu: use
 standard-headers/asm-x86.kvm_para.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Marcelo Tosatti <mtosatti@redhat.com>, kvm-devel <kvm@vger.kernel.org>

On Fri, May 25, 2018 at 12:53:44PM +0100, Peter Maydell wrote:
> On 25 May 2018 at 12:06, Peter Maydell <peter.maydell@linaro.org> wrote:
> > On 23 May 2018 at 15:43, Michael S. Tsirkin <mst@redhat.com> wrote:
> >> Switch to the header we imported from Linux,
> >> this allows us to drop a hack in kvm_i386.h.
> >> More code will be dropped in the next patch.
> >>
> >> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >
> >> --- a/target/i386/cpu.h
> >> +++ b/target/i386/cpu.h
> >> @@ -688,8 +688,6 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
> >>  #define CPUID_7_0_EDX_SPEC_CTRL     (1U << 26) /* Speculation Control */
> >>  #define CPUID_7_0_EDX_SPEC_CTRL_SSBD  (1U << 31) /* Speculative Store Bypass Disable */
> >>
> >> -#define KVM_HINTS_DEDICATED (1U << 0)
> >> -
> >>  #define CPUID_8000_0008_EBX_IBPB    (1U << 12) /* Indirect Branch Prediction Barrier */
> >>
> >>  #define CPUID_XSAVE_XSAVEOPT   (1U << 0)
> >
> > Hi -- this seems like it will break compilation when we next
> > update our copy of the Linux kernel headers, because (as of
> > 4.17-rc6, at least), asm-x86/kvm_para.h doesn't define
> > KVM_HINTS_DEDICATED.
> 
> For the moment I'm using this workaround (I wanted to do a header
> update for something else I'm working on):
> 
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -48,6 +48,11 @@
>  #include "exec/memattrs.h"
>  #include "trace.h"
> 
> +/* Work around this kernel header constant changing its name */
> +#ifndef KVM_HINTS_REALTIME
> +#define KVM_HINTS_REALTIME KVM_HINTS_DEDICATED
> +#endif
> +
>  //#define DEBUG_KVM
> 
>  #ifdef DEBUG_KVM

I don't think we need this chunk.

> @@ -387,7 +392,7 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s,
> uint32_t function,
>              ret &= ~(1U << KVM_FEATURE_PV_UNHALT);
>          }
>      } else if (function == KVM_CPUID_FEATURES && reg == R_EDX) {
> -        ret |= 1U << KVM_HINTS_DEDICATED;
> +        ret |= 1U << KVM_HINTS_REALTIME;
>          found = 1;
>      }

That's the right change when we update this header.

> thanks
> -- PMM
