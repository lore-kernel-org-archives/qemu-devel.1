Received: from eggs.gnu.org ([2001:4830:134:3::10]:56329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dDRA3-0003BM-62
	for qemu-devel@nongnu.org; Wed, 24 May 2017 03:56:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dDR9y-0000Gz-A3
	for qemu-devel@nongnu.org; Wed, 24 May 2017 03:56:51 -0400
Received: from mailout3.w1.samsung.com ([210.118.77.13]:63883)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1dDR9y-0000GV-05
	for qemu-devel@nongnu.org; Wed, 24 May 2017 03:56:46 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout3.w1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0OQG00D1E62HW600@mailout3.w1.samsung.com> for
	qemu-devel@nongnu.org; Wed, 24 May 2017 08:56:41 +0100 (BST)
Date: Wed, 24 May 2017 10:56:37 +0300
From: Alexey <a.perevalov@samsung.com>
Message-id: <20170524075637.GB12925@aperevalov-ubuntu>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-disposition: inline
In-reply-to: <20170524065736.GF3873@pxdev.xzpeter.org>
References: <1495539071-12995-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170523113130eucas1p1babac9d8659c10abe22ddc7d5b9526ab@eucas1p1.samsung.com>
	<1495539071-12995-8-git-send-email-a.perevalov@samsung.com>
	<20170524065736.GF3873@pxdev.xzpeter.org>
Subject: Re: [Qemu-devel] [PATCH V6 07/10] migration: add bitmap for copied
 page
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: i.maximets@samsung.com, qemu-devel@nongnu.org, dgilbert@redhat.com

On Wed, May 24, 2017 at 02:57:36PM +0800, Peter Xu wrote:
> On Tue, May 23, 2017 at 02:31:08PM +0300, Alexey Perevalov wrote:
> > This patch adds ability to track down already copied
> > pages, it's necessary for calculation vCPU block time in
> > postcopy migration feature and maybe for restore after
> > postcopy migration failure.
> > 
> > Functions which work with RAMBlock are placed into ram.c,
> > due to TARGET_WORDS_BIGENDIAN is poisoned int postcopy-ram.c -
> > hardware independed code.
> > 
> > Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
> > ---
> >  include/migration/migration.h | 16 +++++++++++
> >  migration/postcopy-ram.c      | 22 ++++++++++++---
> >  migration/ram.c               | 63 +++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 97 insertions(+), 4 deletions(-)
> > 
> > diff --git a/include/migration/migration.h b/include/migration/migration.h
> > index 449cb07..4e05c83 100644
> > --- a/include/migration/migration.h
> > +++ b/include/migration/migration.h
> > @@ -101,6 +101,20 @@ struct MigrationIncomingState {
> >      LoadStateEntry_Head loadvm_handlers;
> >  
> >      /*
> > +     * bitmap indicates whether page copied,
> > +     * based on ramblock offset
> > +     * now it is using only for blocktime calculation in
> > +     * postcopy migration, so livetime of this entry:
> > +     * since user requested blocktime calculation,
> > +     * till the end of postcopy migration
> > +     * as an example it could represend following memory map
> > +     * ___________________________________
> > +     * |4k pages | hugepages | 4k pages
> 
> Can we really do this?

> 
> The problem is AFAIU migration stream is sending pages only in target
> page size, even for huge pages... so even for huge pages we should
> still need per TARGET_PAGE_SIZE bitmap?
sending maybe, but copying to userfault fd is doing in hugepage size
in case of hugetlbfs memory backend.
> 
> (Please refer to ram_state_init() on init of RAMBlock.bmap)
I thought to use bitmap per ramblock, but I decided to not do it,
because of following reasons:
	1. There is only 4k ramblocks, for such ramblock it's not
	optimal
	2. copied pages bitmap - it's attribute of incoming migration,
	but ramblock it's general structure, although bmap it's about
	dirty pages of precopy migrations, hmm, but RAMBlock also
	contains unsentmap and it's for postcopy.
> 
> > +     *
> > +     * */
> > +    unsigned long *copied_pages;
> > +
> > +    /*
> >       * PostcopyBlocktimeContext to keep information for postcopy
> >       * live migration, to calculate vCPU block time
> >       * */
> > @@ -279,6 +293,8 @@ int migrate_compress_threads(void);
> >  int migrate_decompress_threads(void);
> >  bool migrate_use_events(void);
> >  bool migrate_postcopy_blocktime(void);
> > +unsigned long int get_copied_bit_offset(ram_addr_t addr);
> > +unsigned long int *copied_pages_bitmap_new(void);
> >  
> >  /* Sending on the return path - generic and then for each message type */
> >  void migrate_send_rp_message(MigrationIncomingState *mis,
> > diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> > index 5435a40..d647769 100644
> > --- a/migration/postcopy-ram.c
> > +++ b/migration/postcopy-ram.c
> > @@ -94,23 +94,34 @@ static void destroy_blocktime_context(struct PostcopyBlocktimeContext *ctx)
> >  
> >  static void postcopy_migration_cb(Notifier *n, void *data)
> >  {
> > -    PostcopyBlocktimeContext *ctx = container_of(n, PostcopyBlocktimeContext,
> > -                                               postcopy_notifier);
> >      MigrationState *s = data;
> >      if (migration_has_finished(s) || migration_has_failed(s)) {
> > +        MigrationIncomingState *mis = migration_incoming_get_current();
> > +        PostcopyBlocktimeContext *ctx = mis->blocktime_ctx;
> > +
> > +        if (!ctx) {
> > +            return;
> > +        }
> 
> If we are in postcopy_migration_cb() already, then we have registered
> the notifiers, then... could this (!ctx) really happen?
> 
ok, maybe it's unnecessary sanity check.

> > +
> >          g_free(ctx->page_fault_vcpu_time);
> >          /* g_free is NULL robust */
> >          ctx->page_fault_vcpu_time = NULL;
> >          g_free(ctx->vcpu_addr);
> >          ctx->vcpu_addr = NULL;
> > +        g_free(mis->copied_pages);
> > +        mis->copied_pages = NULL;
> >      }
> >  }
> >  
> >  static void migration_exit_cb(Notifier *n, void *data)
> >  {
> > -    PostcopyBlocktimeContext *ctx = container_of(n, PostcopyBlocktimeContext,
> > -                                               exit_notifier);
> > +    MigrationIncomingState *mis = migration_incoming_get_current();
> > +    PostcopyBlocktimeContext *ctx = mis->blocktime_ctx;
> > +    if (!ctx) {
> > +        return;
> > +    }
> 
> I failed to find out why touched this up...
> 
> Thanks,
> 
> >      destroy_blocktime_context(ctx);
> > +    mis->blocktime_ctx = NULL;
> >  }
> >  
> >  static struct PostcopyBlocktimeContext *blocktime_context_new(void)
> > @@ -227,6 +238,9 @@ static bool ufd_check_and_apply(int ufd, MigrationIncomingState *mis)
> >              mis->blocktime_ctx = blocktime_context_new();
> >          }
> >  
> > +        if (!mis->copied_pages) {
> > +            mis->copied_pages = copied_pages_bitmap_new();
> > +        }
> >          asked_features |= UFFD_FEATURE_THREAD_ID;
> >      }
> >  #endif
> > diff --git a/migration/ram.c b/migration/ram.c
> > index f59fdd4..1abb6bb 100644
> > --- a/migration/ram.c
> > +++ b/migration/ram.c
> > @@ -2661,6 +2661,69 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
> >      return ret;
> >  }
> >  
> > +static unsigned long get_total_bits_per_page(ram_addr_t mem_length,
> > +        size_t page_size)
> > +{
> > +    unsigned long page_size_bit = find_last_bit((unsigned long *)&page_size,
> > +            BITS_PER_LONG);
> > +    unsigned long total_bits = mem_length >> page_size_bit;
> > +    if (mem_length % page_size) {
> > +        total_bits += 1;
> > +    }
> > +    return total_bits;
> > +}
> > +
> > +/*
> > + * this function allocates bitmap for copied pages,
> > + * also it calculates
> > + * how many entries do we need
> > + * */
> > +unsigned long int *copied_pages_bitmap_new(void)
> > +{
> > +    RAMBlock *block;
> > +    unsigned long int total_bits = 0;
> > +
> > +    rcu_read_lock();
> > +    RAMBLOCK_FOREACH(block) {
> > +        /* in general case used_length may not be aligned
> > +         * by page_size */
> > +
> > +        total_bits += get_total_bits_per_page(block->used_length,
> > +                block->page_size);
> > +    }
> > +    rcu_read_unlock();
> > +
> > +    return bitmap_new(total_bits);
> > +}
> > +
> > +unsigned long int get_copied_bit_offset(ram_addr_t addr)
> > +{
> > +    RAMBlock *block;
> > +    unsigned long int iter_bit = 0;
> > +
> > +    rcu_read_lock();
> > +    RAMBLOCK_FOREACH(block) {
> > +        /* in general case used_length may not be aligned
> > +         * by page_size */
> > +        if (block->host == NULL) {
> > +            continue;
> > +        }
> > +        if (addr - (ram_addr_t)block->host < block->max_length) {
> > +            unsigned long page_size_bit = find_last_bit(
> > +                    (unsigned long *)&block->page_size,
> > +                    BITS_PER_LONG);
> > +            ram_addr_t offset = addr - (ram_addr_t)block->host;
> > +            iter_bit += offset >> page_size_bit;
> > +            break;
> > +        }
> > +        iter_bit += get_total_bits_per_page(block->used_length,
> > +                block->page_size);
> > +    }
> > +    rcu_read_unlock();
> > +
> > +    return iter_bit;
> > +}
> > +
> >  static SaveVMHandlers savevm_ram_handlers = {
> >      .save_live_setup = ram_save_setup,
> >      .save_live_iterate = ram_save_iterate,
> > -- 
> > 1.8.3.1
> > 
> 
> -- 
> Peter Xu
> 

-- 

BR
Alexey
