Received: from eggs.gnu.org ([2001:4830:134:3::10]:55924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1da1z5-0007ZI-Q0
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 11:42:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1da1z1-00040h-PE
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 11:42:55 -0400
Received: from 1.mo179.mail-out.ovh.net ([178.33.111.220]:45270)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1da1z1-000408-Fm
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 11:42:51 -0400
Received: from player168.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id AC6FA59B62
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 17:42:49 +0200 (CEST)
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
	<1499274819-15607-8-git-send-email-clg@kaod.org>
	<20170724042956.GD17228@umbus.fritz.box>
	<006293c9-b396-82f9-19ba-d57301934ffe@kaod.org>
	<20170725122154.GE8978@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <449ced34-c454-0984-ce37-193b86cad293@kaod.org>
Date: Tue, 25 Jul 2017 17:42:40 +0200
MIME-Version: 1.0
In-Reply-To: <20170725122154.GE8978@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 07/26] ppc/xive: add MMIO handlers to
 the XIVE interrupt source
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 07/25/2017 02:21 PM, David Gibson wrote:
> On Mon, Jul 24, 2017 at 05:55:42PM +0200, C=E9dric Le Goater wrote:
>> On 07/24/2017 06:29 AM, David Gibson wrote:
>>> On Wed, Jul 05, 2017 at 07:13:20PM +0200, C=E9dric Le Goater wrote:
>>>> Each interrupt source is associated with a 2-bit state machine calle=
d
>>>> an Event State Buffer (ESB). It is controlled by MMIO to trigger
>>>> events.
> [snip]
>>>> +/* TODO: handle second page */
>>>
>>> Is this comment still relevent?
>>
>> Some HW have a second page to trigger the event. I am not sure we need=
=20
>> to model it though. I will make some inquiries.
>=20
> Ah, ok.  Maybe clarify the comment a bit.
>=20
> [snip]
>>>> +static void xive_esb_write(void *opaque, hwaddr addr,
>>>> +                           uint64_t value, unsigned size)
>>>> +{
>>>> +    XiveICSState *xs =3D ICS_XIVE(opaque);
>>>> +    XIVE *x =3D xs->xive;
>>>> +    uint32_t offset =3D addr & 0xF00;
>>>> +    uint32_t srcno =3D addr >> xs->esb_shift;
>>>> +    uint32_t lisn =3D srcno + ICS_BASE(xs)->offset;
>>>> +    XiveIVE *ive;
>>>> +    bool notify =3D false;
>>>> +
>>>> +    ive =3D xive_get_ive(x, lisn);
>>>> +    if (!ive || !(ive->w & IVE_VALID))  {
>>>> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid LISN %d\n", l=
isn);
>>>> +        return;
>>>> +    }
>>>
>>> Having this code associated with the individual ICS look directly at
>>> the IVE table in the core xive object seems a bit dubious.
>>
>> The IVE table holds the validity and mask status of the interrupt=20
>> entries, so we need that lookup. However, (continues below) ...
>>
>>> This also
>>> points out another mismatch between the re-used ICS code and the new
>>> XIVE code: ICS gathers all the per-source-irq flags/state into the
>>> irqstate structure, whereas xive has per-irq information in the
>>> centralized ecb and IVE tables.  There can certainly be good reasons
>>> for that, but using both at once is kind of clunky.
>>
>> I understand that you would rather put the esbs in the source they=20
>> belong to. That is the case on real HW but it makes the modeling a=20
>> bit more difficult. We would need to choose a MMIO address to give=20
>> to the guest OS. I had some issues with the allocator (I need=20
>> to look at this problem closer).
>=20
> Uh.. what do MMIO addresses have to do with this?  I'm talking about
> the actual ESB state in the packed bit array.

To ease the modeling, the ESB states of all IRQs are under the same
bit array and they are exposed to the guest OS through a single memory=20
region so that all accesses to the ESB states are centralized. On real=20
HW, the ESB cache and the MMIO base depends on the source.=20
=20
Anyway, that might not be an issue. I will see what I can do to=20
decorrelate the XIVE source from the main XIVE object. We can=20
probably move the ESB state array below the XIVE source.

C.

