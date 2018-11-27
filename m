Received: from eggs.gnu.org ([2001:4830:134:3::10]:47061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gRXpo-0002x6-5m
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 02:31:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gRXpk-0002q4-4A
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 02:31:04 -0500
Received: from 15.mo1.mail-out.ovh.net ([188.165.38.232]:50697)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gRXpj-0002pR-Ti
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 02:31:00 -0500
Received: from player794.ha.ovh.net (unknown [10.109.159.222])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 07A90146B91
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 08:30:57 +0100 (CET)
References: <20181116105729.23240-1-clg@kaod.org>
	<20181116105729.23240-3-clg@kaod.org>
	<20181122031934.GC10448@umbus.fritz.box>
	<75cdc1f3-f337-3c37-b234-d96222a370d2@kaod.org>
	<20181123010852.GT10448@umbus.fritz.box>
	<8270d5fc-ab20-f47d-37d8-1e2ba179fbfd@kaod.org>
	<20181126053947.GG2251@umbus.fritz.box>
	<23a938ba-d2bc-8a9d-07ef-6672a8cc3a93@kaod.org>
	<20181126234818.GK2251@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <de9a16b7-6086-0084-2f59-35004553083a@kaod.org>
Date: Tue, 27 Nov 2018 08:30:52 +0100
MIME-Version: 1.0
In-Reply-To: <20181126234818.GK2251@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 02/36] ppc/xive: add support for the LSI
 interrupt sources
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

