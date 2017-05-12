Received: from eggs.gnu.org ([2001:4830:134:3::10]:47792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d94R2-0005ew-IX
	for qemu-devel@nongnu.org; Fri, 12 May 2017 02:52:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d94R0-0006nj-JX
	for qemu-devel@nongnu.org; Fri, 12 May 2017 02:52:20 -0400
Date: Fri, 12 May 2017 16:07:31 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170512060731.GF12908@umbus.fritz.box>
References: <20170505204746.14116-1-danielhb@linux.vnet.ibm.com>
	<20170505204746.14116-3-danielhb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uTRFFR9qmiCqR05s"
Content-Disposition: inline
In-Reply-To: <20170505204746.14116-3-danielhb@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v9 2/6] hw/ppc: removing drc->detach_cb and
 drc->detach_cb_opaque
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, mdroth@linux.vnet.ibm.com


--uTRFFR9qmiCqR05s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 05, 2017 at 05:47:42PM -0300, Daniel Henrique Barboza wrote:
> The pointer drc->detach_cb is being used as a way of informing
> the detach() function inside spapr_drc.c which cb to execute. This
> information can also be retrieved simply by checking drc->type and
> choosing the right callback based on it. In this context, detach_cb
> is redundant information that must be managed.
>=20
> After the previous spapr_lmb_release change, no detach_cb_opaques
> are being used by any of the three callbacks functions. This is
> yet another information that is now unused and, on top of that, can't
> be migrated either.
>=20
> This patch makes the following changes:
>=20
> - removal of detach_cb_opaque. the 'opaque' argument was removed from
> the callbacks and from the detach() function of sPAPRConnectorClass. The
> attribute detach_cb_opaque of sPAPRConnector was removed.
>=20
> - removal of detach_cb from the detach() call. The function pointer
> detach_cb of sPAPRConnector was removed. detach() now uses a
> switch(drc->type) to execute the apropriate callback. To achieve this,
> spapr_core_release, spapr_lmb_release and spapr_phb_remove_pci_device_cb
> callbacks were made public to be visible inside detach().
>=20
> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
> ---
>  hw/ppc/spapr.c              | 10 ++++++----
>  hw/ppc/spapr_drc.c          | 36 ++++++++++++++++++++----------------
>  hw/ppc/spapr_pci.c          |  5 +++--
>  include/hw/pci-host/spapr.h |  3 +++
>  include/hw/ppc/spapr.h      |  4 ++++
>  include/hw/ppc/spapr_drc.h  |  8 +-------
>  6 files changed, 37 insertions(+), 29 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 346c827..e190eb9 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2610,7 +2610,8 @@ static uint64_t spapr_dimm_get_address(PCDIMMDevice=
 *dimm)
