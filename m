Received: from eggs.gnu.org ([2001:4830:134:3::10]:36075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fYAqt-0003Ju-RU
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 09:51:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fYAqs-000556-OS
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 09:51:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48720 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fYAqs-00053u-Jg
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 09:51:18 -0400
Date: Wed, 27 Jun 2018 15:51:15 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180627135115.jk3d4mcuhmlznkc7@sirius.home.kraxel.org>
References: <20180627115836.25092-1-kraxel@redhat.com>
	<20180627115836.25092-2-kraxel@redhat.com>
	<10b74818-155c-bdc8-ca0e-c7239be35673@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <10b74818-155c-bdc8-ca0e-c7239be35673@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] warn about two vga cards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org

On Wed, Jun 27, 2018 at 10:10:17AM -0300, Philippe Mathieu-Daud=E9 wrote:
> Hi Gerd,
>=20
> On 06/27/2018 08:58 AM, Gerd Hoffmann wrote:
> > Two vga cards will listen on the same legacy (isa) ioports.  Due to t=
his
> > conflict only one of the two cards will work correctly in vga mode.
>=20
> The last one registered...
>=20
> > Print a warning message in that case.
> >=20
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > ---
> >  hw/display/vga.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >=20
> > diff --git a/hw/display/vga.c b/hw/display/vga.c
> > index c82e6d240a..a6c246f76b 100644
> > --- a/hw/display/vga.c
> > +++ b/hw/display/vga.c
> > @@ -2273,6 +2273,7 @@ MemoryRegion *vga_init_io(VGACommonState *s, Ob=
ject *obj,
> >  void vga_init(VGACommonState *s, Object *obj, MemoryRegion *address_=
space,
> >                MemoryRegion *address_space_io, bool init_vga_ports)
> >  {
> > +    static bool vgaports_registered;
> >      MemoryRegion *vga_io_memory;
> >      const MemoryRegionPortio *vga_ports, *vbe_ports;
> > =20
> > @@ -2289,6 +2290,11 @@ void vga_init(VGACommonState *s, Object *obj, =
MemoryRegion *address_space,
> >                                          1);
> >      memory_region_set_coalescing(vga_io_memory);
> >      if (init_vga_ports) {
> > +        if (vgaports_registered) {
> > +            warn_report("multiple vga cards may not work as expected=
");
> > +        } else {
> > +            vgaports_registered =3D true;
> > +        }
> >          portio_list_init(&s->vga_port_list, obj, vga_ports, s, "vga"=
);
>=20
> Here we leak s->vga_port_list->regions from the 1st card.
> Can we call portio_list_destroy() in the if (vgaports_registered) block=
?

We don't have a pointer at hand.  Easier would be to only register
the ports in the else block.

Or throw an error in the if (vgaports_registered) block instead of
printing a warning only.

Hmm ...

cheers,
  Gerd
