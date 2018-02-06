Received: from eggs.gnu.org ([2001:4830:134:3::10]:42133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ej3mp-00062g-4B
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 08:59:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ej3mo-0007aw-BP
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 08:59:51 -0500
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:43646)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ej3mo-0007aO-4R
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 08:59:50 -0500
Received: by mail-oi0-x244.google.com with SMTP id 4so1363608ois.10
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 05:59:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <f10dd700-68c9-ec0a-461c-38ad757102c6@amsat.org>
References: <20180123035837.16578-1-f4bug@amsat.org>
	<20180123035837.16578-5-f4bug@amsat.org>
	<CAKmqyKMoUcPhkr8bM1DU1QeBaRbJ9kAfOp_j-vFxf1y8p=1AbA@mail.gmail.com>
	<5a373a1f-6289-a216-cd02-254402069c12@amsat.org>
	<CAFEAcA8UzFXVyWKHKdOtjtoPjKCJ-dxu_MSZD4_1i3Hoge7eKw@mail.gmail.com>
	<f10dd700-68c9-ec0a-461c-38ad757102c6@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Feb 2018 13:59:28 +0000
Message-ID: <CAFEAcA8fAC-uPcuEdCyzjdaqQx8B0JVi1U8j-882zU78ch-XKw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 4/6] hw/sd/pl181: expose a SDBus and
 connect the SDCard to it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Michael Walle <michael@walle.cc>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Stefan Weil <sw@weilnetz.de>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, "open list:ARM PrimeCell and..." <qemu-arm@nongnu.org>

On 6 February 2018 at 13:53, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
> On 02/06/2018 10:06 AM, Peter Maydell wrote:
>> How do you manage to get rid of sdbus_reparent_card()? Raspi
>> needs it for its weirdo multiplexed SD controller setup, and
>> AFAIK we don't have a way to say "this thing is hotpluggable
>> but not by the user" yet...
>
> The card is hotpluggable, the bus isn't.
>
> An unique SDBus is created in the bcm2835_peripherals object (model
> closer than hardware), sdhci/sdhost/gpio controllers use it via property
> links.
> What I don't do is checking the gpio selector (sd_fsel), hoping the
> guest isn't nasty enough to use both SD controllers at once...

We do need to honour the sd_fsel -- otherwise newer Linux rpi
kernels don't boot, because they want to use the non-default
SD controller and they select it accordingly. At the moment
this works using sdbus_reparent_card(). (I do vaguely recall
looking at whether this could be done using hotplug but I
forget why I decided it was a bad idea.)

thanks
-- PMM
