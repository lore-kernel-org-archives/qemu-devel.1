Received: from eggs.gnu.org ([2001:4830:134:3::10]:39732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fSPeZ-00063Z-Os
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 12:26:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fSPeW-0000Pm-JM
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 12:26:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38286 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fSPeW-0000Pc-B4
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 12:26:44 -0400
Date: Mon, 11 Jun 2018 17:26:30 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180611162630.GH17756@stefanha-x1.localdomain>
References: <e74aee54657de6f8d643a92ba21f467db149c2c8.1528714312.git.yi.z.zhang@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Rn7IEEq3VEzCw+ji"
Content-Disposition: inline
In-Reply-To: <e74aee54657de6f8d643a92ba21f467db149c2c8.1528714312.git.yi.z.zhang@linux.intel.com>
Subject: Re: [Qemu-devel] [RFC PATCH 1/1] nvdimm: let qemu requiring section
 alignment of pmem resource.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Yi <yi.z.zhang@linux.intel.com>
Cc: xiaoguangrong.eric@gmail.com, dan.j.williams@intel.com, ross.zwisler@linux.intel.com, yu.c.zhang@linux.intel.com, mst@redhat.com, qemu-devel@nongnu.org, imammedo@redhat.com, linux-nvdimm@lists.01.org, ehabkost@redhat.com


--Rn7IEEq3VEzCw+ji
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 11, 2018 at 06:54:25PM +0800, Zhang Yi wrote:
> Nvdimm driver use Memory hot-plug APIs to map it's pmem resource,
> which at a section granularity.
>=20
> When QEMU emulated the vNVDIMM device, decrease the label-storage,
> QEMU will put the vNVDIMMs directly next to one another in physical
> address space, which means that the boundary between them won't
> align to the 128 MB memory section size.

I'm having a hard time parsing this.

Where does the "128 MB memory section size" come from?  ACPI?
A chipset-specific value?

> Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
> ---
>  hw/mem/nvdimm.c         | 2 +-
>  include/hw/mem/nvdimm.h | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
> index 4087aca..ff6e171 100644
> --- a/hw/mem/nvdimm.c
> +++ b/hw/mem/nvdimm.c
> @@ -109,7 +109,7 @@ static void nvdimm_realize(PCDIMMDevice *dimm, Error =
**errp)
>      NVDIMMDevice *nvdimm =3D NVDIMM(dimm);
>      uint64_t align, pmem_size, size =3D memory_region_size(mr);
> =20
> -    align =3D memory_region_get_alignment(mr);
> +    align =3D MAX(memory_region_get_alignment(mr), NVDIMM_ALIGN_SIZE);
> =20
>      pmem_size =3D size - nvdimm->label_size;
>      nvdimm->label_data =3D memory_region_get_ram_ptr(mr) + pmem_size;
> diff --git a/include/hw/mem/nvdimm.h b/include/hw/mem/nvdimm.h
> index 3c82751..1d384e4 100644
> --- a/include/hw/mem/nvdimm.h
> +++ b/include/hw/mem/nvdimm.h
> @@ -41,6 +41,7 @@
>   *    at least 128KB in size, which holds around 1000 labels."
>   */
>  #define MIN_NAMESPACE_LABEL_SIZE      (128UL << 10)
> +#define NVDIMM_ALIGN_SIZE      (128UL << 20)
> =20
>  #define TYPE_NVDIMM      "nvdimm"
>  #define NVDIMM(obj)      OBJECT_CHECK(NVDIMMDevice, (obj), TYPE_NVDIMM)
> --=20
> 2.7.4
>=20

--Rn7IEEq3VEzCw+ji
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbHqK2AAoJEJykq7OBq3PIGxoH/jEVOGFM//UKxMGmAa9xIOKk
2XESW9OhQxn2jLhkqUPXcdVHVrF470KE6+1yUEapHr3+ekpTvnlyLHkng88SF7o0
Zgjyu5AHfnmf751l4OFeNlyyxzzzdy+agwtM3FbGQLlfXmr8GhQZjAnD2gqMQyGZ
cs3kNgSK3PJBMS/rfufR1Qac3VimzDBN3lLrtS2zmn3lnzzi9kTqqtKiohW9jEvy
08pZNHesxUAXqJBesbnpnbKf8APhiFZmmja3RE6kiIQwfqS7yphVtqEJVW6UM5U7
vPoIGFoogeAxI8cUasgm3qPUQuQ6s/5eXh/kvFZeUk+Ml4ubCkBWo4t1ByNsIPY=
=ti8a
-----END PGP SIGNATURE-----

--Rn7IEEq3VEzCw+ji--
