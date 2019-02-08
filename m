Received: from eggs.gnu.org ([209.51.188.92]:50831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gs0L6-0004Js-JS
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 02:12:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gs0L3-0002cb-JS
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 02:12:44 -0500
Received: from 1.mo2.mail-out.ovh.net ([46.105.63.121]:47527)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gs0L2-0002N1-6u
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 02:12:40 -0500
Received: from player791.ha.ovh.net (unknown [10.109.143.146])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id CC546183CA3
	for <qemu-devel@nongnu.org>; Fri,  8 Feb 2019 08:12:17 +0100 (CET)
References: <20190107183946.7230-1-clg@kaod.org>
	<20190107183946.7230-7-clg@kaod.org>
	<20190208053554.GC12810@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <36cd0056-a8b6-7128-5bf4-d5a479d99d76@kaod.org>
Date: Fri, 8 Feb 2019 08:12:12 +0100
MIME-Version: 1.0
In-Reply-To: <20190208053554.GC12810@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 06/13] spapr/xive: fix migration of the
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
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 2/8/19 6:36 AM, David Gibson wrote:
> On Mon, Jan 07, 2019 at 07:39:39PM +0100, C=E9dric Le Goater wrote:
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
> Why is the CAM value you get from KVM different from the one you
> expect in qemu?

An NVT base identifier is allocated for each VM at the OPAL level
and each vCPU getd an increment of this value. It is pushed in the=20
OS CAM line when the vCPU is scheduled to run.
=20
KVM XIVE names this identifier a VP id.=20

The QEMU emulation of XIVE uses a fixed value for the NVT base=20
identifier.

C.

=20
>> ---
>>  hw/ppc/spapr_irq.c | 26 +++++++++++++++++++++++++-
>>  1 file changed, 25 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
>> index 233c97c5ecd9..ba27d9d8e972 100644
>> --- a/hw/ppc/spapr_irq.c
>> +++ b/hw/ppc/spapr_irq.c
>> @@ -363,7 +363,31 @@ static void spapr_irq_cpu_intc_create_xive(sPAPRM=
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
>> +        spapr_xive_set_tctx_os_cam(cpu->tctx);
>> +    }
>> +    return 0;
>>  }
>> =20
>>  static void spapr_irq_reset_xive(sPAPRMachineState *spapr, Error **er=
rp)
>=20
