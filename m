Received: from eggs.gnu.org ([209.51.188.92]:59695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hH5vg-0005mZ-Cn
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 08:14:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hH5vf-0004Xh-Ag
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 08:14:12 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44589)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hH5vf-0004Ga-3q
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 08:14:11 -0400
Received: by mail-wr1-f65.google.com with SMTP id w18so2665368wrv.11
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 05:13:54 -0700 (PDT)
References: <20190417005053.885-1-stephen.checkoway@oberlin.edu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <aaa450c5-0446-b4b3-40ac-ef87b5522545@redhat.com>
Date: Thu, 18 Apr 2019 14:13:52 +0200
MIME-Version: 1.0
In-Reply-To: <20190417005053.885-1-stephen.checkoway@oberlin.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] hw/char/escc: Lower irq when transmit
 buffer is filled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stephen Checkoway <stephen.checkoway@oberlin.edu>, Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Artyom Tarasenko <atar4qemu@gmail.com>, Laurent Vivier <laurent@vivier.eu>, qemu-trivial@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

On 4/17/19 2:50 AM, Stephen Checkoway wrote:
> The SCC/ESCC will briefly stop asserting an interrupt when the
> transmit FIFO is filled.
> 
> This code doesn't model the transmit FIFO/shift register so the
> pending transmit interrupt is never deasserted which means that an
> edge-triggered interrupt controller will never see the low-to-high
> transition it needs to raise another interrupt. The practical
> consequence of this is that guest firmware with an interrupt service
> routine for the ESCC that does not send all of the data it has
> immediately will stop sending data if the following sequence of
> events occurs:
> 1. Disable processor interrupts
> 2. Write a character to the ESCC
> 3. Add additional characters to a buffer which is drained by the ISR
> 4. Enable processor interrupts
> 
> In this case, the first character will be sent, the interrupt will
> fire and the ISR will output the second character. Since the pending
> transmit interrupt remains asserted, no additional interrupts will
> ever fire.

You might want to add a line expliciting the chipset model which forced
you to do that patch (Z85C30).

> This fixes that situation by explicitly lowering the IRQ when a
> character is written to the buffer and no other interrupts are currently
> pending.

> 
> Signed-off-by: Stephen Checkoway <stephen.checkoway@oberlin.edu>
> ---
>  hw/char/escc.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/hw/char/escc.c b/hw/char/escc.c
> index 628f5f81f7..c5b05a63f1 100644
> --- a/hw/char/escc.c
> +++ b/hw/char/escc.c
> @@ -509,6 +509,13 @@ static void escc_mem_write(void *opaque, hwaddr addr,
>          break;
>      case SERIAL_DATA:
>          trace_escc_mem_writeb_data(CHN_C(s), val);
> +        /*
> +         * Lower the irq when data is written to the Tx buffer and no other
> +         * interrupts are currently pending. The irq will be raised again once
> +         * the Tx buffer becomes empty below.
> +         */
> +        s->txint = 0;
> +        escc_update_irq(s);

Way better, thanks :)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Note: the Z85C30 has a 1-byte transmit FIFO and 3-byte receive FIFO.
Our model default is the ESCC, and we use ESCC_SERIO_QUEUE_SIZE=256 byte
for rx FIFO... If needed we can add properties and use a white list of
chipset with their tx/rx FIFO size.

>          s->tx = val;
>          if (s->wregs[W_TXCTRL2] & TXCTRL2_TXEN) { // tx enabled
>              if (qemu_chr_fe_backend_connected(&s->chr)) {
> 
