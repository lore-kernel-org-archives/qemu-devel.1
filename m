Received: from eggs.gnu.org ([2001:4830:134:3::10]:35313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ejSuu-000871-6n
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 11:49:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ejSut-000562-AL
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 11:49:52 -0500
Received: from mail-ot0-x230.google.com ([2607:f8b0:4003:c0f::230]:38360)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ejSut-00055o-56
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 11:49:51 -0500
Received: by mail-ot0-x230.google.com with SMTP id h14so1406684otj.5
	for <qemu-devel@nongnu.org>; Wed, 07 Feb 2018 08:49:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <3131facd-2630-a159-15c3-0013332bf805@redhat.com>
References: <CAFEAcA8ges1g2TOGKYBG+xtjxGHWsg+Hr81eSxcQrLNPV4CUNg@mail.gmail.com>
	<20180206190432.GF3291@localhost.localdomain>
	<CAFEAcA8gwSqNpVD5xfk_yEz0OUMwa2rrfKaEhBXq5KravJmOag@mail.gmail.com>
	<f87c71eb-78b8-e7a8-ac77-575212a94c7e@redhat.com>
	<CAFEAcA-Y6C-E_2=dEuQAA1ryeyzmCYKZUf-Fh-4jaQMhnU9Kkg@mail.gmail.com>
	<3131facd-2630-a159-15c3-0013332bf805@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 7 Feb 2018 16:49:29 +0000
Message-ID: <CAFEAcA-d_hPyotGd-qdRBKfAQ4RkD4q9Aodi2AtGE5FeftRSzw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] how to handle QOM 'container' objects whose
 contents depend on QOM properties?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

On 7 February 2018 at 16:38, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 07/02/2018 17:22, Peter Maydell wrote:
>>> Just to understand the context better, when you buy a SoC (presumably as
>>> IP) can you also configure it to hardwire different CPU config signals?
>>
>> Usually if you buy an SoC you're buying the silicon, not
>> the IP. I think the usual case is that the SoC ties the
>> CPU config signals to 0 or 1 (part of the SoC designer's
>> job is configuring the semi-configurable bits of IP the
>> way they want when they put them all together). It would
>> certainly be in theory possible for the SoC to instead
>> route those signals out to pins on the SoC for the board
>> to tie off, but my impression is that's not a likely design
>> choice.
>
> Yeah, that's why I was wondering if buying an SoC as configurable IP was
> a thing at all.  In that case, I would just make things less
> configurable and, if needed, hack the configurability with -global.

So is that a vote for the aspeed style "create N different
QOM types" ?

It doesn't necessarily help with 'armv7m', which isn't an
SoC, but just part of the way we currently model M profile CPUs.
In real hardware, the CPU includes all of the interrupt
controller, timers, etc, which in QEMU are separate
objects to the QEMU CPU object and wrapped up inside
an armv7m container.

(It would I guess be possible to merge the 'armv7m' container
entirely into the QEMU CPU object, so creating the CPU object
gave you an nvic and the mmio register regions to map and so
on. We don't do anything like that for other cpus right now,
though...)

thanks
-- PMM
