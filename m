Received: from eggs.gnu.org ([2001:4830:134:3::10]:58271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fxYVr-0007LP-Uy
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 10:10:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fxYVm-00076w-VT
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 10:10:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44636)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fxYVm-00076D-M6
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 10:10:26 -0400
Date: Wed, 5 Sep 2018 11:10:22 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180905141022.GM12698@habkost.net>
References: <1533909989-56115-1-git-send-email-robert.hu@linux.intel.com>
	<1533909989-56115-4-git-send-email-robert.hu@linux.intel.com>
	<9e06fe89-2688-1e6e-16ec-d5e8cdc87ce4@redhat.com>
	<1536126475.15675.1.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536126475.15675.1.camel@linux.intel.com>
Subject: Re: [Qemu-devel] [PATCH v3 3/3] Change other funcitons referring to
 feature_word_info[]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Robert Hoo <robert.hu@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, robert.hu@intel.com, rth@twiddle.net, thomas.lendacky@amd.com, qemu-devel@nongnu.org, jingqi.liu@intel.com, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Jiri Denemark <jdenemar@redhat.com>

Question to the QAPI schema maintainers below:

On Wed, Sep 05, 2018 at 01:47:55PM +0800, Robert Hoo wrote:
> On Fri, 2018-08-17 at 17:52 +0200, Paolo Bonzini wrote:
> > On 10/08/2018 16:06, Robert Hoo wrote:
> > > x86_cpu_get_feature_words(): limit to CPUID_FEATURE_WORD only.
> > 
> > This should also grow support for MSR feature words.
> > 
> > My suggestion is that you add another patch after patch 1 that expands
> > the definition of X86CPUFeatureWordInfo like this, and adjusts
> > x86_cpu_get_feature_words() to match the new C structs.  Then this
> > patch can add MSR feature support somewhat easily.
> > 
> > The QAPI definitions would then look like this:
> > 
> > diff --git a/qapi/misc.json b/qapi/misc.json
> > index d450cfef21..eae9243976 100644
> > --- a/qapi/misc.json
> > +++ b/qapi/misc.json
> > @@ -2663,9 +2663,9 @@
> >    'data': [ 'EAX', 'EBX', 'ECX', 'EDX', 'ESP', 'EBP', 'ESI', 'EDI' ] }
> >  
> >  ##
> > -# @X86CPUFeatureWordInfo:
> > +# @X86CPUIDFeatureWordInfo:
> >  #
> > -# Information about a X86 CPU feature word
> > +# Information about an X86 CPUID feature word
> >  #
> >  # @cpuid-input-eax: Input EAX value for CPUID instruction for that feature word
> >  #
> > @@ -2678,12 +2690,45 @@
> >  #
> >  # Since: 1.5
> >  ##
> > -{ 'struct': 'X86CPUFeatureWordInfo',
> > +{ 'struct': 'X86CPUIDFeatureWordInfo',
> >    'data': { 'cpuid-input-eax': 'int',
> >              '*cpuid-input-ecx': 'int',
> >              'cpuid-register': 'X86CPURegister32',
> >              'features': 'int' } }
> >  
> > +##
> > +# @X86MSRFeatureWordInfo:
> > +#
> > +# Information about an X86 MSR feature word
> > +#
> > +# @index: Index of the model specific register
> > +#
> > +# @cpuid-feature: CPUID feature name that communicates the existance of the MSR
> > +#
> > +# @features: value of output register, containing the feature bits
> > +#
> > +# Since: 3.1
> > +##
> > +{ 'struct': 'X86MSRFeatureWordInfo',
> > +  'data': { 'index': 'int',
> > +            'cpuid-feature': 'str',
> > +            'features': 'int' } }
> > +
> > +##
> > +# @X86CPUFeatureWordInfo:
> > +#
> > +# A discriminated record of X86 CPU feature words
> > +#
> > +# Since: 3.1
> > +##
> > +
> > +{ 'union': 'X86CPUFeatureWordInfo',
> > +  'base': { 'type': 'X86CPUFeatureWordType' },
> > +  'discriminator': 'type',
> > +  'data': {
> > +    'cpuid': 'X86CPUIDFeatureWordInfo',
> > +    'msr': 'X86MSRFeatureWordInfo' }}
> > +
> >  ##
> >  # @DummyForceArrays:
> >  #
> 
> [root@robert-ivt qemu]# git diff qapi/misc.json
> diff --git a/qapi/misc.json b/qapi/misc.json
> index d450cfe..7351dc2 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -2663,25 +2663,25 @@
>    'data': [ 'EAX', 'EBX', 'ECX', 'EDX', 'ESP', 'EBP', 'ESI', 'EDI' ] }
>  
>  ##
> -# @X86CPUFeatureWordInfo:
> +# @X86CPUIDFeatureWordInfo:
>  #
> -# Information about a X86 CPU feature word
> +# Information about a X86 CPUID feature word
>  #
> -# @cpuid-input-eax: Input EAX value for CPUID instruction for that
> feature word
> +# @input-eax: Input EAX value for CPUID instruction for that feature
> word
>  #
> -# @cpuid-input-ecx: Input ECX value for CPUID instruction for that
> +# @input-ecx: Input ECX value for CPUID instruction for that
>  #                   feature word
>  #
> -# @cpuid-register: Output register containing the feature bits
> +# @register: Output register containing the feature bits
>  #
>  # @features: value of output register, containing the feature bits
>  #
>  # Since: 1.5
>  ##
> -{ 'struct': 'X86CPUFeatureWordInfo',
> -  'data': { 'cpuid-input-eax': 'int',
> -            '*cpuid-input-ecx': 'int',
> -            'cpuid-register': 'X86CPURegister32',
> +{ 'struct': 'X86CPUIDFeatureWordInfo',
> +  'data': { 'input-eax': 'int',
> +            '*input-ecx': 'int',
> +            'register': 'X86CPURegister32',
>              'features': 'int' } }
>  
>  ##
> @@ -2694,6 +2694,50 @@
>  { 'struct': 'DummyForceArrays',
>    'data': { 'unused': ['X86CPUFeatureWordInfo'] } }
>  
> +##
> +# @X86MSRFeatureWordInfo:
> +#
> +# Information about an X86 MSR feature word
> +#
> +# @index: Index of the model specific register
> +#
> +# @cpuid-feature: CPUID feature name that communicates the existance of
> the MSR
> +#
> +# @features: value of output register, containing the feature bits
> +#
> +# Since: 3.1
> +##
> +{ 'struct': 'X86MSRFeatureWordInfo',
> +  'data': { 'index': 'int',
> +            'cpuid-feature': 'str',
> +            'features': 'int' } }
> +
> +##
> +# @X86CPUFeatureWordType:
> +#
> +# Kinds of X86 CPU feature words
> +#
> +# @cpuid: A CPUID leaf
> +#
> +# @msr: An MSR
> +##
> +{ 'enum': 'X86CPUFeatureWordType',
> +  'data': [ 'cpuid', 'msr' ] }
> +
> +##
> +# @X86CPUFeatureWordInfo:
> +#
> +# A discriminated record of X86 CPU feature words
> +#
> +# Since: 3.1
> +##
> +{ 'union': 'X86CPUFeatureWordInfo',
> +  'base': { 'type': 'X86CPUFeatureWordType' },
> +  'discriminator': 'type',
> +  'data': {
> +    'cpuid': 'X86CPUIDFeatureWordInfo',
> +    'msr': 'X86MSRFeatureWordInfo' }}


Question to the QAPI maintainers: is this really allowed?  With
this change, data that conforms to the new schema may not conform
to the old schema, because now the "input-eax" field will become
optional.

AFAICS, this will break the existing libvirt code: it will make
qemuMonitorJSONParseCPUx86Features() error out because it won't
find the "input-eax" field on all X86CPUFeatureWordInfo elements.


> +
>  
>  ##
>  # @NumaOptionsType:
> 
> Hi Paolo,
> 
> above is my draft change on the qapi json file. 1 question: 
> struct X86MSRFeatureWordInfo {
>     int64_t index;
>     char *cpuid_feature;
>     int64_t features;
> };
> how to have a "const" prefix the "char *"?

QAPI will make qapi_free_X86MSRFeatureWordInfo(i) call
g_free(i->cpuid_feature), which means you aren't supposed to use
a const char pointer here.  You can use g_strdup() if necessary.


> > 
> > I'm not sure if the cpuid-feature field is useful for libvirt and
> > other management applications.  Eduardo, what do you think?

It looks like a very limited way to represent dependencies
between CPU features because it applies only to MSRs.  I would
prefer to represent feature dependencies in a more generic way
later, and only if really necessary.


> > 
> > Thanks,
> > 
> > Paolo
> 
> 

-- 
Eduardo
