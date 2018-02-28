Received: from eggs.gnu.org ([2001:4830:134:3::10]:37367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1er8jV-00008U-0G
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 15:53:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1er8jQ-0008MA-L2
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 15:53:49 -0500
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:38834)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1er8jQ-0008Lc-Dy
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 15:53:44 -0500
Received: by mail-pf0-x244.google.com with SMTP id d26so1502954pfn.5
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 12:53:44 -0800 (PST)
References: <1519709965-29833-1-git-send-email-cota@braap.org>
	<1519709965-29833-4-git-send-email-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <27f68fa5-a4ad-fbcf-3167-0f26a2a6aeda@linaro.org>
Date: Wed, 28 Feb 2018 12:53:39 -0800
MIME-Version: 1.0
In-Reply-To: <1519709965-29833-4-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 03/16] tcg: track TBs with per-region BST's
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>

On 02/26/2018 09:39 PM, Emilio G. Cota wrote:
> This paves the way for enabling scalable parallel generation of TCG code.
> 
> Instead of tracking TBs with a single binary search tree (BST), use a
> BST for each TCG region, protecting it with a lock. This is as scalable
> as it gets, since each TCG thread operates on a separate region.
> 
> The core of this change is the introduction of struct tcg_region_tree,
> which contains a pointer to a GTree and an associated lock to serialize
> accesses to it. We then allocate an array of tcg_region_tree's, adding
> the appropriate padding to avoid false sharing based on
> qemu_dcache_linesize.
> 
> Given a tc_ptr, we first find the corresponding region_tree. This
> is done by special-casing the first and last regions first, since they
> might be of size != region.size; otherwise we just divide the offset
> by region.stride. I was worried about this division (several dozen
> cycles of latency), but profiling shows that this is not a fast path.
> Note that region.stride is not required to be a power of two; it
> is only required to be a multiple of the host's page size.
> 
> Note that with this design we can also provide consistent snapshots
> about all region trees at once; for instance, tcg_tb_foreach
> acquires/releases all region_tree locks before/after iterating over them.
> For this reason we now drop tb_lock in dump_exec_info().
> 
> As an alternative I considered implementing a concurrent BST, but this
> can be tricky to get right, offers no consistent snapshots of the BST,
> and performance and scalability-wise I don't think it could ever beat
> having separate GTrees, given that our workload is insert-mostly (all
> concurrent BST designs I've seen focus, understandably, on making
> lookups fast, which comes at the expense of convoluted, non-wait-free
> insertions/removals).
> 
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  accel/tcg/cpu-exec.c      |   2 +-
>  accel/tcg/translate-all.c | 101 ++++--------------------
>  include/exec/exec-all.h   |   1 -
>  include/exec/tb-context.h |   1 -
>  tcg/tcg.c                 | 191 ++++++++++++++++++++++++++++++++++++++++++++++
>  tcg/tcg.h                 |   6 ++
>  6 files changed, 213 insertions(+), 89 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
