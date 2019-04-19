Received: from eggs.gnu.org ([209.51.188.92]:44152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hHVeQ-0001TT-3P
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 11:42:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hHVeP-0002KG-5r
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 11:42:06 -0400
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144]:52399)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stephen.checkoway@oberlin.edu>)
	id 1hHVeP-0002Jx-1B
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 11:42:05 -0400
Received: by mail-it1-x144.google.com with SMTP id x132so8796769itf.2
	for <qemu-devel@nongnu.org>; Fri, 19 Apr 2019 08:42:04 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
From: Stephen Checkoway <stephen.checkoway@oberlin.edu>
In-Reply-To: <aaa450c5-0446-b4b3-40ac-ef87b5522545@redhat.com>
Date: Fri, 19 Apr 2019 11:42:02 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <05AF5CE1-3A71-4D78-B35B-C443BE310985@oberlin.edu>
References: <20190417005053.885-1-stephen.checkoway@oberlin.edu>
	<aaa450c5-0446-b4b3-40ac-ef87b5522545@redhat.com>
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
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Artyom Tarasenko <atar4qemu@gmail.com>, Laurent Vivier <laurent@vivier.eu>, qemu-trivial@nongnu.org, =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>



> On Apr 18, 2019, at 08:13, Philippe Mathieu-Daud=C3=A9 =
<philmd@redhat.com> wrote:
>=20
> On 4/17/19 2:50 AM, Stephen Checkoway wrote:
>> The SCC/ESCC will briefly stop asserting an interrupt when the
>> transmit FIFO is filled.
>>=20
>> This code doesn't model the transmit FIFO/shift register so the
>> pending transmit interrupt is never deasserted which means that an
>> edge-triggered interrupt controller will never see the low-to-high
>> transition it needs to raise another interrupt. The practical
>> consequence of this is that guest firmware with an interrupt service
>> routine for the ESCC that does not send all of the data it has
>> immediately will stop sending data if the following sequence of
>> events occurs:
>> 1. Disable processor interrupts
>> 2. Write a character to the ESCC
>> 3. Add additional characters to a buffer which is drained by the ISR
>> 4. Enable processor interrupts
>>=20
>> In this case, the first character will be sent, the interrupt will
>> fire and the ISR will output the second character. Since the pending
>> transmit interrupt remains asserted, no additional interrupts will
>> ever fire.
>=20
> You might want to add a line expliciting the chipset model which =
forced
> you to do that patch (Z85C30).

Done.

Thanks for looking at this.

--=20
Stephen Checkoway
