Received: from eggs.gnu.org ([2001:4830:134:3::10]:54253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gWfUg-0001X3-8D
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 05:42:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gWfUa-0004ei-Az
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 05:42:26 -0500
Received: from 9.mo177.mail-out.ovh.net ([46.105.72.238]:45711)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gWfUW-0004bs-3j
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 05:42:16 -0500
Received: from player738.ha.ovh.net (unknown [10.109.159.69])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 28E27D4F5C
	for <qemu-devel@nongnu.org>; Tue, 11 Dec 2018 11:42:09 +0100 (CET)
References: <20181209194610.29727-1-clg@kaod.org>
	<20181209194610.29727-19-clg@kaod.org>
	<39e8edd0-6056-5b51-174b-631dcb267ff5@kaod.org>
	<20181211020620.GG4261@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <744ff9f8-6f84-00d4-a2e0-84652658762e@kaod.org>
Date: Tue, 11 Dec 2018 11:42:03 +0100
MIME-Version: 1.0
In-Reply-To: <20181211020620.GG4261@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 18/19] spapr: add a 'pseries-4.0-xive'
 machine type
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

On 12/11/18 3:06 AM, David Gibson wrote:
> On Mon, Dec 10, 2018 at 11:17:33PM +0100, C=E9dric Le Goater wrote:
>> On 12/9/18 8:46 PM, C=E9dric Le Goater wrote:
>>> This pseries machine makes use of a new sPAPR IRQ backend supporting
>>> the XIVE interrupt mode.
>>>
>>> The guest OS is required to have support for the XIVE exploitation
>>> mode of the POWER9 interrupt controller.
>>>
>>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>>> ---
>>>  hw/ppc/spapr.c | 15 +++++++++++++++
>>>  1 file changed, 15 insertions(+)
>>>
>>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>>> index 4012ebd794a4..3cc134a0b673 100644
>>> --- a/hw/ppc/spapr.c
>>> +++ b/hw/ppc/spapr.c
>>> @@ -3985,6 +3985,21 @@ static void spapr_machine_4_0_class_options(Ma=
chineClass *mc)
>>> =20
>>>  DEFINE_SPAPR_MACHINE(4_0, "4.0", true);
>>> =20
>>> +static void spapr_machine_4_0_xive_instance_options(MachineState *ma=
chine)
>>> +{
>>> +    spapr_machine_4_0_instance_options(machine);
>>> +}
>>> +
>>> +static void spapr_machine_4_0_xive_class_options(MachineClass *mc)
>>> +{
>>> +    sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
>>> +
>>> +    spapr_machine_4_0_class_options(mc);> +    smc->irq =3D &spapr_i=
rq_xive;
>>
>> I have been adding checks on the CPU model to export the XIVE capabili=
ty=20
>> only on POWER9 processors but it breaks some of the tests.
>>
>> I was wondering if we could add a default POWER9 CPU to the -xive mach=
ine :=20
>>
>>   + mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power9_v2.0");
>>
>> and if we could change tests/cpu-plug-test.c with :
>>
>>   @@ -198,8 +198,13 @@ static void add_pseries_test_case(const
>>        }
>>        data =3D g_new(PlugTestData, 1);
>>        data->machine =3D g_strdup(mname);
>>   -    data->cpu_model =3D "power8_v2.0";
>>   -    data->device_model =3D g_strdup("power8_v2.0-spapr-cpu-core");
>>   +    if (g_str_has_suffix(mname, "xive")) {
>>   +        data->cpu_model =3D "power9_v2.0";
>>   +        data->device_model =3D g_strdup("power9_v2.0-spapr-cpu-core=
");
>>   +    } else {
>>   +        data->cpu_model =3D "power8_v2.0";
>>   +        data->device_model =3D g_strdup("power8_v2.0-spapr-cpu-core=
");
>>   +    }
>>        data->sockets =3D 2;
>>        data->cores =3D 3;
>>        data->threads =3D 1;
>>
>> or if there is a better way ?
>=20
> So, I'd actually prefer a machine option, rather than wholly separate
> machine types to select xics/xive/dual.  Machine types was fine while
> prototyping this, but I don't think we want to actually merge new
> machine types for it.

I agree.=20

> So, instead I think we want a machine option which can be set to
> xics/xive/dual, with xics being the default for earlier machine types
> and dual the default for 4.0 onwards.

I will revive an old patch doing just that.=20

The question now is how to link the sPAPRMachineState instance to=20
the selected sPAPR IRQ backend.=20

I don't think we can move 'smc->irq' to sPAPRMachineState. So we will
need an helper returning the appropriate backend depending on the machine=
=20
option and 'smc->irq' should disappear.

> We can make POWER9 the default cpu for 4.0 onwards as well, if you want=
.

OK.

C.
