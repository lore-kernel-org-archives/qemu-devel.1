Received: from eggs.gnu.org ([2001:4830:134:3::10]:57963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUiPi-0002gf-V9
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 20:53:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUiPh-0001dz-JH
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 20:52:59 -0400
Date: Mon, 18 Jun 2018 10:52:41 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180618005241.GI25461@umbus.fritz.box>
References: <20180615140448.32234-1-david@redhat.com>
	<20180615140448.32234-14-david@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/GPgYEyhnw15BExa"
Content-Disposition: inline
In-Reply-To: <20180615140448.32234-14-david@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 13/13] pc-dimm: get_memory_region() will
 not fail after realize
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


--/GPgYEyhnw15BExa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 15, 2018 at 04:04:48PM +0200, David Hildenbrand wrote:
> Let's try to reduce error handling a bit. In the plug/unplug case, the
> device was realized and therefore we can assume that getting access to
> the memory region will not fail.
>=20
> For get_vmstate_memory_region() this is already handled that way.
> Document both cases.
>=20
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

and ppc parts

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/i386/pc.c             |  7 +------
>  hw/mem/pc-dimm.c         |  7 +------
>  hw/ppc/spapr.c           | 12 ++----------
>  include/hw/mem/pc-dimm.h |  6 ++++--
>  4 files changed, 8 insertions(+), 24 deletions(-)
>=20
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 2db032a6df..f310040351 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1706,15 +1706,10 @@ static void pc_memory_plug(HotplugHandler *hotplu=
g_dev,
>      PCMachineClass *pcmc =3D PC_MACHINE_GET_CLASS(pcms);
>      PCDIMMDevice *dimm =3D PC_DIMM(dev);
>      PCDIMMDeviceClass *ddc =3D PC_DIMM_GET_CLASS(dimm);
> -    MemoryRegion *mr;
> +    MemoryRegion *mr =3D ddc->get_memory_region(dimm, &error_abort);
>      uint64_t align =3D TARGET_PAGE_SIZE;
>      bool is_nvdimm =3D object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
> =20
> -    mr =3D ddc->get_memory_region(dimm, &local_err);
> -    if (local_err) {
> -        goto out;
> -    }
> -
>      if (memory_region_get_alignment(mr) && pcmc->enforce_aligned_dimm) {
>          align =3D memory_region_get_alignment(mr);
>      }
> diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
> index 4ff39b59ef..65843bc52a 100644
> --- a/hw/mem/pc-dimm.c
> +++ b/hw/mem/pc-dimm.c
> @@ -37,15 +37,10 @@ void pc_dimm_plug(DeviceState *dev, MachineState *mac=
hine, uint64_t align,
>      PCDIMMDeviceClass *ddc =3D PC_DIMM_GET_CLASS(dimm);
>      MemoryRegion *vmstate_mr =3D ddc->get_vmstate_memory_region(dimm,
>                                                                &error_abo=
rt);
> +    MemoryRegion *mr =3D ddc->get_memory_region(dimm, &error_abort);
>      Error *local_err =3D NULL;
> -    MemoryRegion *mr;
>      uint64_t addr;
> =20
> -    mr =3D ddc->get_memory_region(dimm, &local_err);
> -    if (local_err) {
> -        goto out;
> -    }
> -
>      addr =3D object_property_get_uint(OBJECT(dimm),
>                                      PC_DIMM_ADDR_PROP, &local_err);
>      if (local_err) {
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 3e5320020f..6934abc21e 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3142,14 +3142,10 @@ static void spapr_memory_plug(HotplugHandler *hot=
plug_dev, DeviceState *dev,
>      sPAPRMachineState *ms =3D SPAPR_MACHINE(hotplug_dev);
>      PCDIMMDevice *dimm =3D PC_DIMM(dev);
>      PCDIMMDeviceClass *ddc =3D PC_DIMM_GET_CLASS(dimm);
> -    MemoryRegion *mr;
> +    MemoryRegion *mr =3D ddc->get_memory_region(dimm, &error_abort);
>      uint64_t align, size, addr;
>      uint32_t node;
> =20
> -    mr =3D ddc->get_memory_region(dimm, &local_err);
> -    if (local_err) {
> -        goto out;
> -    }
>      align =3D memory_region_get_alignment(mr);
>      size =3D memory_region_size(mr);
> =20
> @@ -3340,16 +3336,12 @@ static void spapr_memory_unplug_request(HotplugHa=
ndler *hotplug_dev,
>      Error *local_err =3D NULL;
>      PCDIMMDevice *dimm =3D PC_DIMM(dev);
>      PCDIMMDeviceClass *ddc =3D PC_DIMM_GET_CLASS(dimm);
> -    MemoryRegion *mr;
> +    MemoryRegion *mr =3D ddc->get_memory_region(dimm, &error_abort);
>      uint32_t nr_lmbs;
>      uint64_t size, addr_start, addr;
>      int i;
>      sPAPRDRConnector *drc;
> =20
> -    mr =3D ddc->get_memory_region(dimm, &local_err);
> -    if (local_err) {
> -        goto out;
> -    }
>      size =3D memory_region_size(mr);
>      nr_lmbs =3D size / SPAPR_MEMORY_BLOCK_SIZE;
> =20
> diff --git a/include/hw/mem/pc-dimm.h b/include/hw/mem/pc-dimm.h
> index 5679a80465..26ebb7d5e9 100644
> --- a/include/hw/mem/pc-dimm.h
> +++ b/include/hw/mem/pc-dimm.h
> @@ -62,9 +62,11 @@ typedef struct PCDIMMDevice {
>   * @realize: called after common dimm is realized so that the dimm based
>   * devices get the chance to do specified operations.
>   * @get_memory_region: returns #MemoryRegion associated with @dimm which
> - * is directly mapped into the physical address space of guest.
> + * is directly mapped into the physical address space of guest. Will not
> + * fail after the device was realized.
>   * @get_vmstate_memory_region: returns #MemoryRegion which indicates the
> - * memory of @dimm should be kept during live migration.
> + * memory of @dimm should be kept during live migration. Will not fail
> + * after the device was realized.
>   */
>  typedef struct PCDIMMDeviceClass {
>      /* private */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--/GPgYEyhnw15BExa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsnAlgACgkQbDjKyiDZ
s5Kbeg/9EuiW7DhVCvQkYb2K9TWdjTROErD5OiWhudMpytICJ39EIdQtEriDag5g
IbqraYtrfVL+cKwskPxoWyqhUskQG96kISw/PSmdrvZx3SqqpSOtpl7yLUwzjFt1
Myw6PPQtsO21Sk2JXRRZzfeOEd8og+O3JenOxULxuwjOi5FHaj7WpVgFHK/YJk9P
jCkVOfnSe7yXFD4Mr8DeXzeQoiPTayhHwa8PZ3Z7ZciDBK9QJdr14qSaHu4GMRP1
iTJ1ZvZsoTbWZ8+fmuYqFoP4CrwztJMVV/3PiEasncp9nO9bnXilwoohjb1GbJYm
mlJvUJ/j+N64v1Ix1DqsrB+Yp5Gz9L2+ujpOULT7OzT5tVEpI1y1Iqd942l4l+pc
9sSVo3wdba6q7h/7gJWZ/YyIDFQ6CXAwIMuv7CSmFrQNEByx6kFVIhxekVXI/FeR
TKw+uhdz1T8C7xCP0hYeP5kkLFJf/ZuWepjMuaJY8P9628dLKfcuR6G8WT8mJtIq
WMeQiL5ddDFOmx6xFYpVA1r1JwQ2BWGJ1V8zYe7ui7hvKifiVXT9ryUqfAKLnqQ9
43dkKvQk7Trwbw+oAxvwstKNxd+MBsEIpL6AnUhpwOknWeWSck5z9w+2Ub5KPxOU
TGbC+U1YJzJQfI+J0dDH2tWz+nk5OIgxVTYagu/CM7nuDVQ+SLs=
=ZK5M
-----END PGP SIGNATURE-----

--/GPgYEyhnw15BExa--
