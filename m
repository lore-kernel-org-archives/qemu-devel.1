Received: from eggs.gnu.org ([2001:4830:134:3::10]:59228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcd@tribudubois.net>) id 1cLvEg-0008RQ-G5
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 12:08:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcd@tribudubois.net>) id 1cLvEd-0005gF-9e
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 12:08:26 -0500
Received: from relay4-d.mail.gandi.net ([2001:4b98:c:538::196]:41048)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jcd@tribudubois.net>) id 1cLvEd-0005fx-3F
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 12:08:23 -0500
References: <20161224151113.23955-1-jcd@tribudubois.net>
	<606aedd3-2f56-fb89-b547-763baf833ed5@gmail.com>
	<5b3ba089-e218-40ff-3b72-f31ada1e4cfc@tribudubois.net>
	<a6c26a91-696c-db4b-7311-7cfc7ef9ee74@gmail.com>
	<ccab130c-3f65-e4b4-8453-b2fd0f1110ae@tribudubois.net>
From: Jean-Christophe DUBOIS <jcd@tribudubois.net>
Message-ID: <5f1acd02-018d-0a17-105c-cd42c50a3e91@tribudubois.net>
Date: Tue, 27 Dec 2016 18:08:17 +0100
MIME-Version: 1.0
In-Reply-To: <ccab130c-3f65-e4b4-8453-b2fd0f1110ae@tribudubois.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] [M25P80] Make sure not to overrun the
 internal data buffer.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "mar.krzeminski" <mar.krzeminski@gmail.com>, qemu-devel@nongnu.org, peter.maydell@linaro.org

You can have a more detailed procedure on how to run Xvisor on Qemu 
Sabrelite (with Linux guests if you wish) at the following URL.

https://github.com/avpatel/xvisor-next/blob/master/docs/arm/imx6-sabrelite.txt

You don't need to start the guest to see the crash. Just boot Xvisor ...

JC

Le 24/12/2016 à 19:12, Jean-Christophe DUBOIS a écrit :
> Le 24/12/2016 à 19:04, mar.krzeminski a écrit :
>>
>>
>> W dniu 24.12.2016 o 18:41, Jean-Christophe DUBOIS pisze:
>>> Le 24/12/2016 à 18:18, mar.krzeminski a écrit :
>>>> Hello,
>>>>
>>>> W dniu 24.12.2016 o 16:11, Jean-Christophe Dubois pisze:
>>>>> It did happen that the internal data buffer was overrun leading to 
>>>>> a Qemu
>>>>> crash (in particular while emulating the i.MX6 sabrelite board).
>>>>>
>>>>> This patch makes sure the data array would not be overrun and 
>>>>> allow the
>>>>> sabrelite emulation to run without crash.
>>>>>
>>>>> Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>
>>>>> ---
>>>>>   hw/block/m25p80.c | 2 +-
>>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
>>>>> index d29ff4c..a1c4e5d 100644
>>>>> --- a/hw/block/m25p80.c
>>>>> +++ b/hw/block/m25p80.c
>>>>> @@ -1117,7 +1117,7 @@ static uint32_t m25p80_transfer8(SSISlave 
>>>>> *ss, uint32_t tx)
>>>>>           s->data[s->len] = (uint8_t)tx;
>>>>>           s->len++;
>>>>>   -        if (s->len == s->needed_bytes) {
>>>>> +        if ((s->len >= s->needed_bytes) || (s->len >= 
>>>>> sizeof(s->data))) {
>>>>>               complete_collecting_data(s);
>>>>>           }
>>>>>           break;
>>>> Do you have exact scenario that caused the problem?
>>>
>>> When booting Xvisor (http://xhypervisor.org/) on top of Qemu 
>>> emulated Sabrelite.
>>>
>>> During the boot Qemu would segfault while writing to the SPI flash.
>> Thanks, I'll try to take I look.
>
> Once you have built Xvisor for "generic ARMv7" you can run the 
> following command.
>
> qemu-system-arm -M sabrelite -display none -serial null -serial stdio 
> -kernel ./build/vmm.bin -initrd ./build/vmm.bin  -dtb 
> ./build/arch/arm/board/generic/dts/imx6/sabrelite-a9/one_guest_sabrelite-a9.dtb
>
> You can also run Qemu  under valgrind that will pinpoint the problem.
>
> JC
>
>>>
>>>> Generally it should not happen.
>>>
>>> The fact is that there is no protection to make sure the data array 
>>> is not overrun.
>> Yes. IMHO it could be nice to log some error here and reset state 
>> machine instead
>> of going to next state.
>>>
>>> May be it should not happen but it did happen in this case ....
>> Yeap, but this mean m25p80's state machine goes nuts. Overflow is 
>> just a symptom
>> that something wrong is going on.
>>
>> Thanks,
>> Marcin
>>>
>>> JC
>>>
>>>
>>>>
>>>> Thanks,
>>>> Marcin
>>>>
>>>>
>>>
>>>
>>
>>
>
>
>
