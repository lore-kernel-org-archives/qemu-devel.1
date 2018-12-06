Received: from eggs.gnu.org ([2001:4830:134:3::10]:48541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gUnBS-0004LR-Op
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 01:30:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gUnBM-0005rS-RQ
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 01:30:50 -0500
Received: from 9.mo177.mail-out.ovh.net ([46.105.72.238]:48512)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gUnBL-0005o3-S1
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 01:30:44 -0500
Received: from player756.ha.ovh.net (unknown [10.109.146.53])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 44070D667E
	for <qemu-devel@nongnu.org>; Thu,  6 Dec 2018 07:30:40 +0100 (CET)
References: <20181205232251.10446-1-clg@kaod.org>
	<20181205232251.10446-7-clg@kaod.org>
	<20181206040914.GO768@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <16ae54d9-2bad-ea77-30be-fff2cf3dea89@kaod.org>
Date: Thu, 6 Dec 2018 07:30:34 +0100
MIME-Version: 1.0
In-Reply-To: <20181206040914.GO768@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 06/37] ppc/xive: add support for the END
 Event State buffers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On 12/6/18 5:09 AM, David Gibson wrote:
> On Thu, Dec 06, 2018 at 12:22:20AM +0100, C=E9dric Le Goater wrote:
>> The Event Notification Descriptor (END) XIVE structure also contains
>> two Event State Buffers providing further coalescing of interrupts,
>> one for the notification event (ESn) and one for the escalation events
>> (ESe). A MMIO page is assigned for each to control the EOI through
>> loads only. Stores are not allowed.
>>
>> The END ESBs are modeled through an object resembling the 'XiveSource'
>> It is stateless as the END state bits are backed into the XiveEND
>> structure under the XiveRouter and the MMIO accesses follow the same
>> rules as for the standard source ESBs.
>>
>> END ESBs are not supported by the Linux drivers neither on OPAL nor on
>> sPAPR. Nevetherless, it provides a mean to study the question in the
>> future and validates a bit more the XIVE model.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>> ---
>>  include/hw/ppc/xive.h |  22 ++++++
>>  hw/intc/xive.c        | 173 +++++++++++++++++++++++++++++++++++++++++=
-
>>  2 files changed, 193 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
>> index d1b4c6c78ec5..d67b0785df7c 100644
>> --- a/include/hw/ppc/xive.h
>> +++ b/include/hw/ppc/xive.h
>> @@ -305,6 +305,8 @@ static inline void xive_source_irq_set(XiveSource =
*xsrc, uint32_t srcno,
>> =20
>>  typedef struct XiveRouter {
>>      SysBusDevice    parent;
>> +
>> +    uint32_t       chip_id;
>=20
> I still don't think you need this..

I know :)=20

>=20
>>  } XiveRouter;
>> =20
>>  #define TYPE_XIVE_ROUTER "xive-router"
>> @@ -336,6 +338,26 @@ int xive_router_get_end(XiveRouter *xrtr, uint8_t=
 end_blk, uint32_t end_idx,
>>  int xive_router_write_end(XiveRouter *xrtr, uint8_t end_blk, uint32_t=
 end_idx,
>>                            XiveEND *end, uint8_t word_number);
>> =20
>> +/*
>> + * XIVE END ESBs
>> + */
>> +
>> +#define TYPE_XIVE_END_SOURCE "xive-end-source"
>> +#define XIVE_END_SOURCE(obj) \
>> +    OBJECT_CHECK(XiveENDSource, (obj), TYPE_XIVE_END_SOURCE)
>> +
>> +typedef struct XiveENDSource {
>> +    DeviceState parent;
>> +
>> +    uint32_t        nr_ends;
>> +
>> +    /* ESB memory region */
>> +    uint32_t        esb_shift;
>> +    MemoryRegion    esb_mmio;
>> +
>> +    XiveRouter      *xrtr;
>=20
> ..or this..
>=20
>> +} XiveENDSource;
>> +
>>  /*
>>   * For legacy compatibility, the exceptions define up to 256 differen=
t
>>   * priorities. P9 implements only 9 levels : 8 active levels [0 - 7]
>> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
>> index 41d8ba1540d0..83686e260df5 100644
>> --- a/hw/intc/xive.c
>> +++ b/hw/intc/xive.c
>> @@ -612,8 +612,18 @@ static void xive_router_end_notify(XiveRouter *xr=
tr, uint8_t end_blk,
>>       * even futher coalescing in the Router
>>       */
>>      if (!xive_end_is_notify(&end)) {
>> -        qemu_log_mask(LOG_UNIMP, "XIVE: !UCOND_NOTIFY not implemented=
\n");
>> -        return;
>> +        uint8_t pq =3D GETFIELD_BE32(END_W1_ESn, end.w1);
>> +        bool notify =3D xive_esb_trigger(&pq);
>> +
>> +        if (pq !=3D GETFIELD_BE32(END_W1_ESn, end.w1)) {
>> +            end.w1 =3D SETFIELD_BE32(END_W1_ESn, end.w1, pq);
>> +            xive_router_write_end(xrtr, end_blk, end_idx, &end, 1);
>> +        }
>> +
>> +        /* ESn[Q]=3D1 : end of notification */
>> +        if (!notify) {
>> +            return;
>> +        }
>>      }
>> =20
>>      /*
>> @@ -658,12 +668,18 @@ static void xive_router_notify(XiveNotifier *xn,=
 uint32_t lisn)
>>                             GETFIELD_BE64(EAS_END_DATA,  eas.w));
>>  }
>> =20
>> +static Property xive_router_properties[] =3D {
>> +    DEFINE_PROP_UINT32("chip-id", XiveRouter, chip_id, 0),
>> +    DEFINE_PROP_END_OF_LIST(),
>> +};
>> +
>>  static void xive_router_class_init(ObjectClass *klass, void *data)
>>  {
>>      DeviceClass *dc =3D DEVICE_CLASS(klass);
>>      XiveNotifierClass *xnc =3D XIVE_NOTIFIER_CLASS(klass);
>> =20
>>      dc->desc    =3D "XIVE Router Engine";
>> +    dc->props   =3D xive_router_properties;
>>      xnc->notify =3D xive_router_notify;
>>  }
>> =20
>> @@ -692,6 +708,158 @@ void xive_eas_pic_print_info(XiveEAS *eas, uint3=
2_t lisn, Monitor *mon)
>>                     (uint32_t) GETFIELD_BE64(EAS_END_DATA, eas->w));
>>  }
>> =20
>> +/*
>> + * END ESB MMIO loads
>> + */
>> +static uint64_t xive_end_source_read(void *opaque, hwaddr addr, unsig=
ned size)
>> +{
>> +    XiveENDSource *xsrc =3D XIVE_END_SOURCE(opaque);
>> +    XiveRouter *xrtr =3D xsrc->xrtr;
>> +    uint32_t offset =3D addr & 0xFFF;
>> +    uint8_t end_blk;
>> +    uint32_t end_idx;
>> +    XiveEND end;
>> +    uint32_t end_esmask;
>> +    uint8_t pq;
>> +    uint64_t ret =3D -1;
>> +
>> +    end_blk =3D xrtr->chip_id;
>=20
> .. instead I think it makes more sense to just configure the end_blk
> directly on the end_source, rather than reaching into another object
> to=20

Ah. That's what I was asking in an email. I missed the answer maybe.
Let's drop it and sPAPRXive block will be 0.=20

>=20
>> +    end_idx =3D addr >> (xsrc->esb_shift + 1);
>> +
>> +    if (xive_router_get_end(xrtr, end_blk, end_idx, &end)) {
>> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: No END %x/%x\n", end_bl=
k,
>> +                      end_idx);
>> +        return -1;
>> +    }
>> +
>> +    if (!xive_end_is_valid(&end)) {
>> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: END %x/%x is invalid\n"=
,
>> +                      end_blk, end_idx);
>> +        return -1;
>> +    }
>> +
>> +    end_esmask =3D addr_is_even(addr, xsrc->esb_shift) ? END_W1_ESn :=
 END_W1_ESe;
>> +    pq =3D GETFIELD_BE32(end_esmask, end.w1);
>> +
>> +    switch (offset) {
>> +    case XIVE_ESB_LOAD_EOI ... XIVE_ESB_LOAD_EOI + 0x7FF:
>> +        ret =3D xive_esb_eoi(&pq);
>> +
>> +        /* Forward the source event notification for routing ?? */
>> +        break;
>> +
>> +    case XIVE_ESB_GET ... XIVE_ESB_GET + 0x3FF:
>> +        ret =3D pq;
>> +        break;
>> +
>> +    case XIVE_ESB_SET_PQ_00 ... XIVE_ESB_SET_PQ_00 + 0x0FF:
>> +    case XIVE_ESB_SET_PQ_01 ... XIVE_ESB_SET_PQ_01 + 0x0FF:
>> +    case XIVE_ESB_SET_PQ_10 ... XIVE_ESB_SET_PQ_10 + 0x0FF:
>> +    case XIVE_ESB_SET_PQ_11 ... XIVE_ESB_SET_PQ_11 + 0x0FF:
>> +        ret =3D xive_esb_set(&pq, (offset >> 8) & 0x3);
>> +        break;
>> +    default:
>> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid END ESB load ad=
dr %d\n",
>> +                      offset);
>> +        return -1;
>> +    }
>> +
>> +    if (pq !=3D GETFIELD_BE32(end_esmask, end.w1)) {
>> +        end.w1 =3D SETFIELD_BE32(end_esmask, end.w1, pq);
>> +        xive_router_write_end(xrtr, end_blk, end_idx, &end, 1);
>> +    }
>> +
>> +    return ret;
>> +}
>> +
>> +/*
>> + * END ESB MMIO stores are invalid
>> + */
>> +static void xive_end_source_write(void *opaque, hwaddr addr,
>> +                                  uint64_t value, unsigned size)
>> +{
>> +    qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid ESB write addr 0x%"
>> +                  HWADDR_PRIx"\n", addr);
>> +}
>> +
>> +static const MemoryRegionOps xive_end_source_ops =3D {
>> +    .read =3D xive_end_source_read,
>> +    .write =3D xive_end_source_write,
>> +    .endianness =3D DEVICE_BIG_ENDIAN,
>> +    .valid =3D {
>> +        .min_access_size =3D 8,
>> +        .max_access_size =3D 8,
>> +    },
>> +    .impl =3D {
>> +        .min_access_size =3D 8,
>> +        .max_access_size =3D 8,
>> +    },
>> +};
>> +
>> +static void xive_source_end_reset(void *dev)
>> +{
>> +    /* TODO: Loop on all ENDs and mask off the ESn and ESe */
>=20
> IIUC you're talking about actually writing the (potentially in memory)
> END structures.  I don't think that makes sense for the END source
> hardware model.  I'm guessing you want this for PAPR, where the ENDs
> are in virtual hardware=20

That's done already.

> rather than guest memory, but in that case I
> think the reset handling should be in the PAPR specific Xive object,
> not the end_source itself.

I will remove the TODO, it's obsolete.

Thanks,

C.
=20
>=20
>> +}
>> +
>> +static void xive_end_source_realize(DeviceState *dev, Error **errp)
>> +{
>> +    XiveENDSource *xsrc =3D XIVE_END_SOURCE(dev);
>> +    Object *obj;
>> +    Error *local_err =3D NULL;
>> +
>> +    obj =3D object_property_get_link(OBJECT(dev), "xive", &local_err)=
;
>> +    if (!obj) {
>> +        error_propagate(errp, local_err);
>> +        error_prepend(errp, "required link 'xive' not found: ");
>> +        return;
>> +    }
>> +
>> +    xsrc->xrtr =3D XIVE_ROUTER(obj);
>> +
>> +    if (!xsrc->nr_ends) {
>> +        error_setg(errp, "Number of interrupt needs to be greater tha=
n 0");
>> +        return;
>> +    }
>> +
>> +    if (xsrc->esb_shift !=3D XIVE_ESB_4K &&
>> +        xsrc->esb_shift !=3D XIVE_ESB_64K) {
>> +        error_setg(errp, "Invalid ESB shift setting");
>> +        return;
>> +    }
>> +
>> +    /*
>> +     * Each END is assigned an even/odd pair of MMIO pages, the even =
page
>> +     * manages the ESn field while the odd page manages the ESe field=
.
>> +     */
>> +    memory_region_init_io(&xsrc->esb_mmio, OBJECT(xsrc),
>> +                          &xive_end_source_ops, xsrc, "xive.end",
>> +                          (1ull << (xsrc->esb_shift + 1)) * xsrc->nr_=
ends);
>> +
>> +    qemu_register_reset(xive_source_end_reset, dev);
>> +}
>> +
>> +static Property xive_end_source_properties[] =3D {
>> +    DEFINE_PROP_UINT32("nr-ends", XiveENDSource, nr_ends, 0),
>> +    DEFINE_PROP_UINT32("shift", XiveENDSource, esb_shift, XIVE_ESB_64=
K),
>> +    DEFINE_PROP_END_OF_LIST(),
>> +};
>> +
>> +static void xive_end_source_class_init(ObjectClass *klass, void *data=
)
>> +{
>> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
>> +
>> +    dc->desc    =3D "XIVE END Source";
>> +    dc->props   =3D xive_end_source_properties;
>> +    dc->realize =3D xive_end_source_realize;
>> +}
>> +
>> +static const TypeInfo xive_end_source_info =3D {
>> +    .name          =3D TYPE_XIVE_END_SOURCE,
>> +    .parent        =3D TYPE_DEVICE,
>> +    .instance_size =3D sizeof(XiveENDSource),
>> +    .class_init    =3D xive_end_source_class_init,
>> +};
>> +
>>  /*
>>   * XIVE Fabric
>>   */
>> @@ -706,6 +874,7 @@ static void xive_register_types(void)
>>      type_register_static(&xive_source_info);
>>      type_register_static(&xive_fabric_info);
>>      type_register_static(&xive_router_info);
>> +    type_register_static(&xive_end_source_info);
>>  }
>> =20
>>  type_init(xive_register_types)
>=20
