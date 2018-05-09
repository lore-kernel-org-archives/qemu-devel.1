Received: from eggs.gnu.org ([2001:4830:134:3::10]:51096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fGTQA-0004rr-Ei
	for qemu-devel@nongnu.org; Wed, 09 May 2018 14:02:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fGTQ9-0003J1-L0
	for qemu-devel@nongnu.org; Wed, 09 May 2018 14:02:34 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:34716)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1fGTQ9-0003Hz-Du
	for qemu-devel@nongnu.org; Wed, 09 May 2018 14:02:33 -0400
Received: by mail-lf0-x244.google.com with SMTP id r25-v6so8462605lfd.1
	for <qemu-devel@nongnu.org>; Wed, 09 May 2018 11:02:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180509034658.26455-8-f4bug@amsat.org>
References: <20180509034658.26455-1-f4bug@amsat.org>
	<20180509034658.26455-8-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 9 May 2018 11:02:01 -0700
Message-ID: <CAKmqyKMBHQJZqKevdi8AZ6yStk8sow0kL8vNQiXf7u79jTGPhw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 07/14] sdcard: Invert the
 sd_req_crc_is_valid() logic
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
> Let's return TRUE when the CRC is valid.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/sd/sd.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index d8dad94fc4..6fc8daa5b8 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -467,13 +467,13 @@ static void sd_set_sdstatus(SDState *sd)
>      memset(sd->sd_status, 0, 64);
>  }
>
> -static int sd_req_crc_validate(SDRequest *req)
> +static bool sd_req_crc_is_valid(SDRequest *req)
>  {
>      uint8_t buffer[5];
>      buffer[0] =3D 0x40 | req->cmd;
>      stl_be_p(&buffer[1], req->arg);
> -    return 0;
> -    return sd_frame48_calc_checksum(buffer) !=3D req->crc; /* TODO */
> +    return true;
> +    return sd_frame48_calc_checksum(buffer) =3D=3D req->crc; /* TODO */
>  }
>
>  static void sd_response_r1_make(SDState *sd, uint8_t *response)
> @@ -1631,7 +1631,7 @@ int sd_do_command(SDState *sd, SDRequest *req,
>          return 0;
>      }
>
> -    if (sd_req_crc_validate(req)) {
> +    if (!sd_req_crc_is_valid(req)) {
>          sd->card_status |=3D COM_CRC_ERROR;
>          rtype =3D sd_illegal;
>          goto send_response;
> --
> 2.17.0
>
>
