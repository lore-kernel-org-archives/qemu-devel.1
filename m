Received: from eggs.gnu.org ([2001:4830:134:3::10]:38616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dI8oO-0008LS-Nx
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 03:21:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dI8oJ-000580-HO
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 03:21:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35326)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dI8oJ-00057s-8h
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 03:21:51 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DE1F161B8A
	for <qemu-devel@nongnu.org>; Tue,  6 Jun 2017 07:21:49 +0000 (UTC)
Date: Tue, 6 Jun 2017 15:21:43 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170606072143.GA27621@pxdev.xzpeter.org>
References: <20170601214056.30387-1-quintela@redhat.com>
	<20170601214056.30387-4-quintela@redhat.com>
	<20170602175529.GE2081@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170602175529.GE2081@work-vm>
Subject: Re: [Qemu-devel] [PATCH 3/4] ram: Print block stats also in the
 complete case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, lvivier@redhat.com

On Fri, Jun 02, 2017 at 06:55:30PM +0100, Dr. David Alan Gilbert wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
> > To make things easier, I just moved it to populate_ram_info().
> 
> Blk is not RAM; better to create a separate function.

Agree...

Maybe rename populate_ram_info() into more general name?
migrate_info_populate()?

(Also, I think auto convergence is not RAM-related as well, so same
 comment may apply to patch 2)

Thanks,

> 
> Dave
> 
> > Signed-off-by: Juan Quintela <quintela@redhat.com>
> > ---
> >  migration/migration.c | 26 ++++++++------------------
> >  1 file changed, 8 insertions(+), 18 deletions(-)
> > 
> > diff --git a/migration/migration.c b/migration/migration.c
> > index 7f79da0..8289544 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -509,6 +509,14 @@ static void populate_ram_info(MigrationInfo *info, MigrationState *s)
> >          info->cpu_throttle_percentage = cpu_throttle_get_percentage();
> >      }
> >  
> > +    if (blk_mig_active()) {
> > +        info->has_disk = true;
> > +        info->disk = g_malloc0(sizeof(*info->disk));
> > +        info->disk->transferred = blk_mig_bytes_transferred();
> > +        info->disk->remaining = blk_mig_bytes_remaining();
> > +        info->disk->total = blk_mig_bytes_total();
> > +    }
> > +
> >      if (s->state != MIGRATION_STATUS_COMPLETED) {
> >          info->ram->remaining = ram_bytes_remaining();
> >          info->ram->dirty_pages_rate = ram_dirty_pages_rate();
> > @@ -540,15 +548,6 @@ MigrationInfo *qmp_query_migrate(Error **errp)
> >          info->setup_time = s->setup_time;
> >  
> >          populate_ram_info(info, s);
> > -
> > -        if (blk_mig_active()) {
> > -            info->has_disk = true;
> > -            info->disk = g_malloc0(sizeof(*info->disk));
> > -            info->disk->transferred = blk_mig_bytes_transferred();
> > -            info->disk->remaining = blk_mig_bytes_remaining();
> > -            info->disk->total = blk_mig_bytes_total();
> > -        }
> > -
> >          break;
> >      case MIGRATION_STATUS_POSTCOPY_ACTIVE:
> >          /* Mostly the same as active; TODO add some postcopy stats */
> > @@ -562,15 +561,6 @@ MigrationInfo *qmp_query_migrate(Error **errp)
> >          info->setup_time = s->setup_time;
> >  
> >          populate_ram_info(info, s);
> > -
> > -        if (blk_mig_active()) {
> > -            info->has_disk = true;
> > -            info->disk = g_malloc0(sizeof(*info->disk));
> > -            info->disk->transferred = blk_mig_bytes_transferred();
> > -            info->disk->remaining = blk_mig_bytes_remaining();
> > -            info->disk->total = blk_mig_bytes_total();
> > -        }
> > -
> >          break;
> >      case MIGRATION_STATUS_COLO:
> >          info->has_status = true;
> > -- 
> > 2.9.4
> > 
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

-- 
Peter Xu
