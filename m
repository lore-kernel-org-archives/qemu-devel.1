Received: from eggs.gnu.org ([2001:4830:134:3::10]:32868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1df2SH-000156-Ct
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 07:13:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1df2SE-0007Cc-5l
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 07:13:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37248)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1df2SD-0007Bw-S9
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 07:13:42 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E56567C838
	for <qemu-devel@nongnu.org>; Tue,  8 Aug 2017 11:13:40 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170720113113.GF2101@work-vm> (David Alan Gilbert's message of
	"Thu, 20 Jul 2017 12:31:14 +0100")
References: <20170717134238.1966-1-quintela@redhat.com>
	<20170717134238.1966-17-quintela@redhat.com>
	<20170720113113.GF2101@work-vm>
Reply-To: quintela@redhat.com
Date: Tue, 08 Aug 2017 13:13:36 +0200
Message-ID: <87k22e9usf.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v5 16/17] migration: Transfer pages over
 new channels
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com, berrange@redhat.com

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
>> We switch for sending the page number to send real pages.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> 
>> --
>> 
>> Remove the HACK bit, now we have the function that calculates the size
>> of a page exported.
>> ---
>>  migration/migration.c | 14 ++++++++----
>>  migration/ram.c       | 59 +++++++++++++++++----------------------------------
>>  2 files changed, 29 insertions(+), 44 deletions(-)
>> 
>> diff --git a/migration/migration.c b/migration/migration.c
>> index e122684..34a34b7 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -1882,13 +1882,14 @@ static void *migration_thread(void *opaque)
>>      /* Used by the bandwidth calcs, updated later */
>>      int64_t initial_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
>>      int64_t setup_start = qemu_clock_get_ms(QEMU_CLOCK_HOST);
>> -    int64_t initial_bytes = 0;
>>      /*
>>       * The final stage happens when the remaining data is smaller than
>>       * this threshold; it's calculated from the requested downtime and
>>       * measured bandwidth
>>       */
>>      int64_t threshold_size = 0;
>> +    int64_t qemu_file_bytes = 0;
>> +    int64_t multifd_pages = 0;
>
> It feels like these changes to the transfer count should be in a
> separate patch.

Until this patch, we only sent the address number for testing purposes,
we can change it in the previous patch.  I can split the
qemu_file_bytes, though.

>>      int64_t start_time = initial_time;
>>      int64_t end_time;
>>      bool old_vm_running = false;
>> @@ -1976,9 +1977,13 @@ static void *migration_thread(void *opaque)
>>          }
>>          current_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
>>          if (current_time >= initial_time + BUFFER_DELAY) {
>> -            uint64_t transferred_bytes = qemu_ftell(s->to_dst_file) -
>> -                                         initial_bytes;
>>              uint64_t time_spent = current_time - initial_time;
>> +            uint64_t qemu_file_bytes_now = qemu_ftell(s->to_dst_file);
>> +            uint64_t multifd_pages_now = ram_counters.multifd;
>> +            uint64_t transferred_bytes =
>> +                (qemu_file_bytes_now - qemu_file_bytes) +
>> +                (multifd_pages_now - multifd_pages) *
>> +                qemu_target_page_size();
>
> If I've followed this right, then ram_counters.multifd is in the main
> thread not the individual threads, so we should be OK doing that.

Yeap.

>
>>              double bandwidth = (double)transferred_bytes / time_spent;
>>              threshold_size = bandwidth * s->parameters.downtime_limit;
>>  
>> @@ -1996,7 +2001,8 @@ static void *migration_thread(void *opaque)
>>  
>>              qemu_file_reset_rate_limit(s->to_dst_file);
>>              initial_time = current_time;
>> -            initial_bytes = qemu_ftell(s->to_dst_file);
>> +            qemu_file_bytes = qemu_file_bytes_now;
>> +            multifd_pages = multifd_pages_now;
>>          }
>>          if (qemu_file_rate_limit(s->to_dst_file)) {
>>              /* usleep expects microseconds */
>> diff --git a/migration/ram.c b/migration/ram.c
>> index b55b243..c78b286 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -468,25 +468,21 @@ static void *multifd_send_thread(void *opaque)
>>              break;
>>          }
>>          if (p->pages.num) {
>> -            int i;
>>              int num;
>>  
>>              num = p->pages.num;
>>              p->pages.num = 0;
>>              qemu_mutex_unlock(&p->mutex);
>>  
>> -            for (i = 0; i < num; i++) {
>> -                if (qio_channel_write(p->c,
>> -                                      (const char *)&p->pages.iov[i].iov_base,
>> -                                      sizeof(uint8_t *), &error_abort)
>> -                    != sizeof(uint8_t *)) {
>> -                    MigrationState *s = migrate_get_current();
>> +            if (qio_channel_writev_all(p->c, p->pages.iov,
>> +                                       num, &error_abort)
>> +                != num * TARGET_PAGE_SIZE) {
>> +                MigrationState *s = migrate_get_current();
>
> Same comments as previous patch; note we should find a way to get
> the error message logged; not easy since we're in a thread, but
> we need to find a way to log the errors.

I am open to suggestions how to set errors in a different thread.

>> @@ -1262,8 +1240,10 @@ static int ram_multifd_page(RAMState *rs, PageSearchStatus *pss,
>>                               offset | RAM_SAVE_FLAG_MULTIFD_PAGE);
>>          fd_num = multifd_send_page(p, rs->migration_dirty_pages == 1);
>>          qemu_put_be16(rs->f, fd_num);
>> +        if (fd_num != UINT16_MAX) {
>> +            qemu_fflush(rs->f);
>> +        }
>
> Is that to make sure that the relatively small messages actually get
> transmitted on the main fd so that the destination starts receiving
> them?

Yeap.

> I do have a worry there that, since the addresses are going down a
> single fd we are open to deadlock by the send threads filling up
> buffers and blocking waiting for the receivers to receive.

I think we are doing the intelligent case here.
We only sync when we are sure that the package has finished, so we
should be ok here.  If we finish the migration, we call fflush anyways on
other places, so we can't get stuck as far as I can see.

Later, Juan.
