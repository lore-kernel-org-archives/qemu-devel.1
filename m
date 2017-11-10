Received: from eggs.gnu.org ([2001:4830:134:3::10]:52848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eD9T4-0008Ne-Fv
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 08:35:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eD9T0-0008H3-9y
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 08:35:34 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171109115814.28232-1-ppandit@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <7441e865-c6d7-7fbf-3175-63ebdf7291e7@amsat.org>
Date: Fri, 10 Nov 2017 10:35:18 -0300
MIME-Version: 1.0
In-Reply-To: <20171109115814.28232-1-ppandit@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH] highbank: validate register
 offset before access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>, Moguofang <moguofang@huawei.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, Prasad J Pandit <pjp@fedoraproject.org>, Shawn Guo <shawn.guo@linaro.org>, Rob Herring <robh@kernel.org>

Hi Prasad, Moguofang.

On 11/09/2017 08:58 AM, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
> An 'offset' parameter sent to highbank register r/w functions
> could be greater than number(NUM_REGS=0x200) of hb registers,
> leading to an OOB access issue. Add check to avoid it.
> 
> Reported-by: Moguofang (Dennis mo) <moguofang@huawei.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  hw/arm/highbank.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
> index 354c6b25a8..94df151454 100644
> --- a/hw/arm/highbank.c
> +++ b/hw/arm/highbank.c
> @@ -117,6 +117,9 @@ static void hb_regs_write(void *opaque, hwaddr offset,
>          }
>      }
>  
> +    if (offset / 4 >= NUM_REGS) {

I'd report that:

           qemu_log_mask(LOG_UNIMP, ...

Cc'ing Shawn & Rob since this might also be a LOG_GUEST_ERROR.

> +        return;
> +    }
>      regs[offset/4] = value;
>  }
>  
> @@ -124,6 +127,10 @@ static uint64_t hb_regs_read(void *opaque, hwaddr offset,
>                               unsigned size)
>  {
>      uint32_t *regs = opaque;
> +
> +    if (offset / 4 >= NUM_REGS) {

Ditto.

> +        return 0;
> +    }

>From CODING_STYLE:

Mixed declarations (interleaving statements and declarations within
blocks) are generally not allowed; declarations should be at the
beginning of blocks.

>      uint32_t value = regs[offset/4];
>  
>      if ((offset == 0x100) || (offset == 0x108) || (offset == 0x10C)) {

Regards,

Phil.
