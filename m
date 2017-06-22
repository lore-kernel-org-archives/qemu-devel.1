Received: from eggs.gnu.org ([2001:4830:134:3::10]:59240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dNyTV-0004vu-LN
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 05:32:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dNyTS-0005gc-H0
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 05:32:29 -0400
Received: from 12.mo5.mail-out.ovh.net ([46.105.39.65]:53182)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dNyTS-0005gI-7r
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 05:32:26 -0400
Received: from player695.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 3D4F710C51C
	for <qemu-devel@nongnu.org>; Thu, 22 Jun 2017 11:32:24 +0200 (CEST)
Date: Thu, 22 Jun 2017 11:32:15 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170622113215.146bc3b8@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <20170621091848.28256-3-david@gibson.dropbear.id.au>
References: <20170621091848.28256-1-david@gibson.dropbear.id.au>
	<20170621091848.28256-3-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/CRB+M1_rDiIAJS5NBPBa+nt";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH 2/5] spapr: Refactor spapr_drc_detach()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: mdroth@linux.vnet.ibm.com, bharata@linux.vnet.ibm.com, sursingh@redhat.com, lvivier@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

--Sig_/CRB+M1_rDiIAJS5NBPBa+nt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 21 Jun 2017 17:18:45 +0800
David Gibson <david@gibson.dropbear.id.au> wrote:

> This function has two unused parameters - remove them.
>=20

It's ok for the d argument but I'm not sure about errp... Indeed it isn't u=
sed
in the current code, but looking at the paths below spapr_drc_detach(), we
have:

spapr_drc_detach()
 spapr_drc_release()
  spapr_core_release()
   hotplug_handler_unplug(hotplug_ctrl, dev, &error_abort);

and

spapr_drc_detach()
 spapr_drc_release()
  spapr_lmb_release()
   hotplug_handler_unplug(hotplug_ctrl, dev, &error_abort);

Shouldn't we pass the errp down to hotplug_handler_unplug() instead of
aborting ?

> It also sets awaiting_release on all paths, except one.  On that path
> setting it is harmless, since it will be immediately cleared by
> spapr_drc_release().  So factor it out of the if statements.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/ppc/spapr.c             |  9 ++-------
>  hw/ppc/spapr_drc.c         | 12 ++++++------
>  hw/ppc/spapr_pci.c         |  7 +------
>  include/hw/ppc/spapr_drc.h |  2 +-
>  4 files changed, 10 insertions(+), 20 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 5aa3760..8b5ab3a 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2827,7 +2827,7 @@ static void spapr_memory_unplug_request(HotplugHand=
ler *hotplug_dev,
>                                addr / SPAPR_MEMORY_BLOCK_SIZE);
>          g_assert(drc);
> =20
> -        spapr_drc_detach(drc, dev, errp);
> +        spapr_drc_detach(drc);
>          addr +=3D SPAPR_MEMORY_BLOCK_SIZE;
>      }
> =20
> @@ -2902,7 +2902,6 @@ void spapr_core_unplug_request(HotplugHandler *hotp=
lug_dev, DeviceState *dev,
>  {
>      int index;
>      sPAPRDRConnector *drc;
> -    Error *local_err =3D NULL;
>      CPUCore *cc =3D CPU_CORE(dev);
>      int smt =3D kvmppc_smt_threads();
> =20
> @@ -2919,11 +2918,7 @@ void spapr_core_unplug_request(HotplugHandler *hot=
plug_dev, DeviceState *dev,
>      drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_CPU, index * smt);
>      g_assert(drc);
> =20
> -    spapr_drc_detach(drc, dev, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> -        return;
> -    }
> +    spapr_drc_detach(drc);
> =20
>      spapr_hotplug_req_remove_by_index(drc);
>  }
> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> index 59e19f8..dae1f79 100644
> --- a/hw/ppc/spapr_drc.c
> +++ b/hw/ppc/spapr_drc.c
> @@ -70,7 +70,7 @@ static uint32_t drc_isolate_physical(sPAPRDRConnector *=
drc)
>          uint32_t drc_index =3D spapr_drc_index(drc);
>          if (drc->configured) {
>              trace_spapr_drc_set_isolation_state_finalizing(drc_index);
> -            spapr_drc_detach(drc, DEVICE(drc->dev), NULL);
> +            spapr_drc_detach(drc);
>          } else {
>              trace_spapr_drc_set_isolation_state_deferring(drc_index);
>          }
> @@ -134,7 +134,7 @@ static uint32_t drc_isolate_logical(sPAPRDRConnector =
*drc)
>          uint32_t drc_index =3D spapr_drc_index(drc);
>          if (drc->configured) {
>              trace_spapr_drc_set_isolation_state_finalizing(drc_index);
> -            spapr_drc_detach(drc, DEVICE(drc->dev), NULL);
> +            spapr_drc_detach(drc);
>          } else {
>              trace_spapr_drc_set_isolation_state_deferring(drc_index);
>          }
> @@ -187,7 +187,7 @@ static uint32_t drc_set_unusable(sPAPRDRConnector *dr=
c)
>      if (drc->awaiting_release) {
>          uint32_t drc_index =3D spapr_drc_index(drc);
>          trace_spapr_drc_set_allocation_state_finalizing(drc_index);
> -        spapr_drc_detach(drc, DEVICE(drc->dev), NULL);
> +        spapr_drc_detach(drc);
>      }
> =20
>      return RTAS_OUT_SUCCESS;
> @@ -371,20 +371,20 @@ static void spapr_drc_release(sPAPRDRConnector *drc)
>      drc->dev =3D NULL;
>  }
> =20
> -void spapr_drc_detach(sPAPRDRConnector *drc, DeviceState *d, Error **err=
p)
> +void spapr_drc_detach(sPAPRDRConnector *drc)
>  {
>      trace_spapr_drc_detach(spapr_drc_index(drc));
> =20
> +    drc->awaiting_release =3D true;
> +
>      if (drc->isolation_state !=3D SPAPR_DR_ISOLATION_STATE_ISOLATED) {
>          trace_spapr_drc_awaiting_isolated(spapr_drc_index(drc));
> -        drc->awaiting_release =3D true;
>          return;
>      }
> =20
>      if (spapr_drc_type(drc) !=3D SPAPR_DR_CONNECTOR_TYPE_PCI &&
>          drc->allocation_state !=3D SPAPR_DR_ALLOCATION_STATE_UNUSABLE) {
>          trace_spapr_drc_awaiting_unusable(spapr_drc_index(drc));
> -        drc->awaiting_release =3D true;
>          return;
>      }
> =20
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index bda8938..af925c0 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1476,7 +1476,6 @@ static void spapr_pci_unplug_request(HotplugHandler=
 *plug_handler,
>      PCIDevice *pdev =3D PCI_DEVICE(plugged_dev);
>      sPAPRDRConnectorClass *drck;
>      sPAPRDRConnector *drc =3D spapr_phb_get_pci_drc(phb, pdev);
> -    Error *local_err =3D NULL;
> =20
>      if (!phb->dr_enabled) {
>          error_setg(errp, QERR_BUS_NO_HOTPLUG,
> @@ -1514,11 +1513,7 @@ static void spapr_pci_unplug_request(HotplugHandle=
r *plug_handler,
>              }
>          }
> =20
> -        spapr_drc_detach(drc, DEVICE(pdev), &local_err);
> -        if (local_err) {
> -            error_propagate(errp, local_err);
> -            return;
> -        }
> +        spapr_drc_detach(drc);
> =20
>          /* if this isn't func 0, defer unplug event. otherwise signal re=
moval
>           * for all present functions
> diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
> index 42c3722..ab64235 100644
> --- a/include/hw/ppc/spapr_drc.h
> +++ b/include/hw/ppc/spapr_drc.h
> @@ -234,6 +234,6 @@ int spapr_drc_populate_dt(void *fdt, int fdt_offset, =
Object *owner,
> =20
>  void spapr_drc_attach(sPAPRDRConnector *drc, DeviceState *d, void *fdt,
>                        int fdt_start_offset, Error **errp);
> -void spapr_drc_detach(sPAPRDRConnector *drc, DeviceState *d, Error **err=
p);
> +void spapr_drc_detach(sPAPRDRConnector *drc);
> =20
>  #endif /* HW_SPAPR_DRC_H */


--Sig_/CRB+M1_rDiIAJS5NBPBa+nt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAllLjp8ACgkQAvw66wEB28LuXwCfbnDxQM1OCsvDzF5fxQQC5G7l
2U8AnimRhkwpWLvZs7g205KhNMo7LokP
=60Hr
-----END PGP SIGNATURE-----

--Sig_/CRB+M1_rDiIAJS5NBPBa+nt--
