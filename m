Received: from eggs.gnu.org ([2001:4830:134:3::10]:55093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fTsPm-0001pX-Hp
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 13:21:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fTsPi-00040H-Du
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 13:21:34 -0400
Received: from 3.mo1.mail-out.ovh.net ([46.105.60.232]:38095)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fTsPi-0003zA-3a
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 13:21:30 -0400
Received: from player799.ha.ovh.net (unknown [10.109.122.113])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 5CAC610854B
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 19:21:28 +0200 (CEST)
References: <20180615115303.31125-1-clg@kaod.org>
	<20180615115303.31125-2-clg@kaod.org>
	<20180615151453.535f507e@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <45f5ee26-1243-39fa-06f6-e0b6c4cb3bc4@kaod.org>
Date: Fri, 15 Jun 2018 19:21:19 +0200
MIME-Version: 1.0
In-Reply-To: <20180615151453.535f507e@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 1/3] spapr: split the IRQ
 allocation sequence
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 06/15/2018 03:14 PM, Greg Kurz wrote:
> On Fri, 15 Jun 2018 13:53:01 +0200
> C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>=20
>> Today, when a device requests for IRQ number in a sPAPR machine, the
>> spapr_irq_alloc() routine first scans the ICSState status array to
>> find an empty slot and then performs the assignement of the selected
>> numbers. Split this sequence in two distinct routines : spapr_irq_find=
()
>> for lookups and spapr_irq_claim() for claiming the IRQ numbers.
>>
>> This will ease the introduction of a static layout of IRQ numbers.
>>
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> ---
>>  include/hw/ppc/spapr.h |  5 ++++
>>  hw/ppc/spapr.c         | 64 +++++++++++++++++++++++++++++++++++++++++=
+++++++++
>>  hw/ppc/spapr_events.c  | 18 ++++++++++----
>>  hw/ppc/spapr_pci.c     | 19 ++++++++++++---
>>  hw/ppc/spapr_vio.c     | 10 +++++++-
>>  5 files changed, 108 insertions(+), 8 deletions(-)
>>
>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
>> index 3388750fc795..6088f44c1b2a 100644
>> --- a/include/hw/ppc/spapr.h
>> +++ b/include/hw/ppc/spapr.h
>> @@ -776,6 +776,11 @@ int spapr_irq_alloc(sPAPRMachineState *spapr, int=
 irq_hint, bool lsi,
>>                      Error **errp);
>>  int spapr_irq_alloc_block(sPAPRMachineState *spapr, int num, bool lsi=
,
>>                            bool align, Error **errp);
>> +int spapr_irq_find(sPAPRMachineState *spapr, int num, bool align,
>> +                   Error **errp);
>> +#define spapr_irq_findone(spapr, errp) spapr_irq_find(spapr, 1, false=
, errp)
>> +int spapr_irq_claim(sPAPRMachineState *spapr, int irq, int num, bool =
lsi,
>> +                    Error **errp);
>>  void spapr_irq_free(sPAPRMachineState *spapr, int irq, int num);
>>  qemu_irq spapr_qirq(sPAPRMachineState *spapr, int irq);
>> =20
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index f59999daacfc..b1d19b328166 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -3810,6 +3810,36 @@ static int ics_find_free_block(ICSState *ics, i=
nt num, int alignnum)
>>      return -1;
>>  }
>> =20
>> +int spapr_irq_find(sPAPRMachineState *spapr, int num, bool align, Err=
or **errp)
>> +{
>> +    ICSState *ics =3D spapr->ics;
>> +    int first =3D -1;
>> +
>> +    assert(ics);
>> +
>> +    /*
>> +     * MSIMesage::data is used for storing VIRQ so
>> +     * it has to be aligned to num to support multiple
>> +     * MSI vectors. MSI-X is not affected by this.
>> +     * The hint is used for the first IRQ, the rest should
>> +     * be allocated continuously.
>> +     */
>> +    if (align) {
>> +        assert((num =3D=3D 1) || (num =3D=3D 2) || (num =3D=3D 4) ||
>> +               (num =3D=3D 8) || (num =3D=3D 16) || (num =3D=3D 32));
>> +        first =3D ics_find_free_block(ics, num, num);
>> +    } else {
>> +        first =3D ics_find_free_block(ics, num, 1);
>> +    }
>> +
>> +    if (first < 0) {
>> +        error_setg(errp, "can't find a free %d-IRQ block", num);
>> +        return -1;
>> +    }
>> +
>> +    return first + ics->offset;
>> +}
>> +
>>  /*
>>   * Allocate the IRQ number and set the IRQ type, LSI or MSI
>>   */
>> @@ -3888,6 +3918,40 @@ int spapr_irq_alloc_block(sPAPRMachineState *sp=
apr, int num, bool lsi,
>>      return first;
>>  }
>> =20
>> +int spapr_irq_claim(sPAPRMachineState *spapr, int irq, int num, bool =
lsi,
>> +                    Error **errp)
>> +{
>> +    ICSState *ics =3D spapr->ics;
>> +    int i;
>> +    int srcno =3D irq - ics->offset;
>> +    int ret =3D 0;
>> +
>> +    assert(ics);
>> +
>> +    if (!ics_valid_irq(ics, irq) || !ics_valid_irq(ics, irq + num)) {
>=20
> I guess it is okay to assume that if the first and last irqs are valid,
> so are all numbers in between. Shouldn't the second check be against
> irq + num - 1 though ?

yes. thanks.

> This lacks an error_setg() BTW.
>=20
>> +        return -1;
>> +    }
>> +
>> +    for (i =3D srcno; i < srcno + num; ++i) {
>> +        if (ICS_IRQ_FREE(ics, i)) {
>> +            spapr_irq_set_lsi(spapr, i + ics->offset, lsi);
>> +        } else {
>> +            error_setg(errp, "IRQ %d is not free", i + ics->offset);
>> +            ret =3D -1;
>> +            break;
>> +        }
>> +    }
>> +
>> +    /* we could call spapr_irq_free() when rolling back */
>> +    if (ret) {
>> +        while (--i >=3D srcno) {
>> +            memset(&ics->irqs[i], 0, sizeof(ICSIRQState));
>> +        }
>> +    }
>=20
> Hmm... I guess we should free the whole range otherwise we leak
> srcno + num - i irqs, preferably using spapr_irq_free() to match
> the traces from spapr_irq_alloc().

I don't understand. This is undoing what has been done.=20

> Alternatively, the rollback could be pushed to the callers.

Yes. Today none is done so we might just do nothing about it
and return an error.
=20
> Rest looks good.
>=20
>> +
>> +    return ret;
>> +}
>> +
>>  void spapr_irq_free(sPAPRMachineState *spapr, int irq, int num)
>>  {
>>      ICSState *ics =3D spapr->ics;
>> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
>> index 86836f0626dc..3b6ae7272092 100644
>> --- a/hw/ppc/spapr_events.c
>> +++ b/hw/ppc/spapr_events.c
>> @@ -707,13 +707,18 @@ void spapr_clear_pending_events(sPAPRMachineStat=
e *spapr)
>> =20
>>  void spapr_events_init(sPAPRMachineState *spapr)
>>  {
>> +    int epow_irq;
>> +
>> +    epow_irq =3D spapr_irq_findone(spapr, &error_fatal);
>> +
>> +    spapr_irq_claim(spapr, epow_irq, 1, false, &error_fatal);
>> +
>>      QTAILQ_INIT(&spapr->pending_events);
>> =20
>>      spapr->event_sources =3D spapr_event_sources_new();
>> =20
>>      spapr_event_sources_register(spapr->event_sources, EVENT_CLASS_EP=
OW,
>> -                                 spapr_irq_alloc(spapr, 0, false,
>> -                                                  &error_fatal));
>> +                                 epow_irq);
>> =20
>>      /* NOTE: if machine supports modern/dedicated hotplug event sourc=
e,
>>       * we add it to the device-tree unconditionally. This means we ma=
y
>> @@ -724,9 +729,14 @@ void spapr_events_init(sPAPRMachineState *spapr)
>>       * checking that it's enabled.
>>       */
>>      if (spapr->use_hotplug_event_source) {
>> +        int hp_irq;
>> +
>> +        hp_irq =3D spapr_irq_findone(spapr, &error_fatal);
>> +
>> +        spapr_irq_claim(spapr, hp_irq, 1, false, &error_fatal);
>> +
>>          spapr_event_sources_register(spapr->event_sources, EVENT_CLAS=
S_HOT_PLUG,
>> -                                     spapr_irq_alloc(spapr, 0, false,
>> -                                                      &error_fatal));
>> +                                     hp_irq);
>>      }
>> =20
>>      spapr->epow_notifier.notify =3D spapr_powerdown_req;
>> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
>> index f936ce63effa..7394c62b4a8b 100644
>> --- a/hw/ppc/spapr_pci.c
>> +++ b/hw/ppc/spapr_pci.c
>> @@ -371,8 +371,14 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, =
sPAPRMachineState *spapr,
>>      }
>> =20
>>      /* Allocate MSIs */
>> -    irq =3D spapr_irq_alloc_block(spapr, req_num, false,
>> -                           ret_intr_type =3D=3D RTAS_TYPE_MSI, &err);
>> +    irq =3D spapr_irq_find(spapr, req_num, ret_intr_type =3D=3D RTAS_=
TYPE_MSI, &err);
>> +    if (err) {
>> +        error_reportf_err(err, "Can't allocate MSIs for device %x: ",
>> +                          config_addr);
>> +        rtas_st(rets, 0, RTAS_OUT_HW_ERROR);
>> +        return;
>> +    }
>> +    spapr_irq_claim(spapr, irq, req_num, false, &err);
>>      if (err) {
>>          error_reportf_err(err, "Can't allocate MSIs for device %x: ",
>>                            config_addr);
>> @@ -1698,7 +1704,14 @@ static void spapr_phb_realize(DeviceState *dev,=
 Error **errp)
>>          uint32_t irq;
>>          Error *local_err =3D NULL;
>> =20
>> -        irq =3D spapr_irq_alloc_block(spapr, 1, true, false, &local_e=
rr);
>> +        irq =3D spapr_irq_findone(spapr, &local_err);
>> +        if (local_err) {
>> +            error_propagate(errp, local_err);
>> +            error_prepend(errp, "can't allocate LSIs: ");
>> +            return;
>> +        }
>> +
>> +        spapr_irq_claim(spapr, irq, 1, true, &local_err);
>>          if (local_err) {
>>              error_propagate(errp, local_err);
>>              error_prepend(errp, "can't allocate LSIs: ");
>> diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
>> index 4555c648a8e2..ad9b56e28447 100644
>> --- a/hw/ppc/spapr_vio.c
>> +++ b/hw/ppc/spapr_vio.c
>> @@ -475,7 +475,15 @@ static void spapr_vio_busdev_realize(DeviceState =
*qdev, Error **errp)
>>          dev->qdev.id =3D id;
>>      }
>> =20
>> -    dev->irq =3D spapr_irq_alloc(spapr, dev->irq, false, &local_err);
>> +    if (!dev->irq) {
>> +        dev->irq =3D spapr_irq_findone(spapr, &local_err);
>> +        if (local_err) {
>> +            error_propagate(errp, local_err);
>> +            return;
>> +        }
>> +    }
>> +
>> +    spapr_irq_claim(spapr, dev->irq, 1, false, &local_err);
>>      if (local_err) {
>>          error_propagate(errp, local_err);
>>          return;
>=20
