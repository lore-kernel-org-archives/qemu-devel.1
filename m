Received: from eggs.gnu.org ([2001:4830:134:3::10]:47173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rbraun@sceen.net>) id 1ek56u-0003bD-VP
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 04:36:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rbraun@sceen.net>) id 1ek56q-0006Kx-OB
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 04:36:48 -0500
Received: from shattrath.sceen.net ([151.80.19.218]:36619 helo=mail.sceen.net)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rbraun@sceen.net>) id 1ek56q-0006KY-Gd
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 04:36:44 -0500
Date: Fri, 9 Feb 2018 10:36:44 +0100
From: Richard Braun <rbraun@sceen.net>
Message-ID: <20180209093643.GC27456@shattrath>
References: <1517776881-14115-1-git-send-email-rbraun@sceen.net>
	<CAFEAcA_XagA3SuqNTHd06nH4nTXTNztRBAYOQxF8cJmaVXBhoQ@mail.gmail.com>
	<CAKmqyKOecR8kg3ec1jNbxV+VmZFeQw+sjC8LGBNAaR6pcOwrHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKmqyKOecR8kg3ec1jNbxV+VmZFeQw+sjC8LGBNAaR6pcOwrHg@mail.gmail.com>
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
To: Alistair Francis <alistair23@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair@alistair23.me>, QEMU Developers <qemu-devel@nongnu.org>

On Thu, Feb 08, 2018 at 03:33:32PM -0800, Alistair Francis wrote:
> >> @@ -96,12 +96,10 @@ static uint64_t stm32f2xx_usart_read(void *opaque, hwaddr addr,
> >>      switch (addr) {
> >>      case USART_SR:
> >>          retvalue = s->usart_sr;
> >> -        s->usart_sr &= ~USART_SR_TC;
> 
> This does seem to be the wrong behavior. It should be cleared after
> writing to the USART_DR register (and after this read).

Writing to DR being synchronous, the transmission is complete immediately
after doing it, making that bit set again.

> >>      case USART_DR:
> >>          DB_PRINT("Value: 0x%" PRIx32 ", %c\n", s->usart_dr, (char) s->usart_dr);
> >> -        s->usart_sr |= USART_SR_TXE;
> 
> Doesn't software expect this to be set? Maybe this was just a nasty
> workaround to ensure it was set at some point.

This bit should always be set in the current implementation. It may be
cleared and set the day I/O threads are used, since then, the transient
state will be visible to software.

> >> @@ -151,8 +149,6 @@ static void stm32f2xx_usart_write(void *opaque, hwaddr addr,
> >>              /* XXX this blocks entire thread. Rewrite to use
> >>               * qemu_chr_fe_write and background I/O callbacks */
> >>              qemu_chr_fe_write_all(&s->chr, &ch, 1);
> >> -            s->usart_sr |= USART_SR_TC;
> >> -            s->usart_sr &= ~USART_SR_TXE;
> >
> > The guest can clear the TC and TXE bits by writing to the USART_SR
> > directly, so this code should set both of them, I think ?
> 
> Shouldn't this clear both?
> 
> TXE: "It is cleared by a write to the USART_DR register."
> TC: "a read from the USART_SR register followed by a write to the
> USART_DR register"
> 
> I guess the TC should only clear after a read though.

We're not aiming at a full emulation of the device here, we only want to
emulate visible states. As mentioned above, software should always see
the TXE bit set, since writes are synchronous. TC should be set though,
because it may be cleared by an explicit write to SR setting it to 0.

I'll post a new version of the patch soon.

-- 
Richard Braun
