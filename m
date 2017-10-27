Received: from eggs.gnu.org ([2001:4830:134:3::10]:52619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1e80A4-0007bs-83
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 04:38:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1e80A3-0004a1-7Q
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 04:38:40 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:47608)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1e80A3-0004Yl-0w
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 04:38:39 -0400
Received: by mail-wr0-x244.google.com with SMTP id y39so5482806wrd.4
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 01:38:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171027055612.2488-2-frasse.iglesias@gmail.com>
References: <20171027055612.2488-1-frasse.iglesias@gmail.com>
	<20171027055612.2488-2-frasse.iglesias@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 27 Oct 2017 10:38:07 +0200
Message-ID: <CAKmqyKO=StvRKBs8JAazzDL=yPvc9sadXTdUo0AWZrbANg8=Gg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 01/13] m25p80: Add support for
 continuous read out of RDSR and READ_FSR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Francisco Iglesias <frasse.iglesias@gmail.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Edgar Iglesias <edgari@xilinx.com>, Alistair Francis <alistai@xilinx.com>, francisco.iglesias@feimtech.se, "mar.krzeminski" <mar.krzeminski@gmail.com>

On Fri, Oct 27, 2017 at 7:56 AM, Francisco Iglesias
<frasse.iglesias@gmail.com> wrote:
> Add support for continuous read out of the RDSR and READ_FSR status
> registers until the chip select is deasserted. This feature is supported
> by amongst others 1 or more flashtypes manufactured by Numonyx (Micron),
> Windbond, SST, Gigadevice, Eon and Macronix.
>
> Signed-off-by: Francisco Iglesias <frasse.iglesias@gmail.com>
> Acked-by: Marcin Krzemi=C5=84ski <mar.krzeminski@gmail.com>

Acked-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair

> ---
>  hw/block/m25p80.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
> index a2438b9..2971519 100644
> --- a/hw/block/m25p80.c
> +++ b/hw/block/m25p80.c
> @@ -423,6 +423,7 @@ typedef struct Flash {
>      uint8_t data[M25P80_INTERNAL_DATA_BUFFER_SZ];
>      uint32_t len;
>      uint32_t pos;
> +    bool data_read_loop;
>      uint8_t needed_bytes;
>      uint8_t cmd_in_progress;
>      uint32_t cur_addr;
> @@ -983,6 +984,7 @@ static void decode_new_cmd(Flash *s, uint32_t value)
>          }
>          s->pos =3D 0;
>          s->len =3D 1;
> +        s->data_read_loop =3D true;
>          s->state =3D STATE_READING_DATA;
>          break;
>
> @@ -993,6 +995,7 @@ static void decode_new_cmd(Flash *s, uint32_t value)
>          }
>          s->pos =3D 0;
>          s->len =3D 1;
> +        s->data_read_loop =3D true;
>          s->state =3D STATE_READING_DATA;
>          break;
>
> @@ -1133,6 +1136,7 @@ static int m25p80_cs(SSISlave *ss, bool select)
>          s->pos =3D 0;
>          s->state =3D STATE_IDLE;
>          flash_sync_dirty(s, -1);
> +        s->data_read_loop =3D false;
>      }
>
>      DB_PRINT_L(0, "%sselect\n", select ? "de" : "");
> @@ -1198,7 +1202,9 @@ static uint32_t m25p80_transfer8(SSISlave *ss, uint=
32_t tx)
>          s->pos++;
>          if (s->pos =3D=3D s->len) {
>              s->pos =3D 0;
> -            s->state =3D STATE_IDLE;
> +            if (!s->data_read_loop) {
> +                s->state =3D STATE_IDLE;
> +            }
>          }
>          break;
>
> --
> 2.9.3
>
>
