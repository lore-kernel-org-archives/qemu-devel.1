Received: from eggs.gnu.org ([2001:4830:134:3::10]:51980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cnsqq-0002NY-6P
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 16:15:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cnsqm-0003S9-51
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 16:15:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40534)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cnsql-0003Rj-Sl
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 16:15:20 -0400
Date: Tue, 14 Mar 2017 17:15:16 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170314201516.GA3086@thinpad.lan.raisama.net>
References: <20170314140807.6061-1-git@kirschju.re>
	<20170314140807.6061-2-git@kirschju.re>
	<20170314171632.GS4694@thinpad.lan.raisama.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170314171632.GS4694@thinpad.lan.raisama.net>
Subject: Re: [Qemu-devel] [PATCH v3 1/2] X86: Move rdmsr/wrmsr functionality
 to standalone functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julian Kirsch <git@kirschju.re>
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Tue, Mar 14, 2017 at 02:16:32PM -0300, Eduardo Habkost wrote:
> On Tue, Mar 14, 2017 at 03:08:06PM +0100, Julian Kirsch wrote:
> > Add two new functions to provide read/write access to model specific registers
> > (MSRs) on x86. Move original functionality to new functions
> > x86_cpu_[rd|wr]msr and make list of available MSRs consistent with KVM.
> 
> I would prefer to see code movement and other changes (like
> reordering) in separate patches, to make it easier to review.
> 
> To help reviewers, below is the diff between the old functions in
> misc_helper.c and new functions in helper.c:
> 
> --- /tmp/msrfuncs-old.c	2017-03-14 14:12:04.739686970 -0300
> +++ /tmp/msrfuncs-new.c	2017-03-14 14:11:50.108486602 -0300
> @@ -1,10 +1,10 @@
> -void helper_rdmsr(CPUX86State *env)
> +uint64_t x86_cpu_rdmsr(CPUX86State *env, uint32_t idx, bool *valid)
>  {
>      uint64_t val;
> +    *valid = true;
>  
> -    cpu_svm_check_intercept_param(env, SVM_EXIT_MSR, 0, GETPC());
> -
> -    switch ((uint32_t)env->regs[R_ECX]) {
> +    /* MSR list loosely following the order in kvm.c */
> +    switch (idx) {
>      case MSR_IA32_SYSENTER_CS:
>          val = env->sysenter_cs;
>          break;
[...]
> +#ifdef CONFIG_KVM
> +    /* Export kvm specific pseudo MSRs using their new ordinals only */

I suggest including KVM-specific code in a separate patch.

Also, why are you adding only MSR_KVM_SYSTEM_TIME to wrmsr, and
only MSR_KVM_SYSTEM_TIME_NEW to rdmsr? Shouldn't we include both
addresses on both helper functions?

> +    case MSR_KVM_SYSTEM_TIME_NEW:
> +        val = env->system_time_msr;
> +        break;
> +    case MSR_KVM_WALL_CLOCK_NEW:
> +        val = env->wall_clock_msr;
>          break;
> -    case MSR_TSC_AUX:
> -        val = env->tsc_aux;
> +    case MSR_KVM_ASYNC_PF_EN:
> +        val = env->async_pf_en_msr;
> +        break;
> +    case MSR_KVM_PV_EOI_EN:
> +        val = env->pv_eoi_en_msr;
> +        break;
> +    case MSR_KVM_STEAL_TIME:
> +        val = env->steal_time_msr;
>          break;
>  #endif
[...]
>  
> -void helper_wrmsr(CPUX86State *env)
> +void x86_cpu_wrmsr(CPUX86State *env, uint32_t idx, uint64_t val, bool *valid)
>  {
> -    uint64_t val;
> -
> -    cpu_svm_check_intercept_param(env, SVM_EXIT_MSR, 1, GETPC());
> -
> -    val = ((uint32_t)env->regs[R_EAX]) |
> -        ((uint64_t)((uint32_t)env->regs[R_EDX]) << 32);
> +    *valid = true;
> +    /* FIXME: With KVM nabled, only report success if we are sure the new value
> +     * will actually be written back by the KVM subsystem later. */
>  
> -    switch ((uint32_t)env->regs[R_ECX]) {
> +    switch (idx) {
>      case MSR_IA32_SYSENTER_CS:
>          env->sysenter_cs = val & 0xffff;
>          break;
[...]
> +#ifdef CONFIG_KVM
> +    case MSR_KVM_SYSTEM_TIME:
> +        env->system_time_msr = val;
> +        break;
> +    case MSR_KVM_WALL_CLOCK:
> +        env->wall_clock_msr = val;
> +        break;
> +    case MSR_KVM_ASYNC_PF_EN:
> +        if (env->features[FEAT_KVM] & (1 << KVM_FEATURE_ASYNC_PF)) {
> +            env->async_pf_en_msr = val;
> +        } else {
> +            *valid = false;
> +        }
> +    case MSR_KVM_PV_EOI_EN:
> +        if (env->features[FEAT_KVM] & (1 << KVM_FEATURE_PV_EOI)) {
> +            env->pv_eoi_en_msr = val;
> +        } else {
> +            *valid = false;
> +        }
> +
> +#endif
[...]

-- 
Eduardo
