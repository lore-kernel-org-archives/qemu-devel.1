Received: from eggs.gnu.org ([2001:4830:134:3::10]:40962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cTXhO-0007RN-Jk
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 12:37:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cTXhL-0007io-FM
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 12:37:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54206)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cTXhL-0007hs-6r
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 12:37:31 -0500
Date: Tue, 17 Jan 2017 17:37:25 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170117173724.GF2053@work-vm>
References: <1484556005-29701-1-git-send-email-peterx@redhat.com>
	<1484556005-29701-3-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484556005-29701-3-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 2/2] memory: hmp: add "-f" for "info
 mtree"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, marcandre.lureau@gmail.com

* Peter Xu (peterx@redhat.com) wrote:
> Adding one more option "-f" for "info mtree" to dump the flat views of
> all the address spaces.
> 
> This will be useful to debug the memory rendering logic, also it'll be
> much easier with it to know what memory region is handling what address
> range.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  hmp-commands-info.hx  |  6 +++---
>  include/exec/memory.h |  2 +-
>  memory.c              | 41 ++++++++++++++++++++++++++++++++++++++++-
>  monitor.c             |  4 +++-
>  4 files changed, 47 insertions(+), 6 deletions(-)
> 
> diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
> index 55d50c4..b0f35e6 100644
> --- a/hmp-commands-info.hx
> +++ b/hmp-commands-info.hx
> @@ -249,9 +249,9 @@ ETEXI
>  
>      {
>          .name       = "mtree",
> -        .args_type  = "",
> -        .params     = "",
> -        .help       = "show memory tree",
> +        .args_type  = "flatview:-f",
> +        .params     = "[-f]",
> +        .help       = "show memory tree (-f: dump flat view for address spaces)",
>          .cmd        = hmp_info_mtree,
>      },
>  
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index bec9756..71db380 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -1254,7 +1254,7 @@ void memory_global_dirty_log_start(void);
>   */
>  void memory_global_dirty_log_stop(void);
>  
> -void mtree_info(fprintf_function mon_printf, void *f);
> +void mtree_info(fprintf_function mon_printf, void *f, bool flatview);
>  
>  /**
>   * memory_region_dispatch_read: perform a read directly to the specified
> diff --git a/memory.c b/memory.c
> index c42bde4..6498727 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -2564,12 +2564,51 @@ static void mtree_print_mr(fprintf_function mon_printf, void *f,
>      }
>  }
>  
> -void mtree_info(fprintf_function mon_printf, void *f)
> +static void mtree_print_flatview(fprintf_function p, void *f,
> +                                 AddressSpace *as)
> +{
> +    FlatView *view = address_space_get_flatview(as);
> +    FlatRange *range = &view->ranges[0];
> +    MemoryRegion *mr;
> +    int n = view->nr;
> +
> +    if (n <= 0) {
> +        p(f, MTREE_INDENT "No rendered FlatView for "
> +          "address space '%s'\n", as->name);
> +        flatview_unref(view);
> +        return;
> +    }
> +
> +    while (n--) {
> +        mr = range->mr;
> +        p(f, MTREE_INDENT TARGET_FMT_plx "-"
> +          TARGET_FMT_plx " (prio %d, %s): %s\n",
> +          int128_get64(range->addr.start),
> +          int128_get64(range->addr.start) + MR_SIZE(range->addr.size),
> +          mr->priority,
> +          memory_region_type(mr),
> +          memory_region_name(mr));
> +        range++;
> +    }
> +
> +    flatview_unref(view);
> +}
> +
> +void mtree_info(fprintf_function mon_printf, void *f, bool flatview)
>  {
>      MemoryRegionListHead ml_head;
>      MemoryRegionList *ml, *ml2;
>      AddressSpace *as;
>  
> +    if (flatview) {
> +        QTAILQ_FOREACH(as, &address_spaces, address_spaces_link) {
> +            mon_printf(f, "address-space (flat view): %s\n", as->name);
> +            mtree_print_flatview(mon_printf, f, as);
> +            mon_printf(f, "\n");
> +        }
> +        return;
> +    }
> +
>      QTAILQ_INIT(&ml_head);
>  
>      QTAILQ_FOREACH(as, &address_spaces, address_spaces_link) {
> diff --git a/monitor.c b/monitor.c
> index 0841d43..679cd52 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -1529,7 +1529,9 @@ static void hmp_boot_set(Monitor *mon, const QDict *qdict)
>  
>  static void hmp_info_mtree(Monitor *mon, const QDict *qdict)
>  {
> -    mtree_info((fprintf_function)monitor_printf, mon);
> +    bool flatview = qdict_get_try_bool(qdict, "flatview", false);
> +
> +    mtree_info((fprintf_function)monitor_printf, mon, flatview);
>  }
>  
>  static void hmp_info_numa(Monitor *mon, const QDict *qdict)
> -- 
> 2.7.4
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
