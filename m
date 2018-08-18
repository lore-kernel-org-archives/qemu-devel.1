Received: from eggs.gnu.org ([2001:4830:134:3::10]:58236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <robert.hu@linux.intel.com>) id 1fqu6V-0002dj-H6
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 01:48:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <robert.hu@linux.intel.com>) id 1fqu6R-0004rL-IK
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 01:48:51 -0400
Received: from mga12.intel.com ([192.55.52.136]:49211)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <robert.hu@linux.intel.com>)
	id 1fqu6R-0004qZ-8t
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 01:48:47 -0400
Message-ID: <1534571323.4104.5.camel@linux.intel.com>
From: Robert Hoo <robert.hu@linux.intel.com>
Date: Sat, 18 Aug 2018 13:48:43 +0800
In-Reply-To: <1534561816.4104.3.camel@linux.intel.com>
References: <1533909989-56115-1-git-send-email-robert.hu@linux.intel.com>
	<1533909989-56115-2-git-send-email-robert.hu@linux.intel.com>
	<20180817031019.GZ15372@localhost.localdomain>
	<1534561816.4104.3.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: robert.hu@intel.com, robert.hu@linux.intel.com, pbonzini@redhat.com, rth@twiddle.net, thomas.lendacky@amd.com, qemu-devel@nongnu.org, jingqi.liu@intel.com

On Sat, 2018-08-18 at 11:10 +0800, Robert Hoo wrote:
> On Fri, 2018-08-17 at 00:10 -0300, Eduardo Habkost wrote:
> [trim...]
> > > +
> > >  typedef struct FeatureWordInfo {
> > > -    /* feature flags names are taken from "Intel Processor Identification and
> > > +    FeatureWordType type;
> > > +   /* feature flags names are taken from "Intel Processor Identification and
> > >       * the CPUID Instruction" and AMD's "CPUID Specification".
> > >       * In cases of disagreement between feature naming conventions,
> > >       * aliases may be added.
> > >       */
> > >      const char *feat_names[32];
> > > -    uint32_t cpuid_eax;   /* Input EAX for CPUID */
> > > -    bool cpuid_needs_ecx; /* CPUID instruction uses ECX as input */
> > > -    uint32_t cpuid_ecx;   /* Input ECX value for CPUID */
> > > -    int cpuid_reg;        /* output register (R_* constant) */
> > > +    union {
> > > +        /* If type==CPUID_FEATURE_WORD */
> > > +        struct {
> > > +            uint32_t eax;   /* Input EAX for CPUID */
> > > +            bool needs_ecx; /* CPUID instruction uses ECX as input */
> > > +            uint32_t ecx;   /* Input ECX value for CPUID */
> > > +            int reg;        /* output register (R_* constant) */
> > > +        } cpuid;
> > > +        /* If type==MSR_FEATURE_WORD */
> > > +        struct {
> > > +            uint32_t index;
> > > +            struct {   /*CPUID that enumerate this MSR*/
> > > +                FeatureWord cpuid_class;
> > > +                uint32_t    cpuid_flag;
> > > +            } cpuid_dep;
> > > +        } msr;
> > > +    };
> > >      uint32_t tcg_features; /* Feature flags supported by TCG */
> > >      uint32_t unmigratable_flags; /* Feature flags known to be unmigratable */
> > >      uint32_t migratable_flags; /* Feature flags known to be migratable */
> > 
> > The data structure change looks good, but you are breaking the
> > build if you touch them without updating the existing code.  If
> > you break the build in your series, you break git-bisect.
> > 
> I had tested in my environment before send out, build has no even a
> warning. Is it because this patch is based on master + previous icelake
> cpu model set? I see you are pulling in previous icelake cpu model patch
> set. I will rebase this patch to then master. Will previous icelake cpu
> model patch set appear in master soon?

or you mean each single patch in a series should be individually built
pass? then it will a huge one here: data structure changes + reference
functions.
> > 
> > [...]
> > > +    /*Below are MSR exposed features*/
> > > +    [FEATURE_WORDS_ARCH_CAPABILITIES] = {
> > > +        .type = MSR_FEATURE_WORD,
> > > +        .feat_names = {
> > > +            "rdctl-no", "ibrs-all", "rsba", NULL,
> > > +            "ssb-no", NULL, NULL, NULL,
> > > +            NULL, NULL, NULL, NULL,
> > > +            NULL, NULL, NULL, NULL,
> > > +            NULL, NULL, NULL, NULL,
> > > +            NULL, NULL, NULL, NULL,
> > > +            NULL, NULL, NULL, NULL,
> > > +            NULL, NULL, NULL, NULL,
> > > +        },
> > > +        .msr = { .index = MSR_IA32_ARCH_CAPABILITIES,
> > > +                .cpuid_dep = { FEAT_7_0_EDX,
> > > +                    CPUID_7_0_EDX_ARCH_CAPABILITIES }
> > > +                },
> > > +    },
> > 
> > I suggest moving this hunk to a separate patch: first we refactor
> > the existing code without changing behavior or adding new
> > features, then we add the new features.
> > 
> Sure.
> 
> > >  };
> > >  
> > >  typedef struct X86RegisterInfo32 {
> > > diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> > > index cddf9d9..9e8879e 100644
> > > --- a/target/i386/cpu.h
> > > +++ b/target/i386/cpu.h
> > > @@ -502,9 +502,14 @@ typedef enum FeatureWord {
> > >      FEAT_6_EAX,         /* CPUID[6].EAX */
> > >      FEAT_XSAVE_COMP_LO, /* CPUID[EAX=0xd,ECX=0].EAX */
> > >      FEAT_XSAVE_COMP_HI, /* CPUID[EAX=0xd,ECX=0].EDX */
> > > +    FEATURE_WORDS_NUM_CPUID,
> > > +    FEATURE_WORDS_FIRST_MSR = FEATURE_WORDS_NUM_CPUID,
> > > +    FEATURE_WORDS_ARCH_CAPABILITIES = FEATURE_WORDS_FIRST_MSR,
> > >      FEATURE_WORDS,
> > >  } FeatureWord;
> > >  
> > > +#define FEATURE_WORDS_NUM_MSRS (FEATURE_WORDS - FEATURE_WORDS_FIRST_MSR)
> > > +
> > >  typedef uint32_t FeatureWordArray[FEATURE_WORDS];
> > >  
> > >  /* cpuid_features bits */
> > > -- 
> > > 1.8.3.1
> > > 
> > > 
> > 
> 
> 
