Received: from eggs.gnu.org ([2001:4830:134:3::10]:55320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ete88-0001A6-IT
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 13:49:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ete87-0000GP-CX
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 13:49:36 -0500
Received: from chuckie.co.uk ([82.165.15.123]:45415
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1ete87-0000GB-5h
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 13:49:35 -0500
References: <1519984765-15748-1-git-send-email-konrad@adacore.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <555e2626-998a-8562-1a4a-e2c989215e5e@ilande.co.uk>
Date: Wed, 7 Mar 2018 18:49:21 +0000
MIME-Version: 1.0
In-Reply-To: <1519984765-15748-1-git-send-email-konrad@adacore.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] sparc: fix leon3 casa instruction when MMU
 is disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: KONRAD Frederic <konrad@adacore.com>, qemu-devel@nongnu.org
Cc: rth@twiddle.net, frederic.konrad@adacore.com

On 02/03/18 09:59, KONRAD Frederic wrote:

> From: KONRAD Frederic <frederic.konrad@adacore.com>
> 
> Since the commit af7a06bac7d3abb2da48ef3277d2a415772d2ae8:
> `casa [..](10), .., ..` (and probably others alternate space instructions)
> triggers a data access exception when the MMU is disabled.
> 
> When we enter get_asi(...) dc->mem_idx is set to MMU_PHYS_IDX when the MMU
> is disabled. Just keep mem_idx unchanged in this case so we passthrough the
> MMU when it is disabled.
> 
> Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
> ---
> 
> Notes:
>      Changes RFC -> V1:
>       * emit the instruction with MMU_PHYS_IDX instead of checking that the MMU
>         is enabled in get_physical_address(..)
> 
>   target/sparc/translate.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/target/sparc/translate.c b/target/sparc/translate.c
> index 71e0853..5aa367a 100644
> --- a/target/sparc/translate.c
> +++ b/target/sparc/translate.c
> @@ -2093,6 +2093,11 @@ static DisasASI get_asi(DisasContext *dc, int insn, TCGMemOp memop)
>               type = GET_ASI_BFILL;
>               break;
>           }
> +
> +        /* MMU_PHYS_IDX is used when the MMU is disabled to passthrough the
> +         * permissions check in get_physical_address(..).
> +         */
> +        mem_idx = (dc->mem_idx == MMU_PHYS_IDX) ? MMU_PHYS_IDX : mem_idx;
>       } else {
>           gen_exception(dc, TT_PRIV_INSN);
>           type = GET_ASI_EXCP;
> 

Thanks Frederic, I've applied this to my qemu-sparc branch.


ATB,

Mark.
