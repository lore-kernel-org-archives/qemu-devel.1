Received: from eggs.gnu.org ([2001:4830:134:3::10]:49252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dn2tg-0006e4-Nj
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 09:19:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dn2ta-00015u-Ha
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 09:19:08 -0400
Date: Wed, 30 Aug 2017 21:18:47 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170830131847.GP4208@lemon.lan>
References: <20170830100605.22694-1-famz@redhat.com>
	<87mv6h5l87.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mv6h5l87.fsf@secure.mitica>
Subject: Re: [Qemu-devel] [PATCH] block: Cleanup BMDS in bdrv_close_all
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-stable@nongnu.org, qemu-devel@nongnu.org, peterx@redhat.com, Max Reitz <mreitz@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On Wed, 08/30 13:49, Juan Quintela wrote:
> Fam Zheng <famz@redhat.com> wrote:
> > This fixes the assertion due to op blockers added by BMDS:
> >
> > block.c:3248: bdrv_delete: Assertion `bdrv_op_blocker_is_empty(bs)' failed.
> >
> > Reproducer: simply start block migration and quit QEMU before it ends.
> >
> > Cc: qemu-stable@nongnu.org
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> 
> No need for one stub, see later.
> 
> 
> > ---
> >  block.c                 | 2 ++
> >  migration/block.c       | 2 +-
> >  migration/block.h       | 1 +
> >  stubs/Makefile.objs     | 1 +
> >  stubs/block-migration.c | 6 ++++++
> >  5 files changed, 11 insertions(+), 1 deletion(-)
> >  create mode 100644 stubs/block-migration.c
> >
> > diff --git a/block.c b/block.c
> > index 3308814bba..508a57274d 100644
> > --- a/block.c
> > +++ b/block.c
> > @@ -43,6 +43,7 @@
> >  #include "qemu/cutils.h"
> >  #include "qemu/id.h"
> >  #include "qapi/util.h"
> > +#include "migration/block.h"
> 
> this should be misc.h
> 
> >  
> >  #ifdef CONFIG_BSD
> >  #include <sys/ioctl.h>
> > @@ -3111,6 +3112,7 @@ static void bdrv_close(BlockDriverState *bs)
> >  
> >  void bdrv_close_all(void)
> >  {
> > +    block_migration_cleanup_bmds();
> >      block_job_cancel_sync_all();
> >      nbd_export_close_all();
> >  
> 
> > diff --git a/migration/block.h b/migration/block.h
> > index 22ebe94259..8bae1cf55a 100644
> > --- a/migration/block.h
> > +++ b/migration/block.h
> > @@ -42,4 +42,5 @@ static inline uint64_t blk_mig_bytes_total(void)
> >  #endif /* CONFIG_LIVE_BLOCK_MIGRATION */
> >  
> >  void migrate_set_block_enabled(bool value, Error **errp);
> > +void block_migration_cleanup_bmds(void);
> >  #endif /* MIGRATION_BLOCK_H */
> > diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
> > index e69c217aff..7540913767 100644
> > --- a/stubs/Makefile.objs
> > +++ b/stubs/Makefile.objs
> > @@ -19,6 +19,7 @@ stub-obj-y += is-daemonized.o
> >  stub-obj-$(CONFIG_LINUX_AIO) += linux-aio.o
> >  stub-obj-y += machine-init-done.o
> >  stub-obj-y += migr-blocker.o
> > +stub-obj-y += block-migration.o
> >  stub-obj-y += change-state-handler.o
> >  stub-obj-y += monitor.o
> >  stub-obj-y += notify-event.o
> > diff --git a/stubs/block-migration.c b/stubs/block-migration.c
> > new file mode 100644
> > index 0000000000..855f15c757
> > --- /dev/null
> > +++ b/stubs/block-migration.c
> > @@ -0,0 +1,6 @@
> > +#include "qemu/osdep.h"
> > +#include "migration/block.h"
> > +
> > +void block_migration_cleanup_bmds(void)
> > +{
> > +}
> 
> You can add this inside include/migration/misc.h
> 
> #ifdef CONFIG_LIVE_BLOCK_MIGRATION
> void blk_mig_init(void);
> #else
> static inline void blk_mig_init(void) {}
> 
> // And then you add the stub here?

This doesn't work.  The function is not stubbed for !CONFIG_LIVE_BLOCK_MIGRATION
configs, but for tools that don't link to common-obj-y. For example with your
proposed change, I get:

  LINK    qemu-nbd
block.o: In function `bdrv_close_all':
/home/fam/work/qemu/block.c:3115: undefined reference to `block_migration_cleanup_bmds'
collect2: error: ld returned 1 exit status
make: *** [/home/fam/work/qemu/rules.mak:121: qemu-nbd] Error 1
make: Leaving directory '/home/fam/work/q/build'

> 
> #endif
> 
> 
> Once here, I would consider to give one error/warning if we quit qemu
> and we are in the middle of a block migration, no?

We already have various types of block jobs, such as mirror and backup, and even
non-block tasks like migration and dump that runs in the background. None gives
error/warning.  Keeping quiet here is consistent with other code.

Fam
