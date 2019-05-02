Received: from eggs.gnu.org ([209.51.188.92]:55204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hM7es-0001EK-CL
	for qemu-devel@nongnu.org; Thu, 02 May 2019 05:05:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hM7eq-0002y6-BB
	for qemu-devel@nongnu.org; Thu, 02 May 2019 05:05:38 -0400
References: <20190419154041.77802-1-stephen.checkoway@oberlin.edu>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <45e6247e-cddb-2185-7f7b-503be00bd453@vivier.eu>
Date: Thu, 2 May 2019 11:04:33 +0200
MIME-Version: 1.0
In-Reply-To: <20190419154041.77802-1-stephen.checkoway@oberlin.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH v3] hw/char/escc: Lower irq
 when transmit buffer is filled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stephen Checkoway <stephen.checkoway@oberlin.edu>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Artyom Tarasenko <atar4qemu@gmail.com>, qemu-trivial@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

On 19/04/2019 17:40, Stephen Checkoway wrote:
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
> 
> This behavior was triggered by firmware for an embedded system with a
> Z85C30 which necessitated this patch.
> 
> This patch fixes that situation by explicitly lowering the IRQ when a
> character is written to the buffer and no other interrupts are currently
> pending.
> 
> Signed-off-by: Stephen Checkoway <stephen.checkoway@oberlin.edu>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> 
> I added a sentence about the Z85C30 necessitating this to the commit message.
> 
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
>          s->tx = val;
>          if (s->wregs[W_TXCTRL2] & TXCTRL2_TXEN) { // tx enabled
>              if (qemu_chr_fe_backend_connected(&s->chr)) {
> 


Applied to my trivial-patches branch.

Paolo, Marc-André, if you disagree with this change or prefer to take it
through one of your queues, I can remove it from mine. Let me know.


Thanks,
Laurent
