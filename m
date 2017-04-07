Received: from eggs.gnu.org ([2001:4830:134:3::10]:57816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cwQ5c-0006Co-8Z
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 05:21:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cwQ5X-0006yG-H5
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 05:21:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47844)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cwQ5X-0006y8-8Z
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 05:21:51 -0400
References: <76795e20-2f20-1e54-cfa5-7444f28b18ee@huawei.com>
	<20170321113428.GC15920@cbox> <58D17AF0.2010802@arm.com>
	<20170321193933.GB31111@cbox> <58DA3F68.6090901@arm.com>
	<20170328112328.GA31156@cbox> <20170328115413.GJ23682@e104320-lin>
	<b1c6e747-2fa7-b7a1-60d5-4a9c480b9dc9@huawei.com>
	<58DA67BA.8070404@arm.com>
	<5b7352f4-4965-3ed5-3879-db871797be47@huawei.com>
	<20170329103658.GQ23682@e104320-lin>
	<2a427164-9b37-6711-3a56-906634ba7f12@redhat.com>
	<7c5c8ab7-8fcc-1c98-0bc1-cccb66c4c84d@huawei.com>
	<6ac1597a-2ed5-36b2-848d-5fd048b16d66@redhat.com>
	<55546a4b-c33b-37b9-dafe-15ce75bc1b62@huawei.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <09c64b28-5eb5-4efd-6cb8-035b69313a99@redhat.com>
Date: Fri, 7 Apr 2017 11:21:41 +0200
MIME-Version: 1.0
In-Reply-To: <55546a4b-c33b-37b9-dafe-15ce75bc1b62@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
To: gengdongjiu <gengdongjiu@huawei.com>, Achin Gupta <achin.gupta@arm.com>
Cc: ard.biesheuvel@linaro.org, edk2-devel@lists.01.org, qemu-devel@nongnu.org, zhaoshenglong@huawei.com, James Morse <james.morse@arm.com>, Christoffer Dall <cdall@linaro.org>, xiexiuqi@huawei.com, Marc Zyngier <marc.zyngier@arm.com>, catalin.marinas@arm.com, will.deacon@arm.com, christoffer.dall@linaro.org, rkrcmar@redhat.com, suzuki.poulose@arm.com, andre.przywara@arm.com, mark.rutland@arm.com, vladimir.murzin@arm.com, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, wangxiongfeng2@huawei.com, wuquanming@huawei.com, huangshaoyu@huawei.com, Leif.Lindholm@linaro.comnd@arm.com, Michael Tsirkin <mtsirkin@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On 04/07/17 04:52, gengdongjiu wrote:
> 
> On 2017/4/7 2:55, Laszlo Ersek wrote:

>> I'm unsure if, by "not fixed", you are saying
>>
>>   the number of CPER entries that fits in Error Status Data Block N is
>>   not *uniform* across 0 <= N <= 10 [1]
>>
>> or
>>
>>   the number of CPER entries that fits in Error Status Data Block N is
>>   not *known* in advance, for all of 0 <= N <= 10 [2]
>>
>> Which one is your point?
>>
>> If [1], that's no problem; you can simply sum the individual error
>> status data block sizes in advance, and allocate "etc/hardware_errors"
>> accordingly, using the total size.
>>
>> (Allocating one shared fw_cfg blob for all status data blocks is more
>> memory efficient, as each ALLOCATE command will allocate whole pages
>> (rounded up from the actual blob size).)
>>
>> If your point is [2], then splitting the error status data blocks to
>> separate fw_cfg blobs makes no difference: regardless of whether we try
>> to place all the error status data blocks in a single fw_cfg blob, or in
>> separate fw_cfg blobs, the individual data block cannot be resized at OS
>> runtime, so there's no way to make it work.
>>
> My Point is [2]. The HEST(Hardware Error Source Table) table format is here:
> https://wiki.linaro.org/LEG/Engineering/Kernel/RAS/APEITables#Hardware_Error_Source_Table_.28HEST.29
> 
> Now I understand your thought.

But if you mean [2], then I am confused, with regard to firmware on
physical hardware. Namely, even on physical machines, the firmware has
to estimate, in advance, the area size that will be needed for CPERs,
doesn't it? And once the firmware allocates that memory area, it cannot
be resized at OS runtime. If there are more CPERs at runtime (due to
hardware errors) than the firmware allocated room for, they must surely
wrap around in the preallocated buffer (like in a ring buffer). Isn't
that correct?

On the diagrams that you linked above (great looking diagrams BTW!), I
see CPER in two places (it is helpfully shaded red):

- to the right of BERT; the CPER is part of a box that is captioned
"firmware reserved memory"

- to the right of HEST; again the CPER is part of a box that is
captioned "firmware reserved memory"

So, IMO, when QEMU has to guesstimate the room for CPERs in advance,
that doesn't differ from the physical firmware case. In QEMU maybe you
can let the user specify the area size on the command line, with a
machine type property or similar.

Thanks
Laszlo
