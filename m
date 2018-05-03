Received: from eggs.gnu.org ([2001:4830:134:3::10]:60263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fECS4-0005CZ-8d
	for qemu-devel@nongnu.org; Thu, 03 May 2018 07:31:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fECRy-0003qS-Cj
	for qemu-devel@nongnu.org; Thu, 03 May 2018 07:31:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33004 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fECRy-0003pg-6s
	for qemu-devel@nongnu.org; Thu, 03 May 2018 07:31:02 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5335481A88C3
	for <qemu-devel@nongnu.org>; Thu,  3 May 2018 11:30:56 +0000 (UTC)
Date: Thu, 3 May 2018 12:30:47 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180503113046.GD2660@work-vm>
References: <20180425112723.1111-1-quintela@redhat.com>
	<20180425112723.1111-18-quintela@redhat.com>
	<20180426081815.GT9036@xz-mi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180426081815.GT9036@xz-mi>
Subject: Re: [Qemu-devel] [PATCH v12 17/21] migration: Create
 ram_multifd_page
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, lvivier@redhat.com

* Peter Xu (peterx@redhat.com) wrote:
> On Wed, Apr 25, 2018 at 01:27:19PM +0200, Juan Quintela wrote:
> > The function still don't use multifd, but we have simplified
> > ram_save_page, xbzrle and RDMA stuff is gone.  We have added a new
> > counter.
> > 
> > Signed-off-by: Juan Quintela <quintela@redhat.com>
> > 
> > --
> > Add last_page parameter
> > Add commets for done and address
> > Remove multifd field, it is the same than normal pages
> > Merge next patch, now we send multiple pages at a time
> > Remove counter for multifd pages, it is identical to normal pages
> > Use iovec's instead of creating the equivalent.
> > Clear memory used by pages (dave)
> > Use g_new0(danp)
> > define MULTIFD_CONTINUE
> > now pages member is a pointer
> > Fix off-by-one in number of pages in one packet
> > Remove RAM_SAVE_FLAG_MULTIFD_PAGE
> > s/multifd_pages_t/MultiFDPages_t/
> > ---
> >  migration/ram.c | 93 +++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 93 insertions(+)
> > 
> > diff --git a/migration/ram.c b/migration/ram.c
> > index 398cb0af3b..862ec53d32 100644
> > --- a/migration/ram.c
> > +++ b/migration/ram.c
> > @@ -54,6 +54,7 @@
> >  #include "migration/block.h"
> >  #include "sysemu/sysemu.h"
> >  #include "qemu/uuid.h"
> > +#include "qemu/iov.h"
> >  
> >  /***********************************************************/
> >  /* ram save/restore */
> > @@ -692,8 +693,65 @@ struct {
> >      QemuSemaphore sem_sync;
> >      /* global number of generated multifd packets */
> >      uint32_t seq;
> > +    /* send channels ready */
> > +    QemuSemaphore channels_ready;
> >  } *multifd_send_state;
> >  
> > +static void multifd_send_pages(void)
> > +{
> > +    int i;
> > +    static int next_channel;
> > +    MultiFDSendParams *p = NULL; /* make happy gcc */
> > +    MultiFDPages_t *pages = multifd_send_state->pages;
> > +
> > +    qemu_sem_wait(&multifd_send_state->channels_ready);
> 
> This sem is posted when a thread has finished its work.  However this
> is called in the main migration thread.  If with this line, are the
> threads really sending things in parallel?  Since it looks to me that
> this function (and the main thread) won't send the 2nd page array if
> the 1st hasn't finished, and won't send the 3rd if the 2nd hasn't,
> vice versa...
> 
> Maybe I misunderstood something.  Please feel free to correct me.

I share a similar misunderstanding;  except I can't understand how the
first item ever gets sent if we're waiting for channels_ready.
I think I could have understood it if there was a sem_post at the top of
multifd_send_thread.

Dave

> > +    for (i = next_channel;; i = (i + 1) % migrate_multifd_channels()) {
> > +        p = &multifd_send_state->params[i];
> > +
> > +        qemu_mutex_lock(&p->mutex);
> > +        if (!p->pending_job) {
> > +            p->pending_job++;
> > +            next_channel = (i + 1) % migrate_multifd_channels();
> > +            break;
> > +        }
> > +        qemu_mutex_unlock(&p->mutex);
> > +    }
> > +    p->pages->used = 0;
> > +    multifd_send_state->seq++;
> > +    p->seq = multifd_send_state->seq;
> > +    p->pages->block = NULL;
> > +    multifd_send_state->pages = p->pages;
> > +    p->pages = pages;
> 
> Here we directly replaced MultiFDSendParams.pages with
> multifd_send_state->pages.  Then are we always using a single
> MultiFDPages_t struct?  And if so, will all the initial
> MultiFDSendParams.pages memory leaked without freed?
> 
> > +    qemu_mutex_unlock(&p->mutex);
> > +    qemu_sem_post(&p->sem);
> > +}
> 
> Thanks,
> 
> -- 
> Peter Xu
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
