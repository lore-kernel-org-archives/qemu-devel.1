Received: from eggs.gnu.org ([2001:4830:134:3::10]:48142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1du3b8-00043g-Ua
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 17:28:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1du3b8-0002lD-1z
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 17:28:58 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:33870)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1du3b7-0002ks-Qr
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 17:28:57 -0400
Received: by mail-wm0-x241.google.com with SMTP id i131so2114695wma.1
	for <qemu-devel@nongnu.org>; Mon, 18 Sep 2017 14:28:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170916103523.1482-1-m.olbrich@pengutronix.de>
References: <150555367996.36.15771330325496067998@69b6ddf88678>
	<20170916103523.1482-1-m.olbrich@pengutronix.de>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 18 Sep 2017 14:28:26 -0700
Message-ID: <CAKmqyKP_5dC1td8DMCEM_4v74XBZy5-rWH2z4XA8VCw4165SAg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] hw/sd: fix out-of-bounds check for
 multi block reads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Olbrich <m.olbrich@pengutronix.de>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Sat, Sep 16, 2017 at 3:35 AM, Michael Olbrich
<m.olbrich@pengutronix.de> wrote:
> The current code checks if the next block exceeds the size of the card.
> This generates an error while reading the last block of the card.
> Do the out-of-bounds check when starting to read a new block to fix this.
>
> This issue became visible with increased error checking in Linux 4.13.
>
> Signed-off-by: Michael Olbrich <m.olbrich@pengutronix.de>

Thanks for the patch!

> ---
>
> Changes in v2:
>  - fixed warning
>
> I'm not quite sure if 0x00 is the correct return value, but it's used
> elsewhere in the same function when an error occurs, so it seems
> reasonable.

Returning 0 looks fine to me.

>
>  hw/sd/sd.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index ba47bff4db80..35347a5bbcde 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -1797,8 +1797,13 @@ uint8_t sd_read_data(SDState *sd)
>          break;
>
>      case 18:   /* CMD18:  READ_MULTIPLE_BLOCK */
> -        if (sd->data_offset == 0)
> +        if (sd->data_offset == 0) {
> +            if (sd->data_start + io_len > sd->size) {
> +                sd->card_status |= ADDRESS_ERROR;
> +                return 0x00;
> +            }

Why move it inside the if (sd->data_offset == 0) and not just below
the ret = sd->data[sd->data_offset ++] ?

Thanks,
Alistair

>              BLK_READ_BLOCK(sd->data_start, io_len);
> +        }
>          ret = sd->data[sd->data_offset ++];
>
>          if (sd->data_offset >= io_len) {
> @@ -1812,11 +1817,6 @@ uint8_t sd_read_data(SDState *sd)
>                      break;
>                  }
>              }
> -
> -            if (sd->data_start + io_len > sd->size) {
> -                sd->card_status |= ADDRESS_ERROR;
> -                break;
> -            }
>          }
>          break;
>
> --
> 2.14.1
>
>
