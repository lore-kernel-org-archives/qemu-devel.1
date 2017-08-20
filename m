Received: from eggs.gnu.org ([2001:4830:134:3::10]:46168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1djYFN-0006Sm-CJ
	for qemu-devel@nongnu.org; Sun, 20 Aug 2017 17:59:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1djYFM-0001iD-Jc
	for qemu-devel@nongnu.org; Sun, 20 Aug 2017 17:59:05 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1503249785.git.balaton@eik.bme.hu>
	<ac6a19d43a6d36ae6f7cab99a1ac25d2515339ad.1503249785.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1f2ce36c-928b-0631-fdb0-0f413a7a5cb5@amsat.org>
Date: Sun, 20 Aug 2017 18:58:52 -0300
MIME-Version: 1.0
In-Reply-To: <ac6a19d43a6d36ae6f7cab99a1ac25d2515339ad.1503249785.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 13/15] ppc4xx: Add more PLB registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: Francois Revol <revol@free.fr>, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>

Hi Zoltan,

On 08/20/2017 02:23 PM, BALATON Zoltan wrote:
> These registers are present in 440 SoCs (and maybe in others too) and
> U-Boot accesses them when printing register info. We don't emulate
> these but add them to avoid crashing when they are read or written.

Your code isn't incorrect but it doesn't sound the right way to fix your 
problem. Your firmware shouldn't *crash* on unimplemented dcr.

Looking at ppc_dcr_read() I see that *valp isn't updated on unimp dcrn, 
while the dcr_read_plb() callback you are using return 0 on unimp (with 
an "avoid gcc warning" misleading comment).

What is the hardware behavior on implemented dcr? return 0? In that case 
this should be used in ppc_dcr_read(), also adding some 
qemu_log_mask(LOG_UNIMP,...) log entry there.

Regards,

Phil.

> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/ppc/ppc405_uc.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/ppc/ppc405_uc.c b/hw/ppc/ppc405_uc.c
> index e621d0a..8e58065 100644
> --- a/hw/ppc/ppc405_uc.c
> +++ b/hw/ppc/ppc405_uc.c
> @@ -105,9 +105,12 @@ ram_addr_t ppc405_set_bootinfo (CPUPPCState *env, ppc4xx_bd_info_t *bd,
>   /*****************************************************************************/
>   /* Peripheral local bus arbitrer */
>   enum {
> -    PLB0_BESR = 0x084,
> -    PLB0_BEAR = 0x086,
> -    PLB0_ACR  = 0x087,
> +    PLB3A0_ACR = 0x077,
> +    PLB4A0_ACR = 0x081,
> +    PLB0_BESR  = 0x084,
> +    PLB0_BEAR  = 0x086,
> +    PLB0_ACR   = 0x087,
> +    PLB4A1_ACR = 0x089,
>   };
>   
>   typedef struct ppc4xx_plb_t ppc4xx_plb_t;
> @@ -179,9 +182,12 @@ void ppc4xx_plb_init(CPUPPCState *env)
>       ppc4xx_plb_t *plb;
>   
>       plb = g_malloc0(sizeof(ppc4xx_plb_t));
> +    ppc_dcr_register(env, PLB3A0_ACR, plb, &dcr_read_plb, &dcr_write_plb);
> +    ppc_dcr_register(env, PLB4A0_ACR, plb, &dcr_read_plb, &dcr_write_plb);
>       ppc_dcr_register(env, PLB0_ACR, plb, &dcr_read_plb, &dcr_write_plb);
>       ppc_dcr_register(env, PLB0_BEAR, plb, &dcr_read_plb, &dcr_write_plb);
>       ppc_dcr_register(env, PLB0_BESR, plb, &dcr_read_plb, &dcr_write_plb);
> +    ppc_dcr_register(env, PLB4A1_ACR, plb, &dcr_read_plb, &dcr_write_plb);
>       qemu_register_reset(ppc4xx_plb_reset, plb);
>   }
>   
> 
