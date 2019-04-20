Received: from eggs.gnu.org ([209.51.188.92]:56135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hHvBM-0001lG-Ci
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 14:57:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hHvBL-0006PV-8K
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 14:57:48 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:45440)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hHvBL-0006OL-2W
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 14:57:47 -0400
Received: by mail-ot1-x341.google.com with SMTP id e5so6646002otk.12
	for <qemu-devel@nongnu.org>; Sat, 20 Apr 2019 11:57:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190419114502.20388-1-shahab.vahedi@gmail.com>
In-Reply-To: <20190419114502.20388-1-shahab.vahedi@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 20 Apr 2019 19:57:31 +0100
Message-ID: <CAFEAcA_2aNt10Ti8HCTbCvHrgFYt7Uw2z=pNWBWyWMsbR6kjoQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] cputlb: Fix io_readx() to respect the
 access_type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shahab Vahedi <shahab.vahedi@gmail.com>
Cc: "open list:Overall" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Fri, 19 Apr 2019 at 12:46, Shahab Vahedi <shahab.vahedi@gmail.com> wrote:
>
> This change adapts io_readx() to its input access_type. Currently
> io_readx() treats any memory access as a read, although it has an
> input argument "MMUAccessType access_type". This results in:
>
> 1) Calling the tlb_fill() only with MMU_DATA_LOAD
> 2) Considering only entry->addr_read as the tlb_addr
>
> Buglink: https://bugs.launchpad.net/qemu/+bug/1825359
>
> Signed-off-by: Shahab Vahedi <shahab.vahedi@gmail.com>
> ---
> Changelog:
> - Extra space before closing parenthesis is removed
>
>  accel/tcg/cputlb.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Hi; this patch mostly looks good; thanks for submitting it.

> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 88cc8389e9..4a305ac942 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -878,10 +878,13 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
>          CPUTLBEntry *entry;
>          target_ulong tlb_addr;
>
> -        tlb_fill(cpu, addr, size, MMU_DATA_LOAD, mmu_idx, retaddr);
> +        tlb_fill(cpu, addr, size, access_type, mmu_idx, retaddr);
>
>          entry = tlb_entry(env, mmu_idx, addr);
> -        tlb_addr = entry->addr_read;
> +        tlb_addr =
> +            (access_type == MMU_DATA_LOAD)  ? entry->addr_read  :
> +            (access_type == MMU_DATA_STORE) ? entry->addr_write :
> +            entry->addr_code;

Here you don't need to handle MMU_DATA_STORE, because
we're in io_readx -- stores will go to io_writex, not here.

Style-wise it's probably better just to use an
  if (...) {
      tlb_addr = ...;
  } else {
      tlb_addr = ...;
  }

rather than a multi-line ?: expression.

>          if (!(tlb_addr & ~(TARGET_PAGE_MASK | TLB_RECHECK))) {
>              /* RAM access */
>              uintptr_t haddr = addr + entry->addend;
> --
> 2.21.0
>

thanks
-- PMM
