Received: from eggs.gnu.org ([209.51.188.92]:48382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hEKrf-0003Gd-TO
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 17:34:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hEKgQ-00076g-F1
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 17:23:04 -0400
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141]:38736)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stephen.checkoway@oberlin.edu>)
	id 1hEKgM-00070k-Kc
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 17:23:02 -0400
Received: by mail-it1-x141.google.com with SMTP id f22so5980791ita.3
	for <qemu-devel@nongnu.org>; Wed, 10 Apr 2019 14:22:53 -0700 (PDT)
From: Stephen Checkoway <stephen.checkoway@oberlin.edu>
Message-Id: <437475C9-2835-4CBC-8A38-FF95E29569FA@oberlin.edu>
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Date: Wed, 10 Apr 2019 17:22:45 -0400
In-Reply-To: <1328f591-897f-8762-d324-cccb5f63a360@redhat.com>
References: <20190305051007.56009-1-stephen.checkoway@oberlin.edu>
	<52a82d3a-3b79-c61d-93fa-f087af45f6fb@redhat.com>
	<1328f591-897f-8762-d324-cccb5f63a360@redhat.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/char/escc: Lower irq when transmit
 buffer is filled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Artyom Tarasenko <atar4qemu@gmail.com>, Laurent Vivier <laurent@vivier.eu>, qemu-trivial@nongnu.org, =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>



On Apr 10, 2019, at 16:01, Philippe Mathieu-Daud=C3=A9 =
<philmd@redhat.com> wrote:

> On 3/6/19 12:01 PM, Paolo Bonzini wrote:
>> On 05/03/19 06:10, Stephen Checkoway wrote:
>>> The SCC/ESCC will briefly stop asserting an interrupt when the
>>> transmit FIFO is filled.
>>>=20
>>> This code doesn't model the transmit FIFO/shift register so the
>>> pending transmit interrupt is never deasserted which means that an
>>> edge-triggered interrupt controller will never see the low-to-high
>>> transition it needs to raise another interrupt. The practical
>>> consequence of this is that guest firmware with an interrupt service
>>> routine for the ESCC that does not send all of the data it has
>>> immediately will stop sending data if the following sequence of
>>> events occurs:
>>> 1. Disable processor interrupts
>>> 2. Write a character to the ESCC
>>> 3. Add additional characters to a buffer which is drained by the ISR
>>> 4. Enable processor interrupts
>>>=20
>>> In this case, the first character will be sent, the interrupt will
>>> fire and the ISR will output the second character. Since the pending
>>> transmit interrupt remains asserted, no additional interrupts will
>>> ever fire.
>>>=20
>>> This fixes that situation by explicitly lowering the IRQ when a
>>> character is written to the buffer.
>>>=20
>>> Signed-off-by: Stephen Checkoway <stephen.checkoway@oberlin.edu>
>>=20
>> Looks good but I would like Mark to give his ack as well.
>>=20
>> Mark, could you also add hw/char/escc.c to both SPARC and Mac =
sections
>> of MAINTAINERS?
>=20
> Cc'ing Artyom who also made some changes in this file, and Laurent.
>=20
>=20
> Stephen, which particular chipset are you using?

I'm away from the hardware, but my notes say Z80C30. I've included the =
image from the board if you want to try to decipher the rest of the part =
number. My best guess is it's a Z85C3008VEC. If it's important, I can =
ask someone who is a few thousand km closer to the hardware than I =
currently am to take a look.



> This file models various types. I had a talk with Mark or Laurent at
> last KVM forum about this device. IIRC, while the sun4m machines use a
> real chipset, the MacIO embeds an slighly modified IP core.
>=20
> I can't find what you describe in the Z85C30 doc, however in the ESCC
> datasheet referenced in escc.c (which happens to be a 85MiB pdf!!!) I =
found:

(This chip is ridiculously configurable, I honestly found it much easier =
to write a driver by reverse engineering existing firmware than by =
reading the part sheet.)

>=20
>  Transmit Interrupts and Transmit Buffer Empty Bit on the NMOS/CMOS
>=20
>  The TxIP is reset either by writing data to the transmit buffer or
>  by issuing the Reset Tx Int command in WR0.
>=20
> I understand the NMOS/CMOS desc. matches the Z85C30 (no FIFO used).

It has been a little while since I was last looking at this, but my =
recollection was the SCC has a 1-byte transmit buffer and the ESCC has a =
small (4 maybe?) byte transmit buffer. But in either case writing data =
to the transmit buffer should clear the interrupt.

> So your description and patch makes sens.
> What worries me is the controller could have other pending IRQs to
> deliver and you are clearing them. Shouldn't we only clear the
> INTR_TXINT bit, and call escc_update_irq() which should lower the IRQ =
if
> no bits are pending?
>=20
> Maybe as:
>=20
>    s->wregs[W_INTR] &=3D ~INTR_TXINT;
>    escc_update_irq(s);

Ah, I think I see. In this case, escc_update_irq() will lower the IRQ if =
no other interrupts are pending and the set_txint() will raise it again. =
Otherwise, it'll remain raised. I can give this a shot and see how it =
goes. (I think this should be R_INTR instead of W_INTR, but I'll double =
check once I have an opportunity to dig into this again.)

Thanks for looking at this!

Steve


--=20
Stephen Checkoway
