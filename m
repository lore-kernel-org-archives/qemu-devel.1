Received: from eggs.gnu.org ([2001:4830:134:3::10]:59874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fanc.fnst@cn.fujitsu.com>) id 1cnmaF-0007zu-Bf
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 09:33:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fanc.fnst@cn.fujitsu.com>) id 1cnmaC-0008K7-38
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 09:33:51 -0400
Received: from [59.151.112.132] (port=42365 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fanc.fnst@cn.fujitsu.com>) id 1cnmaB-0008JY-4X
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 09:33:48 -0400
Date: Tue, 14 Mar 2017 21:33:13 +0800
From: Chao Fan <fanc.fnst@cn.fujitsu.com>
Message-ID: <20170314133313.GC2473@localhost.localdomain>
References: <20170314102747.31395-1-fanc.fnst@cn.fujitsu.com>
	<87o9x4t51k.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87o9x4t51k.fsf@secure.mitica>
Subject: Re: [Qemu-devel] [PATCH] Output dirty-bytes-rate instead of
 dirty-pages-rate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: eblake@redhat.com, dgilbert@redhat.com, qemu-devel@nongnu.org, berrange@redhat.com, caoj.fnst@cn.fujitsu.com, douly.fnst@cn.fujitsu.com, maozy.fnst@cn.fujitsu.com, Li Zhijian <lizhijian@cn.fujitsu.com>

On Tue, Mar 14, 2017 at 01:29:43PM +0100, Juan Quintela wrote:
>Chao Fan <fanc.fnst@cn.fujitsu.com> wrote:
>> In hmp, dirty-bytes-rate is more friendly than dirty-pages-rate.
>> It's also better for other tools to determine the cpu throttle
>> value in different architecture.
>>
>> Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
>> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
>
>I agree with Daniel here, you can't change the meaning of a field.  Look
>at skipped pages.  It is zero know because it is not used anymore, but
>we can't drop it.

OK, I see.
Thank you very much.

>
>I think it is better to expose page_size.  We have now
>
>trasferred: bytes
>total: bytes
>duplicate: number of zero pages
>skipped: always zero.
>normal: number of normal pages
>normal_bytes: the same  in bytes
>mbps: megabytes per second?  I can't even remember this one
>dirty_sync_count: number of times we have go through the whole memory
>postcopy_requests = number of pages asked by postcopy faults?
>dirty_pages_rate = pages by some kind of unit
>
>And we haven't yet started with compression or xbzrle.  I think that the
>best approach at this point is putting everything in pages except the
>things that don't make sense.
>
>We can put everything on bytes, but then everything is HUGE.

Yes, it is.

>
>Anyways, what do libvirt/management apps preffer?

I think maybe both are OK.
About this issue, I will change my method to get the bytes.

Many thanks for your reply.

Thanks,
Chao Fan
>
>Later, Juan.
>
>
>> ---
>>  hmp.c                 | 6 +++---
>>  migration/migration.c | 2 +-
>>  qapi-schema.json      | 8 ++++----
>>  3 files changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/hmp.c b/hmp.c
>> index 261843f..7334bc5 100644
>> --- a/hmp.c
>> +++ b/hmp.c
>> @@ -215,9 +215,9 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
>>                         info->ram->normal_bytes >> 10);
>>          monitor_printf(mon, "dirty sync count: %" PRIu64 "\n",
>>                         info->ram->dirty_sync_count);
>> -        if (info->ram->dirty_pages_rate) {
>> -            monitor_printf(mon, "dirty pages rate: %" PRIu64 " pages\n",
>> -                           info->ram->dirty_pages_rate);
>> +        if (info->ram->dirty_bytes_rate) {
>> +            monitor_printf(mon, "dirty bytes rate: %" PRIu64 " bytes/s\n",
>> +                           info->ram->dirty_bytes_rate);
>>          }
>>          if (info->ram->postcopy_requests) {
>>              monitor_printf(mon, "postcopy request count: %" PRIu64 "\n",
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 3dab684..7e7b62c 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -648,7 +648,7 @@ static void populate_ram_info(MigrationInfo *info, MigrationState *s)
>>  
>>      if (s->state != MIGRATION_STATUS_COMPLETED) {
>>          info->ram->remaining = ram_bytes_remaining();
>> -        info->ram->dirty_pages_rate = s->dirty_pages_rate;
>> +        info->ram->dirty_bytes_rate = s->dirty_bytes_rate;
>>      }
>>  }
>>  
>> diff --git a/qapi-schema.json b/qapi-schema.json
>> index 32b4a4b..83a45f8 100644
>> --- a/qapi-schema.json
>> +++ b/qapi-schema.json
>> @@ -565,9 +565,6 @@
>>  #
>>  # @normal-bytes: number of normal bytes sent (since 1.2)
>>  #
>> -# @dirty-pages-rate: number of pages dirtied by second by the
>> -#        guest (since 1.3)
>> -#
>>  # @mbps: throughput in megabits/sec. (since 1.6)
>>  #
>>  # @dirty-sync-count: number of times that dirty ram was synchronized (since 2.1)
>> @@ -575,12 +572,15 @@
>>  # @postcopy-requests: The number of page requests received from the destination
>>  #        (since 2.7)
>>  #
>> +# @dirty-bytes-rate: how many bytes  dirtied by second by the
>> +#        guest (since 2.9)
>> +#
>>  # Since: 0.14.0
>>  ##
>>  { 'struct': 'MigrationStats',
>>    'data': {'transferred': 'int', 'remaining': 'int', 'total': 'int' ,
>>             'duplicate': 'int', 'skipped': 'int', 'normal': 'int',
>> -           'normal-bytes': 'int', 'dirty-pages-rate' : 'int',
>> +           'normal-bytes': 'int', 'dirty-bytes-rate' : 'int',
>>             'mbps' : 'number', 'dirty-sync-count' : 'int',
>>             'postcopy-requests' : 'int' } }
>
>
