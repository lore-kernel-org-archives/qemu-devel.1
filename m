Received: from eggs.gnu.org ([2001:4830:134:3::10]:34447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <git@kirschju.re>) id 1co8X2-0003Y6-Pg
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 09:00:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <git@kirschju.re>) id 1co8Wx-0001BC-Tx
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 09:00:00 -0400
Received: from h2042504.stratoserver.net ([85.214.107.226]:39156)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <git@kirschju.re>) id 1co8Wx-0001Al-NG
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:59:55 -0400
References: <20170314140807.6061-1-git@kirschju.re>
	<20170314140807.6061-2-git@kirschju.re>
	<20170314171632.GS4694@thinpad.lan.raisama.net>
	<20170314223314.GB3086@thinpad.lan.raisama.net>
From: Julian Kirsch <git@kirschju.re>
Message-ID: <c687a959-3aee-16aa-1213-93dee5752188@kirschju.re>
Date: Wed, 15 Mar 2017 13:59:20 +0100
MIME-Version: 1.0
In-Reply-To: <20170314223314.GB3086@thinpad.lan.raisama.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

Hi Eduardo,

thanks for taking the time to look through the patch series. To recapitulate for
the next iteration:

1.) Let the rd/wrmsr functions set the valid variable in case of
    CONFIG_USER_ONLY being set.
2.) Split up patch into code movement followed by reordering
3.) I included only MSR_KVM_SYSTEM_TIME_NEW because exposing MSR_KVM_SYSTEM_TIME
    to users will hardcode its presence forever, and from the comments next
    to the macro definitions I figured MSR_KVM_SYSTEM_TIME should not be used
    anymore.
4.) HyperV MSRs were assumed to be x86_64 specific because they have X64
    in their names, but it seems I was wrong on this one. Sorry for being
    lured simply due to the naming convention.

Best,
Julian

On 14.03.2017 23:33, Eduardo Habkost wrote:
> Found something else that confused me:
> 
> On Tue, Mar 14, 2017 at 02:16:32PM -0300, Eduardo Habkost wrote:
> [...]
>> +#if defined CONFIG_KVM && defined TARGET_X86_64
> 
> Why exactly are you making the hyperv MSRs x86_64-specific? I
> don't see anything at the QEMU code or kernel-side KVM code that
> makes it x86_64-specific.
> 
>> +    case HV_X64_MSR_HYPERCALL:
>> +        val = env->msr_hv_hypercall;
>> +        break;
>> +    case HV_X64_MSR_GUEST_OS_ID:
>> +        val = env->msr_hv_guest_os_id;
>> +        break;
>> +    case HV_X64_MSR_APIC_ASSIST_PAGE:
>> +        val = env->msr_hv_vapic;
>> +        break;
>> +    case HV_X64_MSR_REFERENCE_TSC:
>> +        val = env->msr_hv_tsc;
>> +        break;
>> +    case HV_X64_MSR_CRASH_P0 ... HV_X64_MSR_CRASH_P4:
>> +        val = env->msr_hv_crash_params[idx - HV_X64_MSR_CRASH_P0];
>> +        break;
>> +    case HV_X64_MSR_VP_RUNTIME:
>> +        val = env->msr_hv_runtime;
>> +        break;
>> +    case HV_X64_MSR_SCONTROL:
>> +        val = env->msr_hv_synic_control;
>> +        break;
>> +    case HV_X64_MSR_SVERSION:
>> +        val = env->msr_hv_synic_version;
>> +        break;
>> +    case HV_X64_MSR_SIEFP:
>> +        val = env->msr_hv_synic_evt_page;
>> +        break;
>> +    case HV_X64_MSR_SIMP:
>> +        val = env->msr_hv_synic_msg_page;
>> +        break;
>> +    case HV_X64_MSR_SINT0 ... HV_X64_MSR_SINT15:
>> +        val = env->msr_hv_synic_sint[idx - HV_X64_MSR_SINT0];
>> +        break;
>> +    case HV_X64_MSR_STIMER0_CONFIG:
>> +    case HV_X64_MSR_STIMER1_CONFIG:
>> +    case HV_X64_MSR_STIMER2_CONFIG:
>> +    case HV_X64_MSR_STIMER3_CONFIG:
>> +        val = env->msr_hv_stimer_config[(idx - HV_X64_MSR_STIMER0_CONFIG) / 2];
>> +        break;
>> +    case HV_X64_MSR_STIMER0_COUNT:
>> +    case HV_X64_MSR_STIMER1_COUNT:
>> +    case HV_X64_MSR_STIMER2_COUNT:
>> +    case HV_X64_MSR_STIMER3_COUNT:
>> +        val = env->msr_hv_stimer_count[(idx - HV_X64_MSR_STIMER0_COUNT) / 2];
>> +        break;
>> +#endif
> [...]
> 
