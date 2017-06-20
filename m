Received: from eggs.gnu.org ([2001:4830:134:3::10]:51074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dNM5P-0008Nt-9H
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 12:33:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dNM5M-0003Xp-21
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 12:33:03 -0400
Received: from 7.mo68.mail-out.ovh.net ([46.105.63.230]:44298)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dNM5L-0003XN-Oe
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 12:32:59 -0400
Received: from player789.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 38A515DECE
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 18:32:57 +0200 (CEST)
Date: Tue, 20 Jun 2017 18:32:49 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170620183249.3d67141e@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <20170620015332.13874-3-david@gibson.dropbear.id.au>
References: <20170620015332.13874-1-david@gibson.dropbear.id.au>
	<20170620015332.13874-3-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/THPh/gBSEnqqImDzA7IddaP";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH 2/5] spapr: Uniform DRC reset paths
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

--Sig_/THPh/gBSEnqqImDzA7IddaP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 20 Jun 2017 09:53:29 +0800
David Gibson <david@gibson.dropbear.id.au> wrote:

> DRC objects have a regular device reset method.  However, it only gets
> called in the usual way for PCI DRCs.  Because of where CPU and LMB DRCs
> are in the QOM tree, their device reset method isn't automatically called.
> So, the machine manually registers reset handlers to call device_reset().
>=20
> This patch removes the device reset method, and instead always explicitly
> registers the reset handler from realize().  This means the callers don't
> have to worry about the two cases, and we always get proper resets.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

This indeed simplifies the code. It also has the interesting effect that
nobody cares for the return value of spapr_dr_connector_new() anymore.

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr.c     | 31 ++++---------------------------
>  hw/ppc/spapr_drc.c |  6 +++---
>  2 files changed, 7 insertions(+), 30 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 8a0c247..f12bc4d 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1967,24 +1967,6 @@ static void spapr_boot_set(void *opaque, const cha=
r *boot_device,
>      machine->boot_order =3D g_strdup(boot_device);
>  }
> =20
> -/*
> - * Reset routine for LMB DR devices.
> - *
> - * Unlike PCI DR devices, LMB DR devices explicitly register this reset
> - * routine. Reset for PCI DR devices will be handled by PHB reset routine
> - * when it walks all its children devices. LMB devices reset occurs
> - * as part of spapr_ppc_reset().
> - */
> -static void spapr_drc_reset(void *opaque)
> -{
> -    sPAPRDRConnector *drc =3D opaque;
> -    DeviceState *d =3D DEVICE(drc);
> -
> -    if (d) {
> -        device_reset(d);
> -    }
> -}
> -
>  static void spapr_create_lmb_dr_connectors(sPAPRMachineState *spapr)
>  {
>      MachineState *machine =3D MACHINE(spapr);
> @@ -1993,13 +1975,11 @@ static void spapr_create_lmb_dr_connectors(sPAPRM=
achineState *spapr)
>      int i;
> =20
>      for (i =3D 0; i < nr_lmbs; i++) {
> -        sPAPRDRConnector *drc;
>          uint64_t addr;
> =20
>          addr =3D i * lmb_size + spapr->hotplug_memory.base;
> -        drc =3D spapr_dr_connector_new(OBJECT(spapr), TYPE_SPAPR_DRC_LMB,
> -                                     addr/lmb_size);
> -        qemu_register_reset(spapr_drc_reset, drc);
> +        spapr_dr_connector_new(OBJECT(spapr), TYPE_SPAPR_DRC_LMB,
> +                               addr / lmb_size);
>      }
>  }
> =20
> @@ -2093,11 +2073,8 @@ static void spapr_init_cpus(sPAPRMachineState *spa=
pr)
>          int core_id =3D i * smp_threads;
> =20
>          if (mc->has_hotpluggable_cpus) {
> -            sPAPRDRConnector *drc =3D
> -                spapr_dr_connector_new(OBJECT(spapr), TYPE_SPAPR_DRC_CPU,
> -                                       (core_id / smp_threads) * smt);
> -
> -            qemu_register_reset(spapr_drc_reset, drc);
> +            spapr_dr_connector_new(OBJECT(spapr), TYPE_SPAPR_DRC_CPU,
> +                                   (core_id / smp_threads) * smt);
>          }
> =20
>          if (i < boot_cores_nr) {
> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> index 0bc9046..e5dff16 100644
> --- a/hw/ppc/spapr_drc.c
> +++ b/hw/ppc/spapr_drc.c
> @@ -426,9 +426,9 @@ static bool release_pending(sPAPRDRConnector *drc)
>      return drc->awaiting_release;
>  }
> =20
> -static void reset(DeviceState *d)
> +static void drc_reset(void *opaque)
>  {
> -    sPAPRDRConnector *drc =3D SPAPR_DR_CONNECTOR(d);
> +    sPAPRDRConnector *drc =3D SPAPR_DR_CONNECTOR(opaque);
> =20
>      trace_spapr_drc_reset(spapr_drc_index(drc));
> =20
> @@ -536,6 +536,7 @@ static void realize(DeviceState *d, Error **errp)
>      g_free(child_name);
>      vmstate_register(DEVICE(drc), spapr_drc_index(drc), &vmstate_spapr_d=
rc,
>                       drc);
> +    qemu_register_reset(drc_reset, drc);
>      trace_spapr_drc_realize_complete(spapr_drc_index(drc));
>  }
> =20
> @@ -594,7 +595,6 @@ static void spapr_dr_connector_class_init(ObjectClass=
 *k, void *data)
>      DeviceClass *dk =3D DEVICE_CLASS(k);
>      sPAPRDRConnectorClass *drck =3D SPAPR_DR_CONNECTOR_CLASS(k);
> =20
> -    dk->reset =3D reset;
>      dk->realize =3D realize;
>      dk->unrealize =3D unrealize;
>      drck->release_pending =3D release_pending;

 	 =09

--Sig_/THPh/gBSEnqqImDzA7IddaP
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAllJTjEACgkQAvw66wEB28JkiwCfUvah1/QnTHiHI83JpDULMepL
xMwAmwUahAVmiujm05dXyNDqEixVCu/o
=t86h
-----END PGP SIGNATURE-----

--Sig_/THPh/gBSEnqqImDzA7IddaP--
