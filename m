Received: from eggs.gnu.org ([2001:4830:134:3::10]:59432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eHX2r-0000Kh-QP
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 10:34:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eHX2q-00019e-SU
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 10:34:37 -0500
Date: Wed, 22 Nov 2017 16:34:26 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20171122163426.13f3ed3f@redhat.com>
In-Reply-To: <20171106154813.19936-30-andrew.smirnov@gmail.com>
References: <20171106154813.19936-1-andrew.smirnov@gmail.com>
	<20171106154813.19936-30-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 29/30] i.MX: Add i.MX7 SOC
 implementation.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>, qemu-devel@nongnu.org, yurovsky@gmail.com

On Mon,  6 Nov 2017 07:48:12 -0800
Andrey Smirnov <andrew.smirnov@gmail.com> wrote:

> The following interfaces are partially or fully emulated:
>=20
>     * up to 2 Cortex A9 cores (SMP works with PSCI)
>     * A7 MPCORE (identical to A15 MPCORE)
>     * 4 GPTs modules
>     * 7 GPIO controllers
>     * 2 IOMUXC controllers
>     * 1 CCM module
>     * 1 SVNS module
>     * 1 SRC module
>     * 1 GPCv2 controller
>     * 4 eCSPI controllers
>     * 4 I2C controllers
>     * 7 i.MX UART controllers
>     * 2 FlexCAN controllers
>     * 2 Ethernet controllers (FEC)
>     * 3 SD controllers (USDHC)
>     * 4 WDT modules
>     * 1 SDMA module
>     * 1 GPR module
>     * 2 USBMISC modules
>     * 2 ADC modules
>     * 1 PCIe controller
>=20
> Tested to boot and work with upstream Linux (4.13+) guest.
>=20
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Cc: qemu-devel@nongnu.org
> Cc: qemu-arm@nongnu.org
> Cc: yurovsky@gmail.com
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
...
> +
> +static void fsl_imx7_init(Object *obj)
> +{
> +    BusState *sysbus =3D sysbus_get_default();
> +    FslIMX7State *s =3D FSL_IMX7(obj);
> +    char name[NAME_SIZE];
> +    int i;
> +
> +    if (smp_cpus > FSL_IMX7_NUM_CPUS) {
> +        error_report("%s: Only %d CPUs are supported (%d requested)",
> +                     TYPE_FSL_IMX7, FSL_IMX7_NUM_CPUS, smp_cpus);
> +        exit(1);
> +    }
> +
> +    for (i =3D 0; i < smp_cpus; i++) {
> +        object_initialize(&s->cpu[i], sizeof(s->cpu[i]),
> +                          "cortex-a7-" TYPE_ARM_CPU);
pls reuse ARM_CPU_TYPE_NAME() macro here

> +        snprintf(name, NAME_SIZE, "cpu%d", i);
> +        object_property_add_child(obj, name, OBJECT(&s->cpu[i]),
> +                                  &error_fatal);
> +    }
