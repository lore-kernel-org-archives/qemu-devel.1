Received: from eggs.gnu.org ([2001:4830:134:3::10]:51200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ct7qg-0002D4-Sa
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 03:16:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ct7qd-0005lX-O7
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 03:16:54 -0400
Received: from 3.mo2.mail-out.ovh.net ([46.105.58.226]:43906)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1ct7qd-0005lJ-Hg
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 03:16:51 -0400
Received: from player718.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 6341A78AC6
	for <qemu-devel@nongnu.org>; Wed, 29 Mar 2017 09:16:50 +0200 (CEST)
References: <1490686352-24017-1-git-send-email-clg@kaod.org>
	<1490686352-24017-8-git-send-email-clg@kaod.org>
	<20170329052023.GA21068@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <ff97bcd4-6f9a-e7de-3d30-8f42a0ec30c0@kaod.org>
Date: Wed, 29 Mar 2017 09:16:47 +0200
MIME-Version: 1.0
In-Reply-To: <20170329052023.GA21068@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 7/8] ppc/pnv: link the CPUs to the
 machine XICSFabric
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 03/29/2017 07:20 AM, David Gibson wrote:
> On Tue, Mar 28, 2017 at 09:32:31AM +0200, C=E9dric Le Goater wrote:
>> This assigns the ICPState object to the CPU using the PIR number for
>> lookups before calling the XICS layer to finish the job.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
>> ---
>>  hw/ppc/pnv.c      |  2 ++
>>  hw/ppc/pnv_core.c | 20 ++++++++++++++++----
>>  2 files changed, 18 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
>> index e441b8ac1cad..ae894834892f 100644
>> --- a/hw/ppc/pnv.c
>> +++ b/hw/ppc/pnv.c
>> @@ -711,6 +711,8 @@ static void pnv_chip_realize(DeviceState *dev, Err=
or **errp)
>>          object_property_set_int(OBJECT(pnv_core),
>>                                  pcc->core_pir(chip, core_hwid),
>>                                  "pir", &error_fatal);
>> +        object_property_add_const_link(OBJECT(pnv_core), "xics",
>> +                                       qdev_get_machine(), &error_fat=
al);
>>          object_property_set_bool(OBJECT(pnv_core), true, "realized",
>>                                   &error_fatal);
>>          object_unref(OBJECT(pnv_core));
>> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
>> index d79d530b4881..a5e9614dac7d 100644
>> --- a/hw/ppc/pnv_core.c
>> +++ b/hw/ppc/pnv_core.c
>> @@ -25,6 +25,7 @@
>>  #include "hw/ppc/pnv.h"
>>  #include "hw/ppc/pnv_core.h"
>>  #include "hw/ppc/pnv_xscom.h"
>> +#include "hw/ppc/xics.h"
>> =20
>>  static void powernv_cpu_reset(void *opaque)
>>  {
>> @@ -43,7 +44,7 @@ static void powernv_cpu_reset(void *opaque)
>>      env->msr |=3D MSR_HVB; /* Hypervisor mode */
>>  }
>> =20
>> -static void powernv_cpu_init(PowerPCCPU *cpu, Error **errp)
>> +static void powernv_cpu_init(PowerPCCPU *cpu, XICSFabric *xi, Error *=
*errp)
>>  {
>>      CPUPPCState *env =3D &cpu->env;
>>      int core_pir;
>> @@ -63,6 +64,9 @@ static void powernv_cpu_init(PowerPCCPU *cpu, Error =
**errp)
>>      cpu_ppc_tb_init(env, PNV_TIMEBASE_FREQ);
>> =20
>>      qemu_register_reset(powernv_cpu_reset, cpu);
>> +
>> +    cpu->icp =3D OBJECT(xics_icp_get(xi, pir->default_value));
>> +    xics_cpu_setup(xi, cpu);
>=20
> Hmm.. seems like xics_cpu_setup() should probably set the cpu->icp link=
..

OK. It is not problem, and I have to change 'PATCH 1' anyhow.

Thanks,

C.
=20
>=20
>>  }
>> =20
>>  /*
>> @@ -110,7 +114,7 @@ static const MemoryRegionOps pnv_core_xscom_ops =3D=
 {
>>      .endianness =3D DEVICE_BIG_ENDIAN,
>>  };
>> =20
>> -static void pnv_core_realize_child(Object *child, Error **errp)
>> +static void pnv_core_realize_child(Object *child, XICSFabric *xi, Err=
or **errp)
>>  {
>>      Error *local_err =3D NULL;
>>      CPUState *cs =3D CPU(child);
>> @@ -122,7 +126,7 @@ static void pnv_core_realize_child(Object *child, =
Error **errp)
>>          return;
>>      }
>> =20
>> -    powernv_cpu_init(cpu, &local_err);
>> +    powernv_cpu_init(cpu, xi, &local_err);
>>      if (local_err) {
>>          error_propagate(errp, local_err);
>>          return;
>> @@ -140,6 +144,14 @@ static void pnv_core_realize(DeviceState *dev, Er=
ror **errp)
>>      void *obj;
>>      int i, j;
>>      char name[32];
>> +    Object *xi;
>> +
>> +    xi =3D object_property_get_link(OBJECT(dev), "xics", &local_err);
>> +    if (!xi) {
>> +        error_setg(errp, "%s: required link 'xics' not found: %s",
>> +                   __func__, error_get_pretty(local_err));
>> +        return;
>> +    }
>> =20
>>      pc->threads =3D g_malloc0(size * cc->nr_threads);
>>      for (i =3D 0; i < cc->nr_threads; i++) {
>> @@ -160,7 +172,7 @@ static void pnv_core_realize(DeviceState *dev, Err=
or **errp)
>>      for (j =3D 0; j < cc->nr_threads; j++) {
>>          obj =3D pc->threads + j * size;
>> =20
>> -        pnv_core_realize_child(obj, &local_err);
>> +        pnv_core_realize_child(obj, XICS_FABRIC(xi), &local_err);
>>          if (local_err) {
>>              goto err;
>>          }
>=20
