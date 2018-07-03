Received: from eggs.gnu.org ([2001:4830:134:3::10]:56760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1faJ8Z-0001Xo-ND
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 07:06:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1faJ8W-000387-Gf
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 07:06:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46974)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1faJ8W-00036U-A8
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 07:06:20 -0400
Date: Tue, 3 Jul 2018 08:06:17 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180703110617.GM7451@localhost.localdomain>
References: <1530098844-236851-1-git-send-email-robert.hu@linux.intel.com>
	<1530098844-236851-2-git-send-email-robert.hu@linux.intel.com>
	<20180627170304.GD914@localhost.localdomain>
	<1530177956.22880.32.camel@linux.intel.com>
	<ce3282a7-310c-6c53-05b8-f00afb787279@redhat.com>
	<1530607697.22880.46.camel@linux.intel.com>
	<b7c410af-ebc0-537c-84c4-588842fec111@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7c410af-ebc0-537c-84c4-588842fec111@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/5] i386: Add support for IA32_PRED_CMD
 and IA32_ARCH_CAPABILITIES MSRs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Robert Hoo <robert.hu@linux.intel.com>, qemu-devel@nongnu.org, wei.w.wang@intel.com

On Tue, Jul 03, 2018 at 11:06:00AM +0200, Paolo Bonzini wrote:
> On 03/07/2018 10:48, Robert Hoo wrote:
> >>
> >> However, I suggest adding it to the FeatureWord enum, since everything
> >> that handles FeatureWord applies to this new kind of MSR as well.
> >> Currently FeatureWord is only for CPUID leaves, but it doesn't have to
> >> be like that.
> >>
> > I think this will be changing struct FeatureWordInfo, which is designed
> > for cpuid enumerations. You must not want to do that. May I know more
> > details about your thought?
> 
> The simplest way is to put CPUIDs first and MSRs second in FeatureWord.
> Then you can do
> 
>      FEAT_XSAVE_COMP_LO, /* CPUID[EAX=0xd,ECX=0].EAX */
>      FEAT_XSAVE_COMP_HI, /* CPUID[EAX=0xd,ECX=0].EDX */
> +    FEATURE_WORDS_NUM_CPUID,
> +    FEATURE_WORDS_FIRST_MSR = FEATURE_WORDS_NUM_CPUID,
> +    FEAT_MSR_ARCH_CAPABILITIES = FEATURE_WORDS_FIRST_MSR,
>      FEATURE_WORDS,
> };
> 
> #define FEATURE_WORDS_NUM_MSRS (FEATURE_WORDS - \
>                                 FEATURE_WORDS_FIRST_MSR)
> 
> Then the existing loops that use FeatureWordInfo can go up to
> FEATURE_WORDS_NUM_CPUID.

I assume we want to make some (or most) of the loops go up to
FEATURE_WORDS (e.g. make x86_cpu_get_supported_feature_word()
support MSRs too), otherwise it would be pointless to reuse the
same array.

I would be OK with both approaches, though.  If the first version
doesn't use the `features[]` array and implements this with a
separate `msr_features[]` or `msr_arch_capabilities` field, it
would work for me (especially if this means we can get this
implemented in time for QEMU 3.0).

-- 
Eduardo
