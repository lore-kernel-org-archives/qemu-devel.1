Received: from eggs.gnu.org ([2001:4830:134:3::10]:60479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dZdOT-00019G-8F
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 09:27:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dZdOP-0007SY-5P
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 09:27:29 -0400
Received: from 14.mo3.mail-out.ovh.net ([188.165.43.98]:42819)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dZdOO-0007PU-Uu
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 09:27:25 -0400
Received: from player732.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 5DCB1123D5E
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 15:27:23 +0200 (CEST)
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
	<1499274819-15607-10-git-send-email-clg@kaod.org>
	<20170724044948.GF17228@umbus.fritz.box>
	<1500876571.10674.58.camel@kernel.crashing.org>
	<20170724063905.GN17228@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <6443f6d1-7e30-cb8c-0e18-a2aa7bd32ef9@kaod.org>
Date: Mon, 24 Jul 2017 15:27:18 +0200
MIME-Version: 1.0
In-Reply-To: <20170724063905.GN17228@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 09/26] ppc/xive: add an overall memory
 region for the ESBs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 07/24/2017 08:39 AM, David Gibson wrote:
> On Mon, Jul 24, 2017 at 04:09:31PM +1000, Benjamin Herrenschmidt wrote:
>> On Mon, 2017-07-24 at 14:49 +1000, David Gibson wrote:
>>> On Wed, Jul 05, 2017 at 07:13:22PM +0200, C=E9dric Le Goater wrote:
>>>> Each source adds its own ESB mempry region to the overall ESB memory
>>>> region of the controller. It will be mapped in the CPU address space
>>>> when XIVE is activated.
>>>>
>>>> The default mapping address for the ESB memory region is the same on=
e
>>>> used on baremetal.
>>>>
>>>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>>>> ---
>>>>  hw/intc/xive-internal.h |  5 +++++
>>>>  hw/intc/xive.c          | 44 ++++++++++++++++++++++++++++++++++++++=
+++++-
>>>>  2 files changed, 48 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/hw/intc/xive-internal.h b/hw/intc/xive-internal.h
>>>> index 8e755aa88a14..c06be823aad0 100644
>>>> --- a/hw/intc/xive-internal.h
>>>> +++ b/hw/intc/xive-internal.h
>>>> @@ -98,6 +98,7 @@ struct XIVE {
>>>>      SysBusDevice parent;
>>>> =20
>>>>      /* Properties */
>>>> +    uint32_t     chip_id;
>>>
>>> So there is a XIVE object per chip.  How does this work on PAPR?  One
>>> logical chip/XIVE, or something more complex?
>>
>> One global XIVE for PAPR. For the MMIOs, the way it works is that:
>>
>>  - For MMIOs pertaining to a specific interrupt or queue, there's an H=
-
>> call that will return the proper "guest physical" address. For qemu
>> with KVM we'll have to probably create a single chunk of qemu address
>> space (a single mem region) that contains individual pages mapped with
>> MAP_FIXED originating from the different HW bits, we still need to sor=
t
>> out how exactly we'll do that in practice.
>>
>>  - For the TIMA (the presentation MMIOs), those are always at the same
>> physical address for everybody (so for a guest it's a single memory
>> region we'll map to that physical address), the HW "knows" which HW
>> thread is talking to it (and the hypervisor tells the HW which vcpu is
>> running on a given HW thread at a given point in time). That address i=
s
>> obtained from the device-tree
>=20
> Ok.  That leaves "chip_id" as a rather surprising thing to see in an
> object which will appear on PAPR.

We could also pass the address as a property instead of the chip-id when
creating the XIVE object. May be better for sPAPR.

C. =20
