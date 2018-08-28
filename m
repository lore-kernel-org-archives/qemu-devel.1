Received: from eggs.gnu.org ([2001:4830:134:3::10]:59096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fuluB-0004D9-AZ
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 17:52:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fulu9-0004kL-Ec
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 17:52:06 -0400
References: <20180817190457.8292-1-jsnow@redhat.com>
	<20180817190457.8292-6-jsnow@redhat.com>
	<553da197-ebd0-1eda-909c-aa0740332737@redhat.com>
	<0b63f8aa-16eb-b719-b903-dff693753e8b@redhat.com>
	<70d6a96e-ac23-101c-bf10-d9855fe2ec9e@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <4f4742dd-4f3d-f865-0af5-cf50c78736dc@redhat.com>
Date: Tue, 28 Aug 2018 17:51:53 -0400
MIME-Version: 1.0
In-Reply-To: <70d6a96e-ac23-101c-bf10-d9855fe2ec9e@redhat.com>
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



On 08/25/2018 11:02 AM, Max Reitz wrote:
> On 2018-08-23 00:05, John Snow wrote:
>>
>>
>> On 08/22/2018 08:15 AM, Max Reitz wrote:
>>> On 2018-08-17 21:04, John Snow wrote:
>>>> Change the manual deferment to mirror_exit into the implicit
>>>> callback to job_exit and the mirror_exit callback.
>>>>
>>>> This does change the order of some bdrv_unref calls and job_completed,
>>>> but thanks to the new context in which we call .job_exit, this is safe
>>>> to defer the possible flushing of any nodes to the job_finalize_single
>>>> cleanup stage.
>>>
>>> Ah, right, I forgot this.  Hm, what exactly do you mean?  This function
>>> is executed in the main loop, so it can make 'src' go away.  I don't see
>>> any difference to before.
>>>
>>
>> This changes the order in which we unreference these objects; if you
>> look at this patch the job_completed call I delete is in the middle of
>> what becomes the .exit() callback, which means there is a subtle change
>> in the ordering of how references are put down.
>>
>> Take a look at the weird ordering of mirror_exit as it exists right now;
>> we call job_completed first and *then* put down the last references. If
>> you re-order this upstream right now, you'll deadlock QEMU because this
>> means job_completed is responsible for putting down the last reference
>> to some of these block/bds objects.
>>
>> However, job_completed takes an additional AIO context lock and calls
>> job_finalize_single under *two* locks, which will hang QEMU if we
>> attempt to flush any of these nodes when we put down the last reference.
> 
> If you say so...  I have to admit I don't really understand.  The
> comment doesn't explain why it's so important to keep src around until
> job_completed(), so I don't know.  I thought AioContexts are recursive
> so it doesn't matter whether you take them recursively or not.
> 
> Anyway.  So the difference now is that job_defer_to_main_loop() took the
> lock around the whole exit function, whereas the new exit shim only
> takes it around the .exit() method, but calls job_complete() without a
> lock -- and then job_finalize_single() gets its lock again, so the job
> methods are again called with locks.  That sounds OK to me.
> 
>> Performing the reordering here is *safe* because by removing the call to
>> job_completed and utilizing the exit shim, the .exit() callback executes
>> only under one lock, and when the finalize code runs later it is also
>> executed under only one lock, making this re-ordering safe.
>>
>> Clear as mud?
> 
> Well, I trust you that the drain issue was the reason that src had to
> stay around until after job_completed().  It seems a bit
> counter-intuitive, because the comment explaining that src needs to stay
> around until job_completed() doesn't say much -- but it does imply that
> without that bdrv_ref(), the BDS might be destroyed before
> job_completed().  Which is different from simply having only one
> reference left and then being deleted in job_completed().
> 
> Looking at 3f09bfbc7be, I'm inclined to believe the original reason may
> be that src->job points to the job and that we shouldn't delete it as
> long as it does (bdrv_delete() asserts that bs->job is NULL).  Oh no, a
> tangent appears.
> 
> ...I would assume that when bdrv_replace_node() is called, BlockJob.blk
> is updated to point to the new BDS.  But nobody seems to update the
> BDS.job field.  Investigation is in order.
> 
> Max
> 

The real reason, presently, appears to just be that we want to call
bdrv_drained_end on src, but we may have put down the last reference
during bdrv_replace_node.

I'll update the comment accordingly. Anything beyond that is beyond the
scope of this series.

--js
