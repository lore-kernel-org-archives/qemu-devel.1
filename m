Received: from eggs.gnu.org ([2001:4830:134:3::10]:43811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gVB8x-0001FH-Oh
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 03:05:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gVB8s-0002qH-1W
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 03:05:50 -0500
Received: from 1.mo4.mail-out.ovh.net ([178.33.248.196]:44520)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gVB8p-0002KC-GM
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 03:05:45 -0500
Received: from player787.ha.ovh.net (unknown [10.109.143.183])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 544261C50D9
	for <qemu-devel@nongnu.org>; Fri,  7 Dec 2018 09:05:37 +0100 (CET)
References: <20181205232251.10446-1-clg@kaod.org>
	<20181205232251.10446-12-clg@kaod.org>
	<20181207034649.GA10945@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <0416a307-f6dd-552b-3b57-04ce6c7b101a@kaod.org>
Date: Fri, 7 Dec 2018 09:05:31 +0100
MIME-Version: 1.0
In-Reply-To: <20181207034649.GA10945@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 11/37] spapr/xive: use the VCPU id as a
 NVT identifier
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

On 12/7/18 4:46 AM, David Gibson wrote:
> On Thu, Dec 06, 2018 at 12:22:25AM +0100, C=E9dric Le Goater wrote:
>> The IVPE scans the O/S CAM line of the XIVE thread interrupt contexts
>> to find a matching Notification Virtual Target (NVT) among the NVTs
>> dispatched on the HW processor threads.
>>
>> On a real system, the thread interrupt contexts are updated by the
>> hypervisor when a Virtual Processor is scheduled to run on a HW
>> thread. Under QEMU, the model will emulate the same behavior by
>> hardwiring the NVT identifier in the thread context registers at
>> reset.
>>
>> The NVT identifier used by the sPAPRXive model is the VCPU id. The END
>> identifier is also derived from the VCPU id. A set of helpers doing
>> the conversion between identifiers are provided for the hcalls
>> configuring the sources and the ENDs.
>>
>> The model does not need a NVT table but The XiveRouter NVT operations
>> are provided to perform some extra checks in the routing algorithm.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>> ---
>>  hw/intc/spapr_xive.c | 53 +++++++++++++++++++++++++++++++++++++++++++=
-
>>  1 file changed, 52 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
>> index eef5830d45c6..8da7a8bee949 100644
>> --- a/hw/intc/spapr_xive.c
>> +++ b/hw/intc/spapr_xive.c
>> @@ -26,6 +26,27 @@
>>  #define SPAPR_XIVE_VC_BASE   0x0006010000000000ull
>>  #define SPAPR_XIVE_TM_BASE   0x0006030203180000ull
>> =20
>> +/*
>> + * The allocation of VP blocks is a complex operation in OPAL and the
>> + * VP identifiers have a relation with the number of HW chips, the
>> + * size of the VP blocks, VP grouping, etc. The QEMU sPAPR XIVE
>> + * controller model does not have the same constraints and can use a
>> + * simple mapping scheme of the CPU vcpu_id
>> + *
>> + * These identifiers are never returned to the OS.
>> + */
>> +
>> +#define SPAPR_XIVE_NVT_BASE 0x400
>> +
>> +/*
>> + * sPAPR NVT and END indexing helpers
>> + */
>> +static uint32_t spapr_xive_nvt_to_target(sPAPRXive *xive, uint8_t nvt=
_blk,
>> +                                  uint32_t nvt_idx)
>> +{
>> +    return nvt_idx - SPAPR_XIVE_NVT_BASE;
>> +}
>> +
>>  /*
>>   * On sPAPR machines, use a simplified output for the XIVE END
>>   * structure dumping only the information related to the OS EQ.
>> @@ -40,7 +61,8 @@ static void spapr_xive_end_pic_print_info(sPAPRXive =
*xive, XiveEND *end,
>>      uint32_t nvt =3D GETFIELD_BE32(END_W6_NVT_INDEX, end->w6);
>>      uint8_t priority =3D GETFIELD_BE32(END_W7_F0_PRIORITY, end->w7);
>> =20
>> -    monitor_printf(mon, "%3d/%d % 6d/%5d ^%d", nvt,
>> +    monitor_printf(mon, "%3d/%d % 6d/%5d ^%d",
>> +                   spapr_xive_nvt_to_target(xive, 0, nvt),
>>                     priority, qindex, qentries, qgen);
>> =20
>>      xive_end_queue_pic_print_info(end, 6, mon);
>> @@ -246,6 +268,33 @@ static int spapr_xive_write_end(XiveRouter *xrtr,=
 uint8_t end_blk,
>>      return 0;
>>  }
>> =20
>> +static int spapr_xive_get_nvt(XiveRouter *xrtr,
>> +                              uint8_t nvt_blk, uint32_t nvt_idx, Xive=
NVT *nvt)
>> +{
>> +    sPAPRXive *xive =3D SPAPR_XIVE(xrtr);
>> +    uint32_t vcpu_id =3D spapr_xive_nvt_to_target(xive, nvt_blk, nvt_=
idx);
>> +    PowerPCCPU *cpu =3D spapr_find_cpu(vcpu_id);
>> +
>> +    if (!cpu) {
>> +        return -1;
>> +    }
>> +
>> +    /*
>> +     * sPAPR does not maintain a NVT table. Return that the NVT is
>> +     * valid if we have found a matching CPU
>> +     */
>> +    nvt->w0 =3D cpu_to_be32(NVT_W0_VALID);
>> +    return 0;
>> +}
>> +
>> +static int spapr_xive_write_nvt(XiveRouter *xrtr, uint8_t nvt_blk,
>> +                                uint32_t nvt_idx, XiveNVT *nvt,
>> +                                uint8_t word_number)
>> +{
>> +    /* no NVT table */
>> +    return 0;
>=20
> Should this ever get called.  IIUC, we don't need to write back to the
> NVTs because the papr machine should never hit a non-scheduled NVT.

yes.

> But in that case should this actually be a no-op, or should it be an
> g_assert_not_reached()?

We should never reach it because the get_nvt() should have failed
before in xive_presenter_notify() :

    ...
    /* NVT cache lookup */
    if (xive_router_get_nvt(xrtr, nvt_blk, nvt_idx, &nvt)) {
        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: no NVT %x/%x\n",
                      nvt_blk, nvt_idx);
        return;
    }
    ...

Leaving the machine in a curious state.

so for _write_nvt(), I think g_assert_not_reached() is appropriate and=20
I will add the comment you just made.

may be, I should add an 'assert(cpu)' in _get_nvt() also.
C.=20
