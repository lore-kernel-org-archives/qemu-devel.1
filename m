Received: from eggs.gnu.org ([2001:4830:134:3::10]:55812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <punit.agrawal@arm.com>) id 1ctE5y-0000hx-7a
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 09:57:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <punit.agrawal@arm.com>) id 1ctE5l-0002yA-PS
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 09:57:06 -0400
Received: from foss.arm.com ([217.140.101.70]:41526)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <punit.agrawal@arm.com>) id 1ctE5l-0002uy-JB
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 09:56:53 -0400
From: Punit Agrawal <punit.agrawal@arm.com>
References: <58D17AF0.2010802@arm.com> <20170321193933.GB31111@cbox>
	<58DA3F68.6090901@arm.com> <20170328112328.GA31156@cbox>
	<20170328115413.GJ23682@e104320-lin>
	<b1c6e747-2fa7-b7a1-60d5-4a9c480b9dc9@huawei.com>
	<58DA67BA.8070404@arm.com>
	<5b7352f4-4965-3ed5-3879-db871797be47@huawei.com>
	<20170329103658.GQ23682@e104320-lin>
	<2a427164-9b37-6711-3a56-906634ba7f12@redhat.com>
	<20170329154539-mutt-send-email-mst@kernel.org>
	<756e3032-e619-a70d-3e29-d2797e52fecf@redhat.com>
Date: Wed, 29 Mar 2017 14:56:48 +0100
In-Reply-To: <756e3032-e619-a70d-3e29-d2797e52fecf@redhat.com> (Laszlo Ersek's
	message of "Wed, 29 Mar 2017 15:36:59 +0200")
Message-ID: <87vaqsdw4f.fsf@e105922-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Laszlo Ersek <lersek@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org, catalin.marinas@arm.com, Achin Gupta <achin.gupta@arm.com>, will.deacon@arm.com, qemu-devel@nongnu.org, wuquanming@huawei.com, kvmarm@lists.cs.columbia.edu, Christoffer Dall <cdall@linaro.org>, gengdongjiu <gengdongjiu@huawei.com>, Leif.Lindholm@linaro.com, huangshaoyu@huawei.com, Marc Zyngier <marc.zyngier@arm.com>, andre.przywara@arm.com, edk2-devel@lists.01.org, wangxiongfeng2@huawei.com, nd@arm.com, linux-arm-kernel@lists.infradead.org, ard.biesheuvel@linaro.org, linux-kernel@vger.kernel.org, Igor Mammedov <imammedo@redhat.com>

Laszlo Ersek <lersek@redhat.com> writes:

> On 03/29/17 14:51, Michael S. Tsirkin wrote:
>> On Wed, Mar 29, 2017 at 01:58:29PM +0200, Laszlo Ersek wrote:
>>> (8) When QEMU gets SIGBUS from the kernel -- I hope that's going to come
>>> through a signalfd -- QEMU can format the CPER right into guest memory,
>>> and then inject whatever interrupt (or assert whatever GPIO line) is
>>> necessary for notifying the guest.
>> 
>> I think I see a race condition potential - what if guest accesses
>> CPER in guest memory while it's being written?
>
> I'm not entirely sure about the data flow here (these parts of the ACPI
> spec are particularly hard to read...), but I thought the OS wouldn't
> look until it got a notification.
>
> Or, are you concerned about the next CPER write by QEMU, while the OS is
> reading the last one (and maybe the CPER area could wrap around?)
>
>> 
>> We can probably use another level of indirection to fix this:
>> 
>> allocate twice the space, add a pointer to where the valid
>> table is located and update that after writing CPER completely.
>> The pointer can be written atomically but also needs to
>> be read atomically, so I suspect it should be a single byte
>> as we don't know how are OSPMs implementing this.
>> 
>
> A-B-A problem? (Is that usually solved with a cookie or a wider
> generation counter? But that would again require wider atomics.)
>
> I do wonder though how this is handled on physical hardware. Assuming
> the hardware error traps to the firmware first (which, on phys hw, is
> responsible for depositing the CPER), in that scenario the phys firmware
> would face the same issue (i.e., asynchronously interrupting the OS,
> which could be reading the previously stored CPER).

Not sure about other error sources but for GHESv2 (ACPI 6.1, Section
18.3.2.8) the OS is expected to acknowledge the error before the
firmware is allowed to reuse the memory.

>
> Thanks,
> Laszlo
> _______________________________________________
> kvmarm mailing list
> kvmarm@lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
