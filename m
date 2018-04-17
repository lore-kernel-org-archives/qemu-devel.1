Received: from eggs.gnu.org ([2001:4830:134:3::10]:55382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f8JxR-0002w1-M7
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 02:19:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f8JxQ-0006iG-Bp
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 02:19:13 -0400
Date: Tue, 17 Apr 2018 16:19:00 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180417061900.GB2317@umbus.fritz.box>
References: <1523472120-56496-1-git-send-email-spopovyc@redhat.com>
	<1523472120-56496-2-git-send-email-spopovyc@redhat.com>
	<20180413075739.GC14855@in.ibm.com>
	<e651fb40-2e44-73ed-6082-d9e497073e69@redhat.com>
	<20180417035842.GA3942@in.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="24zk1gE8NUlDmwG9"
Content-Disposition: inline
In-Reply-To: <20180417035842.GA3942@in.ibm.com>
Subject: Re: [Qemu-devel] [PATCH for 2.13 v3 1/2] spapr: Add ibm,
 max-associativity-domains property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bharata B Rao <bharata@linux.vnet.ibm.com>
Cc: Serhii Popovych <spopovyc@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--24zk1gE8NUlDmwG9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 17, 2018 at 09:28:42AM +0530, Bharata B Rao wrote:
> On Mon, Apr 16, 2018 at 07:47:29PM +0300, Serhii Popovych wrote:
> > Bharata B Rao wrote:
> > > On Wed, Apr 11, 2018 at 02:41:59PM -0400, Serhii Popovych wrote:
> > >> Now recent kernels (i.e. since linux-stable commit a346137e9142
> > >> ("powerpc/numa: Use ibm,max-associativity-domains to discover possib=
le nodes")
> > >> support this property to mark initially memory-less NUMA nodes as "p=
ossible"
> > >> to allow further memory hot-add to them.
> > >>
> > >> Advertise this property for pSeries machines to let guest kernels de=
tect
> > >> maximum supported node configuration and benefit from kernel side ch=
ange
> > >> when hot-add memory to specific, possibly empty before, NUMA node.
> > >>
> > >> Signed-off-by: Serhii Popovych <spopovyc@redhat.com>
> > >> ---
> > >>  hw/ppc/spapr.c | 10 ++++++++++
> > >>  1 file changed, 10 insertions(+)
> > >>
> > >> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > >> index a81570e..c05bbad 100644
> > >> --- a/hw/ppc/spapr.c
> > >> +++ b/hw/ppc/spapr.c
> > >> @@ -910,6 +910,13 @@ static void spapr_dt_rtas(sPAPRMachineState *sp=
apr, void *fdt)
> > >>          0, cpu_to_be32(SPAPR_MEMORY_BLOCK_SIZE),
> > >>          cpu_to_be32(max_cpus / smp_threads),
> > >>      };
> > >> +    uint32_t maxdomains[] =3D {
> > >> +        cpu_to_be32(4),
> > >> +        cpu_to_be32(0),
> > >> +        cpu_to_be32(0),
> > >> +        cpu_to_be32(0),
> > >> +        cpu_to_be32(nb_numa_nodes - 1),
> > >> +    };
> > >>
> > >>      _FDT(rtas =3D fdt_add_subnode(fdt, 0, "rtas"));
> > >>
> > >> @@ -946,6 +953,9 @@ static void spapr_dt_rtas(sPAPRMachineState *spa=
pr, void *fdt)
> > >>      _FDT(fdt_setprop(fdt, rtas, "ibm,associativity-reference-points=
",
> > >>                       refpoints, sizeof(refpoints)));
> > >>
> > >> +    _FDT(fdt_setprop(fdt, rtas, "ibm,max-associativity-domains",
> > >> +                     maxdomains, sizeof(maxdomains)));
> > >> +
> > >>      _FDT(fdt_setprop_cell(fdt, rtas, "rtas-error-log-max",
> > >>                            RTAS_ERROR_LOG_MAX));
> > >>      _FDT(fdt_setprop_cell(fdt, rtas, "rtas-event-scan-rate",
> > >=20
> > > This commit causes hash guest with latest guest kernel to hang at ear=
ly boot.
> >=20
> > I use v4.16 tag from stable and can't reproduce on P8 machine reported
> > issue.
> >=20
> > Could you please share more details about your setup, kernel commit id
> > you spot problem?
>=20
> I am on 4.16.0-rc7 (commit id: 0b412605ef5f)
>=20
> BTW this happens only for non-NUMA guest.

Ah, that might explain it.  With no NUMA nodes specified, I think this
code will put a -1 into the max-associativity-domains property, which
is probably causing the mess.  If we don't have NUMA (nb_numa_nodes =3D=3D
0) we probably want to either omit the property entirely, or clamp
that 5th cell to 0.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--24zk1gE8NUlDmwG9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrVkdIACgkQbDjKyiDZ
s5LnEA/+I1b8iB49+lCoHNVImwqDkxE3XzKDYIHFtTWVpR07JNKb7ylTy6qhqUOp
dKONBJ/1MP3VUSbh4hrOznPtx4fbyhuPym7rCUEY4pQvh/hKboDPAxmdLcbJ74ct
VOqFWSCQwANuWrZ7CbvtSbFPZiAT6+YnJTatNZYo0xSWVO2ukQ3W05k+azOYrTLY
E/3LY/OvGJy8cj05OGuN+AaoZLw1S9LhU/XNtDON2EHJeLLhCifU4BtI8+C+bo28
Z/njAGM7GQ/9NVU/QCif+4ebdzeqkmumqefvfAQDJgQtSq2wfMIH2RMnmnHaQYxR
8ERQ3E+6AV+3qAdD09vrCRGAUlCh/wsqr5D7iHvdKGozJGl97U+rFCL0HmYGGRCC
DrXWdy/RzLH99FYa0jE7xYRDZeAc0SZO8cymYhagaGvqVuj+0REP93ateDRtlR+R
d9HpEPk+bg8lykdy0NZTDo60X2uNhdfwprlL43qlCWKZ1rzqLAZM3SgYwEkHE6IP
Sc7ZXsDImfoFUh+g+ZdgSeckWJRk/wEnZVzZnoMB3URiMjJSej+yXhit9M/QJCs5
8wXKCyLKVygyZY+JNOUZ9XWpbt0VpyKhHtnlX5SmSqUR6ngeriW5Qjk/ft93U8uL
iQtjBeBmTfVh9i4z8TmyLm/SPWWFB+ydP9u979sQIQX2WyxSq1U=
=w75Z
-----END PGP SIGNATURE-----

--24zk1gE8NUlDmwG9--
