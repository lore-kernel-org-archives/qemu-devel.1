Received: from eggs.gnu.org ([2001:4830:134:3::10]:43736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eK2Bm-0006GU-DK
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 08:14:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eK2Bl-00007A-Ev
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 08:14:10 -0500
Date: Wed, 29 Nov 2017 08:13:58 -0500
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20171129131358.GE18521@localhost.localdomain>
References: <20171129102513.9153-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171129102513.9153-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/4] blockjob: reinstate
 busy=false/busy=true in block_job_sleep_ns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, qemu-block@nongnu.org, kwolf@redhat.com

On Wed, Nov 29, 2017 at 11:25:09AM +0100, Paolo Bonzini wrote:
> In order to avoid reentering a scheduled coroutine this series uses
> a QEMUTimer outside co_aio_sleep_ns.  The timer callback just calls
> block_job_enter, and can be easily cancelled with timer_del.
> 
> This fixes the outstanding issues with block jobs, without reverting
> the new checks that Jeff added.
> 
> I have not run the full qemu-iotests suite, but the main affected
> tests (030, 041, 055, 097, 176, 200) work fine.
> 
> Paolo
> 
> Kevin Wolf (1):
>   block: Expect graph changes in bdrv_parent_drained_begin/end
> 
> Paolo Bonzini (3):
>   blockjob: remove clock argument from block_job_sleep_ns
>   blockjob: introduce block_job_do_yield
>   blockjob: reimplement block_job_sleep_ns to allow cancellation
> 
>  block/backup.c               |  4 +--
>  block/commit.c               |  2 +-
>  block/io.c                   |  8 ++---
>  block/mirror.c               |  6 ++--
>  block/stream.c               |  2 +-
>  blockjob.c                   | 76 ++++++++++++++++++++++++++++++++++----------
>  include/block/blockjob.h     |  5 ++-
>  include/block/blockjob_int.h |  7 ++--
>  tests/test-blockjob-txn.c    |  2 +-
>  9 files changed, 79 insertions(+), 33 deletions(-)
> 
> -- 
> 2.14.3
>


For the series:

Tested-By: Jeff Cody <jcody@redhat.com>
