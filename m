Received: from eggs.gnu.org ([2001:4830:134:3::10]:35942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gWm4D-0004kh-Hw
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 12:43:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gWm4A-0005Wf-VL
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 12:43:33 -0500
Date: Tue, 11 Dec 2018 15:43:03 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181211174303.GG7141@habkost.net>
References: <20181204142023.15982-1-marcandre.lureau@redhat.com>
	<20181204142023.15982-9-marcandre.lureau@redhat.com>
	<20181211142310.GB20015@habkost.net>
	<CAJ+F1CKF7_MEtZNY2FEot9dG-RZQwGeZZ7+3+q1QgD98koF2SA@mail.gmail.com>
	<20181211165229.744f0c07@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181211165229.744f0c07@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.2 v5 08/19] hw: apply machine compat
 properties without touching globals
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, QEMU <qemu-devel@nongnu.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Qemu-s390x list <qemu-s390x@nongnu.org>, "open list:ARM" <qemu-arm@nongnu.org>, "open list:sPAPR pseries" <qemu-ppc@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>

On Tue, Dec 11, 2018 at 04:52:29PM +0100, Igor Mammedov wrote:
> On Tue, 11 Dec 2018 18:30:32 +0400
> Marc-Andr=E9 Lureau <marcandre.lureau@gmail.com> wrote:
>=20
> > Hi
> >=20
> > On Tue, Dec 11, 2018 at 6:24 PM Eduardo Habkost <ehabkost@redhat.com>=
 wrote:
> > >
> > > I have specific questions about the approach we are using to
> > > eliminate the macros.
> > >
> > > My main goal when asking this to be moved to a separate patch is
> > > to not make this discussion block the register_global_properties() =
&
> > > device_post_init() changes (which look good to me).
> > >
> > >
> > > On Tue, Dec 04, 2018 at 06:20:12PM +0400, Marc-Andr=E9 Lureau wrote=
:
> > > [...] =20
> > > > -#define VIRT_COMPAT_3_0 \
> > > > +static GlobalProperty virt_compat_3_0[] =3D {
> > > >      HW_COMPAT_3_0
> > > > +}; =20
> > >
> > > What about moving the array inside virt_machine_3_0_options()? =20
> >=20
> > Sure
> >=20
> > > =20
> > > >
> > > >  static void virt_3_0_instance_init(Object *obj)
> > > >  {
> > > > @@ -1883,12 +1884,14 @@ static void virt_3_0_instance_init(Object=
 *obj)
> > > >  static void virt_machine_3_0_options(MachineClass *mc)
> > > >  {
> > > >      virt_machine_3_1_options(mc);
> > > > -    SET_MACHINE_COMPAT(mc, VIRT_COMPAT_3_0);
> > > > +    compat_props_add(mc->compat_props,
> > > > +                     virt_compat_3_0, G_N_ELEMENTS(virt_compat_3=
_0));
> > > >  }
> > > >  DEFINE_VIRT_MACHINE(3, 0) =20
> > >
> > > This is nice, because it's basically the same amount of
> > > boilerplate code, but I would find a NULL-terminated array much
> > > easier to use than having to use G_N_ELEMENTS(). =20
> >=20
> > But easier to get wrong too. I prefer the explicit N arguments. (it
> > also gives some flexibility, since you can point to inner pointer +
> > size, although we don't care at this point)
> +1 to explicit array size,
> it also allows to drop terminating NULL entry in compat declarations

I don't mind using G_N_ELEMENTS if you really think it's better,
but I wonder if it will be an obstacle for making
  compat_props_add(compat_props, hw_compat_3_0, ...)
work, because the size of hw_compat_3_0 won't be known by
compat.h or spapr.c.

--=20
Eduardo
