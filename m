Received: from eggs.gnu.org ([2001:4830:134:3::10]:57957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUiPi-0002gH-H9
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 20:52:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUiPe-0001an-1t
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 20:52:58 -0400
Date: Mon, 18 Jun 2018 10:46:41 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180618004641.GF25461@umbus.fritz.box>
References: <20180615140448.32234-1-david@redhat.com>
	<20180615140448.32234-9-david@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SnV5plBeK2Ge1I9g"
Content-Disposition: inline
In-Reply-To: <20180615140448.32234-9-david@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 08/13] pc-dimm: merge
 get_(vmstate_)memory_region()
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


--SnV5plBeK2Ge1I9g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 15, 2018 at 04:04:43PM +0200, David Hildenbrand wrote:
> Importantly, get_vmstate_memory_region() should also fail with a proper
> error if called before the device is realized. For a PCDIMM, both functio=
ns
> are to return the same thing, so share the implementation.
>=20
> All current users are called after the device has been realized, so we
> can expect the calls to succeed.
>=20
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/mem/pc-dimm.c         | 13 +++++--------
>  include/hw/mem/pc-dimm.h |  3 ++-
>  2 files changed, 7 insertions(+), 9 deletions(-)
>=20
> diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
> index 73f0eee4c7..4ff39b59ef 100644
> --- a/hw/mem/pc-dimm.c
> +++ b/hw/mem/pc-dimm.c
> @@ -35,7 +35,8 @@ void pc_dimm_plug(DeviceState *dev, MachineState *machi=
ne, uint64_t align,
>      int slot;
>      PCDIMMDevice *dimm =3D PC_DIMM(dev);
>      PCDIMMDeviceClass *ddc =3D PC_DIMM_GET_CLASS(dimm);
> -    MemoryRegion *vmstate_mr =3D ddc->get_vmstate_memory_region(dimm);
> +    MemoryRegion *vmstate_mr =3D ddc->get_vmstate_memory_region(dimm,
> +                                                              &error_abo=
rt);
>      Error *local_err =3D NULL;
>      MemoryRegion *mr;
>      uint64_t addr;
> @@ -90,7 +91,8 @@ void pc_dimm_unplug(DeviceState *dev, MachineState *mac=
hine)
>  {
>      PCDIMMDevice *dimm =3D PC_DIMM(dev);
>      PCDIMMDeviceClass *ddc =3D PC_DIMM_GET_CLASS(dimm);
> -    MemoryRegion *vmstate_mr =3D ddc->get_vmstate_memory_region(dimm);
> +    MemoryRegion *vmstate_mr =3D ddc->get_vmstate_memory_region(dimm,
> +                                                              &error_abo=
rt);
>      MemoryRegion *mr =3D ddc->get_memory_region(dimm, &error_abort);
> =20
>      memory_device_unplug_region(machine, mr);
> @@ -229,11 +231,6 @@ static MemoryRegion *pc_dimm_get_memory_region(PCDIM=
MDevice *dimm, Error **errp)
>      return host_memory_backend_get_memory(dimm->hostmem);
>  }
> =20
> -static MemoryRegion *pc_dimm_get_vmstate_memory_region(PCDIMMDevice *dim=
m)
> -{
> -    return host_memory_backend_get_memory(dimm->hostmem);
> -}
> -
>  static uint64_t pc_dimm_md_get_addr(const MemoryDeviceState *md)
>  {
>      const PCDIMMDevice *dimm =3D PC_DIMM(md);
> @@ -298,7 +295,7 @@ static void pc_dimm_class_init(ObjectClass *oc, void =
*data)
>      dc->desc =3D "DIMM memory module";
> =20
>      ddc->get_memory_region =3D pc_dimm_get_memory_region;
> -    ddc->get_vmstate_memory_region =3D pc_dimm_get_vmstate_memory_region;
> +    ddc->get_vmstate_memory_region =3D pc_dimm_get_memory_region;
> =20
>      mdc->get_addr =3D pc_dimm_md_get_addr;
>      /* for a dimm plugged_size =3D=3D region_size */
> diff --git a/include/hw/mem/pc-dimm.h b/include/hw/mem/pc-dimm.h
> index cf71247630..5679a80465 100644
> --- a/include/hw/mem/pc-dimm.h
> +++ b/include/hw/mem/pc-dimm.h
> @@ -73,7 +73,8 @@ typedef struct PCDIMMDeviceClass {
>      /* public */
>      void (*realize)(PCDIMMDevice *dimm, Error **errp);
>      MemoryRegion *(*get_memory_region)(PCDIMMDevice *dimm, Error **errp);
> -    MemoryRegion *(*get_vmstate_memory_region)(PCDIMMDevice *dimm);
> +    MemoryRegion *(*get_vmstate_memory_region)(PCDIMMDevice *dimm,
> +                                               Error **errp);
>  } PCDIMMDeviceClass;
> =20
>  void pc_dimm_plug(DeviceState *dev, MachineState *machine, uint64_t alig=
n,

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--SnV5plBeK2Ge1I9g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsnAPEACgkQbDjKyiDZ
s5KISBAA446LjHslBXIleavNpOddylQwVQoLVIXnheiiXIg6kXnnUEYPulYhf51o
sro6rS+VL8XVrLRiN5OsX/QEXjPlGUt28cIL0TAKBO9jgwuB7o1jFqyYEmpKM/ZI
FixWNVyzFheWhrjX1MdzY/0HmQt/c/LYKAb0/MPKhyr4O0ogdvl1Q8aDYydao81+
iLRDGSvi4R5Ohga+Mm3z/khl7weXhP7QNVPWizJg3Hp47Tfdghpb1KGjiNXoL8hV
GA5RpTxAsFmqY3ue4wB/IMO8FwCIiBHH2luFxO4Ydw6oYz3kDD9cxRMN3ceETp89
VWydvV6FD4AT/DijSBDLbiIglU3BzbnpVTzZ1GvKNqY4yyeLeH6cPdkZSAeM1KBS
g4Z3z6iZTjbcjH27CKRhArCd4WomLTj32lDXRSPZ8ffbWfrL6VwgrMkxYMJ/f4Ad
1OfchIkxilicQV6x1S+YXAPrKcyavzTrQ3lSK7ZI5wBh3DqYYbuf3qu959HhIRA5
G7segxz1I12Ko0BKz16IlkD0hvmf8HTW7HMmkq5Y+XgKl337bX49u4UUlJBXt7Dh
7fisOIFrsCFRxNZw/GRPw0HSgDWLWlLuBU3OqgrU+lFMExyPlmvMQbvzfeuwTHmW
nX9C9EbJygKcHI0lVo1ziDQgeRfwlEEkcUOEdsz16Ugfdjtjlgg=
=88LF
-----END PGP SIGNATURE-----

--SnV5plBeK2Ge1I9g--
