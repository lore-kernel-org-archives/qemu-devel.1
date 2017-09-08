Received: from eggs.gnu.org ([2001:4830:134:3::10]:39028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dqM2p-0006dB-0g
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 12:22:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dqM2o-0004QL-3h
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 12:22:15 -0400
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:38791)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dqM2n-0004Q2-TB
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 12:22:14 -0400
Received: by mail-wr0-x22e.google.com with SMTP id 108so5542503wra.5
	for <qemu-devel@nongnu.org>; Fri, 08 Sep 2017 09:22:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <0184EA26B2509940AA629AE1405DD7F2015F5F11@DGGEMA503-MBX.china.huawei.com>
References: <0184EA26B2509940AA629AE1405DD7F2015F5F11@DGGEMA503-MBX.china.huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Sep 2017 17:21:52 +0100
Message-ID: <CAFEAcA8HPhHeeXEDtxnewJ7mAJ-gYzR96pC06qA+Xx95LHu2DA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v11 5/6] target-arm: kvm64: handle SIGBUS
 signal for synchronous External Abort
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: gengdongjiu <gengdongjiu@huawei.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Zhaoshenglong <zhaoshenglong@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, kvm-devel <kvm@vger.kernel.org>, "edk2-devel@lists.01.org" <edk2-devel@lists.01.org>, Christoffer Dall <christoffer.dall@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, Will Deacon <will.deacon@arm.com>, James Morse <james.morse@arm.com>, Tyler Baicar <tbaicar@codeaurora.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Ingo Molnar <mingo@kernel.org>, "bp@suse.de" <bp@suse.de>, Shiju Jose <shiju.jose@huawei.com>, "zjzhang@codeaurora.org" <zjzhang@codeaurora.org>, arm-mail-list <linux-arm-kernel@lists.infradead.org>, "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, John Garry <john.garry@huawei.com>, Jonathan Cameron <jonathan.cameron@huawei.com>, Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, huangdaode <huangdaode@hisilicon.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>, Huangshaoyu <huangshaoyu@huawei.com>, Wuquanming <wuquanming@huawei.com>, Linuxarm <linuxarm@huawei.com>, "Zhengqiang (turing)" <zhengqiang10@huawei.com>

On 8 September 2017 at 17:17, gengdongjiu <gengdongjiu@huawei.com> wrote:
>>
>> This code has all just been copied-and-pasted from target/i386/kvm.c.
>> Please instead abstract it out properly into a cpu-independent source file.
>
>
> Yes, it copied from x86.
> Do you mean abstracting this code to a common folder so that i386 and arm platform share it?

I mean it should go into a common source file (perhaps
accel/kvm/kvm-all.c).


>> What is this ??? You should never need to look up things in the cpreg arrays by fieldoffset.
>
>
> I used it to set the esr_el1's and far_el1's value, for example:
>
>   /* set ESR_EL1 */
>   ret = kvm_arm_cpreg_value(cpu, offsetof(CPUARMState, cp15.esr_el[1]));
>
>   /* set FAR_EL1 */
>   ret = kvm_arm_cpreg_value(cpu, offsetof(CPUARMState, cp15.far_el[1]));

Yes, I saw that, but I have no idea why you think that's
the right way to set register values. No other code in
QEMU does this.

> So use the added API kvm_arm_cpreg_value() to set their value.
> If not used it, do you better method to set their value?

I suggest:

>> The code for handling debug exits (software step, watchpoint,
>> etc) is probably a good place to look for how to deal with register state.

>> Any new globally-visible function prototype in a header should
>> have a doc-comment formatted documentation comment, please.
>
>
> Ok, thanks for this reminder. Do you mean I need to add comments
> for this globally-visible function, such as below:
>
> /*
>  * xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
>  */
> void kvm_hwpoison_page_add(ram_addr_t ram_addr);

It should be in the doc-comment format, which begins
"/**" and has some stylization of how you list parameters
and so on. Lots of examples in the existing headers.

thanks
-- PMM
