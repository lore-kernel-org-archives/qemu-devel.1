Received: from eggs.gnu.org ([2001:4830:134:3::10]:45216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eIyY4-0006KS-KJ
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 10:08:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eIyXz-0002Y8-LI
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 10:08:48 -0500
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:35078)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eIyXz-0002X7-Fs
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 10:08:43 -0500
Received: by mail-qk0-x242.google.com with SMTP id p19so29504284qke.2
	for <qemu-devel@nongnu.org>; Sun, 26 Nov 2017 07:08:43 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171124212938.7074-1-frasse.iglesias@gmail.com>
	<20171124212938.7074-3-frasse.iglesias@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <64ae00a4-d66c-b067-5bf4-b3be6fcf0822@amsat.org>
Date: Sat, 25 Nov 2017 21:45:08 -0300
MIME-Version: 1.0
In-Reply-To: <20171124212938.7074-3-frasse.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v8 02/13] m25p80: Add support for SST READ
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
Cc: peter.maydell@linaro.org, edgari@xilinx.com, alistai@xilinx.com, francisco.iglesias@feimtech.se, mar.krzeminski@gmail.com

Hi Francisco,

On 11/24/2017 06:29 PM, Francisco Iglesias wrote:
> Add support for SST READ ID 0x90/0xAB commands for reading out the flash
> manufacuter ID and device ID.
> 
> Signed-off-by: Francisco Iglesias <frasse.iglesias@gmail.com>
> Acked-by: Alistair Francis <alistair.francis@xilinx.com>
> Acked-by: Marcin Krzemiński <mar.krzeminski@gmail.com>
> ---
>  hw/block/m25p80.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
> index d50acc1..9d20120 100644
> --- a/hw/block/m25p80.c
> +++ b/hw/block/m25p80.c
> @@ -355,6 +355,8 @@ typedef enum {
>      DPP = 0xa2,
>      QPP = 0x32,
>      QPP_4 = 0x34,
> +    RDID_90 = 0x90,
> +    RDID_AB = 0xab,
>  
>      ERASE_4K = 0x20,
>      ERASE4_4K = 0x21,
> @@ -405,6 +407,7 @@ typedef enum {
>      MAN_MACRONIX,
>      MAN_NUMONYX,
>      MAN_WINBOND,
> +    MAN_SST,
>      MAN_GENERIC,
>  } Manufacturer;
>  
> @@ -476,6 +479,8 @@ static inline Manufacturer get_man(Flash *s)
>          return MAN_SPANSION;
>      case 0xC2:
>          return MAN_MACRONIX;
> +    case 0xBF:
> +        return MAN_SST;
>      default:
>          return MAN_GENERIC;
>      }
> @@ -711,6 +716,22 @@ static void complete_collecting_data(Flash *s)
>      case WEVCR:
>          s->enh_volatile_cfg = s->data[0];
>          break;
> +    case RDID_90:
> +    case RDID_AB:
> +        if (get_man(s) == MAN_SST && s->cur_addr <= 1) {

What about reporting if guest access this address when not an SST flash?

           if (get_man(s) == MAN_SST) {
               if (s->cur_addr <= 1) {

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

               } else {
                    // LOG_UNIMP?
               }
           } else {
               qemu_log_mask(LOG_GUEST_ERROR, ...);

> +        }
> +        break;
>      default:
>          break;
>      }
> @@ -926,6 +947,8 @@ static void decode_new_cmd(Flash *s, uint32_t value)
>      case PP4:
>      case PP4_4:
>      case DIE_ERASE:
> +    case RDID_90:
> +    case RDID_AB:
>          s->needed_bytes = get_addr_length(s);
>          s->pos = 0;
>          s->len = 0;

Regards,

Phil.
