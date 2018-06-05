Received: from eggs.gnu.org ([2001:4830:134:3::10]:34928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fQ6hW-0002uk-IO
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 03:48:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fQ6hT-00085Q-G1
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 03:48:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37658 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fQ6hT-00085G-81
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 03:48:15 -0400
Date: Tue, 5 Jun 2018 15:48:09 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180605074809.GE9216@xz-mi>
References: <20180515234017.2277-1-quintela@redhat.com>
	<20180515234017.2277-17-quintela@redhat.com>
	<CAFEAcA_cpAT27=DQj6qyvoP8u=zUgzG2vidcgN=vP1KLDn8LMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA_cpAT27=DQj6qyvoP8u=zUgzG2vidcgN=vP1KLDn8LMA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 16/40] migration: allow dst vm pause on
 postcopy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Juan Quintela <quintela@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On Mon, Jun 04, 2018 at 02:49:58PM +0100, Peter Maydell wrote:
> On 16 May 2018 at 00:39, Juan Quintela <quintela@redhat.com> wrote:
> > From: Peter Xu <peterx@redhat.com>
> >
> > When there is IO error on the incoming channel (e.g., network down),
> > instead of bailing out immediately, we allow the dst vm to switch to the
> > new POSTCOPY_PAUSE state. Currently it is still simple - it waits the
> > new semaphore, until someone poke it for another attempt.
> >
> > One note is that here on ram loading thread we cannot detect the
> > POSTCOPY_ACTIVE state, but we need to detect the more specific
> > POSTCOPY_INCOMING_RUNNING state, to make sure we have already loaded all
> > the device states.
> >
> > Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > Message-Id: <20180502104740.12123-5-peterx@redhat.com>
> > Signed-off-by: Juan Quintela <quintela@redhat.com>
> > ---
> 
> Hi; Coverity (CID 1391289) points out what it thinks is an issue in
> this commit. I think it's wrong, but it does leave me uncertain
> whether we have the locking correct here...

Hi, Peter,

Yeah actually this confused me a bit too when I wanted to fix this...

> 
> > +/* Return true if we should continue the migration, or false. */
> > +static bool postcopy_pause_incoming(MigrationIncomingState *mis)
> > +{
> > +    trace_postcopy_pause_incoming();
> > +
> > +    migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
> > +                      MIGRATION_STATUS_POSTCOPY_PAUSED);
> > +
> > +    assert(mis->from_src_file);
> > +    qemu_file_shutdown(mis->from_src_file);
> > +    qemu_fclose(mis->from_src_file);
> > +    mis->from_src_file = NULL;
> 
> In postcopy_pause_incoming() we always set mis->from_src_file to NULL...
> 
> > +
> > +    assert(mis->to_src_file);
> > +    qemu_file_shutdown(mis->to_src_file);
> > +    qemu_mutex_lock(&mis->rp_mutex);
> > +    qemu_fclose(mis->to_src_file);
> > +    mis->to_src_file = NULL;
> > +    qemu_mutex_unlock(&mis->rp_mutex);
> > +
> > +    error_report("Detected IO failure for postcopy. "
> > +                 "Migration paused.");
> > +
> > +    while (mis->state == MIGRATION_STATUS_POSTCOPY_PAUSED) {
> > +        qemu_sem_wait(&mis->postcopy_pause_sem_dst);
> > +    }
> > +
> > +    trace_postcopy_pause_incoming_continued();
> > +
> > +    return true;
> > +}
> > +
> >  static int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis)
> >  {
> >      uint8_t section_type;
> >      int ret = 0;
> >
> > +retry:
> >      while (true) {
> >          section_type = qemu_get_byte(f);
> >
> > @@ -2104,6 +2145,24 @@ static int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis)
> >  out:
> >      if (ret < 0) {
> >          qemu_file_set_error(f, ret);
> > +
> > +        /*
> > +         * Detect whether it is:
> > +         *
> > +         * 1. postcopy running (after receiving all device data, which
> > +         *    must be in POSTCOPY_INCOMING_RUNNING state.  Note that
> > +         *    POSTCOPY_INCOMING_LISTENING is still not enough, it's
> > +         *    still receiving device states).
> > +         * 2. network failure (-EIO)
> > +         *
> > +         * If so, we try to wait for a recovery.
> > +         */
> > +        if (postcopy_state_get() == POSTCOPY_INCOMING_RUNNING &&
> > +            ret == -EIO && postcopy_pause_incoming(mis)) {
> > +            /* Reset f to point to the newly created channel */
> > +            f = mis->from_src_file;
> 
> ...but here we set f to mis->from_src_file, which Coverity
> thinks must be NULL...
> 
> > +            goto retry;
> 
> ...and then we goto the 'retry' label, which will always
> dereference the NULL pointer and crash in qemu_get_byte().
> 
> > +        }
> >      }
> >      return ret;
> >  }
> 
> Looking at the wider code, I think what Coverity has not spotted is
> that postcopy_pause_incoming() blocks on the semaphore, and the
> code that wakes it up in migration_fd_process_incoming() will
> set mis->from_src_file to something non-NULL before it posts that
> semaphore.
> 
> However, I'm not sure about the locking being used here. There's
> no lock held while postcopy_pause_incoming() does the "set state
> to paused and then clear mis->from_src_file", so what prevents
> this interleaving of execution of the two threads?
> 
>   postcopy_pause_incoming()        migration_fd_process_incoming()
>     + set state to PAUSED
>                                      + find that state is PAUSED
>                                      + mis->from_src_file = f
>     + mis->from_src_file = NULL
>     + wait on semaphore
>                                      + post semaphare
> 
> ?

Thanks for raising this question up.  I suspect here I should postpone
the status update in postcopy_pause_incoming() to be after clearing
the from_src_file var.  Then we'll make sure the
migration_fd_process_incoming() will always update the correct new
file handle after it was cleared in the other thread.

> 
> There are also a couple of other things Coverity thinks might
> be data race conditions (CID 1391295 and CID 1391288) that you
> might want to look at, though I suspect they are false-positives
> (access occurs before thread create of the thread the mutex
> is providing protection against).

Could you kindly let me know if there is any way for me to lookup
these CIDs?  E.g., I searched "CID 1391295 QEMU Coverity" on Google
but I can't find any link.  Any preferred way to do this?

(I think a stupid way is to lookup the CID in every Coverity reports,
 but I guess there is a faster way)

Thanks,

-- 
Peter Xu
