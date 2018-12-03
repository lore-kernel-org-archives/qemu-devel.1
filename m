Received: from eggs.gnu.org ([2001:4830:134:3::10]:39520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gTqwp-0006yp-5a
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 11:19:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gTqwl-0004fl-VP
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 11:19:51 -0500
Received: from 1.mo68.mail-out.ovh.net ([46.105.41.146]:46838)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gTqwl-0004Zw-OH
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 11:19:47 -0500
Received: from player691.ha.ovh.net (unknown [10.109.159.7])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 3EEF1108729
	for <qemu-devel@nongnu.org>; Mon,  3 Dec 2018 17:19:45 +0100 (CET)
References: <20181116105729.23240-1-clg@kaod.org>
	<20181116105729.23240-7-clg@kaod.org>
	<20181122051302.GG10448@umbus.fritz.box>
	<390808b9-250e-e1ae-ea54-fcf47b309833@kaod.org>
	<20181130010410.GE30479@umbus.fritz.box>
	<d8ba2082-625f-b547-47af-416148c04e9c@kaod.org>
	<20181203011406.GP30479@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <dcfe41e1-fd62-3b2c-fb7e-426ac3f32a88@kaod.org>
Date: Mon, 3 Dec 2018 17:19:38 +0100
MIME-Version: 1.0
In-Reply-To: <20181203011406.GP30479@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 06/36] ppc/xive: add support for the END
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

