Received: from eggs.gnu.org ([2001:4830:134:3::10]:53352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cfp74-00053n-Sb
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:38:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cfp73-0003D3-Na
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:38:50 -0500
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:36455)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cfp73-0003CY-H8
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:38:49 -0500
Received: by mail-wr0-x233.google.com with SMTP id 89so60756152wrr.3
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 06:38:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <73cbda87-adc5-e97d-d46d-f1f3d29cd46c@kaod.org>
References: <1486997062-23227-1-git-send-email-clg@kaod.org>
	<1486997062-23227-2-git-send-email-clg@kaod.org>
	<CAFEAcA-q-VSup75PO-To9N11+0WCm=LNiFQ-SQXaTQMroyHFbw@mail.gmail.com>
	<73cbda87-adc5-e97d-d46d-f1f3d29cd46c@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Feb 2017 14:38:27 +0000
Message-ID: <CAFEAcA-1tzbEJ-kLF6iBR8LeXq_iiMgr92zh_HAgO9jVkMhCDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] aspeed/smc: add a 'sdram_base' property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 20 February 2017 at 14:30, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> On 02/20/2017 02:51 PM, Peter Maydell wrote:
>> On 13 February 2017 at 14:44, C=C3=A9dric Le Goater <clg@kaod.org> wrote=
:
>>> The setting of the DRAM address of the DMA transaction depends on the
>>> DRAM base address of the SoC. Let's add a property to give this
>>> information to the SMC controller model.
>>>
>>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>>> Reviewed-by: Joel Stanley <joel@jms.id.au>
>>> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
>>> --
>>
>> This seems a bit weird -- what does it actually do in hardware?
>> (Does it really have the ability to dma anywhere in the
>> address space and just use an odd base address, or is it
>> DMA'ing to a more restricted address space?)
>
> For the AST2500, the valid address range for the DRAM side start
> address of the DMA is [ 0x80000000 - 0xBFFFFFFF ] which is the
> full 1024M SDRAM space. It will wrap back in case of overflow.
>
> For the AST2400, it is [ 0x40000000 - 0x5FFFFFFF ] which is the
> full 512M SDRAM space.
>
> And the length of the DMA goes from 4 bytes to 32MB [ O - 0x7FFFFF ]

So if I do a DMA access to 0x800000 that's the same as an
access at 0x0, or does it fail?

I ask because the other option for modelling this kind of thing
would be that you make the DMA controller device take a link
property which is a MemoryRegion*. Then inside the DMA device
you create the AddressSpace* which you use to do DMA accesses,
and in the board code you pass the DMA device a suitably
constructed MemoryRegion that contains the things that the
device can DMA to.

You don't have to do it that way (and I don't think we
have much in the way of examples of doing it like that,
except for the ARM CPU handling of secure and nonsecure
memory address spaces), but if it seems to fit better
with what the hardware's doing it might be worth the effort.

thanks
-- PMM
