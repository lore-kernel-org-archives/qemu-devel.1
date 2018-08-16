Received: from eggs.gnu.org ([2001:4830:134:3::10]:45159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqHd7-0006Lw-Sy
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 08:43:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqHcy-0000mI-74
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 08:43:50 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:37615)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fqHcw-0000kF-91
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 08:43:48 -0400
Received: by mail-oi0-x242.google.com with SMTP id j205-v6so7731322oib.4
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 05:43:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180731201056.29257-1-tpiepho@impinj.com>
References: <20180731201056.29257-1-tpiepho@impinj.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Aug 2018 13:43:23 +0100
Message-ID: <CAFEAcA_8zRtZJ060+6k0tG95Q0vvEz4=TwL3gMt5ATdcLvMNmQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH] imx_spi: Unset XCH when TX FIFO
 becomes empty
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Trent Piepho <tpiepho@impinj.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Peter Chubb <peter.chubb@nicta.com.au>

On 31 July 2018 at 21:10, Trent Piepho via Qemu-arm <qemu-arm@nongnu.org> w=
rote:
> The current emulation will clear the XCH bit when a burst finishes.
> This is not quite correct.  According to the i.MX7d referemce manual,
> Rev 0.1, =C2=A710.1.7.3:
>
>     This bit [XCH] is cleared automatically when all data in the TXFIFO
>     and the shift register has been shifted out.
>
> So XCH should be cleared when the FIFO empties, not on completion of a
> burst.  The FIFO is 64 x 32 bits =3D 2048 bits, while the max burst size
> is larger at 4096 bits.  So it's possible that the burst is not finished
> after the TXFIFO empties.
>
> Sending a large block (> 2048 bits) with the Linux driver will use a
> burst that is larger than the TXFIFO.  After the TXFIFO has emptied XCH
> does not become unset, as the burst is not yet finished.
>
> What should happen after the TXFIFO empties is the driver will refill it
> and set XCH.  The rising edge of XCH will trigger another transfer to
> begin.  However, since the emulation does not set XCH to 0, there is no
> rising edge and the next trasfer never begins.
>
> Signed-off-by: Trent Piepho <tpiepho@impinj.com>

Applied to target-arm.next. Thanks for the detailed commit message,
it made the patch much easier to review.

-- PMM
