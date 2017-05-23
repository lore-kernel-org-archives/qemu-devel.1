Received: from eggs.gnu.org ([2001:4830:134:3::10]:40011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dD1Nh-0001Yd-FB
	for qemu-devel@nongnu.org; Tue, 23 May 2017 00:25:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dD1Nf-0002CW-Nd
	for qemu-devel@nongnu.org; Tue, 23 May 2017 00:25:13 -0400
Date: Tue, 23 May 2017 14:07:50 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170523040750.GS30246@umbus.fritz.box>
References: <20170522184039.23877-1-danielhb@linux.vnet.ibm.com>
	<20170522184039.23877-2-danielhb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="psiTe9LjpVyD9953"
Content-Disposition: inline
In-Reply-To: <20170522184039.23877-2-danielhb@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v13] migration: spapr: migrate
 pending_events of spapr state
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


--psiTe9LjpVyD9953
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 22, 2017 at 03:40:39PM -0300, Daniel Henrique Barboza wrote:
> From: Jianjun Duan <duanj@linux.vnet.ibm.com>
>=20
> In racing situations between hotplug events and migration operation,
> a rtas hotplug event could have not yet be delivered to the source
> guest when migration is started. In this case the pending_events of
> spapr state need be transmitted to the target so that the hotplug
> event can be finished on the target.
>=20
> All the different fields of the events are encoded as defined by
> PAPR. We can migrate them as a binary stream inside VBUFFER without
> any concerns about data padding or endianess.
>=20
> pending_events is put in a subsection in the spapr state VMSD to make
> sure migration across different versions is not broken.
>=20
> Signed-off-by: Jianjun Duan <duanj@linux.vnet.ibm.com>
> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
> ---
>  hw/ppc/spapr.c         | 32 ++++++++++++++++++++++++++++++++
>  hw/ppc/spapr_events.c  | 19 +++++++++++++++++++
>  include/hw/ppc/spapr.h |  3 ++-
>  3 files changed, 53 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 75e298b..558f951 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1453,6 +1453,37 @@ static bool version_before_3(void *opaque, int ver=
sion_id)
>      return version_id < 3;
>  }
> =20
> +static bool spapr_pending_events_needed(void *opaque)
> +{
> +    sPAPRMachineState *spapr =3D (sPAPRMachineState *)opaque;
> +    return !QTAILQ_EMPTY(&spapr->pending_events);
> +}
> +
> +static const VMStateDescription vmstate_spapr_event_entry =3D {
> +    .name =3D "spapr_event_log_entry",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_INT32(log_type, sPAPREventLogEntry),
> +        VMSTATE_UINT32(data_size, sPAPREventLogEntry),
> +        VMSTATE_VBUFFER_ALLOC_UINT32(data, sPAPREventLogEntry, 0,
> +                                     NULL, data_size),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
> +static const VMStateDescription vmstate_spapr_pending_events =3D {
> +    .name =3D "spapr_pending_events",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .needed =3D spapr_pending_events_needed,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_QTAILQ_V(pending_events, sPAPRMachineState, 1,
> +                         vmstate_spapr_event_entry, sPAPREventLogEntry, =
next),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
>  static bool spapr_ov5_cas_needed(void *opaque)
>  {
>      sPAPRMachineState *spapr =3D opaque;
> @@ -1551,6 +1582,7 @@ static const VMStateDescription vmstate_spapr =3D {
>      .subsections =3D (const VMStateDescription*[]) {
>          &vmstate_spapr_ov5_cas,
>          &vmstate_spapr_patb_entry,
> +        &vmstate_spapr_pending_events,
>          NULL
>      }
>  };
> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> index 73e2a18..6c42041 100644
> --- a/hw/ppc/spapr_events.c
> +++ b/hw/ppc/spapr_events.c
> @@ -346,10 +346,29 @@ static void rtas_event_log_queue(int log_type, void=
 *data)
>  {
>      sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
>      sPAPREventLogEntry *entry =3D g_new(sPAPREventLogEntry, 1);
> +    struct epow_log_full *new_epow =3D NULL;
> +    struct hp_log_full *new_hp =3D NULL;
> +    uint32_t ext_length =3D 0;
> =20
>      g_assert(data);
>      entry->log_type =3D log_type;
>      entry->data =3D data;
> +
> +    switch (log_type) {
> +    case RTAS_LOG_TYPE_EPOW:
> +        new_epow =3D (struct epow_log_full *)data;
> +        ext_length =3D be32_to_cpu(new_epow->hdr.extended_length);
> +        entry->data_size =3D ext_length + sizeof(new_epow->hdr);
> +        break;
> +    case RTAS_LOG_TYPE_HOTPLUG:
> +        new_hp =3D (struct hp_log_full *)data;
> +        ext_length =3D be32_to_cpu(new_hp->hdr.extended_length);
> +        entry->data_size =3D ext_length + sizeof(new_hp->hdr);
> +        break;
> +    default:
> +        g_assert(false);
> +    }
> +

You're still overcomplicating this.  Both epow_log_full and
hp_log_full start with an rtas_error_log header, which is what
contains the extended_length field.  You can just case data directly
to struct rtas_error_log *, and derive the data size from there.

And.. come to think of it, you don't need the log_type in the vmsd
either, since it can be derived from the summary field in the same
header.

And.. going even further, we could alter the existing code so that
instead of embedding the rtas_error_log header in the allocated
buffer, we could inline it into the sPAPREventLogEntry structure, with
just the extended data in the variable sized buffer.  Then we wouldn't
need a new data_size field, the extended_size field from the
rtas_error_log substructure would already be exactly what we need to
size the buffer.


>      QTAILQ_INSERT_TAIL(&spapr->pending_events, entry, next);
>  }
> =20
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index be2b3b8..b2fcd62 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -598,8 +598,9 @@ struct sPAPRTCETable {
>  sPAPRTCETable *spapr_tce_find_by_liobn(target_ulong liobn);
> =20
>  struct sPAPREventLogEntry {
> -    int log_type;
> +    int32_t log_type;
>      void *data;
> +    uint32_t data_size;
>      QTAILQ_ENTRY(sPAPREventLogEntry) next;
>  };
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--psiTe9LjpVyD9953
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZI7WUAAoJEGw4ysog2bOSFPMP+wUNY232F1Sn+kc1YUkGZbve
hBEgfq6Hnl/gNoWKPCtIwZUnRBLSvY8i3X7MJFj8NoAAAw4HiIMCshsyHYf4Yc7F
GwJCMkpB3LG9Dbl1cuguJFVIjdqicsAOXDNnNOkjBJoW2ml4bDoNhR1jmey8O/Fr
91A9NANUuokHgs0C5nXypE9WDhHHtCkcY7cJwPQNRFPfo1d7HoL50NV80DSVCH5D
+uAISO8aLi/da71kODtLc6cJtLOKkfmZrGANVp1jG4bSHAmAW9OpM/Hg8KTAFTz6
fKgNK3D8N9XQShtvdGcTKNL3KmgHd1/IaHGbp/RX95XrKpNHgyHItv7kYfJzZVEv
URZpqR7QoyNvNlskpWUQ6QSJpp6PzRafkJwE0iD2fW+LUNlGIVEGY+8XloS64LTe
nkSE+XXPnpPVd3y6qDf0+KDsOU7/V0xhNRZBpC0pBWskhgY/HbC281M5l4HXex+Q
BGGRGLuzZmCm+4w32V7Orq/A6yOZ3n3+GOJRtrBt2+eS6l5okJxuJBCln6JW3spp
iGm7grIV1D/i3zWi9jRMinhDcW1xe4lL31JUOeAgfChH1axDcpWf75zBOTR+w1xQ
WwaiPK9+EeZpVrwamYbiZ0pFXPcolTCBdPNtj+QapBlqgku78RrkBdNhoEPwEByW
mtrIKTq6UtZ1UK1kbp5V
=yQrM
-----END PGP SIGNATURE-----

--psiTe9LjpVyD9953--
