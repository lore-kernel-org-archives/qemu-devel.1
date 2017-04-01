Received: from eggs.gnu.org ([2001:4830:134:3::10]:48655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cuDHU-0002Qe-31
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 03:17:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cuDHQ-0006d2-Vj
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 03:17:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37236)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cuDHQ-0006cL-NC
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 03:17:00 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BEECBC057EC9
	for <qemu-devel@nongnu.org>; Sat,  1 Apr 2017 07:16:59 +0000 (UTC)
Date: Sat, 1 Apr 2017 15:16:54 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170401071654.GN3981@pxdev.xzpeter.org>
References: <1490599288-11751-1-git-send-email-peterx@redhat.com>
	<1490599288-11751-3-git-send-email-peterx@redhat.com>
	<20170331185918.GF2408@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170331185918.GF2408@work-vm>
Subject: Re: [Qemu-devel] [PATCH 2/5] migration: rename max_size to
 threshold_size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>

On Fri, Mar 31, 2017 at 07:59:19PM +0100, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > In migration codes (especially in migration_thread()), max_size is used
> > in many place for the threshold value that we will start to do the final
> > flush and jump to the next stage to dump the whole rest things to
> > destination. However its name is confusing to first readers. Let's
> > rename it to "threshold_size" when proper and add a comment for it. No
> > functional change is made.
> > 
> > CC: Juan Quintela <quintela@redhat.com>
> > CC: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  include/migration/vmstate.h |  3 ++-
> >  migration/migration.c       | 17 +++++++++--------
> >  migration/savevm.c          |  4 ++--
> >  3 files changed, 13 insertions(+), 11 deletions(-)
> > 
> > diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> > index f2dbf84..dad3984 100644
> > --- a/include/migration/vmstate.h
> > +++ b/include/migration/vmstate.h
> > @@ -56,7 +56,8 @@ typedef struct SaveVMHandlers {
> >  
> >      /* This runs outside the iothread lock!  */
> >      int (*save_live_setup)(QEMUFile *f, void *opaque);
> > -    void (*save_live_pending)(QEMUFile *f, void *opaque, uint64_t max_size,
> > +    void (*save_live_pending)(QEMUFile *f, void *opaque,
> > +                              uint64_t threshold_size,
> >                                uint64_t *non_postcopiable_pending,
> >                                uint64_t *postcopiable_pending);
> >      LoadStateHandler *load_state;
> > diff --git a/migration/migration.c b/migration/migration.c
> > index f9f4d98..b065fe4 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -1907,7 +1907,8 @@ static void *migration_thread(void *opaque)
> >      int64_t initial_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> >      int64_t setup_start = qemu_clock_get_ms(QEMU_CLOCK_HOST);
> >      int64_t initial_bytes = 0;
> > -    int64_t max_size = 0;
> > +    /* We'll do the final flush when reachs threshold_size */
> 
> I think that's 'reaches' - however perhaps we should make a more
> explicit comment:
>    'The final stage happens when the remaining data is smaller than
>     this threshold; it's calculated from the requested downtime
>     and measured bandwidth'

Yes it looks better. Will "steal" that. :)

> 
> other than that:
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Thanks!

-- peterx
