Received: from eggs.gnu.org ([2001:4830:134:3::10]:35880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eHSDm-0005R2-6q
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 05:25:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eHSDl-0007By-4R
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 05:25:34 -0500
Date: Wed, 22 Nov 2017 11:25:15 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171122102515.GA10954@localhost.localdomain>
References: <20171121170350.31290-1-jcody@redhat.com>
	<20171121170350.31290-2-jcody@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171121170350.31290-2-jcody@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PULL 1/4] blockjob: do not allow
 coroutine double entry or entry-after-completion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: qemu-block@nongnu.org, peter.maydell@linaro.org, qemu-devel@nongnu.org, stefanha@redhat.com, pbonzini@redhat.com

Am 21.11.2017 um 18:03 hat Jeff Cody geschrieben:
> When block_job_sleep_ns() is called, the co-routine is scheduled for
> future execution.  If we allow the job to be re-entered prior to the
> scheduled time, we present a race condition in which a coroutine can be
> entered recursively, or even entered after the coroutine is deleted.
> 
> The job->busy flag is used by blockjobs when a coroutine is busy
> executing. The function 'block_job_enter()' obeys the busy flag,
> and will not enter a coroutine if set.  If we sleep a job, we need to
> leave the busy flag set, so that subsequent calls to block_job_enter()
> are prevented.
> 
> This changes the prior behavior of block_job_cancel() being able to
> immediately wake up and cancel a job; in practice, this should not be an
> issue, as the coroutine sleep times are generally very small, and the
> cancel will occur the next time the coroutine wakes up.
> 
> This fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1508708
> 
> Signed-off-by: Jeff Cody <jcody@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

git bisect says that this is the commit where qemu-iotests started to
break, e.g. case 020:

--- /home/kwolf/source/qemu/tests/qemu-iotests/020.out  2017-11-20 10:43:53.157894898 +0100
+++ /home/kwolf/source/qemu/tests/qemu-iotests/020.out.bad      2017-11-22 11:22:48.781344756 +0100
@@ -537,7 +537,8 @@
 wrote 65536/65536 bytes at offset 4295098368
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 No errors were found on the image.
-Image committed.
+qemu-img: block/block-backend.c:2086: blk_root_drained_end: Assertion `blk->quiesce_counter' failed.
+./common.rc: line 61: 17396 Aborted                 (core dumped) ( exec "$QEMU_IMG_PROG" $QEMU_IMG_OPTIONS "$@" )
 Reading from the backing file
