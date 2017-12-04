Received: from eggs.gnu.org ([2001:4830:134:3::10]:55974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eLshk-0005hj-NR
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 10:30:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eLshh-0002OT-Cz
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 10:30:48 -0500
Received: from 17.mo3.mail-out.ovh.net ([87.98.178.58]:39396)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eLshh-0002Np-7V
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 10:30:45 -0500
Received: from player732.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 9D9D7178083
	for <qemu-devel@nongnu.org>; Mon,  4 Dec 2017 16:30:42 +0100 (CET)
References: <20171123132955.1261-1-clg@kaod.org>
	<20171123132955.1261-22-clg@kaod.org>
	<20171204075208.GT2130@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <c24567a8-1dd0-2914-0f42-faf251fe3311@kaod.org>
Date: Mon, 4 Dec 2017 16:30:36 +0100
MIME-Version: 1.0
In-Reply-To: <20171204075208.GT2130@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 21/25] spapr: introduce a helper to map the
 XIVE memory regions
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

On 12/04/2017 08:52 AM, David Gibson wrote:
> On Thu, Nov 23, 2017 at 02:29:51PM +0100, C=E9dric Le Goater wrote:
>> When the XIVE interrupt mode is activated, the machine needs to expose
>> to the guest the MMIO regions use by the controller :
>>
>>   - Event State Buffer (ESB)
>>   - Thread Interrupt Management Area (TIMA)
>>
>> Migration will also need to reflect the current interrupt mode in use.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>> ---
>>  hw/intc/spapr_xive_hcall.c  | 14 ++++++++++++++
>>  hw/ppc/spapr.c              |  5 +++++
>>  include/hw/ppc/spapr_xive.h |  1 +
>>  3 files changed, 20 insertions(+)
>>
>> diff --git a/hw/intc/spapr_xive_hcall.c b/hw/intc/spapr_xive_hcall.c
>> index 60c6c9f4be8f..ba217144878e 100644
>> --- a/hw/intc/spapr_xive_hcall.c
>> +++ b/hw/intc/spapr_xive_hcall.c
>> @@ -933,3 +933,17 @@ void spapr_xive_populate(sPAPRMachineState *spapr=
, int nr_servers,
>>      _FDT(fdt_setprop(fdt, 0, "ibm,plat-res-int-priorities",
>>                       plat_res_int_priorities, sizeof(plat_res_int_pri=
orities)));
>>  }
>> +
>> +void spapr_xive_mmio_map(sPAPRMachineState *spapr)
>> +{
>> +    sPAPRXive *xive =3D spapr->xive;
>> +
>> +    /* ESBs */
>> +    sysbus_mmio_map(SYS_BUS_DEVICE(xive), 0, xive->esb_base);
>> +
>> +    /* Thread Management Interrupt Areas */
>> +    /* TODO: Only map the OS TIMA for the moment. Mapping the whole
>> +     * region needs some rework in the handlers */
>> +    sysbus_mmio_map(SYS_BUS_DEVICE(xive), 1,
>> +                    xive->tm_base + (1 << xive->tm_shift));
>=20
> You probably shouldn't be exposing the user TIMA in the DT if you're
> only allowing the OS TIME to be mapped.

The specs requires to map both Uset and OS TIMA.

>=20
>> +}
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index 3a62369883cc..734706c18cb3 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -1132,6 +1132,7 @@ static void *spapr_build_fdt(sPAPRMachineState *=
spapr,
>>      } else {
>>          /* Populate device tree for XIVE */
>>          spapr_xive_populate(spapr, xics_max_server_number(), fdt, PHA=
NDLE_XICP);
>> +        spapr_xive_mmio_map(spapr);
>=20
> This doesn't belong here, spapr_build_fdt() should _just_ build the
> fdt, not have side effects on the actual device state.

Yes. I will move the rest of the XIVE setup in the reset handler
before the device tree is built.

Thanks,

C. =20

>>      }
>> =20
>>      ret =3D spapr_populate_memory(spapr, fdt);
>> @@ -1613,6 +1614,10 @@ static int spapr_post_load(void *opaque, int ve=
rsion_id)
>>          }
>>      }
>> =20
>> +    if (spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
>> +        spapr_xive_mmio_map(spapr);
>> +    }
>> +
>>      return err;
>>  }
>> =20
>> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
>> index f6d4bf26e06a..88355f7eb643 100644
>> --- a/include/hw/ppc/spapr_xive.h
>> +++ b/include/hw/ppc/spapr_xive.h
>> @@ -84,5 +84,6 @@ typedef struct sPAPRMachineState sPAPRMachineState;
>>  void spapr_xive_hcall_init(sPAPRMachineState *spapr);
>>  void spapr_xive_populate(sPAPRMachineState *spapr, int nr_servers, vo=
id *fdt,
>>                           uint32_t phandle);
>> +void spapr_xive_mmio_map(sPAPRMachineState *spapr);
>> =20
>>  #endif /* PPC_SPAPR_XIVE_H */
>=20
