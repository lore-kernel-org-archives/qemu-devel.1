Received: from eggs.gnu.org ([2001:4830:134:3::10]:56464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1gRWNf-00071E-3X
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 00:57:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1gRWNa-0007so-8c
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 00:57:55 -0500
Received: from mga07.intel.com ([134.134.136.100]:41194)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1gRWNa-0007sX-0B
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 00:57:50 -0500
Message-ID: <5BFCDE07.20707@intel.com>
Date: Tue, 27 Nov 2018 14:02:47 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1542276484-25508-1-git-send-email-wei.w.wang@intel.com>
	<1542276484-25508-4-git-send-email-wei.w.wang@intel.com>
	<20181127054056.GA3205@xz-x1>
In-Reply-To: <20181127054056.GA3205@xz-x1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v9 3/8] migration: use bitmap_mutex in
 migration_bitmap_clear_dirty
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, nilal@redhat.com, riel@redhat.com

On 11/27/2018 01:40 PM, Peter Xu wrote:
> On Thu, Nov 15, 2018 at 06:07:59PM +0800, Wei Wang wrote:
>> The bitmap mutex is used to synchronize threads to update the dirty
>> bitmap and the migration_dirty_pages counter. For example, the free
>> page optimization clears bits of free pages from the bitmap in an
>> iothread context. This patch makes migration_bitmap_clear_dirty update
>> the bitmap and counter under the mutex.
>>
>> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
>> CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> CC: Juan Quintela <quintela@redhat.com>
>> CC: Michael S. Tsirkin <mst@redhat.com>
>> CC: Peter Xu <peterx@redhat.com>
>> ---
>>   migration/ram.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/migration/ram.c b/migration/ram.c
>> index 7e7deec..ef69dbe 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -1556,11 +1556,14 @@ static inline bool migration_bitmap_clear_dirty(RAMState *rs,
>>   {
>>       bool ret;
>>   
>> +    qemu_mutex_lock(&rs->bitmap_mutex);
>>       ret = test_and_clear_bit(page, rb->bmap);
>>   
>>       if (ret) {
>>           rs->migration_dirty_pages--;
>>       }
>> +    qemu_mutex_unlock(&rs->bitmap_mutex);
>> +
>>       return ret;
>>   }
> It seems fine to me, but have you thought about
> test_and_clear_bit_atomic()?  Note that we just had
> test_and_set_bit_atomic() a few months ago.

Thanks for sharing. I think we might also need to
mutex migration_dirty_pages.

>
> And not related to this patch: I'm unclear on why we have had
> bitmap_mutex before, since it seems unnecessary.

OK. This is because with the optimization we have a thread
which clears bits (of free pages) from the bitmap and updates
migration_dirty_pages. So we need to synchronization between
the migration thread and the optimization thread.

Best,
Wei
