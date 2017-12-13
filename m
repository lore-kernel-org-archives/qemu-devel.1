Received: from eggs.gnu.org ([2001:4830:134:3::10]:34105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eP6OD-0004uP-1r
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 07:43:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eP6O9-0007yx-26
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 07:43:57 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20171213113120.GC3950@localhost.localdomain>
References: <20171207170834.15843-1-berto@igalia.com>
	<20171213113120.GC3950@localhost.localdomain>
Date: Wed, 13 Dec 2017 13:43:14 +0100
Message-ID: <w518te6ajdp.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] iotests: Tweak 030 in order to trigger a
 race condition with parallel jobs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Wed 13 Dec 2017 12:31:20 PM CET, Kevin Wolf wrote:
> Am 07.12.2017 um 18:08 hat Alberto Garcia geschrieben:
>> This patch tweaks TestParallelOps in iotest 030 so it allocates data
>> in smaller regions (256KB/512KB instead of 512KB/1MB) and the
>> block-stream job in test_stream_commit() only needs to copy data that
>> is at the very end of the image.
>> 
>> This way when the block-stream job is waken up it will finish right
>> away without any chance of being stopped by block_job_sleep_ns(). This
>> triggers the bug that was fixed by 3d5d319e1221082974711af1d09d82f07
>> and is therefore a more useful test case for parallel block jobs.
>
> But if all jobs complete right away, doesn't this kill the parallelism
> that the test case intended to test?

Good question. There's two cases where there's parallel block jobs:

- test_stream_parallel(): in this case we run four block-stream jobs so
  although one finishes early the others will run the stream_run() loop
  in parallel. So no need to worry here.

- test_stream_commit(): here there's only two jobs. block-stream starts
  first, then block-commit starts and calls bdrv_reopen() and it's
  during that reopen that the first job finishes. So while the main
  purpose of this test case was to ensure that op blockers were working
  fine and that you can launch both jobs at the same time, it's true
  that with this patch you won't have both main iterations (stream_run()
  and mirror_run()) running at the same time.

> Maybe we need both cases?

I guess it's a good idea, it should be as simple as creating a subclass
of TestParallelOps with different sizes, all test cases will be
inherited from the parent.

I'll send a new patch.

Berto
