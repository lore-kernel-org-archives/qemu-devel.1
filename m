Received: from eggs.gnu.org ([2001:4830:134:3::10]:36674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1dPMb7-00012t-MK
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 01:30:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1dPMb3-0000ML-Pq
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 01:30:05 -0400
References: <1493530677-4919-1-git-send-email-gengdongjiu@huawei.com>
	<5908A5BC.1060202@arm.com>
From: gengdongjiu <gengdongjiu@huawei.com>
Message-ID: <9e94c06f-f438-7106-ac96-67e021dcf729@huawei.com>
Date: Mon, 26 Jun 2017 13:22:27 +0800
MIME-Version: 1.0
In-Reply-To: <5908A5BC.1060202@arm.com>
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
To: James Morse <james.morse@arm.com>
Cc: marc.zyngier@arm.com, christoffer.dall@linaro.org, rkrcmar@redhat.com, linux@armlinux.org.uk, tbaicar@codeaurora.org, imammedo@redhat.com, zhaoshenglong@huawei.com, peter.maydell@linaro.org, pbonzini@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, lersek@redhat.com, ard.biesheuvel@linaro.org, mtsirkin@redhat.com, drjones@redhat.com, ben@skyportsystems.com, kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, xiexiuqi@huawei.com, wangxiongfeng2@huawei.com, songwenjun@huawei.com, wuquanming@huawei.com, huangshaoyu@huawei.com

Hi James,

   I have changed the SEA/SEI injection method according you suggestion, but I think this patch may also be needed.
Now for the  SEI, the virtual ESR value is specified by the userspace. only RAS extension support to set the virtual ESR value. so user space will check it to decide whether pass the virtual ESR value.
At the same time, reserve this interface for other possible usage by user space. what do you think about this patch?



On 2017/5/2 23:29, James Morse wrote:
> Hi Dongjiu Geng,
> 
> On 30/04/17 06:37, Dongjiu Geng wrote:
>> Handle kvmtool's detection for RAS extension, because sometimes
>> the APP needs to know the CPU's capacity
> 
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
> 
> Why are we telling user-space that the CPU has RAS extensions? EL0 can't do
> anything with this and the guest EL1 can detect it from the id registers.
> 
> 
> Are you using this to decide whether or not to generate a HEST for the guest?
> 
> If Qemu/kvmtool supports handling memory-failure notifications from signals you
> should always generate a HEST. The GHES notification method could be anything
> Qemu can deliver to the guest using the KVM APIs. Notifications from Qemu to the
> guest don't depend on the RAS extensions. KVM has APIs for IRQ and SEA (you can
> use KVM_SET_ONE_REG).
> 
> 
> I think we need a new API for injecting SError for SEI from Qemu/kvmtool, but it
> shouldn't be related to the RAS extensions. All v8.0 CPUs have HCR_EL2.VSE, so
> we need to know KVM supports this API.
> 
> Your later patch adds code to set VSESR to make virtual RAS SErrors work, I
> think we need to expose that to user-space.
> 
> 
> Thanks,
> 
> James
> .
> 
