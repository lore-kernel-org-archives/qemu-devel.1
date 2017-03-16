Received: from eggs.gnu.org ([2001:4830:134:3::10]:60941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1coQe7-0008GR-5D
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 04:20:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1coQe6-0000fX-Cv
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 04:20:31 -0400
References: <20170316004603.20609-1-jsnow@redhat.com>
	<20170316004603.20609-2-jsnow@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <142fa112-2295-3bd8-f430-e45ae804936e@redhat.com>
Date: Thu, 16 Mar 2017 09:20:20 +0100
MIME-Version: 1.0
In-Reply-To: <20170316004603.20609-2-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC patch 1/3] blockjob: add block_job_start_shim
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org



On 16/03/2017 01:46, John Snow wrote:
> +/**
> + * This code must run after the job's coroutine has been entered,
> + * but not before.
> + */
> +static void coroutine_fn block_job_start_shim(void *opaque)
> +{
> +    BlockJob *job = opaque;
> +
> +    assert(job && job->driver && job->driver->start);
> +    block_job_pause_point(job);
> +    job->driver->start(job);
> +}

Poor function, don't call it a shim :)  Let's just call it
block_job_co_entry.

Paolo

>  void block_job_start(BlockJob *job)
>  {
>      assert(job && !block_job_started(job) && job->paused &&
> -           !job->busy && job->driver->start);
> -    job->co = qemu_coroutine_create(job->driver->start, job);
> -    if (--job->pause_count == 0) {
> -        job->paused = false;
> -        job->busy = true;
> -        qemu_coroutine_enter(job->co);
> -    }
> +           job->driver && job->driver->start);
> +    job->co = qemu_coroutine_create(block_job_start_shim, job);
> +    job->pause_count--;
> +    job->busy = true;
> +    job->paused = false;
> +    qemu_coroutine_enter(job->co);
>  }
>  
>  void block_job_ref(BlockJob *job)
