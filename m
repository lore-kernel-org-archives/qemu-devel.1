Received: from eggs.gnu.org ([2001:4830:134:3::10]:52895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mar.krzeminski@gmail.com>) id 1e7N5s-00011y-Ed
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 10:55:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mar.krzeminski@gmail.com>) id 1e7N5p-0002if-7n
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 10:55:44 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:56996)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mar.krzeminski@gmail.com>)
	id 1e7N5o-0002hG-W2
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 10:55:41 -0400
Received: by mail-lf0-x241.google.com with SMTP id 90so274277lfs.13
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 07:55:40 -0700 (PDT)
References: <20171024195139.28179-1-frasse.iglesias@gmail.com>
	<20171024195139.28179-4-frasse.iglesias@gmail.com>
From: "mar.krzeminski" <mar.krzeminski@gmail.com>
Message-ID: <3e0fa080-b53f-3af5-9940-858bbed188ba@gmail.com>
Date: Wed, 25 Oct 2017 16:55:37 +0200
MIME-Version: 1.0
In-Reply-To: <20171024195139.28179-4-frasse.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-AU
Subject: Re: [Qemu-devel] [PATCH v3 03/13] m25p80: Add support for BRRD/BRWR
 and BULK_ERASE (0x60)
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
> Add support for the bank address register access commands (BRRD/BRWR) and
> the BULK_ERASE (0x60) command.
>
> Signed-off-by: Francisco Iglesias <frasse.iglesias@gmail.com>
> ---
>   hw/block/m25p80.c | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
>
> diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
> index c85e8fa..3d2975c 100644
> --- a/hw/block/m25p80.c
> +++ b/hw/block/m25p80.c
> @@ -331,6 +331,8 @@ typedef enum {
>       WRDI = 0x4,
>       RDSR = 0x5,
>       WREN = 0x6,
> +    BRRD = 0x16,
> +    BRWR = 0x17,
Above commands look to be equivalent to 
EXTEND_ADDR_READ/EXTEND_ADDR_WRITE from Micron.
IMO both could fall in the same case block.

>       JEDEC_READ = 0x9f,
>       BULK_ERASE = 0xc7,
>       READ_FSR = 0x70,
> @@ -368,6 +370,8 @@ typedef enum {
>       EN_4BYTE_ADDR = 0xB7,
>       EX_4BYTE_ADDR = 0xE9,
>   
> +    BULK_ERASE_60 = 0x60,
> +
>       EXTEND_ADDR_READ = 0xC8,
>       EXTEND_ADDR_WRITE = 0xC5,
>   
> @@ -975,6 +979,15 @@ static void decode_new_cmd(Flash *s, uint32_t value)
>           }
>           break;
>   
> +    case BRWR:
> +        if (s->write_enable) {
> +            s->needed_bytes = 1;
> +            s->pos = 0;
> +            s->len = 0;
> +            s->state = STATE_COLLECTING_DATA;
> +        }
> +        break;
> +
>       case WRDI:
>           s->write_enable = false;
>           break;
> @@ -1004,6 +1017,12 @@ static void decode_new_cmd(Flash *s, uint32_t value)
>           s->state = STATE_READING_DATA;
>           break;
>   
> +    case BRRD:
> +        s->pos = 0;
> +        s->len = 1;
> +        s->state = STATE_READING_DATA;
> +        break;
> +
I can not see any code where you are actually filling the register 
value. s->ear could be used for that as well.
>       case JEDEC_READ:
>           DB_PRINT_L(0, "populated jedec code\n");
>           for (i = 0; i < s->pi->id_len; i++) {
> @@ -1038,6 +1057,7 @@ static void decode_new_cmd(Flash *s, uint32_t value)
>           }
>           break;
>   
> +    case BULK_ERASE_60:
>       case BULK_ERASE:
>           if (s->write_enable) {
>               DB_PRINT_L(0, "chip erase\n");
Regards,
Marcin
