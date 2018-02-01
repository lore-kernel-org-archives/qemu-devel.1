Received: from eggs.gnu.org ([2001:4830:134:3::10]:36262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eh2ov-0001Ac-Gy
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 19:33:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eh2ou-00025o-Jx
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 19:33:41 -0500
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:43116)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1eh2ou-00025M-BF
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 19:33:40 -0500
Received: by mail-lf0-x244.google.com with SMTP id o89so23501573lfg.10
	for <qemu-devel@nongnu.org>; Wed, 31 Jan 2018 16:33:40 -0800 (PST)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20180123033034.29493-14-f4bug@amsat.org>
References: <20180123033034.29493-1-f4bug@amsat.org>
	<20180123033034.29493-14-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Wed, 31 Jan 2018 16:33:08 -0800
Message-ID: <CAKmqyKM5QKRJ82FSA6c=05TMzh+KvgOF9zWEdAWFi4fm0x_kUQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 13/18] sdcard: simplify SEND_IF_COND
 (CMD8)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Mon, Jan 22, 2018 at 7:30 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> replace switch(single case) -> if()
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair

> ---
>  hw/sd/sd.c | 26 +++++++++++---------------
>  1 file changed, 11 insertions(+), 15 deletions(-)
>
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index b5c947df62..707c294169 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -1015,23 +1015,19 @@ static sd_rsp_type_t sd_normal_command(SDState *s=
d, SDRequest req)
>
>      case 8:    /* CMD8:   SEND_IF_COND */
>          /* Physical Layer Specification Version 2.00 command */
> -        switch (sd->state) {
> -        case sd_idle_state:
> -            sd->vhs =3D 0;
> -
> -            /* No response if not exactly one VHS bit is set.  */
> -            if (!(req.arg >> 8) || (req.arg >> (ctz32(req.arg & ~0xff) +=
 1))) {
> -                return sd->spi ? sd_r7 : sd_r0;
> -            }
> -
> -            /* Accept.  */
> -            sd->vhs =3D req.arg;
> -            return sd_r7;
> -
> -        default:
> +        if (sd->state !=3D sd_idle_state) {
>              break;
>          }
> -        break;
> +        sd->vhs =3D 0;
> +
> +        /* No response if not exactly one VHS bit is set.  */
> +        if (!(req.arg >> 8) || (req.arg >> (ctz32(req.arg & ~0xff) + 1))=
) {
> +            return sd->spi ? sd_r7 : sd_r0;
> +        }
> +
> +        /* Accept.  */
> +        sd->vhs =3D req.arg;
> +        return sd_r7;
>
>      case 9:    /* CMD9:   SEND_CSD */
>          switch (sd->state) {
> --
> 2.15.1
>
>
