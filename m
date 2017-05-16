Received: from eggs.gnu.org ([2001:4830:134:3::10]:45564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dAU2v-00025z-NI
	for qemu-devel@nongnu.org; Tue, 16 May 2017 00:25:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dAU2u-0007UX-3I
	for qemu-devel@nongnu.org; Tue, 16 May 2017 00:25:17 -0400
Date: Tue, 16 May 2017 14:25:01 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170516042501.GC30022@umbus.fritz.box>
References: <20170515131052.23457-1-danielhb@linux.vnet.ibm.com>
	<20170515131052.23457-2-danielhb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NKoe5XOeduwbEQHU"
Content-Disposition: inline
In-Reply-To: <20170515131052.23457-2-danielhb@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v10] migration: spapr: migrate
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


--NKoe5XOeduwbEQHU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 15, 2017 at 10:10:52AM -0300, Daniel Henrique Barboza wrote:
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

Ok, thanks for splitting this out, but you don't seem to have
addressed the other comments I had on this patch as presented before.

> ---
>  hw/ppc/spapr.c         | 33 +++++++++++++++++++++++++++++++++
>  hw/ppc/spapr_events.c  | 24 +++++++++++++-----------
>  include/hw/ppc/spapr.h |  3 ++-
>  3 files changed, 48 insertions(+), 12 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 80d12d0..8cfdc71 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1437,6 +1437,38 @@ static bool version_before_3(void *opaque, int ver=
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
> +        VMSTATE_BOOL(exception, sPAPREventLogEntry),

I'd like some more information to convince me there isn't redundant
data here.

> +        VMSTATE_UINT32(data_size, sPAPREventLogEntry),
> +        VMSTATE_VARRAY_UINT32_ALLOC(data, sPAPREventLogEntry, data_size,
> +                                    0, vmstate_info_uint8, uint8_t),

And I think this should be VBUFFER rather than VARRAY to avoid the
data type change.

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
> @@ -1535,6 +1567,7 @@ static const VMStateDescription vmstate_spapr =3D {
>      .subsections =3D (const VMStateDescription*[]) {
>          &vmstate_spapr_ov5_cas,
>          &vmstate_spapr_patb_entry,
> +        &vmstate_spapr_pending_events,
>          NULL
>      }
>  };
> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> index f0b28d8..70c7cfc 100644
> --- a/hw/ppc/spapr_events.c
> +++ b/hw/ppc/spapr_events.c
> @@ -342,7 +342,8 @@ static int rtas_event_log_to_irq(sPAPRMachineState *s=
papr, int log_type)
>      return source->irq;
>  }
> =20
> -static void rtas_event_log_queue(int log_type, void *data, bool exceptio=
n)
> +static void rtas_event_log_queue(int log_type, void *data, bool exceptio=
n,
 +                                 int data_size)

This could derive data_size from the header passed in.

