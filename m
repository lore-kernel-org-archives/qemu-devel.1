Received: from eggs.gnu.org ([2001:4830:134:3::10]:46262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dBXiP-0001Yd-ST
	for qemu-devel@nongnu.org; Thu, 18 May 2017 22:32:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dBXiM-00026j-Pb
	for qemu-devel@nongnu.org; Thu, 18 May 2017 22:32:29 -0400
Date: Fri, 19 May 2017 12:32:16 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170519023216.GD12284@umbus.fritz.box>
References: <20170518202402.12571-1-danielhb@linux.vnet.ibm.com>
	<20170518202402.12571-3-danielhb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="C1iGAkRnbeBonpVg"
Content-Disposition: inline
In-Reply-To: <20170518202402.12571-3-danielhb@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v11 2/2] migration: spapr: migrate
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


--C1iGAkRnbeBonpVg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 18, 2017 at 05:24:02PM -0300, Daniel Henrique Barboza wrote:
> From: Jianjun Duan <duanj@linux.vnet.ibm.com>
>=20
> In racing situations between hotplug events and migration operation,
> a rtas hotplug event could have not yet be delivered to the source
> guest when migration is started. In this case the pending_events of
> spapr state need be transmitted to the target so that the hotplug
> event can be finished on the target.
>=20
> All the different fields of the events are encoded as defined by
> PAPR. We can migrate them as uint8_t binary stream without any
> concerns about data padding or endianess.
>=20
> pending_events is put in a subsection in the spapr state VMSD to make
> sure migration across different versions is not broken.
>=20
> Signed-off-by: Jianjun Duan <duanj@linux.vnet.ibm.com>
> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
> ---
>  hw/ppc/spapr.c         | 32 ++++++++++++++++++++++++++++++++
>  hw/ppc/spapr_events.c  |  1 +
>  include/hw/ppc/spapr.h |  3 ++-
>  3 files changed, 35 insertions(+), 1 deletion(-)
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
> index 73e2a18..96c1605 100644
> --- a/hw/ppc/spapr_events.c
> +++ b/hw/ppc/spapr_events.c
> @@ -350,6 +350,7 @@ static void rtas_event_log_queue(int log_type, void *=
data)
>      g_assert(data);
>      entry->log_type =3D log_type;
>      entry->data =3D data;
> +    entry->data_size =3D sizeof(*data);

This can't be right, since data is a void*.  I'm surprised it even
compiles.  You'll need to actually look into the data buffer here and
extract the size field.

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

--C1iGAkRnbeBonpVg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZHlkvAAoJEGw4ysog2bOSxgMP/jbrS9R+9B2awTgRlr7pb354
W5mq+Zc44/3eluttGlThhP4V4rp7P83z8rUgfkxNL+/l0zoL97Eb0vO+6QUSeZw/
eRYz8DKqVcoSOzchhUTILXOHSjrvIEXah6Q5ioMr+PQM9fW7TIIpctB2AR8s3KM4
SvH1hFqVjPYJ4t4QS0bu1+8SkTJoeeBmYlB9m23JeC8Fzvy/mqIfOJzHVsP6uVmD
/fzUozETgCj90HWt+h2CN4N+vvagAJnNAoRYhBauG/7ECgbsPuSQUiSX2Om8Izwk
Su8xae+1/aDIkOkSbTR9yYA18IqY/fbhHLgpGcACMWATmY3re3hje0ys+T0fUeF9
wnxI/ng/XK7u/dr5YIh+S574eKfxxbPNZl2kK+35FYFDrzQLajNxcDNtVp/jG39s
K8WvJCLhl+3Wl6vaMNA7rWjBraUz3f6EU4YoJL50/2CQ01uUvwexgmrRQc99/zFo
+RkuHgQRBJVNRVKDbdivlDRWfWIVv1vVXj4dXXaVaYsYl5fFvIZopkSGNg93LijD
lyDc5Z2F6BFzXbMoxjucCcV5Cj6LyTLZJ1iisgIR9pfskEppQvcO5RmwoTXVAYN4
WPbRS+N3TZgGkU5iO5dH+ygM5Eclw0OFM69GlvHOEJDx151jJgtk3yL4TwRKo+RX
kx/kJ7xLMZiylu81rNAh
=VpjX
-----END PGP SIGNATURE-----

--C1iGAkRnbeBonpVg--
