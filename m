Received: from eggs.gnu.org ([209.51.188.92]:55917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h1NKx-00042b-CK
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 22:35:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h1NKt-0000Az-Hq
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 22:35:16 -0500
Date: Wed, 6 Mar 2019 14:16:23 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190306031622.GI19715@umbus.fritz.box>
References: <20190226045304.25618-1-david@gibson.dropbear.id.au>
	<20190226045304.25618-31-david@gibson.dropbear.id.au>
	<CAFEAcA_S+Sq_5fMbVvXnSLsWzzVxKYA2zs8QH02H_xAAb+1+kA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QDIl5R72YNOeCxaP"
Content-Disposition: inline
In-Reply-To: <CAFEAcA_S+Sq_5fMbVvXnSLsWzzVxKYA2zs8QH02H_xAAb+1+kA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 30/50] spapr: Generate FDT fragment for LMBs
 at configure connector time
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: gkurz@kaod.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Laurent Vivier <lvivier@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>, Greg Kurz <groug@kaod.org>


--QDIl5R72YNOeCxaP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 05, 2019 at 04:10:20PM +0000, Peter Maydell wrote:
> On Tue, 26 Feb 2019 at 04:53, David Gibson <david@gibson.dropbear.id.au> =
wrote:
> >
> > From: Greg Kurz <groug@kaod.org>
>=20
>=20
> Hi -- Coverity points out a possible overflow here (CID 1399145):
>=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 00eb3b643c..b92deee771 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -3333,14 +3333,26 @@ static void spapr_nmi(NMIState *n, int cpu_inde=
x, Error **errp)
> >      }
> >  }
> >
> > +int spapr_lmb_dt_populate(sPAPRDRConnector *drc, sPAPRMachineState *sp=
apr,
> > +                          void *fdt, int *fdt_start_offset, Error **er=
rp)
> > +{
> > +    uint64_t addr;
> > +    uint32_t node;
> > +
> > +    addr =3D spapr_drc_index(drc) * SPAPR_MEMORY_BLOCK_SIZE;
>=20
> This multiplication is done as a 32x32, which might overflow and
> be truncated before the result is put into the 64-bit result.
> Casting one side or the other to uint64_t would fix this.

I've applied the following fix to my tree and will include it in the
next pull request:

=46rom 07d93b239203f4fb655e42f6a8a194a4f9eb40a2 Mon Sep 17 00:00:00 2001
=46rom: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 6 Mar 2019 14:15:26 +1100
Subject: [PATCH] spapr: Force SPAPR_MEMORY_BLOCK_SIZE to be a hwaddr (64-bi=
t)

SPAPR_MEMORY_BLOCK_SIZE is logically a difference in memory addresses, and
hence of type hwaddr which is 64-bit.  Previously it wasn't marked as such
which means that it could be treated as 32-bit.  That will work in some
circumstances but if multiplied by another 32-bit value it could lead to
a 32-bit overflow and an incorrect result.

One specific instance of this in spapr_lmb_dt_populate() was spotted by
Coverity (CID 1399145).

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 include/hw/ppc/spapr.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index ff1bd60615..1311ebe28e 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -792,7 +792,7 @@ int spapr_rtc_import_offset(sPAPRRTCState *rtc, int64_t=
 legacy_offset);
=20
 #define TYPE_SPAPR_RNG "spapr-rng"
=20
-#define SPAPR_MEMORY_BLOCK_SIZE (1 << 28) /* 256MB */
+#define SPAPR_MEMORY_BLOCK_SIZE ((hwaddr)1 << 28) /* 256MB */
=20
 /*
  * This defines the maximum number of DIMM slots we can have for sPAPR
--=20
2.20.1

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--QDIl5R72YNOeCxaP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlx/O4QACgkQbDjKyiDZ
s5IhbhAAqNJSpMuosk44OmDa8G3Yis2rfdC4H1nmMai5v2RKaBTakAl1Kh6O8Teb
BYUBD0keawuZbYHTywdyXdVz9NNjBfX9+jLbCsWb+NMf/+3AF/Y+GAYkIihMNwvo
/A9/hQ+SQw9vzPZSjGKRQur/eHXUuCPrIVQu8wHaP610fmPrIMrfXdL8A7fA/VzB
EbHj28O2aVSFVWwz+EpRmwK8kh8JGwsbGj3vBFLHN0B+qD74QsfZtECaH7qg/bQV
X0SFyyCIVPPcmA8PAw2iu2kT8/crjBFqC0GQAekU91AbdLO0EJG8Ibzir5vUDzoz
6hZ9nY5yOXdP0HvQxMLHCFbkTIlMtbgYvX84BBlVyRWt+PMRmqpQ100uLt2Rg23d
iulm26BEHzppDuWK0MQ7bcy5rJNppJI1eijCOdyE0V2KM2vXLSd3k5PfaCRNFIfn
MqW/Crthwm+K73EKjOZiAqpIzxO2sTWAfxeVDKOYTiBGXVzpKDSc41trNpzKKbxx
d+vC7aSwvIr81LZfAyWt1ad7ziRAjzwEL2XYMQN5tciKp4hbg1TM4/00WlhhGSdO
H1df/+QdULMsHSTKo63U8VgOF20DbKYWRMFNnHRwXQFjNoF1VjL4NBDttJm7jLng
hY8hUKPjHQMU39PPU6QAkIT5mnA1RlWQW01pyshevXJLoCIWCnY=
=PGwI
-----END PGP SIGNATURE-----

--QDIl5R72YNOeCxaP--
