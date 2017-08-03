Received: from eggs.gnu.org ([2001:4830:134:3::10]:55998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ddGjY-0001Fd-6E
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 10:04:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ddGjT-0004WN-CP
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 10:04:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48724)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ddGjT-0004V1-2g
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 10:04:11 -0400
Date: Thu, 3 Aug 2017 15:03:57 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170803140356.GC3673@work-vm>
References: <1501229198-30588-1-git-send-email-peterx@redhat.com>
	<1501229198-30588-13-git-send-email-peterx@redhat.com>
	<20170801094715.GE2079@work-vm>
	<20170802050610.GD15080@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170802050610.GD15080@pxdev.xzpeter.org>
Subject: Re: [Qemu-devel] [RFC 12/29] migration: allow dst vm pause on
 postcopy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>

* Peter Xu (peterx@redhat.com) wrote:
> On Tue, Aug 01, 2017 at 10:47:16AM +0100, Dr. David Alan Gilbert wrote:
> > * Peter Xu (peterx@redhat.com) wrote:
> 
> [...]
> 
> > > +/* Return true if we should continue the migration, or false. */
> > > +static bool postcopy_pause_incoming(MigrationIncomingState *mis)
> > > +{
> > > +    trace_postcopy_pause_incoming();
> > > +
> > > +    migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
> > > +                      MIGRATION_STATUS_POSTCOPY_PAUSED);
> > > +
> > > +    assert(mis->from_src_file);
> > > +    qemu_file_shutdown(mis->from_src_file);
> > > +    qemu_fclose(mis->from_src_file);
> > > +    mis->from_src_file = NULL;
> > > +
> > > +    assert(mis->to_src_file);
> > > +    qemu_mutex_lock(&mis->rp_mutex);
> > > +    qemu_file_shutdown(mis->to_src_file);
> > > +    qemu_fclose(mis->to_src_file);
> > > +    mis->to_src_file = NULL;
> > > +    qemu_mutex_unlock(&mis->rp_mutex);
> > 
> > Hmm is that safe?  If we look at migrate_send_rp_message we have:
> > 
> >     static void migrate_send_rp_message(MigrationIncomingState *mis,
> >                                         enum mig_rp_message_type message_type,
> >                                         uint16_t len, void *data)
> >     {
> >         trace_migrate_send_rp_message((int)message_type, len);
> >         qemu_mutex_lock(&mis->rp_mutex);
> >         qemu_put_be16(mis->to_src_file, (unsigned int)message_type);
> >         qemu_put_be16(mis->to_src_file, len);
> >         qemu_put_buffer(mis->to_src_file, data, len);
> >         qemu_fflush(mis->to_src_file);
> >         qemu_mutex_unlock(&mis->rp_mutex);
> >     }
> > 
> > If we came into postcopy_pause_incoming at about the same time
> > migrate_send_rp_message was being called and pause_incoming took the
> > lock first, then once it release the lock, send_rp_message carries on
> > and uses mis->to_src_file that's now NULL.
> > 
> > One solution here is to just call qemu_file_shutdown() but leave the
> > files open at this point, but clean the files up sometime later.
> 
> I see the commnent on patch 14 as well - yeah, we need patch 14 to
> co-op here, and as long as we are with patch 14, we should be ok.
> 
> > 
> > > +
> > > +    while (mis->state == MIGRATION_STATUS_POSTCOPY_PAUSED) {
> > > +        qemu_sem_wait(&mis->postcopy_pause_sem_dst);
> > > +    }
> > > +
> > > +    trace_postcopy_pause_incoming_continued();
> > > +
> > > +    return true;
> > > +}
> > > +
> > >  static int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis)
> > >  {
> > >      uint8_t section_type;
> > >      int ret = 0;
> > >  
> > > +retry:
> > >      while (true) {
> > >          section_type = qemu_get_byte(f);
> > >  
> > > @@ -2004,6 +2034,21 @@ static int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis)
> > >  out:
> > >      if (ret < 0) {
> > >          qemu_file_set_error(f, ret);
> > > +
> > > +        /*
> > > +         * Detect whether it is:
> > > +         *
> > > +         * 1. postcopy running
> > > +         * 2. network failure (-EIO)
> > > +         *
> > > +         * If so, we try to wait for a recovery.
> > > +         */
> > > +        if (mis->state == MIGRATION_STATUS_POSTCOPY_ACTIVE &&
> > > +            ret == -EIO && postcopy_pause_incoming(mis)) {
> > > +            /* Reset f to point to the newly created channel */
> > > +            f = mis->from_src_file;
> > > +            goto retry;
> > > +        }
> > 
> > I wonder if:
> > 
> >            if (mis->state == MIGRATION_STATUS_POSTCOPY_ACTIVE &&
> >                ret == -EIO && postcopy_pause_incoming(mis)) {
> >                /* Try again after postcopy recovery */
> >                return qemu_loadvm_state_main(mis->from_src_file, mis);
> >            }
> > would be nicer; it avoids the goto loop.
> 
> I agree we should avoid using goto loops. However I do see vast usages
> of goto like this one when we want to redo part of the procedures of a
> function (or, of course, when handling errors in "C-style").

We mostly use them to jump forward to an error exit; only rarely do
we do loops with them;  so if we can sensibly avoid them it's best.

> Calling qemu_loadvm_state_main() inside itself is ok as well, but it
> also has defect: stack usage would be out of control, or even, it can
> be controled by malicious users. E.g., if someone used program to
> periodically stop/start any network endpoint along the migration
> network, QEMU may go into a paused -> recovery -> active -> paused ...
> loop, and stack usage will just grow with time. I'd say it's an
> extreme example though...

I think it's safe because it's a tail-call so a new stack frame isn't
needed.

> (Another way besides above two: maybe we can just return in
>  qemu_loadvm_state_main with something like -EAGAIN, then the caller
>  of qemu_loadvm_state_main can re-call it when necessary, though I
>  would prefer "goto is okay here"... :)

Dave

> -- 
> Peter Xu
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
