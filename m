Received: from eggs.gnu.org ([2001:4830:134:3::10]:46801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fZLQ4-0004dC-3q
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 15:20:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fZLQ3-0003SA-9Q
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 15:20:28 -0400
MIME-Version: 1.0
In-Reply-To: <20180620130619.11362-2-peter.maydell@linaro.org>
References: <20180620130619.11362-1-peter.maydell@linaro.org>
	<20180620130619.11362-2-peter.maydell@linaro.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Sat, 30 Jun 2018 12:20:24 -0700
Message-ID: <CAMo8BfLRr16q4_nj0vacK4N4fb0EBymXZB6SHon72h7BJ9M5jw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/3] tcg: Support MMU protection regions
 smaller than TARGET_PAGE_SIZE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Patch Tracking <patches@linaro.org>

Hi Peter,

On Wed, Jun 20, 2018 at 6:06 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
> Add support for MMU protection regions that are smaller than
> TARGET_PAGE_SIZE. We do this by marking the TLB entry for those
> pages with a flag TLB_RECHECK. This flag causes us to always
> take the slow-path for accesses. In the slow path we can then
> special case them to always call tlb_fill() again, so we have
> the correct information for the exact address being accessed.
>
> This change allows us to handle reading and writing from small
> regions; we cannot deal with execution from the small region.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  accel/tcg/softmmu_template.h |  24 ++++---
>  include/exec/cpu-all.h       |   5 +-
>  accel/tcg/cputlb.c           | 131 +++++++++++++++++++++++++++++------
>  3 files changed, 130 insertions(+), 30 deletions(-)

I'm observing the following failure with xtensa tests:

(qemu) qemu: fatal: Unable to handle guest executing from RAM within a
small MPU region at 0xd0000804

Bisection points to this patch. Any idea what happened?

-- 
Thanks.
-- Max
