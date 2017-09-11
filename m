Received: from eggs.gnu.org ([2001:4830:134:3::10]:33944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1drM1U-0000Xf-Ux
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 06:33:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1drM1R-0003eb-OM
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 06:33:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38618)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1drM1R-0003eD-Gt
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 06:32:57 -0400
References: <20170903163304.17919-1-n54@gmx.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <64a0355f-e42e-6c93-b1a1-312aaf913b09@redhat.com>
Date: Mon, 11 Sep 2017 12:32:53 +0200
MIME-Version: 1.0
In-Reply-To: <20170903163304.17919-1-n54@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] memory: Rename queue to mrqueue (memory
 region queue)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kamil Rytarowski <n54@gmx.com>
Cc: qemu-devel@nongnu.org

On 03/09/2017 18:33, Kamil Rytarowski wrote:
> SunOS declares struct queue in <netinet/in.h>.
> 
> This fixes build on SmartOS (Joyent).
> 
> Patch cherry-picked from pkgsrc by jperkin (Joyent).
> 
> Signed-off-by: Kamil Rytarowski <n54@gmx.com>
> ---
>  memory.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/memory.c b/memory.c
> index c0adc35410..b9920a6540 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -2701,10 +2701,10 @@ typedef struct MemoryRegionList MemoryRegionList;
>  
>  struct MemoryRegionList {
>      const MemoryRegion *mr;
> -    QTAILQ_ENTRY(MemoryRegionList) queue;
> +    QTAILQ_ENTRY(MemoryRegionList) mrqueue;
>  };
>  
> -typedef QTAILQ_HEAD(queue, MemoryRegionList) MemoryRegionListHead;
> +typedef QTAILQ_HEAD(mrqueue, MemoryRegionList) MemoryRegionListHead;
>  
>  #define MR_SIZE(size) (int128_nz(size) ? (hwaddr)int128_get64( \
>                             int128_sub((size), int128_one())) : 0)
> @@ -2746,7 +2746,7 @@ static void mtree_print_mr(fprintf_function mon_printf, void *f,
>          bool found = false;
>  
>          /* check if the alias is already in the queue */
> -        QTAILQ_FOREACH(ml, alias_print_queue, queue) {
> +        QTAILQ_FOREACH(ml, alias_print_queue, mrqueue) {
>              if (ml->mr == mr->alias) {
>                  found = true;
>              }
> @@ -2755,7 +2755,7 @@ static void mtree_print_mr(fprintf_function mon_printf, void *f,
>          if (!found) {
>              ml = g_new(MemoryRegionList, 1);
>              ml->mr = mr->alias;
> -            QTAILQ_INSERT_TAIL(alias_print_queue, ml, queue);
> +            QTAILQ_INSERT_TAIL(alias_print_queue, ml, mrqueue);
>          }
>          mon_printf(f, TARGET_FMT_plx "-" TARGET_FMT_plx
>                     " (prio %d, %s): alias %s @%s " TARGET_FMT_plx
> @@ -2783,26 +2783,26 @@ static void mtree_print_mr(fprintf_function mon_printf, void *f,
>      QTAILQ_FOREACH(submr, &mr->subregions, subregions_link) {
>          new_ml = g_new(MemoryRegionList, 1);
>          new_ml->mr = submr;
> -        QTAILQ_FOREACH(ml, &submr_print_queue, queue) {
> +        QTAILQ_FOREACH(ml, &submr_print_queue, mrqueue) {
>              if (new_ml->mr->addr < ml->mr->addr ||
>                  (new_ml->mr->addr == ml->mr->addr &&
>                   new_ml->mr->priority > ml->mr->priority)) {
> -                QTAILQ_INSERT_BEFORE(ml, new_ml, queue);
> +                QTAILQ_INSERT_BEFORE(ml, new_ml, mrqueue);
>                  new_ml = NULL;
>                  break;
>              }
>          }
>          if (new_ml) {
> -            QTAILQ_INSERT_TAIL(&submr_print_queue, new_ml, queue);
> +            QTAILQ_INSERT_TAIL(&submr_print_queue, new_ml, mrqueue);
>          }
>      }
>  
> -    QTAILQ_FOREACH(ml, &submr_print_queue, queue) {
> +    QTAILQ_FOREACH(ml, &submr_print_queue, mrqueue) {
>          mtree_print_mr(mon_printf, f, ml->mr, level + 1, cur_start,
>                         alias_print_queue);
>      }
>  
> -    QTAILQ_FOREACH_SAFE(ml, &submr_print_queue, queue, next_ml) {
> +    QTAILQ_FOREACH_SAFE(ml, &submr_print_queue, mrqueue, next_ml) {
>          g_free(ml);
>      }
>  }
> @@ -2872,13 +2872,13 @@ void mtree_info(fprintf_function mon_printf, void *f, bool flatview)
>      }
>  
>      /* print aliased regions */
> -    QTAILQ_FOREACH(ml, &ml_head, queue) {
> +    QTAILQ_FOREACH(ml, &ml_head, mrqueue) {
>          mon_printf(f, "memory-region: %s\n", memory_region_name(ml->mr));
>          mtree_print_mr(mon_printf, f, ml->mr, 1, 0, &ml_head);
>          mon_printf(f, "\n");
>      }
>  
> -    QTAILQ_FOREACH_SAFE(ml, &ml_head, queue, ml2) {
> +    QTAILQ_FOREACH_SAFE(ml, &ml_head, mrqueue, ml2) {
>          g_free(ml);
>      }
>  }
> 

Queued, thanks.

Paolo
