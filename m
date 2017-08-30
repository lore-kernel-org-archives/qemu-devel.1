Received: from eggs.gnu.org ([2001:4830:134:3::10]:36566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dn3bc-0004Hy-IB
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 10:04:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dn3bY-0000Vh-8s
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 10:04:32 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170830131847.GP4208@lemon.lan> (Fam Zheng's message of "Wed,
	30 Aug 2017 21:18:47 +0800")
References: <20170830100605.22694-1-famz@redhat.com>
	<87mv6h5l87.fsf@secure.mitica> <20170830131847.GP4208@lemon.lan>
Reply-To: quintela@redhat.com
Date: Wed, 30 Aug 2017 16:04:07 +0200
Message-ID: <87efrt5ezs.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] block: Cleanup BMDS in bdrv_close_all
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-stable@nongnu.org, qemu-devel@nongnu.org, peterx@redhat.com, Max Reitz <mreitz@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Fam Zheng <famz@redhat.com> wrote:
> On Wed, 08/30 13:49, Juan Quintela wrote:
>> Fam Zheng <famz@redhat.com> wrote:
>> > This fixes the assertion due to op blockers added by BMDS:
>> >
>> > block.c:3248: bdrv_delete: Assertion `bdrv_op_blocker_is_empty(bs)' failed.
>> >
>> > Reproducer: simply start block migration and quit QEMU before it ends.
>> >
>> > Cc: qemu-stable@nongnu.org
>> > Signed-off-by: Fam Zheng <famz@redhat.com>
>> 
>> No need for one stub, see later.
>> 
>> 
>> > ---
>> >  block.c                 | 2 ++
>> >  migration/block.c       | 2 +-
>> >  migration/block.h       | 1 +
>> >  stubs/Makefile.objs     | 1 +
>> >  stubs/block-migration.c | 6 ++++++
>> >  5 files changed, 11 insertions(+), 1 deletion(-)
>> >  create mode 100644 stubs/block-migration.c
>> >
>> > diff --git a/block.c b/block.c
>> > index 3308814bba..508a57274d 100644
>> > --- a/block.c
>> > +++ b/block.c
>> > @@ -43,6 +43,7 @@
>> >  #include "qemu/cutils.h"
>> >  #include "qemu/id.h"
>> >  #include "qapi/util.h"
>> > +#include "migration/block.h"
>> 
>> this should be misc.h
>> 
>> >  
>> >  #ifdef CONFIG_BSD
>> >  #include <sys/ioctl.h>
>> > @@ -3111,6 +3112,7 @@ static void bdrv_close(BlockDriverState *bs)
>> >  
>> >  void bdrv_close_all(void)
>> >  {
>> > +    block_migration_cleanup_bmds();
>> >      block_job_cancel_sync_all();
>> >      nbd_export_close_all();
>> >  
>> 
>> > diff --git a/migration/block.h b/migration/block.h
>> > index 22ebe94259..8bae1cf55a 100644
>> > --- a/migration/block.h
>> > +++ b/migration/block.h
>> > @@ -42,4 +42,5 @@ static inline uint64_t blk_mig_bytes_total(void)
>> >  #endif /* CONFIG_LIVE_BLOCK_MIGRATION */
>> >  
>> >  void migrate_set_block_enabled(bool value, Error **errp);
>> > +void block_migration_cleanup_bmds(void);
>> >  #endif /* MIGRATION_BLOCK_H */
>> > diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
>> > index e69c217aff..7540913767 100644
>> > --- a/stubs/Makefile.objs
>> > +++ b/stubs/Makefile.objs
>> > @@ -19,6 +19,7 @@ stub-obj-y += is-daemonized.o
>> >  stub-obj-$(CONFIG_LINUX_AIO) += linux-aio.o
>> >  stub-obj-y += machine-init-done.o
>> >  stub-obj-y += migr-blocker.o
>> > +stub-obj-y += block-migration.o
>> >  stub-obj-y += change-state-handler.o
>> >  stub-obj-y += monitor.o
>> >  stub-obj-y += notify-event.o
>> > diff --git a/stubs/block-migration.c b/stubs/block-migration.c
>> > new file mode 100644
>> > index 0000000000..855f15c757
>> > --- /dev/null
>> > +++ b/stubs/block-migration.c
>> > @@ -0,0 +1,6 @@
>> > +#include "qemu/osdep.h"
>> > +#include "migration/block.h"
>> > +
>> > +void block_migration_cleanup_bmds(void)
>> > +{
>> > +}
>> 
>> You can add this inside include/migration/misc.h
>> 
>> #ifdef CONFIG_LIVE_BLOCK_MIGRATION
>> void blk_mig_init(void);
>> #else
>> static inline void blk_mig_init(void) {}
>> 
>> // And then you add the stub here?
>
> This doesn't work.  The function is not stubbed for !CONFIG_LIVE_BLOCK_MIGRATION
> configs, but for tools that don't link to common-obj-y. For example with your
> proposed change, I get:
>
>   LINK    qemu-nbd
> block.o: In function `bdrv_close_all':
> /home/fam/work/qemu/block.c:3115: undefined reference to
> `block_migration_cleanup_bmds'
> collect2: error: ld returned 1 exit status
> make: *** [/home/fam/work/qemu/rules.mak:121: qemu-nbd] Error 1
> make: Leaving directory '/home/fam/work/q/build'


This works for me, for both CONFIG_LIVE_BLOCK_MIGRATION enabled and not.
For qemu-system-x86_64 and qemu-nbd.  Could you test?

gcommit 2888b96dfe5ea9c7901990f54e14b1a7ed3e46b9
Author: Fam Zheng <famz@redhat.com>
Date:   Wed Aug 30 18:06:05 2017 +0800

    block: Cleanup BMDS in bdrv_close_all
    
    This fixes the assertion due to op blockers added by BMDS:
    
    block.c:3248: bdrv_delete: Assertion `bdrv_op_blocker_is_empty(bs)' failed.
    
    Reproducer: simply start block migration and quit QEMU before it ends.
    
    Cc: qemu-stable@nongnu.org
    Signed-off-by: Fam Zheng <famz@redhat.com>
    
    --
    
    Don't use stub

diff --git a/block.c b/block.c
index 3615a6809e..4268f892da 100644
--- a/block.c
+++ b/block.c
@@ -43,6 +43,7 @@
 #include "qemu/cutils.h"
 #include "qemu/id.h"
 #include "qapi/util.h"
+#include "migration/misc.h"
 
 #ifdef CONFIG_BSD
 #include <sys/ioctl.h>
@@ -3111,6 +3112,7 @@ static void bdrv_close(BlockDriverState *bs)
 
 void bdrv_close_all(void)
 {
+    block_migration_cleanup_bmds();
     block_job_cancel_sync_all();
     nbd_export_close_all();
 
diff --git a/include/migration/misc.h b/include/migration/misc.h
index c079b7771b..6ecb7068d9 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -24,8 +24,10 @@ void ram_mig_init(void);
 
 #ifdef CONFIG_LIVE_BLOCK_MIGRATION
 void blk_mig_init(void);
+void block_migration_cleanup_bmds(void);
 #else
 static inline void blk_mig_init(void) {}
+static inline void block_migration_cleanup_bmds(void) {}
 #endif
 
 #define SELF_ANNOUNCE_ROUNDS 5
diff --git a/migration/block.c b/migration/block.c
index 9171f60028..c059e48484 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -673,7 +673,7 @@ static int64_t get_remaining_dirty(void)
 
 
 /* Called with iothread lock taken.  */
-static void block_migration_cleanup_bmds(void)
+void block_migration_cleanup_bmds(void)
 {
     BlkMigDevState *bmds;
     AioContext *ctx;
