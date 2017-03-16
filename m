Received: from eggs.gnu.org ([2001:4830:134:3::10]:45684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cod4f-0004vv-VY
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 17:36:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cod4e-0002Ft-35
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 17:36:46 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:35310)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cod4d-0002FP-Ut
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 17:36:44 -0400
Received: by mail-qt0-x243.google.com with SMTP id r5so7437476qtb.2
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 14:36:43 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170315135021.6978-1-quintela@redhat.com>
	<20170315135021.6978-9-quintela@redhat.com>
	<20170316122616.GH2567@work-vm>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e62f7122-d15a-d5ee-0942-a501e07f280f@amsat.org>
Date: Thu, 16 Mar 2017 18:36:40 -0300
MIME-Version: 1.0
In-Reply-To: <20170316122616.GH2567@work-vm>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 08/31] ram: Move iterations_prev into
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
Cc: qemu-devel@nongnu.org

On 03/16/2017 09:26 AM, Dr. David Alan Gilbert wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  migration/ram.c | 13 ++++++-------
>>  1 file changed, 6 insertions(+), 7 deletions(-)
>>
>> diff --git a/migration/ram.c b/migration/ram.c
>> index ae077c5..6cdad06 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -157,6 +157,8 @@ struct RAMState {
>>      int64_t num_dirty_pages_period;
>>      /* xbzrle misses since the beggining of the period */
>>      uint64_t xbzrle_cache_miss_prev;
>> +    /* number of iterations at the beggining of period */
>                                          ^  ^
>                                          One extra g, one missing n
>
> Other than that,
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>> +    uint64_t iterations_prev;
>>  };
>>  typedef struct RAMState RAMState;
>>
>> @@ -602,16 +604,13 @@ static void migration_bitmap_sync_range(ram_addr_t start, ram_addr_t length)
>>          cpu_physical_memory_sync_dirty_bitmap(bitmap, start, length);
>>  }
>>
>> -/* Fix me: there are too many global variables used in migration process. */
>> -static uint64_t iterations_prev;
>> -
>>  static void migration_bitmap_sync_init(RAMState *rs)
>>  {
>>      rs->start_time = 0;
>>      rs->bytes_xfer_prev = 0;
>>      rs->num_dirty_pages_period = 0;
>>      rs->xbzrle_cache_miss_prev = 0;
>> -    iterations_prev = 0;
>> +    rs->iterations_prev = 0;
>>  }
>>
>>  /* Returns a summary bitmap of the page sizes of all RAMBlocks;
>> @@ -687,13 +686,13 @@ static void migration_bitmap_sync(RAMState *rs)
>>          }
>>
>>          if (migrate_use_xbzrle()) {
>> -            if (iterations_prev != acct_info.iterations) {
>> +            if (rs->iterations_prev != acct_info.iterations) {
>>                  acct_info.xbzrle_cache_miss_rate =
>>                     (double)(acct_info.xbzrle_cache_miss -
>>                              rs->xbzrle_cache_miss_prev) /
>> -                   (acct_info.iterations - iterations_prev);
>> +                   (acct_info.iterations - rs->iterations_prev);
>>              }
>> -            iterations_prev = acct_info.iterations;
>> +            rs->iterations_prev = acct_info.iterations;
>>              rs->xbzrle_cache_miss_prev = acct_info.xbzrle_cache_miss;
>>          }
>>          s->dirty_pages_rate = rs->num_dirty_pages_period * 1000
>> --
>> 2.9.3
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>
