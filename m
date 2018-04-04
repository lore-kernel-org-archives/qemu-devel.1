Received: from eggs.gnu.org ([2001:4830:134:3::10]:45471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f3fV7-0007Cj-71
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 06:18:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f3fV6-0007MZ-7Q
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 06:18:45 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:38614)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f3fV6-0007MM-2A
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 06:18:44 -0400
Received: by mail-ot0-x241.google.com with SMTP id o9-v6so22742578otj.5
	for <qemu-devel@nongnu.org>; Wed, 04 Apr 2018 03:18:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180319161556.16446-1-peter.maydell@linaro.org>
References: <20180319161556.16446-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 4 Apr 2018 11:18:23 +0100
Message-ID: <CAFEAcA8trs8tMKBqbOLaNx4OR9H9+xO4jJQjY2+yeCNdsdCBCA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH for-2.12 0/2] bcm2835_sdhost:
 fix interrupt handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Pekka Enberg <penberg@iki.fi>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Gerd Hoffmann <kraxel@redhat.com>, Andrew Baumann <Andrew.Baumann@microsoft.com>, "patches@linaro.org" <patches@linaro.org>

Ping for code review, please? It would be nice if our 'raspi3'
model for 2.12 was one we could say actually booted a known
Linux image...

thanks
-- PMM

On 19 March 2018 at 16:15, Peter Maydell <peter.maydell@linaro.org> wrote:
> This patchset fixes the code in the bcm2835_sdhost device
> so that it raises interrupts in more plausible places.
>
> The Linux bcm2835_sdhost driver doesn't work on QEMU at the moment,
> because our model raises spurious data interrupts.  Our function
> bcm2835_sdhost_fifo_run() will flag an interrupt any time it is
> called with s->datacnt == 0, even if the host hasn't actually issued
> a data read or write command yet.  This means that the driver gets a
> spurious data interrupt as soon as it enables IRQs and then does
> something else that causes us to call the fifo_run routine, like
> writing to SDHCFG, and before it does the write to SDCMD to issue the
> read.  The driver's IRQ handler then spins forever complaining that
> there's no data and the SD controller isn't in a state where there's
> going to be any data:
>
> [   41.040738] sdhost-bcm2835 3f202000.mmc: fsm 1, hsts 00000000
> [   41.042059] sdhost-bcm2835 3f202000.mmc: fsm 1, hsts 00000000
> (continues forever).
>
> Move the interrupt flag setting to more plausible places:
>  * for BUSY, raise this as soon as a BUSYWAIT command has executed
>  * for DATA, raise this when the FIFO has any space free (for a write)
>    or any data in it (for a read)
>  * for BLOCK, raise this when the data count is 0 and we've
>    actually done some reading or writing
>
> This is pure guesswork since the documentation for this hardware is
> not public, but it is sufficient to get the Linux bcm2835_sdhost
> driver to work.
>
> If anybody has other OSes than Linux that use the sdhost SD
> controller (not the 'Arasan' one, which is a different bit of
> the SoC) testing with those would be appreciated. If anybody
> has documentation for this hardware that would be even better.
>
> With these patches plus the previous set, I can get the Debian
> raspi3 image to boot (though there are a lot of warnings relating
> to the pl011 UART for some reason).
>
> thanks
> -- PMM
>
> Peter Maydell (2):
>   hw/sd/bcm2835_sdhost: Add tracepoints
>   hw/sd/bcm2835_sdhost: Don't raise spurious interrupts
>
>  hw/sd/bcm2835_sdhost.c | 51 +++++++++++++++++++++++++++++++-------------------
>  hw/sd/trace-events     |  6 ++++++
>  2 files changed, 38 insertions(+), 19 deletions(-)
>
> --
> 2.16.2
