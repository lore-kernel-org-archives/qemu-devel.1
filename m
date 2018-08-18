Received: from eggs.gnu.org ([2001:4830:134:3::10]:60099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <robert.hu@linux.intel.com>) id 1fqx7H-0001JF-VT
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 05:01:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <robert.hu@linux.intel.com>) id 1fqx7E-0006nP-Lf
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 05:01:51 -0400
Received: from mga01.intel.com ([192.55.52.88]:65320)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <robert.hu@linux.intel.com>)
	id 1fqx7E-0006mI-Df
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 05:01:48 -0400
Message-ID: <1534582905.4104.25.camel@linux.intel.com>
From: Robert Hoo <robert.hu@linux.intel.com>
Date: Sat, 18 Aug 2018 17:01:45 +0800
In-Reply-To: <20180817132820.GB15372@localhost.localdomain>
References: <1533909989-56115-1-git-send-email-robert.hu@linux.intel.com>
	<1533909989-56115-4-git-send-email-robert.hu@linux.intel.com>
	<20180817132820.GB15372@localhost.localdomain>
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: robert.hu@intel.com, robert.hu@linux.intel.com, pbonzini@redhat.com, rth@twiddle.net, thomas.lendacky@amd.com, qemu-devel@nongnu.org, jingqi.liu@intel.com

