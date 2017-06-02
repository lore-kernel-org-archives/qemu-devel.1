Received: from eggs.gnu.org ([2001:4830:134:3::10]:45425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dGh7q-0004MU-DD
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 03:36:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dGh7n-0001if-5Z
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 03:36:02 -0400
Date: Fri, 2 Jun 2017 17:35:48 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170602073548.GP13397@umbus.fritz.box>
References: <20170531092516.5112-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NDuspjMMC1Ui5ypn"
Content-Disposition: inline
In-Reply-To: <20170531092516.5112-1-lvivier@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] spapr: manage hotplugged devices while
 the VM is not started
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>


--NDuspjMMC1Ui5ypn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 31, 2017 at 11:25:16AM +0200, Laurent Vivier wrote:
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
> v2:
> - don't replace dev->hotplugged to test if CPU hotplug
>   is supported.

So, this addresses the specific points mentioned on the last version,
but not the wider query: what exactly in the previous behaviour was
causing problems.

On a related note, having better understood the DRC code while writing
my cleanups, I'm reconsidering your earlier suggestion of simply
disabling hotplugs until after CAS.

I rejected that approach before because I was assuming the problem was
due to hotplug events being lost, and I was confident that CAS marked
a transition from losing to not-losing events (other than by
accident).  However, later discussions have shown that the problem is
more to do with device tree updates being essentially duplicated
between the DT given to the guest during CAS and further updates from
hotplug events.

On that new understanding CAS does seem like a logical watershed,
since it's the point at which the guest gets the final version of the
"cold plugged" device tree.  I still have some concerns about the
details, but the basic approach seems sound.

Sorry for the misdirection.

>=20
>  hw/ppc/spapr.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index ab3aab1..f0c543c 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2521,6 +2521,12 @@ static void spapr_nmi(NMIState *n, int cpu_index, =
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
> @@ -2531,6 +2537,7 @@ static void spapr_add_lmbs(DeviceState *dev, uint64=
_t addr_start, uint64_t size,
>      int i, fdt_offset, fdt_size;
>      void *fdt;
>      uint64_t addr =3D addr_start;
> +    bool coldplugged =3D spapr_coldplugged(dev);
> =20
>      for (i =3D 0; i < nr_lmbs; i++) {
>          drc =3D spapr_dr_connector_by_id(SPAPR_DR_CONNECTOR_TYPE_LMB,
> @@ -2542,9 +2549,9 @@ static void spapr_add_lmbs(DeviceState *dev, uint64=
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
> @@ -2553,7 +2560,7 @@ static void spapr_add_lmbs(DeviceState *dev, uint64=
_t addr_start, uint64_t size,
>      /* send hotplug notification to the
>       * guest only in case of hotplugged memory
>       */
> -    if (dev->hotplugged) {
> +    if (!coldplugged) {
>          if (dedicated_hp_event_source) {
>              drc =3D spapr_dr_connector_by_id(SPAPR_DR_CONNECTOR_TYPE_LMB,
>                      addr_start / SPAPR_MEMORY_BLOCK_SIZE);
> @@ -2867,6 +2874,7 @@ static void spapr_core_plug(HotplugHandler *hotplug=
_dev, DeviceState *dev,
>      int smt =3D kvmppc_smt_threads();
>      CPUArchId *core_slot;
>      int index;
> +    bool coldplugged =3D spapr_coldplugged(dev);
> =20
>      core_slot =3D spapr_find_cpu_slot(MACHINE(hotplug_dev), cc->core_id,=
 &index);
>      if (!core_slot) {
> @@ -2888,7 +2896,7 @@ static void spapr_core_plug(HotplugHandler *hotplug=
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
> @@ -2896,7 +2904,7 @@ static void spapr_core_plug(HotplugHandler *hotplug=
_dev, DeviceState *dev,
>          }
>      }
> =20
> -    if (dev->hotplugged) {
> +    if (!coldplugged) {
>          /*
>           * Send hotplug notification interrupt to the guest only in case
>           * of hotplugged CPUs.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--NDuspjMMC1Ui5ypn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZMRVRAAoJEGw4ysog2bOSmb0QAMYWR6QNHtq63znBJcNlNGH4
90hLgA27TTsGV+rACqDrG4c9qkIclwLGiGVknXtvU7PIimrSsUP86gxvfB1rpYss
9kX6xRiseKnEiekMQtfQ9fsXIdcqGwQdNWKQrAeZ3moVxbQuDr8N8CxOEHgSGpwf
Vrt8YsrvzSwtKXQLRa3nba1xQRNoOuOh3k1IwDcxp4wlwOWG0YKzTrrlbYMIhSWF
2GRRljL/tl6ZebaQMgh9ymhieCalPNjl9gR8q+6WXmdhuzJbuUETE5tXyyArM7VH
eTnzMlck3osYhfrHK6Ayp0oBAS+s/+wGAOUz6egnqEXV/oV8MgqaKVsptgmFBdxU
sNGFDtlqmVi/U2X2MfURq3VmXDdLeV8qwLDhprkVfzkyMqEsTW8AKHKszZusOjNb
384WRDmH8j+lLT06kbOQ8BwWDF9QM6XpuAkMUPwkCiJHdFgxYIlCIBgnGYnuCbyY
74O29NbYXP+96uez6LrwTOUcZ4Z+Ei5eBwFc+Nan7SG15R/Fhp4xTJ6iyMa81F2H
7n+YF5bAfUz7OAbUfu5HxNR5J3Azqfsnjrnk1+6J0kiBsk5/8x3bn9sMkB4aeghV
MzafBjW+OUKMODVBfm4gWwx9TFXQ4NNHC5Sr6iD1Aie+s4AiXzGSmKSiSPiD9ePw
eFXb+MJvALY+gLgsavOC
=fAUA
-----END PGP SIGNATURE-----

--NDuspjMMC1Ui5ypn--
