Received: from eggs.gnu.org ([2001:4830:134:3::10]:46790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dNc5x-0006vu-NK
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 05:38:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dNc5u-0004FG-JT
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 05:38:41 -0400
Received: from 1.mo5.mail-out.ovh.net ([188.165.57.91]:42422)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dNc5u-0004EU-92
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 05:38:38 -0400
Received: from player695.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 9ECBE1086AE
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 11:38:35 +0200 (CEST)
Date: Wed, 21 Jun 2017 11:38:28 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170621113828.2663ecb8@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <20170620015332.13874-5-david@gibson.dropbear.id.au>
References: <20170620015332.13874-1-david@gibson.dropbear.id.au>
	<20170620015332.13874-5-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/louZ4obJ/OAWom4Z=L0V+pi";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH 4/5] spapr: Remove unnecessary differences
 between hotplug and coldplug paths
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: mdroth@linux.vnet.ibm.com, bharata@linux.vnet.ibm.com, sursingh@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

--Sig_/louZ4obJ/OAWom4Z=L0V+pi
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 20 Jun 2017 09:53:31 +0800
David Gibson <david@gibson.dropbear.id.au> wrote:

> spapr_drc_attach() has a 'coldplug' parameter which sets the DRC into
> configured state initially, instead of the usual ISOLATED/UNUSABLE state.
> It turns out this is unnecessary: although coldplugged devices do need to
> be in CONFIGURED state once the guest starts, that will already be
> accomplished by the reset code which will move DRCs for already plugged
> devices into a coldplug equivalent state.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr.c             | 13 +++----------
>  hw/ppc/spapr_drc.c         |  5 ++---
>  hw/ppc/spapr_pci.c         |  3 +--
>  include/hw/ppc/spapr_drc.h |  2 +-
>  4 files changed, 7 insertions(+), 16 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index f12bc4d..35f2d4b 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2611,7 +2611,7 @@ static void spapr_add_lmbs(DeviceState *dev, uint64=
_t addr_start, uint64_t size,
>          fdt_offset =3D spapr_populate_memory_node(fdt, node, addr,
>                                                  SPAPR_MEMORY_BLOCK_SIZE);
> =20
> -        spapr_drc_attach(drc, dev, fdt, fdt_offset, !dev->hotplugged, er=
rp);
> +        spapr_drc_attach(drc, dev, fdt, fdt_offset, errp);
>          addr +=3D SPAPR_MEMORY_BLOCK_SIZE;
>      }
>      /* send hotplug notification to the
> @@ -2955,17 +2955,10 @@ static void spapr_core_plug(HotplugHandler *hotpl=
ug_dev, DeviceState *dev,
> =20
>      g_assert(drc || !mc->has_hotpluggable_cpus);
> =20
> -    /*
> -     * Setup CPU DT entries only for hotplugged CPUs. For boot time or
> -     * coldplugged CPUs DT entries are setup in spapr_build_fdt().
> -     */
> -    if (dev->hotplugged) {
> -        fdt =3D spapr_populate_hotplug_cpu_dt(cs, &fdt_offset, spapr);
> -    }
> +    fdt =3D spapr_populate_hotplug_cpu_dt(cs, &fdt_offset, spapr);
> =20
>      if (drc) {
> -        spapr_drc_attach(drc, dev, fdt, fdt_offset, !dev->hotplugged,
> -                         &local_err);
> +        spapr_drc_attach(drc, dev, fdt, fdt_offset, &local_err);
>          if (local_err) {
>              g_free(fdt);
>              error_propagate(errp, local_err);
> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> index 32e39f2..e70879a 100644
> --- a/hw/ppc/spapr_drc.c
> +++ b/hw/ppc/spapr_drc.c
> @@ -340,7 +340,7 @@ static void prop_get_fdt(Object *obj, Visitor *v, con=
st char *name,
>  }
> =20
>  void spapr_drc_attach(sPAPRDRConnector *drc, DeviceState *d, void *fdt,
> -                      int fdt_start_offset, bool coldplug, Error **errp)
> +                      int fdt_start_offset, Error **errp)
>  {
>      trace_spapr_drc_attach(spapr_drc_index(drc));
> =20
> @@ -351,12 +351,11 @@ void spapr_drc_attach(sPAPRDRConnector *drc, Device=
State *d, void *fdt,
>      if (spapr_drc_type(drc) =3D=3D SPAPR_DR_CONNECTOR_TYPE_PCI) {
>          g_assert(drc->allocation_state =3D=3D SPAPR_DR_ALLOCATION_STATE_=
USABLE);
>      }
> -    g_assert(fdt || coldplug);
> +    g_assert(fdt);
> =20
>      drc->dev =3D d;
>      drc->fdt =3D fdt;
>      drc->fdt_start_offset =3D fdt_start_offset;
> -    drc->configured =3D coldplug;
> =20
>      if (spapr_drc_type(drc) !=3D SPAPR_DR_CONNECTOR_TYPE_PCI) {
>          drc->awaiting_allocation =3D true;
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 0b447f2..f2543ef 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1435,8 +1435,7 @@ static void spapr_phb_hot_plug_child(HotplugHandler=
 *plug_handler,
>          goto out;
>      }
> =20
> -    spapr_drc_attach(drc, DEVICE(pdev), fdt, fdt_start_offset,
> -                     !plugged_dev->hotplugged, &local_err);
> +    spapr_drc_attach(drc, DEVICE(pdev), fdt, fdt_start_offset, &local_er=
r);
>      if (local_err) {
>          goto out;
>      }
> diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
> index 6fd84d1..d15e9eb 100644
> --- a/include/hw/ppc/spapr_drc.h
> +++ b/include/hw/ppc/spapr_drc.h
> @@ -234,7 +234,7 @@ int spapr_drc_populate_dt(void *fdt, int fdt_offset, =
Object *owner,
>                            uint32_t drc_type_mask);
> =20
>  void spapr_drc_attach(sPAPRDRConnector *drc, DeviceState *d, void *fdt,
> -                      int fdt_start_offset, bool coldplug, Error **errp);
> +                      int fdt_start_offset, Error **errp);
>  void spapr_drc_detach(sPAPRDRConnector *drc, DeviceState *d, Error **err=
p);
> =20
>  #endif /* HW_SPAPR_DRC_H */


--Sig_/louZ4obJ/OAWom4Z=L0V+pi
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAllKPpQACgkQAvw66wEB28JMZwCeI1EZX5+dxVJmvsEwO6ZL0UBX
BecAn2gs1DI3dcafXCLmLQVFi3kiN8/4
=GyUU
-----END PGP SIGNATURE-----

--Sig_/louZ4obJ/OAWom4Z=L0V+pi--
