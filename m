Received: from eggs.gnu.org ([2001:4830:134:3::10]:41372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d0liU-00037n-VF
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 05:16:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d0liT-0000Ww-TM
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 05:16:02 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:37125)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1d0liT-0000Vp-Mb
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 05:16:01 -0400
Received: by mail-wm0-x22c.google.com with SMTP id m123so6210523wma.0
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 02:16:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAJy91Ca2FTvBzd2OqQZyEJBtCAxxosdcAFP1RMgGCQe2PJXEJA@mail.gmail.com>
References: <CAJy91CZpAiZ6adPmbAESrYqDgtK37CEgw4SAk97jCNduADy6Tw@mail.gmail.com>
	<CAFEAcA-V3BNcrhhnap+Hn8spfZPd0=Dv2v0P5myGwqU2e5t0Eg@mail.gmail.com>
	<CAJy91Ca2FTvBzd2OqQZyEJBtCAxxosdcAFP1RMgGCQe2PJXEJA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 19 Apr 2017 10:15:40 +0100
Message-ID: <CAFEAcA-f1P4OW+DwLRn1AZQCzoiWNX_8Rhq0oduppMOSLWo9Ww@mail.gmail.com>
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
To: Jiahuan Zhang <jiahuanzhang90@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 19 April 2017 at 09:56, Jiahuan Zhang <jiahuanzhang90@gmail.com> wrote:
> Do you mean that it is reasonable for QEMU emulation consumes high CPU time
> when doing host-guest interaction, since the interaction calls many QEMU
> codes in the background?

> Since my guest app is rather simple and no while() is included, according to
> your words,
> can I conclude that the high processor time is cause by the callbacks for
> guest to host data transfer?

What is happening is that the guest kernel's serial driver
has a loop that (simplified) looks like this:

  do {
      if (pl011_read(REG_FR) & FR_TXFF)
          break; /* fifo full, try again later */
      pl011_write(buffer[x], REG_DR);  /* send one byte */
      x++;
  } while (x != len);

This is a lot of guest CPU instructions (and two callouts
to QEMU's device emulation) for every single byte.

>> You will likely get better throughput if you use the 'virt' board
>> where you can use the virtio-serial device which can send
>> data more efficiently.

> Here, can I understand your statement in this way,
> a transmit buffer in the serial device for guest to host data transfer
> may reduce the processor time, and in turn, increase the throughput?

The reason virtio-serial is faster is because the guest
kernel driver can essentially tell QEMU
 "the data is in guest memory at address X length L"
and then QEMU takes all that data at once. This is much
more efficient.

thanks
-- PMM
