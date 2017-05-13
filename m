Received: from eggs.gnu.org ([2001:4830:134:3::10]:34113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d9f2K-0000P0-Rg
	for qemu-devel@nongnu.org; Sat, 13 May 2017 17:57:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d9f2F-0000Tx-Vx
	for qemu-devel@nongnu.org; Sat, 13 May 2017 17:57:16 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:36339)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d9f2F-0000Tg-S3
	for qemu-devel@nongnu.org; Sat, 13 May 2017 17:57:11 -0400
Received: by mail-qt0-x243.google.com with SMTP id j13so11073886qta.3
	for <qemu-devel@nongnu.org>; Sat, 13 May 2017 14:57:11 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <CAEz5UgEp8wRBxeg4nAAd9GVeihcXQv__jfrjQtnVNT8eTNCLOw@mail.gmail.com>
	<20170513182814.ydpkjeekvvjf5rzo@aurel32.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ecb7491d-6446-a9fa-49d1-f4aaade16470@amsat.org>
Date: Sat, 13 May 2017 18:57:07 -0300
MIME-Version: 1.0
In-Reply-To: <20170513182814.ydpkjeekvvjf5rzo@aurel32.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] MIPS little endian - Bug when decoding physaddr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, Vinicius Maciel <viniciusfre@gmail.com>
Cc: qemu-devel@nongnu.org

Hi Vinicius,

> On 2017-05-12 19:52, Vinicius Maciel wrote:
>> Hi all,
>>
>> I'm trying to emulate a MIPS 74Kc using a custom machine in order to run a
>> CFE bootloader from broadcom. The CPU is Broadcom BCM5357. The problem

Here is your problem, there is no such model in QEMU.

>> happens when Qemu calculates physaddr inside io_readx(), cputlb.c:line 784
>>
>> physaddr = (physaddr & TARGET_PAGE_MASK) + addr;
>>
>> After run this line the the value is 0x18000000, which is clearly wrong.

The Broadcom BCM5357 is a WiSoc (Wireless System-On-Chip).

A SoC (System-On-Chip) is not limited to a MIPS CPU but has a large set 
of embedded peripherals.

QEMU does models the MIPS 74Kf cpu, but not the BCM5357 peripherals.

At this physical address this SoC family maps a bus called 
SiliconBackplane (BP).
The first peripheral mapped in the BP region is the ChipCommon (CC). 
Common meaning this core registers intend to be consistent between 
different models/releases using this BP bus, so a firmware can check it 
is running the correct hardware or check if peripherals/features are 
available/enabled to configure/use them.

My guess is your CFE function board_earlyinit() is trying to determine 
the chip model by reading the ChipID from the CC it supposed is 
physically mapped at 0x18000000, which is not modeled in QEMU.

Phil.

>
> I don't think it's wrong, see below:
>
>> More informations:
>>
>> BUG function: io_readx
>> Assembly instruction: lw t1,0(a2)
>> Machine code: 0x8cc90000 (Little endian)
>> Access address: 0xb8000000
>>
>> Assembly code:
>> 80702f30 <board_earlyinit>:
>> 80702f30: 3c06b800 lui a2,0xb800
>
> This load 0xb8000000 in a2
>
>> 80702f34: 24075350 li a3,21328
>> 80702f38: 8cc90000 lw t1,0(a2) <----
>
> Now this try to load a value from the virtual address 0xb8000000. This
> address corresponds to kseg1 (Kernel Unmapped Uncached) and is mapped
> to the physical address 0x18000000. See the MIPS32 Privileged Resource
> Architecture Manual for more details how the virtual to physical mapping
> works.
>
> Aurelien
>
