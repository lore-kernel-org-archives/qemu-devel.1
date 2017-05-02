Received: from eggs.gnu.org ([2001:4830:134:3::10]:59559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1d5Wmw-0004wp-Du
	for qemu-devel@nongnu.org; Tue, 02 May 2017 08:20:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1d5Wms-0004OO-Fj
	for qemu-devel@nongnu.org; Tue, 02 May 2017 08:20:18 -0400
References: <1493530677-4919-1-git-send-email-gengdongjiu@huawei.com>
	<20170502075631.GE16940@cbox>
From: gengdongjiu <gengdongjiu@huawei.com>
Message-ID: <c3b355e7-0358-25ea-9617-80be489a3f83@huawei.com>
Date: Tue, 2 May 2017 20:15:03 +0800
MIME-Version: 1.0
In-Reply-To: <20170502075631.GE16940@cbox>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/3] arm64: kvm: support kvmtool to
 detect RAS extension feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christoffer Dall <cdall@linaro.org>
Cc: james.morse@arm.com, marc.zyngier@arm.com, christoffer.dall@linaro.org, rkrcmar@redhat.com, linux@armlinux.org.uk, tbaicar@codeaurora.org, imammedo@redhat.com, zhaoshenglong@huawei.com, peter.maydell@linaro.org, pbonzini@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, lersek@redhat.com, ard.biesheuvel@linaro.org, mtsirkin@redhat.com, drjones@redhat.com, ben@skyportsystems.com, kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, xiexiuqi@huawei.com, wangxiongfeng2@huawei.com, songwenjun@huawei.com, wuquanming@huawei.com, huangshaoyu@huawei.com, gengdongjiu <gengdongjiu@huawei.com>, linux-kernel@vger.kernel.org

Hi Christoffer,
   thanks for your review and comments.

On 2017/5/2 15:56, Christoffer Dall wrote:
> Hi Dongjiu,
> 
> Please send a cover letter for patch series with more than a single
> patch.
 OK, got it.

> 
> The subject and description of these patches are also misleading.
> Hopefully this is in no way tied to kvmtool, but to userspace
> generically, for example also to be used by QEMU?
> 
> On Sun, Apr 30, 2017 at 01:37:55PM +0800, Dongjiu Geng wrote:
>> Handle kvmtool's detection for RAS extension, because sometimes
>> the APP needs to know the CPU's capacity
> 
> the APP ?
> 
> the CPU's capacity?
I will fix it.

> 
>>
>> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
>> ---
>>  arch/arm64/kvm/reset.c   | 11 +++++++++++
>>  include/uapi/linux/kvm.h |  1 +
>>  2 files changed, 12 insertions(+)
>>
>> diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
>> index d9e9697..1004039 100644
>> --- a/arch/arm64/kvm/reset.c
>> +++ b/arch/arm64/kvm/reset.c
>> @@ -64,6 +64,14 @@ static bool cpu_has_32bit_el1(void)
>>  	return !!(pfr0 & 0x20);
>>  }
>>  
>> +static bool kvm_arm_support_ras_extension(void)
>> +{
>> +	u64 pfr0;
>> +
>> +	pfr0 = read_system_reg(SYS_ID_AA64PFR0_EL1);
>> +	return !!(pfr0 & 0x10000000);
>> +}
>> +
>>  /**
>>   * kvm_arch_dev_ioctl_check_extension
>>   *
>> @@ -87,6 +95,9 @@ int kvm_arch_dev_ioctl_check_extension(struct kvm *kvm, long ext)
>>  	case KVM_CAP_ARM_PMU_V3:
>>  		r = kvm_arm_support_pmu_v3();
>>  		break;
>> +	case KVM_CAP_ARM_RAS_EXTENSION:
>> +		r = kvm_arm_support_ras_extension();
>> +		break;
> 
> You need to document this capability and API in
> Documentation/virtual/kvm/api.txt and explain how this works.
 Ok, thanks for your suggestion.

> 
> 
> 
>>  	case KVM_CAP_SET_GUEST_DEBUG:
>>  	case KVM_CAP_VCPU_ATTRIBUTES:
>>  		r = 1;
>> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
>> index f51d508..27fe556 100644
>> --- a/include/uapi/linux/kvm.h
>> +++ b/include/uapi/linux/kvm.h
>> @@ -883,6 +883,7 @@ struct kvm_ppc_resize_hpt {
>>  #define KVM_CAP_PPC_MMU_RADIX 134
>>  #define KVM_CAP_PPC_MMU_HASH_V3 135
>>  #define KVM_CAP_IMMEDIATE_EXIT 136
>> +#define KVM_CAP_ARM_RAS_EXTENSION 137
>>  
>>  #ifdef KVM_CAP_IRQ_ROUTING
>>  
>> -- 
>> 2.10.1
>>
> 
> Thanks,
> -Christoffer
> 
> .
> 
