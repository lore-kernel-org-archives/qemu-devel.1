Received: from eggs.gnu.org ([2001:4830:134:3::10]:47082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1egCHK-0002Ii-28
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 11:27:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1egCHG-0005K6-4z
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 11:27:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43670)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1egCHF-0005IW-S1
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 11:27:26 -0500
Date: Mon, 29 Jan 2018 14:27:22 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180129162722.GM25150@localhost.localdomain>
References: <1516904751-10248-1-git-send-email-luwei.kang@intel.com>
	<20180126191410.GJ25150@localhost.localdomain>
	<82D7661F83C1A047AF7DC287873BF1E167E9614F@SHSMSX101.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82D7661F83C1A047AF7DC287873BF1E167E9614F@SHSMSX101.ccr.corp.intel.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/2] i386: Add Intel Processor Trace
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>, "mtosatti@redhat.com" <mtosatti@redhat.com>, Chao Peng <chao.p.peng@linux.intel.com>

On Mon, Jan 29, 2018 at 07:03:13AM +0000, Kang, Luwei wrote:
> > > From: Chao Peng <chao.p.peng@linux.intel.com>
> > >
> > > Expose Intel Processor Trace feature to guest.
> > >
> > > In order to make this feature migration-safe, new feature word
> > > information "FEAT_INTEL_PT_EBX" and "FEAT_INTEL_PT_ECX" be added.
> > > Some constant value initialized in CPUID[0x14].0x01 to guarantee get
> > > same result in diffrent hardware when this feature is enabled.
> > >
> > > Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> > > Signed-off-by: Luwei Kang <luwei.kang@intel.com>
> > > ---
> > > v1->v2:
> > >  - In order to make this feature migration-safe, new feature word
> > >    information "FEAT_INTEL_PT_EBX" and "FEAT_INTEL_PT_ECX" be added.
> > >    Some constant value initialized in CPUID[0x14].0x01 to guarantee
> > >    get same result in diffrent hardware when this feature is enabled.
> > >
[...]
> > > @@ -3452,6 +3488,34 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
> > >          }
> > >          break;
> > >      }
> > > +    case 0x14: {
> > > +	/* Intel Processor Trace Enumeration */
> > > +        *eax = 0;
> > > +        *ebx = 0;
> > > +        *ecx = 0;
> > > +        *edx = 0;
> > > +        if (!(env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_INTEL_PT) ||
> > > +             !kvm_enabled()) {
> > > +            break;
> > > +        }
> > > +
> > > +        if (count == 0) {
> > > +            *eax = 1;
> > > +            *ebx = env->features[FEAT_INTEL_PT_EBX];
> > > +            *ecx = env->features[FEAT_INTEL_PT_ECX];
> > > +        } else if (count == 1) {
> > > +            *eax = INTLE_PT_ADDR_RANGES_NUM;
> > > +            if (env->features[FEAT_INTEL_PT_EBX] &
> > > +                    CPUID_INTEL_PT_EBX_MTC_COFI) {
> > > +                *eax |= INTEL_PT_MTC_BITMAP;
> > > +            }
> > > +            if (env->features[FEAT_INTEL_PT_EBX] &
> > > +                    CPUID_INTEL_PT_EBX_PSB_CYCLE) {
> > > +                *ebx = INTEL_PT_PSB_BITMAP | INTEL_PT_CYCLE_BITMAP;
> > > +            }
> > 
> > We still need to validate the bitmaps and number of ranges against the host capabilities (reported on GET_SUPPORTED_CPUID),
> > don't we?
> 
> Yes, we need to validate the bitmaps and number of ranges against the host capabilities. For example,  MSR_IA32_RTIT_CTL.MTCFreq only support the value defined in bitmap or will cause #GP fault.
> 
> > 
> > If you are going to set CPUID bits that are not already present on env->features[], you will want x86_cpu_filter_features() to
> > manually validate the constants against x86_cpu_get_supported_feature_word(), to ensure we won't try to enable unsupported
> > bits.
> > 
> > (If doing that, we need to make sure CPUID_7_0_EBX_INTEL_PT will be set on xc->filtered_features[FEAT_7_0_EBX] if something is
> > unsupported, to tell the calling code that intel-pt can't be enabled on the current host)
> > 
> 
> So, Can I make all the value in CPUID[14] as constant and make the CPUID information get from IceLake hardware as default(minimal) value.
> CPUID[14] available only when Intel PT is supported and enabled.
> We also need to check the host value by kvm_arch_get_supported_cpuid().  If something is unsupported in minimal value Intel PT can't be enabled.

Exactly.

> I didn't use x86_cpu_get_supported_feature_word() because the value of CPUID[14] will all be constant hence sub-leaf FEAT_INTEL_PT_EBX/ FEAT_INTEL_PT_ECX are unnecessary(will remove in next version).

Yes, if you make CPUID[14h] constant in the first version, you
won't need FEAT_INTEL_PT_* yet.

However, if you introduce FeatureWord values for
  CPUID[EAX=14h,ECX=0].EBX, CPUID[EAX=14h,ECX=0].ECX,
  CPUID[EAX=14h,ECX=1].EAX, and CPUID[EAX=14h,ECX=1].EBX,
you will be able to write more generic code using
x86_cpu_get_supported_feature_word(), and make it easier to make
the PT features configurable by CPU models in the future.

But I would be OK with an initial version that simply uses
constants, and not introducing new FeatureWord values.



> Please help correct me if anything wrong.
> 
> Thanks,
> Luwei Kang
> 
> > In the future we could extend FeatureWordInfo to make it easier to handle counter/bitmap fields like those, then we won't need
> > special cases inside x86_cpu_filter_features().
> > 
> > 
> 

-- 
Eduardo
