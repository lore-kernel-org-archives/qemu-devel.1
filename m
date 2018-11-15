Received: from eggs.gnu.org ([2001:4830:134:3::10]:41659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gNIwF-0000IA-0Z
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:48:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gNIwA-00061L-1T
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:48:10 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33009)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gNIw9-0005zI-9R
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:48:05 -0500
Received: by mail-wr1-f68.google.com with SMTP id u9-v6so21515651wrr.0
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 06:48:03 -0800 (PST)
References: <20181115143535.5885-1-peter.maydell@linaro.org>
	<20181115143535.5885-3-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9a28fd5b-7f43-562d-0bd5-f493f9bc88c1@redhat.com>
Date: Thu, 15 Nov 2018 15:48:00 +0100
MIME-Version: 1.0
In-Reply-To: <20181115143535.5885-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-3.1 2/2] hw/block/onenand: use
 qemu_log_mask() for reporting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, patches@linaro.org

On 15/11/18 15:35, Peter Maydell wrote:
> Update the onenand device to use qemu_log_mask() for reporting
> guest errors and unimplemented features, rather than plain
> fprintf() and hw_error().
> 
> (We leave the hw_error() in onenand_reset(), as that is
> triggered by a failure to read the underlying block device
> for the bootRAM, not by guest action.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>   hw/block/onenand.c | 22 +++++++++++++---------
>   1 file changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/block/onenand.c b/hw/block/onenand.c
> index 49ef68c9b14..2b48609776d 100644
> --- a/hw/block/onenand.c
> +++ b/hw/block/onenand.c
> @@ -28,6 +28,7 @@
>   #include "exec/memory.h"
>   #include "hw/sysbus.h"
>   #include "qemu/error-report.h"
> +#include "qemu/log.h"
>   
>   /* 11 for 2kB-page OneNAND ("2nd generation") and 10 for 1kB-page chips */
>   #define PAGE_SHIFT	11
> @@ -594,8 +595,8 @@ static void onenand_command(OneNANDState *s)
>       default:
>           s->status |= ONEN_ERR_CMD;
>           s->intstatus |= ONEN_INT;
> -        fprintf(stderr, "%s: unknown OneNAND command %x\n",
> -                        __func__, s->command);
> +        qemu_log_mask(LOG_GUEST_ERROR, "unknown OneNAND command %x\n",
> +                      s->command);
>       }
>   
>       onenand_intr_update(s);
> @@ -657,12 +658,13 @@ static uint64_t onenand_read(void *opaque, hwaddr addr,
>       case 0xff02:	/* ECC Result of spare area data */
>       case 0xff03:	/* ECC Result of main area data */
>       case 0xff04:	/* ECC Result of spare area data */
> -        hw_error("%s: implement ECC\n", __func__);
> +        qemu_log_mask(LOG_UNIMP,
> +                      "onenand: ECC result registers unimplemented\n");
>           return 0x0000;
>       }
>   
> -    fprintf(stderr, "%s: unknown OneNAND register %x\n",
> -                    __func__, offset);
> +    qemu_log_mask(LOG_GUEST_ERROR, "read of unknown OneNAND register 0x%x\n",
> +                  offset);
>       return 0;
>   }
>   
> @@ -706,8 +708,9 @@ static void onenand_write(void *opaque, hwaddr addr,
>               break;
>   
>           default:
> -            fprintf(stderr, "%s: unknown OneNAND boot command %"PRIx64"\n",
> -                            __func__, value);
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "unknown OneNAND boot command %" PRIx64 "\n",
> +                          value);
>           }
>           break;
>   
> @@ -757,8 +760,9 @@ static void onenand_write(void *opaque, hwaddr addr,
>           break;
>   
>       default:
> -        fprintf(stderr, "%s: unknown OneNAND register %x\n",
> -                        __func__, offset);
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "write to unknown OneNAND register 0x%x\n",
> +                      offset);
>       }
>   }
>   
> 
