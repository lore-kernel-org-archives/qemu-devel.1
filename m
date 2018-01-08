Received: from eggs.gnu.org ([2001:4830:134:3::10]:45260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eYTug-0000RF-Kw
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 04:40:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eYTuc-0001VA-Kv
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 04:40:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60046)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eYTuc-0001UN-Ez
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 04:40:10 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6573580090
	for <qemu-devel@nongnu.org>; Mon,  8 Jan 2018 09:40:09 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20171017141854.GC2326@work-vm> (David Alan Gilbert's message of
	"Tue, 17 Oct 2017 15:18:55 +0100")
References: <20171004104636.7963-1-quintela@redhat.com>
	<20171004104636.7963-11-quintela@redhat.com>
	<20171017141854.GC2326@work-vm>
Reply-To: quintela@redhat.com
Date: Mon, 08 Jan 2018 10:40:02 +0100
Message-ID: <87a7xoadu5.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v9 10/12] migration: Transfer pages over
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
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
>> We switch for sending the page number to send real pages.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>
> I think this is OK if squashed with the 'test' patch to remove
> the test stuff.

Done.

>
> Some minor comments below.
>
>> --
>> 
>> Remove the HACK bit, now we have the function that calculates the size
>> of a page exported.
>> Rename multifd_pages{_now}, to sent pages
>> Remove multifd pages field, it is the same than normal pages
>> ---
>>  migration/migration.c |  7 ++++++-
>>  migration/ram.c       | 39 +++++++++++----------------------------
>>  2 files changed, 17 insertions(+), 29 deletions(-)
>> 
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 54ef095d82..1bd87a4e44 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -2085,6 +2085,7 @@ static void *migration_thread(void *opaque)
>>       */
>>      int64_t threshold_size = 0;
>>      int64_t qemu_file_bytes = 0;
>> +    int64_t sent_pages = 0;
>>      int64_t start_time = initial_time;
>>      int64_t end_time;
>>      bool old_vm_running = false;
>> @@ -2173,8 +2174,11 @@ static void *migration_thread(void *opaque)
>>          current_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
>>          if (current_time >= initial_time + BUFFER_DELAY) {
>>              uint64_t qemu_file_bytes_now = qemu_ftell(s->to_dst_file);
>> +            uint64_t sent_pages_now = ram_counters.normal;
>>              uint64_t transferred_bytes =
>> -                qemu_file_bytes_now - qemu_file_bytes;
>> +                (qemu_file_bytes_now - qemu_file_bytes) +
>> +                (sent_pages_now - sent_pages) *
>> +                qemu_target_page_size();
>
> This could do with commenting to explain the difference between the
> two sets of counts.

Rework it to make clear that multifd data is not sent through qemu file.

>> @@ -1288,8 +1270,10 @@ static int ram_multifd_page(RAMState *rs, PageSearchStatus *pss,
>>                               offset | RAM_SAVE_FLAG_MULTIFD_PAGE);
>>          fd_num = multifd_send_page(p, rs->migration_dirty_pages == 1);
>>          qemu_put_be16(rs->f, fd_num);
>> +        if (fd_num != MULTIFD_CONTINUE) {
>> +            qemu_fflush(rs->f);
>> +        }
>
> Could do with a comment.

Done.

Later, Juan.
