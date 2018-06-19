Received: from eggs.gnu.org ([2001:4830:134:3::10]:60229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fV4G5-0004TP-SL
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 20:12:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fV4G4-0000G3-ID
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 20:12:29 -0400
Date: Tue, 19 Jun 2018 10:12:03 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180619001203.GG25461@umbus.fritz.box>
References: <20180618142536.23995-1-david@redhat.com>
	<20180618142536.23995-12-david@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="T3/vOasYOEcRCfmZ"
Content-Disposition: inline
In-Reply-To: <20180618142536.23995-12-david@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 11/12] nvdimm: make get_memory_region()
 perform checks and initialization
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


--T3/vOasYOEcRCfmZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 18, 2018 at 04:25:35PM +0200, David Hildenbrand wrote:
> We might get a call to get_memory_region() before the device has been
> realized. We should return a consistent value, as the return value
> will e.g. later on be used in the pre_plug handler.
>=20
> To avoid duplicating too much code, factor the initialization and checks
> out into a helper function.
>=20
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/mem/nvdimm.c | 46 +++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 37 insertions(+), 9 deletions(-)
>=20
> diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
> index db7d8c3050..bba98e57e1 100644
> --- a/hw/mem/nvdimm.c
> +++ b/hw/mem/nvdimm.c
> @@ -71,20 +71,24 @@ static void nvdimm_init(Object *obj)
>                          NULL, NULL);
>  }
> =20
> -static MemoryRegion *nvdimm_get_memory_region(PCDIMMDevice *dimm, Error =
**errp)
> +static void nvdimm_prepare_memory_region(NVDIMMDevice *nvdimm, Error **e=
rrp)
>  {
> -    NVDIMMDevice *nvdimm =3D NVDIMM(dimm);
> +    PCDIMMDevice *dimm =3D PC_DIMM(nvdimm);
> +    uint64_t align, pmem_size, size;
> +    MemoryRegion *mr;
> =20
> -    return nvdimm->nvdimm_mr;
> -}
> +    if (nvdimm->nvdimm_mr) {
> +        return;
> +    }
> =20
> -static void nvdimm_realize(PCDIMMDevice *dimm, Error **errp)
> -{
> -    MemoryRegion *mr =3D host_memory_backend_get_memory(dimm->hostmem);
> -    NVDIMMDevice *nvdimm =3D NVDIMM(dimm);
> -    uint64_t align, pmem_size, size =3D memory_region_size(mr);
> +    if (!dimm->hostmem) {
> +        error_setg(errp, "'" PC_DIMM_MEMDEV_PROP "' property must be set=
");
> +        return;
> +    }
> =20
> +    mr =3D host_memory_backend_get_memory(dimm->hostmem);
>      align =3D memory_region_get_alignment(mr);
> +    size =3D memory_region_size(mr);
> =20
>      pmem_size =3D size - nvdimm->label_size;
>      nvdimm->label_data =3D memory_region_get_ram_ptr(mr) + pmem_size;
> @@ -108,6 +112,30 @@ static void nvdimm_realize(PCDIMMDevice *dimm, Error=
 **errp)
>      nvdimm->nvdimm_mr->align =3D align;
>  }
> =20
> +static MemoryRegion *nvdimm_get_memory_region(PCDIMMDevice *dimm, Error =
**errp)
> +{
> +    NVDIMMDevice *nvdimm =3D NVDIMM(dimm);
> +    Error *local_err =3D NULL;
> +
> +    if (!nvdimm->nvdimm_mr) {

nvdimm_prepare..() already checks this internally, so you could just
call it internally.  Nonetheless

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> +        nvdimm_prepare_memory_region(nvdimm, &local_err);
> +        if (local_err) {
> +            error_propagate(errp, local_err);
> +            return NULL;
> +        }
> +    }
> +    return nvdimm->nvdimm_mr;
> +}
> +
> +static void nvdimm_realize(PCDIMMDevice *dimm, Error **errp)
> +{
> +    NVDIMMDevice *nvdimm =3D NVDIMM(dimm);
> +
> +    if (!nvdimm->nvdimm_mr) {
> +        nvdimm_prepare_memory_region(nvdimm, errp);
> +    }
> +}
> +
>  /*
>   * the caller should check the input parameters before calling
>   * label read/write functions.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--T3/vOasYOEcRCfmZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsoSlMACgkQbDjKyiDZ
s5KSIg/5Ac1ISmYj9LIA/KnCEaXuI03yDzOZNfQir3aVwkPXZSHJjXRf1DEBBNYj
ZrNrXE0ghujXh554g9t0tCy+iWEwh2wxHWcFvzShVphVQN05iAwbZ1epJofPV6X9
4fK1enAW6GtQx3lpeFI8859JDbqY7MjyMgoO+xQ09kwZpdecn6L2BDwDhdxSpmaY
d+sPqPt4ffsnpqlof7uAcA/QEvmcps8QzIJ9QdP/B48TymgQUC+U7IfozeRABFR2
2ixigDzvmyDVeL8pkkztoW1r+0UgtpVn+Ov5/miDcJphYAImFlUFWw7eUhQdZCDa
HoGbhgx5VGaxV3d9Xxi9G7Zc4Z5CwKwISxQdX6eThN9zagqDW+CRV/W4BLjGN+Bm
XtGVpmnjF3UkZK+fXWUD6cG5A9nOIPAU4gHgBpq2ks7emYfYYXpN7U9M7TZqyJaw
U+/BurMz+bn6SWNHesVeWxxBgcghhKDPNYE93nY36Zv9PiMce8jGSOQRb6I+uJYW
ccGO4W59zja6Jr/oVmFYBhEReMdt9XDn4RMKd1Cgmi9jT+DXMZA9rbB2NsZ4H28g
qbEW97fRlKB283tYaIPv9d5aMjFMbuk52TqkxxH+s4hKB3rd/fCDpcPz80gDDZOU
ZuBkFzBtVzbt/3l/4B+rl5RQEOBwXwCDvDt0sCfhnIjXP8dUfl0=
=+cOd
-----END PGP SIGNATURE-----

--T3/vOasYOEcRCfmZ--
