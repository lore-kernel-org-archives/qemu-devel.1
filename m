Received: from eggs.gnu.org ([2001:4830:134:3::10]:43313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dVE8W-0007jW-CS
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 05:40:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dVE8S-0001vD-80
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 05:40:48 -0400
Date: Wed, 12 Jul 2017 19:40:05 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170712094005.GM4083@umbus.fritz.box>
References: <20170711043917.1757-1-david@gibson.dropbear.id.au>
	<20170711043917.1757-10-david@gibson.dropbear.id.au>
	<20170712082637.GA5377@in.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="M2Pxvdb9QxnGd/3e"
Content-Disposition: inline
In-Reply-To: <20170712082637.GA5377@in.ibm.com>
Subject: Re: [Qemu-devel] [PULL 09/17] spapr: Remove unnecessary differences
 between hotplug and coldplug paths
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bharata B Rao <bharata@linux.vnet.ibm.com>
Cc: peter.maydell@linaro.org, agraf@suse.de, mdroth@linux.vnet.ibm.com, groug@kaod.org, lvivier@redhat.com, aik@ozlabs.ru, surajjs@au1.ibm.com, sbobroff@au1.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--M2Pxvdb9QxnGd/3e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 12, 2017 at 01:56:37PM +0530, Bharata B Rao wrote:
> On Tue, Jul 11, 2017 at 02:39:09PM +1000, David Gibson wrote:
> > spapr_drc_attach() has a 'coldplug' parameter which sets the DRC into
> > configured state initially, instead of the usual ISOLATED/UNUSABLE stat=
e.
> > It turns out this is unnecessary: although coldplugged devices do need =
to
> > be in CONFIGURED state once the guest starts, that will already be
> > accomplished by the reset code which will move DRCs for already plugged
> > devices into a coldplug equivalent state.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > Reviewed-by: Laurent Vivier <lvivier@redhat.com>
> > Reviewed-by: Greg Kurz <groug@kaod.org>
> > ---
> >  hw/ppc/spapr.c             | 13 +++----------
> >  hw/ppc/spapr_drc.c         |  5 ++---
> >  hw/ppc/spapr_pci.c         |  3 +--
> >  include/hw/ppc/spapr_drc.h |  2 +-
> >  4 files changed, 7 insertions(+), 16 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 4fa982d..70b3fd3 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -2611,7 +2611,7 @@ static void spapr_add_lmbs(DeviceState *dev, uint=
64_t addr_start, uint64_t size,
> >          fdt_offset =3D spapr_populate_memory_node(fdt, node, addr,
> >                                                  SPAPR_MEMORY_BLOCK_SIZ=
E);
> >=20
> > -        spapr_drc_attach(drc, dev, fdt, fdt_offset, !dev->hotplugged, =
errp);
> > +        spapr_drc_attach(drc, dev, fdt, fdt_offset, errp);
> >          addr +=3D SPAPR_MEMORY_BLOCK_SIZE;
> >      }
> >      /* send hotplug notification to the
> > @@ -2956,17 +2956,10 @@ static void spapr_core_plug(HotplugHandler *hot=
plug_dev, DeviceState *dev,
> >=20
> >      g_assert(drc || !mc->has_hotpluggable_cpus);
> >=20
> > -    /*
> > -     * Setup CPU DT entries only for hotplugged CPUs. For boot time or
> > -     * coldplugged CPUs DT entries are setup in spapr_build_fdt().
> > -     */
> > -    if (dev->hotplugged) {
> > -        fdt =3D spapr_populate_hotplug_cpu_dt(cs, &fdt_offset, spapr);
> > -    }
> > +    fdt =3D spapr_populate_hotplug_cpu_dt(cs, &fdt_offset, spapr);
>=20
> A harmless (but still good to get rid of) side effect of this change is
> that we are now building the CPU device tree for boot time and cold-plugg=
ed
> CPUs twice:
>=20
> first from spapr_core_plug() -> spapr_populate_hotplug_cpu_dt()
> second from spapr_build_fdt() -> spapr_populate_cpus_dt_node()
>=20
> The first one is not used while the 2nd one acutally ends up building
> the CPUs DT entries for the boot time and cold-plugged CPUs.

Yeah, I know.  I think simpler code is more important than the handful
of wasted cycles.  We might be able to avoid this with some of the DT
generation cleanups I have on the long term radar.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--M2Pxvdb9QxnGd/3e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZZe5zAAoJEGw4ysog2bOSUckQAN4D517hRvHg95fHhTE3f6v4
li27NyVVHm9gTUp10p+9HKn3dO6+jojNoNaqG+wE82jVmzhJyfyvBRupSbH0X2dN
4gLs5RFsDtZdOjR545yAd31yHWV2cV1xyKWg/4F31Vk5Hf5/R62sa7dlKQ3J6pq+
e+zXqDZw22jhOMEYO7OEOGQjtxj5ygov6Hr9p5VhVHWhH5QejhqsPAEymsvDOWX+
v7qz0i/js0/UvHZCedCCtsHQiI5jogmFODOGQ+Ugt34i7GGcAuLcyzDyDcCeLIgY
BbB4NyhjKVf6iaOU5lxqZdKvuQtkChWvJLEscS3I1QIwCojl6Swubau/8jr/aSSI
4ARr46GeNer+ank4+mWUqjjT8ys0iT26He/9mqrRq4y/cpGH9kBnXSn6QgtFi/MW
BrpRR4XEtwseNdgasVFgvy8S6nY1UOZRRW/fAw8L0CSF7HXWTGq6RKblDtzwnSvI
8EWU88S1+wkdXx8KSsr/SAVdPi12vl9EGGebmWSCGAjdQAMzICx8NnZl09a8l4Do
JYPv2f23cEUMBFQoBFyDpM6uErBoTg6WFdDqPt3201hSOg+AI9PoCx3k48ghXxwc
2Y7Lq4we4JBrM+AbmcshS5TTFITdgLwEYfNq4qcSznRl4fIPv9HH8OWnozLDkBfg
k96c0Nurtlin8O1kn/vm
=elAN
-----END PGP SIGNATURE-----

--M2Pxvdb9QxnGd/3e--
