Received: from eggs.gnu.org ([2001:4830:134:3::10]:42495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ejqr5-0007Ae-15
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 13:23:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ejqr0-00005q-Va
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 13:23:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36954)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ejqr0-00005Q-NB
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 13:23:26 -0500
Date: Thu, 8 Feb 2018 16:23:23 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180208182323.GC13981@localhost.localdomain>
References: <1517414266-12077-1-git-send-email-luwei.kang@intel.com>
	<20180207145358.GI13301@localhost.localdomain>
	<82D7661F83C1A047AF7DC287873BF1E167EC22C8@SHSMSX101.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82D7661F83C1A047AF7DC287873BF1E167EC22C8@SHSMSX101.ccr.corp.intel.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/2] i386: Add Intel Processor Trace
 feature support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Kang, Luwei" <luwei.kang@intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mtosatti@redhat.com" <mtosatti@redhat.com>, Chao Peng <chao.p.peng@linux.intel.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>

On Thu, Feb 08, 2018 at 01:24:46AM +0000, Kang, Luwei wrote:
> > On Wed, Jan 31, 2018 at 11:57:45PM +0800, Luwei Kang wrote:
> > > From: Chao Peng <chao.p.peng@linux.intel.com>
> > >
> > > Expose Intel Processor Trace feature to guest.
> > >
> > > To make Intel PT live migration safe and get same CPUID information
> > > with same CPU model on diffrent host. CPUID[14] is constant in this
> > > patch. Intel PT use EPT is first supported in IceLake, the CPUID[14]
> > > get on this machine as default value. Intel PT would be disabled If
> > > any machine don't support this minial feature list.
> > >
> > > Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> > > Signed-off-by: Luwei Kang <luwei.kang@intel.com>
> > > ---
> > >  target/i386/cpu.c | 53
> > > +++++++++++++++++++++++++++++++++++++++++++++++++++--
> > >  target/i386/cpu.h |  1 +
> > >  target/i386/kvm.c | 23 +++++++++++++++++++++++
> > >  3 files changed, 75 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/target/i386/cpu.c b/target/i386/cpu.c index
> > > a49d222..aaa427a 100644
> > > --- a/target/i386/cpu.c
> > > +++ b/target/i386/cpu.c
> > > @@ -172,7 +172,14 @@
> > >  #define L2_ITLB_4K_ASSOC       4
> > >  #define L2_ITLB_4K_ENTRIES   512
> > >
> > > -
> > > +/* CPUID Leaf 0x14 constants: */
> > > +#define INTLE_PT_MAX_SUBLEAF     0x1
> > 
> > Typo.
> > 
> > > +#define INTEL_PT_MINIMAL_EBX     0xf
> > > +#define INTEL_PT_MINIMAL_ECX     0x7
> > 
> > I suggest documenting what capabilities are included in
> > INTEL_PT_MINIMAL_* here.
> > 
> > 
> > > +#define INTLE_PT_ADDR_RANGES_NUM 0x2 /* Number of configurable
> > > +address ranges */
> > 
> > Typo.
> > 
> > > +#define INTEL_PT_MTC_BITMAP      (0x0249 << 16) /* Support ART(0,3,6,9) */
> > > +#define INTEL_PT_CYCLE_BITMAP    0x1fff         /* Support 0,2^(0~11) */
> > > +#define INTEL_PT_PSB_BITMAP      (0x003f << 16) /* Support 2K,4K,8K,16K,32K,64K */
> > >
> > >  static void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
> > >                                       uint32_t vendor2, uint32_t
> > > vendor3) @@ -427,7 +434,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
> > >              NULL, NULL, "mpx", NULL,
> > >              "avx512f", "avx512dq", "rdseed", "adx",
> > >              "smap", "avx512ifma", "pcommit", "clflushopt",
> > > -            "clwb", NULL, "avx512pf", "avx512er",
> > > +            "clwb", "intel-pt", "avx512pf", "avx512er",
> > >              "avx512cd", "sha-ni", "avx512bw", "avx512vl",
> > >          },
> > >          .cpuid_eax = 7,
> > > @@ -3452,6 +3459,27 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
> > >          }
> > >          break;
> > >      }
> > > +    case 0x14: {
> > > +        /* Intel Processor Trace Enumeration */
> > > +        *eax = 0;
> > > +        *ebx = 0;
> > > +        *ecx = 0;
> > > +        *edx = 0;
> > > +        if (!(env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_INTEL_PT) ||
> > > +            !kvm_enabled()) {
> > > +            break;
> > > +        }
> > > +
> > > +        if (count == 0) {
> > > +            *eax = INTLE_PT_MAX_SUBLEAF;
> > > +            *ebx = INTEL_PT_MINIMAL_EBX;
> > > +            *ecx = INTEL_PT_MINIMAL_ECX;
> > > +        } else if (count == 1) {
> > > +            *eax = INTEL_PT_MTC_BITMAP | INTLE_PT_ADDR_RANGES_NUM;
> > > +            *ebx = INTEL_PT_PSB_BITMAP | INTEL_PT_CYCLE_BITMAP;
> > > +        }
> > > +        break;
> > > +    }
> > >      case 0x40000000:
> > >          /*
> > >           * CPUID code in kvm_arch_init_vcpu() ignores stuff @@
> > > -4082,6 +4110,27 @@ static int x86_cpu_filter_features(X86CPU *cpu)
> > >          }
> > >      }
> > >
> > > +    if (env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_INTEL_PT) {
> > 
> > What if the accelerator is not KVM, but is reporting intel-pt as supported?
> 
> I have add this check in cpu_x86_cpuid() but I think we'd better add kvm_enabled() check here as well.
> What is your opinion?

The function is going to crash if KVM is not enabled and the
accelerator returns intel-pt is supported, as cpu->kvm_state will
be NULL.

> 
> > 
> > > +        KVMState *s = CPU(cpu)->kvm_state;
> > > +        uint32_t eax_0 = kvm_arch_get_supported_cpuid(s, 0x14, 0, R_EAX);
> > > +        uint32_t ebx_0 = kvm_arch_get_supported_cpuid(s, 0x14, 0, R_EBX);
> > > +        uint32_t ecx_0 = kvm_arch_get_supported_cpuid(s, 0x14, 0, R_ECX);
> > > +        uint32_t eax_1 = kvm_arch_get_supported_cpuid(s, 0x14, 1, R_EAX);
> > > +        uint32_t ebx_1 = kvm_arch_get_supported_cpuid(s, 0x14, 1,
> > > + R_EBX);
> > > +
> > > +        if (!eax_0 ||
> > 
> > OK.
> > 
> > > +           ((ebx_0 & INTEL_PT_MINIMAL_EBX) != INTEL_PT_MINIMAL_EBX)
> > > + ||
> > 
> > How do we know if KVM is going to emulate #GP properly when
> > setting a bit that is supported by the host CPU but cleared
> > on the guest CPUID?  Do we care?
> 
> I think it need KVM make this check and Qemu don't need aware
> this.
> For example, EBX[0].CR3_filter (IA32_RTIT_CTL.cr3 can't be set
> if 0) is support by host but we mask off this bit in kvm guest.
> Qemu will set the CPUID to KVM by ioctl KVM_SET_CPUID2. KVM
> will trap the behavior when KVM guest want to set
> IA32_RTIT_CTL.cr3. If we find EBX[0].CR3_filter is not
> supported a #GP will be emulated. This check will added in KVM
> patch set V5 and it still working in progress.

I was assuming there would be released Linux versions where this
wasn't implemented yet.  If nothing was merged yet, we should be
safe.


> 
> > 
> > > +           ((ecx_0 & INTEL_PT_MINIMAL_ECX) != INTEL_PT_MINIMAL_ECX)
> > > + ||
> > 
> > Same comment as above.
> > 
> > Also: bit 31 must match the host, meaning we must reject a
> > host where ecx_0 & (1 << 31) is set.
> 
> Get it, will add in next version.
> 
> > 
> > 
> > > +           ((eax_1 & (INTLE_PT_ADDR_RANGES_NUM | INTEL_PT_MTC_BITMAP)) !=
> > > +                (INTLE_PT_ADDR_RANGES_NUM | INTEL_PT_MTC_BITMAP)) ||
> > 
> > This will make the code accept hosts with 3 address ranges
> > (0b011), but reject ones with 4 address ranges (0b100).  This
> > doesn't sound right to me.
> 
> I see, will fix it.
> 
> > 
> > 
> > > +           ((ebx_1 & (INTEL_PT_PSB_BITMAP | INTEL_PT_CYCLE_BITMAP)) !=
> > > +                (INTEL_PT_PSB_BITMAP | INTEL_PT_CYCLE_BITMAP))) {
> > 
> > How do we know if KVM is going to emulate #GP properly when
> > setting an invalid CycThresh or PSBFreq value?  Do we care?
> 
> It will check in KVM and will emulate a #GP if set an invalid
> value but I think qemu can't aware this.  From my point of
> view, I think qemu don't need to care or get this information.

If all KVM versions that return 0x14 on GET_SUPPORTED_CPUID will
emulate #GP properly, this will be OK.

-- 
Eduardo
