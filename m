Received: from eggs.gnu.org ([2001:4830:134:3::10]:38809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dCQkF-0002yJ-JU
	for qemu-devel@nongnu.org; Sun, 21 May 2017 09:18:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dCQkE-0006f1-M5
	for qemu-devel@nongnu.org; Sun, 21 May 2017 09:18:03 -0400
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
References: <20170508141310.8674-1-pbonzini@redhat.com>
Message-ID: <20297b79-c716-5045-8ac0-11cbecdb0856@redhat.com>
Date: Sun, 21 May 2017 15:17:50 +0200
MIME-Version: 1.0
In-Reply-To: <20170508141310.8674-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 00/11] Preparation for block job mutex
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, qemu-block@nongnu.org, Jeff Cody <jcody@redhat.com>

Ping?

On 08/05/2017 16:12, Paolo Bonzini wrote:
> These are a bunch of cleanups and patches extracted from the AioContext
> lock removal series.  As a general theme, the patches reorganize
> blockjob.c to follow the blockjob.h/blockjob_int.h separation more
> closely.  For this reason, a lot of the patches are just moving functions
> around.
> 
> The blockjob.h/blockjob_int.h split later will correspond to different
> locking rules, but the patches are independent from this change, and
> can be applied/reviewed separately.
> 
> There is no code change from v1, but all patches now have Reviewed-by
> from at least one of John and Stefan.
> 
> Thanks,
> 
> Paolo
> 
> 
> Paolo Bonzini (11):
>   blockjob: remove unnecessary check
>   blockjob: remove iostatus_reset callback
>   blockjob: introduce block_job_early_fail
>   blockjob: introduce block_job_pause/resume_all
>   blockjob: separate monitor and blockjob APIs
>   blockjob: move iostatus reset inside block_job_user_resume
>   blockjob: introduce block_job_cancel_async, check iostatus invariants
>   blockjob: group BlockJob transaction functions together
>   blockjob: strengthen a bit test-blockjob-txn
>   blockjob: reorganize block_job_completed_txn_abort
>   blockjob: use deferred_to_main_loop to indicate the coroutine has
>     ended
> 
>  block/backup.c               |   2 +-
>  block/commit.c               |   2 +-
>  block/io.c                   |  19 +-
>  block/mirror.c               |   2 +-
>  blockdev.c                   |   1 -
>  blockjob.c                   | 900 +++++++++++++++++++++++--------------------
>  include/block/blockjob.h     |  16 -
>  include/block/blockjob_int.h |  27 +-
>  tests/test-blockjob-txn.c    |   7 +-
>  tests/test-blockjob.c        |  10 +-
>  10 files changed, 522 insertions(+), 464 deletions(-)
> 
