Received: from eggs.gnu.org ([209.51.188.92]:34013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guL4B-0002Xb-Rc
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 12:44:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guL16-00064U-Od
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 12:41:47 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:44901)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1guL0u-0005Rq-Gy
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 12:41:35 -0500
Received: by mail-ot1-x341.google.com with SMTP id g1so11852393otj.11
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 09:41:25 -0800 (PST)
MIME-Version: 1.0
References: <20190214102816.3393-1-peter.maydell@linaro.org>
	<20190214102816.3393-6-peter.maydell@linaro.org>
	<alpine.BSF.2.21.9999.1902141745470.64316@zero.eik.bme.hu>
In-Reply-To: <alpine.BSF.2.21.9999.1902141745470.64316@zero.eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Feb 2019 17:41:13 +0000
Message-ID: <CAFEAcA_hQVwGJoK17TzqcejiG+ycnt8rEAYwZ2Tub=H9Myj_Sw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 5/7] ui/cocoa: Don't call NSApp
 sendEvent directly from handleEvent
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

On Thu, 14 Feb 2019 at 17:04, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>
> On Thu, 14 Feb 2019, Peter Maydell wrote:
> > Currently the handleEvent method will directly call the NSApp
> > sendEvent method for any events that we want to let OSX deal
> > with. When we rearrange the event handling code, the way that
> > we say "let OSX have this event" is going to change. Prepare
> > for that by refactoring so that handleEvent returns a flag
> > indicating whether it consumed the event.
> >
> > Suggested-by: BALATON Zoltan <balaton@eik.bme.hu>
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---

> > +static bool bool_with_iothread_lock(BoolCodeBlock block)
> > +{
> > +    bool locked = qemu_mutex_iothread_locked();
> > +    bool val;
> > +
>
> Git complained about extra white space in the end of the empty line above
> but not sure if it was added during mailing or you have it in the original
> patch.

Almost certainly an error in the original patch. I'll fix it.

> > +    if (!locked) {
> > +        qemu_mutex_lock_iothread();
> > +    }
> > +    val = block();
> > +    if (!locked) {
> > +        qemu_mutex_unlock_iothread();
> > +    }
> > +    return val;
> > +}
> > +
> > // Mac to QKeyCode conversion
> > const int mac_to_qkeycode_map[] = {
> >     [kVK_ANSI_A] = Q_KEY_CODE_A,
> > @@ -320,8 +336,8 @@ - (void) grabMouse;
> > - (void) ungrabMouse;
> > - (void) toggleFullScreen:(id)sender;
> > - (void) handleMonitorInput:(NSEvent *)event;
> > -- (void) handleEvent:(NSEvent *)event;
> > -- (void) handleEventLocked:(NSEvent *)event;
> > +- (bool) handleEvent:(NSEvent *)event;
> > +- (bool) handleEventLocked:(NSEvent *)event;
> > - (void) setAbsoluteEnabled:(BOOL)tIsAbsoluteEnabled;
> > /* The state surrounding mouse grabbing is potentially confusing.
> >  * isAbsoluteEnabled tracks qemu_input_is_absolute() [ie "is the emulated
> > @@ -664,15 +680,16 @@ - (void) handleMonitorInput:(NSEvent *)event
> >     }
> > }
> >
> > -- (void) handleEvent:(NSEvent *)event
> > +- (bool) handleEvent:(NSEvent *)event
> > {
> > -    with_iothread_lock(^{
> > -        [self handleEventLocked:event];
> > +    return bool_with_iothread_lock(^{
> > +        return [self handleEventLocked:event];
> >     });
> > }
>
> If this is only ever used for this one method, wouldn't it be easier to
> move locking to the method below (even with some goto after setting a ret
> variable to unlock at the end of the method where now it returns in the
> middle, but maybe it could even be done without goto as the whole code is
> one big switch that can be exited with break and an if that can be skipped
> by a flag)? That may be easier to follow than this method within block
> within method and then you wouldn't need bool_with_iothread_lock and
> neither handleEvent. Unless there's something I'm missing which makes this
> convoluted way needed.

The aim was to avoid having to do changes to handleEvent's code flow
in order to do "run it with the lock held"; it also means that the
invariant "we always unlock the lock" is easy to confirm, whereas
if you do the lock/unlock inside a single handleEvent method you have
to look for whether it was done right in early-exit cases. It's
a bit less of a convincing argument than it was in v1 (where we were
making no changes to handleEvent at all other than wrapping it in a
lock), but I think it still makes sense this way.

> Other than that
> Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>

thanks
-- PMM
