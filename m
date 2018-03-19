Received: from eggs.gnu.org ([2001:4830:134:3::10]:49233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1exxkW-0001AI-5f
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 12:35:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1exxkV-0006Y5-7V
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 12:35:04 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:46288)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1exxkV-0006Xl-2r
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 12:35:03 -0400
Received: by mail-oi0-x244.google.com with SMTP id x12so14830312oie.13
	for <qemu-devel@nongnu.org>; Mon, 19 Mar 2018 09:35:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180319161556.16446-3-peter.maydell@linaro.org>
References: <20180319161556.16446-1-peter.maydell@linaro.org>
	<20180319161556.16446-3-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Mar 2018 16:34:41 +0000
Message-ID: <CAFEAcA8=Akk685sVg8HsV3a014GK=THkGbDixoKFQkh_pss4PA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH for-2.12 2/2]
 hw/sd/bcm2835_sdhost: Don't raise spurious interrupts
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

On 19 March 2018 at 16:15, Peter Maydell <peter.maydell@linaro.org> wrote:
> The Linux bcm2835_sdhost driver doesn't work on QEMU, because our
> model raises spurious data interrupts.  Our function
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
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/sd/bcm2835_sdhost.c | 43 +++++++++++++++++++++++--------------------
>  1 file changed, 23 insertions(+), 20 deletions(-)
>
> diff --git a/hw/sd/bcm2835_sdhost.c b/hw/sd/bcm2835_sdhost.c
> index 79f3c5ceeb..0fd0853fa3 100644
> --- a/hw/sd/bcm2835_sdhost.c
> +++ b/hw/sd/bcm2835_sdhost.c
> @@ -137,6 +137,9 @@ static void bcm2835_sdhost_send_command(BCM2835SDHostState *s)
>          }
>  #undef RWORD
>      }
> +    if ((s->cmd & SDCMD_BUSYWAIT) && (s->config & SDHCFG_BUSY_IRPT_EN)) {
> +        s->status |= SDHSTS_BUSY_IRPT;
> +    }
>      return;
>
>  error:

Oops, I had a comment here that should go above this if() that I failed
to refresh into the patch before sending it:

+    /* We never really delay commands, so if this was a 'busywait' command
+     * then we've completed it now and can raise the interrupt.
+     */

thanks
-- PMM
