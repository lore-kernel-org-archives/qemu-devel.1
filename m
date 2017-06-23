Received: from eggs.gnu.org ([2001:4830:134:3::10]:35839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <viniciusfre@gmail.com>) id 1dOT6g-0003MT-5g
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 14:14:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <viniciusfre@gmail.com>) id 1dOT6e-0006kj-MH
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 14:14:58 -0400
Received: from mail-vk0-x230.google.com ([2607:f8b0:400c:c05::230]:34828)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <viniciusfre@gmail.com>)
	id 1dOT6e-0006kL-Gg
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 14:14:56 -0400
Received: by mail-vk0-x230.google.com with SMTP id 191so17472382vko.2
	for <qemu-devel@nongnu.org>; Fri, 23 Jun 2017 11:14:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAEz5UgGWxLNg+3Qg02H9Mpzkpy=MwP8YFYamZ8LdxK1gMuWq=g@mail.gmail.com>
References: <CAEz5UgEp8wRBxeg4nAAd9GVeihcXQv__jfrjQtnVNT8eTNCLOw@mail.gmail.com>
	<20170513182814.ydpkjeekvvjf5rzo@aurel32.net>
	<ecb7491d-6446-a9fa-49d1-f4aaade16470@amsat.org>
	<CAEz5UgGWxLNg+3Qg02H9Mpzkpy=MwP8YFYamZ8LdxK1gMuWq=g@mail.gmail.com>
From: Vinicius Maciel <viniciusfre@gmail.com>
Date: Fri, 23 Jun 2017 15:14:53 -0300
Message-ID: <CAEz5UgEQ1=RM2+v8ocUsZxA88jdk5Z+A0eo-G6=iD_CGoZQ2Sw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] MIPS little endian - Bug when decoding physaddr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Aurelien Jarno <aurelien@aurel32.net>, qemu-devel@nongnu.org

Hi everyone,

I'm having a problem similar to the reported in this email, but now I'm
trying to emulate a MIPS 24KEc,
ralink RT5350F.

Assembly Code:
0x802006a0 <reset+672>: lui t5,0xb011
0x802006a4 <reset+676>: ori t5,t5,0x168
0x802006a8 <reset+680>: li t6,23
0x802006ac <reset+684>: nop
0x802006b0 <reset+688>: sw t6,0(t5) <---

The instruction "sw t6,0(t5)" try to write to address 0xb0110168 (0x1011016=
8),
but Qemu decodes
this address to 2952790112 (0xb0000060). Is this address right?

Qemu Debug:
#0  io_readx (env=3D0x5555566e4a78, iotlbentry=3D0x5555566ec348,
addr=3D2952790112,
    retaddr=3D140737129226144, size=3D4)
    at /home/vini/projs/emuladores/qemu-routers/cputlb.c:786
#1  0x00005555557c9a02 in io_readl (env=3D0x5555566e4a78, mmu_idx=3D0, inde=
x=3D0,
    addr=3D2952790112, retaddr=3D140737129226144)
    at /home/vini/projs/emuladores/qemu-routers/softmmu_template.h:104
#2  0x00005555557c9b89 in helper_le_ldul_mmu (env=3D0x5555566e4a78,
addr=3D2952790112, <----
    oi=3D32, retaddr=3D140737129226144)
    at /home/vini/projs/emuladores/qemu-routers/softmmu_template.h:141
#3  0x00007fffea982108 in code_gen_buffer ()

Thanks.


2017-05-13 19:10 GMT-03:00 Vinicius Maciel <viniciusfre@gmail.com>:

> Hi Philippe and Aurelien,
>
> You are right. I have created a simple SYSBUS using sysbus_create_simple
> at 0x18000000 and now my read function works!
>
> Thanks for help. I am attaching my code if you are interested.
>
> Vinicius
>
> 2017-05-13 18:57 GMT-03:00 Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>:
>
>> Hi Vinicius,
>>
>> On 2017-05-12 19:52, Vinicius Maciel wrote:
>>>
>>>> Hi all,
>>>>
>>>> I'm trying to emulate a MIPS 74Kc using a custom machine in order to
>>>> run a
>>>> CFE bootloader from broadcom. The CPU is Broadcom BCM5357. The problem
>>>>
>>>
>> Here is your problem, there is no such model in QEMU.
>>
>> happens when Qemu calculates physaddr inside io_readx(), cputlb.c:line 7=
84
>>>>
>>>> physaddr =3D (physaddr & TARGET_PAGE_MASK) + addr;
>>>>
>>>> After run this line the the value is 0x18000000, which is clearly wron=
g.
>>>>
>>>
>> The Broadcom BCM5357 is a WiSoc (Wireless System-On-Chip).
>>
>> A SoC (System-On-Chip) is not limited to a MIPS CPU but has a large set
>> of embedded peripherals.
>>
>> QEMU does models the MIPS 74Kf cpu, but not the BCM5357 peripherals.
>>
>> At this physical address this SoC family maps a bus called
>> SiliconBackplane (BP).
>> The first peripheral mapped in the BP region is the ChipCommon (CC).
>> Common meaning this core registers intend to be consistent between
>> different models/releases using this BP bus, so a firmware can check it =
is
>> running the correct hardware or check if peripherals/features are
>> available/enabled to configure/use them.
>>
>> My guess is your CFE function board_earlyinit() is trying to determine
>> the chip model by reading the ChipID from the CC it supposed is physical=
ly
>> mapped at 0x18000000, which is not modeled in QEMU.
>>
>> Phil.
>>
>>
>>
>>> I don't think it's wrong, see below:
>>>
>>> More informations:
>>>>
>>>> BUG function: io_readx
>>>> Assembly instruction: lw t1,0(a2)
>>>> Machine code: 0x8cc90000 (Little endian)
>>>> Access address: 0xb8000000
>>>>
>>>> Assembly code:
>>>> 80702f30 <board_earlyinit>:
>>>> 80702f30: 3c06b800 lui a2,0xb800
>>>>
>>>
>>> This load 0xb8000000 in a2
>>>
>>> 80702f34: 24075350 li a3,21328
>>>> 80702f38: 8cc90000 lw t1,0(a2) <----
>>>>
>>>
>>> Now this try to load a value from the virtual address 0xb8000000. This
>>> address corresponds to kseg1 (Kernel Unmapped Uncached) and is mapped
>>> to the physical address 0x18000000. See the MIPS32 Privileged Resource
>>> Architecture Manual for more details how the virtual to physical mappin=
g
>>> works.
>>>
>>> Aurelien
>>>
>>>
>
