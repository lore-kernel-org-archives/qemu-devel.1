Received: from eggs.gnu.org ([2001:4830:134:3::10]:39504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dCNsK-00060c-Lq
	for qemu-devel@nongnu.org; Sun, 21 May 2017 06:14:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dCNsJ-0001NU-Es
	for qemu-devel@nongnu.org; Sun, 21 May 2017 06:14:12 -0400
Date: Sat, 20 May 2017 16:30:59 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170520063059.GB30246@umbus.fritz.box>
References: <20170519142750.18437-1-danielhb@linux.vnet.ibm.com>
	<20170519142750.18437-3-danielhb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NDin8bjvE/0mNLFQ"
Content-Disposition: inline
In-Reply-To: <20170519142750.18437-3-danielhb@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v12 2/2] migration: spapr: migrate
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


--NDin8bjvE/0mNLFQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 19, 2017 at 11:27:50AM -0300, Daniel Henrique Barboza wrote:
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
>  hw/ppc/spapr_events.c  | 12 ++++++++++++
>  include/hw/ppc/spapr.h |  3 ++-
>  3 files changed, 46 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 0980d73..5afd328 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1444,6 +1444,37 @@ static bool version_before_3(void *opaque, int ver=
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
> @@ -1542,6 +1573,7 @@ static const VMStateDescription vmstate_spapr =3D {
>      .subsections =3D (const VMStateDescription*[]) {
>          &vmstate_spapr_ov5_cas,
>          &vmstate_spapr_patb_entry,
> +        &vmstate_spapr_pending_events,
>          NULL
>      }
>  };
> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> index 73e2a18..a509c46 100644
> --- a/hw/ppc/spapr_events.c
> +++ b/hw/ppc/spapr_events.c
> @@ -350,6 +350,18 @@ static void rtas_event_log_queue(int log_type, void =
*data)
>      g_assert(data);
>      entry->log_type =3D log_type;
>      entry->data =3D data;
> +
> +    switch (log_type) {
> +    case RTAS_LOG_TYPE_EPOW:
> +        entry->data_size =3D sizeof(struct epow_log_full);
> +        break;
> +    case RTAS_LOG_TYPE_HOTPLUG:
> +        entry->data_size =3D sizeof(struct hp_log_full);
> +        break;
> +    default:
> +        g_assert(false);
> +    }

You can do better than this.  The header of the event has an
'extended_length' field which is set (correctly) by the existing
functions creating the events.  You'll need to add the base/common
header size back in, but that's easy.

That's how the guest determines the size of the events once they
arrive, and that's what you should use here as well.

> +
>      QTAILQ_INSERT_TAIL(&spapr->pending_events, entry, next);
>  }
> =20
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 02239a5..0554e11 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -597,8 +597,9 @@ struct sPAPRTCETable {
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

--NDin8bjvE/0mNLFQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZH+KjAAoJEGw4ysog2bOSq5MP/0gIYZhnIXhbK/Q8T2T154zu
Zwq+l8UqQE9v1a2lthzvT77D58sG+YdyovAUc6YNVxtlk1WTs3FyDije0fuagdZm
p08fcAercao6o+aOKtwhMEPSGAnNv5D+PGkNBuVFrs9FiIiTKzP9++/annyGxv3+
vhB/XDb5Hf0jJOuSnoAZSQw5DQTmHGI3Bt6R6Yt50feUqAtigwY8tWFVCMbpioZC
Hk/BlGJoFBtv1SqP5gkI2M9pgSbi+MTfsjX6p5D627GfGhyfOj9a6DIrEd4za9Vn
Fw6LaRjQwDDYrVgmAXedKizH27jZVHtqX8c0AkrnNsfHzHmc1ndFY3RdcOJaR05z
o+jYpAfTrHzo063hIO/p8AowiUgUJb33iM7nv92dlMcIyKhJAvzwHErfjacGqxoQ
Rah5pbv1hyEvJJ4htR1TqNi52MARAJx2UQ8m22XGoDmvAaP4NFKoyXjuTwDDVV1U
AoIBFT619bB5FHszNwtk1IN0bj9R/3id7QH2eEiy9YAeH+u90lEyjok63KRVVkt4
MHpnh4CSG0HjHCgqQJW45SxoSMnI9F6Z8ZMfw8nSbM88mSMMLlAFQ4zvg8Eb99Y0
a/30xCG+KPzOvsg1cGuMogcU27Ll16cZ3gfNgAX9VdCCiLwWFS0geZQWNsboKH7Y
SaaHN5wYCmUaJuRQ3TFM
=OM3i
-----END PGP SIGNATURE-----

--NDin8bjvE/0mNLFQ--
