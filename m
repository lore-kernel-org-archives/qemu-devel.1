Received: from eggs.gnu.org ([2001:4830:134:3::10]:47823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gQ5te-0008WF-Jc
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 02:29:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gQ5tZ-0003b5-FD
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 02:29:01 -0500
Received: from 13.mo3.mail-out.ovh.net ([188.165.33.202]:37339)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gQ5tY-00038X-OV
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 02:28:56 -0500
Received: from player693.ha.ovh.net (unknown [10.109.146.143])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 7526D1E9D0B
	for <qemu-devel@nongnu.org>; Fri, 23 Nov 2018 08:28:48 +0100 (CET)
References: <20181116105729.23240-1-clg@kaod.org>
	<20181116105729.23240-7-clg@kaod.org>
	<20181122051302.GG10448@umbus.fritz.box>
	<14e8b331-0c33-b07e-01ca-a540852bea37@kaod.org>
	<20181123043611.GZ10448@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <77c78ac1-d30c-b0ec-79af-d5a23085e39f@kaod.org>
Date: Fri, 23 Nov 2018 08:28:42 +0100
MIME-Version: 1.0
In-Reply-To: <20181123043611.GZ10448@umbus.fritz.box>
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

On 11/23/18 5:36 AM, David Gibson wrote:
> On Thu, Nov 22, 2018 at 10:58:56PM +0100, C=E9dric Le Goater wrote:
>> On 11/22/18 6:13 AM, David Gibson wrote:
>>> On Fri, Nov 16, 2018 at 11:56:59AM +0100, C=E9dric Le Goater wrote:
>>>> The Event Notification Descriptor also contains two Event State
>>>> Buffers providing further coalescing of interrupts, one for the
>>>> notification event (ESn) and one for the escalation events (ESe). A
>>>> MMIO page is assigned for each to control the EOI through loads
>>>> only. Stores are not allowed.
>>>>
>>>> The END ESBs are modeled through an object resembling the 'XiveSourc=
e'
>>>> It is stateless as the END state bits are backed into the XiveEND
>>>> structure under the XiveRouter and the MMIO accesses follow the same
>>>> rules as for the standard source ESBs.
>>>>
>>>> END ESBs are not supported by the Linux drivers neither on OPAL nor =
on
>>>> sPAPR. Nevetherless, it provides a mean to study the question in the
>>>> future and validates a bit more the XIVE model.
>>>>
>>>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>>>> ---
>>>>  include/hw/ppc/xive.h |  20 ++++++
>>>>  hw/intc/xive.c        | 160 +++++++++++++++++++++++++++++++++++++++=
++-
>>>>  2 files changed, 178 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
>>>> index ce62aaf28343..24301bf2076d 100644
>>>> --- a/include/hw/ppc/xive.h
>>>> +++ b/include/hw/ppc/xive.h
>>>> @@ -208,6 +208,26 @@ int xive_router_get_end(XiveRouter *xrtr, uint8=
_t end_blk, uint32_t end_idx,
>>>>  int xive_router_set_end(XiveRouter *xrtr, uint8_t end_blk, uint32_t=
 end_idx,
>>>>                          XiveEND *end);
>>>> =20
>>>> +/*
>>>> + * XIVE END ESBs
>>>> + */
>>>> +
>>>> +#define TYPE_XIVE_END_SOURCE "xive-end-source"
>>>> +#define XIVE_END_SOURCE(obj) \
>>>> +    OBJECT_CHECK(XiveENDSource, (obj), TYPE_XIVE_END_SOURCE)
>>>
>>> Is there a particular reason to make this a full QOM object, rather
>>> than just embedding it in the XiveRouter?
>>
>> yes, it should probably be under the XiveRouter you are right because
>> there is a direct link with the ENDT which is in the XiverRouter.=20
>>
>> But if I remove the chip_id field from the XiveRouter, it becomes a QO=
M
>> interface. something to ponder.
>=20
> Huh?  I really don't understand what you're saying here.  What does
> chip_id have to do with anything?

I am quoting a comment of yours :

	> +/*
	> + * XIVE Router
	> + */
	> +
	> +typedef struct XiveRouter {
	> +    SysBusDevice    parent;
	> +
	> +    uint32_t        chip_id;

	I don't think this belongs in the base class.  The PowerNV specific
	variants will need it, but it doesn't make sense for the PAPR version.


If we remove 'chip_id' from XiveRouter, it can become a QOM interface=20
without state, like the XiveFabric is.

C.=20
