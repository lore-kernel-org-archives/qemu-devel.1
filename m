Received: from eggs.gnu.org ([2001:4830:134:3::10]:35969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dFk7W-0005aL-D6
	for qemu-devel@nongnu.org; Tue, 30 May 2017 12:35:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dFk7R-0001gC-E6
	for qemu-devel@nongnu.org; Tue, 30 May 2017 12:35:46 -0400
Received: from 9.mo5.mail-out.ovh.net ([178.32.96.204]:59749)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dFk7R-0001fY-4L
	for qemu-devel@nongnu.org; Tue, 30 May 2017 12:35:41 -0400
Received: from player799.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 5CB23FF58A
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 18:35:39 +0200 (CEST)
Date: Tue, 30 May 2017 18:35:31 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170530183531.1599765d@bahia.ttt.fr.ibm.com>
In-Reply-To: <20170530160445.12810-1-lvivier@redhat.com>
References: <20170530160445.12810-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/0XL=RgIeFoLfWRP=W_mMZ1I";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] spapr: manage hotplugged
 devices while the VM is not started
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

--Sig_/0XL=RgIeFoLfWRP=W_mMZ1I
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 30 May 2017 18:04:45 +0200
Laurent Vivier <lvivier@redhat.com> wrote:

> For QEMU, a hotlugged device is a device added using the HMP/QMP
> interface.
> For SPAPR, a hotplugged device is a device added while the
> machine is running. In this case QEMU doesn't update internal
> state but relies on the OS for this part
>=20
> In the case of migration, when we (libvirt) hotplug a device
> on the source guest, we (libvirt) generally hotplug the same
> device on the destination guest. But in this case, the machine
> is stopped (RUN_STATE_INMIGRATE) and QEMU must not expect
> the OS will manage it as an hotplugged device as it will
> be "imported" by the migration.
>=20
> This patch changes the meaning of "hotplugged" in spapr.c
> to manage a QEMU hotplugged device like a "coldplugged" one
> when the machine is awaiting an incoming migration.
>=20
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 0980d73..f1302d0 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2511,6 +2511,12 @@ static void spapr_nmi(NMIState *n, int cpu_index, =
Error **errp)
>      }
>  }
> =20
> +static bool spapr_coldplugged(DeviceState *dev)
> +{
> +    return runstate_check(RUN_STATE_INMIGRATE) ||
> +           !dev->hotplugged;
> +}
> +
>  static void spapr_add_lmbs(DeviceState *dev, uint64_t addr_start, uint64=
_t size,
>                             uint32_t node, bool dedicated_hp_event_source,
>                             Error **errp)
> @@ -2521,6 +2527,7 @@ static void spapr_add_lmbs(DeviceState *dev, uint64=
_t addr_start, uint64_t size,
>      int i, fdt_offset, fdt_size;
>      void *fdt;
>      uint64_t addr =3D addr_start;
> +    bool coldplugged =3D spapr_coldplugged(dev);
> =20
>      for (i =3D 0; i < nr_lmbs; i++) {
>          drc =3D spapr_dr_connector_by_id(SPAPR_DR_CONNECTOR_TYPE_LMB,
> @@ -2532,9 +2539,9 @@ static void spapr_add_lmbs(DeviceState *dev, uint64=
_t addr_start, uint64_t size,
>                                                  SPAPR_MEMORY_BLOCK_SIZE);
> =20
>          drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
> -        drck->attach(drc, dev, fdt, fdt_offset, !dev->hotplugged, errp);
> +        drck->attach(drc, dev, fdt, fdt_offset, coldplugged, errp);
>          addr +=3D SPAPR_MEMORY_BLOCK_SIZE;
> -        if (!dev->hotplugged) {
> +        if (coldplugged) {
>              /* guests expect coldplugged LMBs to be pre-allocated */
>              drck->set_allocation_state(drc, SPAPR_DR_ALLOCATION_STATE_US=
ABLE);
>              drck->set_isolation_state(drc, SPAPR_DR_ISOLATION_STATE_UNIS=
OLATED);
> @@ -2543,7 +2550,7 @@ static void spapr_add_lmbs(DeviceState *dev, uint64=
_t addr_start, uint64_t size,
>      /* send hotplug notification to the
>       * guest only in case of hotplugged memory
>       */
> -    if (dev->hotplugged) {
> +    if (!coldplugged) {
>          if (dedicated_hp_event_source) {
>              drc =3D spapr_dr_connector_by_id(SPAPR_DR_CONNECTOR_TYPE_LMB,
>                      addr_start / SPAPR_MEMORY_BLOCK_SIZE);
> @@ -2776,6 +2783,7 @@ static void spapr_core_plug(HotplugHandler *hotplug=
_dev, DeviceState *dev,
>      int smt =3D kvmppc_smt_threads();
>      CPUArchId *core_slot;
>      int index;
> +    bool coldplugged =3D spapr_coldplugged(dev);
> =20
>      core_slot =3D spapr_find_cpu_slot(MACHINE(hotplug_dev), cc->core_id,=
 &index);
>      if (!core_slot) {
> @@ -2797,7 +2805,7 @@ static void spapr_core_plug(HotplugHandler *hotplug=
_dev, DeviceState *dev,
> =20
>      if (drc) {
>          sPAPRDRConnectorClass *drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc=
);
> -        drck->attach(drc, dev, fdt, fdt_offset, !dev->hotplugged, &local=
_err);
> +        drck->attach(drc, dev, fdt, fdt_offset, coldplugged, &local_err);
>          if (local_err) {
>              g_free(fdt);
>              error_propagate(errp, local_err);
> @@ -2805,7 +2813,7 @@ static void spapr_core_plug(HotplugHandler *hotplug=
_dev, DeviceState *dev,
>          }
>      }
> =20
> -    if (dev->hotplugged) {
> +    if (!coldplugged) {
>          /*
>           * Send hotplug notification interrupt to the guest only in case
>           * of hotplugged CPUs.
> @@ -2838,7 +2846,7 @@ static void spapr_core_pre_plug(HotplugHandler *hot=
plug_dev, DeviceState *dev,
>      int node_id;
>      int index;
> =20
> -    if (dev->hotplugged && !mc->has_hotpluggable_cpus) {
> +    if (!spapr_coldplugged(dev) && !mc->has_hotpluggable_cpus) {
>          error_setg(&local_err, "CPU hotplug not supported for this machi=
ne");
>          goto out;
>      }


--Sig_/0XL=RgIeFoLfWRP=W_mMZ1I
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlktn1MACgkQAvw66wEB28IYygCdGHs9kY3tEBydb1q7kaFhrUVH
Bs8AoKSG/75DgWnbg8GPnLrDi2rP65bc
=fOi+
-----END PGP SIGNATURE-----

--Sig_/0XL=RgIeFoLfWRP=W_mMZ1I--
