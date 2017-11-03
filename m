Received: from eggs.gnu.org ([2001:4830:134:3::10]:46576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eAZKI-0008Jo-ML
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 06:35:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eAZKF-00033b-Hq
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 06:35:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44406)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eAZKF-00033L-9D
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 06:35:47 -0400
Message-ID: <1509705342.31823.16.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 03 Nov 2017 11:35:42 +0100
In-Reply-To: <CAFEAcA8RbiuAwwW4oqD_i2NGMeAao8KU=pWP7faM0QbajHgMYw@mail.gmail.com>
References: <20171023210803.20998-1-makovick@gmail.com>
	<20171023210803.20998-5-makovick@gmail.com>
	<1509532830.3856.7.camel@redhat.com>
	<CAHmvugcYmaujAYGwpb+ObistFr522W1XsuV-6jUgi543VgfvTA@mail.gmail.com>
	<1509701213.31823.11.camel@redhat.com>
	<CAFEAcA8RbiuAwwW4oqD_i2NGMeAao8KU=pWP7faM0QbajHgMYw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/7] sdl2: Only accept the hotkeys on the
 main window
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Jind=C5=99ich_Makovi=C4=8Dka?= <makovick@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>

On Fri, 2017-11-03 at 09:37 +0000, Peter Maydell wrote:
> On 3 November 2017 at 09:26, Gerd Hoffmann <kraxel@redhat.com> wrote:
> > Ignoring autorepeat events (as the patch does, but which the commit
> > message doesn't mention) makes sense.=C2=A0=C2=A0But I still fail to =
see why
> > we
> > should limit hotkeys to the main window.
>=20
> Is there documentation about how the input subsystem wants to
> handle autorepeat? (ie how UI frontends should present repeating
> keys to it, and how keyboard backends should expect to see
> repeating keys delivered from it). There's been discussion on
> this in another thread about xenfb and vnc...

Well, that issue didn't got much attention, probably due to the fact
that the linux kernel does autorepeat in software anyway so at least
for linux guests it doesn't matter at all what qemu is doing here.

Currently the input layer doesn't special-case repeat events in any
way, so they are just passed through to the device in case the ui
submits them.

>From a design point of view I think it makes sense to have UIs send
only keydown and keyup events and not any repeat events.  Then leave it
to the device emulation (i.e. ps/2 kbs) to actually generate repeat
events.  That is the only way the repeat rate programmed by the guest
will work as expected.

> Also I think it would be nice to have written up what the
> "expected" set of hotkeys for UI frontends are, so we can
> be consistent. I think SDL and gtk are different about what
> their ungrab keycombo is, for instance. (I've been assuming
> gtk is the "this is the right behaviour" exemplar to follow.)

That is another mess I'll plan to look at, because I want rework the
display command line switches parsing.  So, the current state is:

gtk ungrab is ctrl-alt-g.
sdl ungrab is ctrl-alt (by default, but see below).
cocoa ungrab is ctl-alt too.
For reference: virt-viewer (vnc/spice client) likewise uses ctrl-alt.

So it seems gtk is the odd one here.  Possibly due to how hotkeys are
implemented in gtk, could be a GtkAccelGroup simply doesn't support
modifier-only hotkeys.

Also:  We have a -alt-grab switch which makes sdl use the ctrl-alt-
shift modifier combo (for both ungrab and the other hotkeys).  We have
a -ctrl-grab switch which makes sdl use the right ctrl key (again for
both ungrab and hotkeys).

While being at it:  We have a -no-frame switch which makes sdl disable
the window frame, but it works on sdl1 only and nobody complained so
far ...

I'm tempted to just drop support for -alt-grab, -ctrl-grab and -no-
frame switches.

cheers,
  Gerd
