Received: from eggs.gnu.org ([2001:4830:134:3::10]:45812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eID44-0005oS-6B
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 07:26:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eID3z-0003Qu-7v
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 07:26:40 -0500
Received: from 20.mo1.mail-out.ovh.net ([188.165.45.168]:45560)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eID3z-0003P7-1x
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 07:26:35 -0500
Received: from player795.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 508A4ADDB2
	for <qemu-devel@nongnu.org>; Fri, 24 Nov 2017 13:26:32 +0100 (CET)
References: <20171123132955.1261-1-clg@kaod.org>
	<20171123132955.1261-4-clg@kaod.org>
	<20171124110927.57c0ead2@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <8b327b16-2ee4-0257-7f0a-4e0fdb1ba7fd@kaod.org>
Date: Fri, 24 Nov 2017 12:26:21 +0000
MIME-Version: 1.0
In-Reply-To: <20171124110927.57c0ead2@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 03/25] spapr: introduce a
 spapr_icp_create() helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On 11/24/2017 10:09 AM, Greg Kurz wrote:
> On Thu, 23 Nov 2017 14:29:33 +0100
> C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>=20
>> On sPAPR, the creation of the interrupt presenter depends on some of
>> the machine attributes. When the XIVE interrupt mode is available,
>> this will get more complex. So provide a machine-level helper to
>> isolate the process and hide the details to the sPAPR core realize
>> function.
>>
>=20
> Not sure it makes sense to introduce this helper that early in the seri=
es...
> what about folding it in patch 23 where it is really needed ?

It does 'icp_type' and the 'xics_fabric' which are machine concepts=20
around the sPAPR interrupt controller model.
=20
But yes, it could come before patch 23. May be not folded, though.

C.


>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> ---
>>  hw/ppc/spapr.c          | 14 ++++++++++++++
>>  hw/ppc/spapr_cpu_core.c |  2 +-
>>  include/hw/ppc/spapr.h  |  2 ++
>>  3 files changed, 17 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index 174e7ff0678d..925cbd3c1bf4 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -3556,6 +3556,20 @@ static ICPState *spapr_icp_get(XICSFabric *xi, =
int vcpu_id)
>>      return cpu ? ICP(cpu->intc) : NULL;
>>  }
>> =20
>> +Object *spapr_icp_create(sPAPRMachineState *spapr, CPUState *cs, Erro=
r **errp)
>> +{
>> +    Error *local_err =3D NULL;
>> +    Object *obj;
>> +
>> +    obj =3D icp_create(cs, spapr->icp_type, XICS_FABRIC(spapr), &loca=
l_err);
>> +    if (local_err) {
>> +        error_propagate(errp, local_err);
>> +        return NULL;
>> +    }
>> +
>> +    return obj;
>> +}
>> +
>>  static void spapr_pic_print_info(InterruptStatsProvider *obj,
>>                                   Monitor *mon)
>>  {
>> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
>> index f7cc74512481..61a9850e688b 100644
>> --- a/hw/ppc/spapr_cpu_core.c
>> +++ b/hw/ppc/spapr_cpu_core.c
>> @@ -122,7 +122,7 @@ static void spapr_cpu_core_realize_child(Object *c=
hild,
>>          goto error;
>>      }
>> =20
>> -    cpu->intc =3D icp_create(cs, spapr->icp_type, XICS_FABRIC(spapr),=
 &local_err);
>> +    cpu->intc =3D spapr_icp_create(spapr, cs, &local_err);
>>      if (local_err) {
>>          goto error;
>>      }
>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
>> index 9d21ca9bde3a..9da38de34277 100644
>> --- a/include/hw/ppc/spapr.h
>> +++ b/include/hw/ppc/spapr.h
>> @@ -707,4 +707,6 @@ void spapr_do_system_reset_on_cpu(CPUState *cs, ru=
n_on_cpu_data arg);
>>  int spapr_vcpu_id(PowerPCCPU *cpu);
>>  PowerPCCPU *spapr_find_cpu(int vcpu_id);
>> =20
>> +Object *spapr_icp_create(sPAPRMachineState *spapr, CPUState *cs, Erro=
r **errp);
>> +
>>  #endif /* HW_SPAPR_H */
>=20
