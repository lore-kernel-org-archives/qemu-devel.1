Received: from eggs.gnu.org ([2001:4830:134:3::10]:60827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jiahuanzhang90@gmail.com>) id 1d0mTi-0000hE-Ai
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 06:04:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jiahuanzhang90@gmail.com>) id 1d0mTh-00018x-3b
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 06:04:50 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:34278)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jiahuanzhang90@gmail.com>)
	id 1d0mTg-00018f-U2
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 06:04:49 -0400
Received: by mail-qk0-x241.google.com with SMTP id p68so2640285qke.1
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 03:04:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9mfnUF-ZtU+kGpSj2LqVxPi=0GLB4Jk9zLnhhfq_Su4A@mail.gmail.com>
References: <CAJy91CZpAiZ6adPmbAESrYqDgtK37CEgw4SAk97jCNduADy6Tw@mail.gmail.com>
	<CAFEAcA-V3BNcrhhnap+Hn8spfZPd0=Dv2v0P5myGwqU2e5t0Eg@mail.gmail.com>
	<CAJy91Ca2FTvBzd2OqQZyEJBtCAxxosdcAFP1RMgGCQe2PJXEJA@mail.gmail.com>
	<CAFEAcA-f1P4OW+DwLRn1AZQCzoiWNX_8Rhq0oduppMOSLWo9Ww@mail.gmail.com>
	<CAJy91CY=s2H0VYYuDUrs=HYTEKjKZHpU1MXrhStxGxxWg=hfEg@mail.gmail.com>
	<CAFEAcA9mfnUF-ZtU+kGpSj2LqVxPi=0GLB4Jk9zLnhhfq_Su4A@mail.gmail.com>
From: Jiahuan Zhang <jiahuanzhang90@gmail.com>
Date: Wed, 19 Apr 2017 12:04:47 +0200
Message-ID: <CAJy91CaB3kA0vNRGs52S=OweSfSXnkO71AHOa2XpUYNJTnZHDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] Hight Processor time of Socket communciation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 19 April 2017 at 11:55, Peter Maydell <peter.maydell@linaro.org> wrote:

> On 19 April 2017 at 10:25, Jiahuan Zhang <jiahuanzhang90@gmail.com> wrote:
> > On 19 April 2017 at 11:15, Peter Maydell <peter.maydell@linaro.org>
> wrote:
> >> What is happening is that the guest kernel's serial driver
> >> has a loop that (simplified) looks like this:
> >>
> >>   do {
> >>       if (pl011_read(REG_FR) & FR_TXFF)
> >>           break; /* fifo full, try again later */
> >>       pl011_write(buffer[x], REG_DR);  /* send one byte */
> >>       x++;
> >>   } while (x != len);
> >>
> >> This is a lot of guest CPU instructions (and two callouts
> >> to QEMU's device emulation) for every single byte.
> >>
> > Hi, no, I am not using any kernel driver and I only test the guest to
> host
> > data transfer.
>
> OK, then the equivalent loop is this one:
>
> > /*
> >  * write_to_uart(): write data to serial port
> >  */
> > void write_to_uart(char* out, uint32_t writeSize){
> >  int i;
> >  for(i=0; i<writeSize; i++){
> >   *UART1 =(unsigned char)(*(out+i));
> >  }
> > }
>
> except that your code is broken because it's not
> checking that the FIFO is ready to receive the character
> so it will drop data sometimes.
>

Okay. Thank you for pointing this out.
I would like to make a new serial device based on pl011,
but containing a buffer for guest-to-host data transfer.
I expect it would help to reduce the processor time while communicating.
At this moment, I focus on having a better performance.

regards,
Jiahuan

>
> The point is the same -- you're feeding the data to
> the UART byte-at-a-time.
>
> thanks
> -- PMM
>
