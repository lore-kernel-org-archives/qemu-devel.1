Received: from eggs.gnu.org ([2001:4830:134:3::10]:53861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fXsa7-00040j-8u
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 14:20:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fXsa2-00020n-HM
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 14:20:47 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:45002)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fXsa2-00020g-AT
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 14:20:42 -0400
Received: by mail-qt0-x243.google.com with SMTP id 92-v6so11573794qta.11
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 11:20:42 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180626180324.5537-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <7b97505c-5391-02f3-5abb-daa73ec2419d@amsat.org>
Date: Tue, 26 Jun 2018 15:20:38 -0300
MIME-Version: 1.0
In-Reply-To: <20180626180324.5537-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] sd: Don't trace SDRequest crc field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org

On 06/26/2018 03:03 PM, Peter Maydell wrote:
> We don't actually implement SD command CRC checking, because
> for almost all of our SD controllers the CRC generation is
> done in hardware, and so modelling CRC generation and checking
> would be a bit pointless. (The exception is that milkymist-memcard
> makes the guest software compute the CRC.)
> 
> As a result almost all of our SD controller models don't bother
> to set the SDRequest crc field, and the SD card model doesn't
> check it. So the tracing of it in sdbus_do_command() provokes
> Coverity warnings about use of uninitialized data.
> 
> Drop the CRC field from the trace; we can always add it back
> if and when we do anything useful with the CRC.
> 
> Fixes Coverity issues 1386072, 1386074, 1386076, 1390571.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> We might also want to try to improve our CRC handling
> (eg so that the controller can say "I have not set the CRC,
> don't bother checking it" or "I have set the CRC, do check
> it because it's come from the guest software"), but let's
> put in the simple tweak to make Coverity happy for the moment.

Thanks for this simple patch... So simple I couldn't even think of it...

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/sd/core.c       | 2 +-
>  hw/sd/trace-events | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/sd/core.c b/hw/sd/core.c
> index 820345f704b..107e6d71ddb 100644
> --- a/hw/sd/core.c
> +++ b/hw/sd/core.c
> @@ -91,7 +91,7 @@ int sdbus_do_command(SDBus *sdbus, SDRequest *req, uint8_t *response)
>  {
>      SDState *card = get_card(sdbus);
>  
> -    trace_sdbus_command(sdbus_name(sdbus), req->cmd, req->arg, req->crc);
> +    trace_sdbus_command(sdbus_name(sdbus), req->cmd, req->arg);
>      if (card) {
>          SDCardClass *sc = SD_CARD_GET_CLASS(card);
>  
> diff --git a/hw/sd/trace-events b/hw/sd/trace-events
> index bfd1d62efcb..43cffab8b17 100644
> --- a/hw/sd/trace-events
> +++ b/hw/sd/trace-events
> @@ -7,7 +7,7 @@ bcm2835_sdhost_edm_change(const char *why, uint32_t edm) "(%s) EDM now 0x%x"
>  bcm2835_sdhost_update_irq(uint32_t irq) "IRQ bits 0x%x\n"
>  
>  # hw/sd/core.c
> -sdbus_command(const char *bus_name, uint8_t cmd, uint32_t arg, uint8_t crc) "@%s CMD%02d arg 0x%08x crc 0x%02x"
> +sdbus_command(const char *bus_name, uint8_t cmd, uint32_t arg) "@%s CMD%02d arg 0x%08x"
>  sdbus_read(const char *bus_name, uint8_t value) "@%s value 0x%02x"
>  sdbus_write(const char *bus_name, uint8_t value) "@%s value 0x%02x"
>  sdbus_set_voltage(const char *bus_name, uint16_t millivolts) "@%s %u (mV)"
> 
