Received: from eggs.gnu.org ([2001:4830:134:3::10]:54263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dr7w6-0004nj-DT
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 15:30:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dr7w3-0007R2-2Y
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 15:30:30 -0400
Received: from 14.mo3.mail-out.ovh.net ([188.165.43.98]:44279)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dr7w2-0007PK-Sq
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 15:30:26 -0400
Received: from player758.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 4C0F514D1C1
	for <qemu-devel@nongnu.org>; Sun, 10 Sep 2017 21:30:25 +0200 (CEST)
References: <20170908143344.12960-1-clg@kaod.org>
	<20170908143344.12960-4-clg@kaod.org>
	<20170910031942.GZ2735@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <48cf83e0-8404-3b1e-2bac-7a0443756ac2@kaod.org>
Date: Sun, 10 Sep 2017 21:30:18 +0200
MIME-Version: 1.0
In-Reply-To: <20170910031942.GZ2735@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 3/3] spapr: generate a CAS reset for
 the XIVE exploitation mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

On 09/10/2017 05:19 AM, David Gibson wrote:
> On Fri, Sep 08, 2017 at 04:33:44PM +0200, C=E9dric Le Goater wrote:
>> When the platform and the guest agree on using the XIVE exploitation
>> mode for interrupts, the "interrupt-controller" node needs to reflect
>> the change and the device tree needs an update.
>>
>> Reseting the guest after the CAS negotiation makes this change
>> possible, as the device tree is built at reset time. We use the
>> 'ov5_cas' field to check which interrupt model was negotiated before
>> reset and populate the tree accordingly.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>=20
> Looks reasonable, though I'm not going to apply it until we actually
> have something to go..

Yes. I agree. A simplified XIVE patchset for sPAPR should be ready=20
soon for comments. Please see below for one question.

>> ---
>>  hw/ppc/spapr.c       | 6 +++++-
>>  hw/ppc/spapr_hcall.c | 6 ++++++
>>  2 files changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index 3e3ff1fbc988..be467ab61ad0 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -1073,7 +1073,11 @@ static void *spapr_build_fdt(sPAPRMachineState =
*spapr,
>>      _FDT(fdt_setprop_cell(fdt, 0, "#size-cells", 2));
>> =20
>>      /* /interrupt controller */
>> -    spapr_dt_xics(xics_max_server_number(), fdt, PHANDLE_XICP);
>> +    if (!spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
>> +        spapr_dt_xics(xics_max_server_number(), fdt, PHANDLE_XICP);
>> +    } else {
>> +        /* populate device tree for XIVE */ ;
>=20
> .. here.

How should we handle the PHANDLE_XICP for xive ? as it is done
for xics ?=20

The DT node is now :	"interrupt-controller@6030203180000"

>> +    }
>> =20
>>      ret =3D spapr_populate_memory(spapr, fdt);
>>      if (ret < 0) {
>> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
>> index 92f1e21358b8..ba00b8d3fdd6 100644
>> --- a/hw/ppc/spapr_hcall.c
>> +++ b/hw/ppc/spapr_hcall.c
>> @@ -1613,6 +1613,12 @@ static target_ulong h_client_architecture_suppo=
rt(PowerPCCPU *cpu,
>>              (spapr_h_cas_compose_response(spapr, args[1], args[2],
>>                                            ov5_updates) !=3D 0);
>>      }
>> +
>> +    /* We need to rebuild the device tree for XIVE, generate a reset =
*/
>> +    if (!spapr->cas_reboot) {
>> +        spapr->cas_reboot =3D spapr_ovec_test(ov5_updates, OV5_XIVE_E=
XPLOIT);
>> +    }
>=20
> At some point we may well want to make XIVE exploitation the default
> for POWER9 guests, but that's a detail easily adjusted later.

ah yes. we can do that.

Thanks,

C.=20
=20
>>      spapr_ovec_cleanup(ov5_updates);
>> =20
>>      if (spapr->cas_reboot) {
>=20
