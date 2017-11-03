Received: from eggs.gnu.org ([2001:4830:134:3::10]:48857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eAZUB-00034m-Ii
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 06:46:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eAZU8-0002jm-Dt
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 06:46:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45176)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eAZU8-0002jP-7P
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 06:46:00 -0400
Date: Fri, 3 Nov 2017 10:45:54 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171103104554.GG20155@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171023210803.20998-1-makovick@gmail.com>
	<20171023210803.20998-5-makovick@gmail.com>
	<1509532830.3856.7.camel@redhat.com>
	<CAHmvugcYmaujAYGwpb+ObistFr522W1XsuV-6jUgi543VgfvTA@mail.gmail.com>
	<1509701213.31823.11.camel@redhat.com>
	<CAFEAcA8RbiuAwwW4oqD_i2NGMeAao8KU=pWP7faM0QbajHgMYw@mail.gmail.com>
	<1509705342.31823.16.camel@redhat.com>
	<CAFEAcA_DbZ_1WxjtN5NiY3drFgqmJpZwxcrKSeYtqqkjkq0hUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA_DbZ_1WxjtN5NiY3drFgqmJpZwxcrKSeYtqqkjkq0hUA@mail.gmail.com>
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, =?utf-8?Q?Jind=C5=99ich_Makovi=C4=8Dka?= <makovick@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>

On Fri, Nov 03, 2017 at 10:41:35AM +0000, Peter Maydell wrote:
> On 3 November 2017 at 10:35, Gerd Hoffmann <kraxel@redhat.com> wrote:
> > On Fri, 2017-11-03 at 09:37 +0000, Peter Maydell wrote:
> >> Also I think it would be nice to have written up what the
> >> "expected" set of hotkeys for UI frontends are, so we can
> >> be consistent. I think SDL and gtk are different about what
> >> their ungrab keycombo is, for instance. (I've been assuming
> >> gtk is the "this is the right behaviour" exemplar to follow.)
> >
> > That is another mess I'll plan to look at, because I want rework the
> > display command line switches parsing.  So, the current state is:
> >
> > gtk ungrab is ctrl-alt-g.
> > sdl ungrab is ctrl-alt (by default, but see below).
> > cocoa ungrab is ctl-alt too.
> > For reference: virt-viewer (vnc/spice client) likewise uses ctrl-alt.
> >
> > So it seems gtk is the odd one here.  Possibly due to how hotkeys are
> > implemented in gtk, could be a GtkAccelGroup simply doesn't support
> > modifier-only hotkeys.
> 
> There's a patch in-flight to switch cocoa to ctrl-alt-g.
> (If you think that's a bad idea it would be useful to reply
> to that patch.)
> 
> Using plain ctrl-alt for ungrab has the disadvantage that you
> then can't send the guest any ctrl-alt-anything combos at all,
> I think.

You can deal with that by only processing the  ctrl-alt pair on key
release, and require that the immediately preceeding key press events
were also ctrl-alt.

eg require the specific sequence

  press(ctrl), press(alt), release(alt), release(ctrl)

and thus you can still do 

  press(ctrl), press(alt), press(a), release(a) release(alt), release(ctrl)

and have it go to the guest as normal

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
