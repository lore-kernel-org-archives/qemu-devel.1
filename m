Received: from eggs.gnu.org ([2001:4830:134:3::10]:47153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eCgn5-0004HC-DM
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 01:58:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eCgn2-0003zr-92
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 01:58:19 -0500
Received: from ozlabs.org ([103.22.144.67]:46497)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1eCgn1-0003yv-4R
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 01:58:16 -0500
Date: Thu, 9 Nov 2017 17:53:46 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171109065346.GF7732@umbus.fritz.box>
References: <1508170976-96869-4-git-send-email-imammedo@redhat.com>
	<1508325132-70513-1-git-send-email-imammedo@redhat.com>
	<20171019063151.GA13245@umbus>
	<20171031150114.60e0958e@nial.brq.redhat.com>
	<20171106180216.GT3111@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FeAIMMcddNRN4P4/"
Content-Disposition: inline
In-Reply-To: <20171106180216.GT3111@localhost.localdomain>
Subject: Re: [Qemu-devel] [RFC v2 3/6] possible_cpus: add CPUArchId::type
 field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, peter.maydell@linaro.org, pkrempa@redhat.com, pbonzini@redhat.com, drjones@redhat.com, cohuck@redhat.com


--FeAIMMcddNRN4P4/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 06, 2017 at 04:02:16PM -0200, Eduardo Habkost wrote:
> On Tue, Oct 31, 2017 at 03:01:14PM +0100, Igor Mammedov wrote:
> > On Thu, 19 Oct 2017 17:31:51 +1100
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >=20
> > > On Wed, Oct 18, 2017 at 01:12:12PM +0200, Igor Mammedov wrote:
> > > > For enabling early cpu to numa node configuration at runtime
> > > > qmp_query_hotpluggable_cpus() should provide a list of available
> > > > cpu slots at early stage, before machine_init() is called and
> > > > the 1st cpu is created, so that mgmt might be able to call it
> > > > and use output to set numa mapping.
> > > > Use MachineClass::possible_cpu_arch_ids() callback to set
> > > > cpu type info, along with the rest of possible cpu properties,
> > > > to let machine define which cpu type* will be used.
> > > >=20
> > > > * for SPAPR it will be a spapr core type and for ARM/s390x/x86
> > > >   a respective descendant of CPUClass.
> > > >=20
> > > > Move parse_numa_opts() in vl.c after cpu_model is parsed into
> > > > cpu_type so that possible_cpu_arch_ids() would know which
> > > > cpu_type to use during layout initialization.
> > > >=20
> > > > Signed-off-by: Igor Mammedov <imammedo@redhat.com> =20
> > >=20
> > > Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> > >=20
> > > > ---
> > > >   v2:
> > > >      - fix NULL dereference caused by not initialized
> > > >        MachineState::cpu_type at the time parse_numa_opts()
> > > >        were called
> > > > ---
> > > >  include/hw/boards.h        |  2 ++
> > > >  hw/arm/virt.c              |  3 ++-
> > > >  hw/core/machine.c          | 12 ++++++------
> > > >  hw/i386/pc.c               |  4 +++-
> > > >  hw/ppc/spapr.c             | 13 ++++++++-----
> > > >  hw/s390x/s390-virtio-ccw.c |  1 +
> > > >  vl.c                       |  3 +--
> > > >  7 files changed, 23 insertions(+), 15 deletions(-)
> > > >=20
> > > > diff --git a/include/hw/boards.h b/include/hw/boards.h
> > > > index 191a5b3..fa21758 100644
> > > > --- a/include/hw/boards.h
> > > > +++ b/include/hw/boards.h
> > > > @@ -80,6 +80,7 @@ void machine_set_cpu_numa_node(MachineState *mach=
ine,
> > > >   * CPUArchId:
> > > >   * @arch_id - architecture-dependent CPU ID of present or possible=
 CPU =20
> > >=20
> > > I know this isn't really in scope for this patch, but is @arch_id here
> > > supposed to have meaning defined by the target, or by the machine?
> > >=20
> > > If it's the machime, it could do with a rename - "arch" means target
> > > to most people (thanks to Linux).
> > >=20
> > > If it's the target, it's kind of bogus, because it doesn't necessarily
> > > have a clear meaning per target - get_arch_id in CPUClass has the same
> > > problem, which is probably one reason it's basically only used by the
> > > x86 code at present.
> > >=20
> > > e.g. for target/ppc, what do we use?  There's the PIR, which is in the
> > > CPU.. but only on some cpu models, not all.  There will generally be
> > > some kind of master PIC id, but there are different PIC models on
> > > different boards.  What goes in the devicetree?  Well only some
> > > machines use devicetree, and they might define the cpu reg=20
> > > differently.
> > >=20
> > > Board designs will generally try to make some if not all of those
> > > possible values equal for simplicity, but there's still no real way of
> > > defining a sensible arch_id independent of machine / board.
> > I'd say arch_id is machine specific so far, it was introduced when we
> > didn't have CpuInstanceProperties and at that time we considered only
> > vcpus (threads) and doesn't really apply to spapr cores.
> >=20
> > In general we could do away with arch_id and use CpuInstanceProperties
> > instead, but arch_id also serves aux purpose, it allows machine to
> > pre-calculate(cache) apic-id/mpidr values in one place and then they
> > are/(could be) used by arch in-depended code to build acpi tables.
> > So if we drop arch_id we would need to introduce a machine hook,
> > which would translate CpuInstanceProperties into current arch_id.
>=20
> I think we need to do a better to job documenting where exactly
> we expect arch_id to be used and how, so people know what it's
> supposed to return.

The trouble with this is I think it's impossible - it doesn't have a
well defined meaning.

> If the only place where it's useful now is ACPI code (is it?),
> should we rename it to something like get_acpi_id()?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--FeAIMMcddNRN4P4/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAloD+3kACgkQbDjKyiDZ
s5LIHA/+ML6kNZ4EKPYC107Td4T9dZ2ZDCSP9/XUSXzptemFLuV514jRMinKymgS
5YnYdghb3z5baVYbeGtsdCFEY7cI7ZxqnIMIeGdqUK0JOPvW33HE5Tccfyz/Hmzt
3w+jofAq9B4dKoT7aTRqUODhquT8wt+sSGnRGE4Z+Nb/fv6viv3igS3M2Vb5F5qM
V4et4BInXnV7n3nFuBdH3hRw4DfhGCrKDCBog6odTt38QqNcv8YXBLA+SiKDwq/z
2e1+jS2cGbTBLPJ2CzGMB6ipRvTPfQRckVHsO27GNVsIj8XwDqx+G+Bhk6HQdcBm
ik6z8d+kYNWM6IMPLjZVe5+g+Z4BO2h0BUAvUX5UT0nvlYQk46EYVCQ1Dd8lMEao
VsxperHF5+clW7JE+SQSANA4odYxznno+sLZ7PSh0Xb+kSc95Dp0oE3VAf9iHxak
eWWo+iTLng8IgWy59uTOTOJ2SeF8eevxjCPurYXrxEnUFnOMQ2plPDotY4IVZJYn
aaN0/rg8+FOBuKRJs9Pv5hjZ6YW1BueaQoet4wR44EZBu/11oIoD5a6Klhw5DPhE
QVBuZL78EMe2aTGihaeI2E+o4BmZcu4PS1I5E6YNUGwHB7McO4Da/1GXRFv01pq+
9Lr05kstyLbqhC5+33fMcTIRRGloxc2AUk71aWSRd87GJLc61Rc=
=dpMl
-----END PGP SIGNATURE-----

--FeAIMMcddNRN4P4/--
