Received: from eggs.gnu.org ([2001:4830:134:3::10]:46266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dBXiP-0001Yf-TK
	for qemu-devel@nongnu.org; Thu, 18 May 2017 22:32:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dBXiM-00026i-Q4
	for qemu-devel@nongnu.org; Thu, 18 May 2017 22:32:29 -0400
Date: Fri, 19 May 2017 12:26:43 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170519022643.GC12284@umbus.fritz.box>
References: <20170518202402.12571-1-danielhb@linux.vnet.ibm.com>
	<20170518202402.12571-2-danielhb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DSayHWYpDlRfCAAQ"
Content-Disposition: inline
In-Reply-To: <20170518202402.12571-2-danielhb@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v11 1/2] hw/ppc/spapr_events.c: removing
 'exception' from sPAPREventLogEntry
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


--DSayHWYpDlRfCAAQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 18, 2017 at 05:24:01PM -0300, Daniel Henrique Barboza wrote:
> Currenty we do not have any RTAS event that is reported by the
> event-scan interface. The existing events, RTAS_LOG_TYPE_EPOW and
> RTAS_LOG_TYPE_HOTPLUG, are being reported by the check-exception
> interface and, as such, marked as 'exception=3Dtrue'.
>=20
> Commit 79853e18d9, 'spapr_events: event-scan RTAS interface', added
> the event_scan interface because the guest kernel requires it to
> initialize other required interfaces. It is acting since then as
> a stub because no events that would be reported by it were added
> since then. However, the existence of the 'exception' boolean adds
> an unnecessary load in the future migration of the pending_events,
> sPAPREventLogEntry QTAILQ that hosts the pending RTAS events.
>=20
> To make the code cleaner and ease the future migration changes, this
> patch makes the following changes:
>=20
> - remove the 'exception' boolean that filter these events. There is
> nothing to filter since all events are reported by check-exception;
>=20
> - functions rtas_event_log_queue, rtas_event_log_dequeue and
> rtas_event_log_contains don't receive the 'exception' boolean
> as parameter;
>=20
> - event_scan function was simplified. It was calling
> 'rtas_event_log_dequeue(mask, false)' that was always returning
> 'NULL' because we have no events that are created with
> exception=3Dfalse, thus in the end it would execute a jump to
> 'out_no_events' all the time. The function now assumes that
> this will always be the case and all the remaining logic were
> deleted.
>=20
> In the future, when or if we add new RTAS events that should
> be reported with the event_scan interface, we can refer to
> the changes made in this patch to add the event_scan logic
> back.
>=20
> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

Applied to ppc-for-2.10.

