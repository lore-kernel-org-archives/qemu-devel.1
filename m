Received: from eggs.gnu.org ([2001:4830:134:3::10]:45936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fQ2jg-00037u-LT
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 23:34:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fQ2jf-0000Cg-Gl
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 23:34:16 -0400
Date: Tue, 5 Jun 2018 13:34:01 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180605033401.GU5140@umbus.fritz.box>
References: <20180518164405.11804-1-clg@kaod.org>
	<20180518164405.11804-2-clg@kaod.org>
	<20180525160249.7cb0a5bc@bahia.lan>
	<82ee8b24-91d7-9396-82b7-be37200cfacd@redhat.com>
	<a567d42f-af8e-01da-5e0b-9b6f41c150cf@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rW45g2D1DgwV0HVw"
Content-Disposition: inline
In-Reply-To: <a567d42f-af8e-01da-5e0b-9b6f41c150cf@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 1/4] spapr: remove irq_hint parameter from
 spapr_irq_alloc()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Thomas Huth <thuth@redhat.com>, Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>


--rW45g2D1DgwV0HVw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 28, 2018 at 09:06:12AM +0200, C=E9dric Le Goater wrote:
> On 05/28/2018 08:17 AM, Thomas Huth wrote:
> > On 25.05.2018 16:02, Greg Kurz wrote:
> >> On Fri, 18 May 2018 18:44:02 +0200
> >> C=E9dric Le Goater <clg@kaod.org> wrote:
> >>
> >>> This IRQ number hint can possibly be used by the VIO devices if the
> >>> "irq" property is defined on the command line but it seems it is never
> >>> the case. It is not used in libvirt for instance. So, let's remove it
> >>> to simplify future changes.
> >>>
> >>
> >> Setting an irq manually looks a bit anachronistic. I doubt anyone would
> >> do that nowadays, and the patch does a nice cleanup. So this looks like
> >> a good idea.
> > [...]
> >>> diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
> >>> index 472dd6f33a96..cc064f64fccf 100644
> >>> --- a/hw/ppc/spapr_vio.c
> >>> +++ b/hw/ppc/spapr_vio.c
> >>> @@ -455,7 +455,7 @@ static void spapr_vio_busdev_realize(DeviceState =
*qdev, Error **errp)
> >>>          dev->qdev.id =3D id;
> >>>      }
> >>> =20
> >>> -    dev->irq =3D spapr_irq_alloc(spapr, dev->irq, false, &local_err);
> >>> +    dev->irq =3D spapr_irq_alloc(spapr, false, &local_err);
> >>
> >> Silently breaking "irq" like this looks wrong. I'd rather officially r=
emove
> >> it first (ie, kill spapr_vio_props, -5 lines in spapr_vio.c).
> >>
> >> Of course, this raises the question of interface deprecation, and it s=
hould
> >> theoretically follow the process described at:
> >>
> >> https://wiki.qemu.org/Features/LegacyRemoval#Rules_for_removing_an_int=
erface
> >>
> >> Cc'ing Thomas, our Chief Deprecation Officer, for insights :)
> >=20
> > The property is a public interface. Just because it's not used by
> > libvirt does not mean that nobody is using it. So yes, please follow the
> > rules and mark it as deprecated first for two release, before you really
> > remove it.
>=20
> This "irq" property is a problem to introduce a new static layout of IRQ=
=20
> numbers. It is in complete opposition.=20
>=20
> Can we keep it as it is for old pseries machine (settable) and ignore it=
=20
> for newer ? Would that be fine ?

So, Thomas is right that we need to keep the interface while we go
through the deprecation process, even though it's a bit of a pain
(like you, I seriously doubt anyone ever used it).

But, I think there's a way to avoid that getting in the way of your
cleanups too much.

A bunch of the current problems are caused because spapr_irq_alloc()
conflates two meanings of "allocate": 1) finding a free irq to use for
this device and 2) assigning that irq exclusively to this device.

I think the first thing to do is to split those two parts.  (1) will
never take an irq parameter, (2) will always take an irq parameter.
To implement the (to be deprecated) "irq" property on vio devices you
should skip (1) and just call (2) with the given irq number.

The point of this series is to basically get rid of (1), but this
first step means we don't need to worry about the hint parameter as we
gradually remove it.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--rW45g2D1DgwV0HVw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsWBKcACgkQbDjKyiDZ
s5L8Uw//WS3i7hp8Qy7atjbUGokea7wtpNbT5QefJ/XPSxGb2QwYLWDphcHb5BmT
Sq5IKbJ4s2LyAqN4k0oA0i8rFuErI7K7G4S7g/LVqHeAhM1ij6AXWo2IxrgLFcRm
d5Kz5iaakvuBnwLZInnBToZSLCwKjcHYfHRDPeJp/aCzaD8ZRIAfJ+WBju0PDK9S
RpW09BHdiXmjVzNanxQuVIP9Zq4DXRpBUm5qF2hxctti5+UWobp79GykuqiKgX0/
KQ/9ZImttQCjYA8jUZtgURBA2N68YY3/XPUQPIC32sHG+yvePmT96jjwZP4Mxpe/
UPwxoWHUVQZrFNRK4QMVubT48jJtOf41C7Cn7cDHpa8kDvoW4YcQ63r+12hWhd6B
B2BXzZfbFRW45H6ioNaCBsZ/1ClhMZWWRbaNPMnUw+90KYDFL/PxQ8cvqZV5inJb
tUCuf4ZWx9o+vfzItmdDwYWn3wKeNRuSsraL1paC5ihXqX1yqR4ayU7JPqXeZdEI
HWkjCfoF86zntjpP0QbKU3AUymc/AUg5MyOkbHZcsCDQ0kSk2AebME2+UdyVGBAv
KzsHubrdl/WShVdRHOktxP7NSUCpFvVu9BatjC3ocA0z2lqVaJTpfsfES11cRrFk
ZEa73Z5nPEQO6NXx8Y4AAF0qkS2qxhQhsdi4WB4njqYu34xg0IE=
=jHmm
-----END PGP SIGNATURE-----

--rW45g2D1DgwV0HVw--
