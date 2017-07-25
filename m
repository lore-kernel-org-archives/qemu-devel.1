Received: from eggs.gnu.org ([2001:4830:134:3::10]:37477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dZvzN-0002vm-1F
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 05:18:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dZvzJ-00009i-R6
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 05:18:49 -0400
Received: from 6.mo1.mail-out.ovh.net ([46.105.43.205]:56179)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dZvzJ-00009H-Kg
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 05:18:45 -0400
Received: from player795.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id B0B4C88F6A
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 11:18:43 +0200 (CEST)
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
	<1499274819-15607-20-git-send-email-clg@kaod.org>
	<6e9f8817-2ecc-4ea3-8f22-17496b520bb4@ozlabs.ru>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <d0e51819-6ee3-67ca-d736-fe7f37ef84c8@kaod.org>
Date: Tue, 25 Jul 2017 11:18:34 +0200
MIME-Version: 1.0
In-Reply-To: <6e9f8817-2ecc-4ea3-8f22-17496b520bb4@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [RFC PATCH 19/26] ppc/xive: introduce a
 helper to map the XIVE memory regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 07/25/2017 04:54 AM, Alexey Kardashevskiy wrote:
> On 06/07/17 03:13, C=C3=A9dric Le Goater wrote:
>> It will be used when the guest chooses the XIVE exploitation mode in
>> CAS.
>>
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> ---
>>  hw/intc/xive.c        | 11 +++++++++++
>>  include/hw/ppc/xive.h |  2 ++
>>  2 files changed, 13 insertions(+)
>>
>> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
>> index cda1fa18e44d..895dd2b2f61b 100644
>> --- a/hw/intc/xive.c
>> +++ b/hw/intc/xive.c
>> @@ -915,3 +915,14 @@ bool xive_eq_for_target(XIVE *x, uint32_t target,=
 uint8_t priority,
>> =20
>>      return true;
>>  }
>> +
>> +void xive_mmio_map(XIVE *x)
>> +{
>> +    /* ESBs */
>> +    sysbus_mmio_map(SYS_BUS_DEVICE(x), 0, x->vc_base);
>> +
>> +    /* Thread Management Interrupt Areas */
>> +    /* TODO: Only map the OS TIMA for the moment. Mapping the whole
>> +     * region needs some rework in the handlers */
>> +    sysbus_mmio_map(SYS_BUS_DEVICE(x), 1, x->tm_base + (1 << x->tm_sh=
ift));
>> +}
>=20
>=20
> imho it makes more sense to squash such small patches (this one and 20/=
26,
> 21/26) into those which actually make use of the new helpers - easier t=
o
> review, better for bisectability.

ok. I am also realizing we should unmap.

Thanks,

C.
=20
>=20
>> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
>> index 288116aeb8f4..560f6ab66f73 100644
>> --- a/include/hw/ppc/xive.h
>> +++ b/include/hw/ppc/xive.h
>> @@ -68,4 +68,6 @@ typedef struct sPAPRMachineState sPAPRMachineState;
>>  void xive_spapr_init(sPAPRMachineState *spapr);
>>  void xive_spapr_populate(XIVE *x, void *fdt);
>> =20
>> +void xive_mmio_map(XIVE *x);
>> +
>>  #endif /* PPC_XIVE_H */
>>
>=20
>=20
