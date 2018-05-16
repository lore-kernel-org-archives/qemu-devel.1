Received: from eggs.gnu.org ([2001:4830:134:3::10]:59139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1fIwih-0006im-Mv
	for qemu-devel@nongnu.org; Wed, 16 May 2018 09:43:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1fIwie-0007A3-Bw
	for qemu-devel@nongnu.org; Wed, 16 May 2018 09:43:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50772 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1fIwie-00079f-77
	for qemu-devel@nongnu.org; Wed, 16 May 2018 09:43:52 -0400
References: <20180425071040.25542-1-bala24@linux.vnet.ibm.com>
	<20180425071040.25542-2-bala24@linux.vnet.ibm.com>
	<20180501143737.GA25113@9.122.211.20>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <d4e1788d-64c9-4b43-5fd6-4008b616362e@redhat.com>
Date: Wed, 16 May 2018 15:43:48 +0200
MIME-Version: 1.0
In-Reply-To: <20180501143737.GA25113@9.122.211.20>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/1] migration: calculate
 expected_downtime with ram_bytes_remaining()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Balamuruhan S <bala24@linux.vnet.ibm.com>, dgilbert@redhat.com, quintela@redhat.com, david@gibson.dropbear.id.au
Cc: qemu-devel@nongnu.org

Hi Bala,

I've tested you patch migrating a pseries between a P9 host and a P8
host with 1G huge page size on the P9 side and 16MB on P8 side and the
information are strange now.

"remaining ram" doesn't change, and after a while it can be set to "0"
and estimated downtime is 0 too, but the migration is not completed and
"transferred ram" continues to increase.

so think there is a problem somewhere...

thanks,
Laurent

On 01/05/2018 16:37, Balamuruhan S wrote:
> Hi,
> 
> Dave, David and Juan if you guys are okay with the patch, please
> help to merge it.
> 
> Thanks,
> Bala
> 
> On Wed, Apr 25, 2018 at 12:40:40PM +0530, Balamuruhan S wrote:
>> expected_downtime value is not accurate with dirty_pages_rate * page_size,
>> using ram_bytes_remaining would yeild it correct. It will initially be a
>> gross over-estimate, but for for non-converging migrations it should
>> approach a reasonable estimate later on.
>>
>> currently bandwidth and expected_downtime value are calculated in
>> migration_update_counters() during each iteration from
>> migration_thread(), where as remaining ram is calculated in
>> qmp_query_migrate() when we actually call "info migrate". Due to this
>> there is some difference in expected_downtime value being calculated.
>>
>> with this patch bandwidth, expected_downtime and remaining ram are
>> calculated in migration_update_counters(), retrieve the same value during
>> "info migrate". By this approach we get almost close enough value.
>>
>> Reported-by: Michael Roth <mdroth@linux.vnet.ibm.com>
>> Signed-off-by: Balamuruhan S <bala24@linux.vnet.ibm.com>
>> ---
>>  migration/migration.c | 11 ++++++++---
>>  migration/migration.h |  1 +
>>  2 files changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 52a5092add..5d721ee481 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -614,7 +614,7 @@ static void populate_ram_info(MigrationInfo *info, MigrationState *s)
>>      }
>>
>>      if (s->state != MIGRATION_STATUS_COMPLETED) {
>> -        info->ram->remaining = ram_bytes_remaining();
>> +        info->ram->remaining = s->ram_bytes_remaining;
>>          info->ram->dirty_pages_rate = ram_counters.dirty_pages_rate;
>>      }
>>  }
>> @@ -2227,6 +2227,7 @@ static void migration_update_counters(MigrationState *s,
>>      transferred = qemu_ftell(s->to_dst_file) - s->iteration_initial_bytes;
>>      time_spent = current_time - s->iteration_start_time;
>>      bandwidth = (double)transferred / time_spent;
>> +    s->ram_bytes_remaining = ram_bytes_remaining();
>>      s->threshold_size = bandwidth * s->parameters.downtime_limit;
>>
>>      s->mbps = (((double) transferred * 8.0) /
>> @@ -2237,8 +2238,12 @@ static void migration_update_counters(MigrationState *s,
>>       * recalculate. 10000 is a small enough number for our purposes
>>       */
>>      if (ram_counters.dirty_pages_rate && transferred > 10000) {
>> -        s->expected_downtime = ram_counters.dirty_pages_rate *
>> -            qemu_target_page_size() / bandwidth;
>> +        /*
>> +         * It will initially be a gross over-estimate, but for for
>> +         * non-converging migrations it should approach a reasonable estimate
>> +         * later on
>> +         */
>> +        s->expected_downtime = s->ram_bytes_remaining / bandwidth;
>>      }
>>
>>      qemu_file_reset_rate_limit(s->to_dst_file);
>> diff --git a/migration/migration.h b/migration/migration.h
>> index 8d2f320c48..8584f8e22e 100644
>> --- a/migration/migration.h
>> +++ b/migration/migration.h
>> @@ -128,6 +128,7 @@ struct MigrationState
>>      int64_t downtime_start;
>>      int64_t downtime;
>>      int64_t expected_downtime;
>> +    int64_t ram_bytes_remaining;
>>      bool enabled_capabilities[MIGRATION_CAPABILITY__MAX];
>>      int64_t setup_time;
>>      /*
>> -- 
>> 2.14.3
>>
>>
> 
> 
