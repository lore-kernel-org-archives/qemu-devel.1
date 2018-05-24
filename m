Received: from eggs.gnu.org ([2001:4830:134:3::10]:39627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fLlXl-0003cL-QK
	for qemu-devel@nongnu.org; Thu, 24 May 2018 04:24:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fLlXl-0003m0-08
	for qemu-devel@nongnu.org; Thu, 24 May 2018 04:24:17 -0400
Date: Thu, 24 May 2018 10:24:12 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180524082412.GC4008@localhost.localdomain>
References: <20180518132114.4070-1-kwolf@redhat.com>
	<20180518132114.4070-22-kwolf@redhat.com>
	<26778cd3-3150-734b-d8c6-afa6e41f0215@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26778cd3-3150-734b-d8c6-afa6e41f0215@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 21/40] job: Convert
 block_job_cancel_async() to Job
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, jcody@redhat.com, armbru@redhat.com, mreitz@redhat.com

Am 24.05.2018 um 01:18 hat John Snow geschrieben:
> > diff --git a/include/qemu/job.h b/include/qemu/job.h
> > index 3e817beee9..2648c74281 100644
> > --- a/include/qemu/job.h
> > +++ b/include/qemu/job.h
> > @@ -97,6 +97,12 @@ typedef struct Job {
> >       */
> >      bool cancelled;
> >  
> > +    /**
> > +     * Set to true if the job should abort immediately without waiting
> > +     * for data to be in sync.
> > +     */
> > +    bool force_cancel;
> > +
> 
> Does this comment need an update now, though?
> 
> Actually, in terms of "new jobs" API, it'd be really nice if cancel
> *always meant cancel*.
> 
> I think "cancel" should never be used to mean "successful completion,
> but different from the one we'd get if we used job_complete."
> 
> i.e., either we need a job setting:
> 
> job-set completion-mode=[pivot|no-pivot]
> 
> or optional parameters to pass to job-complete:
> 
> job-complete mode=[understood-by-job-type]
> 
> or some other mechanism that accomplishes the same type of behavior. It
> would be nice if it did not have to be determined at job creation time
> but instead could be determined later.

I agree. We already made sure that job-cancel really means cancel on the
QAPI level, so we're free to do that. We just need to keep supporting
block-job-cancel with the old semantics, so what I have is the easy
conversion. We can change the internal implementation when we actually
implement the selection of a completion mode.

Kevin
