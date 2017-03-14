Received: from eggs.gnu.org ([2001:4830:134:3::10]:58083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cnv0L-00062G-C3
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 18:33:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cnv0I-0003z3-6p
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 18:33:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40694)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cnv0I-0003yk-1C
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 18:33:18 -0400
Date: Tue, 14 Mar 2017 19:33:14 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170314223314.GB3086@thinpad.lan.raisama.net>
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

Found something else that confused me:

On Tue, Mar 14, 2017 at 02:16:32PM -0300, Eduardo Habkost wrote:
[...]
> +#if defined CONFIG_KVM && defined TARGET_X86_64

Why exactly are you making the hyperv MSRs x86_64-specific? I
don't see anything at the QEMU code or kernel-side KVM code that
makes it x86_64-specific.

> +    case HV_X64_MSR_HYPERCALL:
> +        val = env->msr_hv_hypercall;
> +        break;
> +    case HV_X64_MSR_GUEST_OS_ID:
> +        val = env->msr_hv_guest_os_id;
> +        break;
> +    case HV_X64_MSR_APIC_ASSIST_PAGE:
> +        val = env->msr_hv_vapic;
> +        break;
> +    case HV_X64_MSR_REFERENCE_TSC:
> +        val = env->msr_hv_tsc;
> +        break;
> +    case HV_X64_MSR_CRASH_P0 ... HV_X64_MSR_CRASH_P4:
> +        val = env->msr_hv_crash_params[idx - HV_X64_MSR_CRASH_P0];
> +        break;
> +    case HV_X64_MSR_VP_RUNTIME:
> +        val = env->msr_hv_runtime;
> +        break;
> +    case HV_X64_MSR_SCONTROL:
> +        val = env->msr_hv_synic_control;
> +        break;
> +    case HV_X64_MSR_SVERSION:
> +        val = env->msr_hv_synic_version;
> +        break;
> +    case HV_X64_MSR_SIEFP:
> +        val = env->msr_hv_synic_evt_page;
> +        break;
> +    case HV_X64_MSR_SIMP:
> +        val = env->msr_hv_synic_msg_page;
> +        break;
> +    case HV_X64_MSR_SINT0 ... HV_X64_MSR_SINT15:
> +        val = env->msr_hv_synic_sint[idx - HV_X64_MSR_SINT0];
> +        break;
> +    case HV_X64_MSR_STIMER0_CONFIG:
> +    case HV_X64_MSR_STIMER1_CONFIG:
> +    case HV_X64_MSR_STIMER2_CONFIG:
> +    case HV_X64_MSR_STIMER3_CONFIG:
> +        val = env->msr_hv_stimer_config[(idx - HV_X64_MSR_STIMER0_CONFIG) / 2];
> +        break;
> +    case HV_X64_MSR_STIMER0_COUNT:
> +    case HV_X64_MSR_STIMER1_COUNT:
> +    case HV_X64_MSR_STIMER2_COUNT:
> +    case HV_X64_MSR_STIMER3_COUNT:
> +        val = env->msr_hv_stimer_count[(idx - HV_X64_MSR_STIMER0_COUNT) / 2];
> +        break;
> +#endif
[...]

-- 
Eduardo
