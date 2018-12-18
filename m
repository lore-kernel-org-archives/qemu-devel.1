Received: from eggs.gnu.org ([2001:4830:134:3::10]:54747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gZG1H-0007WU-2c
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:06:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gZG1B-0001rC-QK
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:06:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55804)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gZG1B-0001qi-DB
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:06:41 -0500
Date: Tue, 18 Dec 2018 13:27:22 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181218132722.GF22638@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <alpine.BSF.2.21.1803202324320.13789@zero.eik.bme.hu>
	<20180321140654.7h3nkkdlztu6mtrq@sirius.home.kraxel.org>
	<alpine.BSF.2.21.1803211803590.78606@zero.eik.bme.hu>
	<alpine.BSF.2.21.9999.1812171549220.8888@zero.eik.bme.hu>
	<f3d7a0ed-785d-4176-147d-26a4d58d1a36@ilande.co.uk>
	<20181218111603.GE22638@redhat.com>
	<alpine.BSF.2.21.9999.1812181242560.99784@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.BSF.2.21.9999.1812181242560.99784@zero.eik.bme.hu>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Monitor and serial output window broken with SDL2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

On Tue, Dec 18, 2018 at 02:11:35PM +0100, BALATON Zoltan wrote:
> On Tue, 18 Dec 2018, Daniel P. Berrang=C3=A9 wrote:
> > On Tue, Dec 18, 2018 at 10:54:06AM +0000, Mark Cave-Ayland wrote:
> > > On 17/12/2018 14:56, BALATON Zoltan wrote:
> > >=20
> > > > I still have this problem after updating everything on my machine=
, latest QEMU and
> > > > SDL 2.0.9 so it's not likely to be a bug in some external compone=
nt. If I just start
> > > > qemu-system-ppc (compiled with --disable-gtk) and try to open mon=
itor console with
> > > > Ctrl-Alt-2 I see QEMU monitor but when I type in this window the =
serial output window
> > > > contents flash in this window. At the same time the window that o=
pens for Ctrl-Alt-3
> > > > which should have the serial output is empty. It looks like an in=
dex may be off
> > > > somewhere or window contents are not associated with the right wi=
ndow but I have no
> > > > idea where to look for it. Can you reproduce it now and do you ha=
ve any idea what
> > > > could cause this?
> > >=20
> > > Are you using Fedora Core 29 at all? I know Howard has been experie=
ncing redraw
> > > issues since upgrading from FC 28 to FC 29. A couple of other thing=
s to check:
> >=20
> > There is no "Fedora Core" since Fedora Core 6, just Fedora :-P
> >=20
> > But seriously, I teted on Fedora 29 and didn't see any problem, so th=
ere
> > must be some more specific scenario that is hurting it.
> >=20
> > > 1) Does QEMU 3.0 work correctly? If so, a bisection would help.
> > > 2) Are you using an Nvidia graphics card with the nouveau driver?
> >=20
> > This second point is a good idea to consider.
>=20
> How is graphics card relevant for this? I do use NVidia but not nouveau=
 but
> vendor drivers (version 390.87) on Mageia 6 (which is a bit like Fedora=
 but
> may have differences). I have this problem for a while so I don't think=
 it's
> a recent regression. It only seems to affect qemu-system-ppc,
> qemu-system-x86_64 does open serial console all right but could be I wa=
s
> using different configure options for these.

Well SDL has to render stuff to the screen and that involves the graphics
card drivers. It is not uncommon to have rendering problems that only
affect certain vendor drivers. It might be something todo with the PPC
emulation that is tickling different code paths than x86, and that in
turn touches some undefined behaviour in SDL and/or the graphics driver.

So it would be relevant to test if you get the same behaviour when using
the nouveau drivers instead of nvidia vendor drivers.

> Parallel console for Ctrl-Alt-4 seems to work all right but that has no
> content. I'm not sure if it's relevant to have output in the serial win=
dow.
> For qemu-system-ppc OpenBIOS has some serial output. Now that I've trie=
d it
> does seem to be relevant: if I press Ctrl-Alt-3 right after QEMU starts=
 when
> the main screen still says "guest has not initialised" then it works bu=
t if
> I wait until OpenBIOS starts with yellow screen (and some output on ser=
ial)
> and then press Ctrl-Alt-3 then empty window opens so maybe it's related=
 to
> have some content on serial when window first opens?

I don't see any difference depending on whether I use Ctrl-Alt-3 before
or after the yellow screen - both work as expected. The fact that you
see a difference though does suggest that there's something odd being
done in the ppc emulation that is in turn doing something bad to SDLs
rendering with your graphics setup. I don't know what it could be though.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
