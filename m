Received: from eggs.gnu.org ([2001:4830:134:3::10]:40674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gPa8F-0005fw-8u
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 16:34:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gPa1U-0001Lo-2y
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 16:27:03 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:38280)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gPa1S-0001Jo-3e
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 16:27:00 -0500
Received: by mail-pl1-x644.google.com with SMTP id e5so7238564plb.5
	for <qemu-devel@nongnu.org>; Wed, 21 Nov 2018 13:26:56 -0800 (PST)
Date: Wed, 21 Nov 2018 13:26:54 -0800 (PST)
In-Reply-To: <CAKmqyKMtTqi=D-PKZFnt40MaA8+e6Sj8nUr0VmBFajScw1MYng@mail.gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-ac7d7069-f2ae-45b5-a950-17410b48481f@palmer-si-x1c4>
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

On Wed, 21 Nov 2018 10:32:45 PST (-0800), alistair23@gmail.com wrote:
> On Wed, Nov 21, 2018 at 10:05 AM Logan Gunthorpe <logang@deltatee.com> wrote:
>>
>>
>>
>> On 2018-11-21 10:02 a.m., Alistair Francis wrote:
>> > Connect the Xilinx PCIe device based on the information in the device
>> > tree stored in the ROM of the HiFish Unleashed board.
>>
>> I only briefly tested this patch but could not get any PCI devices to
>> come up with the sifive_u machine. Depending on the kernel I tried, it
>> either failed to initialize a Xilinx PCIe (likely due to a mismatch with
>> the DT) or it appears to successfully initialize a Microsemi device but
>> did not enumerate any devices underneath.
>
> That seems like either a kernel or bbl issue.
>
> You need to make sure that bbl doesn't edit the device tree (to add
> the Microsemi device or remove the Xilinx one) and ensure your kernel
> supports the Xilinx one.
>
>>
>> In any case, it would be nice if the Microsemi/Xilinx confusion was at
>> least explained in the commit message.
>
> What should we say? The QEMU machine accurately models the real
> hardware which reports a Xilinx PCIe. The confusion generally appears
> above QEMU where people are used to using the MicroSemi one.

I think the real issue here is that "sifive_u" doesn't actually fully describe 
the device we're trying to emulate.  Is it a:

* Generic SiFive U core?  In that case we just have a 64-bit core and 
  essentially no devices.  This is kind of useless.
* A HiFive Unleashed?  In that case there's no PCIe, as it requires an 
  expansion board.
* A HiFive Unleashed + VC707?  Here we have Xilinx PCIe.
* A HiFive Unleashed + Microsemi Expansion?  Here have Microsemi PCIe.

There's a tradeoff between accurately emulating the hardware and blowing up the 
amount of targets we support in QEMU.  We went through this discussion before 
and ended up where we are now, but maybe it's best to go have the discussion 
again?
