Received: from eggs.gnu.org ([2001:4830:134:3::10]:35515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1db3hC-0001gK-Ia
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 07:44:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1db3hB-0008D1-LH
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 07:44:42 -0400
References: <20170727024224.22900-1-f4bug@amsat.org>
	<20170727024224.22900-20-f4bug@amsat.org>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <78b454a6-b0a4-8cfe-8a4d-9b5207f03faa@msgid.tls.msk.ru>
Date: Fri, 28 Jul 2017 14:44:32 +0300
MIME-Version: 1.0
In-Reply-To: <20170727024224.22900-20-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for 2.10 v2 20/20] i2c/exynos4210: fix
 write to I2CADD register, bit 0 is not mapped
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>
Cc: qemu-trivial@nongnu.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org

27.07.2017 05:42, Philippe Mathieu-Daud=C3=A9 wrote:
> From the Exynos4210 User Manual [1]:
>=20
> 14.4.1.3 I2CADDn (MULTI-MASTER I2C-Bus Address Register)
>   [7-1] slave address, latched from the I2C-bus.
>   bit [0] is not mapped.
>=20
> [1]: Exynos_4_Dual_45nm_User_Manaul_Public_REV1.00-0.pdf

Okay, so what happens when one writes to bit0?

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/i2c/exynos4210_i2c.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/i2c/exynos4210_i2c.c b/hw/i2c/exynos4210_i2c.c
> index c96fa7d7be..e6a9ca8f03 100644
> --- a/hw/i2c/exynos4210_i2c.c
> +++ b/hw/i2c/exynos4210_i2c.c
> @@ -243,7 +243,7 @@ static void exynos4210_i2c_write(void *opaque, hwad=
dr offset,
>          break;
>      case I2CADD_ADDR:
>          if ((s->i2cstat & I2CSTAT_OUTPUT_EN) =3D=3D 0) {
> -            s->i2cadd =3D v;
> +            s->i2cadd =3D v & ~1;

Maybe a comment is a good idea here, saying that bit0 is unmapped.

Thanks,

/mjt
