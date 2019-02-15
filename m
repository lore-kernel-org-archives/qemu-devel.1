Received: from eggs.gnu.org ([209.51.188.92]:54333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guaMJ-0000BQ-3n
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 05:04:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guaMG-0005si-Pp
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 05:04:38 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:46526)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1guaMG-0005dr-9y
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 05:04:36 -0500
Received: by mail-ot1-x343.google.com with SMTP id w25so15532533otm.13
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 02:04:18 -0800 (PST)
MIME-Version: 1.0
References: <20190214102816.3393-1-peter.maydell@linaro.org>
	<20190214102816.3393-8-peter.maydell@linaro.org>
	<alpine.BSF.2.21.9999.1902150223200.49412@zero.eik.bme.hu>
In-Reply-To: <alpine.BSF.2.21.9999.1902150223200.49412@zero.eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Feb 2019 10:04:06 +0000
Message-ID: <CAFEAcA9aUxU4gTnpP3OKLToLttagfNWuA9UzxNGHeXNkKCWiDg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 7/7] ui/cocoa: Perform UI operations
 only on the main thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, John Arbuckle <programmingkidx@gmail.com>, Roman Bolshakov <r.bolshakov@yadro.com>, Berkus Decker <berkus@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Ben Hekster <ben.hekster@foghorn.io>

On Fri, 15 Feb 2019 at 01:28, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>
> On Thu, 14 Feb 2019, Peter Maydell wrote:
> > - (void)sendEvent:(NSEvent *)event
> > {
> >     COCOA_DEBUG("QemuApplication: sendEvent\n");
> > -    [super sendEvent: event];
> > +    if (!cocoaView || ![cocoaView handleEvent:event]) {
> > +        [super sendEvent: event];
> > +    }
>
> I think the menu problem may be because now all mouse events go to our
> handleEvent method and it may swallow those that should operate the menus
> somehow while previously [super sendEvent] took care of those events and
> only left the remaining mouse events in queue? Maybe we should test in
> handleEvent if the mouse event is within our window and forward everything
> else to super? But I'm not sure and could be wrong, only guessing.

Menus definitely did work for me (both mouse interaction and
keyboard shortcuts), so I'm not sure why you're seeing something
different.

My understanding is that the new code should eat exactly the
same set of events that the old code did:
 * in the old code, only our custom "pull events off the queue"
   code took events from OSX, and it passed them to handleEvent;
   only events handleEvent called [NSApp sendEvent] on would
   ever get to the OSX menu/etc handling
 * in the new code, OSX's run loop takes events off the queue:
   they go to our NSApplication sendEvent method, which passes
   them to handleEvent. Only events that handleEvent returns false
   for will ever get to the OSX menu/etc handling
and (absent bugs) handleEvent should now return false for exactly
the set of events that it previously called sendEvent on.

I know menu handling in OSX is a bit odd because the menu
drag stuff uses a 'private event loop' to handle events
while the menu is down. Maybe something is interacting
badly with that.

thanks
-- PMM