>      return addr;
>  }
> =20
> -static void spapr_lmb_release(DeviceState *dev, void *opaque)
> +/* Callback to be called during DRC release. */
> +void spapr_lmb_release(DeviceState *dev)
>  {
>      HotplugHandler *hotplug_ctrl;
> =20
> @@ -2652,7 +2653,7 @@ static void spapr_del_lmbs(DeviceState *dev, uint64=
_t addr_start, uint64_t size,
>          g_assert(drc);
> =20
>          drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
> -        drck->detach(drc, dev, spapr_lmb_release, NULL, errp);
> +        drck->detach(drc, dev, errp);
>          addr +=3D SPAPR_MEMORY_BLOCK_SIZE;
>      }
> =20
> @@ -2728,7 +2729,8 @@ static void spapr_core_unplug(HotplugHandler *hotpl=
ug_dev, DeviceState *dev,
>      object_unparent(OBJECT(dev));
>  }
> =20
> -static void spapr_core_release(DeviceState *dev, void *opaque)
> +/* Callback to be called during DRC release. */
> +void spapr_core_release(DeviceState *dev)
>  {
>      HotplugHandler *hotplug_ctrl;
> =20
> @@ -2761,7 +2763,7 @@ void spapr_core_unplug_request(HotplugHandler *hotp=
lug_dev, DeviceState *dev,
>      g_assert(drc);
> =20
>      drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
> -    drck->detach(drc, dev, spapr_core_release, NULL, &local_err);
> +    drck->detach(drc, dev, &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
>          return;
> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> index a1cdc87..1c72160 100644
> --- a/hw/ppc/spapr_drc.c
> +++ b/hw/ppc/spapr_drc.c
> @@ -20,6 +20,7 @@
>  #include "qapi/visitor.h"
>  #include "qemu/error-report.h"
>  #include "hw/ppc/spapr.h" /* for RTAS return codes */
> +#include "hw/pci-host/spapr.h" /* spapr_phb_remove_pci_device_cb callbac=
k */
>  #include "trace.h"
> =20
>  #define DRC_CONTAINER_PATH "/dr-connector"
> @@ -99,8 +100,7 @@ static uint32_t set_isolation_state(sPAPRDRConnector *=
drc,
>          if (drc->awaiting_release) {
>              if (drc->configured) {
>                  trace_spapr_drc_set_isolation_state_finalizing(get_index=
(drc));
> -                drck->detach(drc, DEVICE(drc->dev), drc->detach_cb,
> -                             drc->detach_cb_opaque, NULL);
> +                drck->detach(drc, DEVICE(drc->dev), NULL);
>              } else {
>                  trace_spapr_drc_set_isolation_state_deferring(get_index(=
drc));
>              }
> @@ -153,8 +153,7 @@ static uint32_t set_allocation_state(sPAPRDRConnector=
 *drc,
>          if (drc->awaiting_release &&
>              drc->allocation_state =3D=3D SPAPR_DR_ALLOCATION_STATE_UNUSA=
BLE) {
>              trace_spapr_drc_set_allocation_state_finalizing(get_index(dr=
c));
> -            drck->detach(drc, DEVICE(drc->dev), drc->detach_cb,
> -                         drc->detach_cb_opaque, NULL);
> +            drck->detach(drc, DEVICE(drc->dev), NULL);
>          } else if (drc->allocation_state =3D=3D SPAPR_DR_ALLOCATION_STAT=
E_USABLE) {
>              drc->awaiting_allocation =3D false;
>          }
> @@ -404,15 +403,10 @@ static void attach(sPAPRDRConnector *drc, DeviceSta=
te *d, void *fdt,
>                               NULL, 0, NULL);
>  }
> =20
> -static void detach(sPAPRDRConnector *drc, DeviceState *d,
> -                   spapr_drc_detach_cb *detach_cb,
> -                   void *detach_cb_opaque, Error **errp)
> +static void detach(sPAPRDRConnector *drc, DeviceState *d, Error **errp)
>  {
>      trace_spapr_drc_detach(get_index(drc));
> =20
> -    drc->detach_cb =3D detach_cb;
> -    drc->detach_cb_opaque =3D detach_cb_opaque;
> -
>      /* if we've signalled device presence to the guest, or if the guest
>       * has gone ahead and configured the device (via manually-executed
>       * device add via drmgr in guest, namely), we need to wait
> @@ -456,8 +450,21 @@ static void detach(sPAPRDRConnector *drc, DeviceStat=
e *d,
> =20
>      drc->indicator_state =3D SPAPR_DR_INDICATOR_STATE_INACTIVE;
> =20
> -    if (drc->detach_cb) {
> -        drc->detach_cb(drc->dev, drc->detach_cb_opaque);
> +    /* Calling release callbacks based on drc->type. */
> +    switch (drc->type) {
> +    case SPAPR_DR_CONNECTOR_TYPE_CPU:
> +        spapr_core_release(drc->dev);
> +        break;
> +    case SPAPR_DR_CONNECTOR_TYPE_PHB:
> +    case SPAPR_DR_CONNECTOR_TYPE_VIO:
> +    case SPAPR_DR_CONNECTOR_TYPE_PCI:

This isn't correct.  PHB and VIO DRCs haven't been implemented yet,
and when they are, I don't believe the PCI callback will be suitable.
PHB and VIO should go to the default case for now.

> +        spapr_phb_remove_pci_device_cb(drc->dev);
> +        break;
> +    case SPAPR_DR_CONNECTOR_TYPE_LMB:
> +        spapr_lmb_release(drc->dev);
> +        break;
> +    default:
> +        ;

=2E. and the default case should probably assert().  If we get here it
means something else has built a bad DRC.

>      }
> =20
>      drc->awaiting_release =3D false;
> @@ -467,8 +474,6 @@ static void detach(sPAPRDRConnector *drc, DeviceState=
 *d,
>      drc->fdt_start_offset =3D 0;
>      object_property_del(OBJECT(drc), "device", NULL);
>      drc->dev =3D NULL;
> -    drc->detach_cb =3D NULL;
> -    drc->detach_cb_opaque =3D NULL;
>  }
> =20
>  static bool release_pending(sPAPRDRConnector *drc)
> @@ -498,8 +503,7 @@ static void reset(DeviceState *d)
>           * force removal if we are
>           */
>          if (drc->awaiting_release) {
> -            drck->detach(drc, DEVICE(drc->dev), drc->detach_cb,
> -                         drc->detach_cb_opaque, NULL);
> +            drck->detach(drc, DEVICE(drc->dev), NULL);
>          }
> =20
>          /* non-PCI devices may be awaiting a transition to UNUSABLE */
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index e7567e2..5775db8 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1369,7 +1369,8 @@ out:
>      }
>  }
> =20
> -static void spapr_phb_remove_pci_device_cb(DeviceState *dev, void *opaqu=
e)
> +/* Callback to be called during DRC release. */
> +void spapr_phb_remove_pci_device_cb(DeviceState *dev)
>  {
>      /* some version guests do not wait for completion of a device
>       * cleanup (generally done asynchronously by the kernel) before
> @@ -1392,7 +1393,7 @@ static void spapr_phb_remove_pci_device(sPAPRDRConn=
ector *drc,
>  {
>      sPAPRDRConnectorClass *drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
> =20
> -    drck->detach(drc, DEVICE(pdev), spapr_phb_remove_pci_device_cb, phb,=
 errp);
> +    drck->detach(drc, DEVICE(pdev), errp);
>  }
> =20
>  static sPAPRDRConnector *spapr_phb_get_pci_func_drc(sPAPRPHBState *phb,
> diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
> index 1c2e970..38470b2 100644
> --- a/include/hw/pci-host/spapr.h
> +++ b/include/hw/pci-host/spapr.h
> @@ -123,6 +123,9 @@ sPAPRPHBState *spapr_pci_find_phb(sPAPRMachineState *=
spapr, uint64_t buid);
>  PCIDevice *spapr_pci_find_dev(sPAPRMachineState *spapr, uint64_t buid,
>                                uint32_t config_addr);
> =20
> +/* PCI release callback. */
> +void spapr_phb_remove_pci_device_cb(DeviceState *dev);
> +
>  /* VFIO EEH hooks */
>  #ifdef CONFIG_LINUX
>  bool spapr_phb_eeh_available(sPAPRPHBState *sphb);
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 3e2b5ab..adc9fdb 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -640,6 +640,10 @@ void spapr_hotplug_req_remove_by_count_indexed(sPAPR=
DRConnectorType drc_type,
>  void *spapr_populate_hotplug_cpu_dt(CPUState *cs, int *fdt_offset,
>                                      sPAPRMachineState *spapr);
> =20
> +/* CPU and LMB DRC release callbacks. */
> +void spapr_core_release(DeviceState *dev);
> +void spapr_lmb_release(DeviceState *dev);
> +
>  /* rtas-configure-connector state */
>  struct sPAPRConfigureConnectorState {
>      uint32_t drc_index;
> diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
> index 5524247..813b9ff 100644
> --- a/include/hw/ppc/spapr_drc.h
> +++ b/include/hw/ppc/spapr_drc.h
> @@ -130,8 +130,6 @@ typedef enum {
>      SPAPR_DR_CC_RESPONSE_NOT_CONFIGURABLE =3D -9003,
>  } sPAPRDRCCResponse;
> =20
> -typedef void (spapr_drc_detach_cb)(DeviceState *d, void *opaque);
> -
>  typedef struct sPAPRDRConnector {
>      /*< private >*/
>      DeviceState parent;
> @@ -158,8 +156,6 @@ typedef struct sPAPRDRConnector {
> =20
>      /* device pointer, via link property */
>      DeviceState *dev;
> -    spapr_drc_detach_cb *detach_cb;
> -    void *detach_cb_opaque;
>  } sPAPRDRConnector;
> =20
>  typedef struct sPAPRDRConnectorClass {
> @@ -188,9 +184,7 @@ typedef struct sPAPRDRConnectorClass {
>      /* QEMU interfaces for managing hotplug operations */
>      void (*attach)(sPAPRDRConnector *drc, DeviceState *d, void *fdt,
>                     int fdt_start_offset, bool coldplug, Error **errp);
> -    void (*detach)(sPAPRDRConnector *drc, DeviceState *d,
> -                   spapr_drc_detach_cb *detach_cb,
> -                   void *detach_cb_opaque, Error **errp);
> +    void (*detach)(sPAPRDRConnector *drc, DeviceState *d, Error **errp);
>      bool (*release_pending)(sPAPRDRConnector *drc);
>      void (*set_signalled)(sPAPRDRConnector *drc);
>  } sPAPRDRConnectorClass;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--uTRFFR9qmiCqR05s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZFVEjAAoJEGw4ysog2bOSPFAQAMDKfql6Xjn9azOs9L/2CfFu
+s/CCgMIvW1Wtm4jw9KcKWL5Zk6AHU7rWoO1ZMbsQab/xWwzjoIm4gSAKIk+BZtl
wwOZ/n/PBvfcM8btgpJ/D4BHUKEqzRWDDC/AyVFNDdcODcweBsA0WqvSZUkk4ntC
7Njke1MLWPPm/T0rn8IU91QUI5LgY1U4mZAXzeMAwQrdbS0aYKVTK4ECpRx/KkOn
s0SKJvT4YAEgLGwsH+m92nat3vQysCKlscI7aDEQYxu75DBe6u6EVaxTTjd2s2og
NYCsyu8i3NndPr082httFWKx56mPwsk8g9SUt7+bTBFDbhryRKmBTpgZi+QHJLBM
MAj0Lh2fEVOb4qejABFMQhWRmss/x1pe6EiGRCpjAWoZWKY9VeXSVv6+NnsQjTwr
ii/bf12kwc1dpWm+wlL0qENG/kKAMX655GXdajUzw+3A5/hcEwyIolV1QtNLr+fC
Pu+PVwPsS6pid61mPt55bRoMdhdD6YGGvBvzA/bGsD6bnO2qL1Mcs8UU2za4qvfq
yQaE2Ylwx072gYKKp3AADjkLYSU9XhsjlpJaV4hh6AAq3pzYugiXL3oL2kNsgVX/
Fskgr3UJTYWAkq/J1OURErIrC5e1aF18iHVVRCZv4pQ8qR5FwZ4nWyXnXio3qGdI
cyywl8JSR9Pp/S57oOFj
=v5vb
-----END PGP SIGNATURE-----

--uTRFFR9qmiCqR05s--
