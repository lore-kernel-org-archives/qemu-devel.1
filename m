Received: from eggs.gnu.org ([2001:4830:134:3::10]:45781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mar.krzeminski@gmail.com>) id 1e7QAf-0002Bp-CJ
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 14:12:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mar.krzeminski@gmail.com>) id 1e7QAb-0006ej-8J
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 14:12:53 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:57244)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mar.krzeminski@gmail.com>)
	id 1e7QAb-0006d6-0i
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 14:12:49 -0400
Received: by mail-lf0-x244.google.com with SMTP id 90so942340lfs.13
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 11:12:48 -0700 (PDT)
References: <20171024195139.28179-1-frasse.iglesias@gmail.com>
	<20171024195139.28179-3-frasse.iglesias@gmail.com>
From: "mar.krzeminski" <mar.krzeminski@gmail.com>
Message-ID: <e8ac6787-38cb-c1e9-4ca4-6a5887887bd8@gmail.com>
Date: Wed, 25 Oct 2017 20:12:45 +0200
MIME-Version: 1.0
In-Reply-To: <20171024195139.28179-3-frasse.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-AU
Subject: Re: [Qemu-devel] [PATCH v3 02/13] m25p80: Add support for SST READ
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



W dniu 24.10.2017 o 21:51, Francisco Iglesias pisze:
> Add support for SST READ ID 0x90/0xAB commands for reading out the flash
> manufacuter ID and device ID.
>
> Signed-off-by: Francisco Iglesias <frasse.iglesias@gmail.com>
> ---
>   hw/block/m25p80.c | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
>
> diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
> index 2971519..c85e8fa 100644
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
> @@ -1018,6 +1023,21 @@ static void decode_new_cmd(Flash *s, uint32_t value)
>           s->state = STATE_READING_DATA;
>           break;
>   
> +    case RDID_90:
> +    case RDID_AB:
> +        DB_PRINT_L(0, "populated manf/dev ID\n");
> +        if (get_man(s) == MAN_SST) {
> +            s->data[0] = s->pi->id[0];
> +            s->data[1] = s->pi->id[2];
> +            s->pos = 0;
> +            s->len = 2;
> +            s->data_read_loop = true;
> +            s->state = STATE_READING_DATA;
I am not sure about this. I am looking at SST25WF080 datasheet, and it 
seem that those commands
also expect address, and based on that returns manufacturer id or device id.
> +        } else {
> +            qemu_log_mask(LOG_GUEST_ERROR, "M25P80: Unknown cmd %x\n", value);
> +        }
> +        break;
> +
>       case BULK_ERASE:
>           if (s->write_enable) {
>               DB_PRINT_L(0, "chip erase\n");
Regard,
Marcin
