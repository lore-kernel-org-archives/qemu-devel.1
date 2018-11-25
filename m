Received: from eggs.gnu.org ([2001:4830:134:3::10]:36930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gR1G6-0006BM-G0
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 15:44:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gR1G5-000700-MW
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 15:44:02 -0500
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336]:42840)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gR1G5-0006zb-IC
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 15:44:01 -0500
Received: by mail-ot1-x336.google.com with SMTP id v23so9355840otk.9
	for <qemu-devel@nongnu.org>; Sun, 25 Nov 2018 12:44:01 -0800 (PST)
MIME-Version: 1.0
References: <D965412A-A975-4660-BEC5-6FBF34E35C45@gmail.com>
	<CAFEAcA983Q16B8y1j3msg31BtM5LXhUcB5ouyg6Dp1y-aUaDpw@mail.gmail.com>
	<CAFEAcA8WMh8AnD8X5eMz7YX_c5z0Aw8_ydZ-0poY5Sv9mnxUHw@mail.gmail.com>
	<20181122073202.zafys4gyewgjpgko@sirius.home.kraxel.org>
In-Reply-To: <20181122073202.zafys4gyewgjpgko@sirius.home.kraxel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 25 Nov 2018 20:43:48 +0000
Message-ID: <CAFEAcA-NAbimZZ8=URgUb5hFe7LG72DRM05SwecARtJUcWL1zA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] Fix for crashes and non-responsive UI on
 macOS Mojave
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Berkus Decker <berkus@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>

On Thu, 22 Nov 2018 at 07:32, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > Something somewhere in this call chain should have taken
> > the iothread lock, I assume, but I'm not sure where.
> >
> > Gerd -- what are the rules of the UI subsystem regarding
> > multiple threads, and what threads are allowed to call
> > UI functions like qemu_input_event_send_key_qcode(),
> > from which threads, and whether they need to eg hold
> > the iothread lock when they do so? There's no
> > documentation on these functions in include/ui/input.h.
>
> UI event handling code typically runs in iothread context.  So, yes,
> when calling qemu_input_* the UI code holds the iothread lock.
>
> > (To fix a problem on OSX Mojave this patchset has moved
> > which thread the UI executes on, so it is now always
> > the main thread and not the thread which calls
> > the QemuDisplay 'init' callback. That seems to break
> > an implicit assumption in the UI layer.)
>
> Hmm, I guess the options are (a) grab the iothread lock before calling
> input layer functions, or (b) queue the event and schedule a bottom half
> which processes the queue (which will then be called from iothread
> context, with the lock already taken).

I was thinking about this today, and I realized that if
we just make the OSX UI thread code grab the iothread lock,
then there is a potential deadlock with the changes (also
in this patchset) which defer the DisplayChangeListener
update/switch/refresh operations to the UI thread. The
current patchset has those be synchronous deferrals, so
you could get a deadlock if the UI thread is waiting
for the iothread lock, but the code in the UI midlayer
is holding the iothread lock and waiting for a DCL
operation to be run on the main thread.

What are the required semantics for update/switch/refresh?
These don't seem to be documented. Can we validly make
those be asychronous, or does the midlayer require that
the operation has completed and been reflected onscreen
before the update/switch/refresh callback returns ?

If those have to be synchronous, then we'll need to do
something more complicated (eg the queuing of events
that you suggest), which I'd prefer it if we can avoid,
because that implies memory allocation or a fixed
length queue (plus some fairly significant restructuring
of the cocoa frontend).

thanks
-- PMM
