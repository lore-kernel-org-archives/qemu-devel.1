Received: from eggs.gnu.org ([2001:4830:134:3::10]:36514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1df2e5-0004Bl-Cg
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 07:25:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1df2e2-0007fM-8H
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 07:25:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53320)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1df2e1-0007f1-Uw
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 07:25:54 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DCCD4C047B78
	for <qemu-devel@nongnu.org>; Tue,  8 Aug 2017 11:25:52 +0000 (UTC)
Date: Tue, 8 Aug 2017 12:25:45 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170808112545.GE2081@work-vm>
References: <20170717134238.1966-1-quintela@redhat.com>
	<20170717134238.1966-18-quintela@redhat.com>
	<20170720114507.GG2101@work-vm> <87valy9w7f.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87valy9w7f.fsf@secure.mitica>
Subject: Re: [Qemu-devel] [PATCH v5 17/17] migration: Flush receive queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com, berrange@redhat.com

* Juan Quintela (quintela@redhat.com) wrote:
> "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> > * Juan Quintela (quintela@redhat.com) wrote:
> >> Each time that we sync the bitmap, it is a possiblity that we receive
> >> a page that is being processed by a different thread.  We fix this
> >> problem just making sure that we wait for all receiving threads to
> >> finish its work before we procedeed with the next stage.
> >> 
> >> We are low on page flags, so we use a combination that is not valid to
> >> emit that message:  MULTIFD_PAGE and COMPRESSED.
> >> 
> >> I tried to make a migration command for it, but it don't work because
> >> we sync the bitmap sometimes when we have already sent the beggining
> >> of the section, so I just added a new page flag.
> >> 
> >> Signed-off-by: Juan Quintela <quintela@redhat.com>
> 
> >> +static int multifd_flush(void)
> >> +{
> >> +    int i, thread_count;
> >> +
> >> +    if (!migrate_use_multifd()) {
> >> +        return 0;
> >> +    }
> >> +    thread_count = migrate_multifd_threads();
> >> +    for (i = 0; i < thread_count; i++) {
> >> +        MultiFDRecvParams *p = multifd_recv_state->params[i];
> >> +
> >> +        qemu_mutex_lock(&p->mutex);
> >> +        while (!p->done) {
> >> +            p->sync = true;
> >> +            qemu_cond_wait(&p->cond_sync, &p->mutex);
> >> +        }
> >
> > I don't think I understand how that works in the case where the
> > recv_thread has already 'done' by the point you set sync=true; how does
> > it get back to the check and do the signal?
> 
> We have two cases:
> * done = true
> * done = false
> 
> if done is false, we need to wait until it is done.  But if it is true,
> we don't have to wait.  By definition, there is nothing on that thread
> that we need to wait for.  It is not in the middle of receiving a page.

OK, and you've got the p->mutex, so done can't become true
between the check at the top of the while() and the p->sync = true
on the next line? OK.

Dave
> 
> 
> >
> >> +        qemu_mutex_unlock(&p->mutex);
> >> +    }
> >> +    return 0;
> >> +}
> >> +
> >>  /**
> >>   * save_page_header: write page header to wire
> >>   *
> >> @@ -809,6 +847,12 @@ static size_t save_page_header(RAMState *rs, QEMUFile *f,  RAMBlock *block,
> >>  {
> >>      size_t size, len;
> >>  
> >> +    if (rs->multifd_needs_flush &&
> >> +        (offset & RAM_SAVE_FLAG_MULTIFD_PAGE)) {
> >> +        offset |= RAM_SAVE_FLAG_ZERO;
> >
> > In the comment near the top you say RAM_SAVE_FLAG_COMPRESS_PAGE;  it's
> > probably best to add an alias at the top to make it clear, e.g.
> >   #define RAM_SAVE_FLAG_MULTIFD_SYNC RAM_SAVE_FLAG_ZERO
> >
> >   or maybe (RAM_SAVE_FLAG_MULTIFD_PAGE | RAM_SAVE_FLAG_ZERO)
> 
> done.
> 
> But I only use it when we use the "or".
> 
> Thanks, Juan.
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
