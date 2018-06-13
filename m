Received: from eggs.gnu.org ([2001:4830:134:3::10]:43593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSxIk-0002z6-1I
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 00:22:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSxIi-0000kx-KL
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 00:22:30 -0400
Date: Wed, 13 Jun 2018 14:22:17 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180613042217.GT30690@umbus.fritz.box>
References: <20180518164405.11804-1-clg@kaod.org>
	<20180518164405.11804-2-clg@kaod.org>
	<20180525160249.7cb0a5bc@bahia.lan>
	<82ee8b24-91d7-9396-82b7-be37200cfacd@redhat.com>
	<a567d42f-af8e-01da-5e0b-9b6f41c150cf@kaod.org>
	<20180605033401.GU5140@umbus.fritz.box>
	<48e319d0-2cf7-ab9a-f3d4-085880e1bda8@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gIHggtDV96iaw8wO"
Content-Disposition: inline
In-Reply-To: <48e319d0-2cf7-ab9a-f3d4-085880e1bda8@kaod.org>
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


--gIHggtDV96iaw8wO
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 05, 2018 at 08:41:13AM +0200, C=E9dric Le Goater wrote:
> On 06/05/2018 05:34 AM, David Gibson wrote:
> > On Mon, May 28, 2018 at 09:06:12AM +0200, C=E9dric Le Goater wrote:
> >> On 05/28/2018 08:17 AM, Thomas Huth wrote:
> >>> On 25.05.2018 16:02, Greg Kurz wrote:
> >>>> On Fri, 18 May 2018 18:44:02 +0200
> >>>> C=E9dric Le Goater <clg@kaod.org> wrote:
> >>>>
> >>>>> This IRQ number hint can possibly be used by the VIO devices if the
> >>>>> "irq" property is defined on the command line but it seems it is ne=
ver
> >>>>> the case. It is not used in libvirt for instance. So, let's remove =
it
> >>>>> to simplify future changes.
> >>>>>
> >>>>
> >>>> Setting an irq manually looks a bit anachronistic. I doubt anyone wo=
uld
> >>>> do that nowadays, and the patch does a nice cleanup. So this looks l=
ike
> >>>> a good idea.
> >>> [...]
> >>>>> diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
> >>>>> index 472dd6f33a96..cc064f64fccf 100644
> >>>>> --- a/hw/ppc/spapr_vio.c
> >>>>> +++ b/hw/ppc/spapr_vio.c
> >>>>> @@ -455,7 +455,7 @@ static void spapr_vio_busdev_realize(DeviceStat=
e *qdev, Error **errp)
> >>>>>          dev->qdev.id =3D id;
> >>>>>      }
> >>>>> =20
> >>>>> -    dev->irq =3D spapr_irq_alloc(spapr, dev->irq, false, &local_er=
r);
> >>>>> +    dev->irq =3D spapr_irq_alloc(spapr, false, &local_err);
> >>>>
> >>>> Silently breaking "irq" like this looks wrong. I'd rather officially=
 remove
> >>>> it first (ie, kill spapr_vio_props, -5 lines in spapr_vio.c).
> >>>>
> >>>> Of course, this raises the question of interface deprecation, and it=
 should
> >>>> theoretically follow the process described at:
> >>>>
> >>>> https://wiki.qemu.org/Features/LegacyRemoval#Rules_for_removing_an_i=
nterface
> >>>>
> >>>> Cc'ing Thomas, our Chief Deprecation Officer, for insights :)
> >>>
> >>> The property is a public interface. Just because it's not used by
> >>> libvirt does not mean that nobody is using it. So yes, please follow =
the
> >>> rules and mark it as deprecated first for two release, before you rea=
lly
> >>> remove it.
> >>
> >> This "irq" property is a problem to introduce a new static layout of I=
RQ=20
> >> numbers. It is in complete opposition.=20
> >>
> >> Can we keep it as it is for old pseries machine (settable) and ignore =
it=20
> >> for newer ? Would that be fine ?
> >=20
> > So, Thomas is right that we need to keep the interface while we go
> > through the deprecation process, even though it's a bit of a pain
> > (like you, I seriously doubt anyone ever used it).
>=20
> That's OK. The patch is simple. But it means that we have to keep the=20
> irq_hint parameter for 2 QEMU versions.

