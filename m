Received: from eggs.gnu.org ([209.51.188.92]:43865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <xuwei5@huawei.com>) id 1hMCjv-00010K-Py
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:31:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <xuwei5@huawei.com>) id 1hMCju-0006BW-O4
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:31:11 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:45394 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <xuwei5@huawei.com>) id 1hMCju-0005yt-HA
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:31:10 -0400
References: <1556170489-131927-12-git-send-email-imammedo@redhat.com>
	<1556211116-172721-1-git-send-email-xuwei5@huawei.com>
	<20190426135412.758769f9@Igors-MacBook-Pro.local>
	<b87a2b31-0389-2df0-42a6-a1593d437fcd@hisilicon.com>
	<20190502162420.6c8280c8@Igors-MacBook-Pro>
From: Wei Xu <xuwei5@hisilicon.com>
Message-ID: <9caa067d-df2e-78c6-5672-e276da3263a6@hisilicon.com>
Date: Thu, 2 May 2019 15:30:54 +0100
MIME-Version: 1.0
In-Reply-To: <20190502162420.6c8280c8@Igors-MacBook-Pro>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 11/13] tests: acpi: add simple arm/virt
 testcase
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: x00249684 <xuwei5@huawei.com>, qemu-devel@nongnu.org, shameerali.kolothum.thodi@huawei.com, linuxarm@huawei.com, Andrew Jones <drjones@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, mst@redhat.com

Hi Igor,

On 5/2/2019 3:24 PM, Igor Mammedov wrote:
> On Fri, 26 Apr 2019 17:28:10 +0100
> Wei Xu <xuwei5@hisilicon.com> wrote:
> 
>> Hi Igor,
>>
>> On 4/26/2019 12:54 PM, Igor Mammedov wrote:
>>> On Fri, 26 Apr 2019 00:51:56 +0800
>>> x00249684 <xuwei5@huawei.com> wrote:
>>>
>>>> Hi Igor,
>>>>
>>>> +static void test_acpi_virt_tcg(void)
>>>> +{
>>>> +    test_data data = {
>>>> +        .machine = "virt",
>>>> +        .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
>>>> +        .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
>>>> +        .cd = "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2",
>>>> +        .ram_start = 0x40000000ULL,
>>>> +        .scan_len = 128ULL * 1024 * 1024,
>>>> +    };
>>>> +
>>>> +    test_acpi_one("-cpu cortex-a57 ", &data);
>>>>
>>>> Replaced the cortex-a57 with host and succesfully tested on the hisilicon arm64 
>>>> D05 board. Otherwise it failed with "kvm_init_vcpu failed: Invalid argument".
>>>> Is it possilbe to set the cpu type like numa-test.c?
>>>
>>> I think it works with numa-test because it uses TCG only but in case of bios-tables-test
>>> it uses accel="kvm:tcg" to leverage KVM capabilities whenever possible to speed up test.
>>>
>>> Now back to our ARM test case, uefi requirement is to use 64bit CPU (hence it was cortex-a57)
>>> however unlike x86 it obviously breaks since KVM accelerator on ARM host is used
>>> and it doesn't work with anything other than 'host' cpu model.
>>>
>>> I think we still want to use KVM whenever possible, but problem lies in that
>>> user (testcase) doesn't have an idea if KVM accelerator is available and host is 64 CPU.
>>>
>>> to sum up we need to support 2 modes:
>>>   1. host is 64 ARM, use kvm with -cpu host
>>>   2. all other cases use tcg with -cpu cortex-a57
>>>
>>> I can hack to probe if /dev/kvm is accessible and host is 64 bit and use #1
>>> otherwise fallback to #2
>>> or as quick fix do only #2 initially and think about a better solution to #1 
>>
>> Thanks!
>> Fine to me.
>>
>>>
>>> Is there any other suggestions/opinions how to approach issue/proceed.
>>
>> To check the host cpu architecture is ARM or not, maybe we can check the value
>> of "CPU implementer" is 0x41 or not from the /proc/cpuinfo.
> 
> it turned out it's more complicated.
> we also should pick a correct GIC depending on host's CPU and that
> changes ACPI tables, so it will worn on some hosts and fail on other.
Sorry, I did not consider that case.

> 
> I'll add a patch to enable test case to pick accelerator and force TCG
> for ARM tests for now.
>

Thanks!

Best Regards,
Wei

>>
>> Best Regards,
>> Wei
>>
>>>
>>> PS:
>>> we probably would like to reuse this not only for acpi tests but also for other
>>> arm/virt test cases that involve running guest code. 
>>>
>>>> Thanks!
>>>>
>>>> Best Regards,
>>>> Wei
>>>
>>>
>>> .
>>>
>>
> 
> 
> .
> 
