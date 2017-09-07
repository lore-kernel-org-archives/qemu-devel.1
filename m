Received: from eggs.gnu.org ([2001:4830:134:3::10]:51012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dpyco-00087V-JY
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 11:21:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dpyce-0003ts-Vz
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 11:21:50 -0400
Received: from 1.mo177.mail-out.ovh.net ([178.33.107.143]:45919)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dpyce-0003mu-Md
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 11:21:40 -0400
Received: from player714.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id E9CF374DFE
	for <qemu-devel@nongnu.org>; Thu,  7 Sep 2017 17:21:31 +0200 (CEST)
Date: Thu, 7 Sep 2017 17:21:23 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170907172123.6732c1ba@bahia>
In-Reply-To: <20170906184305.2612-1-danielhb@linux.vnet.ibm.com>
References: <20170906184305.2612-1-danielhb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/J0nbrKH.ntGbdCInPjQxfUc";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] hw/ppc/spapr.c: cleaning up
 qdev_get_machine() calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, mdroth@linux.vnet.ibm.com, david@gibson.dropbear.id.au

--Sig_/J0nbrKH.ntGbdCInPjQxfUc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed,  6 Sep 2017 15:43:05 -0300
Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com> wrote:

> This patch removes the qdev_get_machine() calls that are made in
> spapr.c in situations where we can get an existing pointer for
> the MachineState by either passing it as an argument to the function
> or by using other already available pointers.
>=20
> The following changes were made:
>=20
> - spapr_node0_size: static function that is called two times:
> at spapr_setup_hpt_and_vrma and ppc_spapr_init. In both cases we can
> pass an existing MachineState pointer to it.
>=20
> - spapr_build_fdt: MachineState pointer can be retrieved from
> the existing sPAPRMachineState pointer.
>=20
> - spapr_boot_set: the opaque in the first arg is a sPAPRMachineState
> pointer as we can see inside ppc_spapr_init:
>=20
>     qemu_register_boot_set(spapr_boot_set, spapr);
>=20
> We can get a MachineState pointer from it.
>=20
> - spapr_machine_device_plug and spapr_machine_device_unplug_request: the
> MachineState, sPAPRMachineState, MachineClass and sPAPRMachineClass point=
ers
> can all be retrieved from the HotplugHandler pointer.
>=20
> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
> ---

It makes sense for me.

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index cec441c..6ac3390 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -390,10 +390,8 @@ static int spapr_fixup_cpu_dt(void *fdt, sPAPRMachin=
eState *spapr)
>      return ret;
>  }
> =20
> -static hwaddr spapr_node0_size(void)
> +static hwaddr spapr_node0_size(MachineState *machine)
>  {
> -    MachineState *machine =3D MACHINE(qdev_get_machine());
> -
>      if (nb_numa_nodes) {
>          int i;
>          for (i =3D 0; i < nb_numa_nodes; ++i) {
> @@ -1027,7 +1025,7 @@ static void *spapr_build_fdt(sPAPRMachineState *spa=
pr,
>                               hwaddr rtas_addr,
>                               hwaddr rtas_size)
>  {
> -    MachineState *machine =3D MACHINE(qdev_get_machine());
> +    MachineState *machine =3D MACHINE(spapr);
>      MachineClass *mc =3D MACHINE_GET_CLASS(machine);
>      sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(machine);
>      int ret;
> @@ -1347,7 +1345,7 @@ void spapr_setup_hpt_and_vrma(sPAPRMachineState *sp=
apr)
>      spapr_reallocate_hpt(spapr, hpt_shift, &error_fatal);
> =20
>      if (spapr->vrma_adjust) {
> -        spapr->rma_size =3D kvmppc_rma_size(spapr_node0_size(),
> +        spapr->rma_size =3D kvmppc_rma_size(spapr_node0_size(MACHINE(spa=
pr)),
>                                            spapr->htab_shift);
>      }
>      /* We're setting up a hash table, so that means we're not radix */
> @@ -2007,7 +2005,7 @@ static SaveVMHandlers savevm_htab_handlers =3D {
>  static void spapr_boot_set(void *opaque, const char *boot_device,
>                             Error **errp)
>  {
> -    MachineState *machine =3D MACHINE(qdev_get_machine());
> +    MachineState *machine =3D MACHINE(opaque);
>      machine->boot_order =3D g_strdup(boot_device);
>  }
> =20
> @@ -2154,7 +2152,7 @@ static void ppc_spapr_init(MachineState *machine)
>      MemoryRegion *rma_region;
>      void *rma =3D NULL;
>      hwaddr rma_alloc_size;
> -    hwaddr node0_size =3D spapr_node0_size();
> +    hwaddr node0_size =3D spapr_node0_size(machine);
>      long load_limit, fw_size;
>      char *filename;
>      Error *resize_hpt_err =3D NULL;
> @@ -3198,7 +3196,8 @@ out:
>  static void spapr_machine_device_plug(HotplugHandler *hotplug_dev,
>                                        DeviceState *dev, Error **errp)
>  {
> -    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(qdev_get_machine(=
));
> +    MachineState *ms =3D MACHINE(hotplug_dev);
> +    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(ms);
> =20
>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
>          int node;
> @@ -3247,8 +3246,8 @@ static void spapr_machine_device_plug(HotplugHandle=
r *hotplug_dev,
>  static void spapr_machine_device_unplug_request(HotplugHandler *hotplug_=
dev,
>                                                  DeviceState *dev, Error =
**errp)
>  {
> -    sPAPRMachineState *sms =3D SPAPR_MACHINE(qdev_get_machine());
> -    MachineClass *mc =3D MACHINE_GET_CLASS(qdev_get_machine());
> +    sPAPRMachineState *sms =3D SPAPR_MACHINE(OBJECT(hotplug_dev));
> +    MachineClass *mc =3D MACHINE_GET_CLASS(sms);
> =20
>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
>          if (spapr_ovec_test(sms->ov5_cas, OV5_HP_EVT)) {


--Sig_/J0nbrKH.ntGbdCInPjQxfUc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQQr1DtEU17Ap5iU26IC/DrrAQHbwgUCWbFj9AAKCRAC/DrrAQHb
wpwGAJ4ztFezSVRu01RH4eeWcNszV5KeHwCgnx8XwS9K53xxxPqu2QSgw0iNai4=
=hDln
-----END PGP SIGNATURE-----

--Sig_/J0nbrKH.ntGbdCInPjQxfUc--
