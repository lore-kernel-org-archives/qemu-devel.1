Received: from eggs.gnu.org ([2001:4830:134:3::10]:57726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ekBMS-0005Us-Nh
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 11:17:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ekBMR-0008Cq-O9
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 11:17:16 -0500
References: <20180209152412.23626-1-pbonzini@redhat.com>
	<20180209161613.GM3998@localhost.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5f22880c-6813-9e5f-9128-e9800d79dd24@redhat.com>
Date: Fri, 9 Feb 2018 17:17:08 +0100
MIME-Version: 1.0
In-Reply-To: <20180209161613.GM3998@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block/nvme: fix Coverity
 reports
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, famz@redhat.com

On 09/02/2018 17:16, Kevin Wolf wrote:
> Am 09.02.2018 um 16:24 hat Paolo Bonzini geschrieben:
>> 1) string not null terminated in sysfs_find_group_file
>>
>> 2) NULL pointer dereference and dead local variable in nvme_init.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>  block/nvme.c        | 14 ++++++--------
>>  util/vfio-helpers.c |  2 +-
>>  2 files changed, 7 insertions(+), 9 deletions(-)
>>
>> diff --git a/block/nvme.c b/block/nvme.c
>> index e9d0e218fc..ce217ffc81 100644
>> --- a/block/nvme.c
>> +++ b/block/nvme.c
>> @@ -553,7 +553,6 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
>>      uint64_t cap;
>>      uint64_t timeout_ms;
>>      uint64_t deadline, now;
>> -    Error *local_err = NULL;
>>  
>>      qemu_co_mutex_init(&s->dma_map_lock);
>>      qemu_co_queue_init(&s->dma_flush_queue);
>> @@ -645,11 +644,6 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
>>                             false, nvme_handle_event, nvme_poll_cb);
>>  
>>      nvme_identify(bs, namespace, errp);
>> -    if (local_err) {
>> -        error_propagate(errp, local_err);
>> -        ret = -EIO;
>> -        goto fail_handler;
>> -    }
>>  
>>      /* Set up command queues. */
>>      if (!nvme_add_io_queue(bs, errp)) {
> 
> I don't think this is right, errp must not be assigned twice, and you
> don't want to return 0 when an error is set. Even if we were return the
> right return value and errp content, it would be rather surprising to
> have an error set without jumping to an error label.
> 
> So we should either pass &local_err to nvme_identify() or make it return
> a success flag so we can run a proper error path.

You're right, that was dumb. :(

Paolo
