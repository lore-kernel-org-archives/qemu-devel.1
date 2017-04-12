Received: from eggs.gnu.org ([2001:4830:134:3::10]:34930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cyDr0-0001Kj-AR
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 04:42:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cyDqz-0001ED-AR
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 04:42:18 -0400
Date: Wed, 12 Apr 2017 16:42:05 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170412084205.GC32022@lemon>
References: <20170324123458.yk3rj3g47e5xr33i@eukaryote>
	<0e1c78f3-1b82-58e4-035e-944484e66f29@redhat.com>
	<20170411120504.GJ4516@noname.str.redhat.com>
	<58fea8c2-deb7-b9fa-e6d8-d1ea158ed500@redhat.com>
	<20170411133017.GL4516@noname.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170411133017.GL4516@noname.str.redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] Making QMP 'block-job-cancel'
 transactionable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

On Tue, 04/11 15:30, Kevin Wolf wrote:
> Am 11.04.2017 um 15:14 hat Eric Blake geschrieben:
> > On 04/11/2017 07:05 AM, Kevin Wolf wrote:
> > > Note that job completion/cancellation aren't synchronous QMP commands.
> > > The job works something like this, where '...' means that the VM can run
> > > and submit new writes etc.:
> > > 
> > > 1. Start job: mirror_start
> > > ...
> > > 2. Bulk has completed: BLOCK_JOB_READY event
> > > ...
> > > 3. Request completion/cancellation: block-job-completet/cancel
> > > ...
> > > 4. Actual completion/cancellation: BLOCK_JOB_COMPLETED
> > > 
> > > The last one is the actual job completion that we want to be atomic for
> > > a group of nodes. Just making step 3 atomic (which is what including
> > > block-job-complete/cancel in transaction would mean) doesn't really buy
> > > us anything because the data will still change between step 3 and 4.
> > 
> > But as long as the data changes between steps 3 and 4 are written to
> > only one of the two devices, rather than both, then the disk contents
> > atomicity is guaranteed at the point where we stopped the mirroring (ie.
> > during step 3).
> 
> But that's not how things work. Essentially requesting completion means
> that the next time that source and target are in sync, we complete the
> block job. This means that still new copying requests can be issued
> before the job actually completes (and it's even likely to happen).
> 
> > > Now step 4 is reached for each job individually, and unless you stop the
> > > VM (or at least the processing of I/O requests), I don't see how you
> > > could reach it at the same time for all jobs.
> > 
> > The fact that the jobs complete independently (based on different
> > amounts of data to flush) is not problematic, if we are still guaranteed
> > that issuing the request altered the graph so that future writes by the
> > guest only go to one side, and the delay in closing is only due to
> > flushing write requests that pre-dated the job end request.
> 
> This is not easily possible without implementing something like a backup
> job for the final stage of the mirror job... Otherwise the guest can
> always overwrite a sector that is still marked dirty and then that new
> sector will definitely be copied still.

We can add a block-job-cancel-sync command and call block_job_cancel_sync(). If
added to transaction, this does what Eric is asking, right?

Fam
