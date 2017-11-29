Received: from eggs.gnu.org ([2001:4830:134:3::10]:37561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eK9eW-0004em-Ch
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 16:12:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eK9eV-0001S1-Bx
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 16:12:20 -0500
References: <20171129102513.9153-1-pbonzini@redhat.com>
	<20171129102513.9153-5-pbonzini@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <477da2da-99ca-dbb8-b3b1-a0bd959c683a@redhat.com>
Date: Wed, 29 Nov 2017 15:12:03 -0600
MIME-Version: 1.0
In-Reply-To: <20171129102513.9153-5-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jcody@redhat.com, famz@redhat.com, qemu-block@nongnu.org

On 11/29/2017 04:25 AM, Paolo Bonzini wrote:
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

I'm a bit late in reviewing; just pointing out that:

> @@ -807,14 +848,8 @@ void block_job_sleep_ns(BlockJob *job, int64_t ns)
>           return;
>       }
>   
> -    /* We need to leave job->busy set here, because when we have
> -     * put a coroutine to 'sleep', we have scheduled it to run in
> -     * the future.  We cannot enter that same coroutine again before
> -     * it wakes and runs, otherwise we risk double-entry or entry after
> -     * completion. */
>       if (!block_job_should_pause(job)) {
> -        co_aio_sleep_ns(blk_get_aio_context(job->blk),
> -                        QEMU_CLOCK_REALTIME, ns);
> +        block_job_do_yield(job, qemu_clock_get_ns(QEMU_CLOCK_REALTIME) + ns);

This conflicts slightly with 
https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg01681.html that 
simplifies co_aio_sleep_ns.  Are we left with any callers of 
co_aio_sleep_ns() that can use anything other than QEMU_CLOCK_REALTIME, 
or can that also be simplified?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
