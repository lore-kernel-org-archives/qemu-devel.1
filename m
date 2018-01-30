Received: from eggs.gnu.org ([208.118.235.92]:60742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1egcVq-0003Px-1g
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 15:29:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1egcUs-0006CM-Ta
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 15:28:13 -0500
References: <20180119205847.7141-1-jsnow@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <5ce53137-e975-9e62-61b6-e4dc785d0969@redhat.com>
Date: Tue, 30 Jan 2018 15:25:28 -0500
MIME-Version: 1.0
In-Reply-To: <20180119205847.7141-1-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 00/13] blockjob: refactor mirror_throttle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com

ping;

I won't respin for patchew until this gets looked over again, sorry :)

On 01/19/2018 03:58 PM, John Snow wrote:
> mirror_throttle attempts to make sure we yield every so often when we're
> doing operations that may not otherwise be as cooperative as we'd like.
> 
> This pattern is useful to other jobs like commit as well; if commit
> continuously decides not to copy data (and calculates delay_ns to be 0),
> we'll frequently and aggressively yield, only to be rescheduled immediately.
> 
> This causes those "WARNING: I/O thread spun for 1000 iterations"
> warnings that everyone loves so much.
> 
> Split out the mirror_throttle function to become a new internal
> BlockJob API function, block_job_throttle; then use it for all
> the other jobs in their runtime loops.
> 
> I decided to use it in stream and backup as well, so that regardless of if the
> loop structure has the chance to be greedy or not (I did not audit this), the
> BlockJob has some kind of failsafe that will occasionally perform a 0ns sleep
> every SLICE_TIME.
> 
> v2:
>  - Fixed spacing consistency (Paolo)
>  - Renamed last_yield_ns to last_enter_ns (Stefan)
>  - Renamed block_job_throttle to block_job_relax (Stefan)
>  - Removed external usages of block_job_pause_point and
>    block_job_sleep_ns (Paolo)
>  - Further cut down block/backup code to use block_job_relax
> 
> ________________________________________________________________________________
> 
> For convenience, this branch is available at:
> https://github.com/jnsnow/qemu.git branch block-job-yield
> https://github.com/jnsnow/qemu/tree/block-job-yield
> 
> This version is tagged block-job-yield-v2:
> https://github.com/jnsnow/qemu/releases/tag/block-job-yield-v2
> 
> John Snow (13):
>   blockjob: record time of last entrance
>   blockjob: consolidate SLICE_TIME definition
>   blockjob: create block_job_relax
>   blockjob: allow block_job_throttle to take delay_ns
>   block/commit: use block_job_relax
>   block/stream: use block_job_relax
>   block/backup: use block_job_relax
>   allow block_job_relax to return -ECANCELED
>   block/backup: remove yield_and_check
>   block/mirror: condense cancellation and relax calls
>   block/mirror: remove block_job_sleep_ns calls
>   blockjob: privatize block_job_sleep_ns
>   blockjob: remove block_job_pause_point from interface
> 
>  block/backup.c               | 27 ++++++-----------------
>  block/commit.c               |  4 +---
>  block/mirror.c               | 52 +++++++++++++++-----------------------------
>  block/stream.c               |  4 +---
>  block/trace-events           |  2 +-
>  blockjob.c                   | 51 ++++++++++++++++++++++++++++++++++++-------
>  include/block/blockjob.h     |  5 +++++
>  include/block/blockjob_int.h | 37 +++++++++++++++----------------
>  tests/test-bdrv-drain.c      |  2 +-
>  tests/test-blockjob-txn.c    |  2 +-
>  10 files changed, 94 insertions(+), 92 deletions(-)
> 