On Fri, 2018-08-17 at 10:28 -0300, Eduardo Habkost wrote:
> On Fri, Aug 10, 2018 at 10:06:29PM +0800, Robert Hoo wrote:
> > Add an util function feature_word_description(), which help construct the string
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
> >  target/i386/cpu.c | 77 +++++++++++++++++++++++++++++++++++++++++--------------
> >  1 file changed, 58 insertions(+), 19 deletions(-)
> > 
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index f7c70d9..21ed599 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -3024,21 +3024,51 @@ static const TypeInfo host_x86_cpu_type_info = {
> >  
> >  #endif
> >  
> > +/*
> > +*caller should have input str no less than 64 byte length.
> > +*/
> > +#define FEATURE_WORD_DESCPTION_LEN 64
> > +static int feature_word_description(char str[], FeatureWordInfo *f,
> > +                                            uint32_t bit)
> 
> I agree with Eric: g_strup_printf() would be much simpler here.
> 
1 question: I think caller should g_free() the returned str after it
warn_report(), right?
> > +{
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
> 
> What about leaving the (f->feat_names[bit] ? ... : ...) part
> in report_unavailable_features() and just make this function
> return "CPUID[...]" or "MSR[...]"?
> 
> 
> > +        break;
> > +    }
> > +    return ret > 0;
> > +}
> > +
> >  static void report_unavailable_features(FeatureWord w, uint32_t mask)
> >  {
> >      FeatureWordInfo *f = &feature_word_info[w];
> >      int i;
> > +    char feat_word_dscrp_str[FEATURE_WORD_DESCPTION_LEN];
> >  
> >      for (i = 0; i < 32; ++i) {
> >          if ((1UL << i) & mask) {
> > -            const char *reg = get_register_name_32(f->cpuid_reg);
> > -            assert(reg);
> > -            warn_report("%s doesn't support requested feature: "
> > -                        "CPUID.%02XH:%s%s%s [bit %d]",
> > +            feature_word_description(feat_word_dscrp_str, f, i);
> > +            warn_report("%s doesn't support requested feature: %s",
> >                          accel_uses_host_cpuid() ? "host" : "TCG",
> > -                        f->cpuid_eax, reg,
> > -                        f->feat_names[i] ? "." : "",
> > -                        f->feat_names[i] ? f->feat_names[i] : "", i);
> > +                        feat_word_dscrp_str);
> >          }
> >      }
> >  }
> > @@ -3276,17 +3306,17 @@ static void x86_cpu_get_feature_words(Object *obj, Visitor *v,
> >  {
> >      uint32_t *array = (uint32_t *)opaque;
> >      FeatureWord w;
> > -    X86CPUFeatureWordInfo word_infos[FEATURE_WORDS] = { };
> > -    X86CPUFeatureWordInfoList list_entries[FEATURE_WORDS] = { };
> > +    X86CPUFeatureWordInfo word_infos[FEATURE_WORDS_NUM_CPUID] = { };
> > +    X86CPUFeatureWordInfoList list_entries[FEATURE_WORDS_NUM_CPUID] = { };
> >      X86CPUFeatureWordInfoList *list = NULL;
> >  
> > -    for (w = 0; w < FEATURE_WORDS; w++) {
> > +    for (w = 0; w < FEATURE_WORDS_NUM_CPUID; w++) {
> >          FeatureWordInfo *wi = &feature_word_info[w];
> >          X86CPUFeatureWordInfo *qwi = &word_infos[w];
> > -        qwi->cpuid_input_eax = wi->cpuid_eax;
> > -        qwi->has_cpuid_input_ecx = wi->cpuid_needs_ecx;
> > -        qwi->cpuid_input_ecx = wi->cpuid_ecx;
> > -        qwi->cpuid_register = x86_reg_info_32[wi->cpuid_reg].qapi_enum;
> > +        qwi->cpuid_input_eax = wi->cpuid.eax;
> > +        qwi->has_cpuid_input_ecx = wi->cpuid.needs_ecx;
> > +        qwi->cpuid_input_ecx = wi->cpuid.ecx;
> > +        qwi->cpuid_register = x86_reg_info_32[wi->cpuid.reg].qapi_enum;
> 
> Looks OK, but I would add an
> assert(wi->type == CPUID_FEATURE_WORD) on every block of code
> that uses the wi->cpuid field.
> 
> I would also get rid of FEATURE_WORDS_NUM_CPUID and
> FEATURE_WORDS_FIRST_MSR to reduce the chance of future mistakes.
> We can use FEATURE_WORDS in this loop and just check wi->type on
> each iteration.
> 
> >          qwi->features = array[w];
> >  
> >          /* List will be in reverse order, but order shouldn't matter */
> > @@ -3659,12 +3689,20 @@ static uint32_t x86_cpu_get_supported_feature_word(FeatureWord w,
> >                                                     bool migratable_only)
> >  {
> >      FeatureWordInfo *wi = &feature_word_info[w];
> > -    uint32_t r;
> > +    uint32_t r = 0;
> >  
> >      if (kvm_enabled()) {
> > -        r = kvm_arch_get_supported_cpuid(kvm_state, wi->cpuid_eax,
> > -                                                    wi->cpuid_ecx,
> > -                                                    wi->cpuid_reg);
> > +        switch (wi->type) {
> > +        case CPUID_FEATURE_WORD:
> > +            r = kvm_arch_get_supported_cpuid(kvm_state, wi->cpuid.eax,
> > +                                                wi->cpuid.ecx,
> > +                                                wi->cpuid.reg);
> > +            break;
> > +        case MSR_FEATURE_WORD:
> > +            r = kvm_arch_get_supported_msr_feature(kvm_state,
> > +                        wi->msr.index);
> > +            break;
> 
> I'm not sure this is correct in the case of
> IA32_ARCH_CAPABILITIES.RSBA: we do want to be able to set RSBA
> even if the host doesn't have it set.
> 
> Probably you need to handle IA32_ARCH_CAPABILITIES.RSBA as a
> special case inside kvm_arch_get_supported_msr_feature().
> 
> (And we do want to warn the user in some way if RSBA is set in
> the host but not in the guest.  But that's a separate problem.)

The first part is easy to do. the latter, "to warn the user in some way
if RSBA is set in the host but not in the guest", in
kvm_arch_get_supported_msr_feature(), how can I know if guest has
enabled IA32_ARCH_CAPABILITIES.RSBA or not? or you mean check in some
other place, where is it?
> 
> > +        }
> >      } else if (hvf_enabled()) {
> >          r = hvf_get_supported_cpuid(wi->cpuid_eax,
> >                                      wi->cpuid_ecx,
> > @@ -4732,9 +4770,10 @@ static void x86_cpu_adjust_feat_level(X86CPU *cpu, FeatureWord w)
> >  {
> >      CPUX86State *env = &cpu->env;
> >      FeatureWordInfo *fi = &feature_word_info[w];
> > -    uint32_t eax = fi->cpuid_eax;
> > +    uint32_t eax = fi->cpuid.eax;
> >      uint32_t region = eax & 0xF0000000;
> >  
> > +    assert(feature_word_info[w].type == CPUID_FEATURE_WORD);
> >      if (!env->features[w]) {
> >          return;
> >      }
> > -- 
> > 1.8.3.1
> > 
> > 
> 
