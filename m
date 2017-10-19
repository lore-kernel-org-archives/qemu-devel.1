Received: from eggs.gnu.org ([2001:4830:134:3::10]:36379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e5HAZ-0007Jq-F7
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 16:11:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e5HAV-0001jz-7e
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 16:11:55 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:39719)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1e5HAV-0001jm-05
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 16:11:51 -0400
Date: Thu, 19 Oct 2017 16:11:49 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20171019201149.GA15218@flamenco>
References: <20171016172609.23422-1-richard.henderson@linaro.org>
	<20171018224518.GA28532@flamenco>
	<5381cf3d-00c9-1c05-c973-5934311d654d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5381cf3d-00c9-1c05-c973-5934311d654d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 00/50] tcg tb_lock removal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org

On Thu, Oct 19, 2017 at 15:05:17 +0200, Paolo Bonzini wrote:
> On 19/10/2017 00:45, Emilio G. Cota wrote:
> > I have just pushed a branch on top of this series that includes
> > 10 patches that further pave the way for the removal of tb_lock:
> > 
> >   https://github.com/cota/qemu/tree/multi-tcg-v6-plus
> 
> I started reviewing those,

Nice, thanks!

> I have a few questions:
> 
> 1) why is tcg_region_tree separate from tcg_region_state?  Would it make
> sense to prepare a linked list of tcg_region_state structs, and reuse
> the region lock for the region tree?

I think the naming here might be confusing; "tcg_region_state" should be
understood as "tcg_region_global_state". IOW, there is no per-region struct.

That said, the array of per-region trees could be embedded in this global
struct. I was hesitant to do so because then one could think that
region_state.lock and rt.lock are somehow related; they are not.

> 2) in tb_for_each_tagged_safe, could the "prev" argument instead be
> "next", like
> 
> 
> +    for (n = (head) & 1,                                        \
> +             tb = (TranslationBlock *)((head) & ~1);            \
> +         tb && ((next = (TranslationBlock *)tb->field[n]), 1);  \
> +             n = (uintptr_t)next & 1,                           \
> +             tb = (TranslationBlock *)((uintptr_t)next & ~1))

Is this just to make them closer to the macros in queue.h?

In this case tracking *prev in the loop (rather than next) is
useful because it makes removing the "current" element very simple:

static inline void tb_page_remove(PageDesc *pd, TranslationBlock *tb)
{
    TranslationBlock *tb1;
    uintptr_t *prev;
    unsigned int n1;

    page_for_each_tb_safe(pd, tb1, n1, prev) {
        if (tb1 == tb) {
            *prev = tb1->page_next[n1];
            return;
        }
    }
    g_assert_not_reached();
}

If we wanted to use something similar to QSLIST_REMOVE_AFTER, we'd
have to track three pointers instead of two: prev (tracked by the caller),
current and next (these two as part of the for loop).

> (also please make the iterator macros UPPERCASE)

Will do.

> 3) "translate-all: exit from tb_phys_invalidate if qht_remove fails" may
> be worth posting now?

I'll post it to be included in the next iteration of this series.

Thanks,

		Emilio
