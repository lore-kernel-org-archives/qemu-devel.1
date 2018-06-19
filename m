Received: from eggs.gnu.org ([2001:4830:134:3::10]:34202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fV4Va-0000Bd-U4
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 20:28:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fV4VZ-0007Tv-JK
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 20:28:30 -0400
Date: Tue, 19 Jun 2018 10:14:35 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180619001435.GH25461@umbus.fritz.box>
References: <20180618144800.555-1-david@redhat.com>
	<20180618144800.555-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6QRm19z+IuqknR2w"
Content-Disposition: inline
In-Reply-To: <20180618144800.555-2-david@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 1/4] pc-dimm: assign and verify the
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
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>


--6QRm19z+IuqknR2w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 18, 2018 at 04:47:57PM +0200, David Hildenbrand wrote:
> We can assign and verify the slot before realizing and trying to plug.
> reading/writing the slot property should never fail, so let's reduce
> error handling a bit by using &error_abort.
>=20
> To do this during pre_plug, add and use (x86, ppc) pc_dimm_pre_plug().
>=20
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

and ppc portion

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/i386/pc.c             |  2 ++
>  hw/mem/pc-dimm.c         | 35 ++++++++++++++++++-----------------
>  hw/ppc/spapr.c           |  1 +
>  include/hw/mem/pc-dimm.h |  1 +
>  4 files changed, 22 insertions(+), 17 deletions(-)
>=20
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index f310040351..bf986baf91 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1695,6 +1695,8 @@ static void pc_memory_pre_plug(HotplugHandler *hotp=
lug_dev, DeviceState *dev,
>          error_setg(errp, "nvdimm is not enabled: missing 'nvdimm' in '-M=
'");
>          return;
>      }
> +
> +    pc_dimm_pre_plug(dev, MACHINE(hotplug_dev), errp);
>  }
> =20
>  static void pc_memory_plug(HotplugHandler *hotplug_dev,
> diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
> index 65843bc52a..e56c4daef2 100644
> --- a/hw/mem/pc-dimm.c
> +++ b/hw/mem/pc-dimm.c
> @@ -29,10 +29,27 @@
> =20
>  static int pc_dimm_get_free_slot(const int *hint, int max_slots, Error *=
*errp);
> =20
> +void pc_dimm_pre_plug(DeviceState *dev, MachineState *machine, Error **e=
rrp)
> +{
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
> +}
> +
>  void pc_dimm_plug(DeviceState *dev, MachineState *machine, uint64_t alig=
n,
>                    Error **errp)
>  {
> -    int slot;
>      PCDIMMDevice *dimm =3D PC_DIMM(dev);
>      PCDIMMDeviceClass *ddc =3D PC_DIMM_GET_CLASS(dimm);
>      MemoryRegion *vmstate_mr =3D ddc->get_vmstate_memory_region(dimm,
> @@ -59,22 +76,6 @@ void pc_dimm_plug(DeviceState *dev, MachineState *mach=
ine, uint64_t align,
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
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 6934abc21e..9da233588b 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3211,6 +3211,7 @@ static void spapr_memory_pre_plug(HotplugHandler *h=
otplug_dev, DeviceState *dev,
>          goto out;
>      }
> =20
> +    pc_dimm_pre_plug(dev, MACHINE(hotplug_dev), errp);
>  out:
>      g_free(mem_dev);
>  }
> diff --git a/include/hw/mem/pc-dimm.h b/include/hw/mem/pc-dimm.h
> index 26ebb7d5e9..7b120416d1 100644
> --- a/include/hw/mem/pc-dimm.h
> +++ b/include/hw/mem/pc-dimm.h
> @@ -79,6 +79,7 @@ typedef struct PCDIMMDeviceClass {
>                                                 Error **errp);
>  } PCDIMMDeviceClass;
> =20
> +void pc_dimm_pre_plug(DeviceState *dev, MachineState *machine, Error **e=
rrp);
>  void pc_dimm_plug(DeviceState *dev, MachineState *machine, uint64_t alig=
n,
>                    Error **errp);
>  void pc_dimm_unplug(DeviceState *dev, MachineState *machine);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--6QRm19z+IuqknR2w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsoSuoACgkQbDjKyiDZ
s5L6YhAAiZzlrE5NaCeUR5dzXJPmIDwlX/0XI2PF4/mhS7nBG40z2LPxU5TQnVMa
673JShdgLWo73XqzMyRDikMcZJsU/eiGeAFmDndepFahGZT5ZfB77sN0/2DzZVjv
nfqx1gxUIYmn9BSIPoq/uWyxha1DoW6BRDnV6R/W6pHW+KR+s4yd+TZpjD3oFZBd
qr+mvVBJbUhwr8Lh81QxpkVKgoI0c6Tr/AzPaikFFtWvU2245cQ5anALAYB01pVS
lFVPCYXIPu7tjzVcgGp8upLpGUtnHzJgciOzxNocjgK4NLUOc3WYwefAAiRo+Qjo
tHSlsNAxg/LeWzURfYoxzMIvxXbONC0psSzqYgN7Dtt4bqOvIfRLVoRrjKdOMHn9
9ayZQwLWcfix3DZeYjhq4M82akG2jw6ieUBuPsqbBCjnfOAqfO1hkQ7WwFji6rey
rwkhRHGeNpmQ1s6SWnkBhCT2t3+Zzjis93ltNTmem7Dci54TmntLUsAVqcurWke+
5hTMnj3cPfjQEPqUQlauhEjXro8axu/YWPjPObWwRbUZZPUfpPX3gpywo+ggFxm4
dJpFqxqkbe+1wPdIgX2P3ocEMXLr+KDdZt1JtwUEL6sxxtdNiBUx/p/iJWzVJg5v
Dwn2r6Ru+Vt3JAv94YUmUTlKq7Zh+pRoONRjPZn2Yfbf39qBJP8=
=c8gu
-----END PGP SIGNATURE-----

--6QRm19z+IuqknR2w--
