Received: from eggs.gnu.org ([2001:4830:134:3::10]:46835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cod7x-0007SD-IZ
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 17:40:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cod7u-0004FL-FW
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 17:40:09 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:36229)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cod7u-0004Ed-BX
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 17:40:06 -0400
Received: by mail-qk0-x241.google.com with SMTP id n141so7701724qke.3
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 14:40:06 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170315135021.6978-1-quintela@redhat.com>
	<20170315135021.6978-15-quintela@redhat.com>
	<20170316200450.GP2567@work-vm>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c84dadd0-2d21-f085-74c1-95e23a334381@amsat.org>
Date: Thu, 16 Mar 2017 18:40:02 -0300
MIME-Version: 1.0
In-Reply-To: <20170316200450.GP2567@work-vm>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 14/31] ram: Move iterations into RAMState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org

On 03/16/2017 05:04 PM, Dr. David Alan Gilbert wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  migration/ram.c | 12 +++++++-----
>>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>>
>> diff --git a/migration/ram.c b/migration/ram.c
>> index 8caeb4f..234bdba 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -164,6 +164,8 @@ struct RAMState {
>>      uint64_t zero_pages;
>>      /* number of normal transferred pages */
>>      uint64_t norm_pages;
>> +    /* Iterations since start */
>> +    uint64_t iterations;
>>  };
>>  typedef struct RAMState RAMState;
>>
>> @@ -171,7 +173,6 @@ static RAMState ram_state;
>>
>>  /* accounting for migration statistics */
>>  typedef struct AccountingInfo {
>> -    uint64_t iterations;
>>      uint64_t xbzrle_bytes;
>>      uint64_t xbzrle_pages;
>>      uint64_t xbzrle_cache_miss;
>> @@ -668,13 +669,13 @@ static void migration_bitmap_sync(RAMState *rs)
>>          }
>>
>>          if (migrate_use_xbzrle()) {
>> -            if (rs->iterations_prev != acct_info.iterations) {
>> +            if (rs->iterations_prev != rs->iterations) {
>>                  acct_info.xbzrle_cache_miss_rate =
>>                     (double)(acct_info.xbzrle_cache_miss -
>>                              rs->xbzrle_cache_miss_prev) /
>> -                   (acct_info.iterations - rs->iterations_prev);
>> +                   (rs->iterations - rs->iterations_prev);
>>              }
>> -            rs->iterations_prev = acct_info.iterations;
>> +            rs->iterations_prev = rs->iterations;
>>              rs->xbzrle_cache_miss_prev = acct_info.xbzrle_cache_miss;
>>          }
>>          s->dirty_pages_rate = rs->num_dirty_pages_period * 1000
>> @@ -1926,6 +1927,7 @@ static int ram_save_init_globals(RAMState *rs)
>>      rs->bitmap_sync_count = 0;
>>      rs->zero_pages = 0;
>>      rs->norm_pages = 0;
>> +    rs->iterations = 0;
>>      migration_bitmap_sync_init(rs);
>>      qemu_mutex_init(&migration_bitmap_mutex);
>>
>> @@ -2066,7 +2068,7 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
>>              done = 1;
>>              break;
>>          }
>> -        acct_info.iterations++;
>> +        rs->iterations++;
>>
>>          /* we want to check in the 1st loop, just in case it was the 1st time
>>             and we had to sync the dirty bitmap.
>> --
>> 2.9.3
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>
