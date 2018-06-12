Received: from eggs.gnu.org ([2001:4830:134:3::10]:40285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSYOv-0002nK-4c
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 21:47:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSYOq-0002Nl-UD
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 21:47:13 -0400
Date: Tue, 12 Jun 2018 11:02:33 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180612010233.GN2737@umbus.fritz.box>
References: <20180611121655.19616-1-david@redhat.com>
	<20180611121655.19616-6-david@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vDEbda84Uy/oId5W"
Content-Disposition: inline
In-Reply-To: <20180611121655.19616-6-david@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 05/11] spapr: move memory hotplug size
 check into plug code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Alexander Graf <agraf@suse.de>


--vDEbda84Uy/oId5W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 11, 2018 at 02:16:49PM +0200, David Hildenbrand wrote:
> This might look like a step backwards, but it is not. get_memory_region()
> should not be called on uninititalized devices. In general, only
> properties should be access, but no "derived" satte like the memory
> region.
>=20
> 1. We need duplicate error checks if memdev is actually already set.
>    realize() performs these checks, no need to duplicate.
> 2. This is bad practise as one can see when looking at the NVDIMM
>    implemetation. The call does not return sane data before the device
>    is realized. Although spapr does not use NVDIMM, conceptually it is
>    wrong.
>=20
> So let's just move this call to the right place. We can then cleanup
> get_memory_region().
>=20
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/ppc/spapr.c | 21 ++++++---------------
>  1 file changed, 6 insertions(+), 15 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index f59999daac..a5f1bbd58a 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3153,6 +3153,12 @@ static void spapr_memory_plug(HotplugHandler *hotp=
lug_dev, DeviceState *dev,
>      align =3D memory_region_get_alignment(mr);
>      size =3D memory_region_size(mr);
> =20
> +    if (size % SPAPR_MEMORY_BLOCK_SIZE) {
> +        error_setg(&local_err, "Hotplugged memory size must be a multipl=
e of "
> +                   "%lld MB", SPAPR_MEMORY_BLOCK_SIZE / M_BYTE);
> +        goto out;
> +    }
> +
>      pc_dimm_memory_plug(dev, MACHINE(ms), align, &local_err);
>      if (local_err) {
>          goto out;
> @@ -3186,9 +3192,6 @@ static void spapr_memory_pre_plug(HotplugHandler *h=
otplug_dev, DeviceState *dev,
>  {
>      const sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(hotplug_dev=
);
>      PCDIMMDevice *dimm =3D PC_DIMM(dev);
> -    PCDIMMDeviceClass *ddc =3D PC_DIMM_GET_CLASS(dimm);
> -    MemoryRegion *mr;
> -    uint64_t size;
>      char *mem_dev;
> =20
>      if (!smc->dr_lmb_enabled) {
> @@ -3196,18 +3199,6 @@ static void spapr_memory_pre_plug(HotplugHandler *=
hotplug_dev, DeviceState *dev,
>          return;
>      }
> =20
> -    mr =3D ddc->get_memory_region(dimm, errp);
> -    if (!mr) {
> -        return;
> -    }
> -    size =3D memory_region_size(mr);
> -
> -    if (size % SPAPR_MEMORY_BLOCK_SIZE) {
> -        error_setg(errp, "Hotplugged memory size must be a multiple of "
> -                      "%lld MB", SPAPR_MEMORY_BLOCK_SIZE / M_BYTE);
> -        return;
> -    }
> -
>      mem_dev =3D object_property_get_str(OBJECT(dimm), PC_DIMM_MEMDEV_PRO=
P, NULL);
>      if (mem_dev && !kvmppc_is_mem_backend_page_size_ok(mem_dev)) {
>          error_setg(errp, "Memory backend has bad page size. "

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--vDEbda84Uy/oId5W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsfG6kACgkQbDjKyiDZ
s5LSyBAAlW9Lw4jF8I8H/R2sQtSHHvl33cncxdswtvTGCm5Z6cSoqGmDnBtsQhIj
GCk+YFAQyqK/Uz0OqoyL0DN6mpJlXEscPyZCNhCy3UJ7cVLalcs5NDWjnPrOSvzd
d+Iv9E6+FprQGcpvJsuBP3E+UPmUM/TRyC8hjF4JCrl5C7ztNgLxLdSV/q++B9SG
k1HBurO5JtSO6RHsZcsdjS+oVe1N3qWQyorQwWGAhiJLsNXx6eIWUoEgjEdvo1Ek
M7ByANM3Q/45x3NWeRxkb6RK9Fzs5PL9JiJXSoGeIkQXnnSJqGLoEqGU9TxmUhZd
S3OFasLjGro1RLaQa9AhQ3JxoDyaNOflflHY3fTli2ecnyW8LRsguNZgkaOez2Mx
uoxH1vx0aL/93/oIKAe4DN/tT6/U30uRaVkTub9Mdf4vqb5l/wRwz7QSdSlKlILn
qM7oYlkb6+lIRvsJqikiUdICsVleO2qFwXmeYQ/OMhjwNv/3shK3yNvoLLhp9+0N
rUlKD/8cP+E8Hi1S3cZ0lf0zXIL6VCqZaV5pF3UYiNlSzdc6EVsD0tRjtr9eb02+
FEeNvSlT0pGoUAZIVWjCozEiaTIFUBSDVbrx4e4kbYnqWCh5CgaAAEpTdbFtUU0T
cd3HYkogTNEQOFl4pgWLlJa//5sGDECnf6hkXZrs5FXOlcUomlA=
=NA4R
-----END PGP SIGNATURE-----

--vDEbda84Uy/oId5W--
