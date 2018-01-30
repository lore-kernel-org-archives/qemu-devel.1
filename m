Received: from eggs.gnu.org ([2001:4830:134:3::10]:57243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1egaDP-0007aS-Eb
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 13:02:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1egaCp-00025g-97
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 13:01:03 -0500
Received: from mail-io0-x235.google.com ([2607:f8b0:4001:c06::235]:42729)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1egaCo-00024Z-Rp
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 13:00:27 -0500
Received: by mail-io0-x235.google.com with SMTP id 25so12393997ioj.9
	for <qemu-devel@nongnu.org>; Tue, 30 Jan 2018 10:00:26 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <20180130121823.7h4brwivh7653znu@sirius.home.kraxel.org>
Date: Tue, 30 Jan 2018 13:00:22 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <F79229CE-D35E-4895-A632-4211A7C526D8@gmail.com>
References: <20180126214731.23506-1-programmingkidx@gmail.com>
	<20180130121823.7h4brwivh7653znu@sirius.home.kraxel.org>
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
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: peter.maydell@linaro.org, berrange@redhat.com, qemu-devel@nongnu.org


> On Jan 30, 2018, at 7:18 AM, Gerd Hoffmann <kraxel@redhat.com> wrote:
>=20
> On Fri, Jan 26, 2018 at 04:47:31PM -0500, John Arbuckle wrote:
>> Currently the ungrab keys for the Cocoa and GTK interface are =
Control-Alt-g.
>=20
> SDL is the same now, for consistency.
>=20
>> This combination may not be very fun for the user to have to enter, =
so we
>> now enable the user to specify their own key(s) as the ungrab key(s).
>=20
> What about the other hotkeys?
>=20
> There is fullscreen.  Ctrl-Alt-F for SDL and GTK.  Cmd-F for cocoa, =
but
> it works only if the grab is not active.

If has to be that way because the meta (command) key is sent to the =
guest when the mouse grab is in effect. I actually suggest the SDL and =
GTK interfaces send the meta (windows key on PC keyboard) key to the =
guest when a mouse grab is in effect. This way guest operating systems =
like Mac OS X can use keyboard shortcuts.=20

> Console select (Ctrl-Alt-<nr>), works for SDL and GTK.  When I read =
the
> code correctly it should work for cocoa the same way, but it doesn't
> work for me.  Dunno why.=20

I know this code was broken in cocoa for a while but I made the patch =
that fixes this problem. Console selection does work correctly using a =
recent git version of QEMU.

> Quit. Ctrl-Alt-Q on gtk.  Cmd-Q on cocoa, again only working without
> keyboard grab.  Nothing on SDL.  Just closing the window to quit works
> on GTK and SDL, both have a switch to turn it off.

I know Command-Q is the standard Macintosh keyboard short for quitting =
an application. With GTK I would imagine it would depend on how the host =
operating system expects applications to be built. I don't think Windows =
and Linux have a standard keyboard shortcut for quitting an application.=20=


>=20
> [ ... list of hotkeys is incomplete, there is more, most of them =
working
>      in some of the user interfaces only ... ]
>=20
> There is the -ctrl-grab switch.  Changes all hotkeys from =
Ctrl-Alt-<key>
> to Ctrl-<key>.  SDL only.  I want deprecate it.
>=20
> There is the -alt-grab switch.  Changes all hotkeys from =
Ctrl-Alt-<key>
> to Ctrl-Alt-Shift-<key>.  SDL only.  I want deprecate it too.

Sounds like a good idea. It would help to keep things consistent between =
the UI's.

>=20
> When touching this mess I want move to something more consistent.
>=20
>=20
>> Syntax: -ungrab <key-key-key>
>=20
> As mentioned earlier: New toplevel switch isn't going to fly.  Should =
be
> a suboption of -display.

Is this good?:
-display ungrab=3D<key>...=20

<looks further down the email>.=20

Ok I see what you want:

-display =
gtk,hotkey-modifiers=3Dctrl+shift,hotkey-grab=3Df12,hotkey-fullscreen=3Df1=
1

-display =
cocoa,hotkey-modifiers=3DCommand,hotkey-grab=3Df13,hotkey-fullscreen=3Df14=


I assume hotkey-modifiers is used to set the meta key. Is hotkey-grab =
the key
used to ungrab the mouse? If it is shouldn't it be called hotkey-ungrab?


>=20
>> Example usage:  -ungrab home
>> 	        -ungrab shift-ctrl
>=20
> Modifier-only hotkeys are tricky with gtk (doable, but no support for
> that in the toolkit).
>=20
>> 		-ungrab ctrl-x
>> 		-ungrab pgup-pgdn
>=20
> Really?  Two non-modifier keys?
Yes. The ungrab sequence could be a-b-c and still allow these keys to be =
used in the guest.

>  How is that implemented?  Do you queue
> up the pgup keypress, waiting to see whenever pgdn is pressed too, =
then
> only in case that didn't happen forward the queued pgup key to the =
guest?

Basically there is a array that acts as a check list. It checks off keys =
that belong to the ungrab sequence as they are detected. Once a =
non-ungrab key is detected, the check list is cleared. If all the ungrab =
keys are detected the ungrab code is executed. This only happens on =
keyup events. That way if Control-ALT were the ungrab keys, sending =
Control-ALT-Delete to the guest is still possible because these are the =
keys detected on the keyup event. The Delete key would have cleared the =
check list. Daniel Berrange is the one I can thank for this idea. He =
might be able to explain it better than me.

> Making this work properly without unpleasent surprises in corner cases
> doesn't look easy to me.  Needless to say that the gtk toolkit doesn't
> support this either.

I know it sounds hard to implement but it really isn't. It is just =
knowing which pieces fit where. The keyup and keydown events is where =
most of the action takes place.

> I think we should limit ourself to key combinations which have one
> non-modifier key and optionally one or more modifier keys.  That =
should
> be supportable in all user interfaces we have.  Except curses, =
modifier
> key handling in unix terminals is a completely different world ...
>=20
> When it comes to defining hotkeys I see basically two possible
> ways to do it:
>=20
>  (1) Have a fixed (set of) modifier keys for all hot keys,
>      i.e. something like this:
>=20
>         -display =
gtk,hotkey-modifiers=3Dctrl+shift,hotkey-grab=3Df12,hotkey-fullscreen=3Df1=
1
>=20
>  (2) Allow complete freedom when defining hotkeys, i.e.
>=20
>         -display gtk,hotkey-grab=3Dshift+f12,hotkey-fullscreen=3Dctrl+f1=
1
>=20
> Variant (1) provides a simple way to use other modifiers for all
> hotkeys, simliar to the existing -alt-grab switch.  I also expect
> it is easier to implement.

Choice 2 sounds really nice. It does give the user total freedom to =
customize QEMU
as seen fit.

> Another question is whenever we want allow defining different hotkeys
> for the same thing.  So fullscreen could have both F11 (which is a
> common hotkey in various apps, for example firefox) and Ctrl-Alt-F.
> Might be useful, but also makes the implementation more complex.

Assigning two different keyboard shortcuts to the same feature might be =
problematic.
Keeping things to one keyboard shortcut is probably the simple thing to =
do.

>=20
> I think we should clarify those questions before working on patches.

Agreed.

>=20
> cheers,
>  Gerd

Thank you for the clarification.=20
