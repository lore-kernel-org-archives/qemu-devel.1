Received: from eggs.gnu.org ([2001:4830:134:3::10]:50655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dTN00-00006Y-R9
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 02:44:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dTMzy-0007Nv-CG
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 02:44:20 -0400
Date: Fri, 7 Jul 2017 16:44:07 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170707064407.GC24325@umbus.fritz.box>
References: <20170620184017.17919-1-danielhb@linux.vnet.ibm.com>
	<20170620184017.17919-2-danielhb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NU0Ex4SbNnrxsi6C"
Content-Disposition: inline
In-Reply-To: <20170620184017.17919-2-danielhb@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v14] migration: spapr: migrate
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


--NU0Ex4SbNnrxsi6C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 20, 2017 at 03:40:17PM -0300, Daniel Henrique Barboza wrote:
> In racing situations between hotplug events and migration operation,
> a rtas hotplug event could have not yet be delivered to the source
> guest when migration is started. In this case the pending_events of
> spapr state need be transmitted to the target so that the hotplug
> event can be finished on the target.
>=20
> To achieve the minimal VMSD possible to migrate the pending_events list,
> this patch makes the changes in spapr_events.c:
>=20
> - 'log_type' of sPAPREventLogEntry struct deleted. This information can be
> derived by inspecting the rtas_error_log summary field. A new function
> called 'spapr_event_log_entry_type' was added to retrieve the type of
> a given sPAPREventLogEntry.
>=20
> - sPAPREventLogEntry, epow_log_full and hp_log_full were redesigned. The
> only data we're going to migrate in the VMSD is the event log data itself,
> which can be divided in two parts: a rtas_error_log header and an extended
> event log field. The rtas_error_log header contains information about the
> size of the extended log field, which can be used inside VMSD as the size
> parameter of the VBUFFER_ALOC field that will store it. To allow this use,
> the header.extended_length field must be exposed inline to the VMSD inste=
ad
> of embedded into a 'data' field that holds everything. With this in mind,
> the following changes were done:
>=20
>     * a new 'header' field was added to sPAPREventLogEntry. This field ho=
lds a
> a struct rtas_error_log inline.
>     * the declaration of the 'rtas_error_log' struct was moved to spapr.h
> to be visible to the VMSD macros.
>     * 'data' field of sPAPREventLogEntry was renamed to 'extended_log' and
> now holds only the contents of the extended event log.
>    *  'struct rtas_error_log hdr' were taken away from both epow_log_full
> and hp_log_full. This information is now available at the header field of
> sPAPREventLogEntry.
>    * epow_log_full and hp_log_full were renamed to epow_extended_log and
> hp_extended_log respectively. This rename makes it clearer to understand
> the new purpose of both structures: hold the information of an extended
> event log field.
>     * spapr_powerdown_req and spapr_hotplug_req_event now creates a
> sPAPREventLogEntry structure that contains the full rtas log entry.
>     * rtas_event_log_queue and rtas_event_log_dequeue now receives a
> sPAPREventLogEntry pointer as a parameter instead of a void pointer.
>=20
> - rtas_event_log_queue changes the endianess of the header.extended_length
> from be32 to native. This change is need to allow the VMSD inside spapr.c
> to read the correct size of the entended_log field. As a follow up,
> rtas_event_log_dequeue revert this change before returning the
> sPAPREventLogEntry to the caller.
>=20
> - 'check_exception' now uses a buffer called 'full_log' to store the cont=
ents
> of rtas_error_log and the extended_log. This is need to allow the call to
> cpu_physical_memory_write() to work the same way as it did before - one
> write with a buffer with the whole rtas event log information.
>=20
> - inside spapr.c, pending_events is put in a subsection in the spapr state
> VMSD to make sure migration across different versions is not broken.
>=20
> A small change in rtas_event_log_queue and rtas_event_log_dequeue were al=
so
> made: instead of calling qdev_get_machine(), both functions now receive
> a pointer to the sPAPRMachineState. This pointer is already available in
> the callers of these functions and we don't need to waste resources
> calling qdev() again.
>=20
> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

