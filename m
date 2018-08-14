Received: from eggs.gnu.org ([2001:4830:134:3::10]:34144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <robert.hu@linux.intel.com>) id 1fpWDN-0004gt-AF
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 06:06:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <robert.hu@linux.intel.com>) id 1fpWDI-0000gk-FJ
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 06:06:13 -0400
Received: from mga11.intel.com ([192.55.52.93]:20745)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <robert.hu@linux.intel.com>)
	id 1fpWDI-0000fg-4v
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 06:06:08 -0400
Message-ID: <1534241161.81055.36.camel@linux.intel.com>
From: Robert Hoo <robert.hu@linux.intel.com>
Date: Tue, 14 Aug 2018 18:06:01 +0800
In-Reply-To: <893de8e8-da77-f6d5-5c0c-534e9999b7f0@redhat.com>
References: <1533909989-56115-1-git-send-email-robert.hu@linux.intel.com>
	<1533909989-56115-4-git-send-email-robert.hu@linux.intel.com>
	<893de8e8-da77-f6d5-5c0c-534e9999b7f0@redhat.com>
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
To: Eric Blake <eblake@redhat.com>, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com
Cc: robert.hu@intel.com, robert.hu@linux.intel.com, thomas.lendacky@amd.com, qemu-devel@nongnu.org, jingqi.liu@intel.com

On Fri, 2018-08-10 at 10:17 -0500, Eric Blake wrote:
> On 08/10/2018 09:06 AM, Robert Hoo wrote:
> 
> In the subject: s/funcitons/functions/
> 
> Also, it may be worth using a topic prefix (most of our commit messages 
> resemble:
> 
> topic: Description of patch
> 
> to make it easier to spot patches by topic).
> 
> > Add an util function feature_word_description(), which help construct the string
> 
> s/an util/a util/
> s/help/helps/
> 
Thanks Eric, will fix these typos in v2.
> > describing the feature word (both CPUID and MSR types).
> > 
> > report_unavailable_features(): add MSR_FEATURE_WORD type support.
> > x86_cpu_get_feature_words(): limit to CPUID_FEATURE_WORD only.
> > x86_cpu_get_supported_feature_word(): add MSR_FEATURE_WORD type support.
> > x86_cpu_adjust_feat_level(): assert the requested feature must be
> > CPUID_FEATURE_WORD type.
> > 
> > Signed-off-by: Robert Hoo <robert.hu@linux.intel.com>
> > ---
> >   target/i386/cpu.c | 77 +++++++++++++++++++++++++++++++++++++++++--------------
> >   1 file changed, 58 insertions(+), 19 deletions(-)
> > 
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index f7c70d9..21ed599 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -3024,21 +3024,51 @@ static const TypeInfo host_x86_cpu_type_info = {
> >   
> >   #endif
> >   
> > +/*
> > +*caller should have input str no less than 64 byte length.
> > +*/
> > +#define FEATURE_WORD_DESCPTION_LEN 64
> 
> s/DESCPTION/DESCRIPTION/
> 
> > +static int feature_word_description(char str[], FeatureWordInfo *f,
> > +                                            uint32_t bit)
> > +{
> 
> Prone to buffer overflow if the caller doesn't pass in the length. 
> Would it be better to just g_strdup_printf() into a malloc'd result 
> instead of trying to snprintf()'ing into a buffer that you hope the 
> caller sized large enough?
> 
Oh, wasn't aware of such good util functions. Sure I'd like to use them.
Is there some web page introducing them?

Eduardo/Paolo, do you have more comments?
> > +    int ret;
> > +
> > +    assert(f->type == CPUID_FEATURE_WORD ||
> > +        f->type == MSR_FEATURE_WORD);
> > +    switch (f->type) {
> > +    case CPUID_FEATURE_WORD:
> > +        {
> > +            const char *reg = get_register_name_32(f->cpuid.reg);
> > +            assert(reg);
> > +            ret = snprintf(str, FEATURE_WORD_DESCPTION_LEN,
> > +                "CPUID.%02XH:%s%s%s [bit %d]",
> > +                f->cpuid.eax, reg,
> > +                f->feat_names[bit] ? "." : "",
> > +                f->feat_names[bit] ? f->feat_names[bit] : "", bit);
> > +            break;
> > +        }
> > +    case MSR_FEATURE_WORD:
> > +        ret = snprintf(str, FEATURE_WORD_DESCPTION_LEN,
> > +            "MSR(%xH).%s [bit %d]",
> > +            f->msr.index,
> > +            f->feat_names[bit] ? f->feat_names[bit] : "", bit);
> > +        break;
> > +    }
> 
