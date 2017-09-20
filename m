Received: from eggs.gnu.org ([2001:4830:134:3::10]:36144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1duf1X-0002g9-Tp
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:27:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1duf10-0003qm-2v
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:26:43 -0400
Received: from 6.mo2.mail-out.ovh.net ([87.98.165.38]:49074)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1duf0z-0003qM-Tr
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:26:10 -0400
Received: from player157.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 83FDEAC831
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 11:47:25 +0200 (CEST)
References: <20170911171235.29331-1-clg@kaod.org>
	<20170911171235.29331-15-clg@kaod.org> <20170919075506.GR27153@umbus>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <13fdab3c-6af7-780a-ad1e-9ea64a5d660c@kaod.org>
Date: Wed, 20 Sep 2017 11:47:19 +0200
MIME-Version: 1.0
In-Reply-To: <20170919075506.GR27153@umbus>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v2 14/21] ppc/xive: add support for the
 SET_OS_PENDING command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, Alexander Graf <agraf@suse.de>

On 09/19/2017 09:55 AM, David Gibson wrote:
> On Mon, Sep 11, 2017 at 07:12:28PM +0200, C=E9dric Le Goater wrote:
>> Adjusting the Interrupt Pending Buffer for the O/S would allow a CPU
>> to process event queues of other priorities during one physical
>> interrupt cycle. This is not currently used by the XIVE support for
>> sPAPR in Linux but it is by the hypervisor.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>> ---
>>  hw/intc/spapr_xive.c | 9 ++++++++-
>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
>> index ad3ff91b13ea..ad3f03e37401 100644
>> --- a/hw/intc/spapr_xive.c
>> +++ b/hw/intc/spapr_xive.c
>> @@ -162,7 +162,14 @@ static bool spapr_xive_tm_is_readonly(uint8_t ind=
ex)
>>  static void spapr_xive_tm_write_special(ICPState *icp, hwaddr offset,
>>                                    uint64_t value, unsigned size)
>>  {
>> -    /* TODO: support TM_SPC_SET_OS_PENDING */
>> +    if (offset =3D=3D TM_SPC_SET_OS_PENDING && size =3D=3D 1) {
>> +        icp->tima_os[TM_IPB] |=3D priority_to_ipb(value & 0xff);
>> +        icp->tima_os[TM_PIPR] =3D ipb_to_pipr(icp->tima_os[TM_IPB]);
>=20
> This only lets the cpu raise bits in the IPB, never clear them.> Is tha=
t right? =20

The clear is done when the OS acks the interrupt.

> I don't see how you'd implement the handling of multiple
> priorities without being able to clear bits here.

I am not sure how this command should be used from the OS.=20
Currently, I only see KVM handling it in the XICS/XIVE glue.
I need to take a closer look.

C.
=20


>> +        spapr_xive_icp_notify(icp);
>> +    } else {
>> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid TIMA write @%"
>> +                      HWADDR_PRIx" size %d\n", offset, size);
>> +    }
>> =20
>>      /* TODO: support TM_SPC_ACK_OS_EL */
>>  }
>=20
