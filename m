Received: from eggs.gnu.org ([2001:4830:134:3::10]:37599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ds5Ht-0000H0-U8
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 06:52:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ds5Hs-0005Tn-Ty
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 06:52:58 -0400
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:35357)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ds5Hs-0005Sa-JF
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 06:52:56 -0400
Received: by mail-wr0-x230.google.com with SMTP id m18so27941909wrm.2
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 03:52:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5552cf68-b998-686b-8e7e-710399c2b014@huawei.com>
References: <0184EA26B2509940AA629AE1405DD7F2015FE17F@DGGEMA503-MBX.china.huawei.com>
	<CAFEAcA8J5wZ23kQypzcbUScUResjWnN6rDG0b0idD1rv7F5Fsw@mail.gmail.com>
	<5552cf68-b998-686b-8e7e-710399c2b014@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 13 Sep 2017 11:52:34 +0100
Message-ID: <CAFEAcA_zO_-kDYb0MkW=p5oY6tQPk4PpCqZoG0_01pn=sa3upw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: gengdongjiu <gengdongjiu@huawei.com>
Cc: James Morse <james.morse@arm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Zhaoshenglong <zhaoshenglong@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, kvm-devel <kvm@vger.kernel.org>, "edk2-devel@lists.01.org" <edk2-devel@lists.01.org>, Christoffer Dall <christoffer.dall@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, Will Deacon <will.deacon@arm.com>, Tyler Baicar <tbaicar@codeaurora.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Ingo Molnar <mingo@kernel.org>, "bp@suse.de" <bp@suse.de>, Shiju Jose <shiju.jose@huawei.com>, "zjzhang@codeaurora.org" <zjzhang@codeaurora.org>, arm-mail-list <linux-arm-kernel@lists.infradead.org>, "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, John Garry <john.garry@huawei.com>, Jonathan Cameron <jonathan.cameron@huawei.com>, Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, huangdaode <huangdaode@hisilicon.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>, Huangshaoyu <huangshaoyu@huawei.com>, Wuquanming <wuquanming@huawei.com>, Linuxarm <linuxarm@huawei.com>, "Zhengqiang (turing)" <zhengqiang10@huawei.com>

On 13 September 2017 at 08:52, gengdongjiu <gengdongjiu@huawei.com> wrote:
>
>
> On 2017/9/12 0:39, Peter Maydell wrote:
>>>>> +    return  kvm_vcpu_ioctl(CPU(cpu), KVM_ARM_SEI, &syndrome);
>>>> This looks odd. If we don't have the RAS extension why do we need to do anything at all here ?
>>> This is because Qemu may need to support non-RAS extension as discussed with ARM James before.
>>> That is to say host hardware CPU does not support RAS, but guest supports.
>>> That is under discussion.
>>> When host hardware supports RAS, specify the syndrome to a valid value, otherwise, set it to 0.
>> If the guest CPU doesn't support the RAS extension then we have
>> no mechanism for delivering it a notification about the
>> memory problem at all, so setting the syndrome to anything
>> doesn't make sense.
>>
>> I'm not sure what you should do in the case of "host
>> supports telling us about a memory problem and has
>> done so, but guest does not support being told about it",
>> but I'm pretty sure it shouldn't be this.

>    in short, if the hardware CPU does not support RAS extension, do you think whether the Qemu or guest OS
> needs to support RAS(generate APEI table / record CPER / Error recovery).

This question seems to be not really related to the review
comment that it is responding to.

(1) If the host does not support notifying us about
errors, then there is clearly nothing to do in this
code, because we will never get a notification.

(2) If the host does support notifying us about errors,
but we choose not to expose RAS to the guest, then
there's not much to do either. We probably just want
to take whatever the default behaviour is for any
application when it touches memory that's bad.
We definitely don't want to tell the guest anything.

(3) If the host supports notification, and we choose
to expose RAS to the guest, then we need to do
whatever we have to do to notify the guest.

If we're in this signal handler and also
arm_feature(env, ARM_FEATURE_RAS) is false then that
is case (2), and my point is that doing anything with
the guest 'syndrome' value looks like the wrong thing.

thanks
-- PMM
