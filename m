Received: from eggs.gnu.org ([2001:4830:134:3::10]:42793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rbraun@sceen.net>) id 1ek4tq-0000IV-8u
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 04:23:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rbraun@sceen.net>) id 1ek4tp-0003U6-7z
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 04:23:18 -0500
Received: from shattrath.sceen.net ([2001:41d0:c:ada::1]:38657
	helo=mail.sceen.net) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rbraun@sceen.net>) id 1ek4tp-0003Nj-0e
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 04:23:17 -0500
Date: Fri, 9 Feb 2018 10:23:13 +0100
From: Richard Braun <rbraun@sceen.net>
Message-ID: <20180209092313.GA27456@shattrath>
References: <1517776881-14115-1-git-send-email-rbraun@sceen.net>
	<CAFEAcA_XagA3SuqNTHd06nH4nTXTNztRBAYOQxF8cJmaVXBhoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_XagA3SuqNTHd06nH4nTXTNztRBAYOQxF8cJmaVXBhoQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] hw/char/stm32f2xx_usart: improve TXE/TC
 bit handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair@alistair23.me>

On Thu, Feb 08, 2018 at 02:58:29PM +0000, Peter Maydell wrote:
> On 4 February 2018 at 20:41, Richard Braun <rbraun@sceen.net> wrote:
> > Consider that data is always immediately sent. As a result, keep
> > the SR_TXE and SR_TC bits always set. In addition, fix the reset value
> > of the USART status register.
> 
> Do you know what the data sheet means when it says that TC
> can be cleared by "a read from the USART_SR register followed
> by a write to the USART_DR register" ?

It's meant for software either polling the TC bit or waiting for a
transmission complete interrupt. Once the bit is seen, the next
transmission automatically clears it.

> If we supported interrupts properly (which we don't seem to)
> I suspect we'd need something more than "TXE and TC are always set",
> or the guest would probably never clear the TXE and TC interrupts.

That's the idea of the patch. Since everything is currently synchronous,
there is no need for these transient states to even exist.

> The guest can clear the TC and TXE bits by writing to the USART_SR
> directly, so this code should set both of them, I think ?

Right, nice catch.

-- 
Richard Braun