Concept here is fine, and the implementation is mostly good, but there
are a couple of uglies I really want fixed before merging.

> ---
>  hw/ppc/spapr.c         | 32 +++++++++++++++++
>  hw/ppc/spapr_events.c  | 98 +++++++++++++++++++++++++++++++-------------=
------
>  include/hw/ppc/spapr.h |  9 +++--
>  3 files changed, 101 insertions(+), 38 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index e877d45..28f5c82 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1451,6 +1451,37 @@ static bool version_before_3(void *opaque, int ver=
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
> +        VMSTATE_UINT32(header.summary, sPAPREventLogEntry),
> +        VMSTATE_UINT32(header.extended_length, sPAPREventLogEntry),
> +        VMSTATE_VBUFFER_ALLOC_UINT32(extended_log, sPAPREventLogEntry, 0,
> +                                     NULL, header.extended_length),
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
> @@ -1549,6 +1580,7 @@ static const VMStateDescription vmstate_spapr =3D {
>      .subsections =3D (const VMStateDescription*[]) {
>          &vmstate_spapr_ov5_cas,
>          &vmstate_spapr_patb_entry,
> +        &vmstate_spapr_pending_events,
>          NULL
>      }
>  };
> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> index 171aedc..82b1e66 100644
> --- a/hw/ppc/spapr_events.c
> +++ b/hw/ppc/spapr_events.c
> @@ -42,8 +42,7 @@
>  #include "hw/ppc/spapr_ovec.h"
>  #include <libfdt.h>
> =20
> -struct rtas_error_log {
> -    uint32_t summary;
> +/* Macros related to rtas_error_log struct defined in spapr.h */
>  #define RTAS_LOG_VERSION_MASK                   0xff000000
>  #define   RTAS_LOG_VERSION_6                    0x06000000
>  #define RTAS_LOG_SEVERITY_MASK                  0x00e00000
> @@ -85,8 +84,6 @@ struct rtas_error_log {
>  #define   RTAS_LOG_TYPE_ECC_CORR                0x0000000a
>  #define   RTAS_LOG_TYPE_EPOW                    0x00000040
>  #define   RTAS_LOG_TYPE_HOTPLUG                 0x000000e5
> -    uint32_t extended_length;
> -} QEMU_PACKED;
> =20
>  struct rtas_event_log_v6 {
>      uint8_t b0;
> @@ -166,8 +163,7 @@ struct rtas_event_log_v6_epow {
>      uint64_t reason_code;
>  } QEMU_PACKED;
> =20
> -struct epow_log_full {
> -    struct rtas_error_log hdr;
> +struct epow_extended_log {
>      struct rtas_event_log_v6 v6hdr;
>      struct rtas_event_log_v6_maina maina;
>      struct rtas_event_log_v6_mainb mainb;
> @@ -205,8 +201,7 @@ struct rtas_event_log_v6_hp {
>      union drc_identifier drc_id;
>  } QEMU_PACKED;
> =20
> -struct hp_log_full {
> -    struct rtas_error_log hdr;
> +struct hp_extended_log {
>      struct rtas_event_log_v6 v6hdr;
>      struct rtas_event_log_v6_maina maina;
>      struct rtas_event_log_v6_mainb mainb;
> @@ -341,25 +336,32 @@ static int rtas_event_log_to_irq(sPAPRMachineState =
*spapr, int log_type)
>      return source->irq;
>  }
> =20
> -static void rtas_event_log_queue(int log_type, void *data)
> +static uint32_t spapr_event_log_entry_type(sPAPREventLogEntry *entry)
>  {
> -    sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> -    sPAPREventLogEntry *entry =3D g_new(sPAPREventLogEntry, 1);
> +    return be32_to_cpu(entry->header.summary) & RTAS_LOG_TYPE_MASK;
> +}
> +
> +static void rtas_event_log_queue(sPAPRMachineState *spapr,
> +                                 sPAPREventLogEntry *entry)
> +{
> +    /* Changing header.extended_length to native endianess in
> +     * case a migration occurs and the VMSD needs to read the size
> +     * of the entry->extended_log field.
> +     */
> +    entry->header.extended_length =3D be32_to_cpu(entry->header.extended=
_length);

This is a terrible idea.  Having the same field have different
endianness at different points in its lifecycle makes it _much_ harder
to check if you're doing the right thing, both for humans and for
static checker tools.

Rather than embedding the BE header structure within
sPAPREventLogEntry, just have fields equivalent to the two fields in
the header directly in sPAPREventLogEntry.  These should *always* be
in host native endian (so they are suitable for use with
VMSTATE_VBUFFER_ALLOC).

Then...

> =20
> -    g_assert(data);
> -    entry->log_type =3D log_type;
> -    entry->data =3D data;
>      QTAILQ_INSERT_TAIL(&spapr->pending_events, entry, next);
>  }
> =20
> -static sPAPREventLogEntry *rtas_event_log_dequeue(uint32_t event_mask)
> +static sPAPREventLogEntry *rtas_event_log_dequeue(sPAPRMachineState *spa=
pr,
> +                                                  uint32_t event_mask)
>  {
> -    sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
>      sPAPREventLogEntry *entry =3D NULL;
> =20
>      QTAILQ_FOREACH(entry, &spapr->pending_events, next) {
>          const sPAPREventSource *source =3D
> -            rtas_event_log_to_source(spapr, entry->log_type);
> +            rtas_event_log_to_source(spapr,
> +                                     spapr_event_log_entry_type(entry));
> =20
>          if (source->mask & event_mask) {
>              break;
> @@ -368,6 +370,11 @@ static sPAPREventLogEntry *rtas_event_log_dequeue(ui=
nt32_t event_mask)
> =20
>      if (entry) {
>          QTAILQ_REMOVE(&spapr->pending_events, entry, next);
> +
> +        /* Reverting the endianess change made in rtas_event_log_queue.
> +         */
> +        entry->header.extended_length =3D cpu_to_be32(
> +            entry->header.extended_length);
>      }
> =20
>      return entry;
> @@ -380,7 +387,8 @@ static bool rtas_event_log_contains(uint32_t event_ma=
sk)
> =20
>      QTAILQ_FOREACH(entry, &spapr->pending_events, next) {
>          const sPAPREventSource *source =3D
> -            rtas_event_log_to_source(spapr, entry->log_type);
> +            rtas_event_log_to_source(spapr,
> +                                     spapr_event_log_entry_type(entry));
> =20
>          if (source->mask & event_mask) {
>              return true;
> @@ -428,15 +436,21 @@ static void spapr_init_maina(struct rtas_event_log_=
v6_maina *maina,
>  static void spapr_powerdown_req(Notifier *n, void *opaque)
>  {
>      sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> +    sPAPREventLogEntry *entry;
>      struct rtas_error_log *hdr;
>      struct rtas_event_log_v6 *v6hdr;
>      struct rtas_event_log_v6_maina *maina;
>      struct rtas_event_log_v6_mainb *mainb;
>      struct rtas_event_log_v6_epow *epow;
> -    struct epow_log_full *new_epow;
> +    struct epow_extended_log *new_epow;
> =20
> +    entry =3D g_new(sPAPREventLogEntry, 1);
>      new_epow =3D g_malloc0(sizeof(*new_epow));
> -    hdr =3D &new_epow->hdr;
> +    g_assert(entry);
> +    g_assert(new_epow);
> +    entry->extended_log =3D new_epow;
> +
> +    hdr =3D &entry->header;
>      v6hdr =3D &new_epow->v6hdr;
>      maina =3D &new_epow->maina;
>      mainb =3D &new_epow->mainb;
> @@ -447,8 +461,7 @@ static void spapr_powerdown_req(Notifier *n, void *op=
aque)
>                                 | RTAS_LOG_DISPOSITION_NOT_RECOVERED
>                                 | RTAS_LOG_OPTIONAL_PART_PRESENT
>                                 | RTAS_LOG_TYPE_EPOW);
> -    hdr->extended_length =3D cpu_to_be32(sizeof(*new_epow)
> -                                       - sizeof(new_epow->hdr));
> +    hdr->extended_length =3D cpu_to_be32(sizeof(*new_epow));

=2E..rather than constructing the header per se, just set the event log
fields directly, in native endian...

>      spapr_init_v6hdr(v6hdr);
>      spapr_init_maina(maina, 3 /* Main-A, Main-B and EPOW */);
> @@ -468,7 +481,7 @@ static void spapr_powerdown_req(Notifier *n, void *op=
aque)
>      epow->event_modifier =3D RTAS_LOG_V6_EPOW_MODIFIER_NORMAL;
>      epow->extended_modifier =3D RTAS_LOG_V6_EPOW_XMODIFIER_PARTITION_SPE=
CIFIC;
> =20
> -    rtas_event_log_queue(RTAS_LOG_TYPE_EPOW, new_epow);
> +    rtas_event_log_queue(spapr, entry);
> =20
>      qemu_irq_pulse(xics_get_qirq(XICS_FABRIC(spapr),
>                                   rtas_event_log_to_irq(spapr,
> @@ -487,15 +500,21 @@ static void spapr_hotplug_req_event(uint8_t hp_id, =
uint8_t hp_action,
>                                      union drc_identifier *drc_id)
>  {
>      sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> -    struct hp_log_full *new_hp;
> +    sPAPREventLogEntry *entry;
> +    struct hp_extended_log *new_hp;
>      struct rtas_error_log *hdr;
>      struct rtas_event_log_v6 *v6hdr;
>      struct rtas_event_log_v6_maina *maina;
>      struct rtas_event_log_v6_mainb *mainb;
>      struct rtas_event_log_v6_hp *hp;
> =20
> -    new_hp =3D g_malloc0(sizeof(struct hp_log_full));
> -    hdr =3D &new_hp->hdr;
> +    entry =3D g_new(sPAPREventLogEntry, 1);
> +    new_hp =3D g_malloc0(sizeof(struct hp_extended_log));
> +    g_assert(entry);
> +    g_assert(new_hp);
> +    entry->extended_log =3D new_hp;
> +
> +    hdr =3D &entry->header;
>      v6hdr =3D &new_hp->v6hdr;
>      maina =3D &new_hp->maina;
>      mainb =3D &new_hp->mainb;
> @@ -507,8 +526,7 @@ static void spapr_hotplug_req_event(uint8_t hp_id, ui=
nt8_t hp_action,
>                                 | RTAS_LOG_OPTIONAL_PART_PRESENT
>                                 | RTAS_LOG_INITIATOR_HOTPLUG
>                                 | RTAS_LOG_TYPE_HOTPLUG);
> -    hdr->extended_length =3D cpu_to_be32(sizeof(*new_hp)
> -                                       - sizeof(new_hp->hdr));
> +    hdr->extended_length =3D cpu_to_be32(sizeof(*new_hp));
> =20
>      spapr_init_v6hdr(v6hdr);
>      spapr_init_maina(maina, 3 /* Main-A, Main-B, HP */);
> @@ -561,7 +579,7 @@ static void spapr_hotplug_req_event(uint8_t hp_id, ui=
nt8_t hp_action,
>              cpu_to_be32(drc_id->count_indexed.index);
>      }
> =20
> -    rtas_event_log_queue(RTAS_LOG_TYPE_HOTPLUG, new_hp);
> +    rtas_event_log_queue(spapr, entry);
> =20
>      qemu_irq_pulse(xics_get_qirq(XICS_FABRIC(spapr),
>                                   rtas_event_log_to_irq(spapr,
> @@ -635,10 +653,10 @@ static void check_exception(PowerPCCPU *cpu, sPAPRM=
achineState *spapr,
>                              target_ulong args,
>                              uint32_t nret, target_ulong rets)
>  {
> -    uint32_t mask, buf, len, event_len;
> +    uint32_t mask, buf, len, event_len, extended_len;
>      uint64_t xinfo;
> +    uint8_t *full_log;
>      sPAPREventLogEntry *event;
> -    struct rtas_error_log *hdr;
>      int i;
> =20
>      if ((nargs < 6) || (nargs > 7) || nret !=3D 1) {
> @@ -654,21 +672,29 @@ static void check_exception(PowerPCCPU *cpu, sPAPRM=
achineState *spapr,
>          xinfo |=3D (uint64_t)rtas_ld(args, 6) << 32;
>      }
> =20
> -    event =3D rtas_event_log_dequeue(mask);
> +    event =3D rtas_event_log_dequeue(spapr, mask);
>      if (!event) {
>          goto out_no_events;
>      }
> =20
> -    hdr =3D event->data;
> -    event_len =3D be32_to_cpu(hdr->extended_length) + sizeof(*hdr);
> +    extended_len =3D be32_to_cpu(event->header.extended_length);
> +    event_len =3D extended_len + sizeof(event->header);

=2E.and when you deliver the event to the guest, only then construct the
BE header structure from the native fields in sPAPREventLog.

>      if (event_len < len) {
>          len =3D event_len;
>      }
> =20
> -    cpu_physical_memory_write(buf, event->data, len);
> +    full_log =3D g_malloc0(event_len);
> +    g_assert(full_log);
> +
> +    memcpy(full_log, &event->header, sizeof(event->header));
> +    memcpy(full_log + sizeof(event->header), event->extended_log,
> +           extended_len);

Constructing the whole log in a buffer is also unnecessary.

> +
> +    cpu_physical_memory_write(buf, full_log, len);

You can just write the header fields to the guest with stl_phys() and
similar, then copy in the "extended" log at the appropriate offset
using cpu_physical_memory_write().

>      rtas_st(rets, 0, RTAS_OUT_SUCCESS);
> -    g_free(event->data);
> +    g_free(full_log);
> +    g_free(event->extended_log);
>      g_free(event);
> =20
>      /* according to PAPR+, the IRQ must be left asserted, or re-asserted=
, if
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index f973b02..9432b64 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -598,9 +598,14 @@ struct sPAPRTCETable {
> =20
>  sPAPRTCETable *spapr_tce_find_by_liobn(target_ulong liobn);
> =20
> +struct rtas_error_log {
> +    uint32_t summary;
> +    uint32_t extended_length;
> +} QEMU_PACKED;
> +
>  struct sPAPREventLogEntry {
> -    int log_type;
> -    void *data;
> +    struct rtas_error_log header;
> +    void *extended_log;
>      QTAILQ_ENTRY(sPAPREventLogEntry) next;
>  };
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--NU0Ex4SbNnrxsi6C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZXy2yAAoJEGw4ysog2bOS3yoP/2HEgFMNqnJPXjoq8R/qEVDS
AaZEYdUgvdzrB7dCcbLr+jf66f8V+kEYM4BkXSnO/BZaPkmZrJBLS1r9u7hsLObO
D9w1X+ZjHTdEiBCs8tyh4geeDV07cCO8VSn7Ey/a27f8WhOx2Io9cZzctWLgJJfH
WHaPUNFQGSgGd4pq9EfwFiOrlVCF0x6x9bu2Vu4M/oUKqheUM0exMBnvyBD2NEXH
ZITKRai5D4yEmswTu1+TmKjGzjR8Uqt9fgn0wRy48Kj8xIjWZFP/dWqfSRaFxdA4
WUTORXq81Yw+e1eFtc5+Nuyr4G4W7M6md46545YxRWcnXJiCAi4GMd6UWvxtUC/7
p7QmxOzVB6bJIxlJJtxAeaPDlIVHTHOkI6QElxxCwDt/MXCwnYmmy16IUTQBVOY/
QfYoqzovGPz3rRHWkURwdfmDajlLtjhBpNwUkrh65hUHCHLGPwrzueJKomQu77d9
Buu1T0gFaNloID0u93nLTMOArIo1VgSFme1pXz5ldrzo2QRywt8RjI2hyJqR0xdT
tf1yzGm29YbWsb9amkpSLFrKhn4ewp9mau0yqq2OKYuaEt+RsIw/SmTV+dGi3t4n
6jNPxLsxCM8qp5cbsJZC8WLBAunkgntoZa3gdKKE4fMy3iyaFGYQwGtntJDlKGni
sirCor5PC8qAxsSjlRN4
=tYYF
-----END PGP SIGNATURE-----

--NU0Ex4SbNnrxsi6C--
