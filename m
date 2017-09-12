Received: from eggs.gnu.org ([2001:4830:134:3::10]:49624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1drg67-0003BI-8n
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 03:59:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1drg63-0008Tg-Be
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 03:59:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58760)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1drg63-0008TA-2b
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 03:59:03 -0400
References: <1505143227-14324-1-git-send-email-arei.gonglei@huawei.com>
	<20170911183748.GS7570@localhost.localdomain>
	<33183CC9F5247A488A2544077AF19020DA3AAD3B@DGGEMA505-MBX.china.huawei.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <35ab2902-630c-b57f-77c2-10bf88798d81@redhat.com>
Date: Tue, 12 Sep 2017 09:58:48 +0200
MIME-Version: 1.0
In-Reply-To: <33183CC9F5247A488A2544077AF19020DA3AAD3B@DGGEMA505-MBX.china.huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] i386/cpu/hyperv: support over 64 vcpus for
 windows guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mst@redhat.com" <mst@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>, "mtosatti@redhat.com" <mtosatti@redhat.com>, "vrozenfe@redhat.com" <vrozenfe@redhat.com>, "Huangweidong (C)" <weidong.huang@huawei.com>

On 12/09/2017 03:41, Gonglei (Arei) wrote:
> 
>> -----Original Message-----
>> From: Eduardo Habkost [mailto:ehabkost@redhat.com]
>> Sent: Tuesday, September 12, 2017 2:38 AM
>> To: Gonglei (Arei)
>> Cc: qemu-devel@nongnu.org; mst@redhat.com; pbonzini@redhat.com;
>> rth@twiddle.net; mtosatti@redhat.com; vrozenfe@redhat.com;
>> Huangweidong (C)
>> Subject: Re: [PATCH] i386/cpu/hyperv: support over 64 vcpus for windows
>> guests
>>
>> On Mon, Sep 11, 2017 at 11:20:27PM +0800, Gonglei wrote:
>>> Starting with Windows Server 2012 and Windows 8, if
>>> CPUID.40000005.EAX contains a value of -1, Windows assumes specific
>>> limit to the number of VPs. In this case, Windows Server 2012
>>> guest VMs may use more than 64 VPs, up to the maximum supported
>>> number of processors applicable to the specific Windows
>>> version being used.
>>>
>>>
>> https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/referenc
>> e/tlfs
>>>
>>> For compatibility, Let's introduce a new property for X86CPU,
>>> named "x-hv-max-vps" as Eduardo's suggestion, and set it
>>> to 0x40 before machine 2.10.
>>>
>>> (The "x-" prefix indicates that the property is not supposed to
>>> be a stable user interface.)
>>>
>>> Signed-off-by: Gonglei <arei.gonglei@huawei.com>
>>> ---
>>>  include/hw/i386/pc.h |  5 +++++
>>>  target/i386/cpu.c    |  1 +
>>>  target/i386/cpu.h    |  2 ++
>>>  target/i386/kvm.c    | 15 ++++++++++++++-
>>>  4 files changed, 22 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
>>> index 8226904..087d184 100644
>>> --- a/include/hw/i386/pc.h
>>> +++ b/include/hw/i386/pc.h
>>> @@ -371,6 +371,11 @@ bool e820_get_entry(int, uint32_t, uint64_t *,
>> uint64_t *);
>>>
>>>  #define PC_COMPAT_2_10 \
>>>      HW_COMPAT_2_10 \
>>> +    {\
>>> +        .driver   = TYPE_X86_CPU,\
>>> +        .property = "x-hv-max-vps",\
>>> +        .value    = "0x40",\
>>> +    },
>>>
>>>  #define PC_COMPAT_2_9 \
>>>      HW_COMPAT_2_9 \
>>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>>> index 69676e1..2702485 100644
>>> --- a/target/i386/cpu.c
>>> +++ b/target/i386/cpu.c
>>> @@ -4145,6 +4145,7 @@ static Property x86_cpu_properties[] = {
>>>                       false),
>>>      DEFINE_PROP_BOOL("vmware-cpuid-freq", X86CPU,
>> vmware_cpuid_freq, true),
>>>      DEFINE_PROP_BOOL("tcg-cpuid", X86CPU, expose_tcg, true),
>>> +    DEFINE_PROP_INT32("x-hv-max-vps", X86CPU, hv_max_vps, -1),
>>>      DEFINE_PROP_END_OF_LIST()
>>>  };
>>>
>>> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
>>> index 525d35d..5c726f3 100644
>>> --- a/target/i386/cpu.h
>>> +++ b/target/i386/cpu.h
>>> @@ -1282,6 +1282,8 @@ struct X86CPU {
>>>      int32_t socket_id;
>>>      int32_t core_id;
>>>      int32_t thread_id;
>>> +
>>> +    int32_t hv_max_vps;
>>>  };
>>>
>>>  static inline X86CPU *x86_env_get_cpu(CPUX86State *env)
>>> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
>>> index 6db7783..a898bef 100644
>>> --- a/target/i386/kvm.c
>>> +++ b/target/i386/kvm.c
>>> @@ -751,7 +751,20 @@ int kvm_arch_init_vcpu(CPUState *cs)
>>>
>>>          c = &cpuid_data.entries[cpuid_i++];
>>>          c->function = HYPERV_CPUID_IMPLEMENT_LIMITS;
>>> -        c->eax = 0x40;
>>> +
>>> +        /*
>>> +         * From "Requirements for Implementing the Microsoft
>>> +         * Hypervisor Interface":
>>> +         *
>> https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/referenc
>> e/tlfs
>>> +         *
>>> +         * "Starting with Windows Server 2012 and Windows 8, if
>>> +         * CPUID.40000005.EAX contains a value of -1, Windows assumes
>>> +         * specific limit to the number of VPs. In this case, Windows
>>> +         * Server 2012 guest VMs may use more than 64 VPs, up to the
>>> +         * maximum supported number of processors applicable to the
>>> +         * specific Windows version being used."
>>> +         */
>>
>> I would place this comment above the DEFINE_PROP_INT32
>> declaration, as its purpose is to explain the -1 default.
>>
> Fine, do I need to send v2? Or you adjust it directly?

Done, also changing the sentence to "Windows assumes that the hypervisor
imposes no specific limit to the number of VPs" as in the Microsoft
document.

Paolo

> 
> Thanks,
> -Gonglei
>>
>>> +        c->eax = cpu->hv_max_vps;
>>>          c->ebx = 0x40;
>>>
>>>          kvm_base = KVM_CPUID_SIGNATURE_NEXT;
>>> --
>>> 1.8.3.1
>>>
>>>
>>
>> --
>> Eduardo
