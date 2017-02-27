Received: from eggs.gnu.org ([2001:4830:134:3::10]:52945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ci9ZN-00064R-PV
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 19:53:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ci9ZK-0000Dk-KW
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 19:53:41 -0500
Date: Mon, 27 Feb 2017 11:30:50 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170227003050.GI17615@umbus.fritz.box>
References: <1487252865-12064-1-git-send-email-clg@kaod.org>
	<1487252865-12064-9-git-send-email-clg@kaod.org>
	<20170223022933.GW12577@umbus.fritz.box>
	<6deab394-2564-3a43-669c-af4b8a2aa4e3@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GFRhMCFsFD5VPY3r"
Content-Disposition: inline
In-Reply-To: <6deab394-2564-3a43-669c-af4b8a2aa4e3@kaod.org>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2 08/22] ppc/xics: use the QOM
 interface to resend irqs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--GFRhMCFsFD5VPY3r
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 24, 2017 at 12:12:54PM +0100, C=E9dric Le Goater wrote:
> On 02/23/2017 03:29 AM, David Gibson wrote:
> > On Thu, Feb 16, 2017 at 02:47:31PM +0100, C=E9dric Le Goater wrote:
> >> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >> ---
> >>  hw/intc/xics.c | 26 ++++++++++++++------------
> >>  1 file changed, 14 insertions(+), 12 deletions(-)
> >>
> >> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> >> index 0ffdf09c5304..2decb921e4e3 100644
> >> --- a/hw/intc/xics.c
> >> +++ b/hw/intc/xics.c
> >> @@ -229,16 +229,15 @@ static void icp_check_ipi(ICPState *ss)
> >>      qemu_irq_raise(ss->output);
> >>  }
> >> =20
> >> -static void icp_resend(ICPState *ss)
> >> +static void icp_resend(XICSInterface *xi, ICPState *ss)
> >>  {
> >> -    ICSState *ics;
> >> +    XICSInterfaceClass *xic =3D XICS_INTERFACE_GET_CLASS(xi);
> >> =20
> >>      if (ss->mfrr < CPPR(ss)) {
> >>          icp_check_ipi(ss);
> >>      }
> >> -    QLIST_FOREACH(ics, &ss->xics->ics, list) {
> >> -        ics_resend(ics);
> >> -    }
> >> +
> >> +    xic->ics_resend(xi);
> >>  }
> >> =20
> >>  void icp_set_cppr(ICPState *ss, uint8_t cppr)
> >> @@ -262,7 +261,7 @@ void icp_set_cppr(ICPState *ss, uint8_t cppr)
> >>          }
> >>      } else {
> >>          if (!XISR(ss)) {
> >> -            icp_resend(ss);
> >> +            icp_resend(XICS_INTERFACE(qdev_get_machine()), ss);
> >=20
> > Here you're assuming that the machine is the implementor of the xics
> > interface, which is kinda ugly.  The ICP should have a pointer to the
> > xics interface, which will eventually replace the pointer to the
> > overall xics object it has now.
>=20
> yes. I will try improve that. I don't like those calls to=20
> qdev_get_machine()either.=20
>=20
> There are done in a couple of places though, under spapr_cpu_core
> to get XICS for instance.

Right, but I'm happier with it there, in code that's definitely
associated with a particular machine, rather than in the xics code
which is at least somewhat reusable.

> > But I haven't read the rest of the series yet, maybe this is just
> > transitional.
> >=20
> >>          }
> >>      }
> >>  }
> >> @@ -299,6 +298,8 @@ uint32_t icp_ipoll(ICPState *ss, uint32_t *mfrr)
> >> =20
> >>  void icp_eoi(ICPState *ss, uint32_t xirr)
> >>  {
> >> +    XICSInterface *xi =3D XICS_INTERFACE(qdev_get_machine());
> >> +    XICSInterfaceClass *xic =3D XICS_INTERFACE_GET_CLASS(xi);
> >>      ICSState *ics;
> >>      uint32_t irq;
> >> =20
> >> @@ -306,13 +307,13 @@ void icp_eoi(ICPState *ss, uint32_t xirr)
> >>      ss->xirr =3D (ss->xirr & ~CPPR_MASK) | (xirr & CPPR_MASK);
> >>      trace_xics_icp_eoi(ss->cs->cpu_index, xirr, ss->xirr);
> >>      irq =3D xirr & XISR_MASK;
> >> -    QLIST_FOREACH(ics, &ss->xics->ics, list) {
> >> -        if (ics_valid_irq(ics, irq)) {
> >> -            ics_eoi(ics, irq);
> >> -        }
> >> +
> >> +    ics =3D xic->ics_get(xi, irq);
> >> +    if (ics) {
> >> +        ics_eoi(ics, irq);
> >>      }
> >>      if (!XISR(ss)) {
> >> -        icp_resend(ss);
> >> +        icp_resend(xi, ss);
> >>      }
> >>  }
> >> =20
> >> @@ -592,10 +593,11 @@ static void ics_simple_reset(DeviceState *dev)
> >> =20
> >>  static int ics_simple_post_load(ICSState *ics, int version_id)
> >>  {
> >> +    XICSInterface *xi =3D XICS_INTERFACE(qdev_get_machine());
> >>      int i;
> >> =20
> >>      for (i =3D 0; i < ics->xics->nr_servers; i++) {
> >> -        icp_resend(&ics->xics->ss[i]);
> >> +        icp_resend(xi, &ics->xics->ss[i]);
> >>      }
> >=20
> > This resend triggering needs to get moved to the xics interface
> > implementor - i.e. the machine.  It's actually already broken right
> > now, since it incorrectly relies on the ordering of the ics and icp
> > restore during migration.
>=20
> I'm adding a icp_resend() handler in patch 12 and using it patch 14.
> Maybe we can move the post_load() handler out of ICS simple now ?=20
>=20
> Thanks,
>=20
> C.=20
>=20
> =20
> >>      return 0;
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--GFRhMCFsFD5VPY3r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYs3M3AAoJEGw4ysog2bOSb98P/AiFHkZGWfUfs4Dgu7aqn9nU
i1l00O6DKQB21LUo2NxKu8Iin5oAvCoBkPgvV7qcolF/ywMKnlW4/+9VYJpUPyjF
dpurvzJKyCepC9GIzP1lhVh35yj1HVAju9Y6LQMwBl9uSy3KF6P/se9YptpDaLOK
yV/OMZfedIqenXcqcnQVsVI9wKb2KgqfkqTyKwlyMeB7FE5Q+4kr+x3I5IiRa8s6
nz953hZI8RQYC8X16gwu4fHH3MCo3+DAVOiQmPUqpiQgKJVUnrgJ5xTFDL55994w
wAuaZGjb4TImtLyPOwQ9PSzgevD66y7R+Uj+TsVIgQ6QmzlWntP66+bgPhaSX+AU
kdMO7rqPkHBWXTxKBhJgZSaF4QFzJ/4Xbj2rulEfPQRfD+aqj41ecs1CaX2EiiSP
40VzXUn7kMFwMFZ8X//FPIGJzbsf1+PrC9jUFCzs/lstHS19U/zeFuZkz3q7IOe9
15gro9EkWZtYjKiVHYSMIhy2gK9eOugivFM2Q6gQ2LLN5Z2erjh70Tla7v32miAb
vxc/9KFiF1+FJe+o7pTG7g6JwS1Dl8I/LoETtxeETL1VbI8lQbYD4BjW5SBGL+mO
yWFvo6Kg7TcYd6T6hb6zK6KllM8xH5eICU/ZvhnT8gkIAP0IoWXefFij+42fwXFN
TV1uVzGQzCy/aup+1xI8
=WgIb
-----END PGP SIGNATURE-----

--GFRhMCFsFD5VPY3r--
