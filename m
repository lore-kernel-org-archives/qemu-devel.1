Received: from eggs.gnu.org ([2001:4830:134:3::10]:40115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1eh1Di-0007UF-Mt
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 17:51:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1eh1Df-0001tF-Jd
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 17:51:10 -0500
Received: from mail-io0-x235.google.com ([2607:f8b0:4001:c06::235]:46440)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1eh1Df-0001su-Co
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 17:51:07 -0500
Received: by mail-io0-x235.google.com with SMTP id f34so17009075ioi.13
	for <qemu-devel@nongnu.org>; Wed, 31 Jan 2018 14:51:07 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <20180131090310.e4jlhu7euyeompkh@sirius.home.kraxel.org>
Date: Wed, 31 Jan 2018 17:51:04 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <655BB356-66E8-4AC4-8EC4-47E3E2DA6B36@gmail.com>
References: <20180126214731.23506-1-programmingkidx@gmail.com>
	<20180130121823.7h4brwivh7653znu@sirius.home.kraxel.org>
	<F79229CE-D35E-4895-A632-4211A7C526D8@gmail.com>
	<20180131090310.e4jlhu7euyeompkh@sirius.home.kraxel.org>
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


> On Jan 31, 2018, at 4:03 AM, Gerd Hoffmann <kraxel@redhat.com> wrote:
>=20
>>> What about the other hotkeys?
>>>=20
>>> There is fullscreen.  Ctrl-Alt-F for SDL and GTK.  Cmd-F for cocoa, =
but
>>> it works only if the grab is not active.
>>=20
>> If has to be that way because the meta (command) key is sent to the
>> guest when the mouse grab is in effect. I actually suggest the SDL =
and
>> GTK interfaces send the meta (windows key on PC keyboard) key to the
>> guest when a mouse grab is in effect. This way guest operating =
systems
>> like Mac OS X can use keyboard shortcuts.=20
>=20
> Well, the modifier key changes are actually sent to the guest, but
> usually they have no effect there.
>=20
> So, if you press Ctrl-Alt-F, the guest will see the keydown and keyup
> events for ctrl and alt.  It will not see the 'f', because SDL hijacks
> that.

Maybe the f could be sent to the guest directly via =
qemu_input_event_send_key_qcode().

>=20
>>> Console select (Ctrl-Alt-<nr>), works for SDL and GTK.  When I read =
the
>>> code correctly it should work for cocoa the same way, but it doesn't
>>> work for me.  Dunno why.=20
>>=20
>> I know this code was broken in cocoa for a while but I made the patch
>> that fixes this problem. Console selection does work correctly using =
a
>> recent git version of QEMU.
>=20
> Just pulled latest master and recompiled, still not working for me.
> This is sierra in a vm.

What software do you use to run the VM? It could be possible the VM =
software is interfering with the ungrab keys.

> Unrelated side note: hvf doesn't work for me too (nested on kvm).

I haven't played with this new feature yet. Maybe I will try it out one =
day.

>=20
>>> Quit. Ctrl-Alt-Q on gtk.  Cmd-Q on cocoa, again only working without
>>> keyboard grab.  Nothing on SDL.  Just closing the window to quit =
works
>>> on GTK and SDL, both have a switch to turn it off.
>>=20
>> I know Command-Q is the standard Macintosh keyboard short for =
quitting
>> an application. With GTK I would imagine it would depend on how the
>> host operating system expects applications to be built. I don't think
>> Windows and Linux have a standard keyboard shortcut for quitting an
>> application.=20
>=20
> On Linux Ctrl-Q seems to be common (maybe only in the gnome world).
> On Windows Alt-F4 should be standard.
>=20
> Qemu picked two-modifier hot-keys (like Ctrl-Alt-Q) to avoid overlaps
> with guest hot keys, so both qemu and guest hotkeys can be used =
without
> having to deal with keyboard/mouse grabs all the time.
>=20
>> Ok I see what you want:
>>=20
>> -display =
gtk,hotkey-modifiers=3Dctrl+shift,hotkey-grab=3Df12,hotkey-fullscreen=3Df1=
1
>>=20
>> -display =
cocoa,hotkey-modifiers=3DCommand,hotkey-grab=3Df13,hotkey-fullscreen=3Df14=

>=20
> I think that would be "super" not "Command" because that is the name =
for
> the key in the pc world so this is what the key got as QKeyCode name.
>=20
>> I assume hotkey-modifiers is used to set the meta key.
>=20
> Yes.
>=20
>> Is hotkey-grab the key used to ungrab the mouse?
>=20
> Yes (keyboard grab too).
>=20
>> If it is shouldn't it be called hotkey-ungrab?
>=20
> Good question.  On gtk/sdl Ctrl-Alt-G actually toggles the grab, i.e.
> can do *both* grab and ungrab.  But I expect most users use it for
> ungrab only, due to mouse clicks activating the grab too.
>=20
>>>> Example usage:  -ungrab home
>>>> 	        -ungrab shift-ctrl
>>>=20
>>> Modifier-only hotkeys are tricky with gtk (doable, but no support =
for
>>> that in the toolkit).
>>>=20
>>>> 		-ungrab ctrl-x
>>>> 		-ungrab pgup-pgdn
>>>=20
>>> Really?  Two non-modifier keys?
>> Yes. The ungrab sequence could be a-b-c and still allow these keys to =
be used in the guest.
>>=20
>>> How is that implemented?  Do you queue
>>> up the pgup keypress, waiting to see whenever pgdn is pressed too, =
then
>>> only in case that didn't happen forward the queued pgup key to the =
guest?
>>=20
>> Basically there is a array that acts as a check list. It checks off
>> keys that belong to the ungrab sequence as they are detected. Once a
>> non-ungrab key is detected, the check list is cleared. If all the
>> ungrab keys are detected the ungrab code is executed. This only
>> happens on keyup events. That way if Control-ALT were the ungrab =
keys,
>> sending Control-ALT-Delete to the guest is still possible because
>> these are the keys detected on the keyup event. The Delete key would
>> have cleared the check list. Daniel Berrange is the one I can thank
>> for this idea. He might be able to explain it better than me.
>=20
> Hmm, ok.
>=20
> Doing the same for gtk would basically imply to not use any toolkit
> support for hotkeys ...
>=20
> It'll also become more difficuilt if we use that for multiple hotkeys.
>=20
> But possibly we can share the code across all UIs, now that =
keycodemapdb
> is used by qemu.  So first translate the keycode from the UI toolkit =
to
> a QKeyCode, then feed that into shared hotkey detection code.

Sounds like a good idea. I will be more than happy to help. My cocoa =
code
uses sets to implement keeping track of key presses. A set is a =
collection of data=20
that only allows for unique values. So no two items in a set can be the =
same
value. My patch uses cocoa's NSSet so the shared code would probably not =
be
able to use it. I don't currently know of an implementation of a set =
that is
in C and available for us to use, so we may have to implement it =
ourselves.=20

>=20
>>> I think we should limit ourself to key combinations which have one
>>> non-modifier key and optionally one or more modifier keys.  That
>>> should be supportable in all user interfaces we have.  Except
>>> curses, modifier key handling in unix terminals is a completely
>>> different world ...
>>>=20
>>> When it comes to defining hotkeys I see basically two possible ways
>>> to do it:
>>>=20
>>> (1) Have a fixed (set of) modifier keys for all hot keys, i.e.
>>> something like this:
>>>=20
>>>        -display =
gtk,hotkey-modifiers=3Dctrl+shift,hotkey-grab=3Df12,hotkey-fullscreen=3Df1=
1
>>>=20
>>> (2) Allow complete freedom when defining hotkeys, i.e.
>>>=20
>>>        -display gtk,hotkey-grab=3Dshift+f12,hotkey-fullscreen=3Dctrl+f=
11
>>>=20
>>> Variant (1) provides a simple way to use other modifiers for all
>>> hotkeys, simliar to the existing -alt-grab switch.  I also expect it
>>> is easier to implement.
>>=20
>> Choice 2 sounds really nice. It does give the user total freedom to
>> customize QEMU as seen fit.
>=20
> But on the other hand switching all hotkeys from ctrl-alt-<key> to
> ctrl-shift-<key> is alot of work with choice (2) because you have to
> redefine all hotkeys.  With choice (1) it is a simple
> "hotkey-modifiers=3Dctrl+shift".
>=20
> So both approaches have their specific advantages ...
>=20
>>> Another question is whenever we want allow defining different
>>> hotkeys for the same thing.  So fullscreen could have both F11
>>> (which is a common hotkey in various apps, for example firefox) and
>>> Ctrl-Alt-F.  Might be useful, but also makes the implementation more
>>> complex.
>>=20
>> Assigning two different keyboard shortcuts to the same feature might
>> be problematic.  Keeping things to one keyboard shortcut is probably
>> the simple thing to do.
>=20
> Yes.  I also think the added complexity needed isn't worth the =
benefits.
>=20
> cheers,
>  Gerd
>=20
