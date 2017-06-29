Received: from eggs.gnu.org ([2001:4830:134:3::10]:42452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=346f73eb6=Paul.Durrant@citrix.com>)
	id 1dQV2v-0004N3-8s
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 04:43:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=346f73eb6=Paul.Durrant@citrix.com>)
	id 1dQV2s-0004H6-1H
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 04:43:29 -0400
Received: from smtp.eu.citrix.com ([185.25.65.24]:57827)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=346f73eb6=Paul.Durrant@citrix.com>)
	id 1dQV2r-0004GK-M0
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 04:43:25 -0400
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Thu, 29 Jun 2017 08:43:22 +0000
Message-ID: <3f4d040dbf344b9db3e007484a8062f4@AMSPEX02CL03.citrite.net>
References: <CAFEAcA-wYgWeYdFRAcW-DhqsFRsy_iKF+WU6qt7UbUKZ+EK1eg@mail.gmail.com>
	<alpine.DEB.2.10.1706271438090.24648@sstabellini-ThinkPad-X260>
	<CAFEAcA8yUHuBj2SUhL++7-NiBvHrcxRCH=Yq6TsNGrN4NXVV-w@mail.gmail.com>
	<alpine.DEB.2.10.1706281109340.2919@sstabellini-ThinkPad-X260>
In-Reply-To: <alpine.DEB.2.10.1706281109340.2919@sstabellini-ThinkPad-X260>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] Getting rid of xen_init_display() (and its dubious
 call into main_loop_wait())
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Stefano Stabellini' <sstabellini@kernel.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Anthony Perard <anthony.perard@citrix.com>, Gerd Hoffmann <kraxel@redhat.com>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>

> -----Original Message-----
> From: Stefano Stabellini [mailto:sstabellini@kernel.org]
> Sent: 28 June 2017 19:20
> To: Peter Maydell <peter.maydell@linaro.org>
> Cc: Stefano Stabellini <sstabellini@kernel.org>; QEMU Developers <qemu-
> devel@nongnu.org>; Anthony Perard <anthony.perard@citrix.com>; Gerd
> Hoffmann <kraxel@redhat.com>; Paul Durrant <Paul.Durrant@citrix.com>;
> xen-devel@lists.xenproject.org
> Subject: Re: Getting rid of xen_init_display() (and its dubious call into
> main_loop_wait())
>=20
> On Wed, 28 Jun 2017, Peter Maydell wrote:
> > On 28 June 2017 at 01:06, Stefano Stabellini <sstabellini@kernel.org>
> wrote:
> > > On Tue, 27 Jun 2017, Peter Maydell wrote:
> > >> So, there is exactly one caller of main_loop_wait() in the tree that
> > >> passes it 'true' as an argument. That caller is in xen_init_display(=
)
> > >> in hw/dispaly/xenfb.c. The function was added in 2009 with the
> comment
> > >> "FIXME/TODO: Kill this. Temporary needed while DisplayState
> > >> reorganization is in flight."
> > >>
> > >> I'd like to think that we've now completed whatever reorg that was,
> > >> 8 years on, so can we now get rid of this function? It definitely
> > >> seems very dubious to have a display init function with a busy loop
> > >> and a call into main_loop_wait()...
> > >
> > > LOL, you gotta love "temporary fixes". I am happy to see it wasn't me
> > > that added it ;-)
> > >
> > > I think the following should do the trick.
> >
> > Thanks!
> >
> > > ---
> > >
> > > xenfb: remove xen_init_display "temporary" hack
> > >
> > > Initialize xenfb properly, as all other backends, from its own
> > > "initialise" function.
> > >
> > > Signed-off-by: Stefano Stabellini <sstabellini@kernel.org>
> > >
> > > diff --git a/hw/display/xenfb.c b/hw/display/xenfb.c
> > > index e76c0d8..873e51f 100644
> > > --- a/hw/display/xenfb.c
> > > +++ b/hw/display/xenfb.c
> > > @@ -71,7 +71,6 @@ struct XenFB {
> > >      int               fbpages;
> > >      int               feature_update;
> > >      int               bug_trigger;
> > > -    int               have_console;
> > >      int               do_resize;
> > >
> > >      struct {
> > > @@ -80,6 +79,7 @@ struct XenFB {
> > >      int               up_count;
> > >      int               up_fullscreen;
> > >  };
> > > +static const GraphicHwOps xenfb_ops;
> > >
> > >  /* -----------------------------------------------------------------=
--- */
> > >
> > > @@ -855,6 +855,8 @@ static int fb_init(struct XenDevice *xendev)
> > >  static int fb_initialise(struct XenDevice *xendev)
> > >  {
> > >      struct XenFB *fb =3D container_of(xendev, struct XenFB, c.xendev=
);
> > > +    struct XenDevice *xin;
> > > +    struct XenInput *in;
> > >      struct xenfb_page *fb_page;
> > >      int videoram;
> > >      int rc;
> > > @@ -877,16 +879,12 @@ static int fb_initialise(struct XenDevice
> *xendev)
> > >      if (rc !=3D 0)
> > >         return rc;
> > >
> > > -#if 0  /* handled in xen_init_display() for now */
> > > -    if (!fb->have_console) {
> > > -        fb->c.ds =3D graphic_console_init(xenfb_update,
> > > -                                        xenfb_invalidate,
> > > -                                        NULL,
> > > -                                        NULL,
> > > -                                        fb);
> > > -        fb->have_console =3D 1;
> > > -    }
> > > -#endif
> > > +    fb->c.con =3D graphic_console_init(NULL, 0, &xenfb_ops, fb);
> > > +
> > > +    xin =3D xen_pv_find_xendev("vkbd", xen_domid, 0);
> > > +    in =3D container_of(xin, struct XenInput, c.xendev);
> > > +    in->c.con =3D fb->c.con;
> >
> > Won't this crash if xen_pv_find_xendev() returned NULL?
> > Or are we guaranteed that that can't happen here?
>=20
> As long as there is a vkdb device, it will be already added to the
> xendevs list at this point. However, if there isn't a device at all,
> then it would crash. In that case, I think we should print a warning and
> continue without it.
>=20
> I'll send an updated patch.

There is still the fact the vkbd can't initialise until vfb has done so. Th=
is interdependency is subtle and IMO bogus. It needs to be cleared up.

  Paul
