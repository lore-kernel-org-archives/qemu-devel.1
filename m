Received: from eggs.gnu.org ([2001:4830:134:3::10]:54762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eDw9N-0003IP-EV
	for qemu-devel@nongnu.org; Sun, 12 Nov 2017 12:34:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eDw9M-0001WF-Hm
	for qemu-devel@nongnu.org; Sun, 12 Nov 2017 12:34:29 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171111081111.32724-1-ppandit@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <29f80a56-df32-0eb5-0152-683c85a7e421@amsat.org>
Date: Sun, 12 Nov 2017 14:34:21 -0300
MIME-Version: 1.0
In-Reply-To: <20171111081111.32724-1-ppandit@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1] highbank: validate register offset
 before access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>
Cc: Moguofang <moguofang@huawei.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, Shawn Guo <shawn.guo@linaro.org>, Rob Herring <robh@kernel.org>, Prasad J Pandit <pjp@fedoraproject.org>

Hi Prasad,

Thanks for updating this patch so quickly :)

On 11/11/2017 05:11 AM, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
> An 'offset' parameter sent to highbank register r/w functions
> could be greater than number(NUM_REGS=0x200) of hb registers,
> leading to an OOB access issue. Add check to avoid it.
> 
> Reported-by: Moguofang (Dennis mo) <moguofang@huawei.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  hw/arm/highbank.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> Update: log error message(via qemu_log_mask) before returning
>   -> https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg01914.html
> 
> diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
> index 354c6b25a8..8494dc6a48 100644
> --- a/hw/arm/highbank.c
> +++ b/hw/arm/highbank.c
> @@ -34,6 +34,7 @@
>  #include "hw/ide/ahci.h"
>  #include "hw/cpu/a9mpcore.h"
>  #include "hw/cpu/a15mpcore.h"
> +#include "qemu/log.h"
>  
>  #define SMP_BOOT_ADDR           0x100
>  #define SMP_BOOT_REG            0x40
> @@ -117,14 +118,26 @@ static void hb_regs_write(void *opaque, hwaddr offset,
>          }
>      }
>  
> +    if (offset / 4 >= NUM_REGS) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "highbank: bad write offset 0x%x\n", (uint32_t)offset);

I'd rather use:

           "highbank: bad write offset 0x%" HWADDR_PRIx "\n", offset);

> +        return;
> +    }
>      regs[offset/4] = value;
>  }
>  
>  static uint64_t hb_regs_read(void *opaque, hwaddr offset,
>                               unsigned size)
>  {
> +    uint32_t value;
>      uint32_t *regs = opaque;
> -    uint32_t value = regs[offset/4];
> +
> +    if (offset / 4 >= NUM_REGS) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "highbank: bad read offset 0x%x\n", (uint32_t)offset);

Ditto HWADDR_PRIx.

> +        return 0;
> +    }
> +    value = regs[offset/4];

  +    value = regs[offset / 4];

With checkpatch fixed:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>  
>      if ((offset == 0x100) || (offset == 0x108) || (offset == 0x10C)) {
>          value |= 0x30000000;
> 
