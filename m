Received: from eggs.gnu.org ([2001:4830:134:3::10]:44651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cod2R-0003Hx-Au
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 17:34:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cod2P-0000PC-54
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 17:34:27 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:34976)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cod2P-0000OX-1B
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 17:34:25 -0400
Received: by mail-qk0-x241.google.com with SMTP id o135so7678223qke.2
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 14:34:24 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170315135021.6978-1-quintela@redhat.com>
	<20170315135021.6978-6-quintela@redhat.com>
	<20170316122231.GE2567@work-vm>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c60faf74-bbd4-bb8f-b489-8b743ec69602@amsat.org>
Date: Thu, 16 Mar 2017 18:34:21 -0300
MIME-Version: 1.0
In-Reply-To: <20170316122231.GE2567@work-vm>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 05/31] ram: Move bytes_xfer_prev into
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

On 03/16/2017 09:22 AM, Dr. David Alan Gilbert wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>> ---
>>  migration/ram.c | 13 +++++++------
>>  1 file changed, 7 insertions(+), 6 deletions(-)
>>
>> diff --git a/migration/ram.c b/migration/ram.c
>> index f6ac503..2d288cc 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -151,6 +151,8 @@ struct RAMState {
>>      /* this variables are used for bitmap sync */
>>      /* last time we did a full bitmap_sync */
>>      int64_t start_time;
>> +    /* bytes transferred at start_time */
>> +    int64_t bytes_xfer_prev;
>>  };
>>  typedef struct RAMState RAMState;
>>
>> @@ -597,7 +599,6 @@ static void migration_bitmap_sync_range(ram_addr_t start, ram_addr_t length)
>>  }
>>
>>  /* Fix me: there are too many global variables used in migration process. */
>> -static int64_t bytes_xfer_prev;
>>  static int64_t num_dirty_pages_period;
>>  static uint64_t xbzrle_cache_miss_prev;
>>  static uint64_t iterations_prev;
>> @@ -605,7 +606,7 @@ static uint64_t iterations_prev;
>>  static void migration_bitmap_sync_init(RAMState *rs)
>>  {
>>      rs->start_time = 0;
>> -    bytes_xfer_prev = 0;
>> +    rs->bytes_xfer_prev = 0;
>>      num_dirty_pages_period = 0;
>>      xbzrle_cache_miss_prev = 0;
>>      iterations_prev = 0;
>> @@ -638,8 +639,8 @@ static void migration_bitmap_sync(RAMState *rs)
>>
>>      rs->bitmap_sync_count++;
>>
>> -    if (!bytes_xfer_prev) {
>> -        bytes_xfer_prev = ram_bytes_transferred();
>> +    if (!rs->bytes_xfer_prev) {
>> +        rs->bytes_xfer_prev = ram_bytes_transferred();
>>      }
>>
>>      if (!rs->start_time) {
>> @@ -674,13 +675,13 @@ static void migration_bitmap_sync(RAMState *rs)
>>
>>              if (s->dirty_pages_rate &&
>>                 (num_dirty_pages_period * TARGET_PAGE_SIZE >
>> -                   (bytes_xfer_now - bytes_xfer_prev)/2) &&
>> +                   (bytes_xfer_now - rs->bytes_xfer_prev)/2) &&
>>                 (rs->dirty_rate_high_cnt++ >= 2)) {
>>                      trace_migration_throttle();
>>                      rs->dirty_rate_high_cnt = 0;
>>                      mig_throttle_guest_down();
>>               }
>> -             bytes_xfer_prev = bytes_xfer_now;
>> +             rs->bytes_xfer_prev = bytes_xfer_now;
>>          }
>>
>>          if (migrate_use_xbzrle()) {
>> --
>> 2.9.3
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>
