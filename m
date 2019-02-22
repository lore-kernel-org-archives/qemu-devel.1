Received: from eggs.gnu.org ([209.51.188.92]:57513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gxCx2-0002Mz-11
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 10:41:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gxCww-0000A9-5x
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 10:41:19 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:34165)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gxCwv-00009K-N3
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 10:41:17 -0500
Received: by mail-oi1-x242.google.com with SMTP id g16so2044829oib.1
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 07:41:17 -0800 (PST)
MIME-Version: 1.0
References: <20190214102816.3393-1-peter.maydell@linaro.org>
	<20190214102816.3393-2-peter.maydell@linaro.org>
	<20190222151910.io5pvf6u3kp3axns@SPB-NB-133.local>
In-Reply-To: <20190222151910.io5pvf6u3kp3axns@SPB-NB-133.local>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Feb 2019 15:41:05 +0000
Message-ID: <CAFEAcA_Ek6iZshV45qykNiu8mTgwh0a5zYFRWX-mUNX2f6Na6Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 1/7] ui/cocoa: Ensure we have the
 iothread lock when calling into QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Bolshakov <r.bolshakov@yadro.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, John Arbuckle <programmingkidx@gmail.com>, Berkus Decker <berkus@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Ben Hekster <ben.hekster@foghorn.io>, BALATON Zoltan <balaton@eik.bme.hu>

On Fri, 22 Feb 2019 at 15:19, Roman Bolshakov <r.bolshakov@yadro.com> wrote:
>
> On Thu, Feb 14, 2019 at 10:28:10AM +0000, Peter Maydell wrote:
> > The Cocoa UI should run on the main thread; this is enforced
> > in OSX Mojave. In order to be able to run on the main thread,
> > we need to make sure we hold the iothread lock whenever we
> > call into various QEMU UI midlayer functions.
> >
>
> Hi Peter,
>
> I wonder if qmp_stop and qmp_cont calls should be made in locked context
> within pauseQEMU and resumeQEMU methods, respectively?

Yes, you're right, I missed these, but they should also be
called within a with_iothread_lock wrapper.

> I also think it's better to clarify that the reason of the commit is not
> Mojave enforcing usage of event loop in main thread but an improvement
> of event processing in Cocoa UI, because Cocoa UI works on Mojave.

Hmm? The point of this patchset is exactly that Mojave enforces
that things go on the main thread, where previous OSX versions
did not, and so in some situations QEMU will crash on Mojave
where it did not on older versions. So I'm not sure what you're
suggesting should be clarified here.

> As of now qemu main loop and Cocoa events processing is done in the same
> thread. And you can see from below that invocation of the qemu_main blocks
> Cocoa event loop [NSApp run] in applicationDidFinishLaunching as qemu_main
> doesn't quit.

Yes, indeed. This is how we've traditionally done the Cocoa
event handling. It's worked OK for everything up to Mojave...

> Each millisecond cocoa_refresh gets called by display handler. The function
> extracts all available events from the cocoa event queue and dispatches them to
> handleEvent:
>
>         event = [NSApp nextEventMatchingMask:NSEventMaskAny untilDate:distantPast
>                         inMode: NSDefaultRunLoopMode dequeue:YES];
>         if (event != nil) {
>             [cocoaView handleEvent:event];
>         }
>
> handleEvent enqueues keyboard and mouse events into ps2 queue and the
> other events are enqueued to Cocoa event queue. I'm curious what happens
> to the events that are enqueued with:
>         [NSApp sendEvent:event];

As I understand it, this sendEvent method doesn't queue anything.
It just hands the event to the usual OSX event handling chain,
which will either use it (for example, if it's a menu-item
key accelerator event) or drop it on the floor. The logic is
basically "QEMU-specific code gets first chance to decide whether
to consume the event; the default (and a few other odd cases)
if it does not is that we let the OSX framework code do whatever
it wants to do with it".

thanks
-- PMM
