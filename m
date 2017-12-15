Received: from eggs.gnu.org ([2001:4830:134:3::10]:40584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ePtqO-0005BZ-Qg
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 12:32:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ePtqO-0006q4-0a
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 12:32:20 -0500
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:40040)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ePtqN-0006p6-R3
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 12:32:19 -0500
Received: by mail-ot0-x243.google.com with SMTP id e74so8407683ote.7
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 09:32:19 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171215170732.31125-3-richard.henderson@linaro.org>
References: <20171215170732.31125-1-richard.henderson@linaro.org>
	<20171215170732.31125-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Dec 2017 17:31:58 +0000
Message-ID: <CAFEAcA_b4SOUN1tCyjNBPnf12SejPzBL-9dHQv6=K0C1HqTwag@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 2/7] target/moxie: Fix tlb_fill
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Anthony Green <green@moxielogic.com>

On 15 December 2017 at 17:07, Richard Henderson
<richard.henderson@linaro.org> wrote:
> We should not exit unless moxie_cpu_handle_mmu_fault has failed.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/moxie/helper.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/target/moxie/helper.c b/target/moxie/helper.c
> index 2ecee89f11..6890ffd71c 100644
> --- a/target/moxie/helper.c
> +++ b/target/moxie/helper.c
> @@ -36,9 +36,8 @@ void tlb_fill(CPUState *cs, target_ulong addr, MMUAccessType access_type,
>
>      ret = moxie_cpu_handle_mmu_fault(cs, addr, access_type, mmu_idx);
>      if (unlikely(ret)) {
> -        cpu_restore_state(cs, retaddr);
> +        cpu_loop_exit_restore(cs, retaddr);
>      }
> -    cpu_loop_exit(cs);
>  }
>
>  void helper_raise_exception(CPUMoxieState *env, int ex)
> --

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

I suspect this codepath has never been tested. There's another
bug in moxie_cpu_handle_mmu_fault() where it will call
tlb_set_page() even in the "mmu lookup missed, we're
going to throw an exception" codepath.

Is moxie even worth bothering to keep in QEMU? As far as I can tell:
 * the only changes to target/moxie since the target was added in
   2013 have been generic cross-tree changes and cleanups and
   minor bugs found by static analysis etc
 * the last commit signed-off-by the moxie maintainer was
   in March 2013
 * last email to qemu-devel by the maintainer was December 2013
 * as far as I can tell nobody's ever reported a bug to us,
   which is suggestive that it has no users

This target is costing us maintenance effort -- is it actually
useful to anybody ?

thanks
-- PMM
