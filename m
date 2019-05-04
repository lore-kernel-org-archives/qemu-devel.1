Received: from eggs.gnu.org ([209.51.188.92]:37474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hMn8i-0000E8-B6
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:23:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hMn8e-0003Bx-EW
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:23:12 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35690)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hMn8d-0003AO-Jy
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:23:08 -0400
Received: by mail-wr1-f66.google.com with SMTP id h15so4596379wrb.2
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 22:23:04 -0700 (PDT)
References: <20190503120448.13385-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <40488c65-1aae-60c7-4d62-52e754f8f026@redhat.com>
Date: Sat, 4 May 2019 07:23:02 +0200
MIME-Version: 1.0
In-Reply-To: <20190503120448.13385-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] target/arm: Stop using variable length
 array in dc_zva
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 5/3/19 2:04 PM, Peter Maydell wrote:
> Currently the dc_zva helper function uses a variable length
> array. In fact we know (as the comment above remarks) that
> the length of this array is bounded because the architecture
> limits the block size and QEMU limits the target page size.
> Use a fixed array size and assert that we don't run off it.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Changes v1->v2:
>  * use ARRAY_SIZE() instead of sizeof()

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>  * add a comment to make it a bit clearer that the
>    expected size of hostaddr[] is only 2 entries
> ---
>  target/arm/helper.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 81a92ab4911..10444d12b18 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -1,4 +1,5 @@
>  #include "qemu/osdep.h"
> +#include "qemu/units.h"
>  #include "target/arm/idau.h"
>  #include "trace.h"
>  #include "cpu.h"
> @@ -13099,14 +13100,17 @@ void HELPER(dc_zva)(CPUARMState *env, uint64_t vaddr_in)
>           * We know that in fact for any v8 CPU the page size is at least 4K
>           * and the block size must be 2K or less, but TARGET_PAGE_SIZE is only
>           * 1K as an artefact of legacy v5 subpage support being present in the
> -         * same QEMU executable.
> +         * same QEMU executable. So in practice the hostaddr[] array has
> +         * two entries, given the current setting of TARGET_PAGE_BITS_MIN.
>           */
>          int maxidx = DIV_ROUND_UP(blocklen, TARGET_PAGE_SIZE);
> -        void *hostaddr[maxidx];
> +        void *hostaddr[DIV_ROUND_UP(2 * KiB, 1 << TARGET_PAGE_BITS_MIN)];
>          int try, i;
>          unsigned mmu_idx = cpu_mmu_index(env, false);
>          TCGMemOpIdx oi = make_memop_idx(MO_UB, mmu_idx);
>  
> +        assert(maxidx <= ARRAY_SIZE(hostaddr));
> +
>          for (try = 0; try < 2; try++) {
>  
>              for (i = 0; i < maxidx; i++) {
> 
