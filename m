Received: from eggs.gnu.org ([2001:4830:134:3::10]:40447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1ctAQr-00081u-F8
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 06:02:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1ctAQo-0001k0-Bm
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 06:02:25 -0400
Received: from [45.249.212.189] (port=2884 helo=dggrg03-dlp.huawei.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1ctAQm-0001hQ-Rp
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 06:02:22 -0400
References: <7055772d-2a20-6e0c-2bf8-204bc9ef52a5@arm.com>
	<b912c293-4314-7c90-30a4-2f986feb1670@huawei.com>
	<22fb583f-a33e-15f8-a059-fb112b27dd4f@arm.com>
	<58CFF058.8020205@arm.com>
	<76795e20-2f20-1e54-cfa5-7444f28b18ee@huawei.com>
	<20170321113428.GC15920@cbox> <58D17AF0.2010802@arm.com>
	<20170321193933.GB31111@cbox> <58DA3F68.6090901@arm.com>
	<20170328112328.GA31156@cbox> <20170328115413.GJ23682@e104320-lin>
	<b1c6e747-2fa7-b7a1-60d5-4a9c480b9dc9@huawei.com>
	<58DA67BA.8070404@arm.com>
From: gengdongjiu <gengdongjiu@huawei.com>
Message-ID: <5b7352f4-4965-3ed5-3879-db871797be47@huawei.com>
Date: Wed, 29 Mar 2017 17:36:37 +0800
MIME-Version: 1.0
In-Reply-To: <58DA67BA.8070404@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] kvm: pass the virtual SEI syndrome to
 guest OS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: lersek@redhat.com, ard.biesheuvel@linaro.org, edk2-devel@lists.01.org, qemu-devel@nongnu.org, zhaoshenglong@huawei.com
Cc: Achin Gupta <achin.gupta@arm.com>, James Morse <james.morse@arm.com>, Christoffer Dall <cdall@linaro.org>, xiexiuqi@huawei.com, Marc Zyngier <marc.zyngier@arm.com>, catalin.marinas@arm.com, will.deacon@arm.com, christoffer.dall@linaro.org, rkrcmar@redhat.com, suzuki.poulose@arm.com, andre.przywara@arm.com, mark.rutland@arm.com, vladimir.murzin@arm.com, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, wangxiongfeng2@huawei.com, wuquanming@huawei.com, huangshaoyu@huawei.com, Leif.Lindholm@linaro.comnd@arm.com


Hi Laszlo/Biesheuvel/Qemu developer,

   Now I encounter a issue and want to consult with you in ARM64 platform， as described below:

   when guest OS happen synchronous or asynchronous abort, kvm needs to send the error address to Qemu or UEFI through sigbus to dynamically generate APEI table. from my investigation, there are two ways:

   (1) Qemu get the error address, and generate the APEI table, then notify UEFI to know this generation, then inject abort error to guest OS, guest OS read the APEI table.
   (2) Qemu get the error address, and let UEFI to generate the APEI table, then inject abort error to guest OS, guest OS read the APEI table.


   Do you think which modules generates the APEI table is better? UEFI or Qemu?




On 2017/3/28 21:40, James Morse wrote:
> Hi gengdongjiu,
> 
> On 28/03/17 13:16, gengdongjiu wrote:
>> On 2017/3/28 19:54, Achin Gupta wrote:
>>> On Tue, Mar 28, 2017 at 01:23:28PM +0200, Christoffer Dall wrote:
>>>> On Tue, Mar 28, 2017 at 11:48:08AM +0100, James Morse wrote:
>>>>> On the host, part of UEFI is involved to generate the CPER records.
>>>>> In a guest?, I don't know.
>>>>> Qemu could generate the records, or drive some other component to do it.
>>>>
>>>> I think I am beginning to understand this a bit.  Since the guet UEFI
>>>> instance is specifically built for the machine it runs on, QEMU's virt
>>>> machine in this case, they could simply agree (by some contract) to
>>>> place the records at some specific location in memory, and if the guest
>>>> kernel asks its guest UEFI for that location, things should just work by
>>>> having logic in QEMU to process error reports and populate guest memory.
>>>>
>>>> Is this how others see the world too?
>>>
>>> I think so!
>>>
>>> AFAIU, the memory where CPERs will reside should be specified in a GHES entry in
>>> the HEST. Is this not the case with a guest kernel i.e. the guest UEFI creates a
>>> HEST for the guest Kernel?
>>>
>>> If so, then the question is how the guest UEFI finds out where QEMU (acting as
>>> EL3 firmware) will populate the CPERs. This could either be a contract between
>>> the two or a guest DXE driver uses the MM_COMMUNICATE call (see [1]) to ask QEMU
>>> where the memory is.
>>
>> whether invoke the guest UEFI will be complex? not see the advantage. it seems x86 Qemu
>> directly generate the ACPI table, but I am not sure, we are checking the qemu
> logical.
>> let Qemu generate CPER record may be clear.
> 
> At boot UEFI in the guest will need to make sure the areas of memory that may be
> used for CPER records are reserved. Whether UEFI or Qemu decides where these are
> needs deciding, (but probably not here)...
> 
> At runtime, when an error has occurred, I agree it would be simpler (fewer
> components involved) if Qemu generates the CPER records. But if UEFI made the
> memory choice above they need to interact and it gets complicated again. The
> CPER records are defined in the UEFI spec, so I would expect UEFI to contain
> code to generate/parse them.
> 
> 
> Thanks,
> 
> James
> 
> 
> .
> 
