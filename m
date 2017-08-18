Received: from eggs.gnu.org ([2001:4830:134:3::10]:39084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1diWMl-00081s-C6
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 21:46:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1diWMk-0000q3-CP
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 21:46:27 -0400
Date: Fri, 18 Aug 2017 11:25:01 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170818012501.GK5509@umbus.fritz.box>
References: <1502994790-21856-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yhze8HlyfmXt1APY"
Content-Disposition: inline
In-Reply-To: <1502994790-21856-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] hw/ppc/spapr: Fix segfault when
 instantiating a 'pc-dimm' without 'memdev'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--yhze8HlyfmXt1APY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 17, 2017 at 08:33:10PM +0200, Thomas Huth wrote:
> QEMU currently crashes when trying to use a 'pc-dimm' on the pseries
> machine without specifying its 'memdev' property. Let's add a sanity
> check to the pre_plug handler to fix this issue.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Thanks for all these patches fixing little bugs in 2.10.

> ---
>  hw/ppc/spapr.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index f7a1972..22d400a 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2808,10 +2808,17 @@ static void spapr_memory_pre_plug(HotplugHandler =
*hotplug_dev, DeviceState *dev,
>  {
>      PCDIMMDevice *dimm =3D PC_DIMM(dev);
>      PCDIMMDeviceClass *ddc =3D PC_DIMM_GET_CLASS(dimm);
> -    MemoryRegion *mr =3D ddc->get_memory_region(dimm);
> -    uint64_t size =3D memory_region_size(mr);
> +    MemoryRegion *mr;
> +    uint64_t size;
>      char *mem_dev;
> =20
> +    if (!dimm->hostmem) {

Isn't checking dimm->hostmem directly here an abstraction violation?
Could we just check for a NULL return from get_memory_region instead?


> +        error_setg(errp, "'" PC_DIMM_MEMDEV_PROP "' property must be set=
");
> +        return;
> +    }
> +
> +    mr =3D ddc->get_memory_region(dimm);
> +    size =3D memory_region_size(mr);
>      if (size % SPAPR_MEMORY_BLOCK_SIZE) {
>          error_setg(errp, "Hotplugged memory size must be a multiple of "
>                        "%lld MB", SPAPR_MEMORY_BLOCK_SIZE / M_BYTE);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--yhze8HlyfmXt1APY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmWQesACgkQbDjKyiDZ
s5JS/Q/7B9qTisQgCGVmVlVhgaIh83tlMXwjpFf+HU9Yxw/6GTNvNYQV9yoYKVff
On+sfkBa54+z05j/K8Tln5zU2QnOHQ3O1CkmkWmvPBnItFPIybZ52psac0D+wcgj
fvDHrIlGliFdI9F24edvGQqfnnqPnnlJNz85lzvqzkx59V4/kCE1Cep35KfGQrk7
8JnwJuTBahEjsSQ1JuDEVhtatfthb6voBdot/beWCibwYvulNkG2yqwq6/tMZ0t3
KaOYHbMDVGlH55jsP6yimz7qa0JCp4IABD5axBtfsWB7TlVQxOxM0ySwE/2/3m9+
xLYHdYkKTCxmyIszY893OJ7UDyogR8c5YR3HutwRyNMmXWdTjV6r4LdrMsxrz9KZ
zYM3ePJW5aSwCY6OS6FfxfS4wiiI5Nk3nQypOGjh8+1z8FG5CcQxowjOIs+AQCUE
g69pj3uq1NPTCpPWH8LzUz/3VcWJ1+fAZOoCwgueNI6qJ0lztcBYM970EpvsflBm
vtuRF2sf+DX34vkgGcro8Pq4NAjNzcODib9JqDXcinodppWdLTrFaI46BI9Gmg1z
MGvwyldF8so5IqH4C3m8dbRQnQ6xxuq0UDjqqztkAqoRcZDPRQVkQUwbL5k/ghEr
03bnYqLENin4qx/P1f1twD9GrNyqINWypiF0w6ecGWfF0UXk3ic=
=CUlZ
-----END PGP SIGNATURE-----

--yhze8HlyfmXt1APY--
