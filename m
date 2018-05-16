Received: from eggs.gnu.org ([2001:4830:134:3::10]:51915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fJ3Qo-0006Wg-Bz
	for qemu-devel@nongnu.org; Wed, 16 May 2018 16:53:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fJ3Qn-0001tQ-JR
	for qemu-devel@nongnu.org; Wed, 16 May 2018 16:53:54 -0400
Date: Wed, 16 May 2018 22:53:44 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180516205344.GH4435@localhost.localdomain>
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-23-kwolf@redhat.com>
	<c6b54143-2dd0-e8f1-eaa7-afb7423628d1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6b54143-2dd0-e8f1-eaa7-afb7423628d1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 22/42] job: Move BlockJobCreateFlags to Job
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org

Am 16.05.2018 um 21:13 hat Eric Blake geschrieben:
> On 05/09/2018 11:26 AM, Kevin Wolf wrote:
> > This renames the BlockJobCreateFlags constants, moves a few JOB_INTERNAL
> > checks to job_create() and the auto_{finalize,dismiss} fields from
> > BlockJob to Job.
> 
> Do we still want to allow auto-finalize on all jobs, or should we keep it
> just for legacy support on block jobs?  Even more so for auto-dismiss (if
> you use the legacy interface, that's what you expect to happen; but other
> than for legacy block jobs, any sane management app is going to request
> auto-dismiss be false, so why expose it to generic jobs?)
> 
> Of course, it may still be easiest to plumb up auto- actions in the internal
> code (where it has to work to keep legacy block jobs from breaking, but no
> new callers have to enable it), so my argument may not apply until you
> actually expose a QMP interface for generic jobs.

This series doesn't expose it anyway. We can later decide whether we
want to add it or not. A sophisticated management tool like libvirt that
needs to manage individual nodes and cope with daemon restarts will
never make use of them, but they might still be useful in hand-crafted
scripts for defined special cases.

> > +++ b/block/mirror.c
> > @@ -1282,7 +1282,7 @@ void mirror_start(const char *job_id, BlockDriverState *bs,
> >       }
> >       is_none_mode = mode == MIRROR_SYNC_MODE_NONE;
> >       base = mode == MIRROR_SYNC_MODE_TOP ? backing_bs(bs) : NULL;
> > -    mirror_start_job(job_id, bs, BLOCK_JOB_DEFAULT, target, replaces,
> > +    mirror_start_job(job_id, bs, JOB_DEFAULT, target, replaces,
> >                        speed, granularity, buf_size, backing_mode,
> >                        on_source_error, on_target_error, unmap, NULL, NULL,
> >                        &mirror_job_driver, is_none_mode, base, false,
> 
> Just an observation that this is a lot of parameters; would using boxed QAPI
> types make these calls any more obvious?  But that's a separate cleanup.

I'm not sure if we have a QAPI type that matches this. But maybe it
could become a QAPI struct and very few extra parameters.

Kevin
