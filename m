Received: from eggs.gnu.org ([2001:4830:134:3::10]:53425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fEDmF-0004Sk-Po
	for qemu-devel@nongnu.org; Thu, 03 May 2018 08:56:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fEDmA-0001yZ-VT
	for qemu-devel@nongnu.org; Thu, 03 May 2018 08:56:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51894 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fEDmA-0001xh-Oh
	for qemu-devel@nongnu.org; Thu, 03 May 2018 08:55:58 -0400
References: <CAFEAcA87nQZLG493hSPb__zwKHVMsSNaS_qhY2EPghzTvJ9fwg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e77d927d-17fb-9543-adac-8281dd775f74@redhat.com>
Date: Thu, 3 May 2018 14:55:50 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA87nQZLG493hSPb__zwKHVMsSNaS_qhY2EPghzTvJ9fwg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] does a device model need to call
 qemu_chr_fe_accept_input() in its reset method?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 03/05/2018 14:49, Peter Maydell wrote:
> Hi; I noticed that one of our UART models, hw/char/cadence_uart.c,
> calls qemu_chr_fe_accept_input() in its reset method. This sort
> of makes sense, since device reset is a state transition from
> "I'm in a state where I've previously said I can't accept input"
> to "I'm in a state where I can accept input". However, it looks
> like none of the other UARTs do this.
>=20
> Is this a bug in our other UARTs, or does the chardev framework
> guarantee to forget about 'nope' responses from the fd_can_read
> callback on system reset?

No, system reset is not a particularly interesting event for most of the
backends.

So you have found a bug, and in fact it should be called on every rising
edge of can_read, so for example digic-uart.c is even more broken.  I
vaguely remember looking at it years ago...

Paolo
