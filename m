Received: from eggs.gnu.org ([2001:4830:134:3::10]:33700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f5kue-0006WP-5d
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 00:29:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f5kuc-0003tL-U4
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 00:29:44 -0400
Date: Tue, 10 Apr 2018 14:29:29 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180410042929.GJ3361@umbus.fritz.box>
References: <1522938923-96058-1-git-send-email-spopovyc@redhat.com>
	<1522938923-96058-3-git-send-email-spopovyc@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="huG+SbfbdD6eblZQ"
Content-Disposition: inline
In-Reply-To: <1522938923-96058-3-git-send-email-spopovyc@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for 2.13 2/2] spapr: Add ibm,
 max-associativity-domains property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Serhii Popovych <spopovyc@redhat.com>
Cc: qemu-ppc@nongnu.org, bharata@linux.vnet.ibm.com, qemu-devel@nongnu.org


--huG+SbfbdD6eblZQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 05, 2018 at 10:35:23AM -0400, Serhii Popovych wrote:
> Now recent kernels (i.e. since linux-stable commit a346137e9142
> ("powerpc/numa: Use ibm,max-associativity-domains to discover possible no=
des")
> support this property to mark initially memory-less NUMA nodes as "possib=
le"
> to allow further memory hot-add to them.
>=20
> Advertise this property for pSeries machines to let guest kernels detect
> maximum supported node configuration and benefit from kernel side change
> when hot-add memory to specific, possibly empty before, NUMA node.
>=20
> Signed-off-by: Serhii Popovych <spopovyc@redhat.com>
> ---
>  hw/ppc/spapr.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 3ad4545..e02fc94 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -909,6 +909,14 @@ static void spapr_dt_rtas(sPAPRMachineState *spapr, =
void *fdt)
>          0, cpu_to_be32(SPAPR_MEMORY_BLOCK_SIZE),
>          cpu_to_be32(max_cpus / smp_threads),
>      };
> +    uint32_t maxdomains[] =3D {
> +        cpu_to_be32(5),
> +        cpu_to_be32(0),
> +        cpu_to_be32(0),
> +        cpu_to_be32(0),
> +        cpu_to_be32(nb_numa_nodes - 1),
> +        cpu_to_be32(max_cpus - 1),
> +    };

There's a minor problem here, which I didn't think of when I was
discussing this with you earlier.

(max_cpus - 1) in the last slot isn't quite right, because we need the
maximum vcpu id here.  Because of (complicated, historical) reasons we
don't allocate the vcpu ids contiguously in all cases, so it could be
larger than max_cpus - 1.

But, we don't actually need to handle that case.  We give 5 levels of
associativity on cpus, but only 4 on memory.  Having a quick look at
the NUMA code on the guest side, I'm pretty sure it's ok if we only
give maximum values to depth 4 here, so we can just drop the last cell
here.

> =20
>      _FDT(rtas =3D fdt_add_subnode(fdt, 0, "rtas"));
> =20
> @@ -945,6 +953,9 @@ static void spapr_dt_rtas(sPAPRMachineState *spapr, v=
oid *fdt)
>      _FDT(fdt_setprop(fdt, rtas, "ibm,associativity-reference-points",
>                       refpoints, sizeof(refpoints)));
> =20
> +    _FDT(fdt_setprop(fdt, rtas, "ibm,max-associativity-domains",
> +                     maxdomains, sizeof(maxdomains)));
> +
>      _FDT(fdt_setprop_cell(fdt, rtas, "rtas-error-log-max",
>                            RTAS_ERROR_LOG_MAX));
>      _FDT(fdt_setprop_cell(fdt, rtas, "rtas-event-scan-rate",

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--huG+SbfbdD6eblZQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrMPakACgkQbDjKyiDZ
s5JptRAAudARq+YkqiWhYgM0DbmxfXL7fuyX9EfDdT5DBcnpdfW4X3ulOHH4IFzj
ceToBme4PZBNqcypvTqYoz4ouQuKZG2WMR3VFv64Xt7zwcGCbuxZcta+rEDXr0+S
lGmqKFWtNhRVvS/cR1bJ6c22J0QB/ry2LiAbUcgN4l1/wFav9CpdL7+aY6zoW75u
Y4Er2YN/OT/PF13ozQvp6KxaNonQKCq9sUZBmJvKtgWYEPPJ7S7j3hq3DmXV0pEO
z6b7JSBHfbM4MR2n86XfoE3GrlS7NTkhy/edwhTP1Mop5/Qsf/J6nkCtYKaDR1Lb
8BgEC1MmStIYjYXn+VE580GSuinONtqWt0M0NYXxl9SPkn4M4sJoqrREIqHKayyH
NeKpNX6BlxJDozFoxpKy8yA+lyPyLiUcMQgu9iL4VG7bwYfFRjGp3pMQd9kYtY7O
c1Xszq15D/9NdZ3zF4C4RK2+hYDduS3Y39xC0fFhhNyTctQ/g8pbjMlkZ60MHBd7
xL5NICwnD2qm44iQbOeIzQTL85WknnGmenvUZ7kvOakn9nbnTO5FP4e35hFIbvSV
QkuWtNlDg+U8vnAGF6IQo6V0Vm45axmz+zXItsyfoysUK8zTHDOhFtIXaXndw6kt
m6rPgBb0URZIlEoSPAayxRWoCQqIk8WXF9mAQCKSnEOqm9BsHjI=
=TSP4
-----END PGP SIGNATURE-----

--huG+SbfbdD6eblZQ--
