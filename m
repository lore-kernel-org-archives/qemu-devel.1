Received: from eggs.gnu.org ([2001:4830:134:3::10]:41967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cqiwO-0007Zj-0N
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 12:16:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cqiwM-00006C-EH
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 12:16:51 -0400
Date: Wed, 22 Mar 2017 12:16:38 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170322161638.GK3411@localhost.localdomain>
References: <148969972666.96.6167903765236289989@6c512846dbc7>
	<18a5e8e8-36bf-62ed-7cdd-f576c6700dc3@redhat.com>
	<20170322160143.GH3411@localhost.localdomain>
	<9e312886-03e7-d15c-76cb-4ec333eba317@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e312886-03e7-d15c-76cb-4ec333eba317@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/3] block: pause block jobs for
 bdrv_drain_begin/end
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, qemu-block@nongnu.org, kwolf@redhat.com, pbonzini@redhat.com

On Wed, Mar 22, 2017 at 12:05:26PM -0400, John Snow wrote:
> 
> 
> On 03/22/2017 12:01 PM, Jeff Cody wrote:
> > On Wed, Mar 22, 2017 at 11:37:15AM -0400, John Snow wrote:
> >> ping, is this the only issue? Any feedback? If this can hit 2.9 that
> >> would be good.
> >>
> > 
> > The series looks fine to me, and I can patch up the nit from patchew when
> > applying.  But do you happen to have a qemu-iotest for this case, or is it
> > not very feasible to create one?
> > 
> 
> I might need a hint from Paolo on how; my reproducer ATM is to literally
> boot a Fedora VM and issue reboots/QMP commands and manually observe a
> hang. (Which is pretty subjective ...)
> 
> An iotest version would probably involve using the qtest socket to issue
> a PCI reset of some sort inbetween QMP commands as necessary, but
> testing for a hang in iotests seems race-prone. I have no idea how long
> this hang would last on other machines, for instance.
> 
> There might be a more fool-proof automated testing method, but at the
> second I'm drawing a blank.
>

OK, I figured as much.  We'll chalk that up as "not very feasible", at least
for the moment :)


> >>
> >> On 03/16/2017 05:28 PM, no-reply@patchew.org wrote:
> >>> Hi,
> >>>
> >>> This series seems to have some coding style problems. See output below for
> >>> more information:
> >>>
> >>> Type: series
> >>> Subject: [Qemu-devel] [PATCH v2 0/3] block: pause block jobs for bdrv_drain_begin/end
> >>> Message-id: 20170316212351.13797-1-jsnow@redhat.com
> >>>
> >>> === TEST SCRIPT BEGIN ===
> >>> #!/bin/bash
> >>>
> >>> BASE=base
> >>> n=1
> >>> total=$(git log --oneline $BASE.. | wc -l)
> >>> failed=0
> >>>
> >>> # Useful git options
> >>> git config --local diff.renamelimit 0
> >>> git config --local diff.renames True
> >>>
> >>> commits="$(git log --format=%H --reverse $BASE..)"
> >>> for c in $commits; do
> >>>     echo "Checking PATCH $n/$total: $(git log -n 1 --format=%s $c)..."
> >>>     if ! git show $c --format=email | ./scripts/checkpatch.pl --mailback -; then
> >>>         failed=1
> >>>         echo
> >>>     fi
> >>>     n=$((n+1))
> >>> done
> >>>
> >>> exit $failed
> >>> === TEST SCRIPT END ===
> >>>
> >>> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> >>> From https://github.com/patchew-project/qemu
> >>>  * [new tag]         patchew/20170316212351.13797-1-jsnow@redhat.com -> patchew/20170316212351.13797-1-jsnow@redhat.com
> >>> Switched to a new branch 'test'
> >>> 1cca6f3 blockjob: add devops to blockjob backends
> >>> 864d906 block-backend: add drained_begin / drained_end ops
> >>> 5e4f22d blockjob: add block_job_start_shim
> >>>
> >>> === OUTPUT BEGIN ===
> >>> Checking PATCH 1/3: blockjob: add block_job_start_shim...
> >>> Checking PATCH 2/3: block-backend: add drained_begin / drained_end ops...
> >>> ERROR: suspect code indent for conditional statements (8, 14)
> >>> #70: FILE: block/block-backend.c:1903:
> >>> +        if (blk->dev_ops && blk->dev_ops->drained_end) {
> >>> +              blk->dev_ops->drained_end(blk->dev_opaque);
> >>>
> >>> total: 1 errors, 0 warnings, 67 lines checked
> >>>
> >>> Your patch has style problems, please review.  If any of these errors
> >>> are false positives report them to the maintainer, see
> >>> CHECKPATCH in MAINTAINERS.
> >>>
> >>> Checking PATCH 3/3: blockjob: add devops to blockjob backends...
> >>> === OUTPUT END ===
> >>>
> >>> Test command exited with code: 1
> >>>
> >>>
> >>> ---
> >>> Email generated automatically by Patchew [http://patchew.org/].
> >>> Please send your feedback to patchew-devel@freelists.org
> >>>
