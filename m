Received: from eggs.gnu.org ([2001:4830:134:3::10]:53131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dr7pl-0003IP-Lk
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 15:23:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dr7pi-0003r5-HN
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 15:23:57 -0400
Received: from 5.mo3.mail-out.ovh.net ([87.98.178.36]:57902)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dr7pi-0003p9-BJ
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 15:23:54 -0400
Received: from player758.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id BBEDB150369
	for <qemu-devel@nongnu.org>; Sun, 10 Sep 2017 21:23:49 +0200 (CEST)
References: <20170908143344.12960-1-clg@kaod.org>
	<20170908143344.12960-3-clg@kaod.org>
	<20170910031731.GY2735@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <093c41a2-abaa-ce97-a93c-e4b475b67e2d@kaod.org>
Date: Sun, 10 Sep 2017 21:23:42 +0200
MIME-Version: 1.0
In-Reply-To: <20170910031731.GY2735@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/3] spapr: fix CAS-generated reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, Sam Bobroff <sam.bobroff@au1.ibm.com>

On 09/10/2017 05:17 AM, David Gibson wrote:
> On Fri, Sep 08, 2017 at 04:33:43PM +0200, C=E9dric Le Goater wrote:
>> The OV5_MMU_RADIX_300 requires special handling in the CAS negotiation
>> process. It is cleared from the option vector of the guest before
>> evaluating the changes and re-added later. But, when testing for a
>> possible CAS reset :
>>
>>     spapr->cas_reboot =3D spapr_ovec_diff(ov5_updates,
>>                                         ov5_cas_old, spapr->ov5_cas);
>>
>> the bit OV5_MMU_RADIX_300 will each time be seen as removed from the
>> previous OV5 set, hence generating a reset loop.
>>
>> Fix this problem by also clearing the same bit in the ov5_cas_old set.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>=20
> Kind of an ugly hack, =20

yes. I lack context to fully understand why the guest radix option is
handled that way.=20

> but probably the easiest fix for now. Applied to ppc-for-2.11.

Thanks,

C.

>=20
>> ---
>>  hw/ppc/spapr_hcall.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
>> index 07b3da8dc4cd..92f1e21358b8 100644
>> --- a/hw/ppc/spapr_hcall.c
>> +++ b/hw/ppc/spapr_hcall.c
>> @@ -1575,6 +1575,13 @@ static target_ulong h_client_architecture_suppo=
rt(PowerPCCPU *cpu,
>>       * to worry about this for now.
>>       */
>>      ov5_cas_old =3D spapr_ovec_clone(spapr->ov5_cas);
>> +
>> +    /* also clear the radix/hash bit from the current ov5_cas bits to
>> +     * be in sync with the newly ov5 bits. Else the radix bit will be
>> +     * seen as being removed and this will generate a reset loop
>> +     */
>> +    spapr_ovec_clear(ov5_cas_old, OV5_MMU_RADIX_300);
>> +
>>      /* full range of negotiated ov5 capabilities */
>>      spapr_ovec_intersect(spapr->ov5_cas, spapr->ov5, ov5_guest);
>>      spapr_ovec_cleanup(ov5_guest);
>=20
