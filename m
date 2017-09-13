Received: from eggs.gnu.org ([2001:4830:134:3::10]:44484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1ds2Tw-00060d-NU
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 03:53:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1ds2Ts-0001jI-QT
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 03:53:12 -0400
References: <0184EA26B2509940AA629AE1405DD7F2015FE17F@DGGEMA503-MBX.china.huawei.com>
	<CAFEAcA8J5wZ23kQypzcbUScUResjWnN6rDG0b0idD1rv7F5Fsw@mail.gmail.com>
From: gengdongjiu <gengdongjiu@huawei.com>
Message-ID: <5552cf68-b998-686b-8e7e-710399c2b014@huawei.com>
Date: Wed, 13 Sep 2017 15:52:14 +0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8J5wZ23kQypzcbUScUResjWnN6rDG0b0idD1rv7F5Fsw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v11 6/6] target-arm: kvm64: Handle SError
 interrupt for the guest OS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, james.morse@arm.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Zhaoshenglong <zhaoshenglong@huawei.com>, Paolo
	Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, kvm-devel <kvm@vger.kernel.org>, "edk2-devel@lists.01.org" <edk2-devel@lists.01.org>, Christoffer Dall <christoffer.dall@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, Will
	Deacon <will.deacon@arm.com>, Tyler Baicar <tbaicar@codeaurora.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Ingo Molnar <mingo@kernel.org>, "bp@suse.de" <bp@suse.de>, Shiju Jose <shiju.jose@huawei.com>, "zjzhang@codeaurora.org" <zjzhang@codeaurora.org>, arm-mail-list <linux-arm-kernel@lists.infradead.org>, "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>, lkml -
	Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, John Garry <john.garry@huawei.com>, Jonathan Cameron <jonathan.cameron@huawei.com>, Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, huangdaode <huangdaode@hisilicon.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>, Huangshaoyu <huangshaoyu@huawei.com>, Wuquanming <wuquanming@huawei.com>, Linuxarm <linuxarm@huawei.com>, "Zhengqiang (turing)" <zhengqiang10@huawei.com>



On 2017/9/12 0:39, Peter Maydell wrote:
>>>> +    return  kvm_vcpu_ioctl(CPU(cpu), KVM_ARM_SEI, &syndrome);
>>> This looks odd. If we don't have the RAS extension why do we need to do anything at all here ?
>> This is because Qemu may need to support non-RAS extension as discussed with ARM James before.
>> That is to say host hardware CPU does not support RAS, but guest supports.
>> That is under discussion.
>> When host hardware supports RAS, specify the syndrome to a valid value, otherwise, set it to 0.
> If the guest CPU doesn't support the RAS extension then we have
> no mechanism for delivering it a notification about the
> memory problem at all, so setting the syndrome to anything
> doesn't make sense.
> 
> I'm not sure what you should do in the case of "host
> supports telling us about a memory problem and has
> done so, but guest does not support being told about it",
> but I'm pretty sure it shouldn't be this.
Hi peter,
   thanks for the comments.

   in short, if the hardware CPU does not support RAS extension, do you think whether the Qemu or guest OS
needs to support RAS(generate APEI table / record CPER / Error recovery).

CC James,

Hi James,
  you ever have below comments:

-----------------------------------------------------------------------
But you can use APEI in a guest on CPUs without the RAS extensions: the host may
signal memory errors to Qemu for any number of reasons.
------------------------------------------------------------------

in fact, I have a concern about it. If CPU without the RAS extension, the host should not deliver the sigbus.
in which case in your test that host still deliver sigbus without RAS?
