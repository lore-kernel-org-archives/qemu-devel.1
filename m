Received: from eggs.gnu.org ([2001:4830:134:3::10]:49561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dVEW3-0001Kj-MV
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 06:05:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dVEVy-0004As-Em
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 06:05:07 -0400
Received: from 10.mo68.mail-out.ovh.net ([46.105.79.203]:46947)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dVEVy-0004A4-4z
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 06:05:02 -0400
Received: from player750.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 7C0836C12D
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 12:05:00 +0200 (CEST)
Date: Wed, 12 Jul 2017 12:04:51 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170712120451.198aef60@bahia.lan>
In-Reply-To: <20170712055317.26225-4-david@gibson.dropbear.id.au>
References: <20170712055317.26225-1-david@gibson.dropbear.id.au>
	<20170712055317.26225-4-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/oowY3Ixu1whiOdeRMSLgwdN";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCHv2 3/8] spapr: Simplify unplug path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: mdroth@linux.vnet.ibm.com, danielhb@linux.vnet.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com, sjitindarsingh@gmail.com, bharata@linux.vnet.ibm.com

--Sig_/oowY3Ixu1whiOdeRMSLgwdN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 12 Jul 2017 15:53:12 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> spapr_lmb_release() and spapr_core_release() call hotplug_handler_unplug()
> which after a bunch of indirection calls spapr_memory_unplug() or
> spapr_core_unplug().  But we already know which is the appropriate thing
> to call here, so we can just fold it directly into the release function.
>=20
> Once that's done, there's no need for an hc->unplug method in the spapr
> machine at all: since we also have an hc->unplug_request method, the
> hotplug core will never use ->unplug.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Nice cleanup :)

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr.c | 54 ++++++++--------------------------------------------=
--
>  1 file changed, 8 insertions(+), 46 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 2a059d5..ff2aa6b 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2818,6 +2818,9 @@ void spapr_lmb_release(DeviceState *dev)
>  {
>      HotplugHandler *hotplug_ctrl =3D qdev_get_hotplug_handler(dev);
>      sPAPRMachineState *spapr =3D SPAPR_MACHINE(hotplug_ctrl);
> +    PCDIMMDevice *dimm =3D PC_DIMM(dev);
> +    PCDIMMDeviceClass *ddc =3D PC_DIMM_GET_CLASS(dimm);
> +    MemoryRegion *mr =3D ddc->get_memory_region(dimm);
>      sPAPRDIMMState *ds =3D spapr_pending_dimm_unplugs_find(spapr, PC_DIM=
M(dev));
> =20
>      /* This information will get lost if a migration occurs
> @@ -2838,18 +2841,7 @@ void spapr_lmb_release(DeviceState *dev)
>       * Now that all the LMBs have been removed by the guest, call the
>       * pc-dimm unplug handler to cleanup up the pc-dimm device.
>       */
> -    hotplug_handler_unplug(hotplug_ctrl, dev, &error_abort);
> -}
> -
> -static void spapr_memory_unplug(HotplugHandler *hotplug_dev, DeviceState=
 *dev,
> -                                Error **errp)
> -{
> -    sPAPRMachineState *ms =3D SPAPR_MACHINE(hotplug_dev);
> -    PCDIMMDevice *dimm =3D PC_DIMM(dev);
> -    PCDIMMDeviceClass *ddc =3D PC_DIMM_GET_CLASS(dimm);
> -    MemoryRegion *mr =3D ddc->get_memory_region(dimm);
> -
> -    pc_dimm_memory_unplug(dev, &ms->hotplug_memory, mr);
> +    pc_dimm_memory_unplug(dev, &spapr->hotplug_memory, mr);
>      object_unparent(OBJECT(dev));
>  }
> =20
> @@ -2918,10 +2910,11 @@ static void *spapr_populate_hotplug_cpu_dt(CPUSta=
te *cs, int *fdt_offset,
>      return fdt;
>  }
> =20
> -static void spapr_core_unplug(HotplugHandler *hotplug_dev, DeviceState *=
dev,
> -                              Error **errp)
> +/* Callback to be called during DRC release. */
> +void spapr_core_release(DeviceState *dev)
>  {
> -    MachineState *ms =3D MACHINE(qdev_get_machine());
> +    HotplugHandler *hotplug_ctrl =3D qdev_get_hotplug_handler(dev);
> +    MachineState *ms =3D MACHINE(hotplug_ctrl);
>      sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(ms);
>      CPUCore *cc =3D CPU_CORE(dev);
>      CPUArchId *core_slot =3D spapr_find_cpu_slot(ms, cc->core_id, NULL);
> @@ -2945,15 +2938,6 @@ static void spapr_core_unplug(HotplugHandler *hotp=
lug_dev, DeviceState *dev,
>      object_unparent(OBJECT(dev));
>  }
> =20
> -/* Callback to be called during DRC release. */
> -void spapr_core_release(DeviceState *dev)
> -{
> -    HotplugHandler *hotplug_ctrl;
> -
> -    hotplug_ctrl =3D qdev_get_hotplug_handler(dev);
> -    hotplug_handler_unplug(hotplug_ctrl, dev, &error_abort);
> -}
> -
>  static
>  void spapr_core_unplug_request(HotplugHandler *hotplug_dev, DeviceState =
*dev,
>                                 Error **errp)
> @@ -3159,27 +3143,6 @@ static void spapr_machine_device_plug(HotplugHandl=
er *hotplug_dev,
>      }
>  }
> =20
> -static void spapr_machine_device_unplug(HotplugHandler *hotplug_dev,
> -                                      DeviceState *dev, Error **errp)
> -{
> -    sPAPRMachineState *sms =3D SPAPR_MACHINE(qdev_get_machine());
> -    MachineClass *mc =3D MACHINE_GET_CLASS(qdev_get_machine());
> -
> -    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
> -        if (spapr_ovec_test(sms->ov5_cas, OV5_HP_EVT)) {
> -            spapr_memory_unplug(hotplug_dev, dev, errp);
> -        } else {
> -            error_setg(errp, "Memory hot unplug not supported for this g=
uest");
> -        }
> -    } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_CORE)) {
> -        if (!mc->has_hotpluggable_cpus) {
> -            error_setg(errp, "CPU hot unplug not supported on this machi=
ne");
> -            return;
> -        }
> -        spapr_core_unplug(hotplug_dev, dev, errp);
> -    }
> -}
> -
>  static void spapr_machine_device_unplug_request(HotplugHandler *hotplug_=
dev,
>                                                  DeviceState *dev, Error =
**errp)
>  {
> @@ -3397,7 +3360,6 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
>      mc->get_hotplug_handler =3D spapr_get_hotplug_handler;
>      hc->pre_plug =3D spapr_machine_device_pre_plug;
>      hc->plug =3D spapr_machine_device_plug;
> -    hc->unplug =3D spapr_machine_device_unplug;
>      mc->cpu_index_to_instance_props =3D spapr_cpu_index_to_props;
>      mc->possible_cpu_arch_ids =3D spapr_possible_cpu_arch_ids;
>      hc->unplug_request =3D spapr_machine_device_unplug_request;


--Sig_/oowY3Ixu1whiOdeRMSLgwdN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlll9EMACgkQAvw66wEB28LuOgCgjBoT0HZubrr3a0mTGEYYr9YN
mWkAniXzFN0HJqIvyjaWt9nL6bP1ze95
=ozO8
-----END PGP SIGNATURE-----

--Sig_/oowY3Ixu1whiOdeRMSLgwdN--
