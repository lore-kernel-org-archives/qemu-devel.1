Received: from eggs.gnu.org ([2001:4830:134:3::10]:53928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ciJxB-000702-6M
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 06:58:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ciJxA-0003sr-F5
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 06:58:57 -0500
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:38784)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ciJxA-0003sg-85
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 06:58:56 -0500
Received: by mail-wm0-x235.google.com with SMTP id u199so16756449wmd.1
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 03:58:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170224164021.9066-1-clement.deschamps@antfield.fr>
References: <20170224164021.9066-1-clement.deschamps@antfield.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Feb 2017 11:58:34 +0000
Message-ID: <CAFEAcA9RSPFQJ2EE0jcTbkymj=CSWt1NajXu8ojX0rhkw5QyWg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v3 0/4] bcm2835: add sdhost and gpio
 controllers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Clement Deschamps <clement.deschamps@antfield.fr>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Andrew Baumann <andrew.baumann@microsoft.com>

On 24 February 2017 at 16:40, Clement Deschamps
<clement.deschamps@antfield.fr> wrote:
> This patches add the Arasan SDHost controller and the GPIO controller to the BCM2835/36 platforms.
>
> This patches have been tested with raspbian 2015-09-24 (which uses the SDHCI controller),
> and raspbian 2017-01-11 (which dynamically switches to the SDHost controller).

Thanks; applied to target-arm.next; I'll put out a pullreq either today
or tomorrow with these in.

> I spotted an issue with the raspi2 platform, but it is not related to this patch.
> The CP15 timer frequency is set to 19.20MHz in the raspbian kernel DTB.
> There is a constant (GTIMER_SCALE) in target/arm/internals.h which seems to tell that the timer is at 62.5MHz.
> This causes problems:
> - The sleep command entered in guest lasts around 1/3 of the time it is supposed to last.
> - The cursor is blinking faster that it should
> - The systemd timeouts expire too early.
> - ...
>
> Did you already have this issue on another platform ?
> Should the frequency in the DTB be dynamically replaced depending on the GTIMER_SCALE value ?
> Or should the constant GTIMER_SCALE be platform dependent ?

We haven't noticed that on other platforms -- I think typically the kernel
trusts the value in the cp15 "what frequency are the timers" register,
at least on the "virt" board which gets the most usage.

We probably should have a mechanism for allowing the SoC or
board to set the clock frequency for the timer registers, though.
Ideally this would be done with the clocktree patchset that
Fred Konrad has been working on, which provides a generic
mechanism for wiring up "clocks" to devices which tell them how
fast things should tick.

thanks
-- PMM
