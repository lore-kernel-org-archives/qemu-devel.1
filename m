Received: from eggs.gnu.org ([2001:4830:134:3::10]:56369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1g8BtY-0008SN-Hc
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 18:14:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1g8BtX-0005A6-P9
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 18:14:56 -0400
References: <1538579266-8389-1-git-send-email-edgar.iglesias@gmail.com>
	<1538579266-8389-3-git-send-email-edgar.iglesias@gmail.com>
From: Alistair <alistair23@gmail.com>
Message-ID: <95a9c881-20fe-cba5-3e9b-25526e20de89@gmail.com>
Date: Thu, 4 Oct 2018 15:14:47 -0700
MIME-Version: 1.0
In-Reply-To: <1538579266-8389-3-git-send-email-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 02/12] net: cadence_gem: Announce
 availability of priority queues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: figlesia@xilinx.com, peter.maydell@linaro.org, sstabellini@kernel.org, edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com, frasse.iglesias@gmail.com, alistair@alistair23.me, richard.henderson@linaro.org, frederic.konrad@adacore.com

On 10/03/2018 08:07 AM, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> 
> Announce the availability of the various priority queues.
> This fixes an issue where guest kernels would miss to
> configure secondary queues due to inproper feature bits.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>   hw/net/cadence_gem.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
> index e560b7a..901c173 100644
> --- a/hw/net/cadence_gem.c
> +++ b/hw/net/cadence_gem.c
> @@ -1213,6 +1213,7 @@ static void gem_reset(DeviceState *d)
>       int i;
>       CadenceGEMState *s = CADENCE_GEM(d);
>       const uint8_t *a;
> +    uint32_t queues_mask;
>   
>       DB_PRINT("\n");
>   
> @@ -1229,7 +1230,10 @@ static void gem_reset(DeviceState *d)
>       s->regs[GEM_DESCONF] = 0x02500111;
>       s->regs[GEM_DESCONF2] = 0x2ab13fff;
>       s->regs[GEM_DESCONF5] = 0x002f2045;
> -    s->regs[GEM_DESCONF6] = 0x00000200;
> +    s->regs[GEM_DESCONF6] = 0x0;
> +
> +    queues_mask = MAKE_64BIT_MASK(1, s->num_priority_queues - 1);
> +    s->regs[GEM_DESCONF6] |= queues_mask;
>   
>       /* Set MAC address */
>       a = &s->conf.macaddr.a[0];
> 
