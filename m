Received: from eggs.gnu.org ([2001:4830:134:3::10]:36432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Andrew.Baumann@microsoft.com>) id 1evmsn-0007Nb-Rw
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:34:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Andrew.Baumann@microsoft.com>) id 1evmsn-0003RJ-21
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:34:37 -0400
From: Andrew Baumann <Andrew.Baumann@microsoft.com>
Date: Tue, 13 Mar 2018 16:34:30 +0000
Message-ID: <MWHPR21MB01895D8620B67C98D730B25C9ED20@MWHPR21MB0189.namprd21.prod.outlook.com>
References: <20180313153458.26822-1-peter.maydell@linaro.org>
	<20180313153458.26822-2-peter.maydell@linaro.org>
In-Reply-To: <20180313153458.26822-2-peter.maydell@linaro.org>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 1/9] hw/arm/raspi: Don't do board-setup or
 secure-boot for raspi3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>, Pekka Enberg <penberg@iki.fi>, "patches@linaro.org" <patches@linaro.org>

> From: Qemu-devel <qemu-devel-
> bounces+andrew.baumann=3Dmicrosoft.com@nongnu.org> On Behalf Of Peter
> Maydell
> Sent: Tuesday, 13 March 2018 08:35
>=20
> For the rpi1 and 2 we want to boot the Linux kernel via some
> custom setup code that makes sure that the SMC instruction
> acts as a no-op, because it's used for cache maintenance.
> The rpi3 boots AArch64 kernels, which don't need SMC for
> cache maintenance and always expect to be booted non-secure.
> Don't fill in the aarch32-specific parts of the binfo struct.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/arm/raspi.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
> index a37881433c..1ac0737149 100644
> --- a/hw/arm/raspi.c
> +++ b/hw/arm/raspi.c
> @@ -82,10 +82,19 @@ static void setup_boot(MachineState *machine, int
> version, size_t ram_size)
>      binfo.board_id =3D raspi_boardid[version];
>      binfo.ram_size =3D ram_size;
>      binfo.nb_cpus =3D smp_cpus;
> -    binfo.board_setup_addr =3D BOARDSETUP_ADDR;
> -    binfo.write_board_setup =3D write_board_setup;
> -    binfo.secure_board_setup =3D true;
> -    binfo.secure_boot =3D true;
> +
> +    if (version <=3D 2) {
> +        /* The rpi1 and 2 require some custom setup code to run in Secur=
e
> +         * mode before booting a kernel (to set up the SMC vectors so
> +         * that we get a no-op SMC; this is used by Linux to call the
> +         * firmware for some cache maintenance operations.
> +         * The rpi3 doesn't need this.
> +         */
> +        binfo.board_setup_addr =3D BOARDSETUP_ADDR;
> +        binfo.write_board_setup =3D write_board_setup;
> +        binfo.secure_board_setup =3D true;
> +        binfo.secure_boot =3D true;
> +    }
>=20
>      /* Pi2 and Pi3 requires SMP setup */
>      if (version >=3D 2) {

Reviewed-by: Andrew Baumann <Andrew.Baumann@microsoft.com>
