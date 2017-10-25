Received: from eggs.gnu.org ([2001:4830:134:3::10]:44060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mar.krzeminski@gmail.com>) id 1e7Q1Y-000862-El
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 14:03:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mar.krzeminski@gmail.com>) id 1e7Q1X-0002fC-HK
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 14:03:28 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:52937)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mar.krzeminski@gmail.com>)
	id 1e7Q1X-0002e8-9j
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 14:03:27 -0400
Received: by mail-lf0-x244.google.com with SMTP id b190so922288lfg.9
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 11:03:27 -0700 (PDT)
References: <20171024195139.28179-1-frasse.iglesias@gmail.com>
	<20171024195139.28179-2-frasse.iglesias@gmail.com>
From: "mar.krzeminski" <mar.krzeminski@gmail.com>
Message-ID: <f8c2e259-3022-31e8-fdeb-f9587a99179f@gmail.com>
Date: Wed, 25 Oct 2017 20:03:24 +0200
MIME-Version: 1.0
In-Reply-To: <20171024195139.28179-2-frasse.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: pl
Subject: Re: [Qemu-devel] [PATCH v3 01/13] m25p80: Add support for
 continuous read out of RDSR and READ_FSR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Francisco Iglesias <frasse.iglesias@gmail.com>, qemu-devel@nongnu.org
Cc: edgari@xilinx.com, alistai@xilinx.com, francisco.iglesias@feimtech.se



W dniu 24.10.2017 o 21:51, Francisco Iglesias pisze:
> Add support for continuous read out of the RDSR and READ_FSR status
> registers until the chip select is deasserted. This feature is supported
> by amongst others 1 or more flashtypes manufactured by Numonyx (Micron),
> Windbond, SST, Gigadevice, Eon and Macronix.
>
> Signed-off-by: Francisco Iglesias <frasse.iglesias@gmail.com>
Acked-by: Marcin Krzemiński <mar.krzeminski@gmail.com>
> ---
>   hw/block/m25p80.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
> index a2438b9..2971519 100644
> --- a/hw/block/m25p80.c
> +++ b/hw/block/m25p80.c
> @@ -423,6 +423,7 @@ typedef struct Flash {
>       uint8_t data[M25P80_INTERNAL_DATA_BUFFER_SZ];
>       uint32_t len;
>       uint32_t pos;
> +    bool data_read_loop;
>       uint8_t needed_bytes;
>       uint8_t cmd_in_progress;
>       uint32_t cur_addr;
> @@ -983,6 +984,7 @@ static void decode_new_cmd(Flash *s, uint32_t value)
>           }
>           s->pos = 0;
>           s->len = 1;
> +        s->data_read_loop = true;
>           s->state = STATE_READING_DATA;
>           break;
>   
> @@ -993,6 +995,7 @@ static void decode_new_cmd(Flash *s, uint32_t value)
>           }
>           s->pos = 0;
>           s->len = 1;
> +        s->data_read_loop = true;
>           s->state = STATE_READING_DATA;
>           break;
>   
> @@ -1133,6 +1136,7 @@ static int m25p80_cs(SSISlave *ss, bool select)
>           s->pos = 0;
>           s->state = STATE_IDLE;
>           flash_sync_dirty(s, -1);
> +        s->data_read_loop = false;
>       }
>   
>       DB_PRINT_L(0, "%sselect\n", select ? "de" : "");
> @@ -1198,7 +1202,9 @@ static uint32_t m25p80_transfer8(SSISlave *ss, uint32_t tx)
>           s->pos++;
>           if (s->pos == s->len) {
>               s->pos = 0;
> -            s->state = STATE_IDLE;
> +            if (!s->data_read_loop) {
> +                s->state = STATE_IDLE;
> +            }
>           }
>           break;
>   