No.. the suggestion below is designed to avoid that..

> > But, I think there's a way to avoid that getting in the way of your
> > cleanups too much.
> >=20
> > A bunch of the current problems are caused because spapr_irq_alloc()
> > conflates two meanings of "allocate": 1) finding a free irq to use for
> > this device and 2) assigning that irq exclusively to this device.
> >=20
> > I think the first thing to do is to split those two parts.  (1) will
> > never take an irq parameter, (2) will always take an irq parameter.
> > To implement the (to be deprecated) "irq" property on vio devices you
> > should skip (1) and just call (2) with the given irq number.
>=20
> well, we need to call both because if "irq" is zero then when we=20
> fallback to "1) finding a free irq to use."

No, basically in the VIO code itself you'd have:
	irq =3D <irq property value>;
	if (!irq)
		irq =3D find_irq()
	claim_irq(irq);

find_irq() never takes a hint, claim_irq() always does (except it's
not really a hint).

> But we can move the exclusive IRQ assignment (2) under the VIO model=20
> which is the only one using it and start deprecating the property.

No.. the exclusive claim would be global - everything would use that.

> > The point of this series is to basically get rid of (1), but this
> > first step means we don't need to worry about the hint parameter as we
> > gradually remove it.
>=20
> OK. I think I got what you are asking for. (2) means adding an extra=20
> handler to the sPAPR IRQ interface, which would always fail in the
> new XICS sPAPR IRQ backend using static numbers.

No.. (2), "claim_irq()" as I called it above, would _always_ be used.
find_irq() would only be used to implement the legacy allocation.
In various places we'll have code like this:

	if (legacy) {
		irq =3D find_irq();
	} else {
		irq =3D <fixed value or formula>;
	}
	claim_irq(irq);

Where that fixed value could be something like:
	irq =3D PCI_LSI_BASE + phb->index*4 + pin#;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--gIHggtDV96iaw8wO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsgm/UACgkQbDjKyiDZ
s5KVTQ/+PechYUsoYImFjQPV+cHakJ9buul7hnqT7vrMv54js7pI6OzD81CFbrND
g9nGYctwz+GqnsZqOv56mQYqAmtaJVUonX7NbeVkd+B32LRTQmYiY5ZJ8vh9V4lj
YASZK5kg9DkLnRvN1I3dprugJsTuxBcJu/hdk2rgLyYPb4LVEQRLTOFNxV0eAh1W
zNj0AyslUAc4zF3xHB+KaaLLiWkAfI5B2Ealb1h4jIpGC3nDMSs5/mhaSdIAE09O
IFyQ79NadPru/2NYmATp+VgbUwkggiBj+6IlXUrmrI9rMWta3bMT8gqEHMMg8/Xo
+Ou+OziV3I6NExdN9QxM3SdDLaxnwRfRN3kgmw6hwv4PJh0+aA6JcNDySswhJu9f
yi1EZP6G+u4goybPzTr1M60narOfrkJYHkxFYL0QD+W9IDRHlDT4soVsXYEcAQCl
QjyHChVG6SWFWrYcBm+Bn/jyhzi0YbMrIlLUfFQ7gK1paq/8wdw4YRDlk36BCuRh
9YssNxCIk55Cd4/AsV2j8dbFbRwdI67l7Vi5LpldPCu/wiq9Mj5xMoX/EeIOKQ7W
c97OoznPRwnwylhl9UN/nxFaN8HKEDjXw4tKBhOJQKTG5E4CO7rTCRii7jafNtpc
Mq31YR7kR2rjwOGDvESvVtFetH6vnYG/HT6d+6+n3+7FRjiQbdA=
=PUln
-----END PGP SIGNATURE-----

--gIHggtDV96iaw8wO--
