Received: from eggs.gnu.org ([2001:4830:134:3::10]:44242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cod1T-0002Yh-E8
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 17:33:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cod1S-0007xl-Dv
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 17:33:27 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:33247)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cod1S-0007xV-A6
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 17:33:26 -0400
Received: by mail-qk0-x242.google.com with SMTP id j127so7679521qke.0
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 14:33:26 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170315135021.6978-1-quintela@redhat.com>
	<20170315135021.6978-4-quintela@redhat.com>
	<20170316122119.GC2567@work-vm>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <56a66cc2-fe54-8ac7-dd95-8d66bf7b5b78@amsat.org>
Date: Thu, 16 Mar 2017 18:33:22 -0300
MIME-Version: 1.0
In-Reply-To: <20170316122119.GC2567@work-vm>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 03/31] ram: move bitmap_sync_count into
 RAMState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>
Cc: amit.shah@redhat.com, qemu-devel@nongnu.org

On 03/16/2017 09:21 AM, Dr. David Alan Gilbert wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>> ---
>>  migration/ram.c | 22 +++++++++++-----------
>>  1 file changed, 11 insertions(+), 11 deletions(-)
>>
>> diff --git a/migration/ram.c b/migration/ram.c
>> index 9120755..c0bee94 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -45,8 +45,6 @@
>>  #include "qemu/rcu_queue.h"
>>  #include "migration/colo.h"
>>
>> -static uint64_t bitmap_sync_count;
>> -
>>  /***********************************************************/
>>  /* ram save/restore */
>>
>> @@ -148,6 +146,8 @@ struct RAMState {
>>      bool ram_bulk_stage;
>>      /* How many times we have dirty too many pages */
>>      int dirty_rate_high_cnt;
>> +    /* How many times we have synchronized the bitmap */
>> +    uint64_t bitmap_sync_count;
>>  };
>>  typedef struct RAMState RAMState;
>>
>> @@ -455,7 +455,7 @@ static void xbzrle_cache_zero_page(RAMState *rs, ram_addr_t current_addr)
>>      /* We don't care if this fails to allocate a new cache page
>>       * as long as it updated an old one */
>>      cache_insert(XBZRLE.cache, current_addr, ZERO_TARGET_PAGE,
>> -                 bitmap_sync_count);
>> +                 rs->bitmap_sync_count);
>>  }
>>
>>  #define ENCODING_FLAG_XBZRLE 0x1
>> @@ -475,7 +475,7 @@ static void xbzrle_cache_zero_page(RAMState *rs, ram_addr_t current_addr)
>>   * @last_stage: if we are at the completion stage
>>   * @bytes_transferred: increase it with the number of transferred bytes
>>   */
>> -static int save_xbzrle_page(QEMUFile *f, uint8_t **current_data,
>> +static int save_xbzrle_page(QEMUFile *f, RAMState *rs, uint8_t **current_data,
>>                              ram_addr_t current_addr, RAMBlock *block,
>>                              ram_addr_t offset, bool last_stage,
>>                              uint64_t *bytes_transferred)
>> @@ -483,11 +483,11 @@ static int save_xbzrle_page(QEMUFile *f, uint8_t **current_data,
>>      int encoded_len = 0, bytes_xbzrle;
>>      uint8_t *prev_cached_page;
>>
>> -    if (!cache_is_cached(XBZRLE.cache, current_addr, bitmap_sync_count)) {
>> +    if (!cache_is_cached(XBZRLE.cache, current_addr, rs->bitmap_sync_count)) {
>>          acct_info.xbzrle_cache_miss++;
>>          if (!last_stage) {
>>              if (cache_insert(XBZRLE.cache, current_addr, *current_data,
>> -                             bitmap_sync_count) == -1) {
>> +                             rs->bitmap_sync_count) == -1) {
>>                  return -1;
>>              } else {
>>                  /* update *current_data when the page has been
>> @@ -634,7 +634,7 @@ static void migration_bitmap_sync(RAMState *rs)
>>      int64_t end_time;
>>      int64_t bytes_xfer_now;
>>
>> -    bitmap_sync_count++;
>> +    rs->bitmap_sync_count++;
>>
>>      if (!bytes_xfer_prev) {
>>          bytes_xfer_prev = ram_bytes_transferred();
>> @@ -697,9 +697,9 @@ static void migration_bitmap_sync(RAMState *rs)
>>          start_time = end_time;
>>          num_dirty_pages_period = 0;
>>      }
>> -    s->dirty_sync_count = bitmap_sync_count;
>> +    s->dirty_sync_count = rs->bitmap_sync_count;
>>      if (migrate_use_events()) {
>> -        qapi_event_send_migration_pass(bitmap_sync_count, NULL);
>> +        qapi_event_send_migration_pass(rs->bitmap_sync_count, NULL);
>>      }
>>  }
>>
>> @@ -806,7 +806,7 @@ static int ram_save_page(RAMState *rs, MigrationState *ms, QEMUFile *f,
>>              ram_release_pages(ms, block->idstr, pss->offset, pages);
>>          } else if (!rs->ram_bulk_stage &&
>>                     !migration_in_postcopy(ms) && migrate_use_xbzrle()) {
>> -            pages = save_xbzrle_page(f, &p, current_addr, block,
>> +            pages = save_xbzrle_page(f, rs, &p, current_addr, block,
>>                                       offset, last_stage, bytes_transferred);
>>              if (!last_stage) {
>>                  /* Can't send this cached data async, since the cache page
>> @@ -1936,7 +1936,7 @@ static int ram_save_init_globals(RAMState *rs)
>>      int64_t ram_bitmap_pages; /* Size of bitmap in pages, including gaps */
>>
>>      rs->dirty_rate_high_cnt = 0;
>> -    bitmap_sync_count = 0;
>> +    rs->bitmap_sync_count = 0;
>>      migration_bitmap_sync_init();
>>      qemu_mutex_init(&migration_bitmap_mutex);
>>
>> --
>> 2.9.3
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>
