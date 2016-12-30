Received: from eggs.gnu.org ([2001:4830:134:3::10]:45172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mar.krzeminski@gmail.com>) id 1cN1cW-0007Q5-0t
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 13:09:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mar.krzeminski@gmail.com>) id 1cN1cR-0006im-3Y
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 13:09:36 -0500
Received: from mail-lf0-x22e.google.com ([2a00:1450:4010:c07::22e]:36603)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mar.krzeminski@gmail.com>)
	id 1cN1cQ-0006id-Sb
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 13:09:31 -0500
Received: by mail-lf0-x22e.google.com with SMTP id t196so240852136lff.3
	for <qemu-devel@nongnu.org>; Fri, 30 Dec 2016 10:09:30 -0800 (PST)
References: <20161224151113.23955-1-jcd@tribudubois.net>
	<606aedd3-2f56-fb89-b547-763baf833ed5@gmail.com>
	<5b3ba089-e218-40ff-3b72-f31ada1e4cfc@tribudubois.net>
	<a6c26a91-696c-db4b-7311-7cfc7ef9ee74@gmail.com>
	<ccab130c-3f65-e4b4-8453-b2fd0f1110ae@tribudubois.net>
	<5f1acd02-018d-0a17-105c-cd42c50a3e91@tribudubois.net>
	<d320496c-42d0-f8ae-71ea-e81073f2cf9d@gmail.com>
	<684d34f1-9107-1ed0-1115-f3034bd899f4@tribudubois.net>
From: "mar.krzeminski" <mar.krzeminski@gmail.com>
Message-ID: <a25f717f-28b6-959a-92c3-a7233dcf7fe2@gmail.com>
Date: Fri, 30 Dec 2016 19:09:27 +0100
MIME-Version: 1.0
In-Reply-To: <684d34f1-9107-1ed0-1115-f3034bd899f4@tribudubois.net>
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
To: Jean-Christophe DUBOIS <jcd@tribudubois.net>, qemu-devel@nongnu.org, peter.maydell@linaro.org



W dniu 30.12.2016 o 18:14, Jean-Christophe DUBOIS pisze:
> Le 30/12/2016 à 16:39, mar.krzeminski a écrit :
>> I got some time, and reproduced the problem. Here are some logs with 
>> m25p80 debugs:
>> : decode_new_cmd: decoded new command:9f
>> : decode_new_cmd: populated jedec code
>> : decode_new_cmd: decoded new command:0
>> : decode_new_cmd: decoded new command:0 //Getting flash Id in above 4 
>> lines -> OK (but missing CS)
>> Found sst25vf016b compatible flash device
>> : decode_new_cmd: decoded new command:6 //Write enable, command 
>> without payload, so it is ok
>> : decode_new_cmd: decoded new command:1 //Write to status register, 
>> guest sends data
>> INFO: spi0.0: sst25vf016b (2048 Kbytes)
>> INFO: spi0.0: mtd
>>   .name = spi0.0,
>>   .size = 0x200000 (2MiB)
>>   .erasesize = 0x00001000 (4KiB)
>>   .numeraseregions = 0
>> Segmentation fault (core dumped) //Here probably guest try to send 
>> some data
>>
>> The root cause why m25p80 enter strange state is that CS line is not 
>> selected/deselected at all- there is missing debug from m25p80_cs.
>> In spi transfer CS line (here qemu_irq) should be 0 before begin of 
>> every message, and set after end of transmission.
>> In case of simple WREN command you should see something like this:
>> : m25p80_cs: deselect
>> : decode_new_cmd: decoded new command:6
>> : m25p80_cs: select
>>
>> Can you check spi controller model code?
>
> I'll double check.
>
> But why is the SPI memory/device even responding if CS is not set ?
Looking at ssi code it should not.
Flash (so the m25p80) is responding when CS line is low and it seem that 
this is default.

Thanks,
Marcin

>
>>
>> Thanks,
>> Marcin
>>
>>
>
>
