Received: from eggs.gnu.org ([2001:4830:134:3::10]:36876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <robert.hu@linux.intel.com>) id 1fr0k0-0005Js-QI
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 08:54:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <robert.hu@linux.intel.com>) id 1fr0jx-00005Q-Ji
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 08:54:04 -0400
Received: from mga03.intel.com ([134.134.136.65]:48465)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <robert.hu@linux.intel.com>)
	id 1fr0jx-0008Vz-AI
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 08:54:01 -0400
Message-ID: <1534596838.4104.27.camel@linux.intel.com>
From: Robert Hoo <robert.hu@linux.intel.com>
Date: Sat, 18 Aug 2018 20:53:58 +0800
In-Reply-To: <9e06fe89-2688-1e6e-16ec-d5e8cdc87ce4@redhat.com>
References: <1533909989-56115-1-git-send-email-robert.hu@linux.intel.com>
	<1533909989-56115-4-git-send-email-robert.hu@linux.intel.com>
	<9e06fe89-2688-1e6e-16ec-d5e8cdc87ce4@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: robert.hu@intel.com, robert.hu@linux.intel.com, rth@twiddle.net, ehabkost@redhat.com, thomas.lendacky@amd.com, qemu-devel@nongnu.org, jingqi.liu@intel.com

On Fri, 2018-08-17 at 17:52 +0200, Paolo Bonzini wrote:
> On 10/08/2018 16:06, Robert Hoo wrote:
> > x86_cpu_get_feature_words(): limit to CPUID_FEATURE_WORD only.
> 
> This should also grow support for MSR feature words.
> 
> My suggestion is that you add another patch after patch 1 that expands
> the definition of X86CPUFeatureWordInfo like this, and adjusts
> x86_cpu_get_feature_words() to match the new C structs.  Then this
> patch can add MSR feature support somewhat easily.
> 
> The QAPI definitions would then look like this:

I'm not familiar with json language. Can someone else compose this part?
> 
> diff --git a/qapi/misc.json b/qapi/misc.json
> index d450cfef21..eae9243976 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -2663,9 +2663,9 @@
>    'data': [ 'EAX', 'EBX', 'ECX', 'EDX', 'ESP', 'EBP', 'ESI', 'EDI' ] }
>  
>  ##
> -# @X86CPUFeatureWordInfo:
> +# @X86CPUIDFeatureWordInfo:
>  #
> -# Information about a X86 CPU feature word
> +# Information about an X86 CPUID feature word
>  #
>  # @cpuid-input-eax: Input EAX value for CPUID instruction for that feature word
>  #
> @@ -2678,12 +2690,45 @@
>  #
>  # Since: 1.5
>  ##
> -{ 'struct': 'X86CPUFeatureWordInfo',
> +{ 'struct': 'X86CPUIDFeatureWordInfo',
>    'data': { 'cpuid-input-eax': 'int',
>              '*cpuid-input-ecx': 'int',
>              'cpuid-register': 'X86CPURegister32',
>              'features': 'int' } }
>  
> +##
> +# @X86MSRFeatureWordInfo:
> +#
> +# Information about an X86 MSR feature word
> +#
> +# @index: Index of the model specific register
> +#
> +# @cpuid-feature: CPUID feature name that communicates the existance of the MSR
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
> +# @X86CPUFeatureWordInfo:
> +#
> +# A discriminated record of X86 CPU feature words
> +#
> +# Since: 3.1
> +##
> +
> +{ 'union': 'X86CPUFeatureWordInfo',
> +  'base': { 'type': 'X86CPUFeatureWordType' },
> +  'discriminator': 'type',
> +  'data': {
> +    'cpuid': 'X86CPUIDFeatureWordInfo',
> +    'msr': 'X86MSRFeatureWordInfo' }}
> +
>  ##
>  # @DummyForceArrays:
>  #
> 
> I'm not sure if the cpuid-feature field is useful for libvirt and
> other management applications.  Eduardo, what do you think?
> 
> Thanks,
> 
> Paolo
