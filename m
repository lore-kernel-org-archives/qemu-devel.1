Received: from eggs.gnu.org ([2001:4830:134:3::10]:41161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gengdj.1984@gmail.com>) id 1ctEiU-0008U4-Tp
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 10:36:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gengdj.1984@gmail.com>) id 1ctEiT-00028M-Jf
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 10:36:54 -0400
Received: from mail-yw0-x244.google.com ([2607:f8b0:4002:c05::244]:33655)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <gengdj.1984@gmail.com>)
	id 1ctEiT-00027i-Eu
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 10:36:53 -0400
Received: by mail-yw0-x244.google.com with SMTP id p77so1755777ywg.0
	for <qemu-devel@nongnu.org>; Wed, 29 Mar 2017 07:36:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170329103658.GQ23682@e104320-lin>
References: <76795e20-2f20-1e54-cfa5-7444f28b18ee@huawei.com>
	<20170321113428.GC15920@cbox> <58D17AF0.2010802@arm.com>
	<20170321193933.GB31111@cbox>
	<58DA3F68.6090901@arm.com> <20170328112328.GA31156@cbox>
	<20170328115413.GJ23682@e104320-lin>
	<b1c6e747-2fa7-b7a1-60d5-4a9c480b9dc9@huawei.com>
	<58DA67BA.8070404@arm.com>
	<5b7352f4-4965-3ed5-3879-db871797be47@huawei.com>
	<20170329103658.GQ23682@e104320-lin>
From: gengdongjiu <gengdj.1984@gmail.com>
Date: Wed, 29 Mar 2017 22:36:51 +0800
Message-ID: <CAMj-D2BT3ByY-iFrRVVK7y=G7zhRBtM031VgLn6JzwUE-WCdWQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
To: Achin Gupta <achin.gupta@arm.com>
Cc: gengdongjiu <gengdongjiu@huawei.com>, lersek@redhat.com, ard.biesheuvel@linaro.org, edk2-devel@lists.01.org, qemu-devel@nongnu.org, zhaoshenglong@huawei.com, James Morse <james.morse@arm.com>, Christoffer Dall <cdall@linaro.org>, xiexiuqi@huawei.com, Marc Zyngier <marc.zyngier@arm.com>, catalin.marinas@arm.com, will.deacon@arm.com, christoffer.dall@linaro.org, rkrcmar@redhat.com, suzuki.poulose@arm.com, andre.przywara@arm.com, mark.rutland@arm.com, vladimir.murzin@arm.com, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, wangxiongfeng2@huawei.com, wuquanming@huawei.com, huangshaoyu@huawei.com, Leif.Lindholm@linaro.comnd@arm.com

Hi Achin,
  Thanks for your mail and  answer.

2017-03-29 18:36 GMT+08:00, Achin Gupta <achin.gupta@arm.com>:
> Hi gengdongjiu,
>
> On Wed, Mar 29, 2017 at 05:36:37PM +0800, gengdongjiu wrote:
>>
>> Hi Laszlo/Biesheuvel/Qemu developer,
>>
>>    Now I encounter a issue and want to consult with you in ARM64 platfor=
m=EF=BC=8C
>> as described below:
>>
>>    when guest OS happen synchronous or asynchronous abort, kvm needs to
>> send the error address to Qemu or UEFI through sigbus to dynamically
>> generate APEI table. from my investigation, there are two ways:
>>
>>    (1) Qemu get the error address, and generate the APEI table, then
>> notify UEFI to know this generation, then inject abort error to guest OS=
,
>> guest OS read the APEI table.
>>    (2) Qemu get the error address, and let UEFI to generate the APEI
>> table, then inject abort error to guest OS, guest OS read the APEI table=
.

The description may be not precise, I update it

   (1) Qemu get the error address, and generate the CPER table, then
notify guest UEFI to place this CPER table to Guest OS memory, then
Qemu let KVM inject abort error to guest OS, guest OS read the CPER
table.

 (2) Qemu get the error address, and let guest UEFI to directly
generate the CPER
table and place this table to the guest OS memory, not let Qemu gerate
it. then KVM inject abort error to guest OS, guest OS read the CPER
table.

