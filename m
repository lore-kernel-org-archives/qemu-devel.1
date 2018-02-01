Received: from eggs.gnu.org ([2001:4830:134:3::10]:59615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eh2Qp-0006Z3-Il
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 19:08:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eh2Qo-0001jW-Bt
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 19:08:47 -0500
References: <20180127020515.27137-1-jsnow@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <0463d2fd-067b-45a8-84ae-5c3f35651888@redhat.com>
Date: Wed, 31 Jan 2018 19:08:35 -0500
MIME-Version: 1.0
In-Reply-To: <20180127020515.27137-1-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v3 00/14] blockjobs: add explicit job
 management
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, pkrempa@redhat.com, jtc@redhat.com, qemu-devel@nongnu.org



On 01/26/2018 09:05 PM, John Snow wrote:
> For jobs that complete when a monitor isn't looking, there's no way to
> tell what the job's final return code was. We need to allow jobs to
> remain in the list until queried for reliable management.
> 
> Furthermore, it's not viable to have graph changes when the monitor
> isn't looking either. We need at least another event for that.
> 
> This series is a rough sketch for the WAITING, PENDING and CONCLUDED
> events that accompany an expanded job management scheme that a management
> client can opt-in to.
> 
> V3:
>  - Added WAITING and PENDING events
>  - Added block_job_finalize verb
>  - Added .pending() callback for jobs
>  - Tweaked how .commit/.abort work
> 
> V2:
>  - Added tests!
>  - Changed property name (Jeff, Paolo)
> 
> RFC / Known problems:
> - I need a lot more tests.
> - Jobs need to actually implement their .pending callback for this to be of any
>   actual use.
> - Mirror needs to be refactored to use the commit/abort/pending/clean callbacks
>   to fulfill the promise made by "no graph changes without user authorization"
>   that PENDING is supposed to offer
> - Jobs beyond backup will be able to opt-in to the new management scheme in the
>   next version.
> - V4 will include a forced synchronicity for jobs in a transaction; i.e. all
>   jobs will be forced to use either the old or new styles, but not a mix.
> 
> Please take a look and shout loudly if I'm wandering in the wrong direction.
> 
> ________________________________________________________________________________
> 
> For convenience, this branch is available at:
> https://github.com/jnsnow/qemu.git branch block-job-reap
> https://github.com/jnsnow/qemu/tree/block-job-reap
> 
> This version is tagged block-job-reap-v3:
> https://github.com/jnsnow/qemu/releases/tag/block-job-reap-v3
> 
> John Snow (14):
>   blockjobs: add manual property
>   blockjobs: Add status enum
>   blockjobs: add state transition table
>   blockjobs: RFC add block_job_verb permission table
>   blockjobs: add block_job_dismiss
>   blockjobs: add CONCLUDED state
>   blockjobs: ensure abort is called for cancelled jobs
>   blockjobs: add commit, abort, clean helpers
>   blockjobs: add prepare callback
>   blockjobs: Add waiting event
>   blockjobs: add PENDING status and event
>   blockjobs: add block-job-finalize
>   blockjobs: Expose manual property
>   iotests: test manual job dismissal
> 
>  block/backup.c               |  22 ++--
>  block/commit.c               |   2 +-
>  block/mirror.c               |   2 +-
>  block/replication.c          |   5 +-
>  block/stream.c               |   2 +-
>  block/trace-events           |   2 +
>  blockdev.c                   |  42 ++++++-
>  blockjob.c                   | 279 ++++++++++++++++++++++++++++++++++++++++---
>  include/block/block_int.h    |   9 +-
>  include/block/blockjob.h     |  38 ++++++
>  include/block/blockjob_int.h |  12 +-
>  qapi/block-core.json         | 135 +++++++++++++++++++--
>  tests/qemu-iotests/056       | 241 +++++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/056.out   |   4 +-
>  tests/test-bdrv-drain.c      |   4 +-
>  tests/test-blockjob-txn.c    |   2 +-
>  tests/test-blockjob.c        |   4 +-
>  17 files changed, 750 insertions(+), 55 deletions(-)
> 

NACK

There are a lot of changes I've already made to this series based on
Kevin's recommendations; please wait for the next revision.

And a lot of bugs in this series I've already found.

--js
