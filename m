Received: from eggs.gnu.org ([2001:4830:134:3::10]:58941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groeck7@gmail.com>) id 1fzqt3-0006Gk-LQ
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 18:12:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groeck7@gmail.com>) id 1fzqhI-0004UE-Tp
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 17:59:56 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:33016)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <groeck7@gmail.com>) id 1fzqhI-0004Dg-HZ
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 17:59:48 -0400
Received: by mail-pl1-x642.google.com with SMTP id b30-v6so9665274pla.0
	for <qemu-devel@nongnu.org>; Tue, 11 Sep 2018 14:59:33 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 11 Sep 2018 14:59:30 -0700
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <20180911215930.GB23260@roeck-us.net>
References: <20180831233736.GA10164@roeck-us.net>
	<e0b4bcce-6513-5614-88b1-5ee445d1bcc8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0b4bcce-6513-5614-88b1-5ee445d1bcc8@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] PC Chipset: Improve serial divisor
 calculation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Calvin Lee <cyrus296@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org

On Tue, Sep 11, 2018 at 03:21:34PM +0200, Paolo Bonzini wrote:
> On 01/09/2018 01:37, Guenter Roeck wrote:
> > The patch results in an unexpected DLL register value. Here is the
> > surrounding code from drivers/tty/serial/pxa.c:
> > 
> > 	serial_out(up, UART_DLL, quot & 0xff);		/* LS of divisor */
> > 
> > 	/*
> > 	 * work around Errata #75 according to Intel(R) PXA27x
> > 	 * Processor Family Specification Update (Nov 2005)
> > 	 */
> > 	dll = serial_in(up, UART_DLL);
> > 	WARN_ON(dll != (quot & 0xff));	// <-- warning
> > 
> > Reverting the patch fixes the problem.
> 
> I think it's a typo.  Can you try this:
> 

You are correct, the patch below fixes the problem.

Tested-by: Guenter Roeck <linux@roeck-us.net>

Thanks!
Guenter

> diff --git a/hw/char/serial.c b/hw/char/serial.c
> index 251f40fdac..02463e3388 100644
> --- a/hw/char/serial.c
> +++ b/hw/char/serial.c
> @@ -345,9 +345,9 @@ static void serial_ioport_write(void *opaque, hwaddr addr, uint64_t val,
>      default:
>      case 0:
>          if (s->lcr & UART_LCR_DLAB) {
> -            if (size == 2) {
> +            if (size == 1) {
>                  s->divider = (s->divider & 0xff00) | val;
> -            } else if (size == 4) {
> +            } else {
>                  s->divider = val;
>              }
>              serial_update_parameters(s);
> 
> Thanks,
> 
> Paolo
