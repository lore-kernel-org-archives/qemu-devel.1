Received: from eggs.gnu.org ([2001:4830:134:3::10]:33508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cxuY1-0005Gy-5r
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 08:05:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cxuXx-0001Gz-3H
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 08:05:25 -0400
Date: Tue, 11 Apr 2017 14:05:04 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170411120504.GJ4516@noname.str.redhat.com>
References: <20170324123458.yk3rj3g47e5xr33i@eukaryote>
	<0e1c78f3-1b82-58e4-035e-944484e66f29@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e1c78f3-1b82-58e4-035e-944484e66f29@redhat.com>
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
To: John Snow <jsnow@redhat.com>
Cc: Kashyap Chamarthy <kchamart@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

Am 03.04.2017 um 22:29 hat John Snow geschrieben:
> On 03/24/2017 08:34 AM, Kashyap Chamarthy wrote:
> > While debugging some other issue, I happened to stumble across an old
> > libvirt commit[*] that adds support for pivot (whether QEMU should
> > switch to a target copy or not) operation as a result of issuing QMP
> > 'block-job-cancel' to a 'drive-mirror' (in libvirt parlance, "block
> > copy").
> > 
> > In the libvirt commit message[*] Eric Blake writes:
> > 
> >     "[...] There may be potential improvements to the snapshot code to
> >     exploit block copy over multiple disks all at one point in time.
> >     And, if 'block-job-cancel' were made part of 'transaction', you
> >     could copy multiple disks at the same point in time without pausing
> >     the domain. [...]"
> > 
> 
> Oh, you want a transactional cancel to basically capitalize on the
> second completion mode of the mirror job.
> 
> I have never really cared for the way this job works, because I don't
> think "canceling" a ready job is semantically valid (it's not canceled!
> We completed successfully, just using a different completion mode) --
> but if I am in the minority here I would cede that a transactional
> cancel would be a worthwhile thing to have.

Note that job completion/cancellation aren't synchronous QMP commands.
The job works something like this, where '...' means that the VM can run
and submit new writes etc.:

1. Start job: mirror_start
...
2. Bulk has completed: BLOCK_JOB_READY event
...
3. Request completion/cancellation: block-job-completet/cancel
...
4. Actual completion/cancellation: BLOCK_JOB_COMPLETED

The last one is the actual job completion that we want to be atomic for
a group of nodes. Just making step 3 atomic (which is what including
block-job-complete/cancel in transaction would mean) doesn't really buy
us anything because the data will still change between step 3 and 4.

Now step 4 is reached for each job individually, and unless you stop the
VM (or at least the processing of I/O requests), I don't see how you
could reach it at the same time for all jobs.

Kevin
