Received: from eggs.gnu.org ([2001:4830:134:3::10]:59559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fnQgj-00030P-Sl
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 11:47:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fnQgi-0003tK-NK
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 11:47:53 -0400
Date: Wed, 8 Aug 2018 17:47:44 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180808154744.GD15410@localhost.localdomain>
References: <20180807043349.27196-1-jsnow@redhat.com>
	<20180807043349.27196-3-jsnow@redhat.com>
	<20180808040253.GE755222@localhost.localdomain>
	<20180808152301.GC15410@localhost.localdomain>
	<c068a626-0ab7-3a7b-0fc1-bde5d0d9590f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c068a626-0ab7-3a7b-0fc1-bde5d0d9590f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 02/21] jobs: add exit shim
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>

Am 08.08.2018 um 17:38 hat John Snow geschrieben:
> On 08/08/2018 11:23 AM, Kevin Wolf wrote:
> > Am 08.08.2018 um 06:02 hat Jeff Cody geschrieben:
> >> On Tue, Aug 07, 2018 at 12:33:30AM -0400, John Snow wrote:
> >>> Most jobs do the same thing when they leave their running loop:
> >>> - Store the return code in a structure
> >>> - wait to receive this structure in the main thread
> >>> - signal job completion via job_completed
> >>>
> >>> More seriously, when we utilize job_defer_to_main_loop_bh to call
> >>> a function that calls job_completed, job_finalize_single will run
> >>> in a context where it has recursively taken the aio_context lock,
> >>> which can cause hangs if it puts down a reference that causes a flush.
> >>>
> >>> The job infrastructure is perfectly capable of registering job
> >>> completion itself when we leave the job's entry point. In this
> >>> context, we can signal job completion from outside of the aio_context,
> >>> which should allow for job cleanup code to run with only one lock.
> >>>
> >>> Signed-off-by: John Snow <jsnow@redhat.com>
> >>
> >> I like the simplification, both in SLOC and in exit logic (as seen in
> >> patches 3-7).
> > 
> > I agree, unifying this seems like a good idea.
> > 
> > Like in the first patch, I'm not convinced of the details, though.
> > Essentially, this is my objection regarding job->err extended to
> > job->ret: You rely on jobs setting job->ret and job->err, but the
> > interfaces don't really show this.
> > 
> >>> @@ -546,6 +559,12 @@ static void coroutine_fn job_co_entry(void *opaque)
> >>>      assert(job && job->driver && job->driver->start);
> >>>      job_pause_point(job);
> >>>      job->driver->start(job);
> >>
> >> One nit-picky observation here, that is unrelated to this patch: reading
> >> through, it may not be so obvious that 'start' is really a 'run' or
> >> 'execute', (linguistically, to me 'start' implies a kick-off rather than
> >> ongoing execution).
> > 
> > I had exactly the same thought. My proposal is to change the existing...
> > 
> >     CoroutineEntry *start;
> > 
> > ...which is just short for...
> > 
> >     void coroutine_fn start(void *opaque);
> > 
> > ...into this one:
> > 
> >     int coroutine_fn run(void *opaque, Error **errp);
> > 
> > I see that at the end of the series, you actually introduced an int
> > return value already. I would have done that from the start, but as long
> > the final state makes sense, I won't insist.
> > 
> > But can we have the Error **errp addition, too? Pretty please?
> > 
> > Kevin
> > 
> 
> I'm actually glad you want that addition, I was considering very
> strongly adding it but I felt like I had made the series long enough
> already and didn't want to change too much all at once.
> 
> The basic thought was just:
> 
> "It'd sure be nice to have a generic function entry point that looks
> like it returns the same error information as our non-coroutine functions."
> 
> I can absolutely work that in, and break this series into two parts:
> 
> (1) Rework jobs infrastructure to use the new run signature, and
> (2) Rework jobs to use the finalization callbacks.
> 
> Sound good?

I haven't looked at the rest of the series yet, but so far this sounds
good to me.

Kevin
