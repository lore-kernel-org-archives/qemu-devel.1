Received: from eggs.gnu.org ([2001:4830:134:3::10]:58364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gWTsE-0003PJ-0p
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 17:17:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gWTsA-0002g6-0o
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 17:17:57 -0500
Received: from 5.mo173.mail-out.ovh.net ([46.105.40.148]:49608)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gWTs6-0002KS-B8
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 17:17:51 -0500
Received: from player159.ha.ovh.net (unknown [10.109.160.226])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 2242EE5A17
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 23:17:40 +0100 (CET)
References: <20181209194610.29727-1-clg@kaod.org>
	<20181209194610.29727-19-clg@kaod.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <39e8edd0-6056-5b51-174b-631dcb267ff5@kaod.org>
Date: Mon, 10 Dec 2018 23:17:33 +0100
MIME-Version: 1.0
In-Reply-To: <20181209194610.29727-19-clg@kaod.org>
Content-Type: text/plain; charset=utf-8
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

On 12/9/18 8:46 PM, C=C3=A9dric Le Goater wrote:
> This pseries machine makes use of a new sPAPR IRQ backend supporting
> the XIVE interrupt mode.
>=20
> The guest OS is required to have support for the XIVE exploitation
> mode of the POWER9 interrupt controller.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  hw/ppc/spapr.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 4012ebd794a4..3cc134a0b673 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3985,6 +3985,21 @@ static void spapr_machine_4_0_class_options(Mach=
ineClass *mc)
> =20
>  DEFINE_SPAPR_MACHINE(4_0, "4.0", true);
> =20
> +static void spapr_machine_4_0_xive_instance_options(MachineState *mach=
ine)
> +{
> +    spapr_machine_4_0_instance_options(machine);
> +}
> +
> +static void spapr_machine_4_0_xive_class_options(MachineClass *mc)
> +{
> +    sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
> +
> +    spapr_machine_4_0_class_options(mc);> +    smc->irq =3D &spapr_irq=
_xive;

I have been adding checks on the CPU model to export the XIVE capability=20
only on POWER9 processors but it breaks some of the tests.

I was wondering if we could add a default POWER9 CPU to the -xive machine=
 :=20

  + mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power9_v2.0");

and if we could change tests/cpu-plug-test.c with :

  @@ -198,8 +198,13 @@ static void add_pseries_test_case(const
       }
       data =3D g_new(PlugTestData, 1);
       data->machine =3D g_strdup(mname);
  -    data->cpu_model =3D "power8_v2.0";
  -    data->device_model =3D g_strdup("power8_v2.0-spapr-cpu-core");
  +    if (g_str_has_suffix(mname, "xive")) {
  +        data->cpu_model =3D "power9_v2.0";
  +        data->device_model =3D g_strdup("power9_v2.0-spapr-cpu-core");
  +    } else {
  +        data->cpu_model =3D "power8_v2.0";
  +        data->device_model =3D g_strdup("power8_v2.0-spapr-cpu-core");
  +    }
       data->sockets =3D 2;
       data->cores =3D 3;
       data->threads =3D 1;

or if there is a better way ?=20

Thanks,

C.

> +}
> +
> +DEFINE_SPAPR_MACHINE(4_0_xive, "4.0-xive", false);
> +
>  /*
>   * pseries-3.1
>   */
>=20
=20
