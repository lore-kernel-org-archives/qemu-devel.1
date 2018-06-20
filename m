Received: from eggs.gnu.org ([2001:4830:134:3::10]:53198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fVbF3-0003Gk-BK
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 07:25:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fVbEy-0000TM-Bi
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 07:25:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50922 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fVbEy-0000TC-63
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 07:25:32 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CC51D402312B
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 11:25:31 +0000 (UTC)
Date: Wed, 20 Jun 2018 12:25:28 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180620112528.GJ2549@work-vm>
References: <20180523111817.1463-1-quintela@redhat.com>
	<20180523111817.1463-12-quintela@redhat.com>
	<20180611164516.GI2661@work-vm> <87d0wlyle1.fsf@secure.mitica>
	<20180620090127.GB2549@work-vm> <87r2l1lrp0.fsf@secure.mitica>
	<20180620094626.GD2549@work-vm> <87in6dlreq.fsf@secure.mitica>
	<20180620103841.GH2549@work-vm> <87602dlnqu.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87602dlnqu.fsf@secure.mitica>
Subject: Re: [Qemu-devel] [PATCH v13 11/12] migration: Remove not needed
 semaphore and quit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com

* Juan Quintela (quintela@redhat.com) wrote:
> "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> > * Juan Quintela (quintela@redhat.com) wrote:
> >> "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> >> > * Juan Quintela (quintela@redhat.com) wrote:
> >> >> "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> >> >> > * Juan Quintela (quintela@redhat.com) wrote:
> >> >> >> "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> >> >> >> > * Juan Quintela (quintela@redhat.com) wrote:
> >> >> >> >> We know quit closing the QIO.
> >> 
> >> ...
> >> >> > Two questions from that then:
> >> >> >   a) Are you sure it's safe to close the qio_channel while another
> >> >> > thread is in qio_channel_read_all_eof?  Is it really defined that it
> >> >> > causes the other thread to exit with an error;  close() in some stuff
> >> >> > frees data structures that the other thread is still reading; that's
> >> >> > why I've used shutdown(2) in the past rather than close on fd's
> >> >> 
> >> >> Dunno if it is safe (I think it is), but I agree that shutdown will also
> >> >> get what I need.
> >> >> 
> >> >> >   b) I don't think your answer explains why it's an object_unref?
> >> >> 
> >> >> That is the standard way to closing qios to not have to take into
> >> >> account who have it oppened.  See previous paragraph, it is better to
> >> >> use shutdown, done.
> >> >
> >> > OK, great;  I suspect it's unsafe because as soon as you do the unref
> >> > it could free the object; actually you should have a ref from each of
> >> > the threads to sotp it being freed while they use it.
> >> >
> >> > Dave
> >> >
> >> >> Thanks, Juan.
> >> >> 
> >> >> > Dave
> >> >> >
> >> >> >> Later, Juan.
> >> >> > --
> >> >> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> >> > --
> >> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> >> 
> >> What do you think about this, to avoid me resend the whole series?
> >> 
> >> From e03d77de1ca179fa0168cead7c23cfeae57f1787 Mon Sep 17 00:00:00 2001
> >> From: Juan Quintela <quintela@redhat.com>
> >> Date: Wed, 18 Apr 2018 00:49:19 +0200
> >> Subject: [PATCH 17/18] migration: Remove not needed semaphore and quit
> >> 
> >> We know quit with shutdwon in the QIO.
> >> 
> >> Signed-off-by: Juan Quintela <quintela@redhat.com>
> >> --
> >> Add comment
> >> Use shutdown() instead of unref()
> >> ---
> >>  migration/ram.c | 14 +++++---------
> >>  1 file changed, 5 insertions(+), 9 deletions(-)
> >> 
> >> diff --git a/migration/ram.c b/migration/ram.c
> >> index 2c3a452a7d..be5d26f4cb 100644
> >> --- a/migration/ram.c
> >> +++ b/migration/ram.c
> >> @@ -594,14 +594,10 @@ typedef struct {
> >>      QemuThread thread;
> >>      /* communication channel */
> >>      QIOChannel *c;
> >> -    /* sem where to wait for more work */
> >> -    QemuSemaphore sem;
> >>      /* this mutex protects the following parameters */
> >>      QemuMutex mutex;
> >>      /* is this channel thread running */
> >>      bool running;
> >> -    /* should this thread finish */
> >> -    bool quit;
> >>      /* array of pages to receive */
> >>      MultiFDPages_t *pages;
> >>      /* packet allocated len */
> >> @@ -1152,8 +1148,11 @@ static void multifd_recv_terminate_threads(Error *err)
> >>          MultiFDRecvParams *p = &multifd_recv_state->params[i];
> >>  
> >>          qemu_mutex_lock(&p->mutex);
> >> -        p->quit = true;
> >> -        qemu_sem_post(&p->sem);
> >> +        /* We could arrive here for two reasons:
> >> +           - normal quit, i.e. everything went fine, just finished
> >> +           - error quit: We close the channels so the channel threads
> >> +             finish the qio_channel_read_all_eof() */
> >> +        qio_channel_shutdown(p->c, QIO_CHANNEL_SHUTDOWN_BOTH, NULL);
> >
> > OK, so with any luck all the threads now exit;  do we still have a
> > close/unref once we're sure they have all exited?
> 
> Yeap.
> 
> static void multifd_recv_terminate_threads(Error *err)
> {
>     [...]
>     for (i = 0; i < migrate_multifd_channels(); i++) {
>         MultiFDRecvParams *p = &multifd_recv_state->params[i];
> 
>         qemu_mutex_lock(&p->mutex);
>         /* We could arrive here for two reasons:
>            - normal quit, i.e. everything went fine, just finished
>            - error quit: We close the channels so the channel threads
>              finish the qio_channel_read_all_eof() */
>         qio_channel_shutdown(p->c, QIO_CHANNEL_SHUTDOWN_BOTH, NULL);
>         qemu_mutex_unlock(&p->mutex);
>     }
> }
> 
> int multifd_load_cleanup(Error **errp)
> {
>     int i;
>     int ret = 0;
> 
>     if (!migrate_use_multifd()) {
>         return 0;
>     }
>     multifd_recv_terminate_threads(NULL);
>     for (i = 0; i < migrate_multifd_channels(); i++) {
>         MultiFDRecvParams *p = &multifd_recv_state->params[i];
> 
>         if (p->running) {
>             qemu_thread_join(&p->thread);
>         }
>         object_unref(OBJECT(p->c));
>         p->c = NULL;
>         [...]
>     }
>     [...]
> }
> 
> Omited the things that we don't care about for this.

I think that looks OK; you've got one unref at the end, and you do the
shutdown to actually kick them out.

Dave

> Thanks, Juan.
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
