Received: from eggs.gnu.org ([2001:4830:134:3::10]:39619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dDBk1-0004i4-VU
	for qemu-devel@nongnu.org; Tue, 23 May 2017 11:28:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dDBjx-0003I7-2P
	for qemu-devel@nongnu.org; Tue, 23 May 2017 11:28:57 -0400
Received: from 17.mo5.mail-out.ovh.net ([46.105.56.132]:35535)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dDBjw-0003Ho-SL
	for qemu-devel@nongnu.org; Tue, 23 May 2017 11:28:52 -0400
Received: from player786.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 07BD9F74E4
	for <qemu-devel@nongnu.org>; Tue, 23 May 2017 17:28:51 +0200 (CEST)
Date: Tue, 23 May 2017 17:28:42 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170523172842.1fce414e@bahia.ttt.fr.ibm.com>
In-Reply-To: <20170523111812.13469-2-lvivier@redhat.com>
References: <20170523111812.13469-1-lvivier@redhat.com>
	<20170523111812.13469-2-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/i.dTFuL+YAGoZtSzlg2H/Lg";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 1/4] spapr: add pre_plug
 function for memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

--Sig_/i.dTFuL+YAGoZtSzlg2H/Lg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 23 May 2017 13:18:09 +0200
Laurent Vivier <lvivier@redhat.com> wrote:

> This allows to manage errors before the memory
> has started to be hotplugged. We already have
> the function for the CPU cores.
>=20
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>  hw/ppc/spapr.c | 45 ++++++++++++++++++++++++++++++---------------
>  1 file changed, 30 insertions(+), 15 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 0980d73..0e8d8d1 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2569,20 +2569,6 @@ static void spapr_memory_plug(HotplugHandler *hotp=
lug_dev, DeviceState *dev,
>      uint64_t align =3D memory_region_get_alignment(mr);
>      uint64_t size =3D memory_region_size(mr);
>      uint64_t addr;
> -    char *mem_dev;
> -
> -    if (size % SPAPR_MEMORY_BLOCK_SIZE) {
> -        error_setg(&local_err, "Hotplugged memory size must be a multipl=
e of "
> -                      "%lld MB", SPAPR_MEMORY_BLOCK_SIZE/M_BYTE);
> -        goto out;
> -    }
> -
> -    mem_dev =3D object_property_get_str(OBJECT(dimm), PC_DIMM_MEMDEV_PRO=
P, NULL);
> -    if (mem_dev && !kvmppc_is_mem_backend_page_size_ok(mem_dev)) {
> -        error_setg(&local_err, "Memory backend has bad page size. "
> -                   "Use 'memory-backend-file' with correct mem-path.");
> -        goto out;
> -    }
> =20
>      pc_dimm_memory_plug(dev, &ms->hotplug_memory, mr, align, &local_err);
>      if (local_err) {
> @@ -2603,6 +2589,33 @@ out:
>      error_propagate(errp, local_err);
>  }
> =20
> +static void spapr_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceSta=
te *dev,
> +                                Error **errp)

Indentation nit

> +{
> +    PCDIMMDevice *dimm =3D PC_DIMM(dev);
> +    PCDIMMDeviceClass *ddc =3D PC_DIMM_GET_CLASS(dimm);
> +    MemoryRegion *mr =3D ddc->get_memory_region(dimm);
> +    uint64_t size =3D memory_region_size(mr);
> +    Error *local_err =3D NULL;
> +    char *mem_dev;
> +
> +    if (size % SPAPR_MEMORY_BLOCK_SIZE) {
> +        error_setg(&local_err, "Hotplugged memory size must be a multipl=
e of "
> +                      "%lld MB", SPAPR_MEMORY_BLOCK_SIZE / M_BYTE);
> +        goto out;
> +    }
> +
> +    mem_dev =3D object_property_get_str(OBJECT(dimm), PC_DIMM_MEMDEV_PRO=
P, NULL);
> +    if (mem_dev && !kvmppc_is_mem_backend_page_size_ok(mem_dev)) {
> +        error_setg(&local_err, "Memory backend has bad page size. "
> +                   "Use 'memory-backend-file' with correct mem-path.");
> +        goto out;
> +    }
> +
> +out:
> +    error_propagate(errp, local_err);

As recently discussed with Markus Armbruster, it isn't necessary to have a
local Error * if you don't do anything else with it but propagate it.

Message-ID: <20170522090055.GN30246@umbus.fritz.box>

The patch looks good anyway.

Reviewed-by: Greg Kurz <groug@kaod.org>

> +}
> +
>  typedef struct sPAPRDIMMState {
>      uint32_t nr_lmbs;
>  } sPAPRDIMMState;
> @@ -2990,7 +3003,9 @@ static void spapr_machine_device_unplug_request(Hot=
plugHandler *hotplug_dev,
>  static void spapr_machine_device_pre_plug(HotplugHandler *hotplug_dev,
>                                            DeviceState *dev, Error **errp)
>  {
> -    if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_CORE)) {
> +    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
> +        spapr_memory_pre_plug(hotplug_dev, dev, errp);
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_CORE)) {
>          spapr_core_pre_plug(hotplug_dev, dev, errp);
>      }
>  }


--Sig_/i.dTFuL+YAGoZtSzlg2H/Lg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlkkVSoACgkQAvw66wEB28JlSACfcfDx++3n6OakimV4Qc/Uq9Bh
jq0AniTPhjiisKqBP/yqbMxGi3OKpglN
=TunC
-----END PGP SIGNATURE-----

--Sig_/i.dTFuL+YAGoZtSzlg2H/Lg--
