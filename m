Received: from eggs.gnu.org ([2001:4830:134:3::10]:48676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ej8u3-0007kU-IF
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:27:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ej8u2-0006Oe-Me
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:27:39 -0500
Received: from mail-ot0-x22a.google.com ([2607:f8b0:4003:c0f::22a]:34235)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ej8u2-0006OR-Fa
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:27:38 -0500
Received: by mail-ot0-x22a.google.com with SMTP id l10so2840392oth.1
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 11:27:38 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180206190432.GF3291@localhost.localdomain>
References: <CAFEAcA8ges1g2TOGKYBG+xtjxGHWsg+Hr81eSxcQrLNPV4CUNg@mail.gmail.com>
	<20180206190432.GF3291@localhost.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Feb 2018 19:27:17 +0000
Message-ID: <CAFEAcA8gwSqNpVD5xfk_yEz0OUMwa2rrfKaEhBXq5KravJmOag@mail.gmail.com>
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

On 6 February 2018 at 19:04, Eduardo Habkost <ehabkost@redhat.com> wrote:
> On Tue, Feb 06, 2018 at 06:18:25PM +0000, Peter Maydell wrote:
>> One current approach to that is that instead of init'ing those
>> child objects in the container init, we postpone that to
>> container realize. This looks pretty ugly, and it also means
>> that you can't do "forward this property" using add_alias if the
>> target is the late-inited child (instead you have to have a
>> real property on the container and set the property on the child
>> manually after it's inited). You can see an example of this kind
>> of thing in hw/arm/armv7m.c.
>
> My rule of thumb is: if something is configurable (even if it's
> just slightly), it belongs to realize.  instance_init is reserved
> for stuff that don't take any external input.  If your container
> contents are not static, creating the contents is not a task for
> instance_init.
>
> But I would like to understand the drawbacks of this approach
> better.  So, if the object didn't have any "forward this
> property" aliases, would you see other problems with this
> approach?
>
> Why exactly those boards need the aliases?  Who sets those alias
> properties?  Can we provide helpers that make this task easier?

The "forwarding properties" bit is the one I'm hitting at the
moment. armv7m creates the CPU object, but it's really the
SoC which creates armv7m that wants to set various properties
on the CPU. (The CPU properties being set are things like
"initial vector address" which in real hardware are set by
the SoC hard-wiring various config signals on the core to 1 or 0.)
So I'd end up needing to manually forward a lot of properties
which are implemented in the cpu object but exposed to the
rest of the system via the armv7m wrapper.

It's also a bit weird because in the limit case you end up
doing nothing in init and postponing it all to realize,
at which point we're back to single-phase init. I don't
much like the "needed to configure this thing" design looking
different from the "simple nonconfigurable thing" design.
If nothing else, it makes it harder to convert from one to
the other when we add a new SoC or whatever.

thanks
-- PMM
