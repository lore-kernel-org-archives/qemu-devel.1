Received: from eggs.gnu.org ([2001:4830:134:3::10]:58204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dofQt-00039w-M4
	for qemu-devel@nongnu.org; Sun, 03 Sep 2017 20:40:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dofQo-0002pE-RL
	for qemu-devel@nongnu.org; Sun, 03 Sep 2017 20:40:07 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:38554)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dofQo-0002ou-Lv
	for qemu-devel@nongnu.org; Sun, 03 Sep 2017 20:40:02 -0400
Received: by mail-qt0-x243.google.com with SMTP id d15so3524815qta.5
	for <qemu-devel@nongnu.org>; Sun, 03 Sep 2017 17:40:02 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170903163304.17919-1-n54@gmx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6b1b26a9-092c-4bd1-bcae-4041d1ec74b5@amsat.org>
Date: Sun, 3 Sep 2017 21:39:57 -0300
MIME-Version: 1.0
In-Reply-To: <20170903163304.17919-1-n54@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: Kamil Rytarowski <n54@gmx.com>, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org

Hi Kamil,

On 09/03/2017 01:33 PM, Kamil Rytarowski wrote:
> SunOS declares struct queue in <netinet/in.h>.

I didn't check what is this define for, but I'd rather add in 
include/sysemu/os-posix.h:

#ifdef queue
#undef queue
#endif

If no QEMU code rely on this netinet queue.

> 
> This fixes build on SmartOS (Joyent).
> 
> Patch cherry-picked from pkgsrc by jperkin (Joyent).
> 
> Signed-off-by: Kamil Rytarowski <n54@gmx.com>
> ---
>   memory.c | 22 +++++++++++-----------
>   1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/memory.c b/memory.c
> index c0adc35410..b9920a6540 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -2701,10 +2701,10 @@ typedef struct MemoryRegionList MemoryRegionList;
>   
>   struct MemoryRegionList {
>       const MemoryRegion *mr;
> -    QTAILQ_ENTRY(MemoryRegionList) queue;
> +    QTAILQ_ENTRY(MemoryRegionList) mrqueue;
>   };
>   
> -typedef QTAILQ_HEAD(queue, MemoryRegionList) MemoryRegionListHead;
> +typedef QTAILQ_HEAD(mrqueue, MemoryRegionList) MemoryRegionListHead;
>   
>   #define MR_SIZE(size) (int128_nz(size) ? (hwaddr)int128_get64( \
>                              int128_sub((size), int128_one())) : 0)
> @@ -2746,7 +2746,7 @@ static void mtree_print_mr(fprintf_function mon_printf, void *f,
>           bool found = false;
>   
>           /* check if the alias is already in the queue */
> -        QTAILQ_FOREACH(ml, alias_print_queue, queue) {
> +        QTAILQ_FOREACH(ml, alias_print_queue, mrqueue) {
>               if (ml->mr == mr->alias) {
>                   found = true;
>               }
> @@ -2755,7 +2755,7 @@ static void mtree_print_mr(fprintf_function mon_printf, void *f,
>           if (!found) {
>               ml = g_new(MemoryRegionList, 1);
>               ml->mr = mr->alias;
> -            QTAILQ_INSERT_TAIL(alias_print_queue, ml, queue);
> +            QTAILQ_INSERT_TAIL(alias_print_queue, ml, mrqueue);
>           }
>           mon_printf(f, TARGET_FMT_plx "-" TARGET_FMT_plx
>                      " (prio %d, %s): alias %s @%s " TARGET_FMT_plx
> @@ -2783,26 +2783,26 @@ static void mtree_print_mr(fprintf_function mon_printf, void *f,
>       QTAILQ_FOREACH(submr, &mr->subregions, subregions_link) {
>           new_ml = g_new(MemoryRegionList, 1);
>           new_ml->mr = submr;
> -        QTAILQ_FOREACH(ml, &submr_print_queue, queue) {
> +        QTAILQ_FOREACH(ml, &submr_print_queue, mrqueue) {
>               if (new_ml->mr->addr < ml->mr->addr ||
>                   (new_ml->mr->addr == ml->mr->addr &&
>                    new_ml->mr->priority > ml->mr->priority)) {
> -                QTAILQ_INSERT_BEFORE(ml, new_ml, queue);
> +                QTAILQ_INSERT_BEFORE(ml, new_ml, mrqueue);
>                   new_ml = NULL;
>                   break;
>               }
>           }
>           if (new_ml) {
> -            QTAILQ_INSERT_TAIL(&submr_print_queue, new_ml, queue);
> +            QTAILQ_INSERT_TAIL(&submr_print_queue, new_ml, mrqueue);
>           }
>       }
>   
> -    QTAILQ_FOREACH(ml, &submr_print_queue, queue) {
> +    QTAILQ_FOREACH(ml, &submr_print_queue, mrqueue) {
>           mtree_print_mr(mon_printf, f, ml->mr, level + 1, cur_start,
>                          alias_print_queue);
>       }
>   
> -    QTAILQ_FOREACH_SAFE(ml, &submr_print_queue, queue, next_ml) {
> +    QTAILQ_FOREACH_SAFE(ml, &submr_print_queue, mrqueue, next_ml) {
>           g_free(ml);
>       }
>   }
> @@ -2872,13 +2872,13 @@ void mtree_info(fprintf_function mon_printf, void *f, bool flatview)
>       }
>   
>       /* print aliased regions */
> -    QTAILQ_FOREACH(ml, &ml_head, queue) {
> +    QTAILQ_FOREACH(ml, &ml_head, mrqueue) {
>           mon_printf(f, "memory-region: %s\n", memory_region_name(ml->mr));
>           mtree_print_mr(mon_printf, f, ml->mr, 1, 0, &ml_head);
>           mon_printf(f, "\n");
>       }
>   
> -    QTAILQ_FOREACH_SAFE(ml, &ml_head, queue, ml2) {
> +    QTAILQ_FOREACH_SAFE(ml, &ml_head, mrqueue, ml2) {
>           g_free(ml);
>       }
>   }
> 
