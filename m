Received: from eggs.gnu.org ([2001:4830:134:3::10]:42423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fdvu1-0003Gh-4h
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 07:06:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fdvu0-0006HC-3p
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 07:06:21 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:43106)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fdvtz-0006G0-Tz
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 07:06:20 -0400
Received: by mail-oi0-x244.google.com with SMTP id b15-v6so61443730oib.10
	for <qemu-devel@nongnu.org>; Fri, 13 Jul 2018 04:06:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180702160546.31969-5-richard.henderson@linaro.org>
References: <20180702160546.31969-1-richard.henderson@linaro.org>
	<20180702160546.31969-5-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Jul 2018 12:05:49 +0100
Message-ID: <CAFEAcA8qtHmWt9Zhnhqcc6J-hgbxucq-gU1V5=uZa727kqKSvg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 4/6] accel/tcg: Don't treat invalid TLB
 entries as needing recheck
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 2 July 2018 at 17:05, Richard Henderson <richard.henderson@linaro.org> wrote:
> From: Peter Maydell <peter.maydell@linaro.org>
>
> In get_page_addr_code() when we check whether the TLB entry
> is marked as TLB_RECHECK, we should not go down that code
> path if the TLB entry is not valid at all (ie the TLB_INVALID
> bit is set).
>
> Tested-by: Laurent Vivier <laurent@vivier.eu>
> Reported-by: Laurent Vivier <laurent@vivier.eu>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Message-Id: <20180629161731.16239-1-peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  accel/tcg/cputlb.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 3ae1198c24..cc90a5fe92 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -963,7 +963,8 @@ tb_page_addr_t get_page_addr_code(CPUArchState *env, target_ulong addr)
>          }
>      }
>
> -    if (unlikely(env->tlb_table[mmu_idx][index].addr_code & TLB_RECHECK)) {
> +    if (unlikely((env->tlb_table[mmu_idx][index].addr_code &
> +                  (TLB_RECHECK | TLB_INVALID_MASK)) == TLB_RECHECK)) {
>          /*
>           * This is a TLB_RECHECK access, where the MMU protection
>           * covers a smaller range than a target page, and we must

Looking again at this code, I think that now we have the code to
ensure that there's only ever one entry in the TLB/victim TLB for
a given guest address, this change is unnecessary. The sequence

    if (unlikely(!tlb_hit(env->tlb_table[mmu_idx][index].addr_code, addr))) {
        if (!VICTIM_TLB_HIT(addr_read, addr)) {
            tlb_fill(ENV_GET_CPU(env), addr, 0, MMU_INST_FETCH, mmu_idx, 0);
        }
    }

should result in us always either (a) taking a guest exception and
longjumping out of the tlb_fill(), or (b) ending up with the TLB
containing an entry valid for an insn fetch, ie addr_code does not
have TLB_INVALID_MASK set. So we could drop the check on TLB_INVALID_MASK
here and instead have:

    assert(tlb_hit(env->tlb_table[mmu_idx][index].addr_code, addr));

(I'm looking at this code and trying to clean up the mishandling of
execution from rom-device-not-in-romd-mode. Patches to follow later...)

thanks
-- PMM
