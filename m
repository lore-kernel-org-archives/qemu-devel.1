Received: from eggs.gnu.org ([2001:4830:134:3::10]:56686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fsbG2-0006tK-Jz
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 18:05:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fsbG1-0001T8-S1
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 18:05:42 -0400
References: <20180817190457.8292-1-jsnow@redhat.com>
	<20180817190457.8292-6-jsnow@redhat.com>
	<553da197-ebd0-1eda-909c-aa0740332737@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <0b63f8aa-16eb-b719-b903-dff693753e8b@redhat.com>
Date: Wed, 22 Aug 2018 18:05:32 -0400
MIME-Version: 1.0
In-Reply-To: <553da197-ebd0-1eda-909c-aa0740332737@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 5/7] block/mirror: utilize job_exit shim
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Jeff Cody <jcody@redhat.com>, kwolf@redhat.com, jtc@redhat.com



On 08/22/2018 08:15 AM, Max Reitz wrote:
> On 2018-08-17 21:04, John Snow wrote:
>> Change the manual deferment to mirror_exit into the implicit
>> callback to job_exit and the mirror_exit callback.
>>
>> This does change the order of some bdrv_unref calls and job_completed,
>> but thanks to the new context in which we call .job_exit, this is safe
>> to defer the possible flushing of any nodes to the job_finalize_single
>> cleanup stage.
> 
> Ah, right, I forgot this.  Hm, what exactly do you mean?  This function
> is executed in the main loop, so it can make 'src' go away.  I don't see
> any difference to before.
> 

This changes the order in which we unreference these objects; if you
look at this patch the job_completed call I delete is in the middle of
what becomes the .exit() callback, which means there is a subtle change
in the ordering of how references are put down.

Take a look at the weird ordering of mirror_exit as it exists right now;
we call job_completed first and *then* put down the last references. If
you re-order this upstream right now, you'll deadlock QEMU because this
means job_completed is responsible for putting down the last reference
to some of these block/bds objects.

However, job_completed takes an additional AIO context lock and calls
job_finalize_single under *two* locks, which will hang QEMU if we
attempt to flush any of these nodes when we put down the last reference.

Performing the reordering here is *safe* because by removing the call to
job_completed and utilizing the exit shim, the .exit() callback executes
only under one lock, and when the finalize code runs later it is also
executed under only one lock, making this re-ordering safe.

Clear as mud?

--js

> The only difference I see is that the BH-scheduled function is now
> job_exit() instead of just mirror_complete() (which is now called as
> part of job_exit()).  But then again, it was mirror_complete() itself
> that called job_completed(), like it is now job_exit().  So if
> everything worked after this patch, I don't see why mirror_complete()
> would bdrv_ref() 'src' around job_completed().
> 
> Max
> 
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>  block/mirror.c | 25 +++++++++----------------
>>  1 file changed, 9 insertions(+), 16 deletions(-)
> 