On 11/27/18 12:48 AM, David Gibson wrote:
> On Mon, Nov 26, 2018 at 12:20:19PM +0100, C=E9dric Le Goater wrote:
>> On 11/26/18 6:39 AM, David Gibson wrote:
>>> On Fri, Nov 23, 2018 at 02:28:35PM +0100, C=E9dric Le Goater wrote:
>>>>
>>>>>>>> +/*
>>>>>>>> + * Returns whether the event notification should be forwarded.
>>>>>>>> + */
>>>>>>>> +static bool xive_source_lsi_trigger(XiveSource *xsrc, uint32_t
>>>>>>>> srcno)
>>>>>>>
>>>>>>> What exactly "trigger" means isn't entirely obvious for an LSI.  =
Might
>>>>>>> be clearer to have "lsi_assert" and "lsi_deassert" helpers instea=
d.
>>>>>>
>>>>>> This is called only when the interrupt is asserted. So it is a=20
>>>>>> simplified LSI trigger depending only on the 'P' bit.
>>>>>
>>>>> Yes, I see that.  But the result is that while the MSI logic is
>>>>> encapsulated in the MSI trigger function, this leaves the LSI logic
>>>>> split across the trigger function and set_irq() itself. I think it=20
>>>>> would be better to have assert and deassert helpers instead, which
>>>>> handle both the trigger/notification and also the updating of the
>>>>> ASSERTED bit.
>>>>
>>>> Something like the xive_source_set_irq_lsi() below ?
>>>
>>> Uh.. not exactly what I had in mind, but close enough.
>>>
>>> [snip]
>>> +/*
>>>> + * Returns whether the event notification should be forwarded.
>>>> + */
>>>>  static bool xive_source_esb_trigger(XiveSource *xsrc, uint32_t srcn=
o)
>>>>  {
>>>> +    bool notify;
>>>> +
>>>>      assert(srcno < xsrc->nr_irqs);
>>>> =20
>>>> -    return xive_esb_trigger(&xsrc->status[srcno]);
>>>> +    notify =3D xive_esb_trigger(&xsrc->status[srcno]);
>>>> +
>>>> +    if (xive_source_irq_is_lsi(xsrc, srcno) &&
>>>
>>> Except that this block can go, since this function is no longer calle=
d
>>> for LSIs.
>>
>> It still can be through the ESB MMIOs, if the guest does a load on the=
=20
>> trigger page.
>=20
> Oh, good point.  That makes me rethink all my comments on this matter.
>=20
> In that case I think your original code was fine, except that I'd
> prefer to see the setting of the ASSERTED bit inside the trigger
> function, instead of in the set_irq() caller.

ok. I will change that.

Thanks,

C.=20


>=20
>=20
>>
>> C.
>>
>> =20
>>>
>>>> +        xive_source_esb_get(xsrc, srcno) =3D=3D XIVE_ESB_QUEUED) {
>>>> +        qemu_log_mask(LOG_GUEST_ERROR,
>>>> +                      "XIVE: queued an event on LSI IRQ %d\n", srcn=
o);
>>>> +    }
>>>> +
>>>> +    return notify;
>>>>  }
>>>> =20
>>>>  /*
>>>> @@ -103,9 +127,22 @@ static bool xive_source_esb_trigger(Xive
>>>>   */
>>>>  static bool xive_source_esb_eoi(XiveSource *xsrc, uint32_t srcno)
>>>>  {
>>>> +    bool notify;
>>>> +
>>>>      assert(srcno < xsrc->nr_irqs);
>>>> =20
>>>> -    return xive_esb_eoi(&xsrc->status[srcno]);
>>>> +    notify =3D xive_esb_eoi(&xsrc->status[srcno]);
>>>> +
>>>> +    /* LSI sources do not set the Q bit but they can still be
>>>> +     * asserted, in which case we should forward a new event
>>>> +     * notification
>>>> +     */
>>>> +    if (xive_source_irq_is_lsi(xsrc, srcno)) {
>>>> +        bool level =3D xsrc->status[srcno] & XIVE_STATUS_ASSERTED;
>>>> +        notify =3D xive_source_set_irq_lsi(xsrc, srcno, level);
>>>> +    }
>>>> +
>>>> +    return notify;
>>>>  }
>>>> =20
>>>>  /*
>>>> @@ -268,8 +305,12 @@ static void xive_source_set_irq(void *op
>>>>      XiveSource *xsrc =3D XIVE_SOURCE(opaque);
>>>>      bool notify =3D false;
>>>> =20
>>>> -    if (val) {
>>>> -        notify =3D xive_source_esb_trigger(xsrc, srcno);
>>>> +    if (xive_source_irq_is_lsi(xsrc, srcno)) {
>>>> +        notify =3D xive_source_set_irq_lsi(xsrc, srcno, val);
>>>> +    } else {
>>>> +        if (val) {
>>>> +            notify =3D xive_source_esb_trigger(xsrc, srcno);
>>>> +        }
>>>>      }
>>>> =20
>>>>      /* Forward the source event notification for routing */
>>>> @@ -289,9 +330,11 @@ void xive_source_pic_print_info(XiveSour
>>>>              continue;
>>>>          }
>>>> =20
>>>> -        monitor_printf(mon, "  %08x %c%c\n", i + offset,
>>>> +        monitor_printf(mon, "  %08x %s %c%c%c\n", i + offset,
>>>> +                       xive_source_irq_is_lsi(xsrc, i) ? "LSI" : "M=
SI",
>>>>                         pq & XIVE_ESB_VAL_P ? 'P' : '-',
>>>> -                       pq & XIVE_ESB_VAL_Q ? 'Q' : '-');
>>>> +                       pq & XIVE_ESB_VAL_Q ? 'Q' : '-',
>>>> +                       xsrc->status[i] & XIVE_STATUS_ASSERTED ? 'A'=
 : ' ');
>>>>      }
>>>>  }
>>>> =20
>>>> @@ -299,6 +342,8 @@ static void xive_source_reset(DeviceStat
>>>>  {
>>>>      XiveSource *xsrc =3D XIVE_SOURCE(dev);
>>>> =20
>>>> +    /* Do not clear the LSI bitmap */
>>>> +
>>>>      /* PQs are initialized to 0b01 which corresponds to "ints off" =
*/
>>>>      memset(xsrc->status, 0x1, xsrc->nr_irqs);
>>>>  }
>>>> @@ -324,6 +369,7 @@ static void xive_source_realize(DeviceSt
>>>>                                       xsrc->nr_irqs);
>>>> =20
>>>>      xsrc->status =3D g_malloc0(xsrc->nr_irqs);
>>>> +    xsrc->lsi_map =3D bitmap_new(xsrc->nr_irqs);
>>>> =20
>>>>      memory_region_init_io(&xsrc->esb_mmio, OBJECT(xsrc),
>>>>                            &xive_source_esb_ops, xsrc, "xive.esb",
>>>>
>>>
>>
>=20
