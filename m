Received: from eggs.gnu.org ([2001:4830:134:3::10]:46672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1dqbJV-0000KW-P4
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 04:40:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1dqbJS-0002BZ-Mc
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 04:40:29 -0400
Message-ID: <1504946403.12628.83.camel@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Sat, 09 Sep 2017 18:40:03 +1000
In-Reply-To: <b2e99c69-76d2-ecc4-476d-75d9f5e3a667@kaod.org>
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
	<1499274819-15607-17-git-send-email-clg@kaod.org>
	<1504942750.12628.81.camel@kernel.crashing.org>
	<b2e99c69-76d2-ecc4-476d-75d9f5e3a667@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 16/26] ppc/xive: notify CPU when
 interrupt priority is more privileged
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Sat, 2017-09-09 at 10:08 +0200, C=C3=A9dric Le Goater wrote:
> On 09/09/2017 09:39 AM, Benjamin Herrenschmidt wrote:
> > On Wed, 2017-07-05 at 19:13 +0200, C=C3=A9dric Le Goater wrote:
> > > Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> > > ---
> > >  hw/intc/xive.c | 21 +++++++++++++++++++++
> > >  1 file changed, 21 insertions(+)
> > >=20
> > > diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> > > index c3c1e9c9db2d..cda1fa18e44d 100644
> > > --- a/hw/intc/xive.c
> > > +++ b/hw/intc/xive.c
> > > @@ -53,6 +53,21 @@ static uint64_t xive_icp_accept(XiveICPState *xi=
cp)
> > >      return (nsr << 8) | xicp->tima_os[TM_CPPR];
> > >  }
> > > =20
> > > +static uint8_t ipb_to_pipr(uint8_t ibp)
> > > +{
> > > +    return ibp ? clz32((uint32_t)ibp << 24) : 0xff;
> > > +}
> >=20
> > The PIPR needs to be updated also on accept etc... anything that chan=
ge
> > IPBs or CPPR really.
>=20
> I did forget the update in accept ... thanks.=20
>=20
> > Also I just learned something from the designers: The IPIR is clamped
> > to CPPR.
> >=20
> > So basically the value in the PIPR is:
> >=20
> > 	v =3D leftmost_bit_of(ipb) (or 0xff);
> > 	pipr =3D v < cppr ? v : cppr;
> >=20
> > which means it's never actually 0xff ... surprise !
>=20
> ah. that is not what the specs say but it shouldn't be a problem.
> I will change the code to reflect that.

Right, I've asked the HW guys to update the spec.

Cheers,
Ben.

> C.
>=20
> > That also means I need to fix my implementation of H_IPOLL in KVM.
> >=20
> > > +static void xive_icp_notify(XiveICPState *xicp)
> > > +{
> > > +    xicp->tima_os[TM_PIPR] =3D ipb_to_pipr(xicp->tima_os[TM_IPB]);
> > > +
> > > +    if (xicp->tima_os[TM_PIPR] < xicp->tima_os[TM_CPPR]) {
> > > +        xicp->tima_os[TM_NSR] |=3D TM_QW1_NSR_EO;
> > > +        qemu_irq_raise(ICP(xicp)->output);
> > > +    }
> > > +}
> > > +
> > >  static void xive_icp_set_cppr(XiveICPState *xicp, uint8_t cppr)
> > >  {
> > >      if (cppr > XIVE_PRIORITY_MAX) {
> > > @@ -60,6 +75,10 @@ static void xive_icp_set_cppr(XiveICPState *xicp=
, uint8_t cppr)
> > >      }
> > > =20
> > >      xicp->tima_os[TM_CPPR] =3D cppr;
> > > +
> > > +    /* CPPR has changed, inform the ICP which might raise an
> > > +     * exception */
> > > +    xive_icp_notify(xicp);
> > >  }
> > > =20
> > >  /*
> > > @@ -339,6 +358,8 @@ static void xive_icp_irq(XiveICSState *xs, int =
lisn)
> > >      } else {
> > >          qemu_log_mask(LOG_UNIMP, "XIVE: w7 format1 not implemented=
\n");
> > >      }
> > > +
> > > +    xive_icp_notify(xicp);
> > >  }
> > > =20
> > >  /*
