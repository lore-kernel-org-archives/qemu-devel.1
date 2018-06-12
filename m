Received: from eggs.gnu.org ([2001:4830:134:3::10]:47104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSZ1T-0000WW-16
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 22:27:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSZ1O-0000Jw-LZ
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 22:27:03 -0400
Date: Tue, 12 Jun 2018 12:02:10 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180612020210.GT2737@umbus.fritz.box>
References: <20180611121655.19616-1-david@redhat.com>
	<20180611121655.19616-12-david@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vru7fAags9pVPvn5"
Content-Disposition: inline
In-Reply-To: <20180611121655.19616-12-david@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 11/11] pc-dimm: assign and verify the
 "slot" property during pre_plug
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


--vru7fAags9pVPvn5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 11, 2018 at 02:16:55PM +0200, David Hildenbrand wrote:
> We can assign and verify the slot before realizing and trying to plug.
> reading/writing the slot property should never change, so let's reduce
> error handling a bit by using &error_abort.
>=20
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/mem/pc-dimm.c | 31 ++++++++++++++-----------------
>  1 file changed, 14 insertions(+), 17 deletions(-)
>=20
> diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
> index 995ce22d8d..88423f95a3 100644
> --- a/hw/mem/pc-dimm.c
> +++ b/hw/mem/pc-dimm.c
> @@ -30,12 +30,25 @@
>  void pc_dimm_memory_pre_plug(DeviceState *dev, MachineState *machine,
>                               Error **errp)
>  {
> +    Error *local_err =3D NULL;
> +    int slot;
> +
> +    slot =3D object_property_get_int(OBJECT(dev), PC_DIMM_SLOT_PROP,
> +                                   &error_abort);
> +    slot =3D pc_dimm_get_free_slot(slot =3D=3D PC_DIMM_UNASSIGNED_SLOT ?=
 NULL : &slot,
> +                                 machine->ram_slots, &local_err);
> +    if (local_err) {
> +        goto out;
> +    }
> +    object_property_set_int(OBJECT(dev), slot, PC_DIMM_SLOT_PROP, &error=
_abort);
> +    trace_mhp_pc_dimm_assigned_slot(slot);
> +out:
> +    error_propagate(errp, local_err);
>  }
> =20
>  void pc_dimm_memory_plug(DeviceState *dev, MachineState *machine,
>                           uint64_t align, Error **errp)
>  {
> -    int slot;
>      PCDIMMDevice *dimm =3D PC_DIMM(dev);
>      PCDIMMDeviceClass *ddc =3D PC_DIMM_GET_CLASS(dimm);
>      MemoryRegion *vmstate_mr =3D ddc->get_vmstate_memory_region(dimm);
> @@ -61,22 +74,6 @@ void pc_dimm_memory_plug(DeviceState *dev, MachineStat=
e *machine,
>      }
>      trace_mhp_pc_dimm_assigned_address(addr);
> =20
> -    slot =3D object_property_get_int(OBJECT(dev), PC_DIMM_SLOT_PROP, &lo=
cal_err);
> -    if (local_err) {
> -        goto out;
> -    }
> -
> -    slot =3D pc_dimm_get_free_slot(slot =3D=3D PC_DIMM_UNASSIGNED_SLOT ?=
 NULL : &slot,
> -                                 machine->ram_slots, &local_err);
> -    if (local_err) {
> -        goto out;
> -    }
> -    object_property_set_int(OBJECT(dev), slot, PC_DIMM_SLOT_PROP, &local=
_err);
> -    if (local_err) {
> -        goto out;
> -    }
> -    trace_mhp_pc_dimm_assigned_slot(slot);
> -
>      memory_device_plug_region(machine, mr, addr);
>      vmstate_register_ram(vmstate_mr, dev);
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--vru7fAags9pVPvn5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsfKZwACgkQbDjKyiDZ
s5K4Sg/9ENbFp0unIimedpeJscS8VWQI4+nyliF8yShyscJrpWmGGj1MUBMHqfC1
MqeYtxbBhwEUDnZKGq0KjJ0/NIw5unlGJ46X8BCBT6VFzEQnRQlGJ66u2gXokKB3
XZm8G3Qd5IqgseLrDZOFVCO7kam4QrTuTRFEfn3myrmckr5EYUPeYdh/ycHQ+yY+
NqLy5x2Uq+8jYNyN40ktc55xZCvCAcIyS2PV2ufavpbKF0bR1sHkAzK7pXuwkuoM
ZAocnc7yjOxKx6tbqgzP6B2F6xso8Bl/RckA0nAo/eItRd54X/NCkNG9nmCXZ/k1
1SgyhI4ldZtsMKK6Sm/CozfyggtPg6waNlae/e2gbfAk2aOWGkSCmcCQBFMVv9pw
nH3DBYHW1etNRsQLnhlkyIh8R723gXQhcf/wLYIVB+e7VDhwOqZpNKncFJk11VNn
7WRWEjCBaAIwCExGWpUGaEObKMeDOgLHfBuEuA3/S6AcnaT889UXKrQWmfzCWa+S
hSPAa7MGIX0lDH5gOX/caLAOXYTSQbhVarAgnivp5cnzLTxBokFT+58jeceFXVu0
yDIawaH5xi9AB4dmP+g9V0KkAbUMulOAlQVn5+Tj1EzkJ/M1/lC6/QKraucv9e8S
9wm8AHjUwi5w30T8M3w+B3seI4ZqV9I5PUEW3zayufBjxIOSK3g=
=O5hN
-----END PGP SIGNATURE-----

--vru7fAags9pVPvn5--
