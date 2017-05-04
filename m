Received: from eggs.gnu.org ([2001:4830:134:3::10]:44772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d69Qm-0001aN-MF
	for qemu-devel@nongnu.org; Thu, 04 May 2017 01:36:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d69Qi-0004o1-GD
	for qemu-devel@nongnu.org; Thu, 04 May 2017 01:36:00 -0400
Date: Thu, 4 May 2017 15:33:25 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170504053325.GA14413@umbus.fritz.box>
References: <20170430172547.13415-1-danielhb@linux.vnet.ibm.com>
	<20170430172547.13415-2-danielhb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
In-Reply-To: <20170430172547.13415-2-danielhb@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/5] hw/ppc: setting spapr_drc_detach_cb in
 spapr_dr_connector_new
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 30, 2017 at 02:25:43PM -0300, Daniel Henrique Barboza wrote:
> The idea of moving the detach callback functions to the constructor
> of the dr_connector is to set them statically at init time, avoiding
> any post-load hooks to restore it (after a migration, for example).
>=20
> Summary of changes:
>=20
> - hw/ppc/spapr_drc.c and include/hw/ppc/spapr_drc.h:
>     *  spapr_dr_connector_new() now has an additional parameter,
> spapr_drc_detach_cb *detach_cb
>     *  'spapr_drc_detach_cb *detach_cb' parameter was removed of
> the detach function pointer in sPAPRDRConnectorClass
>=20
> - hw/ppc/spapr_pci.c:
>     * the callback 'spapr_phb_remove_pci_device_cb' is now passed
> as a parameter in 'spapr_dr_connector_new' instead of 'drck->detach()'
>=20
> - hw/ppc/spapr.c:
>     * 'spapr_create_lmb_dr_connectors' now passes the callback
> 'spapr_lmb_release' to 'spapr_dr_connector_new' instead of 'drck-detach()'
>     * 'spapr_init_cpus' now passes the callback 'spapr_core_release'
> to 'spapr_dr_connector_new' instead of 'drck-detach()'
>     * moved the callback functions up in the code so they can be referenc=
ed
> by 'spapr_create_lmb_dr_connectors' and 'spapr_init_cpus'
>=20
> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

So, the patch looks correct, but the approach bothers me a bit.  The
DRC type and the detach callback are essentially redundant information
- the callback still gets stored in the instance, which doesn't make a
whole lot of sense.

Ideally we'd use QOM subtypes of the base DRC type and put the
callback in the drck, but I suspect that will raise some other
complications, so I'm ok with postponing that.

In the meantime, I think we'd be better of doing an explicit switch on
the DRC type when we want to call the detach function, rather than
storing a function pointer at all.  It's kind of ugly, but we already
have a bunch of nasty switches on the type, so I don't think it's
really any uglier than what we have.


> ---
>  hw/ppc/spapr.c             | 71 +++++++++++++++++++++++-----------------=
------
>  hw/ppc/spapr_drc.c         | 17 ++++++-----
>  hw/ppc/spapr_pci.c         |  5 ++--
>  include/hw/ppc/spapr_drc.h |  4 +--
>  4 files changed, 49 insertions(+), 48 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 80d12d0..bc11757 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1887,6 +1887,29 @@ static void spapr_drc_reset(void *opaque)
>      }
>  }
> =20
> +typedef struct sPAPRDIMMState {
> +    uint32_t nr_lmbs;
> +} sPAPRDIMMState;
> +
> +static void spapr_lmb_release(DeviceState *dev, void *opaque)
> +{
> +    sPAPRDIMMState *ds =3D (sPAPRDIMMState *)opaque;
> +    HotplugHandler *hotplug_ctrl;
> +
> +    if (--ds->nr_lmbs) {
> +        return;
> +    }
> +
> +    g_free(ds);
> +
> +    /*
> +     * Now that all the LMBs have been removed by the guest, call the
> +     * pc-dimm unplug handler to cleanup up the pc-dimm device.
> +     */
> +    hotplug_ctrl =3D qdev_get_hotplug_handler(dev);
> +    hotplug_handler_unplug(hotplug_ctrl, dev, &error_abort);
> +}
> +
>  static void spapr_create_lmb_dr_connectors(sPAPRMachineState *spapr)
>  {
>      MachineState *machine =3D MACHINE(spapr);
> @@ -1900,7 +1923,7 @@ static void spapr_create_lmb_dr_connectors(sPAPRMac=
hineState *spapr)
> =20
>          addr =3D i * lmb_size + spapr->hotplug_memory.base;
>          drc =3D spapr_dr_connector_new(OBJECT(spapr), SPAPR_DR_CONNECTOR=
_TYPE_LMB,
> -                                     addr/lmb_size);
> +                                     (addr / lmb_size), spapr_lmb_releas=
e);
>          qemu_register_reset(spapr_drc_reset, drc);
>      }
>  }
> @@ -1956,6 +1979,14 @@ static CPUArchId *spapr_find_cpu_slot(MachineState=
 *ms, uint32_t id, int *idx)
