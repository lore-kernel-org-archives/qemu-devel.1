Received: from eggs.gnu.org ([2001:4830:134:3::10]:50652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dcnMx-00055c-Sj
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 02:43:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dcnMu-0002d9-Px
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 02:42:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54730)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dcnMu-0002cs-Ju
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 02:42:56 -0400
Date: Wed, 2 Aug 2017 14:42:49 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170802064249.GC4475@pxdev.xzpeter.org>
References: <1501229198-30588-1-git-send-email-peterx@redhat.com>
	<1501229198-30588-19-git-send-email-peterx@redhat.com>
	<20170801113622.GK2079@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170801113622.GK2079@work-vm>
Subject: Re: [Qemu-devel] [RFC 18/29] migration: new state "postcopy-recover"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>

On Tue, Aug 01, 2017 at 12:36:22PM +0100, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:

[...]
> > @@ -2043,9 +2054,32 @@ static bool postcopy_pause(MigrationState *s)
> >          qemu_sem_wait(&s->postcopy_pause_sem);
> >      }
> >  
> > -    trace_postcopy_pause_continued();
> > +    if (s->state == MIGRATION_STATUS_POSTCOPY_RECOVER) {
> > +        /* We were waken up by a recover procedure. Give it a shot */
> >  
> > -    return true;
> > +        /*
> > +         * Firstly, let's wake up the return path now, with a new
> > +         * return path channel.
> > +         */
> > +        qemu_sem_post(&s->postcopy_pause_rp_sem);
> > +
> > +        /* Do the resume logic */
> > +        if (postcopy_do_resume(s) == 0) {
> > +            /* Let's continue! */
> > +            trace_postcopy_pause_continued();
> > +            return true;
> > +        } else {
> > +            /*
> > +             * Something wrong happened during the recovery, let's
> > +             * pause again. Pause is always better than throwing data
> > +             * away.
> > +             */
> > +            goto do_pause;
> 
> You should be able to turn this around into a do {} while or similar
> rather than goto.

Indeed. Fixing up.  Thanks,

-- 
Peter Xu
