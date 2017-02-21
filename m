Received: from eggs.gnu.org ([2001:4830:134:3::10]:52355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cg8B2-0001jt-05
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 06:00:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cg8Ay-0006kE-QI
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 06:00:11 -0500
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:38112)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cg8Ay-0006iC-Gs
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 06:00:08 -0500
Received: by mail-wm0-x22c.google.com with SMTP id r141so72380520wmg.1
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 03:00:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170220173430.31630-1-clement.deschamps@antfield.fr>
References: <20170220173430.31630-1-clement.deschamps@antfield.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Feb 2017 10:59:46 +0000
Message-ID: <CAFEAcA-XkD3RRswf97Zg2phEdJScSYHnTjLmt__xe=+pLedvcw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 0/2] add bcm2835 sdhost controller to
 bcm2835 platform
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Clement Deschamps <clement.deschamps@antfield.fr>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Andrew Baumann <andrew.baumann@microsoft.com>, =?UTF-8?Q?Gr=C3=A9gory_ESTRADE?= <gregory.estrade@gmail.com>

On 20 February 2017 at 17:34, Clement Deschamps
<clement.deschamps@antfield.fr> wrote:
> This patches add the Arasan SD controller to the BCM2835/36 platforms.

Cool!

> On the real hardware, both SD controllers are wired to the same SD card.
> Selection is done via multi-function pins through the GPIO controller.  I'm not
> sure what would be the good solution to emulate this in QEMU.  For now on we
> pass two sd cards on the command line which is not ideal.

That's unfortunate. I think we definitely need to fix this before we
can take the controller support into QEMU, because of the user-visible
effects on the required QEMU command line syntax.

I wonder if we can model this by effectively ejecting the card from
one SDBus and inserting it into the other when the GPIO controller
setting is configured. I think the way we want to do this is to
remove the SDState object from one SDBus qbus and insert it into
the other -- the functions in hw/sd/core.c all already cope with
"there's no card on this bus".

This might be a bit awkward because we effectively want to do a
hotplug/hot-unplug from our code but we don't want to expose to
the user that the device is hotpluggable. It may just be a matter
of doing an object_unparent() and then qdev_set_parent_bus() to move
the card object from one bus to the other... or it could get more
complicated.

thanks
-- PMM
