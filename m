Received: from eggs.gnu.org ([2001:4830:134:3::10]:57884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dVDDQ-0006T7-AW
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 04:41:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dVDDN-0004We-1o
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 04:41:48 -0400
Received: from 10.mo68.mail-out.ovh.net ([46.105.79.203]:42643)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dVDDM-0004VK-PA
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 04:41:44 -0400
Received: from player750.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 82E16692A7
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 10:41:42 +0200 (CEST)
Date: Wed, 12 Jul 2017 10:41:30 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170712104130.4a19222a@bahia.lan>
In-Reply-To: <20170712055317.26225-2-david@gibson.dropbear.id.au>
References: <20170712055317.26225-1-david@gibson.dropbear.id.au>
	<20170712055317.26225-2-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/WvrYe27Rp/PX6j+2617Ia1u";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCHv2 1/8] spapr: Treat devices added before
 inbound migration as coldplugged
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

--Sig_/WvrYe27Rp/PX6j+2617Ia1u
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 12 Jul 2017 15:53:10 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> From: Laurent Vivier <lvivier@redhat.com>
>=20
> When migrating a guest which has already had devices hotplugged,
> libvirt typically starts the destination qemu with -incoming defer,
> adds those hotplugged devices with qmp, then initiates the incoming
> migration.
>=20
> This causes problems for the management of spapr DRC state.  Because
> the device is treated as hotplugged, it goes into a DRC state for a
> device immediately after it's plugged, but before the guest has
> acknowledged its presence.  However, chances are the guest on the
> source machine *has* acknowledged the device's presence and configured
> it.
>=20
> If the source has fully configured the device, then DRC state won't be
> sent in the migration stream: for maximum migration compatibility with
> earlier versions we don't migrate DRCs in coldplug-equivalent state.
> That means that the DRC effectively changes state over the migrate,
> causing problems later on.
>=20
> In addition, logging hotplug events for these devices isn't what we
> want because a) those events should already have been issued on the
> source host and b) the event queue should get wiped out by the
> incoming state anyway.
>=20
> In short, what we really want is to treat devices added before an
> incoming migration as if they were coldplugged.
>=20
> To do this, we first add a spapr_drc_hotplugged() helper which
> determines if the device is hotplugged in the sense relevant for DRC
> state management.  We only send hotplug events when this is true.
> Second, when we add a device which isn't hotplugged in this sense, we
> force a reset of the DRC state - this ensures the DRC is in a
> coldplug-equivalent state (there isn't usually a system reset between
> these device adds and the incoming migration).
>=20
> This is based on an earlier patch by Laurent Vivier, cleaned up and
> extended.
>=20
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr.c             | 24 ++++++++++++++++--------
>  hw/ppc/spapr_drc.c         |  9 ++++++---
>  hw/ppc/spapr_pci.c         |  4 +++-
>  include/hw/ppc/spapr_drc.h |  8 ++++++++
>  4 files changed, 33 insertions(+), 12 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 12b3f09..2a059d5 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2636,6 +2636,7 @@ static void spapr_add_lmbs(DeviceState *dev, uint64=
_t addr_start, uint64_t size,
>      int i, fdt_offset, fdt_size;
>      void *fdt;
>      uint64_t addr =3D addr_start;
> +    bool hotplugged =3D spapr_drc_hotplugged(dev);
>      Error *local_err =3D NULL;
> =20
>      for (i =3D 0; i < nr_lmbs; i++) {
> @@ -2659,12 +2660,15 @@ static void spapr_add_lmbs(DeviceState *dev, uint=
64_t addr_start, uint64_t size,
>              error_propagate(errp, local_err);
>              return;
>          }
> +        if (!hotplugged) {
> +            spapr_drc_reset(drc);
> +        }
>          addr +=3D SPAPR_MEMORY_BLOCK_SIZE;
>      }
>      /* send hotplug notification to the
>       * guest only in case of hotplugged memory
>       */
> -    if (dev->hotplugged) {
> +    if (hotplugged) {
>          if (dedicated_hp_event_source) {
>              drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_LMB,
>                                    addr_start / SPAPR_MEMORY_BLOCK_SIZE);
> @@ -2998,6 +3002,7 @@ static void spapr_core_plug(HotplugHandler *hotplug=
_dev, DeviceState *dev,
>      int smt =3D kvmppc_smt_threads();
>      CPUArchId *core_slot;
>      int index;
> +    bool hotplugged =3D spapr_drc_hotplugged(dev);
> =20
>      core_slot =3D spapr_find_cpu_slot(MACHINE(hotplug_dev), cc->core_id,=
 &index);
>      if (!core_slot) {
> @@ -3018,15 +3023,18 @@ static void spapr_core_plug(HotplugHandler *hotpl=
ug_dev, DeviceState *dev,
>              error_propagate(errp, local_err);
>              return;
>          }
> -    }
> =20
> -    if (dev->hotplugged) {
> -        /*
> -         * Send hotplug notification interrupt to the guest only in case
> -         * of hotplugged CPUs.
> -         */
> -        spapr_hotplug_req_add_by_index(drc);
> +        if (hotplugged) {
> +            /*
> +             * Send hotplug notification interrupt to the guest only
> +             * in case of hotplugged CPUs.
> +             */
> +            spapr_hotplug_req_add_by_index(drc);
> +        } else {
> +            spapr_drc_reset(drc);
> +        }
>      }
> +
>      core_slot->cpu =3D OBJECT(dev);
> =20
>      if (smc->pre_2_10_has_unused_icps) {
> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> index f34355d..9b07f80 100644
> --- a/hw/ppc/spapr_drc.c
> +++ b/hw/ppc/spapr_drc.c
> @@ -412,10 +412,8 @@ static bool release_pending(sPAPRDRConnector *drc)
>      return drc->awaiting_release;
>  }
> =20
> -static void drc_reset(void *opaque)
> +void spapr_drc_reset(sPAPRDRConnector *drc)
>  {
> -    sPAPRDRConnector *drc =3D SPAPR_DR_CONNECTOR(opaque);
> -
>      trace_spapr_drc_reset(spapr_drc_index(drc));
> =20
>      g_free(drc->ccs);
> @@ -447,6 +445,11 @@ static void drc_reset(void *opaque)
>      }
>  }
> =20
> +static void drc_reset(void *opaque)
> +{
> +    spapr_drc_reset(SPAPR_DR_CONNECTOR(opaque));
> +}
> +
>  static bool spapr_drc_needed(void *opaque)
>  {
>      sPAPRDRConnector *drc =3D (sPAPRDRConnector *)opaque;
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index a52dcf8..1e84c55 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1443,7 +1443,9 @@ static void spapr_pci_plug(HotplugHandler *plug_han=
dler,
>      /* If this is function 0, signal hotplug for all the device function=
s.
>       * Otherwise defer sending the hotplug event.
>       */
> -    if (plugged_dev->hotplugged && PCI_FUNC(pdev->devfn) =3D=3D 0) {
> +    if (!spapr_drc_hotplugged(plugged_dev)) {
> +        spapr_drc_reset(drc);
> +    } else if (PCI_FUNC(pdev->devfn) =3D=3D 0) {
>          int i;
> =20
>          for (i =3D 0; i < 8; i++) {
> diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
> index d15e9eb..715016b 100644
> --- a/include/hw/ppc/spapr_drc.h
> +++ b/include/hw/ppc/spapr_drc.h
> @@ -15,6 +15,7 @@
> =20
>  #include <libfdt.h>
>  #include "qom/object.h"
> +#include "sysemu/sysemu.h"
>  #include "hw/qdev.h"
> =20
>  #define TYPE_SPAPR_DR_CONNECTOR "spapr-dr-connector"
> @@ -223,6 +224,13 @@ typedef struct sPAPRDRConnectorClass {
>      bool (*release_pending)(sPAPRDRConnector *drc);
>  } sPAPRDRConnectorClass;
> =20
> +static inline bool spapr_drc_hotplugged(DeviceState *dev)
> +{
> +    return dev->hotplugged && !runstate_check(RUN_STATE_INMIGRATE);
> +}
> +
> +void spapr_drc_reset(sPAPRDRConnector *drc);
> +
>  uint32_t spapr_drc_index(sPAPRDRConnector *drc);
>  sPAPRDRConnectorType spapr_drc_type(sPAPRDRConnector *drc);
> =20


--Sig_/WvrYe27Rp/PX6j+2617Ia1u
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlll4LoACgkQAvw66wEB28IshQCdEx8RSodF1uAdiVwdjIpxqmYf
Lq4AoJb7EqzcwgWaGtAsvRjNZeUPFZEx
=/OF1
-----END PGP SIGNATURE-----

--Sig_/WvrYe27Rp/PX6j+2617Ia1u--
