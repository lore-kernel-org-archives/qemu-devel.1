Received: from eggs.gnu.org ([2001:4830:134:3::10]:43929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fZL1u-0006gl-Tz
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 14:55:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fZL1u-000466-4Q
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 14:55:30 -0400
Received: from mail-yb0-x241.google.com ([2607:f8b0:4002:c09::241]:40544)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1fZL1t-00044K-E3
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 14:55:29 -0400
Received: by mail-yb0-x241.google.com with SMTP id y11-v6so245701ybm.7
	for <qemu-devel@nongnu.org>; Sat, 30 Jun 2018 11:55:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180622135823.32421-1-peter.maydell@linaro.org>
References: <20180622135823.32421-1-peter.maydell@linaro.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Sat, 30 Jun 2018 11:55:28 -0700
Message-ID: <CAMo8BfLsASNPVKix0U2sP55omcbcVUQJen4kpcoLjH=86PdPgA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC PATCH] xtensa: Avoid calling
 get_page_addr_code() from helper function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Patch Tracking <patches@linaro.org>, Richard Henderson <rth@twiddle.net>

On Fri, Jun 22, 2018 at 6:58 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
> The xtensa frontend calls get_page_addr_code() from its
> itlb_hit_test helper function. This function is really part
> of the TCG core's internals, and calling it from a target
> helper makes it awkward to make changes to that core code.
> It also means that we don't pass the correct retaddr to
> tlb_fill(), so we won't correctly handle the case where
> an exception is generated.
>
> The helper is used for the instructions IHI, IHU and IPFL.
>
> Change it to call cpu_ldb_code_ra() instead.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> This retains the current behaviour that all these insns
> may cause exceptions both for MMU permissions checks
> failures and also for "resulting physaddr doesn't point
> at memory".
>
> My reading of the ISA manual is that this isn't strictly
> correct for IHI and IHU, which ought to only cause MMU
> exceptions but not actually do a memory access. If we
> wanted to fix that, the right thing would be to split
> them into their own helper function, which could then
> just do a tlb_fill().
>
> Tagged as RFC because I don't have any xtensa test images.
>
> My motivation here is that at some point I'd like us to
> support execution from arbitrary MMIO/small MPU regions/etc,
> for which purpose get_page_addr_code() will change to return
> -1 to mean "this isn't RAM, load a single insn into a
> throwaway TB and execute it"...

I'm taking this patch, thank you. This test is not worse than
what is done for the data cache. And if it causes problem it'd
be easy to spot, because an exception code for accessing
nonexistent physical memory is very unusual.

-- 
Thanks.
-- Max
