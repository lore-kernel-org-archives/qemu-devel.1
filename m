Received: from eggs.gnu.org ([2001:4830:134:3::10]:57954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUiPi-0002gE-Fz
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 20:52:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUiPh-0001dn-Er
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 20:52:58 -0400
Date: Mon, 18 Jun 2018 10:49:50 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180618004950.GH25461@umbus.fritz.box>
References: <20180615140448.32234-1-david@redhat.com>
	<20180615140448.32234-11-david@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Uu2n37VG4rOBDVuR"
Content-Disposition: inline
In-Reply-To: <20180615140448.32234-11-david@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 10/13] nvdimm: convert nvdimm_mr into a
 pointer
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


--Uu2n37VG4rOBDVuR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 15, 2018 at 04:04:45PM +0200, David Hildenbrand wrote:
> This way we can easily check if the region has already been inititalized
> without having to rely on the size of an uninitialized region being 0.
>=20
> Signed-off-by: David Hildenbrand <david@redhat.com>

I'm not terribly convinced that this is a worthwhile change, but in
the sense that the patch appears to be technically correct:

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/mem/nvdimm.c         | 9 +++++----
>  include/hw/mem/nvdimm.h | 2 +-
>  2 files changed, 6 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
> index 7260c9c6b1..db7d8c3050 100644
> --- a/hw/mem/nvdimm.c
> +++ b/hw/mem/nvdimm.c
> @@ -43,7 +43,7 @@ static void nvdimm_set_label_size(Object *obj, Visitor =
*v, const char *name,
>      Error *local_err =3D NULL;
>      uint64_t value;
> =20
> -    if (memory_region_size(&nvdimm->nvdimm_mr)) {
> +    if (nvdimm->nvdimm_mr) {
>          error_setg(&local_err, "cannot change property value");
>          goto out;
>      }
> @@ -75,7 +75,7 @@ static MemoryRegion *nvdimm_get_memory_region(PCDIMMDev=
ice *dimm, Error **errp)
>  {
>      NVDIMMDevice *nvdimm =3D NVDIMM(dimm);
> =20
> -    return &nvdimm->nvdimm_mr;
> +    return nvdimm->nvdimm_mr;
>  }
> =20
>  static void nvdimm_realize(PCDIMMDevice *dimm, Error **errp)
> @@ -102,9 +102,10 @@ static void nvdimm_realize(PCDIMMDevice *dimm, Error=
 **errp)
>          return;
>      }
> =20
> -    memory_region_init_alias(&nvdimm->nvdimm_mr, OBJECT(dimm),
> +    nvdimm->nvdimm_mr =3D g_new(MemoryRegion, 1);
> +    memory_region_init_alias(nvdimm->nvdimm_mr, OBJECT(dimm),
>                               "nvdimm-memory", mr, 0, pmem_size);
> -    nvdimm->nvdimm_mr.align =3D align;
> +    nvdimm->nvdimm_mr->align =3D align;
>  }
> =20
>  /*
> diff --git a/include/hw/mem/nvdimm.h b/include/hw/mem/nvdimm.h
> index 9340631cfc..c5c9b3c7f8 100644
> --- a/include/hw/mem/nvdimm.h
> +++ b/include/hw/mem/nvdimm.h
> @@ -74,7 +74,7 @@ struct NVDIMMDevice {
>       * it's the PMEM region in NVDIMM device, which is presented to
>       * guest via ACPI NFIT and _FIT method if NVDIMM hotplug is supporte=
d.
>       */
> -    MemoryRegion nvdimm_mr;
> +    MemoryRegion *nvdimm_mr;
> =20
>      /*
>       * The 'on' value results in the unarmed flag set in ACPI NFIT,

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Uu2n37VG4rOBDVuR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsnAa4ACgkQbDjKyiDZ
s5JoKRAAwwR/tUOijmfNl/lDkjxdewlSQUkVV8t8Kp+NLeXqv/nTaUCudsLOTZv4
+vgsE4mpFmRWIIqrAWOohHS3c4Nd+mCODruGZkkWZMvPHTEBJF2J/7TTeOlvIwre
sYimhT/QxItvaNt9FLnepY31xXRMOW8k27SpKxc9CVtNEhmpu96iSu/8HJ8p/b9r
5q2N4adKyehA6P/9Fzzh4cRT5d/qR0aEjdTOW+txUxqItnwI9OIFbqsxkHDuiMK2
A/w5A6UTbd8QlcrM69j4N3bVNzNOMJ8UmrgJWjeMIQYmyOc/NshrjpCUecQQSjRL
Vk4ESWRKoE7qAwuGH1eFn8jDUs4zTiREEMXAidqqVcdgG9FwyBUbLmXlFbW9Y58f
iAI2aOwu3lGDzx7WvRDzJAFdTz+6pfS+n5aN2BhvlrHX76yR4qYVRjst8AXnu5xI
iN5kRGxztEKYNuzsHTelFsm/Dyj/kzxSzyqCSbkPr28RnatCCPeSQH5l6KooI0E6
ay00udN6C1+xVdq9WWGJTkg0oZ/Gppgr+Iih9j4XPnmIOf/btANtIDkTCFjkePgI
ypgS/3myiLnFwpSuptKhxNcLd+6QhS08MFzjI1CQOvhy3YWT44+xs87/YA0x4n3t
0otLZRLr5Pvn2qUmtYU9kgA34yuA0KVIYovQQ2cxIwQNiYDfjJg=
=RDU9
-----END PGP SIGNATURE-----

--Uu2n37VG4rOBDVuR--
