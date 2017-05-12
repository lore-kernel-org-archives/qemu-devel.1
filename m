Received: from eggs.gnu.org ([2001:4830:134:3::10]:47790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d94R2-0005ev-Bz
	for qemu-devel@nongnu.org; Fri, 12 May 2017 02:52:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d94R0-0006no-K2
	for qemu-devel@nongnu.org; Fri, 12 May 2017 02:52:20 -0400
Date: Fri, 12 May 2017 16:28:36 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170512062836.GI12908@umbus.fritz.box>
References: <20170505204746.14116-1-danielhb@linux.vnet.ibm.com>
	<20170505204746.14116-7-danielhb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="byLs0wutDcxFdwtm"
Content-Disposition: inline
In-Reply-To: <20170505204746.14116-7-danielhb@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v9 6/6] migration: spapr: migrate
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


--byLs0wutDcxFdwtm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 05, 2017 at 05:47:46PM -0300, Daniel Henrique Barboza wrote:
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

This seems like it's probably a good idea, even independent of the
hotplug migration stuff.  I suspect there are other races where we
could lose a shutdown event or similar if there's a migration.

> ---
>  hw/ppc/spapr.c         | 33 +++++++++++++++++++++++++++++++++
>  hw/ppc/spapr_events.c  | 24 +++++++++++++-----------
>  include/hw/ppc/spapr.h |  3 ++-
>  3 files changed, 48 insertions(+), 12 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index bc56249..e924fd4 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1498,6 +1498,38 @@ static const VMStateDescription vmstate_spapr_ccs_=
list =3D {
>      },
>  };
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

This requires changing the actual type to int32_t in the structure.

> +        VMSTATE_BOOL(exception, sPAPREventLogEntry),

So, at the moment, AFAICT every event is marked as exception =3D=3D true,
so this doesn't actually tell us anything.   If that becomes not the
case in future, can the exception flag be derived from the log_type or
information in the even buffer?

> +        VMSTATE_UINT32(data_size, sPAPREventLogEntry),
> +        VMSTATE_VARRAY_UINT32_ALLOC(data, sPAPREventLogEntry, data_size,
> +                                    0, vmstate_info_uint8, uint8_t),

So, data_size duplicates information that's in the event header, which
is a bit sad.  I suppose I'm ok with that, since setting up the VARRAY
thing is going to be pretty awkward otherwise.

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
> @@ -1598,6 +1630,7 @@ static const VMStateDescription vmstate_spapr =3D {
>          &vmstate_spapr_patb_entry,
>          &vmstate_spapr_pending_dimm_unplugs,
>          &vmstate_spapr_ccs_list,
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
> +                                 int data_size)
>  {
>      sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
>      sPAPREventLogEntry *entry =3D g_new(sPAPREventLogEntry, 1);
> @@ -351,6 +352,7 @@ static void rtas_event_log_queue(int log_type, void *=
data, bool exception)
>      entry->log_type =3D log_type;
>      entry->exception =3D exception;
>      entry->data =3D data;
> +    entry->data_size =3D data_size;

I think it would make more sense to derive data_size from the buffer
header contents here, rather than in all the callers.

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
> index adc9fdb..ddac014 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -603,7 +603,8 @@ sPAPRTCETable *spapr_tce_find_by_liobn(target_ulong l=
iobn);
>  struct sPAPREventLogEntry {
>      int log_type;
>      bool exception;
> -    void *data;
> +    uint8_t *data;

I think you can avoid this type change (and the casts it requires) by
using VBUFFER instead of VARRAY.

> +    uint32_t data_size;
>      QTAILQ_ENTRY(sPAPREventLogEntry) next;
>  };
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--byLs0wutDcxFdwtm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZFVYRAAoJEGw4ysog2bOSJLwQAOUxmX1I6op3lDD85aIV+Xzd
WNC5DwiIXhNJzIJG/lMhnz976/M0YuonBlVsUUdsrCFeX2ygS5od1BQ6x+Rq+gST
NgGgfMiVw+L6EJN63qTiLCok5yyY+qurm3cdg7g0ne+3jwo+s3RptcE7+k9OLwM1
zRs7a9X+aapLcjZ0hm+VvoqiOyQDmpRx75NZBI/yjP7EwnZUOYrYpQ9CCcu7RRs0
PfRc8jeZYh75S0mB9U/S4SYfPysob24524YJRvausnotr9HHr0CGdffp6/hu3M8c
EJS6xNm9O0j9a4jKkoy4PsF7csMm9rxbyJqJYWYI1EE608wtcTP7xEV+FpY8eRGj
fypLxkk0wMd7/WbZ/NfKbrWHN0wMfMNzZRXkiMSCDLXesxTBJmipr7hYZ+FYNZVk
pzB/XUiQ6wZGTKtsMRaAJNRn1/BBPhkyZo6lpR1M6SmnLcpunh2eBJ4NTuJW9z1G
hTcoXcTAWywYPeIt9cKomB1thIPjpalSl1rX/qdKmmLvOrslP3pVGBma1XfIA/+B
h0rjgKJhnrXC3bbdLtQPnDugvfyJjRwp+Crcyu2dnocPwKtElCa+ahr+oLFy3OBb
og3MjiZGLI3y4sLRPxIxv5+IBlh9pO1dOtnav/6xXvZzexqxMX6Ar1/Oi+U+BVnI
A85svz7yv0u83tpLFbSc
=i6M5
-----END PGP SIGNATURE-----

--byLs0wutDcxFdwtm--
