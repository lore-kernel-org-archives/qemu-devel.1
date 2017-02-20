Received: from eggs.gnu.org ([2001:4830:134:3::10]:59328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cfqu2-0006le-5v
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 11:33:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cfqty-0005Oh-WF
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 11:33:30 -0500
Received: from 1.mo2.mail-out.ovh.net ([46.105.63.121]:56496)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cfqty-0005My-QJ
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 11:33:26 -0500
Received: from player728.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 329025277C
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 17:33:24 +0100 (CET)
References: <1486997062-23227-1-git-send-email-clg@kaod.org>
	<1486997062-23227-2-git-send-email-clg@kaod.org>
	<CAFEAcA-q-VSup75PO-To9N11+0WCm=LNiFQ-SQXaTQMroyHFbw@mail.gmail.com>
	<73cbda87-adc5-e97d-d46d-f1f3d29cd46c@kaod.org>
	<CAFEAcA-1tzbEJ-kLF6iBR8LeXq_iiMgr92zh_HAgO9jVkMhCDg@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <c67277be-26e1-44ba-9fc8-809680010f32@kaod.org>
Date: Mon, 20 Feb 2017 17:33:18 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-1tzbEJ-kLF6iBR8LeXq_iiMgr92zh_HAgO9jVkMhCDg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 02/20/2017 03:38 PM, Peter Maydell wrote:
> On 20 February 2017 at 14:30, C=C3=A9dric Le Goater <clg@kaod.org> wrot=
e:
>> On 02/20/2017 02:51 PM, Peter Maydell wrote:
>>> On 13 February 2017 at 14:44, C=C3=A9dric Le Goater <clg@kaod.org> wr=
ote:
>>>> The setting of the DRAM address of the DMA transaction depends on th=
e
>>>> DRAM base address of the SoC. Let's add a property to give this
>>>> information to the SMC controller model.
>>>>
>>>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>>>> Reviewed-by: Joel Stanley <joel@jms.id.au>
>>>> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
>>>> --
>>>
>>> This seems a bit weird -- what does it actually do in hardware?
>>> (Does it really have the ability to dma anywhere in the
>>> address space and just use an odd base address, or is it
>>> DMA'ing to a more restricted address space?)
>>
>> For the AST2500, the valid address range for the DRAM side start
>> address of the DMA is [ 0x80000000 - 0xBFFFFFFF ] which is the
>> full 1024M SDRAM space. It will wrap back in case of overflow.
>>
>> For the AST2400, it is [ 0x40000000 - 0x5FFFFFFF ] which is the
>> full 512M SDRAM space.
>>
>> And the length of the DMA goes from 4 bytes to 32MB [ O - 0x7FFFFF ]

In fact, the above range is from the spec and it is wrong. I suppose
it is a left over from previous boards. Here is the current one :

	 [ 0 - 0x1fffffc ]
=20
> So if I do a DMA access to 0x800000 that's the same as an
> access at 0x0, or does it fail?

The length value wraps back just like the addresses.

> I ask because the other option for modelling this kind of thing
> would be that you make the DMA controller device take a link
> property which is a MemoryRegion*. Then inside the DMA device
> you create the AddressSpace* which you use to do DMA accesses,
> and in the board code you pass the DMA device a suitably
> constructed MemoryRegion that contains the things that the
> device can DMA to.

ok. I think I understand. I have done something similar for=20
the SCOM sideband bus of the PowerNV machine. It looks a like=20
a good idea. The 'minus 4' on the DMA length might be a little=20
annoying but I will give it a try.

Thanks,

C. =20

> You don't have to do it that way (and I don't think we
> have much in the way of examples of doing it like that,
> except for the ARM CPU handling of secure and nonsecure
> memory address spaces), but if it seems to fit better
> with what the hardware's doing it might be worth the effort.
>=20
> thanks
> -- PMM
>=20
