Received: from eggs.gnu.org ([2001:4830:134:3::10]:34450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g9MMV-0003Zg-Hv
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 23:37:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g9M6z-0006XR-Vh
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 23:21:41 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e]:40614)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g9M6z-0006Wu-IK
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 23:21:37 -0400
Received: by mail-pf1-x42e.google.com with SMTP id s5-v6so7665039pfj.7
	for <qemu-devel@nongnu.org>; Sun, 07 Oct 2018 20:21:37 -0700 (PDT)
References: <20181006214508.5331-1-cota@braap.org>
	<20181006214508.5331-7-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <615784ab-f832-0e7e-047f-cf201ee1a15c@linaro.org>
Date: Sun, 7 Oct 2018 20:21:33 -0700
MIME-Version: 1.0
In-Reply-To: <20181006214508.5331-7-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 6/6] cputlb: dynamically resize TLBs based on
 use rate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Pranith Kumar <bobby.prani@gmail.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 10/6/18 2:45 PM, Emilio G. Cota wrote:
> @@ -122,6 +123,39 @@ size_t tlb_flush_count(void)
>      return count;
>  }
>  
> +/* Call with tlb_lock held */
> +static void tlb_mmu_resize_locked(CPUArchState *env, int mmu_idx)
> +{
> +    CPUTLBDesc *desc = &env->tlb_desc[mmu_idx];
> +    size_t rate = desc->used * 100 / desc->size;
> +    size_t new_size = desc->size;
> +
> +    if (rate == 100) {
> +        new_size = MIN(desc->size << 2, 1 << TCG_TARGET_TLB_MAX_INDEX_BITS);
> +    } else if (rate > 70) {
> +        new_size = MIN(desc->size << 1, 1 << TCG_TARGET_TLB_MAX_INDEX_BITS);
> +    } else if (rate < 30) {
> +        desc->n_flushes_low_rate++;
> +        if (desc->n_flushes_low_rate == 100) {
> +            new_size = MAX(desc->size >> 1, 1 << MIN_CPU_TLB_BITS);
> +            desc->n_flushes_low_rate = 0;
> +        }
> +    }
> +
> +    if (new_size == desc->size) {

s/desc->size/old_size/g
Otherwise it looks plausible as a first cut.


r~
