Received: from eggs.gnu.org ([2001:4830:134:3::10]:38758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gVAtA-0001hK-IW
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 02:49:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gVAt6-00029q-3I
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 02:49:32 -0500
Received: from 5.mo178.mail-out.ovh.net ([46.105.51.53]:45302)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gVAt5-00027g-PE
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 02:49:27 -0500
Received: from player770.ha.ovh.net (unknown [10.109.143.18])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 39CDB42968
	for <qemu-devel@nongnu.org>; Fri,  7 Dec 2018 08:49:26 +0100 (CET)
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
References: <20181205232251.10446-1-clg@kaod.org>
	<20181205232251.10446-5-clg@kaod.org>
	<20181206034124.GM768@umbus.fritz.box>
	<0ed7f319-7ae1-e407-96c1-266463d2a472@kaod.org>
	<20181207015753.GW768@umbus.fritz.box>
Message-ID: <bb2b0691-2366-cb73-4407-af16a812725b@kaod.org>
Date: Fri, 7 Dec 2018 08:49:21 +0100
MIME-Version: 1.0
In-Reply-To: <20181207015753.GW768@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 04/37] ppc/xive: introduce the
 XiveRouter model
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

On 12/7/18 2:57 AM, David Gibson wrote:
> On Thu, Dec 06, 2018 at 07:22:54AM +0100, C=E9dric Le Goater wrote:
>> On 12/6/18 4:41 AM, David Gibson wrote:
>>> On Thu, Dec 06, 2018 at 12:22:18AM +0100, C=E9dric Le Goater wrote:
>>>> The XiveRouter models the second sub-engine of the XIVE architecture=
 :
>>>> the Interrupt Virtualization Routing Engine (IVRE).
>>>>
>>>> The IVRE handles event notifications of the IVSE and performs the
>>>> interrupt routing process. For this purpose, it uses a set of tables
>>>> stored in system memory, the first of which being the Event Assignme=
nt
>>>> Structure (EAS) table.
>>>>
>>>> The EAT associates an interrupt source number with an Event Notifica=
tion
>>>> Descriptor (END) which will be used in a second phase of the routing
>>>> process to identify a Notification Virtual Target.
>>>>
>>>> The XiveRouter is an abstract class which needs to be inherited from
>>>> to define a storage for the EAT, and other upcoming tables.
>>>>
>>>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>>>> ---
>>>>  include/hw/ppc/xive.h      | 31 ++++++++++++++++
>>>>  include/hw/ppc/xive_regs.h | 50 +++++++++++++++++++++++++
>>>>  hw/intc/xive.c             | 76 +++++++++++++++++++++++++++++++++++=
+++
>>>>  3 files changed, 157 insertions(+)
>>>>  create mode 100644 include/hw/ppc/xive_regs.h
>>>>
>>>> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
>>>> index 6770cffec67d..57ec9f84f527 100644
>>>> --- a/include/hw/ppc/xive.h
>>>> +++ b/include/hw/ppc/xive.h
>>>> @@ -141,6 +141,8 @@
>>>>  #define PPC_XIVE_H
>>>> =20
>>>>  #include "hw/qdev-core.h"
>>>> +#include "hw/sysbus.h"
>>>> +#include "hw/ppc/xive_regs.h"
>>>> =20
>>>>  /*
>>>>   * XIVE Fabric (Interface between Source and Router)
>>>> @@ -297,4 +299,33 @@ static inline void xive_source_irq_set(XiveSour=
ce *xsrc, uint32_t srcno,
>>>>      }
>>>>  }
>>>> =20
>>>> +/*
>>>> + * XIVE Router
>>>> + */
>>>> +
>>>> +typedef struct XiveRouter {
>>>> +    SysBusDevice    parent;
>>>
>>> I thought the plan was to make XiveRouter as well as XiveSource a
>>> TYPE_DEVICE descendent rather than a SysBusDevice?
>>
>> We start talking about that, indeed, but then :
>>
>> 	https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg06407.html
>>
>> I thought we concluded that it was going to get too complex.
>>
>> Also, sPAPRXive is a direct descendant of XiveRouter and we want sPAPR=
Xive=20
>> on SysBus.
>=20
> Ah, good point.  So, to clarify my thinking here - I think from a
> theoretical point of view, having XiveRouter not be sysbus and
> including it by composition is probably the "correct" approach.

One possible solution would be to transform the XiveRouter in a QOM=20
interface, this will be possible when I have removed the chip_id field,
and define the VST accessors as we do today. I am not sure how QOM=20
interfaces are considered, but I think they are more in the composition=20
pattern than inheritance. That way, we could have sPAPRXive directly=20
inherit from SysBusDevice.

I can give it a try for v7, and you could merge the small XiveRouter=20
changes in the current XiveRouter patch.

> But I can also see that that will be a bit of a pain in practice.  So
> yes, keeping it as a SysBusDevice is ok, at least as long as any
> migration stuff is in the "outermost" / most specific type, which I
> believe it is.

By this sentence, you mean that we don't rely on the XiveRouter model=20
to capture the sPAPRXive state ?=20

Thanks,

C.=20
=20