>  {
>      sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
>      sPAPREventLogEntry *entry =3D g_new(sPAPREventLogEntry, 1);
> @@ -351,6 +352,7 @@ static void rtas_event_log_queue(int log_type, void *=
data, bool exception)
>      entry->log_type =3D log_type;
>      entry->exception =3D exception;
>      entry->data =3D data;
> +    entry->data_size =3D data_size;
>      QTAILQ_INSERT_TAIL(&spapr->pending_events, entry, next);
>  }
> =20
> @@ -445,6 +447,7 @@ static void spapr_powerdown_req(Notifier *n, void *op=
aque)
>      struct rtas_event_log_v6_mainb *mainb;
>      struct rtas_event_log_v6_epow *epow;
>      struct epow_log_full *new_epow;
> +    uint32_t data_size;
> =20
>      new_epow =3D g_malloc0(sizeof(*new_epow));
>      hdr =3D &new_epow->hdr;
> @@ -453,14 +456,13 @@ static void spapr_powerdown_req(Notifier *n, void *=
opaque)
>      mainb =3D &new_epow->mainb;
>      epow =3D &new_epow->epow;
> =20
> +    data_size =3D sizeof(*new_epow);
>      hdr->summary =3D cpu_to_be32(RTAS_LOG_VERSION_6
>                                 | RTAS_LOG_SEVERITY_EVENT
>                                 | RTAS_LOG_DISPOSITION_NOT_RECOVERED
>                                 | RTAS_LOG_OPTIONAL_PART_PRESENT
>                                 | RTAS_LOG_TYPE_EPOW);
> -    hdr->extended_length =3D cpu_to_be32(sizeof(*new_epow)
> -                                       - sizeof(new_epow->hdr));
> -
> +    hdr->extended_length =3D cpu_to_be32(data_size - sizeof(new_epow->hd=
r));
>      spapr_init_v6hdr(v6hdr);
>      spapr_init_maina(maina, 3 /* Main-A, Main-B and EPOW */);
> =20
> @@ -479,7 +481,7 @@ static void spapr_powerdown_req(Notifier *n, void *op=
aque)
>      epow->event_modifier =3D RTAS_LOG_V6_EPOW_MODIFIER_NORMAL;
>      epow->extended_modifier =3D RTAS_LOG_V6_EPOW_XMODIFIER_PARTITION_SPE=
CIFIC;
> =20
> -    rtas_event_log_queue(RTAS_LOG_TYPE_EPOW, new_epow, true);
> +    rtas_event_log_queue(RTAS_LOG_TYPE_EPOW, new_epow, true, data_size);
> =20
>      qemu_irq_pulse(xics_get_qirq(XICS_FABRIC(spapr),
>                                   rtas_event_log_to_irq(spapr,
> @@ -504,6 +506,7 @@ static void spapr_hotplug_req_event(uint8_t hp_id, ui=
nt8_t hp_action,
>      struct rtas_event_log_v6_maina *maina;
>      struct rtas_event_log_v6_mainb *mainb;
>      struct rtas_event_log_v6_hp *hp;
> +    uint32_t data_size;
> =20
>      new_hp =3D g_malloc0(sizeof(struct hp_log_full));
>      hdr =3D &new_hp->hdr;
> @@ -512,14 +515,14 @@ static void spapr_hotplug_req_event(uint8_t hp_id, =
uint8_t hp_action,
>      mainb =3D &new_hp->mainb;
>      hp =3D &new_hp->hp;
> =20
> +    data_size =3D sizeof(*new_hp);
>      hdr->summary =3D cpu_to_be32(RTAS_LOG_VERSION_6
>                                 | RTAS_LOG_SEVERITY_EVENT
>                                 | RTAS_LOG_DISPOSITION_NOT_RECOVERED
>                                 | RTAS_LOG_OPTIONAL_PART_PRESENT
>                                 | RTAS_LOG_INITIATOR_HOTPLUG
>                                 | RTAS_LOG_TYPE_HOTPLUG);
> -    hdr->extended_length =3D cpu_to_be32(sizeof(*new_hp)
> -                                       - sizeof(new_hp->hdr));
> +    hdr->extended_length =3D cpu_to_be32(data_size - sizeof(new_hp->hdr)=
);
> =20
>      spapr_init_v6hdr(v6hdr);
>      spapr_init_maina(maina, 3 /* Main-A, Main-B, HP */);
> @@ -572,7 +575,7 @@ static void spapr_hotplug_req_event(uint8_t hp_id, ui=
nt8_t hp_action,
>              cpu_to_be32(drc_id->count_indexed.index);
>      }
> =20
> -    rtas_event_log_queue(RTAS_LOG_TYPE_HOTPLUG, new_hp, true);
> +    rtas_event_log_queue(RTAS_LOG_TYPE_HOTPLUG, new_hp, true, data_size);
> =20
>      qemu_irq_pulse(xics_get_qirq(XICS_FABRIC(spapr),
>                                   rtas_event_log_to_irq(spapr,
> @@ -671,8 +674,7 @@ static void check_exception(PowerPCCPU *cpu, sPAPRMac=
hineState *spapr,
>      if (!event) {
>          goto out_no_events;
>      }
> -
> -    hdr =3D event->data;
> +    hdr =3D (struct rtas_error_log *)event->data;
>      event_len =3D be32_to_cpu(hdr->extended_length) + sizeof(*hdr);
> =20
>      if (event_len < len) {
> @@ -728,7 +730,7 @@ static void event_scan(PowerPCCPU *cpu, sPAPRMachineS=
tate *spapr,
>          goto out_no_events;
>      }
> =20
> -    hdr =3D event->data;
> +    hdr =3D (struct rtas_error_log *)event->data;
>      event_len =3D be32_to_cpu(hdr->extended_length) + sizeof(*hdr);
> =20
>      if (event_len < len) {
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 5802f88..fbe1d93 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -599,7 +599,8 @@ sPAPRTCETable *spapr_tce_find_by_liobn(target_ulong l=
iobn);
>  struct sPAPREventLogEntry {
>      int log_type;
>      bool exception;
> -    void *data;
> +    uint8_t *data;
> +    uint32_t data_size;
>      QTAILQ_ENTRY(sPAPREventLogEntry) next;
>  };
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--NKoe5XOeduwbEQHU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZGn8dAAoJEGw4ysog2bOSvngP/0v4eWS4fJPiXl5ptkcNixoh
VaE/0WT1TsTCEimLnPP5SKtQNLEBJ/sPVtuoAMsGWZnBmf5kx43ZRqOjb5qUaVjn
/SaBs5EBQzFqW8iLUG8EGuhersrop4IZixJcznNgZk5Cipfan05fLcYLzKJpPoYc
vn2rWXvcoHrCEdqSx+m5N1VJ5ihBekDtgJNqHWuu0cbSJF4cX2vQwKcGDNQ1pZ0B
gHftXyYcvnxFlsuxnA9wWEWVs+D9oN0r6Qgi8JCcOdZNzffNMbebpHWjaiL3QwQX
71qcY9zJgd0n0ChKWjSE6Hv5nkzOM4mQynaNMQZ428DQptZiaZLX5j9sNwf1ouNB
PzRD7hJmRrUR08T686g4/p2DqkuW3gUKLdxw+5bq+mOm5RsVojuGYJnSUUiL7dXI
tl2bZCAd+FrPQeNB9PHyLA3O7uXZr9it5OKI4G5ZsMD8CQ3IRXPtWNsc5eP4ooBc
Xl+ejlEoQQ5FkUE/TNWuZwRBRlktiTWd54cDGRVZddhwZZ42u0/DgCE8duKm75yP
uhl75v2Xl6IjqLEv+Bgr8wkhKuDNDm0BiLiwGusgymwEiA0mI7+fGX7Y/5mhjphP
Hj2fr1ZKNSrwRPUFIqkaV8rCghynWQyBjQCtfWCJ+tjqGP11Bs19nkqQeAHrGY99
B8ZRFnbfkmqdsWg/p6Ay
=EW0J
-----END PGP SIGNATURE-----

--NKoe5XOeduwbEQHU--
