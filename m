Received: from eggs.gnu.org ([2001:4830:134:3::10]:41611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1ddcw8-0003Po-RK
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 09:47:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1ddcv2-0007f8-7L
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 09:46:42 -0400
Received: from mail-ua0-f171.google.com ([209.85.217.171]:36630)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1ddcv1-0007dZ-Uq
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 09:45:36 -0400
Received: by mail-ua0-f171.google.com with SMTP id k43so7296255uaf.3
	for <qemu-devel@nongnu.org>; Fri, 04 Aug 2017 06:45:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <2ddf96f2-be1a-7fc6-c2b2-80c53ea5ddf3@redhat.com>
References: <20170804091403.13478-1-lprosek@redhat.com>
	<20170804091403.13478-4-lprosek@redhat.com>
	<2ddf96f2-be1a-7fc6-c2b2-80c53ea5ddf3@redhat.com>
From: Ladi Prosek <lprosek@redhat.com>
Date: Fri, 4 Aug 2017 15:45:34 +0200
Message-ID: <CABdb736hP8=Gz4jr9rBY8wv=R22d=dLzTN431OR4K=o6Ms_NUw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 3/3] i386/kvm: advertise Hyper-V frequency
 MSRs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, KVM list <kvm@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Radim Krcmar <rkrcmar@redhat.com>

On Fri, Aug 4, 2017 at 3:39 PM, David Hildenbrand <david@redhat.com> wrote:
> On 04.08.2017 11:14, Ladi Prosek wrote:
>> As of kernel commit eb82feea59d6 ("KVM: hyperv: support HV_X64_MSR_TSC_FREQUENCY
>> and HV_X64_MSR_APIC_FREQUENCY"), KVM supports two new MSRs which are required
>> for nested Hyper-V to read timestamps with RDTSC + TSC page.
>>
>> This commit makes QEMU advertise the MSRs with CPUID.40000003H:EAX[11] and
>> CPUID.40000003H:EDX[8] as specified in the Hyper-V TLFS and experimentally
>> verified on a Hyper-V host. The feature is enabled with the existing hv-time CPU
>> flag, and only if the TSC frequency is stable across migration and known.
>>
>> Signed-off-by: Ladi Prosek <lprosek@redhat.com>
>> ---
>>  target/i386/kvm.c | 16 +++++++++++++++-
>>  1 file changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
>> index 77b6373..7e484a7 100644
>> --- a/target/i386/kvm.c
>> +++ b/target/i386/kvm.c
>> @@ -89,6 +89,7 @@ static bool has_msr_hv_vpindex;
>>  static bool has_msr_hv_runtime;
>>  static bool has_msr_hv_synic;
>>  static bool has_msr_hv_stimer;
>> +static bool has_msr_hv_frequencies;
>>  static bool has_msr_xss;
>>
>>  static bool has_msr_architectural_pmu;
>> @@ -631,7 +632,17 @@ static int hyperv_handle_properties(CPUState *cs)
>>      if (cpu->hyperv_time) {
>>          env->features[FEAT_HYPERV_EAX] |= HV_X64_MSR_HYPERCALL_AVAILABLE;
>>          env->features[FEAT_HYPERV_EAX] |= HV_X64_MSR_TIME_REF_COUNT_AVAILABLE;
>> -        env->features[FEAT_HYPERV_EAX] |= 0x200;
>> +        env->features[FEAT_HYPERV_EAX] |= HV_X64_MSR_REFERENCE_TSC_AVAILABLE;
>> +        if (has_msr_hv_frequencies> +            /* TSC clock must be stable and known for this feature. */
>> +            && ((env->features[FEAT_8000_0007_EDX] & CPUID_APM_INVTSC)
>> +                || env->user_tsc_khz != 0)
>> +            && env->tsc_khz != 0) {
>
> I'd drop the != 0 in both cases and move the env->tsc_khz check up to
> has_msr_hv_frequencies.
>
> if (has_msr_hv_frequencies && env->tsc_khz && ...
>
> Wonder if it even would make sense to move some parts of this check into
> a helper function, to beautify this a bit. tsc_stable(env)
> tsc_known(env) ...

Yup, especially since I copied these conditions from "if
(cpu->vmware_cpuid_freq .." further down in the file. So maybe one
helper called by both would be the best. Thanks!

>> +
>> +            env->features[FEAT_HYPERV_EAX] |= HV_X64_ACCESS_FREQUENCY_MSRS;
>> +            env->features[FEAT_HYPERV_EDX] |=
>> +                HV_FEATURE_FREQUENCY_MSRS_AVAILABLE;
>> +        }
>>      }
>>      if (cpu->hyperv_crash && has_msr_hv_crash) {
>>          env->features[FEAT_HYPERV_EDX] |= HV_X64_GUEST_CRASH_MSR_AVAILABLE;
>> @@ -1127,6 +1138,9 @@ static int kvm_get_supported_msrs(KVMState *s)
>>                  case HV_X64_MSR_STIMER0_CONFIG:
>>                      has_msr_hv_stimer = true;
>>                      break;
>> +                case HV_X64_MSR_TSC_FREQUENCY:
>> +                    has_msr_hv_frequencies = true;
>> +                    break;
>>                  }
>>
>>              }
>>
>
>
> --
>
> Thanks,
>
> David
