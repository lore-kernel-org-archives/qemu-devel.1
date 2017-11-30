Received: from eggs.gnu.org ([2001:4830:134:3::10]:59808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eKQEA-0001Ld-Cg
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 09:54:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eKQE9-0002TO-FO
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 09:54:14 -0500
Date: Thu, 30 Nov 2017 09:53:57 -0500
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20171130145357.GA20944@localhost.localdomain>
References: <cover.1511978000.git.berto@igalia.com>
	<4011ffb0dd7f0a0a3e2cfe28223047c809761c90.1511978000.git.berto@igalia.com>
	<20171130122732.GB4039@localhost.localdomain>
	<w514lpbj0m8.fsf@maestria.local.igalia.com>
	<20171130144335.GD4039@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171130144335.GD4039@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH for-2.11 1/1] blockjob: Make
 block_job_pause_all() keep a reference to the jobs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>

On Thu, Nov 30, 2017 at 03:43:35PM +0100, Kevin Wolf wrote:
> Am 30.11.2017 um 15:35 hat Alberto Garcia geschrieben:
> > On Thu 30 Nov 2017 01:27:32 PM CET, Kevin Wolf wrote:
> > 
> > >> Destroying a paused block job during bdrv_reopen_multiple() has two
> > >> consequences:
> > >> 
> > >>    1) The references to the nodes involved in the job are released,
> > >>       possibly destroying some of them. If those nodes were in the
> > >>       reopen queue this would trigger the problem originally described
> > >>       in commit 40840e419be, crashing QEMU.
> > >
> > > This specific problem could be avoided by making the BDS reference in
> > > the reopen queue strong, i.e. bdrv_ref() in bdrv_reopen_queue_child()
> > > and bdrv_unref() only at the end of bdrv_reopen_multiple().
> > 
> > That is correct.
> > 
> > >>    2) At the end of bdrv_reopen_multiple(), bdrv_drain_all_end() would
> > >>       not be doing all necessary bdrv_parent_drained_end() calls.
> > >
> > > If I understand correctly, you don't have a reproducer here.
> > 
> > That's unfortunately not correct.
> > 
> > You can use the very test case that I mentioned in the commit message:
> > 
> >    https://lists.gnu.org/archive/html/qemu-block/2017-11/msg00934.html
> > 
> > With that one, QEMU master crashes easily because of problem (1). If I
> > hold strong references in the reopen queue as you mentioned, the test
> > case hangs because of problem (2).
> 
> Ok, thanks. I'll try to play with this a bit myself later.
> 

Another data point: I'm able to reproduce that crash, by both increasing
STREAM_BUFFER_SIZE as mentioned, and using the new test case, on -rc3.


> > > It's certainly not a full solution because keeping a reference to a
> > > block job does not prevent it from completing, but only from being
> > > freed. Most block jobs do graph modifications, including dropping the
> > > references to nodes, already when they complete, not only when they
> > > are freed.
> > 
> > Yes but the block job itself holds additional references (thanks to
> > block_job_add_bdrv()).
> 
> Mirror and commit call block_job_remove_all_bdrv() during their
> completion. So yes, it does help for streaming, but not for all block
> jobs.
> 
> Kevin
