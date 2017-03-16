Received: from eggs.gnu.org ([2001:4830:134:3::10]:45459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cod40-0004Ub-LW
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 17:36:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cod3x-0001b7-FD
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 17:36:04 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:35138)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cod3x-0001al-AT
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 17:36:01 -0400
Received: by mail-qk0-x243.google.com with SMTP id o135so7683278qke.2
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 14:36:01 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170315135021.6978-1-quintela@redhat.com>
	<20170315135021.6978-8-quintela@redhat.com>
	<20170316122455.GG2567@work-vm>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <681d0d92-8506-3b93-3af0-1d34504fa976@amsat.org>
Date: Thu, 16 Mar 2017 18:35:57 -0300
MIME-Version: 1.0
In-Reply-To: <20170316122455.GG2567@work-vm>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 07/31] ram: Move xbzrle_cache_miss_prev
 into RAMState
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

On 03/16/2017 09:24 AM, Dr. David Alan Gilbert wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  migration/ram.c | 9 +++++----
>>  1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/migration/ram.c b/migration/ram.c
>> index b13d2d5..ae077c5 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -155,6 +155,8 @@ struct RAMState {
>>      int64_t bytes_xfer_prev;
>>      /* number of dirty pages since start_time */
>>      int64_t num_dirty_pages_period;
>> +    /* xbzrle misses since the beggining of the period */
>                                     ^--- extra g
>
> Other than that,
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>> +    uint64_t xbzrle_cache_miss_prev;
>>  };
>>  typedef struct RAMState RAMState;
>>
>> @@ -601,7 +603,6 @@ static void migration_bitmap_sync_range(ram_addr_t start, ram_addr_t length)
>>  }
>>
>>  /* Fix me: there are too many global variables used in migration process. */
>> -static uint64_t xbzrle_cache_miss_prev;
>>  static uint64_t iterations_prev;
>>
>>  static void migration_bitmap_sync_init(RAMState *rs)
>> @@ -609,7 +610,7 @@ static void migration_bitmap_sync_init(RAMState *rs)
>>      rs->start_time = 0;
>>      rs->bytes_xfer_prev = 0;
>>      rs->num_dirty_pages_period = 0;
>> -    xbzrle_cache_miss_prev = 0;
>> +    rs->xbzrle_cache_miss_prev = 0;
>>      iterations_prev = 0;
>>  }
>>
>> @@ -689,11 +690,11 @@ static void migration_bitmap_sync(RAMState *rs)
>>              if (iterations_prev != acct_info.iterations) {
>>                  acct_info.xbzrle_cache_miss_rate =
>>                     (double)(acct_info.xbzrle_cache_miss -
>> -                            xbzrle_cache_miss_prev) /
>> +                            rs->xbzrle_cache_miss_prev) /
>>                     (acct_info.iterations - iterations_prev);
>>              }
>>              iterations_prev = acct_info.iterations;
>> -            xbzrle_cache_miss_prev = acct_info.xbzrle_cache_miss;
>> +            rs->xbzrle_cache_miss_prev = acct_info.xbzrle_cache_miss;
>>          }
>>          s->dirty_pages_rate = rs->num_dirty_pages_period * 1000
>>              / (end_time - rs->start_time);
>> --
>> 2.9.3
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>
