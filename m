Received: from eggs.gnu.org ([2001:4830:134:3::10]:53778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g7NIB-00050d-VP
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 12:13:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g7NIB-0000vh-5R
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 12:12:59 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:42694)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g7NIA-0000uw-UE
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 12:12:59 -0400
Received: by mail-ot1-x343.google.com with SMTP id h26-v6so2440218otl.9
	for <qemu-devel@nongnu.org>; Tue, 02 Oct 2018 09:12:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <f18e92fa-7b49-04b6-0adb-4f1a84668168@kaod.org>
References: <20180921161939.822-1-clg@kaod.org>
	<20180921161939.822-9-clg@kaod.org>
	<CAFEAcA8W0ixkfje4NSx-+kdw4rNh44JgNTu2OhDD_p91nHK7hw@mail.gmail.com>
	<f18e92fa-7b49-04b6-0adb-4f1a84668168@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Oct 2018 17:12:36 +0100
Message-ID: <CAFEAcA_injuKY7=fLvG7sj2p7Ffzx5tNQ4f3RxjsNk8Hy-rYMA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 08/11] aspeed/smc: add support for DMAs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>, Alistair Francis <alistair@alistair23.me>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On 2 October 2018 at 16:48, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> On 10/2/18 12:56 PM, Peter Maydell wrote:
>> Rather than having the DMA device directly grab the system_memory
>> MR like this, it's better to have the device have a MemoryRegion
>> property, which the SoC sets with whatever the DMA device should
>> be able to see.
>
> ok. I see, but it seems I have a chicken & egg problem.
>
> The MemoryRegion I would liked to grab is the bmc->ram one in aspeed.c
> but it is initialized after the SoC is. I don't know how to lazy bind
> this region in the Aspeed SMC model using the Aspeed SoC model as a
> proxy to pass the region property through a link or/and alias.
>
> If I could find a way, the model would be much cleaner.

Usually what you want to pass is not the RAM region directly but
some container object (which contains the RAM region among
other things). This is often a container that you're passing
to the SoC anyway so it can put its devices in it.

(The direct answer to your chicken-and-egg problem is that you
can create a container before creating the SoC, pass that to
the SoC, then create the RAM afterwards and put it in the
container after. But that feels a bit like a workaround for
a less than ideal structure, somehow.)

thanks
-- PMM
