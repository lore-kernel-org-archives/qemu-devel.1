Received: from eggs.gnu.org ([2001:4830:134:3::10]:33534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fGYAa-0005Qh-CC
	for qemu-devel@nongnu.org; Wed, 09 May 2018 19:06:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fGYAZ-0008K5-GJ
	for qemu-devel@nongnu.org; Wed, 09 May 2018 19:06:48 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:33128)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1fGYAZ-0008JY-9m
	for qemu-devel@nongnu.org; Wed, 09 May 2018 19:06:47 -0400
Received: by mail-lf0-x244.google.com with SMTP id m18-v6so281396lfb.0
	for <qemu-devel@nongnu.org>; Wed, 09 May 2018 16:06:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180509034658.26455-15-f4bug@amsat.org>
References: <20180509034658.26455-1-f4bug@amsat.org>
	<20180509034658.26455-15-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 9 May 2018 16:06:15 -0700
Message-ID: <CAKmqyKN44Ei4oogarW=u1yxDZn3qHTkch_U5URi5oDQmaLsZUA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v2 14/14] hw/sd/ssi-sd: Enable CRC
 validation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair@alistair23.me>, Stefan Hajnoczi <stefanha@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Tue, May 8, 2018 at 8:46 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/sd/ssi-sd.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/hw/sd/ssi-sd.c b/hw/sd/ssi-sd.c
> index 77e446bb94..0375f0b959 100644
> --- a/hw/sd/ssi-sd.c
> +++ b/hw/sd/ssi-sd.c
> @@ -95,11 +95,11 @@ static uint32_t ssi_sd_transfer(SSISlave *dev, uint32=
_t val)
>          if (s->arglen =3D=3D 4) {
>              uint8_t request[6];
>              uint8_t longresp[16];
> -            /* FIXME: Check CRC.  */
>
>              DPRINTF("CMD%d arg 0x%08x\n", s->cmd, ldl_be_p(s->cmdarg));
>              sd_frame48_init(request, sizeof(request), s->cmd,
>                              ldl_be_p(s->cmdarg), false);
> +            request[5] =3D sd_frame48_calc_checksum(request);
>
>              s->arglen =3D sdbus_do_command(&s->sdbus, request, longresp)=
;
>              if (s->arglen <=3D 0) {
> @@ -257,6 +257,7 @@ static void ssi_sd_realize(SSISlave *d, Error **errp)
>          qdev_prop_set_drive(carddev, "drive", blk_by_legacy_dinfo(dinfo)=
, &err);
>      }
>      object_property_set_bool(OBJECT(carddev), true, "spi", &err);
> +    object_property_set_bool(OBJECT(carddev), true, "validate-crc", &err=
);
>      object_property_set_bool(OBJECT(carddev), true, "realized", &err);
>      if (err) {
>          error_setg(errp, "failed to init SD card: %s", error_get_pretty(=
err));
> --
> 2.17.0
>
>
