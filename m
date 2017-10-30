Received: from eggs.gnu.org ([2001:4830:134:3::10]:54846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1e96Dz-0006k6-Kf
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 05:19:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1e96Du-0005d1-LF
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 05:19:15 -0400
Received: from mel.act-europe.fr ([194.98.77.210]:58672
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1e96Du-0005bb-66
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 05:19:10 -0400
References: <cover.1508885974.git.pisa@cmp.felk.cvut.cz>
	<28f27d84714abd1e85144a5679eaa3147f4ca023.1508885974.git.pisa@cmp.felk.cvut.cz>
	<35454964-58da-e9d1-f960-c7cff8a9e054@adacore.com>
	<201710292343.11885.pisa@cmp.felk.cvut.cz>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <5a436a93-9538-e61b-32ef-4e92b5aad499@adacore.com>
Date: Mon, 30 Oct 2017 10:19:03 +0100
MIME-Version: 1.0
In-Reply-To: <201710292343.11885.pisa@cmp.felk.cvut.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/6] CAN bus simple SJA1000 PCI card
 emulation for QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc: qemu-devel@nongnu.org, Marek Vasut <marex@denx.de>, Stefan Hajnoczi <stefanha@gmail.com>, Deniz Eren <deniz.eren@icloud.com>, Jan Kiszka <jan.kiszka@siemens.com>, Oliver Hartkopp <socketcan@hartkopp.net>



On 10/29/2017 11:43 PM, Pavel Pisa wrote:
> Hello Fred,
> 
> thanks much for review and remarks.
> 
> On Friday 27 of October 2017 16:18:31 KONRAD Frederic wrote:
>> Hi Pavel,
>>
>> On 10/25/2017 01:12 AM, pisa@cmp.felk.cvut.cz wrote:
>>> From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
>>>
>>> The work is based on Jin Yang GSoC 2013 work funded
>>> by Google and mentored in frame of RTEMS project GSoC
>>> slot donated to QEMU.
>>>
>>> Rewritten for QEMU-2.0+ versions and architecture cleanup
>>> by Pavel Pisa (Czech Technical University in Prague).
>>>
>>> The core SJA1000 support is independent of provided
>>> PCI board. The simple core CAN bus infrastructure
>>> is independent as well.
>>>
>>> Connection to the real host CAN bus network through
>>> SocketCAN network interface is available for Linux
>>> host system as well.
>>>
>>> Signed-off-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
>>> ---
>>>    default-configs/pci.mak |   2 +
>>>    hw/Makefile.objs        |   1 +
>>>    hw/can/Makefile.objs    |   5 +
>>>    hw/can/can_core.c       | 374 +++++++++++++++++++
>>
>> Correct me if I'm wrong but this file above doesn't introduce
>> SJA1000 PCI board? If not it should be in a separate patch.
> 
> May be it would worth to make patches more finegrained.
> But on the other hand initial CAN support is not so
> large and keeping one complete emulation in single
> example board in initial patch can be better to read.

Thing is having huge patches is a pain for reviewers.
So having one patch per purpose is the better choice.

> 
> Logical finegrained division is
> 
> CAN bus emulation core functions and connection to Linux SocketCAN host
>    include/can/can_emu.h
>    hw/can/can_core.c
> 
> CAN bus basic SJA1000 chip register level emulation
>    hw/can/can_sja1000.c
>    hw/can/can_sja1000.h
> 
> CAN bus simple SJA1000 memory mapped PCI card example
>    hw/can/can_pci.c
> This one is questionable, because it exists only for testing
> and uses some random VID DID.
> Do you suggest to omit it now when real world compatible
> HW is included by next patches.
> 
> CAN bus Kvaser PCI CAN-S (single SJA1000 channel) emulation added.
>    hw/can/can_kvaser_pci.c
> 
> CAN bus PCM-3680I PCI (dual SJA1000 channel) emulation added.
>    hw/can/can_pcm3680_pci.c
> 
> CAN bus MIOe-3680 PCI (dual SJA1000 channel) emulation added.
>    hw/can/can_mioe3680_pci.c
> 
> If you think that this is more logical even that the first
> commits introduce something which cannot be tested/compiles
> only into library, then I rearrange patchyes this way.

I don't know all those PCI cards. But if the simple SJA1000
doesn't exist in real life maybe better dropping it?

> 
>>> +#ifdef DEBUG_CAN
>>> +static void can_display_msg(struct qemu_can_frame *msg)
>>> +{
>>> +    int i;
>>> +
>>> +    printf("%03X [%01d]:", (msg->can_id & 0x1fffffff), msg->can_dlc);
>>> +    for (i = 0; i < msg->can_dlc; i++) {
>>> +        printf("  %02X", msg->data[i]);
>>> +    }
>>> +    printf("\n");
>>> +}
>>> +#endif
>>
>> This might bitrot, I suggest doing something like
>>
>> #ifndef DEBUG_CAN
>> #define DEBUG_CAN 0
>> #endif /* DEBUG_CAN */
>>
>> and then
>>
>> if (DEBUG_CAN) {
>>     printf(...);
>>     ...
>> }
>>
>> so it's compiled/checked anyway.
> 
> OK, makes sense. Hopefully GCC doe not start to warn
> about (intentionally) dead code.
> 
> I would wait one or two days for some others review
> and if there is no remark or suggestions I reorganize
> patches according to your suggestions and post
> them again. I hope that there is chance the the patches
> could be accepted to mainline. The years has passed
> from the first sending for review already.
> This CAN emulation support is not so great and shiny
> but I think that it is usable basic start and possibility
> to test embedded systems in emulators is critical
> for development and getting critical even more now,
> when Linux enters automotive control systems after
> initial automotive entertainment.
> Support for D_CAN, CAN FD etc. should follow one day,
> I do not understand how automotive companies could
> exist without such development tool.

Lets post this in a "more" reviewable state with logically
separated patches, so it will be easier to review.

Fred

> 
> Thanks,
> 
> Pavel
> 
