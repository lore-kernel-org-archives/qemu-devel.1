Received: from eggs.gnu.org ([2001:4830:134:3::10]:48956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1ddnRr-0005YB-1C
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 21:00:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1ddnRn-0004H8-Cv
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 21:00:11 -0400
Date: Sat, 5 Aug 2017 02:59:49 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Message-ID: <20170805005949.GY4859@toto>
References: <1501867249-1924-1-git-send-email-peter.maydell@linaro.org>
	<1501867249-1924-2-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1501867249-1924-2-git-send-email-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 1/8] memory.h: Move MemTxResult
 type to memattrs.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, patches@linaro.org

On Fri, Aug 04, 2017 at 06:20:42PM +0100, Peter Maydell wrote:
> Move the MemTxResult type to memattrs.h. We're going to want to
> use it in cpu/qom.h, which doesn't want to include all of
> memory.h. In practice MemTxResult and MemTxAttrs are pretty
> closely linked since both are used for the new-style
> read_with_attrs and write_with_attrs callbacks, so memattrs.h
> is a reasonable home for this rather than creating a whole
> new header file for it.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>


> ---
>  include/exec/memattrs.h | 10 ++++++++++
>  include/exec/memory.h   | 10 ----------
>  2 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/include/exec/memattrs.h b/include/exec/memattrs.h
> index e601061..d4a1642 100644
> --- a/include/exec/memattrs.h
> +++ b/include/exec/memattrs.h
> @@ -46,4 +46,14 @@ typedef struct MemTxAttrs {
>   */
>  #define MEMTXATTRS_UNSPECIFIED ((MemTxAttrs) { .unspecified = 1 })
>  
> +/* New-style MMIO accessors can indicate that the transaction failed.
> + * A zero (MEMTX_OK) response means success; anything else is a failure
> + * of some kind. The memory subsystem will bitwise-OR together results
> + * if it is synthesizing an operation from multiple smaller accesses.
> + */
> +#define MEMTX_OK 0
> +#define MEMTX_ERROR             (1U << 0) /* device returned an error */
> +#define MEMTX_DECODE_ERROR      (1U << 1) /* nothing at that address */
> +typedef uint32_t MemTxResult;
> +
>  #endif
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 400dd44..1dcd312 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -112,16 +112,6 @@ static inline void iommu_notifier_init(IOMMUNotifier *n, IOMMUNotify fn,
>      n->end = end;
>  }
>  
> -/* New-style MMIO accessors can indicate that the transaction failed.
> - * A zero (MEMTX_OK) response means success; anything else is a failure
> - * of some kind. The memory subsystem will bitwise-OR together results
> - * if it is synthesizing an operation from multiple smaller accesses.
> - */
> -#define MEMTX_OK 0
> -#define MEMTX_ERROR             (1U << 0) /* device returned an error */
> -#define MEMTX_DECODE_ERROR      (1U << 1) /* nothing at that address */
> -typedef uint32_t MemTxResult;
> -
>  /*
>   * Memory region callbacks
>   */
> -- 
> 2.7.4
> 
> 
