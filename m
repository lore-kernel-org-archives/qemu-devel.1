Received: from eggs.gnu.org ([2001:4830:134:3::10]:37632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gWsXG-0005CT-M3
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 19:37:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gWsXF-0002fx-Nj
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 19:37:58 -0500
Date: Wed, 12 Dec 2018 11:32:49 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181212003249.GE2719@umbus.fritz.box>
References: <20181209194610.29727-1-clg@kaod.org>
	<20181209194610.29727-16-clg@kaod.org>
	<20181211014737.GE4261@umbus.fritz.box>
	<dcb91154-72d4-fd7e-42fd-d168cc2415e3@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="47eKBCiAZYFK5l32"
Content-Disposition: inline
In-Reply-To: <dcb91154-72d4-fd7e-42fd-d168cc2415e3@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v7 15/19] spapr/xive: enable XIVE MMIOs at
 reset
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


--47eKBCiAZYFK5l32
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 11, 2018 at 11:14:41AM +0100, C=E9dric Le Goater wrote:
> On 12/11/18 2:47 AM, David Gibson wrote:
> > On Sun, Dec 09, 2018 at 08:46:06PM +0100, C=E9dric Le Goater wrote:
> >> Depending on the interrupt mode chosen, enable or disable the XIVE
> >> MMIOs.
> >>
> >> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >> ---
> >>  include/hw/ppc/spapr_xive.h | 1 +
> >>  hw/intc/spapr_xive.c        | 9 +++++++++
> >>  hw/ppc/spapr_irq.c          | 8 ++++++++
> >>  3 files changed, 18 insertions(+)
> >>
> >> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
> >> index 7244a6231ce6..308afb61a666 100644
> >> --- a/include/hw/ppc/spapr_xive.h
> >> +++ b/include/hw/ppc/spapr_xive.h
> >> @@ -48,5 +48,6 @@ void spapr_xive_hcall_init(sPAPRMachineState *spapr);
> >>  void spapr_dt_xive(sPAPRMachineState *spapr, uint32_t nr_servers, voi=
d *fdt,
> >>                     uint32_t phandle);
> >>  void spapr_xive_reset_tctx(sPAPRXive *xive);
> >> +void spapr_xive_enable_mmio(sPAPRXive *xive, bool enable);
> >> =20
> >>  #endif /* PPC_SPAPR_XIVE_H */
> >> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> >> index 560d8d031f74..c6dbb2e8cfc7 100644
> >> --- a/hw/intc/spapr_xive.c
> >> +++ b/hw/intc/spapr_xive.c
> >> @@ -179,6 +179,15 @@ static void spapr_xive_map_mmio(sPAPRXive *xive)
> >>      sysbus_mmio_map(SYS_BUS_DEVICE(xive), 2, xive->tm_base);
> >>  }
> >> =20
> >> +void spapr_xive_enable_mmio(sPAPRXive *xive, bool enable)
> >=20
> > The logic looks fine, but I dislike this name - it's called
> > ..._enable() when it can also be used to disable.
>=20
> ok. Let's call it spapr_xive_mmio_set_enabled() then

Sounds good.

>=20
> C.
> =20
> >> +{
> >> +    memory_region_set_enabled(&xive->source.esb_mmio, enable);
> >> +    memory_region_set_enabled(&xive->tm_mmio, enable);
> >> +
> >> +    /* Disable the END ESBs until a guest OS makes use of them */
> >> +    memory_region_set_enabled(&xive->end_source.esb_mmio, false);
> >> +}
> >> +
> >>  /*
> >>   * When a Virtual Processor is scheduled to run on a HW thread, the
> >>   * hypervisor pushes its identifier in the OS CAM line. Emulate the
> >> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> >> index b423cee30e2c..a8e50725397c 100644
> >> --- a/hw/ppc/spapr_irq.c
> >> +++ b/hw/ppc/spapr_irq.c
> >> @@ -217,6 +217,11 @@ static void spapr_irq_reset_xics(sPAPRMachineStat=
e *spapr, Error **errp)
> >>      CPU_FOREACH(cs) {
> >>          spapr_cpu_core_set_intc(POWERPC_CPU(cs), spapr->icp_type);
> >>      }
> >> +
> >> +    /* Deactivate the XIVE MMIOs */
> >> +    if (spapr->xive) {
> >> +        spapr_xive_enable_mmio(spapr->xive, false);
> >> +    }
> >>  }
> >> =20
> >>  #define SPAPR_IRQ_XICS_NR_IRQS     0x1000
> >> @@ -358,6 +363,9 @@ static void spapr_irq_reset_xive(sPAPRMachineState=
 *spapr, Error **errp)
> >>       * to come after the XiveTCTX reset handlers.
> >>       */
> >>      spapr_xive_reset_tctx(spapr->xive);
> >> +
> >> +    /* Activate the XIVE MMIOs */
> >> +    spapr_xive_enable_mmio(spapr->xive, true);
> >>  }
> >> =20
> >>  /*
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--47eKBCiAZYFK5l32
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwQVzEACgkQbDjKyiDZ
s5ItsBAAxFZKzDo+UrNqirMZZ2NQTtWEy1Q8ar67PtbZp3OdlCendVl3iiXcw1Aw
0rzZX/OezMZvbqsdV+PxIXqzte4X6XDJZV8PaO4t0645J2K3mldo4Yqc0zmFz3TQ
yziKcAm7PXVjvjmkapg7kQRzoah3KPLRjbQN6Qv0SloFwQtI7mSOS1c+/eADoCZZ
5pp8/PUN9dWEqbhBUhreAdtxhQCyNxV2ieviIDY7HcvRImDo7LxIS5uN9dWQ3FRR
7b2Zl4rUa74eLQCs+GC1zzvLdW0PIbXemVhVH7qti+RPWsdneExYYZZl1Xl5Uw8N
gHSkOXhLkklRwb7Zc94jPnlLRNqIFB4kMv7unPVBKJwlfgURa9RK8Qb8z+HmWhzc
CM19FcATecxK5mqqRsgJUzV3oYu74Ab2KSQZjDn75gCpa27Y6BfdsWamkAv3yWz5
4NcQjapFBv0qfDYovLIW/mLEagCC9A43e7zOUJ15Fpxp7COrFYI7mGZscCm6sHOZ
H0Qn8nhb//qGtx2Dza61JWbtfZYHJNVDYpvbPRNiyecXm7XGn9row2J4r7veKXup
K33ZEdSRfUMR0PcTegOSqnWcbn783cfUS2SdJZzCS8u8CzTCCOKTKs674WvvAY+2
4L7GtL890AeBif3WfiVNW4CPo32sanyEQFdT9vDcFBdyJfIYWVo=
=exxJ
-----END PGP SIGNATURE-----

--47eKBCiAZYFK5l32--
