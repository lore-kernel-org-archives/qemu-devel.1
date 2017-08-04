Received: from eggs.gnu.org ([2001:4830:134:3::10]:55198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ddYYI-0001m1-PN
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 05:05:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ddYYH-00078o-Qf
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 05:05:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54126)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ddYYH-00078K-KG
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 05:05:49 -0400
Date: Fri, 4 Aug 2017 17:05:44 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170804090544.GP5561@pxdev.xzpeter.org>
References: <1501229198-30588-1-git-send-email-peterx@redhat.com>
	<1501229198-30588-29-git-send-email-peterx@redhat.com>
	<20170803134744.GL2076@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170803134744.GL2076@work-vm>
Subject: Re: [Qemu-devel] [RFC 28/29] migration: final handshake for the
 resume
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

On Thu, Aug 03, 2017 at 02:47:44PM +0100, Dr. David Alan Gilbert wrote:

[...]

> > +static int postcopy_resume_handshake(MigrationState *s)
> > +{
> > +    qemu_mutex_lock(&s->resume_lock);
> > +
> > +    qemu_savevm_send_postcopy_resume(s->to_dst_file);
> > +
> > +    while (s->state == MIGRATION_STATUS_POSTCOPY_RECOVER) {
> > +        qemu_cond_wait(&s->resume_cond, &s->resume_lock);
> > +    }
> > +
> > +    qemu_mutex_unlock(&s->resume_lock);
> > +
> > +    if (s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) {
> > +        return 0;
> > +    }
> 
> That feels to be a small racy - couldn't that validly become a
> MIGRATION_STATUS_COMPLETED before that check?

Since postcopy_resume_handshake() is called in migration_thread()
context, so it won't change to complete at this point (confirmed with
Dave offlist on the question).

> 
> I wonder if we need to change migrate_fd_cancel to be able to
> cause a cancel in this case?

Yeah that's important, but haven't considered in current series. Do
you mind to postpone it as TODO as well (along with the work to allow
the user to manually switch to PAUSED state, as Dan suggested)?

-- 
Peter Xu
