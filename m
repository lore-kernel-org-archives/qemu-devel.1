Received: from eggs.gnu.org ([2001:4830:134:3::10]:35364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mar.krzeminski@gmail.com>) id 1e8pPZ-0003P5-MX
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 11:22:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mar.krzeminski@gmail.com>) id 1e8pPW-0000wG-Hf
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 11:22:05 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:45818)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mar.krzeminski@gmail.com>)
	id 1e8pPW-0000vW-9O
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 11:22:02 -0400
Received: by mail-lf0-x241.google.com with SMTP id n69so12141382lfn.2
	for <qemu-devel@nongnu.org>; Sun, 29 Oct 2017 08:22:02 -0700 (PDT)
References: <20171029101343.15544-1-frasse.iglesias@gmail.com>
	<20171029101343.15544-3-frasse.iglesias@gmail.com>
From: "mar.krzeminski" <mar.krzeminski@gmail.com>
Message-ID: <8759fbe7-c75e-e05a-a5b2-0306b2841a5d@gmail.com>
Date: Sun, 29 Oct 2017 16:21:57 +0100
MIME-Version: 1.0
In-Reply-To: <20171029101343.15544-3-frasse.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-AU
Subject: Re: [Qemu-devel] [PATCH v5 02/13] m25p80: Add support for SST READ
 ID 0x90/0xAB commands
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



W dniu 29.10.2017 o 11:13, Francisco Iglesias pisze:
> Add support for SST READ ID 0x90/0xAB commands for reading out the flash
> manufacuter ID and device ID.
>
> Signed-off-by: Francisco Iglesias <frasse.iglesias@gmail.com>
> Acked-by: Alistair Francis <alistair.francis@xilinx.com>
> ---
>   hw/block/m25p80.c | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
>
> diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
> index 2971519..7a5c137 100644
> --- a/hw/block/m25p80.c
> +++ b/hw/block/m25p80.c
> @@ -355,6 +355,8 @@ typedef enum {
>       DPP = 0xa2,
>       QPP = 0x32,
>       QPP_4 = 0x34,
> +    RDID_90 = 0x90,
> +    RDID_AB = 0xab,
>   
>       ERASE_4K = 0x20,
>       ERASE4_4K = 0x21,
> @@ -405,6 +407,7 @@ typedef enum {
>       MAN_MACRONIX,
>       MAN_NUMONYX,
>       MAN_WINBOND,
> +    MAN_SST,
>       MAN_GENERIC,
>   } Manufacturer;
>   
> @@ -476,6 +479,8 @@ static inline Manufacturer get_man(Flash *s)
>           return MAN_SPANSION;
>       case 0xC2:
>           return MAN_MACRONIX;
> +    case 0xBF:
> +        return MAN_SST;
>       default:
>           return MAN_GENERIC;
>       }
> @@ -711,6 +716,22 @@ static void complete_collecting_data(Flash *s)
>       case WEVCR:
>           s->enh_volatile_cfg = s->data[0];
>           break;
> +    case RDID_90:
> +    case RDID_AB:
> +        if (get_man(s) == MAN_SST && s->cur_addr <= 1) {
> +            if (s->cur_addr) {
> +                s->data[0] = s->pi->id[2];
> +                s->data[1] = s->pi->id[0];
> +            } else {
> +                s->data[0] = s->pi->id[0];
> +                s->data[1] = s->pi->id[2];
> +            }
> +            s->pos = 0;
> +            s->len = 2;
> +            s->data_read_loop = true;
> +            s->state = STATE_READING_DATA;
Do you know how the real HW will behave?
When you get two bytes, it will send them once again or will wait for 
address?
> +        }
> +        break;
>       default:
>           break;
>       }
> @@ -926,6 +947,8 @@ static void decode_new_cmd(Flash *s, uint32_t value)
>       case PP4:
>       case PP4_4:
>       case DIE_ERASE:
> +    case RDID_90:
> +    case RDID_AB:
>           s->needed_bytes = get_addr_length(s);
If I understand correctly, for above commands allowed address length is 
3 bytes,
but get_add_length can return 4. To avoid strange error I suggest to add 
case entry for them
in get_addr_length.

>           s->pos = 0;
>           s->len = 0;
Regards,
Marcin