>      return &ms->possible_cpus->cpus[index];
>  }
> =20
> +static void spapr_core_release(DeviceState *dev, void *opaque)
> +{
> +    HotplugHandler *hotplug_ctrl;
> +
> +    hotplug_ctrl =3D qdev_get_hotplug_handler(dev);
> +    hotplug_handler_unplug(hotplug_ctrl, dev, &error_abort);
> +}
> +
>  static void spapr_init_cpus(sPAPRMachineState *spapr)
>  {
>      MachineState *machine =3D MACHINE(spapr);
> @@ -1998,7 +2029,8 @@ static void spapr_init_cpus(sPAPRMachineState *spap=
r)
>              sPAPRDRConnector *drc =3D
>                  spapr_dr_connector_new(OBJECT(spapr),
>                                         SPAPR_DR_CONNECTOR_TYPE_CPU,
> -                                       (core_id / smp_threads) * smt);
> +                                       (core_id / smp_threads) * smt,
> +                                       spapr_core_release);
> =20
>              qemu_register_reset(spapr_drc_reset, drc);
>          }
> @@ -2596,29 +2628,6 @@ out:
>      error_propagate(errp, local_err);
>  }
> =20
> -typedef struct sPAPRDIMMState {
> -    uint32_t nr_lmbs;
> -} sPAPRDIMMState;
> -
> -static void spapr_lmb_release(DeviceState *dev, void *opaque)
> -{
> -    sPAPRDIMMState *ds =3D (sPAPRDIMMState *)opaque;
> -    HotplugHandler *hotplug_ctrl;
> -
> -    if (--ds->nr_lmbs) {
> -        return;
> -    }
> -
> -    g_free(ds);
> -
> -    /*
> -     * Now that all the LMBs have been removed by the guest, call the
> -     * pc-dimm unplug handler to cleanup up the pc-dimm device.
> -     */
> -    hotplug_ctrl =3D qdev_get_hotplug_handler(dev);
> -    hotplug_handler_unplug(hotplug_ctrl, dev, &error_abort);
> -}
> -
>  static void spapr_del_lmbs(DeviceState *dev, uint64_t addr_start, uint64=
_t size,
>                             Error **errp)
>  {
> @@ -2636,7 +2645,7 @@ static void spapr_del_lmbs(DeviceState *dev, uint64=
_t addr_start, uint64_t size,
>          g_assert(drc);
> =20
>          drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
> -        drck->detach(drc, dev, spapr_lmb_release, ds, errp);
> +        drck->detach(drc, dev, ds, errp);
>          addr +=3D SPAPR_MEMORY_BLOCK_SIZE;
>      }
> =20
> @@ -2712,14 +2721,6 @@ static void spapr_core_unplug(HotplugHandler *hotp=
lug_dev, DeviceState *dev,
>      object_unparent(OBJECT(dev));
>  }
> =20
> -static void spapr_core_release(DeviceState *dev, void *opaque)
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
> @@ -2745,7 +2746,7 @@ void spapr_core_unplug_request(HotplugHandler *hotp=
lug_dev, DeviceState *dev,
>      g_assert(drc);
> =20
>      drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
> -    drck->detach(drc, dev, spapr_core_release, NULL, &local_err);
> +    drck->detach(drc, dev, NULL, &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
>          return;
> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> index a1cdc87..afe5d82 100644
> --- a/hw/ppc/spapr_drc.c
> +++ b/hw/ppc/spapr_drc.c
> @@ -99,8 +99,8 @@ static uint32_t set_isolation_state(sPAPRDRConnector *d=
rc,
>          if (drc->awaiting_release) {
>              if (drc->configured) {
>                  trace_spapr_drc_set_isolation_state_finalizing(get_index=
(drc));
> -                drck->detach(drc, DEVICE(drc->dev), drc->detach_cb,
> -                             drc->detach_cb_opaque, NULL);
> +                drck->detach(drc, DEVICE(drc->dev), drc->detach_cb_opaqu=
e,
> +                                         NULL);
>              } else {
>                  trace_spapr_drc_set_isolation_state_deferring(get_index(=
drc));
>              }
> @@ -153,8 +153,8 @@ static uint32_t set_allocation_state(sPAPRDRConnector=
 *drc,
>          if (drc->awaiting_release &&
>              drc->allocation_state =3D=3D SPAPR_DR_ALLOCATION_STATE_UNUSA=
BLE) {
>              trace_spapr_drc_set_allocation_state_finalizing(get_index(dr=
c));
> -            drck->detach(drc, DEVICE(drc->dev), drc->detach_cb,
> -                         drc->detach_cb_opaque, NULL);
> +            drck->detach(drc, DEVICE(drc->dev), drc->detach_cb_opaque,
> +                         NULL);
>          } else if (drc->allocation_state =3D=3D SPAPR_DR_ALLOCATION_STAT=
E_USABLE) {
>              drc->awaiting_allocation =3D false;
>          }
> @@ -405,12 +405,10 @@ static void attach(sPAPRDRConnector *drc, DeviceSta=
te *d, void *fdt,
>  }
> =20
>  static void detach(sPAPRDRConnector *drc, DeviceState *d,
> -                   spapr_drc_detach_cb *detach_cb,
>                     void *detach_cb_opaque, Error **errp)
>  {
>      trace_spapr_drc_detach(get_index(drc));
> =20
> -    drc->detach_cb =3D detach_cb;
>      drc->detach_cb_opaque =3D detach_cb_opaque;
> =20
>      /* if we've signalled device presence to the guest, or if the guest
> @@ -498,8 +496,7 @@ static void reset(DeviceState *d)
>           * force removal if we are
>           */
>          if (drc->awaiting_release) {
> -            drck->detach(drc, DEVICE(drc->dev), drc->detach_cb,
> -                         drc->detach_cb_opaque, NULL);
> +            drck->detach(drc, DEVICE(drc->dev), drc->detach_cb_opaque, N=
ULL);
>          }
> =20
>          /* non-PCI devices may be awaiting a transition to UNUSABLE */
> @@ -566,7 +563,8 @@ static void unrealize(DeviceState *d, Error **errp)
> =20
>  sPAPRDRConnector *spapr_dr_connector_new(Object *owner,
>                                           sPAPRDRConnectorType type,
> -                                         uint32_t id)
> +                                         uint32_t id,
> +                                         spapr_drc_detach_cb *detach_cb)
>  {
>      sPAPRDRConnector *drc =3D
>          SPAPR_DR_CONNECTOR(object_new(TYPE_SPAPR_DR_CONNECTOR));
> @@ -577,6 +575,7 @@ sPAPRDRConnector *spapr_dr_connector_new(Object *owne=
r,
>      drc->type =3D type;
>      drc->id =3D id;
>      drc->owner =3D owner;
> +    drc->detach_cb =3D detach_cb;
>      prop_name =3D g_strdup_printf("dr-connector[%"PRIu32"]", get_index(d=
rc));
>      object_property_add_child(owner, prop_name, OBJECT(drc), NULL);
>      object_property_set_bool(OBJECT(drc), true, "realized", NULL);
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index e7567e2..935e65e 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1392,7 +1392,7 @@ static void spapr_phb_remove_pci_device(sPAPRDRConn=
ector *drc,
>  {
>      sPAPRDRConnectorClass *drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
> =20
> -    drck->detach(drc, DEVICE(pdev), spapr_phb_remove_pci_device_cb, phb,=
 errp);
> +    drck->detach(drc, DEVICE(pdev), phb, errp);
>  }
> =20
>  static sPAPRDRConnector *spapr_phb_get_pci_func_drc(sPAPRPHBState *phb,
> @@ -1764,7 +1764,8 @@ static void spapr_phb_realize(DeviceState *dev, Err=
or **errp)
>          for (i =3D 0; i < PCI_SLOT_MAX * 8; i++) {
>              spapr_dr_connector_new(OBJECT(phb),
>                                     SPAPR_DR_CONNECTOR_TYPE_PCI,
> -                                   (sphb->index << 16) | i);
> +                                   (sphb->index << 16) | i,
> +                                   spapr_phb_remove_pci_device_cb);
>          }
>      }
> =20
> diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
> index 5524247..0a2c173 100644
> --- a/include/hw/ppc/spapr_drc.h
> +++ b/include/hw/ppc/spapr_drc.h
> @@ -189,7 +189,6 @@ typedef struct sPAPRDRConnectorClass {
>      void (*attach)(sPAPRDRConnector *drc, DeviceState *d, void *fdt,
>                     int fdt_start_offset, bool coldplug, Error **errp);
>      void (*detach)(sPAPRDRConnector *drc, DeviceState *d,
> -                   spapr_drc_detach_cb *detach_cb,
>                     void *detach_cb_opaque, Error **errp);
>      bool (*release_pending)(sPAPRDRConnector *drc);
>      void (*set_signalled)(sPAPRDRConnector *drc);
> @@ -197,7 +196,8 @@ typedef struct sPAPRDRConnectorClass {
> =20
>  sPAPRDRConnector *spapr_dr_connector_new(Object *owner,
>                                           sPAPRDRConnectorType type,
> -                                         uint32_t id);
> +                                         uint32_t id,
> +                                         spapr_drc_detach_cb *detach_cb);
>  sPAPRDRConnector *spapr_dr_connector_by_index(uint32_t index);
>  sPAPRDRConnector *spapr_dr_connector_by_id(sPAPRDRConnectorType type,
>                                             uint32_t id);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZCr0jAAoJEGw4ysog2bOS/vcP/A2dfIuK8g6soVbjmUa1Q6Pg
d5xmJmQ5tvm/9RglYxQda4G8lbECbwiStNZ5nrgpxJXMaUPBUAQaRqz/G2fpYtcI
6xQBe+PJON6hmFtDx/d9AOxJwY3JHdV8E2Qxb93Jg+wkJ2eM7yaR++tiZWmtaG/H
oM9FyeOrGNDOnvWZIRdGJzdaolyNCM+Nhm7EM2ivhoERoep0WDobW/ulqMev7CD1
ux3+42dQRh5LuCYvemx7O6W9O0cUYwfP6PFxQCmo6T4FmLqLEf1a5jgD034oUrVQ
ejsDt1COeP73KfFmr/PDUPZEYWVIQL48Pws7if3HcGOZyG0xZ5SmB/Gtmn2LNRy4
Rkq3JISYY0ZCSlPIQROKOiiKPjmtcCWXzXDolaVgU00362hDAiIyvaatKsHq7NUA
6dJKq4x62bNOu/xg0co+qU5wuaXzNvZBKg4m4qARpIB6pTH5LH3198FEcVVuXH81
eTjt3fP/9hiHEcfs2ICC+KcJ1Ky5ktWoTo5Rkwr3tIC/AZ7Lc6kSA5AcCR+j8pcD
xNNC4E55ytUYe83hpEQaL32phnMd3WhAA04gwVbernOyT512POXrk6gpodVqVUl3
0fweUnK/Qpugo1N3TVKvoC3hzqgRBxK0WAzOIxHyZPxcAKhXmwFiibjTvhw+TR2E
PdhmZEQTILQ4HhO87hfo
=6MGI
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
