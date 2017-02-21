Received: from eggs.gnu.org ([2001:4830:134:3::10]:55071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cgIni-0008EY-5c
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 17:20:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cgInh-0006OT-71
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 17:20:50 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1487684021-22713-1-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <971a7987-b369-d879-f2bb-80ab5de41a0a@amsat.org>
Date: Tue, 21 Feb 2017 19:20:37 -0300
MIME-Version: 1.0
In-Reply-To: <1487684021-22713-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] hw/ppc/ppc405_uc.c: Avoid integer overflows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, patches@linaro.org

On 02/21/2017 10:33 AM, Peter Maydell wrote:
> When performing clock calculations, the ppc405_uc code
> has several places where it multiplies together two
> 32-bit variables and assigns the result to a 64-bit
> variable. This doesn't quite do what is intended because
> C will compute a 32-bit multiply result. Add casts to
> ensure we don't truncate the result.
>
> (Spotted by Coverity, CID 1005504, 1005505.)

well hidden...

>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/ppc/ppc405_uc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/hw/ppc/ppc405_uc.c b/hw/ppc/ppc405_uc.c
> index d6d3fc2..d5df94a 100644
> --- a/hw/ppc/ppc405_uc.c
> +++ b/hw/ppc/ppc405_uc.c
> @@ -1881,7 +1881,7 @@ static void ppc405cr_clk_setup (ppc405cr_cpc_t *cpc)
>          D1 = (((cpc->pllmr >> 20) - 1) & 0xF) + 1; /* FBDV */
>          D2 = 8 - ((cpc->pllmr >> 16) & 0x7); /* FWDVA */
>          M = D0 * D1 * D2;
> -        VCO_out = cpc->sysclk * M;
> +        VCO_out = (uint64_t)cpc->sysclk * M;
>          if (VCO_out < 400000000 || VCO_out > 800000000) {
>              /* PLL cannot lock */
>              cpc->pllmr &= ~0x80000000;
> @@ -1892,7 +1892,7 @@ static void ppc405cr_clk_setup (ppc405cr_cpc_t *cpc)
>          /* Bypass PLL */
>      bypass_pll:
>          M = D0;
> -        PLL_out = cpc->sysclk * M;
> +        PLL_out = (uint64_t)cpc->sysclk * M;
>      }
>      CPU_clk = PLL_out;
>      if (cpc->cr1 & 0x00800000)
> @@ -2242,7 +2242,7 @@ static void ppc405ep_compute_clocks (ppc405ep_cpc_t *cpc)
>  #ifdef DEBUG_CLOCKS_LL
>          printf("FWDA %01" PRIx32 " %d\n", (cpc->pllmr[1] >> 16) & 0x7, D);
>  #endif
> -        VCO_out = cpc->sysclk * M * D;
> +        VCO_out = (uint64_t)cpc->sysclk * M * D;
>          if (VCO_out < 500000000UL || VCO_out > 1000000000UL) {
>              /* Error - unlock the PLL */
>              printf("VCO out of range %" PRIu64 "\n", VCO_out);
>
