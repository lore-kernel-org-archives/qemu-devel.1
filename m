Received: from eggs.gnu.org ([2001:4830:134:3::10]:59499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cTZLb-0001kh-4o
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 14:23:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cTZLY-0005Hb-0F
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 14:23:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59264)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cTZLX-0005Gz-OA
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 14:23:07 -0500
Date: Tue, 17 Jan 2017 19:23:02 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170117192302.GA12015@work-vm>
References: <1484556005-29701-1-git-send-email-peterx@redhat.com>
	<1484556005-29701-2-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484556005-29701-2-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 1/2] memory: tune mtree_print_mr() to
 dump mr type
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
> We were dumping RW bits for each memory region, that might be confusing.
> It'll make more sense to dump the memory region type directly rather
> than the RW bits since that's how the bits are derived.
> 
> Meanwhile, with some slight cleanup in the function.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  memory.c | 48 +++++++++++++++++++++++++++---------------------
>  1 file changed, 27 insertions(+), 21 deletions(-)
> 
> diff --git a/memory.c b/memory.c
> index 2bfc37f..c42bde4 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -2450,6 +2450,21 @@ void address_space_destroy(AddressSpace *as)
>      call_rcu(as, do_address_space_destroy, rcu);
>  }
>  
> +static const char *memory_region_type(MemoryRegion *mr)
> +{
> +    if (memory_region_is_ram_device(mr)) {
> +        return "ramd";
> +    } else if (memory_region_is_romd(mr)) {
> +        return "romd";
> +    } else if (memory_region_is_rom(mr)) {
> +        return "rom";
> +    } else if (memory_region_is_ram(mr)) {
> +        return "ram";
> +    } else {
> +        return "i/o";
> +    }
> +}
> +
>  typedef struct MemoryRegionList MemoryRegionList;
>  
>  struct MemoryRegionList {
> @@ -2459,6 +2474,10 @@ struct MemoryRegionList {
>  
>  typedef QTAILQ_HEAD(queue, MemoryRegionList) MemoryRegionListHead;
>  
> +#define MR_SIZE(size) (int128_nz(size) ? (hwaddr)int128_get64( \
> +                           int128_sub((size), int128_one())) : 0)
> +#define MTREE_INDENT "  "
> +
>  static void mtree_print_mr(fprintf_function mon_printf, void *f,
>                             const MemoryRegion *mr, unsigned int level,
>                             hwaddr base,
> @@ -2474,7 +2493,7 @@ static void mtree_print_mr(fprintf_function mon_printf, void *f,
>      }
>  
>      for (i = 0; i < level; i++) {
> -        mon_printf(f, "  ");
> +        mon_printf(f, MTREE_INDENT);
>      }
>  
>      if (mr->alias) {
> @@ -2494,37 +2513,24 @@ static void mtree_print_mr(fprintf_function mon_printf, void *f,
>              QTAILQ_INSERT_TAIL(alias_print_queue, ml, queue);
>          }
>          mon_printf(f, TARGET_FMT_plx "-" TARGET_FMT_plx
> -                   " (prio %d, %c%c): alias %s @%s " TARGET_FMT_plx
> +                   " (prio %d, %s): alias %s @%s " TARGET_FMT_plx
>                     "-" TARGET_FMT_plx "%s\n",
>                     base + mr->addr,
> -                   base + mr->addr
> -                   + (int128_nz(mr->size) ?
> -                      (hwaddr)int128_get64(int128_sub(mr->size,
> -                                                      int128_one())) : 0),
> +                   base + mr->addr + MR_SIZE(mr->size),
>                     mr->priority,
> -                   mr->romd_mode ? 'R' : '-',
> -                   !mr->readonly && !(mr->rom_device && mr->romd_mode) ? 'W'
> -                                                                       : '-',
> +                   memory_region_type((MemoryRegion *)mr),
>                     memory_region_name(mr),
>                     memory_region_name(mr->alias),
>                     mr->alias_offset,
> -                   mr->alias_offset
> -                   + (int128_nz(mr->size) ?
> -                      (hwaddr)int128_get64(int128_sub(mr->size,
> -                                                      int128_one())) : 0),
> +                   mr->alias_offset + MR_SIZE(mr->size),
>                     mr->enabled ? "" : " [disabled]");
>      } else {
>          mon_printf(f,
> -                   TARGET_FMT_plx "-" TARGET_FMT_plx " (prio %d, %c%c): %s%s\n",
> +                   TARGET_FMT_plx "-" TARGET_FMT_plx " (prio %d, %s): %s%s\n",
>                     base + mr->addr,
> -                   base + mr->addr
> -                   + (int128_nz(mr->size) ?
> -                      (hwaddr)int128_get64(int128_sub(mr->size,
> -                                                      int128_one())) : 0),
> +                   base + mr->addr + MR_SIZE(mr->size),
>                     mr->priority,
> -                   mr->romd_mode ? 'R' : '-',
> -                   !mr->readonly && !(mr->rom_device && mr->romd_mode) ? 'W'
> -                                                                       : '-',
> +                   memory_region_type((MemoryRegion *)mr),
>                     memory_region_name(mr),
>                     mr->enabled ? "" : " [disabled]");
>      }
> -- 
> 2.7.4
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
