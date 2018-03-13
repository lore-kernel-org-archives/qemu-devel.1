Received: from eggs.gnu.org ([2001:4830:134:3::10]:53388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1evmJB-0000dU-01
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 11:57:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1evmJ6-0001jl-4W
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 11:57:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35824 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1evmJ6-0001je-04
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 11:57:44 -0400
Date: Tue, 13 Mar 2018 23:57:38 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180313155738.GK11787@xz-mi>
References: <20180208103132.28452-1-peterx@redhat.com>
	<20180208103132.28452-28-peterx@redhat.com>
	<20180213201059.GU2378@work-vm> <20180214045639.GI4472@xz-mi>
	<20180214185658.GF2507@work-vm> <20180222074346.GG18962@xz-mi>
	<20180228201418.GQ2981@work-vm> <20180313091318.GI11787@xz-mi>
	<20180313123556.GF3545@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180313123556.GF3545@work-vm>
Subject: Re: [Qemu-devel] [PATCH v6 27/28] migration/qmp: add command
 migrate-pause
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Alexey Perevalov <a.perevalov@samsung.com>, "Daniel P . Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>

On Tue, Mar 13, 2018 at 12:35:56PM +0000, Dr. David Alan Gilbert wrote:

[...]

> > Yes I think if without OOB we should be fine since even the cleanup is
> > running with the BQL.
> > 
> > Now I don't have good idea to solve this problem except introducing a
> > lock.  How about I add a patch to introduce the mgmt_lock, which
> > currently only protect the QEMUFile?  Like:
> > 
> > ----------------------------------
> > diff --git a/migration/migration.c b/migration/migration.c
> > index f31fcbb0d5..00c630326d 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -1195,8 +1195,10 @@ static void migrate_fd_cleanup(void *opaque)
> >          if (multifd_save_cleanup(&local_err) != 0) {
> >              error_report_err(local_err);
> >          }
> > +        qemu_mutex_lock(&s->mgmt_lock);
> >          qemu_fclose(s->to_dst_file);
> >          s->to_dst_file = NULL;
> > +        qemu_mutex_unlock(&s->mgmt_lock);
> >      }
> > 
> >      assert((s->state != MIGRATION_STATUS_ACTIVE) &&
> > @@ -2493,8 +2495,10 @@ static MigThrError postcopy_pause(MigrationState *s)
> > 
> >          /* Current channel is possibly broken. Release it. */
> >          assert(s->to_dst_file);
> > +        qemu_mutex_lock(&s->mgmt_lock);
> >          qemu_file_shutdown(s->to_dst_file);
> >          qemu_fclose(s->to_dst_file);
> >          s->to_dst_file = NULL;
> > +        qemu_mutex_unlock(&s->mgmt_lock);
> 
> That's only safe if we know qemu_fclose() can never block; otherwise
> we're not allowed to take the same lock in the OOB command.
> 
> I think perhaps it's safer to always do something like:
>   tmp = atomic_xchg(s->to_dst_file, NULL);
>   qemu_file_shutdown(tmp);
>   qemu_fclose(tmp);
> 
> then the OOB code can do the same?
> Would that work - avoiding the lock?

According to what we discussed offlist: I'll still introduce that
lock, but instead I'll move the close() out of the lock section since
that can block.

I'll see whether I need a repost tomorrow, or after 2.12 release if
the series will never have a chance for 2.12.

Thanks,

-- 
Peter Xu
