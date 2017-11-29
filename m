Received: from eggs.gnu.org ([2001:4830:134:3::10]:38938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eK1tC-0007hu-Ct
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 07:55:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eK1tB-0000gR-M9
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 07:54:58 -0500
Date: Wed, 29 Nov 2017 13:54:39 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171129125439.GB3753@localhost.localdomain>
References: <20171129102513.9153-1-pbonzini@redhat.com>
	<20171129102513.9153-5-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171129102513.9153-5-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 4/4] blockjob: reimplement
 block_job_sleep_ns to allow cancellation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, qemu-block@nongnu.org, jcody@redhat.com

Am 29.11.2017 um 11:25 hat Paolo Bonzini geschrieben:
> This reverts the effects of commit 4afeffc857 ("blockjob: do not allow
> coroutine double entry or entry-after-completion", 2017-11-21)
> 
> This fixed the symptom of a bug rather than the root cause. Canceling the
> wait on a sleeping blockjob coroutine is generally fine, we just need to
> make it work correctly across AioContexts.  To do so, use a QEMUTimer
> that calls block_job_enter.  Use a mutex to ensure that block_job_enter
> synchronizes correctly with block_job_sleep_ns.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  blockjob.c                   | 57 +++++++++++++++++++++++++++++++++++---------
>  include/block/blockjob.h     |  5 +++-
>  include/block/blockjob_int.h |  4 ++--
>  3 files changed, 52 insertions(+), 14 deletions(-)
> 
> diff --git a/blockjob.c b/blockjob.c
> index 4d22b7d2fb..3fdaabbc1f 100644
> --- a/blockjob.c
> +++ b/blockjob.c
> @@ -37,6 +37,26 @@
>  #include "qemu/timer.h"
>  #include "qapi-event.h"
>  
> +/* Right now, this mutex is only needed to synchronize accesses to job->busy,
> + * especially concurrent calls to block_job_enter.
> + */

As discussed with Paolo on IRC, I'll replace the second line of this
comment, which he had in a different place originally and became prone
to misunderstanding now. The new version is:

/* Right now, this mutex is only needed to synchronize accesses to job->busy,
 * such as concurrent calls to block_job_do_yield and block_job_enter.
 */

Kevin
