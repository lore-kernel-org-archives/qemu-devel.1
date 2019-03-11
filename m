Received: from eggs.gnu.org ([209.51.188.92]:50798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1h3Rnv-0003qI-2r
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 16:45:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1h3Rnt-000339-70
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 16:45:47 -0400
Received: from 7.mo69.mail-out.ovh.net ([46.105.50.32]:42916)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1h3Rnp-00031p-VF
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 16:45:43 -0400
Received: from player696.ha.ovh.net (unknown [10.109.143.223])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id CCF07464CA
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 21:45:39 +0100 (CET)
References: <20190222131322.26079-1-clg@kaod.org>
	<20190222131322.26079-8-clg@kaod.org>
	<20190226010246.GG6872@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <4ff22528-a871-8141-e871-2de5fbcce5c6@kaod.org>
Date: Mon, 11 Mar 2019 21:45:33 +0100
MIME-Version: 1.0
In-Reply-To: <20190226010246.GG6872@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 07/13] spapr/xive: fix migration of the
 XiveTCTX under TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 2/26/19 2:02 AM, David Gibson wrote:
> On Fri, Feb 22, 2019 at 02:13:16PM +0100, C=E9dric Le Goater wrote:
>> When the thread interrupt management state is retrieved from the KVM
>> VCPU, word2 is saved under the QEMU XIVE thread context to print out
>> the OS CAM line under the QEMU monitor.
>>
>> This breaks the migration of a TCG guest (and with KVM when
>> kernel_irqchip=3Doff) because the matching algorithm of the presenter
>> relies on the OS CAM value. Fix with an extra reset of the thread
>> contexts to restore the expected value.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>=20
> As noted elsewhere, I'm not sure this is the right approach to fixing
> this.  In any case this can be folded into the previous patch.

I have proposed an alternative in a response to :

 [PATCH v2 04/13] spapr/xive: add state synchronization with KVM=20

C.


>=20
>> ---
>>  hw/ppc/spapr_irq.c | 26 +++++++++++++++++++++++++-
>>  1 file changed, 25 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
>> index 12ecca6264f3..3176098b9f7c 100644
>> --- a/hw/ppc/spapr_irq.c
>> +++ b/hw/ppc/spapr_irq.c
>> @@ -356,7 +356,31 @@ static void spapr_irq_cpu_intc_create_xive(sPAPRM=
achineState *spapr,
>> =20
>>  static int spapr_irq_post_load_xive(sPAPRMachineState *spapr, int ver=
sion_id)
>>  {
>> -    return spapr_xive_post_load(spapr->xive, version_id);
>> +    CPUState *cs;
>> +    int ret;
>> +
>> +    ret =3D spapr_xive_post_load(spapr->xive, version_id);
>> +    if (ret) {
>> +        return ret;
>> +    }
>> +
>> +    /*
>> +     * When the states are collected from the KVM XIVE device, word2
>> +     * of the XiveTCTX is set to print out the OS CAM line under the
>> +     * QEMU monitor.
>> +     *
>> +     * This breaks the migration on a TCG guest (or on KVM with
>> +     * kernel_irqchip=3Doff) because the matching algorithm of the
>> +     * presenter relies on the OS CAM value. Fix with an extra reset
>> +     * of the thread contexts to restore the expected value.
>> +     */
>> +    CPU_FOREACH(cs) {
>> +        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
>> +
>> +        /* (TCG) Set the OS CAM line of the thread interrupt context.=
 */
>> +        spapr_xive_set_tctx_os_cam(spapr_cpu_state(cpu)->tctx);
>> +    }
>> +    return 0;
>>  }
>> =20
>>  static void spapr_irq_reset_xive(sPAPRMachineState *spapr, Error **er=
rp)
>=20
