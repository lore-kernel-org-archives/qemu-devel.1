Received: from eggs.gnu.org ([2001:4830:134:3::10]:39190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dwgy4-0005BY-7D
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 23:55:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dwgy0-0003Tu-9u
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 23:55:32 -0400
Date: Tue, 26 Sep 2017 13:54:23 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170926035423.GH12504@umbus>
References: <20170911171235.29331-1-clg@kaod.org>
	<20170911171235.29331-2-clg@kaod.org>
	<20170919022719.GH27153@umbus>
	<d3ee87a7-208e-a172-094b-6aeedf8c5840@kaod.org>
	<20170922110040.GP4998@umbus.fritz.box>
	<fc6b85f6-fa5b-7ed2-2635-72aceda74305@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/9ZOS6odDaRI+0hI"
Content-Disposition: inline
In-Reply-To: <fc6b85f6-fa5b-7ed2-2635-72aceda74305@kaod.org>
Subject: Re: [Qemu-devel] [RFC PATCH v2 01/21] ppc/xive: introduce a
 skeleton for the sPAPR XIVE interrupt controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, Alexander Graf <agraf@suse.de>


--/9ZOS6odDaRI+0hI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 22, 2017 at 02:42:07PM +0200, C=E9dric Le Goater wrote:
> On 09/22/2017 01:00 PM, David Gibson wrote:
> > On Tue, Sep 19, 2017 at 03:15:44PM +0200, C=E9dric Le Goater wrote:
> >> On 09/19/2017 04:27 AM, David Gibson wrote:
> >>> On Mon, Sep 11, 2017 at 07:12:15PM +0200, C=E9dric Le Goater wrote:
> >>>> Start with a couple of attributes for the XIVE sPAPR controller
> >>>> model. The number of provisionned IRQ is necessary to size the
> >>>> different internal XIVE tables, the number of CPUs is also.
> >>>>
> >>>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >>>
> >>> [snip]
> >>>
> >>>> +static void spapr_xive_realize(DeviceState *dev, Error **errp)
> >>>> +{
> >>>> +    sPAPRXive *xive =3D SPAPR_XIVE(dev);
> >>>> +
> >>>> +    if (!xive->nr_targets) {
> >>>> +        error_setg(errp, "Number of interrupt targets needs to be g=
reater 0");
> >>>> +        return;
> >>>> +    }
> >>>> +    /* We need to be able to allocate at least the IPIs */
> >>>> +    if (!xive->nr_irqs || xive->nr_irqs < xive->nr_targets) {
> >>>> +        error_setg(errp, "Number of interrupts too small");
> >>>> +        return;
> >>>> +    }
> >>>> +}
> >>>> +
> >>>> +static Property spapr_xive_properties[] =3D {
> >>>> +    DEFINE_PROP_UINT32("nr-irqs", sPAPRXive, nr_irqs, 0),
> >>>> +    DEFINE_PROP_UINT32("nr-targets", sPAPRXive, nr_targets, 0),
> >>>
> >>> I'm a bit uneasy about the number of targets having to be set in
> >>> advance: this can make life awkward when CPUs are hotplugged.  I know
> >>> there's something similar in xics, but it has caused some hassles, and
> >>> we're starting to move away from it.
> >>>
> >>> Do you really need this?
> >>>
> >>
> >> Some of the internal table size depend on the number of cpus=20
> >> defined for the machine.
> >=20
> > Which ones?  My impression was that there needed to be at least #cpus
> > * #priority-levels EQs, but there could be more than that,=20
>=20
> euh no, not in spapr mode at least. There are 8 queues per cpu.

Ok.

> > so it was no longer as tightly bound to the number if "interrupt server=
s"> as xics.
>=20
> ah. I think I see what you mean, that we could allocate them on the=20
> fly when needed by some hcalls ?

Not at hcall time, no, but at cpu hot(un)plug time I was wondering if we
could (de)allocate them then.

> The other place where I use the nr_targets is to provision the=20
> IRQ numbers for the IPIs but that could probably be done in some=20
> other way, specially it there is a IRQ allocator at the machine
> level.

Hm, ok.

>=20
> C. =20
> >> When the sPAPRXive object is instantiated,=20
> >> we use xics_max_server_number() to get the max number of cpus
> >> provisioned.
> >>
> >> C.
> >>
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--/9ZOS6odDaRI+0hI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnJz28ACgkQbDjKyiDZ
s5JrVBAAkkGeZtLAjJicokyY7VGRKJXqQhtjYQJVb1S6qI7JbLmbc/Tfn1QaK6OP
qErNrjbhoYW38Lf3D1+ufFvzOuU8+K54jjMqTfknVQ0zCOqUvyPoXvyga+orndYu
BmQSIY2ZNIghkJ0MOgjiXk5NfZhnpEVML47ip0w+2tAWzvXSadrFvJPLY/6HV29q
CnHbA0efjO7rdE8itZkTB+UMtVV2YiEOaaPUfGVkLtAPr0/DbiRfDVVW2FG6knmK
cLyuTrs4hhXCbT7RihWcEzYNtUMLOLRWWxzeFinSxmQnebUACnyhH7ivzcQEniTg
faXLB6y1gDjLMDO+joufCoZce2riWkgapyfEtiM49x+4ctncdclyqLgA3iB5PdUY
rDBgM3+id1XJjbbiAdcqsO5hHnj1flmojGYebNE8AH8SDJFWTDqZiaKrVrb0gMDf
D2Yjk807k0m13M9sB8dKWS4PK901hEcAxRJj2sGm9NuYQaYPgItUh3fClXkvc0NK
048azp+Q2hih4R3t+HsvaG4yytBllGYvQwPefxeClzRhp+32XSp573kopxHInvwn
LoqxRGDB8/tfjaKIEOTrACTrGjI1v8yUg+4Na5oKwtWm0lPCCOue4R/bSU4qHHJL
zr8HQkjr0CqWLDzJDFBI0y+lLC38Sy5tI5GXTrIXo8jbj8KOANE=
=Z2tq
-----END PGP SIGNATURE-----

--/9ZOS6odDaRI+0hI--