On 12/3/18 2:14 AM, David Gibson wrote:
> On Fri, Nov 30, 2018 at 07:41:33AM +0100, C=E9dric Le Goater wrote:
>> On 11/30/18 2:04 AM, David Gibson wrote:
>>> On Thu, Nov 29, 2018 at 11:06:13PM +0100, C=E9dric Le Goater wrote:
>>>> On 11/22/18 6:13 AM, David Gibson wrote:
>>>>> On Fri, Nov 16, 2018 at 11:56:59AM +0100, C=E9dric Le Goater wrote:
>>>>>> The Event Notification Descriptor also contains two Event State
>>>>>> Buffers providing further coalescing of interrupts, one for the
>>>>>> notification event (ESn) and one for the escalation events (ESe). =
A
>>>>>> MMIO page is assigned for each to control the EOI through loads
>>>>>> only. Stores are not allowed.
>>>>>>
>>>>>> The END ESBs are modeled through an object resembling the 'XiveSou=
rce'
>>>>>> It is stateless as the END state bits are backed into the XiveEND
>>>>>> structure under the XiveRouter and the MMIO accesses follow the sa=
me
>>>>>> rules as for the standard source ESBs.
>>>>>>
>>>>>> END ESBs are not supported by the Linux drivers neither on OPAL no=
r on
>>>>>> sPAPR. Nevetherless, it provides a mean to study the question in t=
he
>>>>>> future and validates a bit more the XIVE model.
>>>>>>
>>>>>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>>>>>> ---
>>>>>>  include/hw/ppc/xive.h |  20 ++++++
>>>>>>  hw/intc/xive.c        | 160 +++++++++++++++++++++++++++++++++++++=
++++-
>>>>>>  2 files changed, 178 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
>>>>>> index ce62aaf28343..24301bf2076d 100644
>>>>>> --- a/include/hw/ppc/xive.h
>>>>>> +++ b/include/hw/ppc/xive.h
>>>>>> @@ -208,6 +208,26 @@ int xive_router_get_end(XiveRouter *xrtr, uin=
t8_t end_blk, uint32_t end_idx,
>>>>>>  int xive_router_set_end(XiveRouter *xrtr, uint8_t end_blk, uint32=
_t end_idx,
>>>>>>                          XiveEND *end);
>>>>>> =20
>>>>>> +/*
>>>>>> + * XIVE END ESBs
>>>>>> + */
>>>>>> +
>>>>>> +#define TYPE_XIVE_END_SOURCE "xive-end-source"
>>>>>> +#define XIVE_END_SOURCE(obj) \
>>>>>> +    OBJECT_CHECK(XiveENDSource, (obj), TYPE_XIVE_END_SOURCE)
>>>>>
>>>>> Is there a particular reason to make this a full QOM object, rather
>>>>> than just embedding it in the XiveRouter?
>>>>
>>>> Coming back on this question because removing the chip_id from the
>>>> router is a problem for the END triggering. At least with the curren=
t
>>>> design. See below for the comment.
>>>>
>>>>>> +typedef struct XiveENDSource {
>>>>>> +    SysBusDevice parent;
>>>>>> +
>>>>>> +    uint32_t        nr_ends;
>>>>>> +
>>>>>> +    /* ESB memory region */
>>>>>> +    uint32_t        esb_shift;
>>>>>> +    MemoryRegion    esb_mmio;
>>>>>> +
>>>>>> +    XiveRouter      *xrtr;
>>>>>> +} XiveENDSource;
>>>>>> +
>>>>>>  /*
>>>>>>   * For legacy compatibility, the exceptions define up to 256 diff=
erent
>>>>>>   * priorities. P9 implements only 9 levels : 8 active levels [0 -=
 7]
>>>>>> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
>>>>>> index 9cb001e7b540..5a8882d47a98 100644
>>>>>> --- a/hw/intc/xive.c
>>>>>> +++ b/hw/intc/xive.c
>>>>>> @@ -622,8 +622,18 @@ static void xive_router_end_notify(XiveRouter=
 *xrtr, uint8_t end_blk,
>>>>>>       * even futher coalescing in the Router
>>>>>>       */
>>>>>>      if (!(end.w0 & END_W0_UCOND_NOTIFY)) {
>>>>>> -        qemu_log_mask(LOG_UNIMP, "XIVE: !UCOND_NOTIFY not impleme=
nted\n");
>>>>>> -        return;
>>>>>> +        uint8_t pq =3D GETFIELD(END_W1_ESn, end.w1);
>>>>>> +        bool notify =3D xive_esb_trigger(&pq);
>>>>>> +
>>>>>> +        if (pq !=3D GETFIELD(END_W1_ESn, end.w1)) {
>>>>>> +            end.w1 =3D SETFIELD(END_W1_ESn, end.w1, pq);
>>>>>> +            xive_router_set_end(xrtr, end_blk, end_idx, &end);
>>>>>> +        }
>>>>>> +
>>>>>> +        /* ESn[Q]=3D1 : end of notification */
>>>>>> +        if (!notify) {
>>>>>> +            return;
>>>>>> +        }
>>>>>>      }
>>>>>> =20
>>>>>>      /*
>>>>>> @@ -706,6 +716,151 @@ void xive_eas_pic_print_info(XiveEAS *eas, u=
int32_t lisn, Monitor *mon)
>>>>>>                     (uint32_t) GETFIELD(EAS_END_DATA, eas->w));
>>>>>>  }
>>>>>> =20
>>>>>> +/*
>>>>>> + * END ESB MMIO loads
>>>>>> + */
>>>>>> +static uint64_t xive_end_source_read(void *opaque, hwaddr addr, u=
nsigned size)
>>>>>> +{
>>>>>> +    XiveENDSource *xsrc =3D XIVE_END_SOURCE(opaque);
>>>>>> +    XiveRouter *xrtr =3D xsrc->xrtr;
>>>>>> +    uint32_t offset =3D addr & 0xFFF;
>>>>>> +    uint8_t end_blk;
>>>>>> +    uint32_t end_idx;
>>>>>> +    XiveEND end;
>>>>>> +    uint32_t end_esmask;
>>>>>> +    uint8_t pq;
>>>>>> +    uint64_t ret =3D -1;
>>>>>> +
>>>>>> +    end_blk =3D xrtr->chip_id;
>>>>>> +    end_idx =3D addr >> (xsrc->esb_shift + 1);
>>>>>> +    if (xive_router_get_end(xrtr, end_blk, end_idx, &end)) {
>>>>
>>>> The current END accessors require a block identifier, hence xrtr->ch=
ip_id,=20
>>>> but in this case, we don't really need it because we are using the E=
NDT=20
>>>> local to the router/chip.=20
>>>
>>>> I don't know how to handle simply this case without keeping chip_id =
:/
>>>
>>> I don't really follow how chip_id is relevant here.  AFAICT the END
>>> accessors take a block id and the back end is responsible for
>>> interpreting them.  The ponwernv one will map it to chip id, but the
>>> PAPR one can just ignore it or only use block 0.
>>
>> Yes. But the block value comes from the xrtr->chip_id today, on PAPR a=
nd
>> PowerNV, even if it's block 0.=20
>>
>> What I could do is add a "chip-id" property to XiveENDSource possibly.
>=20
> This still seems wrong for the PAPR model.=20

We don't really care for PAPR. We can use 0 but the model is common
with PowerNV.

> Why can't you configure the end_block value directly in the Xive=20
> components,=20

That is what I am proposing to add a "chip-id" property to XiveENDSource=20

> then just set it equal to the chip_id when you build the powernv=20
> machine?

yes. that's how it's more or less built. It's a little more complex
on PowerNV because there are low level settings on how the chip_id is
used in the PC and VC, but the modeling is minimal.

C.
