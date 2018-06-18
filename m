Received: from eggs.gnu.org ([2001:4830:134:3::10]:57910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUiPf-0002fT-0K
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 20:52:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUiPe-0001aq-2M
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 20:52:55 -0400
Date: Mon, 18 Jun 2018 10:48:18 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180618004818.GG25461@umbus.fritz.box>
References: <20180615140448.32234-1-david@redhat.com>
	<20180615140448.32234-10-david@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Sw7tCqrGA+HQ0/zt"
Content-Disposition: inline
In-Reply-To: <20180615140448.32234-10-david@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 09/13] nvdimm: convert "unarmed" into a
 static property
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


--Sw7tCqrGA+HQ0/zt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 15, 2018 at 04:04:44PM +0200, David Hildenbrand wrote:
> We don't allow to modify it after realization. So we can simply turn
> it into a static property.
>=20
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/mem/nvdimm.c | 32 +++++++-------------------------
>  1 file changed, 7 insertions(+), 25 deletions(-)
>=20
> diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
> index df9716231f..7260c9c6b1 100644
> --- a/hw/mem/nvdimm.c
> +++ b/hw/mem/nvdimm.c
> @@ -64,36 +64,11 @@ out:
>      error_propagate(errp, local_err);
>  }
> =20
> -static bool nvdimm_get_unarmed(Object *obj, Error **errp)
> -{
> -    NVDIMMDevice *nvdimm =3D NVDIMM(obj);
> -
> -    return nvdimm->unarmed;
> -}
> -
> -static void nvdimm_set_unarmed(Object *obj, bool value, Error **errp)
> -{
> -    NVDIMMDevice *nvdimm =3D NVDIMM(obj);
> -    Error *local_err =3D NULL;
> -
> -    if (memory_region_size(&nvdimm->nvdimm_mr)) {
> -        error_setg(&local_err, "cannot change property value");
> -        goto out;
> -    }
> -
> -    nvdimm->unarmed =3D value;
> -
> - out:
> -    error_propagate(errp, local_err);
> -}
> -
>  static void nvdimm_init(Object *obj)
>  {
>      object_property_add(obj, NVDIMM_LABEL_SIZE_PROP, "int",
>                          nvdimm_get_label_size, nvdimm_set_label_size, NU=
LL,
>                          NULL, NULL);
> -    object_property_add_bool(obj, NVDIMM_UNARMED_PROP,
> -                             nvdimm_get_unarmed, nvdimm_set_unarmed, NUL=
L);
>  }
> =20
>  static MemoryRegion *nvdimm_get_memory_region(PCDIMMDevice *dimm, Error =
**errp)
> @@ -166,13 +141,20 @@ static void nvdimm_write_label_data(NVDIMMDevice *n=
vdimm, const void *buf,
>      memory_region_set_dirty(mr, backend_offset, size);
>  }
> =20
> +static Property nvdimm_properties[] =3D {
> +    DEFINE_PROP_BOOL(NVDIMM_UNARMED_PROP, NVDIMMDevice, unarmed, false),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
>  static void nvdimm_class_init(ObjectClass *oc, void *data)
>  {
>      PCDIMMDeviceClass *ddc =3D PC_DIMM_CLASS(oc);
>      NVDIMMClass *nvc =3D NVDIMM_CLASS(oc);
> +    DeviceClass *dc =3D DEVICE_CLASS(oc);
> =20
>      ddc->realize =3D nvdimm_realize;
>      ddc->get_memory_region =3D nvdimm_get_memory_region;
> +    dc->props =3D nvdimm_properties;
> =20
>      nvc->read_label_data =3D nvdimm_read_label_data;
>      nvc->write_label_data =3D nvdimm_write_label_data;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Sw7tCqrGA+HQ0/zt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsnAVEACgkQbDjKyiDZ
s5KjlxAAsLBefCHlYZW5o4QUicsOnfwnbMQg2Gq7TattwBpd9Pe5BoC6Gg+a+uVD
EfhZRCe/2KdXneJRYw/ZFJ/iIMy2jZQC2sKm+je4M+JAtzdKI08CjBytxyBLq43+
VYNW5MOP/tBiOOaK83g5sWQ7IY29owM1kwcewY34XhspZz37Z3WQ6VxGmcx+AFsG
fdZIlz+LomYs/OAjMEB424/2g414l3uRE1F0axIZdO+hve75NXMtRR8+dFtrWCn4
HyEgnCfDwWpRj9bKskK2vi1nGg9e3tg8frEG6aPL7T3yBlEtuDvceRUY0O1CAqjt
rB0/FE9WwNxkAfNMx2LqlVN3DT5fa0+QU4iUMCH2+crjk6mydghakEEBU+BfL55c
LlvuvaXm2Q4EtZColJTg+Vwx0u6a/gNmlntZpfbaEN10TpaDLCxcxZKYASoa+Yrn
u4u7DmGuG/a4PP7/C2suRlRIJbWApyguwSo1UvXZdyzPWKYllk7roOEBQ92D6yAt
O4CIoOwSFD44lpQXazh66bpS3TR0FHw6VfU2hh/NTmvXttZ8RyP6H96bgz8KnsnX
pk+5dbzS4zYqslzOLpxLe+m1IF17z12G/FCnhHfC6B2sfL2rwpmoRTE0GPGl1wea
Qvj2zKKBHpfCqSdOhu/qdj7X6mbqL1n3xqt4ePFqQmTCgaXT0i0=
=AW7Z
-----END PGP SIGNATURE-----

--Sw7tCqrGA+HQ0/zt--
