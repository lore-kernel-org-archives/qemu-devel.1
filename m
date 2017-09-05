Received: from eggs.gnu.org ([2001:4830:134:3::10]:33563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dp9pT-00086W-GY
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:07:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dp9pJ-0007le-Uk
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:07:31 -0400
Date: Tue, 5 Sep 2017 11:06:55 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170905090655.GC4633@localhost.localdomain>
References: <20170830100605.22694-1-famz@redhat.com>
	<20170905084431.GA4633@localhost.localdomain>
	<20170905085441.GU22515@lemon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170905085441.GU22515@lemon.lan>
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
Cc: qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, qemu-stable@nongnu.org, peterx@redhat.com, Max Reitz <mreitz@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Am 05.09.2017 um 10:54 hat Fam Zheng geschrieben:
> On Tue, 09/05 10:44, Kevin Wolf wrote:
> > Am 30.08.2017 um 12:06 hat Fam Zheng geschrieben:
> > > This fixes the assertion due to op blockers added by BMDS:
> > > 
> > > block.c:3248: bdrv_delete: Assertion `bdrv_op_blocker_is_empty(bs)' failed.
> > > 
> > > Reproducer: simply start block migration and quit QEMU before it ends.
> > > 
> > > Cc: qemu-stable@nongnu.org
> > > Signed-off-by: Fam Zheng <famz@redhat.com>
> > > ---
> > >  block.c                 | 2 ++
> > >  migration/block.c       | 2 +-
> > >  migration/block.h       | 1 +
> > >  stubs/Makefile.objs     | 1 +
> > >  stubs/block-migration.c | 6 ++++++
> > >  5 files changed, 11 insertions(+), 1 deletion(-)
> > >  create mode 100644 stubs/block-migration.c
> > > 
> > > diff --git a/block.c b/block.c
> > > index 3308814bba..508a57274d 100644
> > > --- a/block.c
> > > +++ b/block.c
> > > @@ -43,6 +43,7 @@
> > >  #include "qemu/cutils.h"
> > >  #include "qemu/id.h"
> > >  #include "qapi/util.h"
> > > +#include "migration/block.h"
> > >  
> > >  #ifdef CONFIG_BSD
> > >  #include <sys/ioctl.h>
> > > @@ -3111,6 +3112,7 @@ static void bdrv_close(BlockDriverState *bs)
> > >  
> > >  void bdrv_close_all(void)
> > >  {
> > > +    block_migration_cleanup_bmds();
> > >      block_job_cancel_sync_all();
> > >      nbd_export_close_all();
> > 
> > This is before bdrv_drain_all(). Can't we still have a block migration
> > request in flight, whose callback will then dereference a stale pointer?
> 
> You're right, bdrv_drain_all should be called first.

Actually, looking a bit closer, what prevents the migration thread from
starting new requests even after bdrv_drain_all()? Maybe what we really
need to do is cancelling the migration before calling bdrv_close_all().

Kevin
