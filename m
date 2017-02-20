Received: from eggs.gnu.org ([2001:4830:134:3::10]:51422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cfoyx-0006YA-SZ
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:30:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cfoyu-0001Pw-Mv
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:30:27 -0500
Received: from 2.mo2.mail-out.ovh.net ([188.165.53.149]:55148)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cfoyu-0001N5-HL
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:30:24 -0500
Received: from player728.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id E894852EDE
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 15:30:15 +0100 (CET)
References: <1486997062-23227-1-git-send-email-clg@kaod.org>
	<1486997062-23227-2-git-send-email-clg@kaod.org>
	<CAFEAcA-q-VSup75PO-To9N11+0WCm=LNiFQ-SQXaTQMroyHFbw@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <73cbda87-adc5-e97d-d46d-f1f3d29cd46c@kaod.org>
Date: Mon, 20 Feb 2017 15:30:08 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-q-VSup75PO-To9N11+0WCm=LNiFQ-SQXaTQMroyHFbw@mail.gmail.com>
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

On 02/20/2017 02:51 PM, Peter Maydell wrote:
> On 13 February 2017 at 14:44, C=C3=A9dric Le Goater <clg@kaod.org> wrot=
e:
>> The setting of the DRAM address of the DMA transaction depends on the
>> DRAM base address of the SoC. Let's add a property to give this
>> information to the SMC controller model.
>>
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> Reviewed-by: Joel Stanley <joel@jms.id.au>
>> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
>> --
>=20
> This seems a bit weird -- what does it actually do in hardware?
> (Does it really have the ability to dma anywhere in the
> address space and just use an odd base address, or is it
> DMA'ing to a more restricted address space?)

For the AST2500, the valid address range for the DRAM side start
address of the DMA is [ 0x80000000 - 0xBFFFFFFF ] which is the=20
full 1024M SDRAM space. It will wrap back in case of overflow.

For the AST2400, it is [ 0x40000000 - 0x5FFFFFFF ] which is the=20
full 512M SDRAM space.

And the length of the DMA goes from 4 bytes to 32MB [ O - 0x7FFFFF ]

On real HW, the DRAM address of the DMA is taken as an offset from=20
the beginning of the SDRAM address space. It does the same for=20
the flash address btw. This is why we have the macros in the model :=20

#define DMA_DRAM_ADDR(base, x)  (((x) & ~0xE0000003) | base)
#define DMA_FLASH_ADDR(x)       (((x) & ~0xE0000003) | \
                                 ASPEED_SOC_FMC_FLASH_BASE)


Thanks,

C.
