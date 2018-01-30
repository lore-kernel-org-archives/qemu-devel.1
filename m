Received: from eggs.gnu.org ([2001:4830:134:3::10]:57765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1egUs0-0004ei-9j
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 07:18:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1egUrq-00022X-Dn
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 07:18:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39292)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1egUrq-000221-5R
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 07:18:26 -0500
Date: Tue, 30 Jan 2018 13:18:23 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180130121823.7h4brwivh7653znu@sirius.home.kraxel.org>
References: <20180126214731.23506-1-programmingkidx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180126214731.23506-1-programmingkidx@gmail.com>
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
To: John Arbuckle <programmingkidx@gmail.com>
Cc: peter.maydell@linaro.org, berrange@redhat.com, qemu-devel@nongnu.org

On Fri, Jan 26, 2018 at 04:47:31PM -0500, John Arbuckle wrote:
> Currently the ungrab keys for the Cocoa and GTK interface are Control-Alt-g.

SDL is the same now, for consistency.

> This combination may not be very fun for the user to have to enter, so we
> now enable the user to specify their own key(s) as the ungrab key(s).

What about the other hotkeys?

There is fullscreen.  Ctrl-Alt-F for SDL and GTK.  Cmd-F for cocoa, but
it works only if the grab is not active.

Console select (Ctrl-Alt-<nr>), works for SDL and GTK.  When I read the
code correctly it should work for cocoa the same way, but it doesn't
work for me.  Dunno why.

Quit. Ctrl-Alt-Q on gtk.  Cmd-Q on cocoa, again only working without
keyboard grab.  Nothing on SDL.  Just closing the window to quit works
on GTK and SDL, both have a switch to turn it off.

[ ... list of hotkeys is incomplete, there is more, most of them working
      in some of the user interfaces only ... ]

There is the -ctrl-grab switch.  Changes all hotkeys from Ctrl-Alt-<key>
to Ctrl-<key>.  SDL only.  I want deprecate it.

There is the -alt-grab switch.  Changes all hotkeys from Ctrl-Alt-<key>
to Ctrl-Alt-Shift-<key>.  SDL only.  I want deprecate it too.


When touching this mess I want move to something more consistent.


> Syntax: -ungrab <key-key-key>

As mentioned earlier: New toplevel switch isn't going to fly.  Should be
a suboption of -display.

> Example usage:  -ungrab home
> 	        -ungrab shift-ctrl

Modifier-only hotkeys are tricky with gtk (doable, but no support for
that in the toolkit).

> 		-ungrab ctrl-x
> 		-ungrab pgup-pgdn

Really?  Two non-modifier keys?  How is that implemented?  Do you queue
up the pgup keypress, waiting to see whenever pgdn is pressed too, then
only in case that didn't happen forward the queued pgup key to the guest?

Making this work properly without unpleasent surprises in corner cases
doesn't look easy to me.  Needless to say that the gtk toolkit doesn't
support this either.


I think we should limit ourself to key combinations which have one
non-modifier key and optionally one or more modifier keys.  That should
be supportable in all user interfaces we have.  Except curses, modifier
key handling in unix terminals is a completely different world ...

When it comes to defining hotkeys I see basically two possible
ways to do it:

  (1) Have a fixed (set of) modifier keys for all hot keys,
      i.e. something like this:

         -display gtk,hotkey-modifiers=ctrl+shift,hotkey-grab=f12,hotkey-fullscreen=f11

  (2) Allow complete freedom when defining hotkeys, i.e.

         -display gtk,hotkey-grab=shift+f12,hotkey-fullscreen=ctrl+f11

Variant (1) provides a simple way to use other modifiers for all
hotkeys, simliar to the existing -alt-grab switch.  I also expect
it is easier to implement.

Another question is whenever we want allow defining different hotkeys
for the same thing.  So fullscreen could have both F11 (which is a
common hotkey in various apps, for example firefox) and Ctrl-Alt-F.
Might be useful, but also makes the implementation more complex.

I think we should clarify those questions before working on patches.

cheers,
  Gerd
