Received: from eggs.gnu.org ([209.51.188.92]:53428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMbEm-0001r5-Dt
	for qemu-devel@nongnu.org; Fri, 03 May 2019 12:40:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMbEk-0000g0-RO
	for qemu-devel@nongnu.org; Fri, 03 May 2019 12:40:40 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:50897)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hMbEk-0000dg-HM
	for qemu-devel@nongnu.org; Fri, 03 May 2019 12:40:38 -0400
References: <20181210165636.28366-1-peter.maydell@linaro.org>
	<20181210165636.28366-2-peter.maydell@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <845ed993-5433-53ea-2d29-81450da95d1f@vivier.eu>
Date: Fri, 3 May 2019 18:40:33 +0200
MIME-Version: 1.0
In-Reply-To: <20181210165636.28366-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 1/3] target/m68k: In dump_address_map() check
 for memory access failures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

On 10/12/2018 17:56, Peter Maydell wrote:
> In dump_address_map(), use address_space_ldl() instead of ldl_phys().
> This allows us to check whether the memory access failed.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/m68k/helper.c | 22 +++++++++++++++-------
>   1 file changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/target/m68k/helper.c b/target/m68k/helper.c
> index 917d46efcc3..374e4861886 100644
> --- a/target/m68k/helper.c
> +++ b/target/m68k/helper.c
> @@ -411,6 +411,7 @@ static void dump_address_map(FILE *f, fprintf_function cpu_fprintf,
>       int last_attr = -1, attr = -1;
>       M68kCPU *cpu = m68k_env_get_cpu(env);
>       CPUState *cs = CPU(cpu);
> +    MemTxResult txres;
>   
>       if (env->mmu.tcr & M68K_TCR_PAGE_8K) {
>           /* 8k page */
> @@ -424,22 +425,29 @@ static void dump_address_map(FILE *f, fprintf_function cpu_fprintf,
>           tib_mask = M68K_4K_PAGE_MASK;
>       }
>       for (i = 0; i < M68K_ROOT_POINTER_ENTRIES; i++) {
> -        tia = ldl_phys(cs->as, M68K_POINTER_BASE(root_pointer) + i * 4);
> -        if (!M68K_UDT_VALID(tia)) {
> +        tia = address_space_ldl(cs->as, M68K_POINTER_BASE(root_pointer) + i * 4,
> +                                MEMTXATTRS_UNSPECIFIED, &txres);
> +        if (txres != MEMTX_OK || !M68K_UDT_VALID(tia)) {
>               continue;
>           }
>           for (j = 0; j < M68K_ROOT_POINTER_ENTRIES; j++) {
> -            tib = ldl_phys(cs->as, M68K_POINTER_BASE(tia) + j * 4);
> -            if (!M68K_UDT_VALID(tib)) {
> +            tib = address_space_ldl(cs->as, M68K_POINTER_BASE(tia) + j * 4,
> +                                    MEMTXATTRS_UNSPECIFIED, &txres);
> +            if (txres != MEMTX_OK || !M68K_UDT_VALID(tib)) {
>                   continue;
>               }
>               for (k = 0; k < tic_size; k++) {
> -                tic = ldl_phys(cs->as, (tib & tib_mask) + k * 4);
> -                if (!M68K_PDT_VALID(tic)) {
> +                tic = address_space_ldl(cs->as, (tib & tib_mask) + k * 4,
> +                                        MEMTXATTRS_UNSPECIFIED, &txres);
> +                if (txres != MEMTX_OK || !M68K_PDT_VALID(tic)) {
>                       continue;
>                   }
>                   if (M68K_PDT_INDIRECT(tic)) {
> -                    tic = ldl_phys(cs->as, M68K_INDIRECT_POINTER(tic));
> +                    tic = address_space_ldl(cs->as, M68K_INDIRECT_POINTER(tic),
> +                                            MEMTXATTRS_UNSPECIFIED, &txres);
> +                    if (txres != MEMTX_OK) {
> +                        continue;
> +                    }
>                   }
>   
>                   last_logical = logical;
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
