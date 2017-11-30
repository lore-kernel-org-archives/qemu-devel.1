Received: from eggs.gnu.org ([2001:4830:134:3::10]:41144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eKP9R-0000pr-0X
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 08:45:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eKP9H-0008N8-FZ
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 08:45:17 -0500
Received: from 17.mo6.mail-out.ovh.net ([46.105.36.150]:50865)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eKP9H-0008KY-9x
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 08:45:07 -0500
Received: from player696.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id DA7F812635C
	for <qemu-devel@nongnu.org>; Thu, 30 Nov 2017 14:44:57 +0100 (CET)
References: <20171123132955.1261-1-clg@kaod.org>
	<20171123132955.1261-13-clg@kaod.org>
	<20171129051110.GI3023@umbus.fritz.box>
	<b0fd23cc-bc15-8023-69da-508ce5f6d0fe@kaod.org>
	<20171130040604.GV3023@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <d35fe0fe-ae4a-3bba-ac74-ea07701d331b@kaod.org>
Date: Thu, 30 Nov 2017 13:44:51 +0000
MIME-Version: 1.0
In-Reply-To: <20171130040604.GV3023@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 12/25] spapr: introduce a XIVE interrupt
 presenter model
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

On 11/30/2017 04:06 AM, David Gibson wrote:
> On Wed, Nov 29, 2017 at 10:55:34AM +0100, C=E9dric Le Goater wrote:
>> On 11/29/2017 06:11 AM, David Gibson wrote:
>>> On Thu, Nov 23, 2017 at 02:29:42PM +0100, C=E9dric Le Goater wrote:
>>>> The XIVE interrupt presenter exposes a set of rings, also called
>>>> Thread Interrupt Management Areas (TIMA), to handle priority
>>>> management and interrupt acknowledgment among other things. There is
>>>> one ring per level of privilege, four in all. The one we are
>>>> interested in for the sPAPR machine is the OS ring.
>>>>
>>>> The TIMA is mapped at the same address for each CPU. 'current_cpu' i=
s
>>>> used to retrieve the targeted interrupt presenter object holding the
>>>> cache data of the registers the model use.
>>>>
>>>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>>>> ---
>>>>  hw/intc/spapr_xive.c        | 271 +++++++++++++++++++++++++++++++++=
+++++++++++
>>>>  hw/intc/xive-internal.h     |  89 +++++++++++++++
>>>>  include/hw/ppc/spapr_xive.h |  11 ++
>>>>  3 files changed, 371 insertions(+)
>>>>
>>>> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
>>>> index b1e3f8710cff..554b25e0884c 100644
>>>> --- a/hw/intc/spapr_xive.c
>>>> +++ b/hw/intc/spapr_xive.c
>>>> @@ -23,9 +23,166 @@
>>>>  #include "sysemu/dma.h"
>>>>  #include "monitor/monitor.h"
>>>>  #include "hw/ppc/spapr_xive.h"
>>>> +#include "hw/ppc/xics.h"
>>>> =20
>>>>  #include "xive-internal.h"
>>>> =20
>>>> +struct sPAPRXiveICP {
>>>
>>> I'd really prefer to avoid calling anything in xive "icp" to avoid
>>> confusion with xics.
>>
>> OK.=20
>>
>> The specs refers to the whole as an IVPE : Interrupt Virtualization=20
>> Presentation Engine. In our model, we use the TIMA cached values of=20
>> the OS ring and the qemu_irq for the CPU line.=20
>>
>> Would 'sPAPRXivePresenter' be fine ?
>=20
> That'd be ok.  Or call if sPAPRIVPE.  Or even call it TIMA.  I'd be
> fine with any of those.

In this model, I am making a lot of shortcuts in the XIVE concepts
(which I don't master completely yet ...)=20

The IVPE is the part of the overall controller doing the interrupt=20
presentation.

The TIMA refers to the MMIO region in which the thread interrupt=20
management is done.=20

The XIVE structure that contains the 'virtual processor' interrupt=20
state is the NVT: Notification Virtual Target. An index to an NVT=20
is stored in the EQs to do the routing. I did not introduce the NVT=20
in sPAPRXive because it's rather big, 128 bytes, and we don't need=20
much of it (NSR, CPPR, PIPR, IPB) but we could use a shorten one.

So I think sPAPRXiveNVT, or sPAPRXiveVP (VP for virtual processor)
would be better names.

We will need more of the NVT structure to support the hcalls=20
doing the set and the get of the address of the Reporting Cache=20
line (H_INT_{S,G}ET_OS_REPORTING_LINE). We can extend it when=20
time comes. =20

C.
