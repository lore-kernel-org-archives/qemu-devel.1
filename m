Received: from eggs.gnu.org ([2001:4830:134:3::10]:59786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1d3Sz3-0007fP-KC
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 15:52:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1d3Syy-0007zD-OW
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 15:52:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60671)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1d3Syy-0007xi-F8
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 15:52:12 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3QJi2Kj012294
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 15:52:11 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a2ebvwfrv-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 15:52:10 -0400
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 26 Apr 2017 15:52:09 -0400
References: <20170426183721.7482-1-dgilbert@redhat.com>
	<20170426183721.7482-2-dgilbert@redhat.com>
	<8a107a40-073c-8181-75aa-e5700f2900a7@de.ibm.com>
	<20170426190442.GG2394@work-vm>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 26 Apr 2017 21:52:03 +0200
MIME-Version: 1.0
In-Reply-To: <20170426190442.GG2394@work-vm>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Message-Id: <a56800e0-53c5-8e30-4b6b-eaab088ad449@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] Postcopy: Force allocation of all-zero
 precopy pages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, aarcange@redhat.com
Cc: qemu-devel@nongnu.org, quintela@redhat.com, lvivier@redhat.com, peterx@redhat.com

On 04/26/2017 09:04 PM, Dr. David Alan Gilbert wrote:
> * Christian Borntraeger (borntraeger@de.ibm.com) wrote:
>> On 04/26/2017 08:37 PM, Dr. David Alan Gilbert (git) wrote:
>>> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>>>
>>> When an all-zero page is received during the precopy
>>> phase of a postcopy-enabled migration we must force
>>> allocation otherwise accesses to the page will still
>>> get blocked by userfault.
>>>
>>> Symptom:
>>>   a) If the page is accessed by a device during device-load
>>>     then we get a deadlock as the source finishes sending
>>>     all its pages but the destination device-load is still
>>>     paused and so doesn't clean up.
>>>
>>>   b) If the page is accessed later, then the thread will stay
>>>     paused until the end of migration rather than carrying on
>>>     running, until we release userfault at the end.
>>>
>>> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>>> Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>
>> CC stable? after all the guest hangs on both sides
>>
>> Has survived 40 migrations (usually failed at the 2nd)
>> Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>
> 
> Great...but.....
> Andrea (added to the mail) says this shouldn't be necessary.
> The read we were doing in the is_zero_range() should have been sufficient
> to get the page mapped and that zero page should have survived.

We do not do is_zero_range if ch==0 because of lazy evaluation, no?

> 
> So - I guess that's back a step, we need to figure out why the
> page disapepars for you.
> 
> Dave
> 
>>
>>> ---
>>>  include/migration/migration.h |  3 ++-
>>>  migration/ram.c               | 12 ++++++++----
>>>  migration/rdma.c              |  2 +-
>>>  3 files changed, 11 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/include/migration/migration.h b/include/migration/migration.h
>>> index ba1a16cbc1..b47904033c 100644
>>> --- a/include/migration/migration.h
>>> +++ b/include/migration/migration.h
>>> @@ -265,7 +265,8 @@ uint64_t xbzrle_mig_pages_overflow(void);
>>>  uint64_t xbzrle_mig_pages_cache_miss(void);
>>>  double xbzrle_mig_cache_miss_rate(void);
>>>
>>> -void ram_handle_compressed(void *host, uint8_t ch, uint64_t size);
>>> +void ram_handle_compressed(void *host, uint8_t ch, uint64_t size,
>>> +                           bool always_write);
>>>  void ram_debug_dump_bitmap(unsigned long *todump, bool expected);
>>>  /* For outgoing discard bitmap */
>>>  int ram_postcopy_send_discard_bitmap(MigrationState *ms);
>>> diff --git a/migration/ram.c b/migration/ram.c
>>> index f48664ec62..b4ed41c725 100644
>>> --- a/migration/ram.c
>>> +++ b/migration/ram.c
>>> @@ -2274,10 +2274,12 @@ static inline void *host_from_ram_block_offset(RAMBlock *block,
>>>   * @host: host address for the zero page
>>>   * @ch: what the page is filled from.  We only support zero
>>>   * @size: size of the zero page
>>> + * @always_write: Always perform the memset even if it's zero
>>>   */
>>> -void ram_handle_compressed(void *host, uint8_t ch, uint64_t size)
>>> +void ram_handle_compressed(void *host, uint8_t ch, uint64_t size,
>>> +                           bool always_write)
>>>  {
>>> -    if (ch != 0 || !is_zero_range(host, size)) {
>>> +    if (ch != 0 || always_write || !is_zero_range(host, size)) {
>>>          memset(host, ch, size);
>>>      }
>>>  }
>>> @@ -2514,7 +2516,8 @@ static int ram_load_postcopy(QEMUFile *f)
>>>          switch (flags & ~RAM_SAVE_FLAG_CONTINUE) {
>>>          case RAM_SAVE_FLAG_COMPRESS:
>>>              ch = qemu_get_byte(f);
>>> -            memset(page_buffer, ch, TARGET_PAGE_SIZE);
>>> +            ram_handle_compressed(page_buffer, ch, TARGET_PAGE_SIZE,
>>> +                                  true);
>>>              if (ch) {
>>>                  all_zero = false;
>>>              }
>>> @@ -2664,7 +2667,8 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
>>>
>>>          case RAM_SAVE_FLAG_COMPRESS:
>>>              ch = qemu_get_byte(f);
>>> -            ram_handle_compressed(host, ch, TARGET_PAGE_SIZE);
>>> +            ram_handle_compressed(host, ch, TARGET_PAGE_SIZE,
>>> +                                  postcopy_advised);
>>>              break;
>>>
>>>          case RAM_SAVE_FLAG_PAGE:
>>> diff --git a/migration/rdma.c b/migration/rdma.c
>>> index fe0a4b5a83..07a9bd75d8 100644
>>> --- a/migration/rdma.c
>>> +++ b/migration/rdma.c
>>> @@ -3164,7 +3164,7 @@ static int qemu_rdma_registration_handle(QEMUFile *f, void *opaque)
>>>              host_addr = block->local_host_addr +
>>>                              (comp->offset - block->offset);
>>>
>>> -            ram_handle_compressed(host_addr, comp->value, comp->length);
>>> +            ram_handle_compressed(host_addr, comp->value, comp->length, false);
>>>              break;
>>>
>>>          case RDMA_CONTROL_REGISTER_FINISHED:
>>>
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 
