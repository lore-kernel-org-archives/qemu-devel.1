Received: from eggs.gnu.org ([2001:4830:134:3::10]:42045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fP2YJ-0004O0-C4
	for qemu-devel@nongnu.org; Sat, 02 Jun 2018 05:10:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fP2YG-0002X6-3Q
	for qemu-devel@nongnu.org; Sat, 02 Jun 2018 05:10:23 -0400
Received: from 1.mo69.mail-out.ovh.net ([178.33.251.173]:32808)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fP2YF-0001jA-OA
	for qemu-devel@nongnu.org; Sat, 02 Jun 2018 05:10:20 -0400
Received: from player735.ha.ovh.net (unknown [10.109.108.70])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id 6938D17063
	for <qemu-devel@nongnu.org>; Sat,  2 Jun 2018 11:10:09 +0200 (CEST)
References: <20180518164405.11804-1-clg@kaod.org>
	<20180518164405.11804-2-clg@kaod.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <c0d52342-d42b-587e-18ae-29052cc96c8f@kaod.org>
Date: Sat, 2 Jun 2018 11:10:01 +0200
MIME-Version: 1.0
In-Reply-To: <20180518164405.11804-2-clg@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/4] spapr: remove irq_hint parameter from
 spapr_irq_alloc()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, Alexey Kardashevskiy <aik@ozlabs.ru>

On 05/18/2018 06:44 PM, C=C3=A9dric Le Goater wrote:
> This IRQ number hint can possibly be used by the VIO devices if the
> "irq" property is defined on the command line but it seems it is never
> the case. It is not used in libvirt for instance. So, let's remove it
> to simplify future changes.
>=20
> Nevertheless, this is a compatibbility breakage that will be addressed
> by the subsequent patches which introduce IRQ number allocator
> handlers per machine version.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  include/hw/ppc/spapr.h |  3 +--
>  hw/ppc/spapr.c         | 21 ++++++---------------
>  hw/ppc/spapr_events.c  |  7 +++----
>  hw/ppc/spapr_vio.c     |  2 +-
>  4 files changed, 11 insertions(+), 22 deletions(-)
>=20
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index d60b7c6d7a8b..2cfdfdd67eaf 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -773,8 +773,7 @@ int spapr_get_vcpu_id(PowerPCCPU *cpu);
>  void spapr_set_vcpu_id(PowerPCCPU *cpu, int cpu_index, Error **errp);
>  PowerPCCPU *spapr_find_cpu(int vcpu_id);
> =20
> -int spapr_irq_alloc(sPAPRMachineState *spapr, int irq_hint, bool lsi,
> -                    Error **errp);
> +int spapr_irq_alloc(sPAPRMachineState *spapr, bool lsi, Error **errp);
>  int spapr_irq_alloc_block(sPAPRMachineState *spapr, int num, bool lsi,
>                            bool align, Error **errp);
>  void spapr_irq_free(sPAPRMachineState *spapr, int irq, int num);
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 32ab3c43b6c0..05a924a5f2da 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3798,28 +3798,19 @@ static void spapr_irq_set_lsi(sPAPRMachineState=
 *spapr, int irq, bool lsi)
>      ics_set_irq_type(spapr->ics, irq - spapr->ics->offset, lsi);
>  }
> =20
> -int spapr_irq_alloc(sPAPRMachineState *spapr, int irq_hint, bool lsi,
> -                    Error **errp)
> +int spapr_irq_alloc(sPAPRMachineState *spapr, bool lsi, Error **errp)
>  {
>      ICSState *ics =3D spapr->ics;
>      int irq;
> =20
>      assert(ics);
> =20
> -    if (irq_hint) {
> -        if (!ICS_IRQ_FREE(ics, irq_hint - ics->offset)) {

Side note, this line is a promise for a nice segv if irq_hint < ics->offs=
et.

I think it is time to deprecate the 'irq' property of the sPAPR VIO devic=
es.

C.


> -            error_setg(errp, "can't allocate IRQ %d: already in use", =
irq_hint);
> -            return -1;
> -        }
> -        irq =3D irq_hint;
> -    } else {
> -        irq =3D ics_find_free_block(ics, 1, 1);
> -        if (irq < 0) {
> -            error_setg(errp, "can't allocate IRQ: no IRQ left");
> -            return -1;
> -        }
> -        irq +=3D ics->offset;
> +    irq =3D ics_find_free_block(ics, 1, 1);
> +    if (irq < 0) {
> +        error_setg(errp, "can't allocate IRQ: no IRQ left");
> +        return -1;
>      }
> +    irq +=3D ics->offset;
> =20
>      spapr_irq_set_lsi(spapr, irq, lsi);
>      trace_spapr_irq_alloc(irq);
> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> index 86836f0626dc..64a67439beac 100644
> --- a/hw/ppc/spapr_events.c
> +++ b/hw/ppc/spapr_events.c
> @@ -712,8 +712,7 @@ void spapr_events_init(sPAPRMachineState *spapr)
>      spapr->event_sources =3D spapr_event_sources_new();
> =20
>      spapr_event_sources_register(spapr->event_sources, EVENT_CLASS_EPO=
W,
> -                                 spapr_irq_alloc(spapr, 0, false,
> -                                                  &error_fatal));
> +                                 spapr_irq_alloc(spapr, false, &error_=
fatal));
> =20
>      /* NOTE: if machine supports modern/dedicated hotplug event source=
,
>       * we add it to the device-tree unconditionally. This means we may
> @@ -725,8 +724,8 @@ void spapr_events_init(sPAPRMachineState *spapr)
>       */
>      if (spapr->use_hotplug_event_source) {
>          spapr_event_sources_register(spapr->event_sources, EVENT_CLASS=
_HOT_PLUG,
> -                                     spapr_irq_alloc(spapr, 0, false,
> -                                                      &error_fatal));
> +                                     spapr_irq_alloc(spapr, false,
> +                                                     &error_fatal));
>      }
> =20
>      spapr->epow_notifier.notify =3D spapr_powerdown_req;
> diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
> index 472dd6f33a96..cc064f64fccf 100644
> --- a/hw/ppc/spapr_vio.c
> +++ b/hw/ppc/spapr_vio.c
> @@ -455,7 +455,7 @@ static void spapr_vio_busdev_realize(DeviceState *q=
dev, Error **errp)
>          dev->qdev.id =3D id;
>      }
> =20
> -    dev->irq =3D spapr_irq_alloc(spapr, dev->irq, false, &local_err);
> +    dev->irq =3D spapr_irq_alloc(spapr, false, &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
>          return;
>=20
