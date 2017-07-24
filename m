Received: from eggs.gnu.org ([2001:4830:134:3::10]:35673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dZdgH-0006P1-Eq
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 09:45:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dZdgE-00018y-7H
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 09:45:53 -0400
Received: from 8.mo3.mail-out.ovh.net ([87.98.172.249]:43423)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dZdgE-000174-0q
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 09:45:50 -0400
Received: from player732.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id EFD5A123C3A
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 15:45:47 +0200 (CEST)
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
	<1499274819-15607-11-git-send-email-clg@kaod.org>
	<20170724051151.GG17228@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <9dd093b0-5fd5-8b4c-50c7-cb876b365125@kaod.org>
Date: Mon, 24 Jul 2017 15:45:42 +0200
MIME-Version: 1.0
In-Reply-To: <20170724051151.GG17228@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 10/26] ppc/xive: record interrupt
 source MMIO address for hcalls
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

On 07/24/2017 07:11 AM, David Gibson wrote:
> On Wed, Jul 05, 2017 at 07:13:23PM +0200, C=E9dric Le Goater wrote:
>> The address of the MMIO page through which the Event State Buffer is
>> controlled is returned to the guest by the H_INT_GET_SOURCE_INFO hcall=
.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>> ---
>>  hw/intc/xive.c        | 3 +++
>>  include/hw/ppc/xive.h | 1 +
>>  2 files changed, 4 insertions(+)
>>
>> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
>> index a1cb87a07b76..0db97fd33981 100644
>> --- a/hw/intc/xive.c
>> +++ b/hw/intc/xive.c
>> @@ -344,6 +344,9 @@ static void xive_ics_realize(ICSState *ics, Error =
**errp)
>>                                  ICS_BASE(xs)->offset * (1 << xs->esb_=
shift),
>>                                  &xs->esb_iomem);
>> =20
>> +    /* Record base address which is needed by the hcalls */
>> +    xs->esb_base =3D x->vc_base + ICS_BASE(xs)->offset * (1 << xs->es=
b_shift);
>=20
> This doesn't seem like it needs to be stored in the persistent object
> - it can be calculated when the hcall is made.  Plus if it's for the
> hcll it only makes sense for spapr.

yes. you are right. I will get rid of it.

Thanks,

C.=20

>>      qemu_register_reset(xive_ics_reset, xs);
>>  }
>> =20
>> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
>> index 1178300c9df3..b06bc861b845 100644
>> --- a/include/hw/ppc/xive.h
>> +++ b/include/hw/ppc/xive.h
>> @@ -43,6 +43,7 @@ struct XiveICSState {
>> =20
>>      uint64_t     flags;
>>      uint32_t     esb_shift;
>> +    hwaddr       esb_base;
>>      MemoryRegion esb_iomem;
>> =20
>>      XIVE         *xive;
>=20
