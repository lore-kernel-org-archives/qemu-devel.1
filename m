Received: from eggs.gnu.org ([2001:4830:134:3::10]:53414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1e9FQG-00011H-H1
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 15:08:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1e9FQD-0007p4-A8
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 15:08:32 -0400
Received: from chuckie.co.uk ([82.165.15.123]:45880
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1e9FQD-0007ou-2h
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 15:08:29 -0400
References: <1508947167-5304-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1508947167-5304-10-git-send-email-mark.cave-ayland@ilande.co.uk>
	<CAFEAcA8DGeoNWxr9Y-vRXmtR5=7+EMQqfpt5cs7x2qTcfRZR4Q@mail.gmail.com>
	<98d12504-4523-2a5c-aefa-4b01e1c6c7df@ilande.co.uk>
	<a169c6f0-4a82-cd3c-7f83-0a6394c06e98@ilande.co.uk>
	<CAFEAcA9u3kw6LnwE3ZnExdcmMM42AuycnLOppiX7wXdeKk5hcw@mail.gmail.com>
	<ef818927-9c2e-37cd-91a1-8b5bf40ad8e1@ilande.co.uk>
	<74c257be-f3dc-ebf9-7a55-0eefe46ce93e@amsat.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <b50513a9-0f19-afaa-31b1-6219d84b82f0@ilande.co.uk>
Date: Mon, 30 Oct 2017 19:08:19 +0000
MIME-Version: 1.0
In-Reply-To: <74c257be-f3dc-ebf9-7a55-0eefe46ce93e@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCHv4 09/13] lance: move TYPE_LANCE and
 SysBusPCNetState from lance.c to lance.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Artyom Tarasenko <atar4qemu@gmail.com>

On 30/10/17 18:45, Philippe Mathieu-Daudé wrote:

>>>>>>> +/*
>>>>>>> + * QEMU AMD PC-Net II (Am79C970A) emulation
>>>>>>
>>>>>> Filename says this is Lance ethernet, but the comment says it's PC-Net ?
>>>>>
>>>>> According to the datasheet for Am79C970A, the original Lance is an
>>>>> Am7990 device and the Am79C970A aka PCNet-PCI II as emulated by QEMU is
>>>>> register-compatible with it.
>>>>>
>>>>> I guess the comment above is more technically correct, but I'm happy to
>>>>> adjust it in my local tree if you still feel it needs to change?
>>>
>>> I think we should have a comment that says what the file is
>>> for. Since this is a different file from pcnet.h, we should
>>> have a comment that isn't the same as the pcnet.h one.
>>> I don't particularly mind what it says, as long as it briefly
>>> explains what's in the file (and by implication what distinguishes
>>> things in this file from things in the other).
>>
>> Okay then how about something along the lines of:
>>
>>  * QEMU Lance (Am7990) device emulation
>>  *
>>  * Copyright (c) 2004 Antony T Curtis
>>  * Copyright (c) 2017 Mark Cave-Ayland
>>  *
>>  * This represents the Sparc32 lance (Am7990) ethernet device which is
>>  * an earlier register-compatible member of the AMD PC-Net II
>>  * (Am79C970A) family.
>>
>> In reality pcnet.c/pcnet.h are just the inner workings of the pcnet-pci
>> and lance devices. The comments in pcnet-pci.c and lance.c are identical
>> except for the Sparc32 reference and it was the same header from
>> pcnet-pci.c that I used as the basis for my last patch.
> 
> You are right the PCnet family is based on the Lance one, but it seems
> nobody remembers the Lance origin, the "PC-Net" took over.
> 
> Maybe we can agree with the different families having an unique
> "hw/net/pcnet_lance.h" header with all Lance/PC-Net related XXX_TYPEs,
> what do you think?

This is definitely a good idea in principle, however the lance device in
its current form cannot work for anything other than SPARC32 because of
the the word-size byte swaps for FIFO transfers which occur for DMA
transfers (see the code for ledma_memory_read/ledma_memory_write).

I think in its current form the patch allows for someone to potentially
implement this later for other architectures (e.g x86) so while I don't
want to disallow this in future, it isn't really within the scope of
this particular patchset.


ATB,

Mark.
