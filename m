Received: from eggs.gnu.org ([209.51.188.92]:51733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1go2Mj-0004Uc-KC
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 03:34:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1go2Mi-0001fc-F7
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 03:34:01 -0500
Received: from mga09.intel.com ([134.134.136.24]:63734)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1go2Mh-0001X2-UB
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 03:34:00 -0500
References: <20181227024304.12182-1-tao3.xu@intel.com>
	<20181227024304.12182-3-tao3.xu@intel.com>
	<20190114183545.GB28115@habkost.net>
	<ad912a4e-986b-61d3-0fd8-1047ecabd651@intel.com>
	<20190123191550.GX4136@habkost.net>
From: Tao Xu <tao3.xu@intel.com>
Message-ID: <ab92f502-bc96-34fd-0b21-6d1918648549@intel.com>
Date: Mon, 28 Jan 2019 16:33:40 +0800
MIME-Version: 1.0
In-Reply-To: <20190123191550.GX4136@habkost.net>
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
Cc: pbonzini@redhat.com, rth@twiddle.net, qemu-devel@nongnu.org, robert.hu@linux.intel.com, thomas.lendacky@amd.com, xuelian.guo@intel.com

On 1/24/2019 3:15 AM, Eduardo Habkost wrote:
> On Mon, Jan 21, 2019 at 05:29:32PM +0800, Tao Xu wrote:
>> On 1/15/2019 2:35 AM, Eduardo Habkost wrote:
>>> Sorry, we do have a problem here:
>>>
>>> On Thu, Dec 27, 2018 at 10:43:04AM +0800, Tao Xu wrote:
>>> [...]
>>>>    #define PC_COMPAT_3_0 \
>>>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>>>> index 09706ad51a..5296c73cd5 100644
>>>> --- a/target/i386/cpu.c
>>>> +++ b/target/i386/cpu.c
>>>> @@ -2499,7 +2499,8 @@ static X86CPUDefinition builtin_x86_defs[] = {
>>>>                CPUID_7_0_ECX_PKU | CPUID_7_0_ECX_OSPKE |
>>>>                CPUID_7_0_ECX_AVX512VNNI,
>>>>            .features[FEAT_7_0_EDX] =
>>>> -            CPUID_7_0_EDX_SPEC_CTRL | CPUID_7_0_EDX_SPEC_CTRL_SSBD,
>>>> +            CPUID_7_0_EDX_SPEC_CTRL | CPUID_7_0_EDX_SPEC_CTRL_SSBD |
>>>> +            CPUID_7_0_EDX_ARCH_CAPABILITIES,
>>>
>>> CPUID_7_0_EDX_ARCH_CAPABILITIES is still set on
>>> unmigratable_flags.  We need to make it migratable before adding
>>> it by default to a named CPU model.
>>>
>> Hi Eduardo,
>>
>> Do you mean I need to remove CPUID_7_0_EDX_ARCH_CAPABILITIES
>> from .migratable_flags? Or CPUID_7_0_EDX_ARCH_CAPABILITIES can not
>> support migration now?
> 
> We need to remove it from .unmigratable_flags, but only after
> confirm it is really migration-safe.  To make it migration-safe,
> the MSR value seen by the guest must have a predictable value
> that is 100% independent from host hardware or host software
> version.
> 
> This is easy to ensure if MSR_IA32_ARCH_CAPABILITIES is in
> KVM_GET_MSR_INDEX_LIST (meaning QEMU can actually configure the
> MSR value seen by the guest).  If MSR_IA32_ARCH_CAPABILITIES is
> not on KVM_GET_MSR_INDEX_LIST, arch-capabilities must not be
> returned by x86_cpu_get_supported_feature_word() when
> migratable_only is true.
> 
Thank you. I have seen your patch to migratable it:

[PATCH 0/2] i386: arch_capabilities fixes + migratability
http://lists.nongnu.org/archive/html/qemu-devel/2019-01/msg06701.html

So now can arch-capabilities and features exposed by it be added in 
Cascadelake CPU model? Because Cascadelake CPU model can support it in 
hardware. And for Icelake CPU model, Robert will add in the future.
> 
>>
>>> Also, why are you setting this only on Cascadelake-Server and not
>>> on all the other Intel CPUs?
>>>
>> Thank you for your notice. I reviewed the git log of KVM.
>> "MSR_IA32_ARCH_CAPABILITIES is emulated in kvm, there is no dependency on
>> hardware support for this feature". So do you mean we should also add
>> features based on ARCH_CAPABILITIES in former CPU(such as skylake)?
> 
> It doesn't depend on host hardware features, but it does depend
> on host KVM code added in Linux v4.17, which makes this more
> tricky.
> 
> We don't want a QEMU upgrade to make an existing VM configuration
> to stop running under Linux v4.16.  This will probably require
> versioned CPU models[1] to work well.
> 
> [1] https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg08422.html
> 
Hi Eduardo, I think the versioned CPU models solution is great. But I 
haven't seen further patches in the mail list. What is the recent 
progress of this work? Need me to do something?

Looking forward to your reply.
Tao
