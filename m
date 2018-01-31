Received: from eggs.gnu.org ([2001:4830:134:3::10]:47272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1egoId-0003cC-AV
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 04:03:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1egoIV-0000Df-6o
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 04:03:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49840)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1egoIU-0000DF-UF
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 04:03:15 -0500
Date: Wed, 31 Jan 2018 10:03:10 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180131090310.e4jlhu7euyeompkh@sirius.home.kraxel.org>
References: <20180126214731.23506-1-programmingkidx@gmail.com>
	<20180130121823.7h4brwivh7653znu@sirius.home.kraxel.org>
	<F79229CE-D35E-4895-A632-4211A7C526D8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F79229CE-D35E-4895-A632-4211A7C526D8@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v5] cocoa.m: Add ability for user to
 specify mouse ungrab key
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>
Cc: peter.maydell@linaro.org, berrange@redhat.com, qemu-devel@nongnu.org

> > What about the other hotkeys?
> > 
> > There is fullscreen.  Ctrl-Alt-F for SDL and GTK.  Cmd-F for cocoa, but
> > it works only if the grab is not active.
> 
> If has to be that way because the meta (command) key is sent to the
> guest when the mouse grab is in effect. I actually suggest the SDL and
> GTK interfaces send the meta (windows key on PC keyboard) key to the
> guest when a mouse grab is in effect. This way guest operating systems
> like Mac OS X can use keyboard shortcuts. 

Well, the modifier key changes are actually sent to the guest, but
usually they have no effect there.

So, if you press Ctrl-Alt-F, the guest will see the keydown and keyup
events for ctrl and alt.  It will not see the 'f', because SDL hijacks
that.

> > Console select (Ctrl-Alt-<nr>), works for SDL and GTK.  When I read the
> > code correctly it should work for cocoa the same way, but it doesn't
> > work for me.  Dunno why. 
> 
> I know this code was broken in cocoa for a while but I made the patch
> that fixes this problem. Console selection does work correctly using a
> recent git version of QEMU.

Just pulled latest master and recompiled, still not working for me.
This is sierra in a vm.

Unrelated side note: hvf doesn't work for me too (nested on kvm).

> > Quit. Ctrl-Alt-Q on gtk.  Cmd-Q on cocoa, again only working without
> > keyboard grab.  Nothing on SDL.  Just closing the window to quit works
> > on GTK and SDL, both have a switch to turn it off.
> 
> I know Command-Q is the standard Macintosh keyboard short for quitting
> an application. With GTK I would imagine it would depend on how the
> host operating system expects applications to be built. I don't think
> Windows and Linux have a standard keyboard shortcut for quitting an
> application. 

On Linux Ctrl-Q seems to be common (maybe only in the gnome world).
On Windows Alt-F4 should be standard.

Qemu picked two-modifier hot-keys (like Ctrl-Alt-Q) to avoid overlaps
with guest hot keys, so both qemu and guest hotkeys can be used without
having to deal with keyboard/mouse grabs all the time.

> Ok I see what you want:
> 
> -display gtk,hotkey-modifiers=ctrl+shift,hotkey-grab=f12,hotkey-fullscreen=f11
> 
> -display cocoa,hotkey-modifiers=Command,hotkey-grab=f13,hotkey-fullscreen=f14

I think that would be "super" not "Command" because that is the name for
the key in the pc world so this is what the key got as QKeyCode name.

> I assume hotkey-modifiers is used to set the meta key.

Yes.

> Is hotkey-grab the key used to ungrab the mouse?

Yes (keyboard grab too).

> If it is shouldn't it be called hotkey-ungrab?

Good question.  On gtk/sdl Ctrl-Alt-G actually toggles the grab, i.e.
can do *both* grab and ungrab.  But I expect most users use it for
ungrab only, due to mouse clicks activating the grab too.

> >> Example usage:  -ungrab home
> >> 	        -ungrab shift-ctrl
> > 
> > Modifier-only hotkeys are tricky with gtk (doable, but no support for
> > that in the toolkit).
> > 
> >> 		-ungrab ctrl-x
> >> 		-ungrab pgup-pgdn
> > 
> > Really?  Two non-modifier keys?
> Yes. The ungrab sequence could be a-b-c and still allow these keys to be used in the guest.
> 
> >  How is that implemented?  Do you queue
> > up the pgup keypress, waiting to see whenever pgdn is pressed too, then
> > only in case that didn't happen forward the queued pgup key to the guest?
> 
> Basically there is a array that acts as a check list. It checks off
> keys that belong to the ungrab sequence as they are detected. Once a
> non-ungrab key is detected, the check list is cleared. If all the
> ungrab keys are detected the ungrab code is executed. This only
> happens on keyup events. That way if Control-ALT were the ungrab keys,
> sending Control-ALT-Delete to the guest is still possible because
> these are the keys detected on the keyup event. The Delete key would
> have cleared the check list. Daniel Berrange is the one I can thank
> for this idea. He might be able to explain it better than me.

Hmm, ok.

Doing the same for gtk would basically imply to not use any toolkit
support for hotkeys ...

It'll also become more difficuilt if we use that for multiple hotkeys.

But possibly we can share the code across all UIs, now that keycodemapdb
is used by qemu.  So first translate the keycode from the UI toolkit to
a QKeyCode, then feed that into shared hotkey detection code.

> > I think we should limit ourself to key combinations which have one
> > non-modifier key and optionally one or more modifier keys.  That
> > should be supportable in all user interfaces we have.  Except
> > curses, modifier key handling in unix terminals is a completely
> > different world ...
> > 
> > When it comes to defining hotkeys I see basically two possible ways
> > to do it:
> > 
> >  (1) Have a fixed (set of) modifier keys for all hot keys, i.e.
> >  something like this:
> > 
> >         -display gtk,hotkey-modifiers=ctrl+shift,hotkey-grab=f12,hotkey-fullscreen=f11
> > 
> >  (2) Allow complete freedom when defining hotkeys, i.e.
> > 
> >         -display gtk,hotkey-grab=shift+f12,hotkey-fullscreen=ctrl+f11
> > 
> > Variant (1) provides a simple way to use other modifiers for all
> > hotkeys, simliar to the existing -alt-grab switch.  I also expect it
> > is easier to implement.
> 
> Choice 2 sounds really nice. It does give the user total freedom to
> customize QEMU as seen fit.

But on the other hand switching all hotkeys from ctrl-alt-<key> to
ctrl-shift-<key> is alot of work with choice (2) because you have to
redefine all hotkeys.  With choice (1) it is a simple
"hotkey-modifiers=ctrl+shift".

So both approaches have their specific advantages ...

> > Another question is whenever we want allow defining different
> > hotkeys for the same thing.  So fullscreen could have both F11
> > (which is a common hotkey in various apps, for example firefox) and
> > Ctrl-Alt-F.  Might be useful, but also makes the implementation more
> > complex.
> 
> Assigning two different keyboard shortcuts to the same feature might
> be problematic.  Keeping things to one keyboard shortcut is probably
> the simple thing to do.

Yes.  I also think the added complexity needed isn't worth the benefits.

cheers,
  Gerd
