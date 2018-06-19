Received: from eggs.gnu.org ([2001:4830:134:3::10]:41201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fVHZV-0002hd-HX
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 10:25:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fVHZR-0002wq-8L
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 10:25:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36194 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fVHZR-0002vs-1y
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 10:25:21 -0400
References: <20180604032511.6980-1-aik@ozlabs.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <28144966-f4c5-4a27-c0dd-03f9df74fd32@redhat.com>
Date: Tue, 19 Jun 2018 16:25:18 +0200
MIME-Version: 1.0
In-Reply-To: <20180604032511.6980-1-aik@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu v4] memory/hmp: Print owners/parents
 in "info mtree"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org

On 04/06/2018 05:25, Alexey Kardashevskiy wrote:
> This adds owners/parents (which are the same, just occasionally
> owner==NULL) printing for memory regions; a new '-o' flag
> enabled new output.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Queued, thanks.

> ---
> 
> The only orphan object I know is printed now as:
>   0000000000000000-ffffffffffffffff (prio 0, i/o): mem-container-smram owner:{obj type=kvm-accel}
> 
> 
> Unrelated observation:
>   QEMU in x86_64 constantly hits breakpoints in unassigned_mem_accepts
>   and unassigned_mem_read (when set), in early boot stage before SeaBIOS
>   even shows up, the address is 0xfed40f00 and that is not anything
>   assigned. "info mtree" shows that it is surrounded by:
> 
>   	00000000fec00000-00000000fec00fff (prio 0, i/o): kvm-ioapic
> 	00000000fed00000-00000000fed003ff (prio 0, i/o): hpet
> 	00000000fee00000-00000000feefffff (prio 4096, i/o): kvm-apic-msi
> 
>   Is it something to worry about?

No, it's probing for a TPM in tis_probe.

Paolo

