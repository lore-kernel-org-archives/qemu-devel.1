Received: from eggs.gnu.org ([209.51.188.92]:44847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLAI4-00070j-Jo
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:42:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLAI3-0005EH-HP
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:42:08 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:35257)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hLAI3-00059s-Ak
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:42:07 -0400
Received: by mail-oi1-x243.google.com with SMTP id w197so9021900oia.2
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 10:42:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190403034358.21999-1-richard.henderson@linaro.org>
	<20190403034358.21999-27-richard.henderson@linaro.org>
In-Reply-To: <20190403034358.21999-27-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 18:41:49 +0100
Message-ID: <CAFEAcA_TJJ7V3apxmGvhoiRk2dxzT77SapcyMuopGwqmeQoosw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 26/26] tcg: Use tlb_fill probe from
 tlb_vaddr_to_host
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

On Wed, 3 Apr 2019 at 05:05, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Most of the existing users would continue around a loop which
> would fault the tlb entry in via a normal load/store.  But for
> SVE we have a true non-faulting case which requires the new
> probing form of tlb_fill.

So am I right in thinking that this fixes a bug where we
previously would mark a load as faulted if the memory happened
not to be in the TLB, whereas now we will correctly pull in the
TLB entry and do the load ?

(Since guest code ought to be handling the "non-first-load
faulted" case by looping round or otherwise arranging to
retry, nothing in practice would have noticed this bug, right?)

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/exec/cpu_ldst.h | 40 ++++--------------------
>  accel/tcg/cputlb.c      | 69 ++++++++++++++++++++++++++++++++++++-----
>  target/arm/sve_helper.c |  6 +---
>  3 files changed, 68 insertions(+), 47 deletions(-)
>
> diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
> index d78041d7a0..be8c3f4da2 100644
> --- a/include/exec/cpu_ldst.h
> +++ b/include/exec/cpu_ldst.h
> @@ -440,43 +440,15 @@ static inline CPUTLBEntry *tlb_entry(CPUArchState *env, uintptr_t mmu_idx,
>   * This is the equivalent of the initial fast-path code used by
>   * TCG backends for guest load and store accesses.
>   */

The doc comment which this is the last two lines of needs
updating, I think -- with the changed implementation it's
no longer just the equivalent of the fast-path bit of code,
and it doesn't return NULL on a TLB miss any more.

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