>> It might also be an "issue" for KVM. Ben talked about maintaining=20
>> all the esbs of a guest under a single memory region to be able to=20
>> map the pages in the host.
>>
>> Any how, I agree this is another point to discuss in the sPAPR=20
>> model.
>>
>> Thanks,
>>
>> C.=20
>>
>>
>>>> +    if (srcno >=3D ICS_BASE(xs)->nr_irqs) {
>>>> +        qemu_log_mask(LOG_GUEST_ERROR,
>>>> +                      "XIVE: invalid IRQ number: %d/%d lisn: %d\n",
>>>> +                      srcno, ICS_BASE(xs)->nr_irqs, lisn);
>>>> +        return;
>>>> +    }
>>>> +
>>>> +    switch (offset) {
>>>> +    case 0:
>>>> +        /* TODO: should we trigger even if the IVE is masked ? */
>>>> +        notify =3D xive_pq_trigger(x, lisn);
>>>> +        break;
>>>> +    default:
>>>> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid ESB write add=
r %d\n",
>>>> +                      offset);
>>>> +        return;
>>>> +    }
>>>> +
>>>> +    if (notify && !(ive->w & IVE_MASKED)) {
>>>> +        qemu_irq_pulse(ICS_BASE(xs)->qirqs[srcno]);
>>>> +    }
>>>> +}
>>>> +
>>>> +static const MemoryRegionOps xive_esb_ops =3D {
>>>> +    .read =3D xive_esb_read,
>>>> +    .write =3D xive_esb_write,
>>>> +    .endianness =3D DEVICE_BIG_ENDIAN,
>>>> +    .valid =3D {
>>>> +        .min_access_size =3D 8,
>>>> +        .max_access_size =3D 8,
>>>> +    },
>>>> +    .impl =3D {
>>>> +        .min_access_size =3D 8,
>>>> +        .max_access_size =3D 8,
>>>> +    },
>>>> +};
>>>> +
>>>> +/*
>>>>   * XIVE Interrupt Source
>>>>   */
>>>>  static void xive_ics_set_irq_msi(XiveICSState *xs, int srcno, int v=
al)
>>>> @@ -106,15 +326,25 @@ static void xive_ics_realize(ICSState *ics, Er=
ror **errp)
>>>>          return;
>>>>      }
>>>> =20
>>>> +    if (!xs->esb_shift) {
>>>> +        error_setg(errp, "ESB page size needs to be greater 0");
>>>> +        return;
>>>> +    }
>>>> +
>>>>      ics->irqs =3D g_malloc0(ics->nr_irqs * sizeof(ICSIRQState));
>>>>      ics->qirqs =3D qemu_allocate_irqs(xive_ics_set_irq, xs, ics->nr=
_irqs);
>>>> =20
>>>> +    memory_region_init_io(&xs->esb_iomem, OBJECT(xs), &xive_esb_ops=
, xs,
>>>> +                          "xive.esb",
>>>> +                          (1ull << xs->esb_shift) * ICS_BASE(xs)->n=
r_irqs);
>>>> +
>>>>      qemu_register_reset(xive_ics_reset, xs);
>>>>  }
>>>> =20
>>>>  static Property xive_ics_properties[] =3D {
>>>>      DEFINE_PROP_UINT32("nr-irqs", ICSState, nr_irqs, 0),
>>>>      DEFINE_PROP_UINT32("irq-base", ICSState, offset, 0),
>>>> +    DEFINE_PROP_UINT32("shift", XiveICSState, esb_shift, 0),
>>>>      DEFINE_PROP_END_OF_LIST(),
>>>>  };
>>>> =20
>>>> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
>>>> index 544cc6e0c796..5303d96f5f59 100644
>>>> --- a/include/hw/ppc/xive.h
>>>> +++ b/include/hw/ppc/xive.h
>>>> @@ -33,6 +33,9 @@ typedef struct XiveICSState XiveICSState;
>>>>  struct XiveICSState {
>>>>      ICSState parent_obj;
>>>> =20
>>>> +    uint32_t     esb_shift;
>>>> +    MemoryRegion esb_iomem;
>>>> +
>>>>      XIVE         *xive;
>>>>  };
>>>> =20
>>>
>>
>=20