> ---
> Changes:
> v4:
> * prints object typename if canonical path could not be resolved
> 
> v3:
> * removed QOM's "id" property as there are no objects left which would
> have this property and own an MR
> 
> v2:
> * cleanups
> ---
>  include/exec/memory.h |  2 +-
>  memory.c              | 72 ++++++++++++++++++++++++++++++++++++++++++++-------
>  monitor.c             |  4 ++-
>  hmp-commands-info.hx  |  7 ++---
>  4 files changed, 70 insertions(+), 15 deletions(-)
> 
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 67ea7fe..95340b8 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -1627,7 +1627,7 @@ void memory_global_dirty_log_start(void);
>  void memory_global_dirty_log_stop(void);
>  
>  void mtree_info(fprintf_function mon_printf, void *f, bool flatview,
> -                bool dispatch_tree);
> +                bool dispatch_tree, bool owner);
>  
>  /**
>   * memory_region_request_mmio_ptr: request a pointer to an mmio
> diff --git a/memory.c b/memory.c
> index 10fa2dd..bf0a9f2 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -2832,10 +2832,49 @@ typedef QTAILQ_HEAD(mrqueue, MemoryRegionList) MemoryRegionListHead;
>                             int128_sub((size), int128_one())) : 0)
>  #define MTREE_INDENT "  "
>  
> +static void mtree_expand_owner(fprintf_function mon_printf, void *f,
> +                               const char *label, Object *obj)
> +{
> +    DeviceState *dev = (DeviceState *) object_dynamic_cast(obj, TYPE_DEVICE);
> +
> +    mon_printf(f, " %s:{%s", label, dev ? "dev" : "obj");
> +    if (dev && dev->id) {
> +        mon_printf(f, " id=%s", dev->id);
> +    } else {
> +        gchar *canonical_path = object_get_canonical_path(obj);
> +        if (canonical_path) {
> +            mon_printf(f, " path=%s", canonical_path);
> +            g_free(canonical_path);
> +        } else {
> +            mon_printf(f, " type=%s", object_get_typename(obj));
> +        }
> +    }
> +    mon_printf(f, "}");
> +}
> +
> +static void mtree_print_mr_owner(fprintf_function mon_printf, void *f,
> +                                 const MemoryRegion *mr)
> +{
> +    Object *owner = mr->owner;
> +    Object *parent = memory_region_owner((MemoryRegion *)mr);
> +
> +    if (!owner && !parent) {
> +        mon_printf(f, " orphan");
> +        return;
> +    }
> +    if (owner) {
> +        mtree_expand_owner(mon_printf, f, "owner", owner);
> +    }
> +    if (parent && parent != owner) {
> +        mtree_expand_owner(mon_printf, f, "parent", parent);
> +    }
> +}
> +
>  static void mtree_print_mr(fprintf_function mon_printf, void *f,
>                             const MemoryRegion *mr, unsigned int level,
>                             hwaddr base,
> -                           MemoryRegionListHead *alias_print_queue)
> +                           MemoryRegionListHead *alias_print_queue,
> +                           bool owner)
>  {
>      MemoryRegionList *new_ml, *ml, *next_ml;
>      MemoryRegionListHead submr_print_queue;
> @@ -2881,7 +2920,7 @@ static void mtree_print_mr(fprintf_function mon_printf, void *f,
>          }
>          mon_printf(f, TARGET_FMT_plx "-" TARGET_FMT_plx
>                     " (prio %d, %s): alias %s @%s " TARGET_FMT_plx
> -                   "-" TARGET_FMT_plx "%s\n",
> +                   "-" TARGET_FMT_plx "%s",
>                     cur_start, cur_end,
>                     mr->priority,
>                     memory_region_type((MemoryRegion *)mr),
> @@ -2890,15 +2929,22 @@ static void mtree_print_mr(fprintf_function mon_printf, void *f,
>                     mr->alias_offset,
>                     mr->alias_offset + MR_SIZE(mr->size),
>                     mr->enabled ? "" : " [disabled]");
> +        if (owner) {
> +            mtree_print_mr_owner(mon_printf, f, mr);
> +        }
>      } else {
>          mon_printf(f,
> -                   TARGET_FMT_plx "-" TARGET_FMT_plx " (prio %d, %s): %s%s\n",
> +                   TARGET_FMT_plx "-" TARGET_FMT_plx " (prio %d, %s): %s%s",
>                     cur_start, cur_end,
>                     mr->priority,
>                     memory_region_type((MemoryRegion *)mr),
>                     memory_region_name(mr),
>                     mr->enabled ? "" : " [disabled]");
> +        if (owner) {
> +            mtree_print_mr_owner(mon_printf, f, mr);
> +        }
>      }
> +    mon_printf(f, "\n");
>  
>      QTAILQ_INIT(&submr_print_queue);
>  
> @@ -2921,7 +2967,7 @@ static void mtree_print_mr(fprintf_function mon_printf, void *f,
>  
>      QTAILQ_FOREACH(ml, &submr_print_queue, mrqueue) {
>          mtree_print_mr(mon_printf, f, ml->mr, level + 1, cur_start,
> -                       alias_print_queue);
> +                       alias_print_queue, owner);
>      }
>  
>      QTAILQ_FOREACH_SAFE(ml, &submr_print_queue, mrqueue, next_ml) {
> @@ -2934,6 +2980,7 @@ struct FlatViewInfo {
>      void *f;
>      int counter;
>      bool dispatch_tree;
> +    bool owner;
>  };
>  
>  static void mtree_print_flatview(gpointer key, gpointer value,
> @@ -2974,7 +3021,7 @@ static void mtree_print_flatview(gpointer key, gpointer value,
>          mr = range->mr;
>          if (range->offset_in_region) {
>              p(f, MTREE_INDENT TARGET_FMT_plx "-"
> -              TARGET_FMT_plx " (prio %d, %s): %s @" TARGET_FMT_plx "\n",
> +              TARGET_FMT_plx " (prio %d, %s): %s @" TARGET_FMT_plx,
>                int128_get64(range->addr.start),
>                int128_get64(range->addr.start) + MR_SIZE(range->addr.size),
>                mr->priority,
> @@ -2983,13 +3030,17 @@ static void mtree_print_flatview(gpointer key, gpointer value,
>                range->offset_in_region);
>          } else {
>              p(f, MTREE_INDENT TARGET_FMT_plx "-"
> -              TARGET_FMT_plx " (prio %d, %s): %s\n",
> +              TARGET_FMT_plx " (prio %d, %s): %s",
>                int128_get64(range->addr.start),
>                int128_get64(range->addr.start) + MR_SIZE(range->addr.size),
>                mr->priority,
>                range->readonly ? "rom" : memory_region_type(mr),
>                memory_region_name(mr));
>          }
> +        if (fvi->owner) {
> +            mtree_print_mr_owner(p, f, mr);
> +        }
> +        p(f, "\n");
>          range++;
>      }
>  
> @@ -3015,7 +3066,7 @@ static gboolean mtree_info_flatview_free(gpointer key, gpointer value,
>  }
>  
>  void mtree_info(fprintf_function mon_printf, void *f, bool flatview,
> -                bool dispatch_tree)
> +                bool dispatch_tree, bool owner)
>  {
>      MemoryRegionListHead ml_head;
>      MemoryRegionList *ml, *ml2;
> @@ -3027,7 +3078,8 @@ void mtree_info(fprintf_function mon_printf, void *f, bool flatview,
>              .mon_printf = mon_printf,
>              .f = f,
>              .counter = 0,
> -            .dispatch_tree = dispatch_tree
> +            .dispatch_tree = dispatch_tree,
> +            .owner = owner,
>          };
>          GArray *fv_address_spaces;
>          GHashTable *views = g_hash_table_new(g_direct_hash, g_direct_equal);
> @@ -3059,14 +3111,14 @@ void mtree_info(fprintf_function mon_printf, void *f, bool flatview,
>  
>      QTAILQ_FOREACH(as, &address_spaces, address_spaces_link) {
>          mon_printf(f, "address-space: %s\n", as->name);
> -        mtree_print_mr(mon_printf, f, as->root, 1, 0, &ml_head);
> +        mtree_print_mr(mon_printf, f, as->root, 1, 0, &ml_head, owner);
>          mon_printf(f, "\n");
>      }
>  
>      /* print aliased regions */
>      QTAILQ_FOREACH(ml, &ml_head, mrqueue) {
>          mon_printf(f, "memory-region: %s\n", memory_region_name(ml->mr));
> -        mtree_print_mr(mon_printf, f, ml->mr, 1, 0, &ml_head);
> +        mtree_print_mr(mon_printf, f, ml->mr, 1, 0, &ml_head, owner);
>          mon_printf(f, "\n");
>      }
>  
> diff --git a/monitor.c b/monitor.c
> index 922cfc0..33a6f7d 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -1965,8 +1965,10 @@ static void hmp_info_mtree(Monitor *mon, const QDict *qdict)
>  {
>      bool flatview = qdict_get_try_bool(qdict, "flatview", false);
>      bool dispatch_tree = qdict_get_try_bool(qdict, "dispatch_tree", false);
> +    bool owner = qdict_get_try_bool(qdict, "owner", false);
>  
> -    mtree_info((fprintf_function)monitor_printf, mon, flatview, dispatch_tree);
> +    mtree_info((fprintf_function)monitor_printf, mon, flatview, dispatch_tree,
> +               owner);
>  }
>  
>  static void hmp_info_numa(Monitor *mon, const QDict *qdict)
> diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
> index ddfcd5a..5956495 100644
> --- a/hmp-commands-info.hx
> +++ b/hmp-commands-info.hx
> @@ -250,10 +250,11 @@ ETEXI
>  
>      {
>          .name       = "mtree",
> -        .args_type  = "flatview:-f,dispatch_tree:-d",
> -        .params     = "[-f][-d]",
> +        .args_type  = "flatview:-f,dispatch_tree:-d,owner:-o",
> +        .params     = "[-f][-d][-o]",
>          .help       = "show memory tree (-f: dump flat view for address spaces;"
> -                      "-d: dump dispatch tree, valid with -f only)",
> +                      "-d: dump dispatch tree, valid with -f only);"
> +                      "-o: dump region owners/parents",
>          .cmd        = hmp_info_mtree,
>      },
>  
> 
