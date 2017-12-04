Received: from eggs.gnu.org ([2001:4830:134:3::10]:44589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eLfw3-0006VT-78
	for qemu-devel@nongnu.org; Sun, 03 Dec 2017 20:52:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eLfw2-0000cv-2r
	for qemu-devel@nongnu.org; Sun, 03 Dec 2017 20:52:43 -0500
Date: Mon, 4 Dec 2017 12:17:54 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171204011754.GH2130@umbus.fritz.box>
References: <20171123132955.1261-1-clg@kaod.org>
	<20171123132955.1261-16-clg@kaod.org>
	<20171130050049.GD3023@umbus.fritz.box>
	<1512225658.2224.66.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uAgJxtfIS94j9H4T"
Content-Disposition: inline
In-Reply-To: <1512225658.2224.66.camel@kernel.crashing.org>
Subject: Re: [Qemu-devel] [PATCH 15/25] spapr: notify the CPU when the XIVE
 interrupt priority is more privileged
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--uAgJxtfIS94j9H4T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 02, 2017 at 08:40:58AM -0600, Benjamin Herrenschmidt wrote:
> On Thu, 2017-11-30 at 16:00 +1100, David Gibson wrote:
> >=20
> > >  static uint64_t spapr_xive_icp_accept(sPAPRXiveICP *icp)
> > >  {
> > > -    return 0;
> > > +    uint8_t nsr =3D icp->tima_os[TM_NSR];
> > > +
> > > +    qemu_irq_lower(icp->output);
> > > +
> > > +    if (icp->tima_os[TM_NSR] & TM_QW1_NSR_EO) {
> > > +        uint8_t cppr =3D icp->tima_os[TM_PIPR];
> > > +
> > > +        icp->tima_os[TM_CPPR] =3D cppr;
> > > +
> > > +        /* Reset the pending buffer bit */
> > > +        icp->tima_os[TM_IPB] &=3D ~priority_to_ipb(cppr);
> >=20
> > What if multiple irqs of the same priority were queued?
>=20
> It's the job of the OS to handle that case by consuming from the queue
> until it's empty. There is an MMIO the guest can use if it wants to
> that can set the IPB bits back to 1 for a given priority. Otherwise in
> Linux we just have a SW way to force a replay.

Ok, so "accept" is effectively saying the OS is accepting all
interrupts from that queue, right?

>=20
> > > +        icp->tima_os[TM_PIPR] =3D ipb_to_pipr(icp->tima_os[TM_IPB]);
> > > +
> > > +        /* Drop Exception bit for OS */
> > > +        icp->tima_os[TM_NSR] &=3D ~TM_QW1_NSR_EO;
> > > +    }
> > > +
> > > +    return (nsr << 8) | icp->tima_os[TM_CPPR];
> > > +}
> > > +
> > > +static void spapr_xive_icp_notify(sPAPRXiveICP *icp)
> > > +{
> > > +    if (icp->tima_os[TM_PIPR] < icp->tima_os[TM_CPPR]) {
> > > +        icp->tima_os[TM_NSR] |=3D TM_QW1_NSR_EO;
> > > +        qemu_irq_raise(icp->output);
> > > +    }
> > >  }
> > > =20
> > >  static void spapr_xive_icp_set_cppr(sPAPRXiveICP *icp, uint8_t cppr)
> > > @@ -51,6 +105,9 @@ static void spapr_xive_icp_set_cppr(sPAPRXiveICP *=
icp, uint8_t cppr)
> > >      }
> > > =20
> > >      icp->tima_os[TM_CPPR] =3D cppr;
> > > +
> > > +    /* CPPR has changed, inform the ICP which might raise an excepti=
on */
> > > +    spapr_xive_icp_notify(icp);
> > >  }
> > > =20
> > >  /*
> > > @@ -224,6 +281,8 @@ static void spapr_xive_irq(sPAPRXive *xive, int l=
isn)
> > >      XiveEQ *eq;
> > >      uint32_t eq_idx;
> > >      uint8_t priority;
> > > +    uint32_t server;
> > > +    sPAPRXiveICP *icp;
> > > =20
> > >      ive =3D spapr_xive_get_ive(xive, lisn);
> > >      if (!ive || !(ive->w & IVE_VALID)) {
> > > @@ -253,6 +312,13 @@ static void spapr_xive_irq(sPAPRXive *xive, int =
lisn)
> > >          qemu_log_mask(LOG_UNIMP, "XIVE: !UCOND_NOTIFY not implemente=
d\n");
> > >      }
> > > =20
> > > +    server =3D GETFIELD(EQ_W6_NVT_INDEX, eq->w6);
> > > +    icp =3D spapr_xive_icp_get(xive, server);
> > > +    if (!icp) {
> > > +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: No ICP for server %d\n=
", server);
> > > +        return;
> > > +    }
> > > +
> > >      if (GETFIELD(EQ_W6_FORMAT_BIT, eq->w6) =3D=3D 0) {
> > >          priority =3D GETFIELD(EQ_W7_F0_PRIORITY, eq->w7);
> > > =20
> > > @@ -260,9 +326,18 @@ static void spapr_xive_irq(sPAPRXive *xive, int =
lisn)
> > >          if (priority =3D=3D 0xff) {
> > >              g_assert_not_reached();
> > >          }
> > > +
> > > +        /* Update the IPB (Interrupt Pending Buffer) with the priori=
ty
> > > +         * of the new notification and inform the ICP, which will
> > > +         * decide to raise the exception, or not, depending the CPPR.
> > > +         */
> > > +        icp->tima_os[TM_IPB] |=3D priority_to_ipb(priority);
> > > +        icp->tima_os[TM_PIPR] =3D ipb_to_pipr(icp->tima_os[TM_IPB]);
> > >      } else {
> > >          qemu_log_mask(LOG_UNIMP, "XIVE: w7 format1 not implemented\n=
");
> > >      }
> > > +
> > > +    spapr_xive_icp_notify(icp);
> > >  }
> > > =20
> > >  /*
> >=20
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--uAgJxtfIS94j9H4T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlokokIACgkQbDjKyiDZ
s5KbGxAAg0m39pW+4gSd+j06pP3eeAXz0q7+V2ZRqZSZxWXt85bhwnBfSZDznFJ7
8Vunh4mx5wTfYY2tMXkl4ERfXC0fM8QrRbKqumoWXr1D3VnCLagf9XE5g1tVK5MC
9bovDmEj94cKsF8C2+zOheD0NEYBo41BvnmMN31qlKXBrxTNxtiXP4MPBhMHbFuC
Nbqmi7dqVtGlYy0bXHLzqCL6ustRWsOgCw1ayVdAqF2XKAC2p/vTJGWmqGPMvK4n
l2Tha517CSRk+Mv8SeWxqHQHqdYfb2BENOAliRxjEjHPiM7ed3kflFzUhqnkBHMm
51Z0oqmJ4wH/d13AxzaUHO0Crtl34+HBzaoX4Y8M+cocn+Mrsmp1S4pYkfVYJW5U
7Rz5WpPppd/iPC5BnnyahNDqbbrPfrEzr69CtuDbqDxomExPyzGnMLIoDT9NVSYp
np6eMCHgSCmAQ/hPckZhgscCRK2Q7NRXSlUaH/PVITWIEJ3tmjmewt25/McLOaKg
JeBFyIW1LHT5pt/3+Q7Ax32imV7vIzWMdHH+nJy/lnG5lfYv3FwKpaDnUEWf0kkv
FxfYJxdmcDUUeKDnQDmi6x7aEoIa3XxmHHidJEiaiEUDp6Fy5EHjN7Hi7S6gBMVo
VB7YhM780D/qP6vj68UV1TuAT0IaEv5AQspHcWplttXE3KWuVoc=
=17Ru
-----END PGP SIGNATURE-----

--uAgJxtfIS94j9H4T--
