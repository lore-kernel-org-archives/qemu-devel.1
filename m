Received: from eggs.gnu.org ([2001:4830:134:3::10]:42291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fMBgh-00073b-2X
	for qemu-devel@nongnu.org; Fri, 25 May 2018 08:19:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fMBgc-0007J1-H6
	for qemu-devel@nongnu.org; Fri, 25 May 2018 08:19:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44492 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fMBgc-0007Il-CT
	for qemu-devel@nongnu.org; Fri, 25 May 2018 08:19:10 -0400
Date: Fri, 25 May 2018 15:19:07 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180525151815-mutt-send-email-mst@kernel.org>
References: <1527086545-68024-1-git-send-email-mst@redhat.com>
	<1527086545-68024-8-git-send-email-mst@redhat.com>
	<CAFEAcA9JwWR29YSBKGS1fmmOE=wrSQY+OeJxQc4kmAEHRXUzWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9JwWR29YSBKGS1fmmOE=wrSQY+OeJxQc4kmAEHRXUzWQ@mail.gmail.com>
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

On Fri, May 25, 2018 at 12:06:17PM +0100, Peter Maydell wrote:
> On 23 May 2018 at 15:43, Michael S. Tsirkin <mst@redhat.com> wrote:
> > Switch to the header we imported from Linux,
> > this allows us to drop a hack in kvm_i386.h.
> > More code will be dropped in the next patch.
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> > --- a/target/i386/cpu.h
> > +++ b/target/i386/cpu.h
> > @@ -688,8 +688,6 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
> >  #define CPUID_7_0_EDX_SPEC_CTRL     (1U << 26) /* Speculation Control */
> >  #define CPUID_7_0_EDX_SPEC_CTRL_SSBD  (1U << 31) /* Speculative Store Bypass Disable */
> >
> > -#define KVM_HINTS_DEDICATED (1U << 0)
> > -
> >  #define CPUID_8000_0008_EBX_IBPB    (1U << 12) /* Indirect Branch Prediction Barrier */
> >
> >  #define CPUID_XSAVE_XSAVEOPT   (1U << 0)
> 
> Hi -- this seems like it will break compilation when we next
> update our copy of the Linux kernel headers,

That just means we'll need to update kvm.c when we do it.

> because (as of
> 4.17-rc6, at least), asm-x86/kvm_para.h doesn't define
> KVM_HINTS_DEDICATED. Here's the diff I get as part of
> my attempt to run update-linux-headers:
> 
> --- a/include/standard-headers/asm-x86/kvm_para.h
> +++ b/include/standard-headers/asm-x86/kvm_para.h
> @@ -29,7 +29,7 @@
>  #define KVM_FEATURE_PV_TLB_FLUSH       9
>  #define KVM_FEATURE_ASYNC_PF_VMEXIT    10
> 
> -#define KVM_HINTS_DEDICATED      0
> +#define KVM_HINTS_REALTIME      0
> 
>  /* The last 8 bits are used to indicate how to interpret the flags field
>   * in pvclock structure. If no bits are set, all flags are ignored.
> 
> I'm not sure what's going on here -- commit 633711e8287 in
> the kernel just renames the constant, but doesn't that
> break userspace API ?
> 
> thanks
> -- PMM
