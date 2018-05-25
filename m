Received: from eggs.gnu.org ([2001:4830:134:3::10]:39164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fMDJD-00077r-Kl
	for qemu-devel@nongnu.org; Fri, 25 May 2018 10:03:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fMDJ8-0000RW-Mm
	for qemu-devel@nongnu.org; Fri, 25 May 2018 10:03:07 -0400
Received: from 14.mo3.mail-out.ovh.net ([188.165.43.98]:58037)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fMDJ8-0000R4-DO
	for qemu-devel@nongnu.org; Fri, 25 May 2018 10:03:02 -0400
Received: from player791.ha.ovh.net (unknown [10.109.122.22])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id AB5B61B9456
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 16:03:00 +0200 (CEST)
Date: Fri, 25 May 2018 16:02:49 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180525160249.7cb0a5bc@bahia.lan>
In-Reply-To: <20180518164405.11804-2-clg@kaod.org>
References: <20180518164405.11804-1-clg@kaod.org>
	<20180518164405.11804-2-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Alexey Kardashevskiy <aik@ozlabs.ru>, Thomas Huth <thuth@redhat.com>

On Fri, 18 May 2018 18:44:02 +0200
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> This IRQ number hint can possibly be used by the VIO devices if the
> "irq" property is defined on the command line but it seems it is never
> the case. It is not used in libvirt for instance. So, let's remove it
> to simplify future changes.
>=20

Setting an irq manually looks a bit anachronistic. I doubt anyone would
do that nowadays, and the patch does a nice cleanup. So this looks like
a good idea.

> Nevertheless, this is a compatibbility breakage that will be addressed
                                 ^^
                                typo

> by the subsequent patches which introduce IRQ number allocator
> handlers per machine version.
>=20

Indeed, this silently breaks the "irq" property of VIO devices, and I
don't quite see how the other patches address this specific breakage.

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
> @@ -3798,28 +3798,19 @@ static void spapr_irq_set_lsi(sPAPRMachineState *=
spapr, int irq, bool lsi)
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
> -            error_setg(errp, "can't allocate IRQ %d: already in use", ir=
q_hint);
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
>      spapr_event_sources_register(spapr->event_sources, EVENT_CLASS_EPOW,
> -                                 spapr_irq_alloc(spapr, 0, false,
> -                                                  &error_fatal));
> +                                 spapr_irq_alloc(spapr, false, &error_fa=
tal));
> =20
>      /* NOTE: if machine supports modern/dedicated hotplug event source,
>       * we add it to the device-tree unconditionally. This means we may
> @@ -725,8 +724,8 @@ void spapr_events_init(sPAPRMachineState *spapr)
>       */
>      if (spapr->use_hotplug_event_source) {
>          spapr_event_sources_register(spapr->event_sources, EVENT_CLASS_H=
OT_PLUG,
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
> @@ -455,7 +455,7 @@ static void spapr_vio_busdev_realize(DeviceState *qde=
v, Error **errp)
>          dev->qdev.id =3D id;
>      }
> =20
> -    dev->irq =3D spapr_irq_alloc(spapr, dev->irq, false, &local_err);
> +    dev->irq =3D spapr_irq_alloc(spapr, false, &local_err);

Silently breaking "irq" like this looks wrong. I'd rather officially remove
it first (ie, kill spapr_vio_props, -5 lines in spapr_vio.c).

Of course, this raises the question of interface deprecation, and it should
theoretically follow the process described at:

https://wiki.qemu.org/Features/LegacyRemoval#Rules_for_removing_an_interface

Cc'ing Thomas, our Chief Deprecation Officer, for insights :)

>      if (local_err) {
>          error_propagate(errp, local_err);
>          return;
