Received: from eggs.gnu.org ([2001:4830:134:3::10]:47950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eKnpn-0001In-8O
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:06:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eKnpl-0002Hz-7K
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:06:39 -0500
Date: Fri, 1 Dec 2017 15:10:15 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171201041015.GE30161@umbus.fritz.box>
References: <20171123132955.1261-1-clg@kaod.org>
	<20171123132955.1261-15-clg@kaod.org>
	<20171130044922.GC3023@umbus.fritz.box>
	<36b5b7a1-63f1-30ac-0fa6-a22b49df065f@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HeFlAV5LIbMFYYuh"
Content-Disposition: inline
In-Reply-To: <36b5b7a1-63f1-30ac-0fa6-a22b49df065f@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 14/25] spapr: push the XIVE EQ data in OS
 event queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>


--HeFlAV5LIbMFYYuh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2017 at 02:16:30PM +0000, C=E9dric Le Goater wrote:
> On 11/30/2017 04:49 AM, David Gibson wrote:
> > On Thu, Nov 23, 2017 at 02:29:44PM +0100, C=E9dric Le Goater wrote:
> >> If a triggered event is let through, the Event Queue data defined in t=
he
> >> associated IVE is pushed in the in-memory event queue. The latter is a
> >> circular buffer provided by the OS using the H_INT_SET_QUEUE_CONFIG hc=
all,
> >> one per server and priority couple. It is composed of Event Queue entr=
ies
> >> which are 4 bytes long, the first bit being a 'generation' bit and the=
 31
> >> following bits the EQ Data field.
> >>
> >> The EQ Data field provides a way to set an invariant logical event sou=
rce
> >> number for an IRQ. It is set with the H_INT_SET_SOURCE_CONFIG hcall.
> >>
> >> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >> ---
> >>  hw/intc/spapr_xive.c | 67 +++++++++++++++++++++++++++++++++++++++++++=
+++++++++
> >>  1 file changed, 67 insertions(+)
> >>
> >> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> >> index 983317a6b3f6..df14c5a88275 100644
> >> --- a/hw/intc/spapr_xive.c
> >> +++ b/hw/intc/spapr_xive.c
> >> @@ -193,9 +193,76 @@ static sPAPRXiveICP *spapr_xive_icp_get(sPAPRXive=
 *xive, int server)
> >>      return cpu ? SPAPR_XIVE_ICP(cpu->intc) : NULL;
> >>  }
> >> =20
> >> +static void spapr_xive_eq_push(XiveEQ *eq, uint32_t data)
> >> +{
> >> +    uint64_t qaddr_base =3D (((uint64_t)(eq->w2 & 0x0fffffff)) << 32)=
 | eq->w3;
> >> +    uint32_t qsize =3D GETFIELD(EQ_W0_QSIZE, eq->w0);
> >> +    uint32_t qindex =3D GETFIELD(EQ_W1_PAGE_OFF, eq->w1);
> >> +    uint32_t qgen =3D GETFIELD(EQ_W1_GENERATION, eq->w1);
> >> +
> >> +    uint64_t qaddr =3D qaddr_base + (qindex << 2);
> >> +    uint32_t qdata =3D cpu_to_be32((qgen << 31) | (data & 0x7fffffff)=
);
> >> +    uint32_t qentries =3D 1 << (qsize + 10);
> >> +
> >> +    if (dma_memory_write(&address_space_memory, qaddr, &qdata, sizeof=
(qdata))) {
> >=20
> > This suggests that uint32_t data contains guest endian data, which it
> > generally shouldn't.  Better to use stl_be_dma() (or whatever is
> > appropriate for the endianness of the data field.
>=20
> There are no requirement on the endianness of the data field and=20
> it is just stored in the IVE in the hcall H_INT_SET_SOURCE_CONFIG.=20
> So the guest can pass whatever it likes. =20

Hm, ok.  Guest endian (or at least, not definitively host-endian) data
in a plain uint32_t makes me uncomfortable.  Could we use char data[4]
instead, to make it clear it's a byte-ordered buffer, rather than a
number as far as the XIVE is concerned.

Hm.. except that doesn't quite work, because the hardware must define
which end that generation bit ends up in...

> >> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: failed to write EQ data @=
0x%"
> >> +                      HWADDR_PRIx "\n", __func__, qaddr);
> >> +        return;
> >> +    }
> >> +
> >> +    qindex =3D (qindex + 1) % qentries;
> >> +    if (qindex =3D=3D 0) {
> >> +        qgen ^=3D 1;
> >> +        eq->w1 =3D SETFIELD(EQ_W1_GENERATION, eq->w1, qgen);
> >> +    }
> >> +    eq->w1 =3D SETFIELD(EQ_W1_PAGE_OFF, eq->w1, qindex);
> >> +}
> >> +
> >>  static void spapr_xive_irq(sPAPRXive *xive, int lisn)
> >>  {
> >> +    XiveIVE *ive;
> >> +    XiveEQ *eq;
> >> +    uint32_t eq_idx;
> >> +    uint8_t priority;
> >> +
> >> +    ive =3D spapr_xive_get_ive(xive, lisn);
> >> +    if (!ive || !(ive->w & IVE_VALID)) {
> >> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid LISN %d\n", lis=
n);
> >=20
> > As mentioned on other patches, I'm a little concerned by these
> > guest-triggerable logs.  I guess the LOG_GUEST_ERROR mask will save
> > us, though.
>=20
> I want to track 'invalid' interrupts but I haven't seen these show up=20
> in my tests. I agree there are a little too much and some could just=20
> be asserts.

Uh.. I don't think many can be assert()s.  assert() is only
appropriate if it being tripped definitely indicates a bug in qemu.
Nearly all these qemu_log()s I've seen can be tripped by the guest
doing something bad, which absolutely should not assert() qemu.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--HeFlAV5LIbMFYYuh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlog1icACgkQbDjKyiDZ
s5KdXxAA4iphGhM7PBt3VlvNKW2PGOmaXwvITmdvlJaxi0HftqGRINlYRr06AwqL
yksAtCIYee2HaHTsdPAeuLcDcJ/+/1EeV8PH6Eng+njASu4lFs7QqY6bFc2Aahtt
jMFH/932SMKFEnw260U3XSywQCbaNs6v3x1pyccjtcPG8YWQputNC9iseQYwe1Yo
a/cP+rZdamjFE9SjgU5Qn0dF24/hE9FcftOCyFuleC174huG+zsUFk0oxDQc7Erm
1IdJYo1NPlUvvOAC/VLMthks1Su7Art7jx0nGIpIwxph6PseSm8vuApe5yQDen3Q
ZRr67XWxDKm3p4YcBecKIfX+ryUjSTKHM2K9X/ESMP2wLTHqrJ52OHgWjgGsM335
3yfREBkjYnSNWngLlYboOb1jR4B9CazKl3uPEJtNsuDD8oznlTlacS3j99t3uBRM
p835odLSmKnHEGqFzpDzWFPaphpKih6Wli5NDWxrnb//xZZyKLeAyF6nQ462bSxu
vJ7g1kphG0zRGyW2cqoZcn5VOAwbJA4ZdugURqlSdipNYZb1J5seIffpPW3d8nU4
kJrb0s5KOXF3K+Yslxug1CjbUQSfwJjgUZ6+3bsMHvImNo+XlpOguMVXqil9Rk1R
m6POouwZ9I9i8oCqx6bn/WvlOBY/9OR2wSQUIn7OYnJ8UObxKIc=
=nElm
-----END PGP SIGNATURE-----

--HeFlAV5LIbMFYYuh--
