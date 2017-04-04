Received: from eggs.gnu.org ([2001:4830:134:3::10]:52334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cvSTl-0008Ax-3B
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 13:42:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cvSTh-0008Kc-VL
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 13:42:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60146)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cvSTh-0008KS-Mi
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 13:42:49 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 16EA461980
	for <qemu-devel@nongnu.org>; Tue,  4 Apr 2017 17:42:48 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170331165227.GP4514@work-vm> (David Alan Gilbert's message of
	"Fri, 31 Mar 2017 17:52:28 +0100")
References: <20170323204544.12015-1-quintela@redhat.com>
	<20170323204544.12015-31-quintela@redhat.com>
	<20170331165227.GP4514@work-vm>
Reply-To: quintela@redhat.com
Date: Tue, 04 Apr 2017 19:42:46 +0200
Message-ID: <87r3183w89.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 30/51] ram: Move src_page_req* to RAMState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> * Juan Quintela (quintela@redhat.com) wrote:

Hi

>> @@ -1191,19 +1204,18 @@ static bool get_queued_page(RAMState *rs, MigrationState *ms,
>>   *
>>   * It should be empty at the end anyway, but in error cases there may
>>   * xbe some left.
>> - *
>> - * @ms: current migration state
>>   */
>> -void flush_page_queue(MigrationState *ms)
>> +void flush_page_queue(void)
>
> I'm not sure this is safe;  it's called from migrate_fd_cleanup right at
> the end, if you do any finalisation/cleanup of the RAMState in
> ram_save_complete
> then when is it safe to run this?

But, looking into it, I think that we should be able to move this into
ram_save_cleanup() no?

We don't need it after that?
As an added bonus, we can remove the export of it.

>> @@ -1260,16 +1272,16 @@ int ram_save_queue_pages(MigrationState *ms, const char *rbname,
>>          goto err;
>>      }
>>  
>> -    struct MigrationSrcPageRequest *new_entry =
>> -        g_malloc0(sizeof(struct MigrationSrcPageRequest));
>> +    struct RAMSrcPageRequest *new_entry =
>> +        g_malloc0(sizeof(struct RAMSrcPageRequest));
>>      new_entry->rb = ramblock;
>>      new_entry->offset = start;
>>      new_entry->len = len;
>>  
>>      memory_region_ref(ramblock->mr);
>> -    qemu_mutex_lock(&ms->src_page_req_mutex);
>> -    QSIMPLEQ_INSERT_TAIL(&ms->src_page_requests, new_entry, next_req);
>> -    qemu_mutex_unlock(&ms->src_page_req_mutex);
>> +    qemu_mutex_lock(&rs->src_page_req_mutex);
>> +    QSIMPLEQ_INSERT_TAIL(&rs->src_page_requests, new_entry, next_req);
>> +    qemu_mutex_unlock(&rs->src_page_req_mutex);
>
> Hmm ok where did it get it's rs from?
> Anyway, the thing I needed to convince myself of was that there was
> any guarantee that
> RAMState would exist by the time the first request came in, something
> that we now need
> to be careful of.
> I think we're mostly OK; we call qemu_savevm_state_begin() at the top
> of migration_thread so the ram_save_setup should be done and allocate
> the RAMState before we get into the main loop and thus before we ever
> look at the 'start_postcopy' flag and thus before we ever ask the destination
> to send us stuff.
>
>>      rcu_read_unlock();
>>  
>>      return 0;
>> @@ -1408,7 +1420,7 @@ static int ram_find_and_save_block(RAMState *rs, QEMUFile *f, bool last_stage)
>>  
>>      do {
>>          again = true;
>> -        found = get_queued_page(rs, ms, &pss, &dirty_ram_abs);
>> +        found = get_queued_page(rs, &pss, &dirty_ram_abs);
>>  
>>          if (!found) {
>>              /* priority queue empty, so just search for something dirty */
>> @@ -1968,6 +1980,8 @@ static int ram_state_init(RAMState *rs)
>>  
>>      memset(rs, 0, sizeof(*rs));
>>      qemu_mutex_init(&rs->bitmap_mutex);
>> +    qemu_mutex_init(&rs->src_page_req_mutex);
>> +    QSIMPLEQ_INIT(&rs->src_page_requests);
>
> Similar question to above; that mutex is going to get reinit'd
> on a new migration and it shouldn't be without it being destroyed.
> Maybe make it a once.

good catch.  I think that the easiest way is to just move it into proper
RAMState, init it here, and destroy it at cleanup?

Later, Juan.
