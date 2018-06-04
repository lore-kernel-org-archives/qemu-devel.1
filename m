Received: from eggs.gnu.org ([2001:4830:134:3::10]:55749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fPyB7-0005i2-Sz
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 18:42:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fPyB7-00061Y-2t
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 18:42:17 -0400
MIME-Version: 1.0
In-Reply-To: <20180603000827.30872-8-f4bug@amsat.org>
References: <20180603000827.30872-1-f4bug@amsat.org>
	<20180603000827.30872-8-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 4 Jun 2018 15:41:42 -0700
Message-ID: <CAKmqyKNL001nOWYGXGQTtQm4SeEUYL4r6RAOhR6aB-wr=tNJLA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 7/8] sdcard: Reflect when the Spec v3 is
 supported in the Config Register (SCR)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair@alistair23.me>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Sat, Jun 2, 2018 at 5:08 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  include/hw/sd/sd.h | 1 +
>  hw/sd/sd.c         | 7 +++++--
>  2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/include/hw/sd/sd.h b/include/hw/sd/sd.h
> index 7c6ad3c8f1..b865aafc33 100644
> --- a/include/hw/sd/sd.h
> +++ b/include/hw/sd/sd.h
> @@ -57,6 +57,7 @@
>  enum SDPhySpecificationVersion {
>      SD_PHY_SPECv1_10_VERS     =3D 1,
>      SD_PHY_SPECv2_00_VERS     =3D 2,
> +    SD_PHY_SPECv3_01_VERS     =3D 3,
>  };
>
>  typedef enum {
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index da65f2b178..83426da133 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -315,11 +315,14 @@ static void sd_set_scr(SDState *sd)
>      if (sd->spec_version =3D=3D SD_PHY_SPECv1_10_VERS) {
>          sd->scr[0] |=3D 1;        /* Spec Version 1.10 */
>      } else {
> -        sd->scr[0] |=3D 2;        /* Spec Version 2.00 */
> +        sd->scr[0] |=3D 2;        /* Spec Version 2.00 or Version 3.0X *=
/
>      }
>      sd->scr[1] =3D (2 << 4)       /* SDSC Card (Security Version 1.01) *=
/
>                   | 0b0101;      /* 1-bit or 4-bit width bus modes */
>      sd->scr[2] =3D 0x00;          /* Extended Security is not supported.=
 */
> +    if (sd->spec_version >=3D SD_PHY_SPECv3_01_VERS) {
> +        sd->scr[2] |=3D 1 << 7;   /* Spec Version 3.0X */
> +    }
>      sd->scr[3] =3D 0x00;
>      /* reserved for manufacturer usage */
>      sd->scr[4] =3D 0x00;
> @@ -2067,7 +2070,7 @@ static void sd_realize(DeviceState *dev, Error **er=
rp)
>
>      switch (sd->spec_version) {
>      case SD_PHY_SPECv1_10_VERS
> -     ... SD_PHY_SPECv2_00_VERS:
> +     ... SD_PHY_SPECv3_01_VERS:
>          break;
>      default:
>          error_setg(errp, "Invalid SD card Spec version: %u", sd->spec_ve=
rsion);
> --
> 2.17.1
>
>
