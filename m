Received: from eggs.gnu.org ([2001:4830:134:3::10]:53714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fnQJ0-00027r-N1
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 11:23:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fnQIu-0005v9-In
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 11:23:22 -0400
Date: Wed, 8 Aug 2018 17:23:01 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180808152301.GC15410@localhost.localdomain>
References: <20180807043349.27196-1-jsnow@redhat.com>
	<20180807043349.27196-3-jsnow@redhat.com>
	<20180808040253.GE755222@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180808040253.GE755222@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH 02/21] jobs: add exit shim
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>

Am 08.08.2018 um 06:02 hat Jeff Cody geschrieben:
> On Tue, Aug 07, 2018 at 12:33:30AM -0400, John Snow wrote:
> > Most jobs do the same thing when they leave their running loop:
> > - Store the return code in a structure
> > - wait to receive this structure in the main thread
> > - signal job completion via job_completed
> > 
> > More seriously, when we utilize job_defer_to_main_loop_bh to call
> > a function that calls job_completed, job_finalize_single will run
> > in a context where it has recursively taken the aio_context lock,
> > which can cause hangs if it puts down a reference that causes a flush.
> > 
> > The job infrastructure is perfectly capable of registering job
> > completion itself when we leave the job's entry point. In this
> > context, we can signal job completion from outside of the aio_context,
> > which should allow for job cleanup code to run with only one lock.
> > 
> > Signed-off-by: John Snow <jsnow@redhat.com>
> 
> I like the simplification, both in SLOC and in exit logic (as seen in
> patches 3-7).

I agree, unifying this seems like a good idea.

Like in the first patch, I'm not convinced of the details, though.
Essentially, this is my objection regarding job->err extended to
job->ret: You rely on jobs setting job->ret and job->err, but the
interfaces don't really show this.

> > @@ -546,6 +559,12 @@ static void coroutine_fn job_co_entry(void *opaque)
> >      assert(job && job->driver && job->driver->start);
> >      job_pause_point(job);
> >      job->driver->start(job);
> 
> One nit-picky observation here, that is unrelated to this patch: reading
> through, it may not be so obvious that 'start' is really a 'run' or
> 'execute', (linguistically, to me 'start' implies a kick-off rather than
> ongoing execution).

I had exactly the same thought. My proposal is to change the existing...

    CoroutineEntry *start;

...which is just short for...

    void coroutine_fn start(void *opaque);

...into this one:

    int coroutine_fn run(void *opaque, Error **errp);

I see that at the end of the series, you actually introduced an int
return value already. I would have done that from the start, but as long
the final state makes sense, I won't insist.

But can we have the Error **errp addition, too? Pretty please?

Kevin
