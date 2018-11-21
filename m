Received: from eggs.gnu.org ([2001:4830:134:3::10]:54641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gPamy-0003zq-Lb
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:16:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gPams-0004GC-JB
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:16:04 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:42117)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gPamo-0004Ba-Kp
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:15:56 -0500
Received: by mail-pl1-x641.google.com with SMTP id x21-v6so7376791pln.9
	for <qemu-devel@nongnu.org>; Wed, 21 Nov 2018 14:15:54 -0800 (PST)
Date: Wed, 21 Nov 2018 14:15:52 -0800 (PST)
In-Reply-To: <CAKmqyKM2pmF_D812mp1hcJe8KcLGiNz9vLpy7OpsbS0XxNwo+w@mail.gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-39e17271-363f-4e08-ba7e-779c2f46b54f@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-3.2 v7 5/6] hw/riscv/sifive_u: Connect
 the Xilinx PCIe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alistair23@gmail.com
Cc: logang@deltatee.com, qemu-riscv@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>, qemu-devel@nongnu.org, linux@roeck-us.net, abologna@redhat.com

On Wed, 21 Nov 2018 13:49:53 PST (-0800), alistair23@gmail.com wrote:
> On Wed, Nov 21, 2018 at 1:26 PM Palmer Dabbelt <palmer@sifive.com> wrote:
>>
>> On Wed, 21 Nov 2018 10:32:45 PST (-0800), alistair23@gmail.com wrote:
>> > On Wed, Nov 21, 2018 at 10:05 AM Logan Gunthorpe <logang@deltatee.com> wrote:
>> >>
>> >>
>> >>
>> >> On 2018-11-21 10:02 a.m., Alistair Francis wrote:
>> >> > Connect the Xilinx PCIe device based on the information in the device
>> >> > tree stored in the ROM of the HiFish Unleashed board.
>> >>
>> >> I only briefly tested this patch but could not get any PCI devices to
>> >> come up with the sifive_u machine. Depending on the kernel I tried, it
>> >> either failed to initialize a Xilinx PCIe (likely due to a mismatch with
>> >> the DT) or it appears to successfully initialize a Microsemi device but
>> >> did not enumerate any devices underneath.
>> >
>> > That seems like either a kernel or bbl issue.
>> >
>> > You need to make sure that bbl doesn't edit the device tree (to add
>> > the Microsemi device or remove the Xilinx one) and ensure your kernel
>> > supports the Xilinx one.
>> >
>> >>
>> >> In any case, it would be nice if the Microsemi/Xilinx confusion was at
>> >> least explained in the commit message.
>> >
>> > What should we say? The QEMU machine accurately models the real
>> > hardware which reports a Xilinx PCIe. The confusion generally appears
>> > above QEMU where people are used to using the MicroSemi one.
>>
>> I think the real issue here is that "sifive_u" doesn't actually fully describe
>> the device we're trying to emulate.  Is it a:
>>
>> * Generic SiFive U core?  In that case we just have a 64-bit core and
>>   essentially no devices.  This is kind of useless.
>> * A HiFive Unleashed?  In that case there's no PCIe, as it requires an
>>   expansion board.
>> * A HiFive Unleashed + VC707?  Here we have Xilinx PCIe.
>> * A HiFive Unleashed + Microsemi Expansion?  Here have Microsemi PCIe.
>
> This isn't even always consistent. For example the sifive_u machine
> exists for 32-bit cores, but the PCIe address reported by the hardware
> only works for 64-bit machines.
>
> So we need a trade off between accurately modelling the hardware or
> having 32-bit support.

Yep, there's another issue.

>> There's a tradeoff between accurately emulating the hardware and blowing up the
>> amount of targets we support in QEMU.  We went through this discussion before
>> and ended up where we are now, but maybe it's best to go have the discussion
>> again?
>
> Up to you, it is your board :)
>
> I think it makes more sense to remove these generic boards (that is
> what the virt board is for) and model real hardware boards.

That seems reasonable to me.  Is removing boards allowed?  If so I'd be OK 
renaming these to "sifive-hifive1" and "sifive-hifive-unleashed", and possibly 
adding a "sifive-hifive-unleashed-vc707" as it's possible to emulate most of 
that.  Then we at least have accurate names for the boards.

We do have an issue where I'd like to be able to have some system by which we 
can configure the memory map of the target, but maybe that's separate 
discussion.