> ---
>  hw/ppc/spapr_events.c  | 52 +++++++-------------------------------------=
------
>  include/hw/ppc/spapr.h |  1 -
>  2 files changed, 7 insertions(+), 46 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> index f0b28d8..73e2a18 100644
> --- a/hw/ppc/spapr_events.c
> +++ b/hw/ppc/spapr_events.c
> @@ -342,20 +342,18 @@ static int rtas_event_log_to_irq(sPAPRMachineState =
*spapr, int log_type)
>      return source->irq;
>  }
> =20
> -static void rtas_event_log_queue(int log_type, void *data, bool exceptio=
n)
> +static void rtas_event_log_queue(int log_type, void *data)
>  {
>      sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
>      sPAPREventLogEntry *entry =3D g_new(sPAPREventLogEntry, 1);
> =20
>      g_assert(data);
>      entry->log_type =3D log_type;
> -    entry->exception =3D exception;
>      entry->data =3D data;
>      QTAILQ_INSERT_TAIL(&spapr->pending_events, entry, next);
>  }
> =20
> -static sPAPREventLogEntry *rtas_event_log_dequeue(uint32_t event_mask,
> -                                                  bool exception)
> +static sPAPREventLogEntry *rtas_event_log_dequeue(uint32_t event_mask)
>  {
>      sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
>      sPAPREventLogEntry *entry =3D NULL;
> @@ -364,10 +362,6 @@ static sPAPREventLogEntry *rtas_event_log_dequeue(ui=
nt32_t event_mask,
>          const sPAPREventSource *source =3D
>              rtas_event_log_to_source(spapr, entry->log_type);
> =20
> -        if (entry->exception !=3D exception) {
> -            continue;
> -        }
> -
>          if (source->mask & event_mask) {
>              break;
>          }
> @@ -380,7 +374,7 @@ static sPAPREventLogEntry *rtas_event_log_dequeue(uin=
t32_t event_mask,
>      return entry;
>  }
> =20
> -static bool rtas_event_log_contains(uint32_t event_mask, bool exception)
> +static bool rtas_event_log_contains(uint32_t event_mask)
>  {
>      sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
>      sPAPREventLogEntry *entry =3D NULL;
> @@ -389,10 +383,6 @@ static bool rtas_event_log_contains(uint32_t event_m=
ask, bool exception)
>          const sPAPREventSource *source =3D
>              rtas_event_log_to_source(spapr, entry->log_type);
> =20
> -        if (entry->exception !=3D exception) {
> -            continue;
> -        }
> -
>          if (source->mask & event_mask) {
>              return true;
>          }
> @@ -479,7 +469,7 @@ static void spapr_powerdown_req(Notifier *n, void *op=
aque)
>      epow->event_modifier =3D RTAS_LOG_V6_EPOW_MODIFIER_NORMAL;
>      epow->extended_modifier =3D RTAS_LOG_V6_EPOW_XMODIFIER_PARTITION_SPE=
CIFIC;
> =20
> -    rtas_event_log_queue(RTAS_LOG_TYPE_EPOW, new_epow, true);
> +    rtas_event_log_queue(RTAS_LOG_TYPE_EPOW, new_epow);
> =20
>      qemu_irq_pulse(xics_get_qirq(XICS_FABRIC(spapr),
>                                   rtas_event_log_to_irq(spapr,
> @@ -572,7 +562,7 @@ static void spapr_hotplug_req_event(uint8_t hp_id, ui=
nt8_t hp_action,
>              cpu_to_be32(drc_id->count_indexed.index);
>      }
> =20
> -    rtas_event_log_queue(RTAS_LOG_TYPE_HOTPLUG, new_hp, true);
> +    rtas_event_log_queue(RTAS_LOG_TYPE_HOTPLUG, new_hp);
> =20
>      qemu_irq_pulse(xics_get_qirq(XICS_FABRIC(spapr),
>                                   rtas_event_log_to_irq(spapr,
> @@ -667,7 +657,7 @@ static void check_exception(PowerPCCPU *cpu, sPAPRMac=
hineState *spapr,
>          xinfo |=3D (uint64_t)rtas_ld(args, 6) << 32;
>      }
> =20
> -    event =3D rtas_event_log_dequeue(mask, true);
> +    event =3D rtas_event_log_dequeue(mask);
>      if (!event) {
>          goto out_no_events;
>      }
> @@ -690,7 +680,7 @@ static void check_exception(PowerPCCPU *cpu, sPAPRMac=
hineState *spapr,
>       * interrupts.
>       */
>      for (i =3D 0; i < EVENT_CLASS_MAX; i++) {
> -        if (rtas_event_log_contains(EVENT_CLASS_MASK(i), true)) {
> +        if (rtas_event_log_contains(EVENT_CLASS_MASK(i))) {
>              const sPAPREventSource *source =3D
>                  spapr_event_sources_get_source(spapr->event_sources, i);
> =20
> @@ -710,38 +700,10 @@ static void event_scan(PowerPCCPU *cpu, sPAPRMachin=
eState *spapr,
>                         target_ulong args,
>                         uint32_t nret, target_ulong rets)
>  {
> -    uint32_t mask, buf, len, event_len;
> -    sPAPREventLogEntry *event;
> -    struct rtas_error_log *hdr;
> -
>      if (nargs !=3D 4 || nret !=3D 1) {
>          rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
>          return;
>      }
> -
> -    mask =3D rtas_ld(args, 0);
> -    buf =3D rtas_ld(args, 2);
> -    len =3D rtas_ld(args, 3);
> -
> -    event =3D rtas_event_log_dequeue(mask, false);
> -    if (!event) {
> -        goto out_no_events;
> -    }
> -
> -    hdr =3D event->data;
> -    event_len =3D be32_to_cpu(hdr->extended_length) + sizeof(*hdr);
> -
> -    if (event_len < len) {
> -        len =3D event_len;
> -    }
> -
> -    cpu_physical_memory_write(buf, event->data, len);
> -    rtas_st(rets, 0, RTAS_OUT_SUCCESS);
> -    g_free(event->data);
> -    g_free(event);
> -    return;
> -
> -out_no_events:
>      rtas_st(rets, 0, RTAS_OUT_NO_ERRORS_FOUND);
>  }
> =20
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 5802f88..02239a5 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -598,7 +598,6 @@ sPAPRTCETable *spapr_tce_find_by_liobn(target_ulong l=
iobn);
> =20
>  struct sPAPREventLogEntry {
>      int log_type;
> -    bool exception;
>      void *data;
>      QTAILQ_ENTRY(sPAPREventLogEntry) next;
>  };

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--DSayHWYpDlRfCAAQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZHlfjAAoJEGw4ysog2bOS3EcQAJS3KijN4ienkOdQBSBio6Yz
0dKiLmZgkEyYE6hMRA31U6FbiIbTXrlnpPDlYX+buVM+kUcslfnObR3ATl2+zS/0
9YpVX4179k4pRLCfXR9l1jD0Uo9+PjdmXiqfX0bTEB0WhIqlrIrihXgOBvH+4IdY
BhXRHmpYt9AcEeE5Ths4IOOO+bdhV69bdVFKvo6My+9fQB2uLVHqkYMci53HvBrx
Cnh4xEpK/NTGq0rPa1gnNyj28Y4p7NI+0GgqQyYfz6vktPCZtbacKxnChVzV9oL5
3h2QoiNtCOlwQRkFKyBF0Wn99+gwq0rDjlQPUb73qN7LdQNOjs4b3yjbWiD67KR5
GAOZIATHk87BJcTfaXOMcwQnWlLGf5ko++W4EMs6dcpvrPrzdDw7FfHVFKpt3WOn
eDKopFdkKk18jFeangHn4dusBdYpovLnUeqi06ougWCUHO+7n72GxrpymmTlQaAN
cM13p1KhjlLti+VS6VovcSlfIwkNXQ036zSr9fBj2R3AYO6AmRpTp+NiKrdhmbXL
lbaTpDS/joJeni6R2ZSd19i5SpSziMzlml6x614wldBYuY0VDH+cTUcVpupncA5J
bhrGqrNmh9CCDdxG2URXfXTKUjXoM1LgU7IzSGxL/p9yHpYVqY6f9+TkqqAxZE4O
QunIwS4S8/3xKBJq7CZ3
=uSM7
-----END PGP SIGNATURE-----

--DSayHWYpDlRfCAAQ--
