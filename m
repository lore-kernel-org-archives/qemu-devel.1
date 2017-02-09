Received: from eggs.gnu.org ([2001:4830:134:3::10]:60443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cbwb6-0008Cr-J9
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 16:49:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cbwb1-0002Ra-NK
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 16:49:48 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1486648058-520-1-git-send-email-clg@kaod.org>
	<1486648058-520-5-git-send-email-clg@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c3edd594-8feb-a06f-d239-2d7580cfb883@amsat.org>
Date: Thu, 9 Feb 2017 18:49:39 -0300
MIME-Version: 1.0
In-Reply-To: <1486648058-520-5-git-send-email-clg@kaod.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 4/4] aspeed/smc: use a modulo to
 check segment limits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

On 02/09/2017 10:47 AM, Cédric Le Goater wrote:
> The size of a segment is not necessarily a power of 2.
>
> Signed-off-by: Cédric Le Goater <clg@kaod.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/ssi/aspeed_smc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
> index 70177078a8f2..cb515730c5ad 100644
> --- a/hw/ssi/aspeed_smc.c
> +++ b/hw/ssi/aspeed_smc.c
> @@ -475,15 +475,15 @@ static uint32_t aspeed_smc_check_segment_addr(const AspeedSMCFlash *fl,
>      AspeedSegments seg;
>
>      aspeed_smc_reg_to_segment(s->regs[R_SEG_ADDR0 + fl->id], &seg);
> -    if ((addr & (seg.size - 1)) != addr) {
> +    if ((addr % seg.size) != addr) {
>          qemu_log_mask(LOG_GUEST_ERROR,
>                        "%s: invalid address 0x%08x for CS%d segment : "
>                        "[ 0x%"HWADDR_PRIx" - 0x%"HWADDR_PRIx" ]\n",
>                        s->ctrl->name, addr, fl->id, seg.addr,
>                        seg.addr + seg.size);
> +        addr %= seg.size;
>      }
>
> -    addr &= seg.size - 1;
>      return addr;
>  }
>
>
