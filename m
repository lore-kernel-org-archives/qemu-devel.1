Received: from eggs.gnu.org ([2001:4830:134:3::10]:33136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gPIVS-0001Bj-NY
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 21:44:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gPIVP-000285-JD
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 21:44:46 -0500
Date: Wed, 21 Nov 2018 13:44:22 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181121024422.GA21985@umbus>
References: <1542644585-87579-1-git-send-email-spopovyc@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
In-Reply-To: <1542644585-87579-1-git-send-email-spopovyc@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for 3.1 v2] spapr: Fix ibm,
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


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 19, 2018 at 11:23:05AM -0500, Serhii Popovych wrote:
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
> Fixes: da9f80fbad21 ("spapr: Add ibm,max-associativity-domains property")
> Reported-by: Laurent Vivier <lvivier@redhat.com>
> Signed-off-by: Serhii Popovych <spopovyc@redhat.com>
> ---
> v2
>   Remove now unneeded ?: statement previously used to catch -1 as numa no=
de
>   causing Linux guests hanging on boot.
>=20
>  hw/ppc/spapr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 7afd1a1..a7171fb 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1033,7 +1033,7 @@ static void spapr_dt_rtas(sPAPRMachineState *spapr,=
 void *fdt)
>          cpu_to_be32(0),
>          cpu_to_be32(0),
>          cpu_to_be32(0),
> -        cpu_to_be32(nb_numa_nodes ? nb_numa_nodes - 1 : 0),
> +        cpu_to_be32(nb_numa_nodes),

Sorry, I know this got discussed in the thread on the earlier version,
but I'd prefer we leave the conditional expression in here.

qemu makes a distinction between "non NUMA" (nb_numa_nodes =3D=3D 0) and
"NUMA with one node" (nb_numa_nodes =3D=3D 1).  But from a PAPR guests's
point of view these are equivalent.  I don't want to present two
different cases to the guest when we don't need to, so even though the
guest can handle it, I'd prefer we put a '1' here for both the
nb_numa_nodes =3D=3D 0 and nb_numa_nodes =3D=3D 1 case.

>      };
> =20
>      _FDT(rtas =3D fdt_add_subnode(fdt, 0, "rtas"));

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlv0xoQACgkQbDjKyiDZ
s5IutQ//QmSL1HhpGMDPPe1D7Cpm0tgamNA5SY/uDCSOmWaomEsQJupaxeYKK25q
cyoIvD6+IYi2WULIx9cYlwzjpEmj5TlnYzXTjgLyuLH8bXdaZj95jKtll/SHvrNW
aHyGTysI2da8e8GiJZCNpTQkJ55ELuozSYhMdoguyw2oz4W4APzgJOPCvzvDZQQS
b8UgmX1KFhBGfShOcDzmrBUTy8ejJDpgCYWsEIEGaS7I0Nh+VKqD5QJhdI04lDPd
W82iBPTourcgCA4+kifyqEUzvTdFXSsPwrT5gBRwoAkae1lHaZhJbgusxdCQ8WT6
Aj/v+xuJ0Tu3CHPt6TzJhFy/YtIPVjpKXu4Wg32+WBm7ruIwvcBEupCGoyZpc9Nj
hQvnwK2oZlu6QD76hZhBz+0TFII41RI2Zjhs58B8+WeEtNPhOvF5UB3iWgOh366C
jCeq5wfNd6k1tgH8Ecs8j7WH5LQfjuCbiBgFyVBIy//tz4odgTCQ4wsuDuAyMLQI
3Q7LR5wKI1kHcDVf/YQ43xbUuAY4977F10ko0LSnLia9j4rZJBgRkB9bUhetaXoJ
5Yx3sRkH5Rg5VwvV1WGw2LGh/Jzv1MHsociysbcM/0GdmO6PDfQvpQTlF44ld4Ux
hEva6CvImPUnlZPPfq00ypnl6Y+xsN5mOHhrByDzO1pYIm6j1Jo=
=HKWu
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--
