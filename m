Received: from eggs.gnu.org ([2001:4830:134:3::10]:47560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fqw0b-0003eX-EY
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 03:50:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fqw0Y-0002tl-A6
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 03:50:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60464)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fqw0Y-0002tL-2J
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 03:50:50 -0400
Date: Sat, 18 Aug 2018 03:50:47 -0400 (EDT)
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1182649564.1992584.1534578647115.JavaMail.zimbra@redhat.com>
In-Reply-To: <1534571323.4104.5.camel@linux.intel.com>
References: <1533909989-56115-1-git-send-email-robert.hu@linux.intel.com>
	<1533909989-56115-2-git-send-email-robert.hu@linux.intel.com>
	<20180817031019.GZ15372@localhost.localdomain>
	<1534561816.4104.3.camel@linux.intel.com>
	<1534571323.4104.5.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/3] x86: Data structure changes to
 support MSR based features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Robert Hoo <robert.hu@linux.intel.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, robert hu <robert.hu@intel.com>, rth@twiddle.net, thomas lendacky <thomas.lendacky@amd.com>, qemu-devel@nongnu.org, jingqi liu <jingqi.liu@intel.com>



----- Original Message -----
> From: "Robert Hoo" <robert.hu@linux.intel.com>
> To: "Eduardo Habkost" <ehabkost@redhat.com>
> Cc: "robert hu" <robert.hu@intel.com>, "robert hu" <robert.hu@linux.intel.com>, pbonzini@redhat.com, rth@twiddle.net,
> "thomas lendacky" <thomas.lendacky@amd.com>, qemu-devel@nongnu.org, "jingqi liu" <jingqi.liu@intel.com>
> Sent: Saturday, August 18, 2018 7:48:43 AM
> Subject: Re: [Qemu-devel] [PATCH v3 1/3] x86: Data structure changes to support MSR based features
> 
> On Sat, 2018-08-18 at 11:10 +0800, Robert Hoo wrote:
> > On Fri, 2018-08-17 at 00:10 -0300, Eduardo Habkost wrote:
> > [trim...]
> > > > +
> > > >  typedef struct FeatureWordInfo {
> > > > -    /* feature flags names are taken from "Intel Processor
> > > > Identification and
> > > > +    FeatureWordType type;
> > > > +   /* feature flags names are taken from "Intel Processor
> > > > Identification and
> > > >       * the CPUID Instruction" and AMD's "CPUID Specification".
> > > >       * In cases of disagreement between feature naming conventions,
> > > >       * aliases may be added.
> > > >       */
> > > >      const char *feat_names[32];
> > > > -    uint32_t cpuid_eax;   /* Input EAX for CPUID */
> > > > -    bool cpuid_needs_ecx; /* CPUID instruction uses ECX as input */
> > > > -    uint32_t cpuid_ecx;   /* Input ECX value for CPUID */
> > > > -    int cpuid_reg;        /* output register (R_* constant) */
> > > > +    union {
> > > > +        /* If type==CPUID_FEATURE_WORD */
> > > > +        struct {
> > > > +            uint32_t eax;   /* Input EAX for CPUID */
> > > > +            bool needs_ecx; /* CPUID instruction uses ECX as input */
> > > > +            uint32_t ecx;   /* Input ECX value for CPUID */
> > > > +            int reg;        /* output register (R_* constant) */
> > > > +        } cpuid;
> > > > +        /* If type==MSR_FEATURE_WORD */
> > > > +        struct {
> > > > +            uint32_t index;
> > > > +            struct {   /*CPUID that enumerate this MSR*/
> > > > +                FeatureWord cpuid_class;
> > > > +                uint32_t    cpuid_flag;
> > > > +            } cpuid_dep;
> > > > +        } msr;
> > > > +    };
> > > >      uint32_t tcg_features; /* Feature flags supported by TCG */
> > > >      uint32_t unmigratable_flags; /* Feature flags known to be
> > > >      unmigratable */
> > > >      uint32_t migratable_flags; /* Feature flags known to be migratable
> > > >      */
> > > 
> > > The data structure change looks good, but you are breaking the
> > > build if you touch them without updating the existing code.  If
> > > you break the build in your series, you break git-bisect.
> > > 
> > I had tested in my environment before send out, build has no even a
> > warning. Is it because this patch is based on master + previous icelake
> > cpu model set? I see you are pulling in previous icelake cpu model patch
> > set. I will rebase this patch to then master. Will previous icelake cpu
> > model patch set appear in master soon?
> 
> or you mean each single patch in a series should be individually built
> pass? then it will a huge one here: data structure changes + reference
> functions.

Yes, each patch should individually build and pass.  That's why you should
first introduce the changes to CPUID feature words (data structure and
functions) and then add support for MSR features.

Paolo
