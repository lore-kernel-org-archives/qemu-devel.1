Received: from eggs.gnu.org ([2001:4830:134:3::10]:34186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e4jyl-0005CJ-JT
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 04:45:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e4jyi-0007Z8-IQ
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 04:45:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37706)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1e4jyi-0007YV-Bt
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 04:45:28 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4BD667EA8D
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 08:45:27 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20171012055709.GF30901@pxdev.xzpeter.org> (Peter Xu's message of
	"Thu, 12 Oct 2017 13:57:09 +0800")
References: <20171010181542.24168-1-quintela@redhat.com>
	<20171010181542.24168-7-quintela@redhat.com>
	<20171012055709.GF30901@pxdev.xzpeter.org>
Reply-To: quintela@redhat.com
Date: Wed, 18 Oct 2017 10:45:22 +0200
Message-ID: <87d15kondp.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 06/10] migration: Make sure that we pass
 the right cache size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, lvivier@redhat.com

Peter Xu <peterx@redhat.com> wrote:
> On Tue, Oct 10, 2017 at 08:15:38PM +0200, Juan Quintela wrote:
>> Instead of passing silently round down the number of pages, make it an
>> error that the cache size is not a multiple of 2.
>
> s/multiple/power/?

Thanks.

> Would this patch break existing users?

I have a problem here. Current code:
- "silently" truncate the value that we pass
- "silently" uses a different value that the one that it shows as used
- "shows" a value that is different of what has been set to

So, I have to break one of them:
- only allow valid values (and then we output the same value that user
  input)
- store "setup" value, and use something different "internaly"

No clear winner.  This way we are at least consistent with everything
else.  Documentation already required a power of 2 value.  And we give a
good error message.

Later, Juan.


>
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  migration/page_cache.c | 12 +++++++-----
>>  1 file changed, 7 insertions(+), 5 deletions(-)
>> 
>> diff --git a/migration/page_cache.c b/migration/page_cache.c
>> index 9a9d13d6a2..96268c3aea 100644
>> --- a/migration/page_cache.c
>> +++ b/migration/page_cache.c
>> @@ -58,6 +58,13 @@ PageCache *cache_init(int64_t new_size, size_t page_size, Error **errp)
>>          return NULL;
>>      }
>>  
>> +    /* round down to the nearest power of 2 */
>> +    if (!is_power_of_2(num_pages)) {
>> +        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "cache size",
>> +                   "is not a power of two number of pages");
>> +        return NULL;
>> +    }
>> +
>>      /* We prefer not to abort if there is no memory */
>>      cache = g_try_malloc(sizeof(*cache));
>>      if (!cache) {
>> @@ -65,11 +72,6 @@ PageCache *cache_init(int64_t new_size, size_t page_size, Error **errp)
>>                     "Failed to allocate cache");
>>          return NULL;
>>      }
>> -    /* round down to the nearest power of 2 */
>> -    if (!is_power_of_2(num_pages)) {
>> -        num_pages = pow2floor(num_pages);
>> -        DPRINTF("rounding down to %" PRId64 "\n", num_pages);
>> -    }
>>      cache->page_size = page_size;
>>      cache->num_items = 0;
>>      cache->max_num_items = num_pages;
>> -- 
>> 2.13.6
>> 
