Received: from eggs.gnu.org ([2001:4830:134:3::10]:47154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eCgn5-0004HD-Db
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 01:58:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eCgn2-0003zl-8X
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 01:58:19 -0500
Received: from ozlabs.org ([103.22.144.67]:57533)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1eCgn1-0003yx-4U
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 01:58:16 -0500
Date: Thu, 9 Nov 2017 17:58:03 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171109065803.GG7732@umbus.fritz.box>
References: <1508170976-96869-4-git-send-email-imammedo@redhat.com>
	<1508325132-70513-1-git-send-email-imammedo@redhat.com>
	<20171019063151.GA13245@umbus>
	<20171031150114.60e0958e@nial.brq.redhat.com>
	<20171106180216.GT3111@localhost.localdomain>
	<20171107160404.40e368da.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Fnm8lRGFTVS/3GuM"
Content-Disposition: inline
In-Reply-To: <20171107160404.40e368da.cohuck@redhat.com>
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
To: Cornelia Huck <cohuck@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, peter.maydell@linaro.org, pkrempa@redhat.com, pbonzini@redhat.com, drjones@redhat.com


--Fnm8lRGFTVS/3GuM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 07, 2017 at 04:04:04PM +0100, Cornelia Huck wrote:
> On Mon, 6 Nov 2017 16:02:16 -0200
> Eduardo Habkost <ehabkost@redhat.com> wrote:
>=20
> > On Tue, Oct 31, 2017 at 03:01:14PM +0100, Igor Mammedov wrote:
> > > On Thu, 19 Oct 2017 17:31:51 +1100
> > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > >  =20
> > > > On Wed, Oct 18, 2017 at 01:12:12PM +0200, Igor Mammedov wrote: =20
> > > > > For enabling early cpu to numa node configuration at runtime
> > > > > qmp_query_hotpluggable_cpus() should provide a list of available
> > > > > cpu slots at early stage, before machine_init() is called and
> > > > > the 1st cpu is created, so that mgmt might be able to call it
> > > > > and use output to set numa mapping.
> > > > > Use MachineClass::possible_cpu_arch_ids() callback to set
> > > > > cpu type info, along with the rest of possible cpu properties,
> > > > > to let machine define which cpu type* will be used.
> > > > >=20
> > > > > * for SPAPR it will be a spapr core type and for ARM/s390x/x86
> > > > >   a respective descendant of CPUClass.
> > > > >=20
> > > > > Move parse_numa_opts() in vl.c after cpu_model is parsed into
> > > > > cpu_type so that possible_cpu_arch_ids() would know which
> > > > > cpu_type to use during layout initialization.
> > > > >=20
> > > > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>   =20
> > > >=20
> > > > Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> > > >  =20
> > > > > ---
> > > > >   v2:
> > > > >      - fix NULL dereference caused by not initialized
> > > > >        MachineState::cpu_type at the time parse_numa_opts()
> > > > >        were called
> > > > > ---
> > > > >  include/hw/boards.h        |  2 ++
> > > > >  hw/arm/virt.c              |  3 ++-
> > > > >  hw/core/machine.c          | 12 ++++++------
> > > > >  hw/i386/pc.c               |  4 +++-
> > > > >  hw/ppc/spapr.c             | 13 ++++++++-----
> > > > >  hw/s390x/s390-virtio-ccw.c |  1 +
> > > > >  vl.c                       |  3 +--
> > > > >  7 files changed, 23 insertions(+), 15 deletions(-)
> > > > >=20
> > > > > diff --git a/include/hw/boards.h b/include/hw/boards.h
> > > > > index 191a5b3..fa21758 100644
> > > > > --- a/include/hw/boards.h
> > > > > +++ b/include/hw/boards.h
> > > > > @@ -80,6 +80,7 @@ void machine_set_cpu_numa_node(MachineState *ma=
chine,
> > > > >   * CPUArchId:
> > > > >   * @arch_id - architecture-dependent CPU ID of present or possib=
le CPU   =20
> > > >=20
> > > > I know this isn't really in scope for this patch, but is @arch_id h=
ere
> > > > supposed to have meaning defined by the target, or by the machine?
> > > >=20
> > > > If it's the machime, it could do with a rename - "arch" means target
> > > > to most people (thanks to Linux).
> > > >=20
> > > > If it's the target, it's kind of bogus, because it doesn't necessar=
ily
> > > > have a clear meaning per target - get_arch_id in CPUClass has the s=
ame
> > > > problem, which is probably one reason it's basically only used by t=
he
> > > > x86 code at present.
> > > >=20
> > > > e.g. for target/ppc, what do we use?  There's the PIR, which is in =
the
> > > > CPU.. but only on some cpu models, not all.  There will generally be
> > > > some kind of master PIC id, but there are different PIC models on
> > > > different boards.  What goes in the devicetree?  Well only some
> > > > machines use devicetree, and they might define the cpu reg=20
> > > > differently.
> > > >=20
> > > > Board designs will generally try to make some if not all of those
> > > > possible values equal for simplicity, but there's still no real way=
 of
> > > > defining a sensible arch_id independent of machine / board. =20
> > > I'd say arch_id is machine specific so far, it was introduced when we
> > > didn't have CpuInstanceProperties and at that time we considered only
> > > vcpus (threads) and doesn't really apply to spapr cores.
> > >=20
> > > In general we could do away with arch_id and use CpuInstanceProperties
> > > instead, but arch_id also serves aux purpose, it allows machine to
> > > pre-calculate(cache) apic-id/mpidr values in one place and then they
> > > are/(could be) used by arch in-depended code to build acpi tables.
> > > So if we drop arch_id we would need to introduce a machine hook,
> > > which would translate CpuInstanceProperties into current arch_id. =20
> >=20
> > I think we need to do a better to job documenting where exactly
> > we expect arch_id to be used and how, so people know what it's
> > supposed to return.
> >=20
> > If the only place where it's useful now is ACPI code (is it?),
> > should we rename it to something like get_acpi_id()?
>=20
> It is also used in hw/s390x/sclp.c to fill out a control block, so acpi
> isn't the only user.

Yeah.. this is kind of bogus.  The s390 use is in machine specific
code, so it's basically just re-using the field for an unrelated usage
to the x86/arm one (ACPI).

If we can't assign a universal meaning to the field (even if the
actual values are per-machine) - and I don't think we can - then I
really don't think it belongs in CPUState.  A machine hook which
translates an ArchId to an acpi_id is the correct solution I believe.
Or even an ACPIMachine interface (to be implemented by machines which
do ACPI) which has a method to do this.

Since both the assignment and use are in machine type specific code
for s390, it can have its own field in the s390 specific cpu subclass.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Fnm8lRGFTVS/3GuM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAloD/HsACgkQbDjKyiDZ
s5KQkQ//aOmBtImRA1fXiKcvUYX2zqvMsunPFK5t9qoLbaKEaKf3R1+76kcb3oyO
bDeHG9L/AQEiznbldDlp1Fa6nKv/ok3g2/2SEIoxvujxl7GyAEGtzvFoFzQYr0PE
6JEg5GMNlUUVBykem1s3XvJiSUrMx55RjaFRVY0qwKygUSoMecuQy9p/xz4By3y2
kydLOP03XGQHSclplfo8nYc5Xpkw1es3ufvcE/pKCSAvWtcP9QdKtRTZSRbN4rQz
Lw/WkUpGT/sSb1OCemKSPnufXHX2hmKwQ3bue5G+1xYxMhFMqyGXOSeLr32h4urZ
nNl2fhI8AX9u0wo3a2Gj7eNSwIJyANFjjzW+k4ohwvqYdUANTKWh/nRrGlUmQpLx
lLWefVspp5DRLiEuDfA0oSlvl+ADBUSZTOQTEne81Xrf4CpLYVG733uAGlZ/02zq
zn0dE1js+KKzCzx+U2zd0hbAMjeTS73H6gCusjQtpQ9wOQh5zaFD9p0F9Gs+AM+h
7pssC2LqhnWPBDGi5ktxX/2cLhiDs4Of7vsqneEi3fOeOkCVex3XxBR35dUja9rQ
0XbqqA3r6pPwSz2sv5y2N10lxapD7ArvCtNIxYKQ8ZHo0jd76nbZfeorHzlX4PQi
iqfWAeNBL87SzlKHohaJlM39mY/deRaPtVXZMZTZDV7kteUFTVY=
=nyVy
-----END PGP SIGNATURE-----

--Fnm8lRGFTVS/3GuM--
