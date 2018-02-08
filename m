Received: from eggs.gnu.org ([2001:4830:134:3::10]:35585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ejvtu-0001Sq-IQ
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 18:46:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ejvtt-0006uG-Ji
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 18:46:46 -0500
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:40647)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1ejvtt-0006sZ-Bt
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 18:46:45 -0500
Received: by mail-lf0-x242.google.com with SMTP id i24so5669619lfc.7
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 15:46:45 -0800 (PST)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20180123033034.29493-7-f4bug@amsat.org>
References: <20180123033034.29493-1-f4bug@amsat.org>
	<20180123033034.29493-7-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Thu, 8 Feb 2018 15:46:13 -0800
Message-ID: <CAKmqyKOA+cDHObCvOqUdOUuW-h+ZEtOUJRKZyEW24GFA_2hPKg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 06/18] sdcard: simplify using the ldst
 API
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
> the code is easier to review/refactor.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair

> ---
>  hw/sd/sd.c | 38 +++++++++-----------------------------
>  1 file changed, 9 insertions(+), 29 deletions(-)
>
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 3c66521862..23f5d47782 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -435,57 +435,39 @@ static int sd_req_crc_validate(SDRequest *req)
>  {
>      uint8_t buffer[5];
>      buffer[0] =3D 0x40 | req->cmd;
> -    buffer[1] =3D (req->arg >> 24) & 0xff;
> -    buffer[2] =3D (req->arg >> 16) & 0xff;
> -    buffer[3] =3D (req->arg >> 8) & 0xff;
> -    buffer[4] =3D (req->arg >> 0) & 0xff;
> +    stl_be_p(&buffer[1], req->arg);
>      return 0;
>      return sd_crc7(buffer, 5) !=3D req->crc;     /* TODO */
>  }
>
>  static void sd_response_r1_make(SDState *sd, uint8_t *response)
>  {
> -    uint32_t status =3D sd->card_status;
> +    stl_be_p(response, sd->card_status);
> +
>      /* Clear the "clear on read" status bits */
>      sd->card_status &=3D ~CARD_STATUS_C;
> -
> -    response[0] =3D (status >> 24) & 0xff;
> -    response[1] =3D (status >> 16) & 0xff;
> -    response[2] =3D (status >> 8) & 0xff;
> -    response[3] =3D (status >> 0) & 0xff;
>  }
>
>  static void sd_response_r3_make(SDState *sd, uint8_t *response)
>  {
> -    response[0] =3D (sd->ocr >> 24) & 0xff;
> -    response[1] =3D (sd->ocr >> 16) & 0xff;
> -    response[2] =3D (sd->ocr >> 8) & 0xff;
> -    response[3] =3D (sd->ocr >> 0) & 0xff;
> +    stl_be_p(response, sd->ocr);
>  }
>
>  static void sd_response_r6_make(SDState *sd, uint8_t *response)
>  {
> -    uint16_t arg;
>      uint16_t status;
>
> -    arg =3D sd->rca;
>      status =3D ((sd->card_status >> 8) & 0xc000) |
>               ((sd->card_status >> 6) & 0x2000) |
>                (sd->card_status & 0x1fff);
>      sd->card_status &=3D ~(CARD_STATUS_C & 0xc81fff);
> -
> -    response[0] =3D (arg >> 8) & 0xff;
> -    response[1] =3D arg & 0xff;
> -    response[2] =3D (status >> 8) & 0xff;
> -    response[3] =3D status & 0xff;
> +    stw_be_p(response + 0, sd->rca);
> +    stw_be_p(response + 2, status);
>  }
>
>  static void sd_response_r7_make(SDState *sd, uint8_t *response)
>  {
> -    response[0] =3D (sd->vhs >> 24) & 0xff;
> -    response[1] =3D (sd->vhs >> 16) & 0xff;
> -    response[2] =3D (sd->vhs >>  8) & 0xff;
> -    response[3] =3D (sd->vhs >>  0) & 0xff;
> +    stl_be_p(response, sd->vhs);
>  }
>
>  static inline uint64_t sd_addr_to_wpnum(uint64_t addr)
> @@ -731,7 +713,7 @@ static uint32_t sd_wpbits(SDState *sd, uint64_t addr)
>
>  static void sd_function_switch(SDState *sd, uint32_t arg)
>  {
> -    int i, mode, new_func, crc;
> +    int i, mode, new_func;
>      mode =3D !!(arg & 0x80000000);
>
>      sd->data[0] =3D 0x00;                /* Maximum current consumption =
*/
> @@ -755,9 +737,7 @@ static void sd_function_switch(SDState *sd, uint32_t =
arg)
>          sd->data[14 + (i >> 1)] =3D new_func << ((i * 4) & 4);
>      }
>      memset(&sd->data[17], 0, 47);
> -    crc =3D sd_crc16(sd->data, 64);
> -    sd->data[65] =3D crc >> 8;
> -    sd->data[66] =3D crc & 0xff;
> +    stw_be_p(sd->data + 65, sd_crc16(sd->data, 64));
>  }
>
>  static inline bool sd_wp_addr(SDState *sd, uint64_t addr)
> --
> 2.15.1
>
>
