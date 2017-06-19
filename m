Received: from eggs.gnu.org ([2001:4830:134:3::10]:35855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dMtrw-0007zQ-Ea
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 06:25:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dMtrt-0002vF-7G
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 06:25:16 -0400
Received: from 1.mo179.mail-out.ovh.net ([178.33.111.220]:40535)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dMtrs-0002um-U5
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 06:25:13 -0400
Received: from player716.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 2370D498E1
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 12:25:11 +0200 (CEST)
Date: Mon, 19 Jun 2017 12:25:02 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170619122502.37faeedc@bahia.ttt.fr.ibm.com>
In-Reply-To: <20170608050930.2613-5-david@gibson.dropbear.id.au>
References: <20170608050930.2613-1-david@gibson.dropbear.id.au>
	<20170608050930.2613-5-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/Ie3p+=AzpG_hVUcJr15J9nT";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH 4/6] spapr: Make DRC reset force DRC into
 known state
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

--Sig_/Ie3p+=AzpG_hVUcJr15J9nT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu,  8 Jun 2017 15:09:28 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> The reset handler for DRCs attempts several state transitions which are
> subject to various checks and restrictions.  But at reset time we know
> there is no guest, so we can ignore most of the usual sequencing rules and
> just set the DRC back to a known state.  In fact, it's safer to do so.
>=20
> The existing code also has several redundant checks for
> drc->awaiting_release inside a block which has already tested that.  This
> patch removes those and sets the DRC to a fixed initial state based only
> on whether a device is currently plugged or not.
>=20
> With DRCs correctly reset to a state based on device presence, we don't
> need to force state transitions as cold plugged devices are processed.
> This allows us to remove all the callers of the set_*_state() methods from
> outside spapr_drc.c.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr.c     | 15 ---------------
>  hw/ppc/spapr_drc.c | 28 ++++++++--------------------
>  2 files changed, 8 insertions(+), 35 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 01dda9e..c988e38 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2545,12 +2545,6 @@ static void spapr_add_lmbs(DeviceState *dev, uint6=
4_t addr_start, uint64_t size,
> =20
>          spapr_drc_attach(drc, dev, fdt, fdt_offset, !dev->hotplugged, er=
rp);
>          addr +=3D SPAPR_MEMORY_BLOCK_SIZE;
> -        if (!dev->hotplugged) {
> -            sPAPRDRConnectorClass *drck =3D SPAPR_DR_CONNECTOR_GET_CLASS=
(drc);
> -            /* guests expect coldplugged LMBs to be pre-allocated */
> -            drck->set_allocation_state(drc, SPAPR_DR_ALLOCATION_STATE_US=
ABLE);
> -            drck->set_isolation_state(drc, SPAPR_DR_ISOLATION_STATE_UNIS=
OLATED);
> -        }
>      }
>      /* send hotplug notification to the
>       * guest only in case of hotplugged memory
> @@ -2901,15 +2895,6 @@ static void spapr_core_plug(HotplugHandler *hotplu=
g_dev, DeviceState *dev,
>           * of hotplugged CPUs.
>           */
>          spapr_hotplug_req_add_by_index(drc);
> -    } else {
> -        /*
> -         * Set the right DRC states for cold plugged CPU.
> -         */
> -        if (drc) {
> -            sPAPRDRConnectorClass *drck =3D SPAPR_DR_CONNECTOR_GET_CLASS=
(drc);
> -            drck->set_allocation_state(drc, SPAPR_DR_ALLOCATION_STATE_US=
ABLE);
> -            drck->set_isolation_state(drc, SPAPR_DR_ISOLATION_STATE_UNIS=
OLATED);
> -        }
>      }
>      core_slot->cpu =3D OBJECT(dev);
>  }
> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> index dc4ac77..7e17f34 100644
> --- a/hw/ppc/spapr_drc.c
> +++ b/hw/ppc/spapr_drc.c
> @@ -393,7 +393,6 @@ static bool release_pending(sPAPRDRConnector *drc)
>  static void reset(DeviceState *d)
>  {
>      sPAPRDRConnector *drc =3D SPAPR_DR_CONNECTOR(d);
> -    sPAPRDRConnectorClass *drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
> =20
>      trace_spapr_drc_reset(spapr_drc_index(drc));
> =20
> @@ -401,28 +400,17 @@ static void reset(DeviceState *d)
>      drc->ccs =3D NULL;
> =20
>      /* immediately upon reset we can safely assume DRCs whose devices
> -     * are pending removal can be safely removed, and that they will
> -     * subsequently be left in an ISOLATED state. move the DRC to this
> -     * state in these cases (which will in turn complete any pending
> -     * device removals)
> +     * are pending removal can be safely removed.
>       */
>      if (drc->awaiting_release) {
> -        drck->set_isolation_state(drc, SPAPR_DR_ISOLATION_STATE_ISOLATED=
);
> -        /* generally this should also finalize the removal, but if the d=
evice
> -         * hasn't yet been configured we normally defer removal under the
> -         * assumption that this transition is taking place as part of de=
vice
> -         * configuration. so check if we're still waiting after this, and
> -         * force removal if we are
> -         */
> -        if (drc->awaiting_release) {
> -            spapr_drc_detach(drc, DEVICE(drc->dev), NULL);
> -        }
> +        spapr_drc_release(drc);
> +    }
> =20
> -        /* non-PCI devices may be awaiting a transition to UNUSABLE */
> -        if (spapr_drc_type(drc) !=3D SPAPR_DR_CONNECTOR_TYPE_PCI &&
> -            drc->awaiting_release) {
> -            drck->set_allocation_state(drc, SPAPR_DR_ALLOCATION_STATE_UN=
USABLE);
> -        }
> +    drc->isolation_state =3D drc->dev ? SPAPR_DR_ISOLATION_STATE_UNISOLA=
TED
> +        : SPAPR_DR_ISOLATION_STATE_ISOLATED;
> +    if (spapr_drc_type(drc) !=3D SPAPR_DR_CONNECTOR_TYPE_PCI) {
> +        drc->allocation_state =3D drc->dev ? SPAPR_DR_ALLOCATION_STATE_U=
SABLE
> +            : SPAPR_DR_ALLOCATION_STATE_UNUSABLE;
>      }
>  }
> =20


--Sig_/Ie3p+=AzpG_hVUcJr15J9nT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAllHpn4ACgkQAvw66wEB28L7yQCgmOQBVL23EzX4/jUn97wA/386
Re0Ani6RsbDR4quiT1VqrHPOc11GAYLA
=qYWW
-----END PGP SIGNATURE-----

--Sig_/Ie3p+=AzpG_hVUcJr15J9nT--
