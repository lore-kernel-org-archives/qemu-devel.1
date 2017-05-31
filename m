Received: from eggs.gnu.org ([2001:4830:134:3::10]:41123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dFvjZ-0002KR-TZ
	for qemu-devel@nongnu.org; Wed, 31 May 2017 00:59:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dFvjW-0004ef-PZ
	for qemu-devel@nongnu.org; Wed, 31 May 2017 00:59:49 -0400
Date: Wed, 31 May 2017 14:35:57 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170531043557.GI12163@umbus.fritz.box>
References: <20170530160445.12810-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="U3s59FfKcByyGl+j"
Content-Disposition: inline
In-Reply-To: <20170530160445.12810-1-lvivier@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] spapr: manage hotplugged devices while the
 VM is not started
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--U3s59FfKcByyGl+j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 30, 2017 at 06:04:45PM +0200, Laurent Vivier wrote:
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

So, I think this is a reasonable concept, at least in terms of
cleanliness and not doing unnecessary work.  However, if it's fixing
bugs, I suspect that means we still have problems elsewhere.

Specifically, what is it we're doing before the incoming migration
that's breaking things.  Even if it's unnecessary, anything done there
should be overwritten by the incoming stream.  That should certainly
be the case (now) for the DRC state variables.  Maybe not for the
queued hotplug events - but that means we should update the queue
migration to make sure we clear anything existing on the destination
before adding migrated events.

I'm also concerned by the fact that this makes changes for memory and
cpu hotplug, but not for PCI devices.  Why aren't they also affected
by this problem?

One nit in the implementation, see below:

> ---
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

It probably doesn't matter in practice, but in this specific instance,
I think you want the "raw" qemu meaning of hotplugged rather than the
spapr meaning.

>          error_setg(&local_err, "CPU hotplug not supported for this machi=
ne");
>          goto out;
>      }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--U3s59FfKcByyGl+j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZLkgtAAoJEGw4ysog2bOSPzkQAMgpjWWZSE363e/zINUlNwWP
3QdSbwEyS+QRr5uCyF0DFCSoo/by+8/ftrr5ZzXocTZQ+WINc87k0Qk0uafFCzmh
uzfMlaFMyKNvVB8rUhKQsMTLaZTsnxbODegg2QP2wYkxeRFogo30Pm1YTVqjsnBv
iY0hLu6+04Rh+nOy4KHIUwvX1S/Xb6Ibf9WCMBbBkKRab43oENpeYcWQhsEHpQoe
tWocF0eRW3yB3kAE3HITrzUFiPTpq2UQ3QyFA8SH8bGx2rtiW4bfenANZcdyfpV4
O93jGBhQFavQEto1itcpFbWf0EwW9ISFR+7UjlfQ/Q6S/F89jYYpMewRBDLaWYCA
zjICdXTOC9ncsiwKTaoxmqlmGb50NOP5vx/WJoJrKNArivnaZWzbzkCX6HL1cyZN
zeox+ij7TUz30wYLGc4W0adGaSG4zbZGRoAhZpS7wIJDFCGx+YhHSP5T/oAWsu5c
s/SjY36jESweA9acQSSIGakoxEM963t7U8hKmytGOgOMfqRFpaP1tBAQRin7wsOk
RIN4BQub8UmTKSn0F/R2ywGZy13rxFuDAHDO3Mah4ELLvVYTO1XVOR0vOUlwYNTc
X6nxpsrFRRFLJq0LX9MOvqhWmOcG8bTBJ6xLiqlG5cCu+oNoGKQ9hXf7dlOpaodD
CDjsnwGqQn0NDsZJzRKu
=OYYR
-----END PGP SIGNATURE-----

--U3s59FfKcByyGl+j--
