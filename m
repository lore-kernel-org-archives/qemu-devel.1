Received: from eggs.gnu.org ([209.51.188.92]:56326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1glVtn-00015M-0z
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 04:29:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1glVtm-0004sV-AD
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 04:29:42 -0500
Received: from mga09.intel.com ([134.134.136.24]:45725)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1glVtm-0004le-1j
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 04:29:42 -0500
From: Tao Xu <tao3.xu@intel.com>
References: <20181227024304.12182-1-tao3.xu@intel.com>
	<20181227024304.12182-3-tao3.xu@intel.com>
	<20190114183545.GB28115@habkost.net>
Message-ID: <ad912a4e-986b-61d3-0fd8-1047ecabd651@intel.com>
Date: Mon, 21 Jan 2019 17:29:32 +0800
MIME-Version: 1.0
In-Reply-To: <20190114183545.GB28115@habkost.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] i386: Add some MSR based features on
 Cascadelake-Server CPU model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: pbonzini@redhat.com, rth@twiddle.net, qemu-devel@nongnu.org, robert.hu@linux.intel.com, thomas.lendacky@amd.com

On 1/15/2019 2:35 AM, Eduardo Habkost wrote:
> Sorry, we do have a problem here:
> 
> On Thu, Dec 27, 2018 at 10:43:04AM +0800, Tao Xu wrote:
> [...]
>>   #define PC_COMPAT_3_0 \
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index 09706ad51a..5296c73cd5 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -2499,7 +2499,8 @@ static X86CPUDefinition builtin_x86_defs[] = {
>>               CPUID_7_0_ECX_PKU | CPUID_7_0_ECX_OSPKE |
>>               CPUID_7_0_ECX_AVX512VNNI,
>>           .features[FEAT_7_0_EDX] =
>> -            CPUID_7_0_EDX_SPEC_CTRL | CPUID_7_0_EDX_SPEC_CTRL_SSBD,
>> +            CPUID_7_0_EDX_SPEC_CTRL | CPUID_7_0_EDX_SPEC_CTRL_SSBD |
>> +            CPUID_7_0_EDX_ARCH_CAPABILITIES,
> 
> CPUID_7_0_EDX_ARCH_CAPABILITIES is still set on
> unmigratable_flags.  We need to make it migratable before adding
> it by default to a named CPU model.
> 
Hi Eduardo,

Do you mean I need to remove CPUID_7_0_EDX_ARCH_CAPABILITIES
from .migratable_flags? Or CPUID_7_0_EDX_ARCH_CAPABILITIES can not
support migration now?

> Also, why are you setting this only on Cascadelake-Server and not
> on all the other Intel CPUs?
> 
Thank you for your notice. I reviewed the git log of KVM.
"MSR_IA32_ARCH_CAPABILITIES is emulated in kvm, there is no dependency 
on hardware support for this feature". So do you mean we should also add 
features based on ARCH_CAPABILITIES in former CPU(such as skylake)?

> I'm queueing only patch 1/2 until we sort this out.
>
