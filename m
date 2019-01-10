Received: from eggs.gnu.org ([209.51.188.92]:37341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ghYJO-0004Vh-Qc
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 06:15:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ghYJI-0001YX-SG
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 06:15:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59436)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ghYJG-0001Sy-Qs
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 06:15:40 -0500
Date: Thu, 10 Jan 2019 11:15:17 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190110111517.GB2589@work-vm>
References: <20190110020259.8492-1-ehabkost@redhat.com>
	<20190110020259.8492-4-ehabkost@redhat.com>
	<CAJ+F1C+cADS2WKysnEzH-ZD=C3uj5wymQFXtd4L9BOO2cjbjvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAJ+F1C+cADS2WKysnEzH-ZD=C3uj5wymQFXtd4L9BOO2cjbjvA@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 3/3] virtio: Make
 disable-legacy/disable-modern compat properties optional
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, QEMU <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>

* Marc-Andr=E9 Lureau (marcandre.lureau@gmail.com) wrote:
> Hi
>=20
> On Thu, Jan 10, 2019 at 6:05 AM Eduardo Habkost <ehabkost@redhat.com> w=
rote:
> >
> > The disable-legacy and disable-modern properties apply only to
> > some virtio-pci devices.  Make those properties optional.
> >
> > This fixes the crash introduced by commit f6e501a28ef9 ("virtio: Prov=
ide
> > version-specific variants of virtio PCI devices"):
> >
> >   $ qemu-system-x86_64 -machine pc-i440fx-2.6 \
> >     -device virtio-net-pci-non-transitional
> >   Unexpected error in object_property_find() at qom/object.c:1092:
> >   qemu-system-x86_64: -device virtio-net-pci-non-transitional: can't =
apply \
> >   global virtio-pci.disable-modern=3Don: Property '.disable-modern' n=
ot found
> >   Aborted (core dumped)
> >
> > Reported-by: Thomas Huth <thuth@redhat.com>
> > Fixes: f6e501a28ef9 ("virtio: Provide version-specific variants of vi=
rtio PCI devices")
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> >  hw/core/machine.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > index 5530b71981..a19143aa44 100644
> > --- a/hw/core/machine.c
> > +++ b/hw/core/machine.c
> > @@ -91,8 +91,9 @@ const size_t hw_compat_2_7_len =3D G_N_ELEMENTS(hw_=
compat_2_7);
> >
> >  GlobalProperty hw_compat_2_6[] =3D {
> >      { "virtio-mmio", "format_transport_address", "off" },
> > -    { "virtio-pci", "disable-modern", "on" },
> > -    { "virtio-pci", "disable-legacy", "off" },
> > +    /* Optional because not all virtio-pci devices support legacy mo=
de */
> > +    { "virtio-pci", "disable-modern", "on",  .optional =3D true },
> > +    { "virtio-pci", "disable-legacy", "off", .optional =3D true },
>=20
> Could the generic devices implement a specific interface instead?
> virtio-pci-generic?
>=20
> Adding "optional" handling looks like it may hide some other errors.

I think it would be OK if it only ignored the non-existent property
errors (or better, tested for their existence and then skipped if
they weren't there).

Dave

> >  };
> >  const size_t hw_compat_2_6_len =3D G_N_ELEMENTS(hw_compat_2_6);
> >
> > --
> > 2.18.0.rc1.1.g3f1ff2140
> >
> >
>=20
>=20
> --=20
> Marc-Andr=E9 Lureau
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