>
> Just being pedantic! I don't think we are talking about creating the APEI
> table
> dynamically here. The issue is: Once KVM has received an error that is
> destined
> for a guest it will raise a SIGBUS to Qemu. Now before Qemu can inject th=
e
> error
> into the guest OS, a CPER (Common Platform Error Record) has to be
> generated
> corresponding to the error source (GHES corresponding to memory subsystem=
,
> processor etc) to allow the guest OS to do anything meaningful with the
> error. So who should create the CPER is the question.
>
> At the EL3/EL2 interface (Secure Firmware and OS/Hypervisor), an error
> arrives
> at EL3 and secure firmware (at EL3 or a lower secure exception level) is
> responsible for creating the CPER. ARM is experimenting with using a
> Standalone
> MM EDK2 image in the secure world to do the CPER creation. This will avoi=
d
> adding the same code in ARM TF in EL3 (better for security). The error wi=
ll
> then
> be injected into the OS/Hypervisor (through SEA/SEI/SDEI) through ARM
> Trusted
> Firmware.
>
> Qemu is essentially fulfilling the role of secure firmware at the EL2/EL1
> interface (as discussed with Christoffer below). So it should generate th=
e
> CPER
> before injecting the error.
>
> This is corresponds to (1) above apart from notifying UEFI (I am assuming
> you
> mean guest UEFI). At this time, the guest OS already knows where to pick =
up
> the
> CPER from through the HEST. Qemu has to create the CPER and populate its
> address
> at the address exported in the HEST. Guest UEFI should not be involved in
> this
> flow. Its job was to create the HEST at boot and that has been done by th=
is
> stage.

 Sorry,  As I understand it, after Qemu generate the CPER table, it
should pass the CPER table to the guest UEFI, then Guest UEFI  place
this CPER table to the guest OS memory. In this flow, the Guest UEFI
should be involved, else the Guest OS can not see the CPER table.

>
> Qemu folk will be able to add but it looks like support for CPER generati=
on
> will
> need to be added to Qemu. We need to resolve this.
>
> Do shout if I am missing anything above.
>
> cheers,
> Achin
>
>
>>
>>
>>    Do you think which modules generates the APEI table is better? UEFI o=
r
>> Qemu?
>>
>>
>>
>>
>> On 2017/3/28 21:40, James Morse wrote:
>> > Hi gengdongjiu,
>> >
>> > On 28/03/17 13:16, gengdongjiu wrote:
>> >> On 2017/3/28 19:54, Achin Gupta wrote:
>> >>> On Tue, Mar 28, 2017 at 01:23:28PM +0200, Christoffer Dall wrote:
>> >>>> On Tue, Mar 28, 2017 at 11:48:08AM +0100, James Morse wrote:
>> >>>>> On the host, part of UEFI is involved to generate the CPER records=
.
>> >>>>> In a guest?, I don't know.
>> >>>>> Qemu could generate the records, or drive some other component to =
do
>> >>>>> it.
>> >>>>
>> >>>> I think I am beginning to understand this a bit.  Since the guet
>> >>>> UEFI
>> >>>> instance is specifically built for the machine it runs on, QEMU's
>> >>>> virt
>> >>>> machine in this case, they could simply agree (by some contract) to
>> >>>> place the records at some specific location in memory, and if the
>> >>>> guest
>> >>>> kernel asks its guest UEFI for that location, things should just wo=
rk
>> >>>> by
>> >>>> having logic in QEMU to process error reports and populate guest
>> >>>> memory.
>> >>>>
>> >>>> Is this how others see the world too?
>> >>>
>> >>> I think so!
>> >>>
>> >>> AFAIU, the memory where CPERs will reside should be specified in a
>> >>> GHES entry in
>> >>> the HEST. Is this not the case with a guest kernel i.e. the guest UE=
FI
>> >>> creates a
>> >>> HEST for the guest Kernel?
>> >>>
>> >>> If so, then the question is how the guest UEFI finds out where QEMU
>> >>> (acting as
>> >>> EL3 firmware) will populate the CPERs. This could either be a contra=
ct
>> >>> between
>> >>> the two or a guest DXE driver uses the MM_COMMUNICATE call (see [1])
>> >>> to ask QEMU
>> >>> where the memory is.
>> >>
>> >> whether invoke the guest UEFI will be complex? not see the advantage.
>> >> it seems x86 Qemu
>> >> directly generate the ACPI table, but I am not sure, we are checking
>> >> the qemu
>> > logical.
>> >> let Qemu generate CPER record may be clear.
>> >
>> > At boot UEFI in the guest will need to make sure the areas of memory
>> > that may be
>> > used for CPER records are reserved. Whether UEFI or Qemu decides where
>> > these are
>> > needs deciding, (but probably not here)...
>> >
>> > At runtime, when an error has occurred, I agree it would be simpler
>> > (fewer
>> > components involved) if Qemu generates the CPER records. But if UEFI
>> > made the
>> > memory choice above they need to interact and it gets complicated agai=
n.
>> > The
>> > CPER records are defined in the UEFI spec, so I would expect UEFI to
>> > contain
>> > code to generate/parse them.
>> >
>> >
>> > Thanks,
>> >
>> > James
>> >
>> >
>> > .
>> >
>>
>
