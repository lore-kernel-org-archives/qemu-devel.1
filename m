Received: from eggs.gnu.org ([2001:4830:134:3::10]:37240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f63I5-00061s-AU
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 20:07:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f63Hg-0000Jm-BK
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 20:07:09 -0400
Date: Wed, 11 Apr 2018 10:03:48 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180411000348.GL3361@umbus.fritz.box>
References: <1523383946-37373-1-git-send-email-spopovyc@redhat.com>
	<1523383946-37373-2-git-send-email-spopovyc@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dpynvXbW/eW9Tpc3"
Content-Disposition: inline
In-Reply-To: <1523383946-37373-2-git-send-email-spopovyc@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for 2.13 v2 1/2] spapr: Add ibm,
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


--dpynvXbW/eW9Tpc3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 10, 2018 at 02:12:25PM -0400, Serhii Popovych wrote:
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
> index 2c0be8c..3f61785 100644
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
> +        cpu_to_be32(0),
> +    };

Ah.. close, but not quite right.  This is saying that there's exactly
one node at the bottom (cpu) level, which isn't what we want.  Instead
of setting it to 0, we want to completely drop that layer, keeping it
unspecified.

To do that you need to change the first cell from 5 to 4 (since only 4
levels will be listed) and drop the last cell entirely.

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

--dpynvXbW/eW9Tpc3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrNUOEACgkQbDjKyiDZ
s5I4qhAAojYEg6b/AeazRfE7r9W0ONLZtVSDfJspV35j85lFERYPQOufeTCnFNJ0
UZeB3r4h7ky7RtlRgZe6qJZiK416rPYBzJ2l+ZP03ZIJzir9evjuJyk00SFGI6x2
8eC41EwZCuMsflct4pGt8/TpIQUjk/lR6LSCwN9hMzkXEFlmM6GUILMEMI5A42Qr
zHzT1LiWJA7b5js7UlbMELNS1XD+ycFNUXOBziuA0d2yeF6ZqMT/QqQAdPp0uPHq
zbspAofPLcsG0VpDHrxJu6G/ay0lg7VPRCvipzYIMBob5BpH4tagBic8HFDLcIoF
uiBBKQk3PLtAJofM7rsrBx6VmIkjUtNMQEP/yFbP7CS9e8pT8RG/yJobZ5IVC0zg
YwSlRKk9qVAh03cEM19rOaM2k1W1enAGKzRlr2B1J5YWD8smQHEbQp3JTScBjYK3
iElOdzIXVRrqldKDbY19p4mkIlsuqn+EFTjAP+45lIqtVo6MSGMB+5m7exQJ0kaX
kzKuytG3hf+0/7pydx7kUoqF71a+74Qu+yu8kNEI0lt1u1X35MIxYJveYDiRHlok
bWogJXNzuqYNelBU2PRoNAkWLJj0+ayENg0sjskYTSkPd6qDdwHwuzO193fnLmK2
SFaN/IRLiFAQRIr/kN+0mmuU0oKUepKE3Kd3z0IYsQUn7Waf+8Q=
=/QCD
-----END PGP SIGNATURE-----

--dpynvXbW/eW9Tpc3--
