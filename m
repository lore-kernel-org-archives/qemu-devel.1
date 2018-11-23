Received: from eggs.gnu.org ([2001:4830:134:3::10]:48784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gPzDN-0007AW-Q6
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 19:20:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gPzDJ-0007tP-Ge
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 19:20:57 -0500
Date: Fri, 23 Nov 2018 11:19:36 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181123001936.GN10448@umbus.fritz.box>
References: <1542892767-37213-1-git-send-email-spopovyc@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nRwNdQxTdQ7rZk9A"
Content-Disposition: inline
In-Reply-To: <1542892767-37213-1-git-send-email-spopovyc@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for 3.1 v3] spapr: Fix ibm,
 max-associativity-domains property number of nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Serhii Popovych <spopovyc@redhat.com>
Cc: qemu-ppc@nongnu.org, lvivier@redhat.com, qemu-devel@nongnu.org


--nRwNdQxTdQ7rZk9A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 22, 2018 at 08:19:27AM -0500, Serhii Popovych wrote:
> Laurent Vivier reported off by one with maximum number of NUMA nodes
> provided by qemu-kvm being less by one than required according to
> description of "ibm,max-associativity-domains" property in LoPAPR.
>=20
> It appears that I incorrectly treated LoPAPR description of this
> property assuming it provides last valid domain (NUMA node here)
> instead of maximum number of domains.
>=20
>   ### Before hot-add
>=20
>   (qemu) info numa
>   3 nodes
>   node 0 cpus: 0
>   node 0 size: 0 MB
>   node 0 plugged: 0 MB
>   node 1 cpus:
>   node 1 size: 1024 MB
>   node 1 plugged: 0 MB
>   node 2 cpus:
>   node 2 size: 0 MB
>   node 2 plugged: 0 MB
>=20
>   $ numactl -H
>   available: 2 nodes (0-1)
>   node 0 cpus: 0
>   node 0 size: 0 MB
>   node 0 free: 0 MB
>   node 1 cpus:
>   node 1 size: 999 MB
>   node 1 free: 658 MB
>   node distances:
>   node   0   1
>     0:  10  40
>     1:  40  10
>=20
>   ### Hot-add
>=20
>   (qemu) object_add memory-backend-ram,id=3Dmem0,size=3D1G
>   (qemu) device_add pc-dimm,id=3Ddimm1,memdev=3Dmem0,node=3D2
>   (qemu) [   87.704898] pseries-hotplug-mem: Attempting to hot-add 4 ...
>   <there is no "Initmem setup node 2 [mem 0xHEX-0xHEX]">
>   [   87.705128] lpar: Attempting to resize HPT to shift 21
>   ... <HPT resize messages>
>=20
>   ### After hot-add
>=20
>   (qemu) info numa
>   3 nodes
>   node 0 cpus: 0
>   node 0 size: 0 MB
>   node 0 plugged: 0 MB
>   node 1 cpus:
>   node 1 size: 1024 MB
>   node 1 plugged: 0 MB
>   node 2 cpus:
>   node 2 size: 1024 MB
>   node 2 plugged: 1024 MB
>=20
>   $ numactl -H
>   available: 2 nodes (0-1)
>   ^^^^^^^^^^^^^^^^^^^^^^^^
>              Still only two nodes (and memory hot-added to node 0 below)
>   node 0 cpus: 0
>   node 0 size: 1024 MB
>   node 0 free: 1021 MB
>   node 1 cpus:
>   node 1 size: 999 MB
>   node 1 free: 658 MB
>   node distances:
>   node   0   1
>     0:  10  40
>     1:  40  10
>=20
> After fix applied numactl(8) reports 3 nodes available and memory
> plugged into node 2 as expected.
>=20
> >From David Gibson:
> ------------------
>   Qemu makes a distinction between "non NUMA" (nb_numa_nodes =3D=3D 0) and
>   "NUMA with one node" (nb_numa_nodes =3D=3D 1).  But from a PAPR guests's
>   point of view these are equivalent.  I don't want to present two
>   different cases to the guest when we don't need to, so even though the
>   guest can handle it, I'd prefer we put a '1' here for both the
>   nb_numa_nodes =3D=3D 0 and nb_numa_nodes =3D=3D 1 case.
>=20
> This consolidates everything discussed previously on mailing list.
>=20
> Fixes: da9f80fbad21 ("spapr: Add ibm,max-associativity-domains property")
> Reported-by: Laurent Vivier <lvivier@redhat.com>
> Signed-off-by: Serhii Popovych <spopovyc@redhat.com>

Applied, thanks.

> ---
>  hw/ppc/spapr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 7afd1a1..2ee7201 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1033,7 +1033,7 @@ static void spapr_dt_rtas(sPAPRMachineState *spapr,=
 void *fdt)
>          cpu_to_be32(0),
>          cpu_to_be32(0),
>          cpu_to_be32(0),
> -        cpu_to_be32(nb_numa_nodes ? nb_numa_nodes - 1 : 0),
> +        cpu_to_be32(nb_numa_nodes ? nb_numa_nodes : 1),
>      };
> =20
>      _FDT(rtas =3D fdt_add_subnode(fdt, 0, "rtas"));

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--nRwNdQxTdQ7rZk9A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlv3R5gACgkQbDjKyiDZ
s5L/Yg/+L4WwwsEk2hvYB9ucEth2XFNeR8nml9RWRKUBQpk28uAMo/6ys8KSV/c8
qG/Yzu86GYcflTxPPGF69MkifxjREbT/P1toANgUEdaIche1kv4iYhckPyAWiroa
EUC+6JJ+RfzTieixRjLEg1etCkYfsq3kbzUNzm+/DwA5p3wOlnMpYjYhXnU56wL7
uV7p1gDgblmHHgOuwlpLaKOBaLTN6KQGm/QDw7qbCawkhNTAm0+/znLwMuxdaWQh
MBg3+sfFjM023tqg7iMKZXjRlnVMriKs5+ZMJllTH0lTme+JaIzRUjCL0g8fjBqB
F9YzQdbzu1h/uGXTI4+XSmS+Wuz2ZrP1/caUQge8/PM/PORk2M67zqB5f7a60i04
8wSIjw3y1t368TMF32JIpnQQ5waEmFeQD+OwTA+KGzFwo5qEMSp/vjsoHJDnQy0K
KQx113Pxk5ngO0WJPqX6mnS+W8u+vjGPhpWki6g8a6LtlOE9BZo33pSHkU8VvL75
QgFp5PpWF5FE04Qylrw3qpWllvilm2HlPFpbruPZZupSra8+ycSyUTcILQJmqhzC
f7JGRiQjQ3a7qYq09VXt1+ch+d2bwwpGOF6yFr1YPqXhQvwxlyQJJPvOSK4xkOOV
AehLrJsC4WedWs1k8378OGv8Gws329wWw1EWU/ztQKMkeqLLTB8=
=0sNh
-----END PGP SIGNATURE-----

--nRwNdQxTdQ7rZk9A--
