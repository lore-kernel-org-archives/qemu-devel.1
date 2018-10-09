Received: from eggs.gnu.org ([2001:4830:134:3::10]:42595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1g9vVV-0001fp-75
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 13:09:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1g9vVP-0001rl-H2
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 13:09:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38870)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1g9vVN-0001q5-Ih
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 13:09:10 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6C42874F01
	for <qemu-devel@nongnu.org>; Tue,  9 Oct 2018 17:09:08 +0000 (UTC)
References: <1539093025-101599-1-git-send-email-imammedo@redhat.com>
	<9ccf4afa-3528-a336-3eb2-9fc516852e91@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <40220217-aa30-9436-22a8-9d1fca611d8e@redhat.com>
Date: Tue, 9 Oct 2018 19:09:06 +0200
MIME-Version: 1.0
In-Reply-To: <9ccf4afa-3528-a336-3eb2-9fc516852e91@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] memory: move MemoryRegion::size cleanup to
 memory_region_finalize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org

On 10/09/18 17:47, Paolo Bonzini wrote:
> On 09/10/2018 15:50, Igor Mammedov wrote:
>> It's not necessary to clean up MemoryRegion::size manually in multiple places
>> like it's been implemented in
>>  (1cd3d49262 "memory: cleanup side effects of  memory_region_init_foo() on failure")
>> since each memory_region_init_foo() now calls object_unparent(mr) on failure,
>> memory region destructor memory_region_finalize() will be called upon its
>> completion for each memory_region_init_foo().
>> It's sufficient to clean MemoryRegion::size only from memory_region_finalize(),
>> so do it.
> 
> Stupid question, why is it necessary to clear mr->size at all?...

IIRC it is explained in the above-mentioned, earlier commit 1cd3d49262:

> if MemoryRegion intialization fails it's left in semi-initialized state,
> where it's size is not 0 and attached as child to owner object.
> And this leds to crash in following use-case:
>     (monitor) object_add memory-backend-file,id=mem1,size=99999G,mem-path=/tmp/foo,discard-data=yes
>     memory.c:2083: memory_region_get_ram_ptr: Assertion `mr->ram_block' failed
>     Aborted (core dumped)
> it happens due to assumption that memory region is intialized when
>    memory_region_size() != 0
> and therefore it's ok to access it in
>    file_backend_unparent()
>       if (memory_region_size() != 0)
>           memory_region_get_ram_ptr()
> 
> which happens when object_add fails and unparents failed backend making
> file_backend_unparent() access invalid memory region.

I think it makes sense to zero out the size even if unparenting would, in itself, prevent the above crash. Because, in host_memory_backend_mr_inited(), we have:

    /*
     * NOTE: We forbid zero-length memory backend, so here zero means
     * "we haven't inited the backend memory region yet".
     */

I'm unsure how general that invariant is, but it can't hurt to honor it everywhere. (Especially if we can do the zeroing in one common place.)

Anyway, I should defer to Igor on this! :)

Thanks,
Laszlo

>>  memory.c | 7 +------
>>  1 file changed, 1 insertion(+), 6 deletions(-)
>>
>> diff --git a/memory.c b/memory.c
>> index d852f11..ad24b57 100644
>> --- a/memory.c
>> +++ b/memory.c
>> @@ -1491,7 +1491,6 @@ void memory_region_init_ram_shared_nomigrate(MemoryRegion *mr,
>>      mr->ram_block = qemu_ram_alloc(size, share, mr, &err);
>>      mr->dirty_log_mask = tcg_enabled() ? (1 << DIRTY_MEMORY_CODE) : 0;
>>      if (err) {
>> -        mr->size = int128_zero();
>>          object_unparent(OBJECT(mr));
>>          error_propagate(errp, err);
>>      }
>> @@ -1516,7 +1515,6 @@ void memory_region_init_resizeable_ram(MemoryRegion *mr,
>>                                                mr, &err);
>>      mr->dirty_log_mask = tcg_enabled() ? (1 << DIRTY_MEMORY_CODE) : 0;
>>      if (err) {
>> -        mr->size = int128_zero();
>>          object_unparent(OBJECT(mr));
>>          error_propagate(errp, err);
>>      }
>> @@ -1541,7 +1539,6 @@ void memory_region_init_ram_from_file(MemoryRegion *mr,
>>      mr->ram_block = qemu_ram_alloc_from_file(size, mr, ram_flags, path, &err);
>>      mr->dirty_log_mask = tcg_enabled() ? (1 << DIRTY_MEMORY_CODE) : 0;
>>      if (err) {
>> -        mr->size = int128_zero();
>>          object_unparent(OBJECT(mr));
>>          error_propagate(errp, err);
>>      }
>> @@ -1565,7 +1562,6 @@ void memory_region_init_ram_from_fd(MemoryRegion *mr,
>>                                             fd, &err);
>>      mr->dirty_log_mask = tcg_enabled() ? (1 << DIRTY_MEMORY_CODE) : 0;
>>      if (err) {
>> -        mr->size = int128_zero();
>>          object_unparent(OBJECT(mr));
>>          error_propagate(errp, err);
>>      }
>> @@ -1628,7 +1624,6 @@ void memory_region_init_rom_nomigrate(MemoryRegion *mr,
>>      mr->ram_block = qemu_ram_alloc(size, false, mr, &err);
>>      mr->dirty_log_mask = tcg_enabled() ? (1 << DIRTY_MEMORY_CODE) : 0;
>>      if (err) {
>> -        mr->size = int128_zero();
>>          object_unparent(OBJECT(mr));
>>          error_propagate(errp, err);
>>      }
>> @@ -1652,7 +1647,6 @@ void memory_region_init_rom_device_nomigrate(MemoryRegion *mr,
>>      mr->destructor = memory_region_destructor_ram;
>>      mr->ram_block = qemu_ram_alloc(size, false,  mr, &err);
>>      if (err) {
>> -        mr->size = int128_zero();
>>          object_unparent(OBJECT(mr));
>>          error_propagate(errp, err);
>>      }
>> @@ -1701,6 +1695,7 @@ static void memory_region_finalize(Object *obj)
>>      memory_region_clear_coalescing(mr);
>>      g_free((char *)mr->name);
>>      g_free(mr->ioeventfds);
>> +    mr->size = int128_zero();
>>  }
>>  
>>  Object *memory_region_owner(MemoryRegion *mr)
>>
> 
