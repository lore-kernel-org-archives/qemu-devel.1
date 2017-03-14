Received: from eggs.gnu.org ([2001:4830:134:3::10]:60412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cnnuw-0000oR-Ag
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 10:59:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cnnuv-0000cZ-1e
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 10:59:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45400)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cnnuu-0000cD-PE
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 10:59:16 -0400
Date: Tue, 14 Mar 2017 16:59:10 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170314165824-mutt-send-email-mst@kernel.org>
References: <1489496187-624-1-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1489496187-624-1-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] memory: info mtree check mr range overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, mark.cave-ayland@ilande.co.uk, Peter Maydell <peter.maydell@linaro.org>

On Tue, Mar 14, 2017 at 08:56:27PM +0800, Peter Xu wrote:
> The address of memory regions might overflow when something wrong
> happened, like reported in:
> 
> https://lists.gnu.org/archive/html/qemu-devel/2017-03/msg02043.html
> 
> For easier debugging, let's try to detect it.
> 
> Reported-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Peter Xu <peterx@redhat.com>

I think I already commented on this.
Please use Int128 math instead of hacks around 64 bit math.


> ---
>  memory.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/memory.c b/memory.c
> index 284894b..64b0a60 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -2494,6 +2494,7 @@ static void mtree_print_mr(fprintf_function mon_printf, void *f,
>      MemoryRegionListHead submr_print_queue;
>      const MemoryRegion *submr;
>      unsigned int i;
> +    hwaddr cur_start, cur_end;
>  
>      if (!mr) {
>          return;
> @@ -2503,6 +2504,18 @@ static void mtree_print_mr(fprintf_function mon_printf, void *f,
>          mon_printf(f, MTREE_INDENT);
>      }
>  
> +    cur_start = base + mr->addr;
> +    cur_end = cur_start + MR_SIZE(mr->size);
> +
> +    /*
> +     * Try to detect overflow of memory region. This should never
> +     * happen normally. When it happens, we dump something to warn the
> +     * user who is observing this.
> +     */
> +    if (cur_start < base || cur_end < cur_start) {
> +        mon_printf(f, "[DETECTED OVERFLOW!] ");
> +    }
> +
>      if (mr->alias) {
>          MemoryRegionList *ml;
>          bool found = false;
> @@ -2522,8 +2535,7 @@ static void mtree_print_mr(fprintf_function mon_printf, void *f,
>          mon_printf(f, TARGET_FMT_plx "-" TARGET_FMT_plx
>                     " (prio %d, %s): alias %s @%s " TARGET_FMT_plx
>                     "-" TARGET_FMT_plx "%s\n",
> -                   base + mr->addr,
> -                   base + mr->addr + MR_SIZE(mr->size),
> +                   cur_start, cur_end,
>                     mr->priority,
>                     memory_region_type((MemoryRegion *)mr),
>                     memory_region_name(mr),
> @@ -2534,8 +2546,7 @@ static void mtree_print_mr(fprintf_function mon_printf, void *f,
>      } else {
>          mon_printf(f,
>                     TARGET_FMT_plx "-" TARGET_FMT_plx " (prio %d, %s): %s%s\n",
> -                   base + mr->addr,
> -                   base + mr->addr + MR_SIZE(mr->size),
> +                   cur_start, cur_end,
>                     mr->priority,
>                     memory_region_type((MemoryRegion *)mr),
>                     memory_region_name(mr),
> @@ -2562,7 +2573,7 @@ static void mtree_print_mr(fprintf_function mon_printf, void *f,
>      }
>  
>      QTAILQ_FOREACH(ml, &submr_print_queue, queue) {
> -        mtree_print_mr(mon_printf, f, ml->mr, level + 1, base + mr->addr,
> +        mtree_print_mr(mon_printf, f, ml->mr, level + 1, cur_start,
>                         alias_print_queue);
>      }
>  
> -- 
> 2.7.4
