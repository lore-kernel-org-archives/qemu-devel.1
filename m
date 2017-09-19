Received: from eggs.gnu.org ([2001:4830:134:3::10]:34234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1duOCg-0006uW-C1
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 15:29:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1duOCb-00007I-Se
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 15:29:06 -0400
Received: from 2.mo2.mail-out.ovh.net ([188.165.53.149]:52696)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1duOCb-00006P-ME
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 15:29:01 -0400
Received: from player157.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 7A82CAC0E2
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 21:29:00 +0200 (CEST)
References: <20170911171235.29331-1-clg@kaod.org>
	<20170911171235.29331-10-clg@kaod.org> <20170919073615.GN27153@umbus>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <52f31e9e-f7de-ae27-a8a6-bd2f37666659@kaod.org>
Date: Tue, 19 Sep 2017 21:28:45 +0200
MIME-Version: 1.0
In-Reply-To: <20170919073615.GN27153@umbus>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v2 09/21] ppc/xive: extend the
 interrupt presenter model for XIVE
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

On 09/19/2017 09:36 AM, David Gibson wrote:
> On Mon, Sep 11, 2017 at 07:12:23PM +0200, C=E9dric Le Goater wrote:
>> The XIVE interrupt presenter exposes a set of Thread Interrupt
>> Management Areas, also called rings, one per different level of
>> privilege (four in all). This area is used to handle priority
>> management and interrupt acknowledgment among other things.
>>
>> We extend the ICPState object with a cache of the register data for
>> XIVE. The integration with the sPAPR machine is much easier and we
>> need a common framework to switch from one controller model to
>> another: XICS <-> XIVE.
>=20
> This sounds like an even worse idea than referencing the ICS state.

ok ok.

> The TIMA really needs to be managed by a different object than the ICP.

like an array under the machine indexed by the cpu index ?=20

at some point, we will need to :

    PowerPCCPU *cpu =3D POWERPC_CPU(current_cpu);
    ICPState *icp =3D ICP(cpu->intc);

and=20

    icp =3D xics_icp_get(xive->ics->xics, target);


isn't the cpu->intc pointer  the best option to hold that information ?=20
and it is migrated.

C.=20


>> The next patch will introduce the MMIO handlers to interact with the
>> TIMA, OS only, which is required for the sPAPR support.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>> ---
>>  hw/intc/xics.c        | 4 ++++
>>  include/hw/ppc/xics.h | 6 ++++++
>>  2 files changed, 10 insertions(+)
>>
>> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
>> index a84ba51ad8ff..927d4fec966a 100644
>> --- a/hw/intc/xics.c
>> +++ b/hw/intc/xics.c
>> @@ -274,6 +274,7 @@ static const VMStateDescription vmstate_icp_server=
 =3D {
>>          VMSTATE_UINT32(xirr, ICPState),
>>          VMSTATE_UINT8(pending_priority, ICPState),
>>          VMSTATE_UINT8(mfrr, ICPState),
>> +        VMSTATE_UINT8_ARRAY(tima, ICPState, 0x40),
>>          VMSTATE_END_OF_LIST()
>>      },
>>  };
>> @@ -293,6 +294,7 @@ static void icp_reset(void *dev)
>>      if (icpc->reset) {
>>          icpc->reset(icp);
>>      }
>> +    memset(icp->tima, 0, sizeof(icp->tima));
>>  }
>> =20
>>  static void icp_realize(DeviceState *dev, Error **errp)
>> @@ -343,6 +345,8 @@ static void icp_realize(DeviceState *dev, Error **=
errp)
>>          icpc->realize(icp, errp);
>>      }
>> =20
>> +    icp->tima_os =3D &icp->tima[0x10];
>> +
>>      qemu_register_reset(icp_reset, dev);
>>      vmstate_register(NULL, icp->cs->cpu_index, &vmstate_icp_server, i=
cp);
>>  }
>> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
>> index 28d248abad61..c835997303c4 100644
>> --- a/include/hw/ppc/xics.h
>> +++ b/include/hw/ppc/xics.h
>> @@ -83,6 +83,12 @@ struct ICPState {
>>      qemu_irq output;
>> =20
>>      XICSFabric *xics;
>> +
>> +    /* XIVE section */
>> +#define XIVE_TM_RING_COUNT 4
>> +
>> +    uint8_t tima[XIVE_TM_RING_COUNT * 0x10];
>> +    uint8_t *tima_os;
>>  };
>> =20
>>  #define ICP_PROP_XICS "xics"
>=20
