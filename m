Received: from eggs.gnu.org ([2001:4830:134:3::10]:56437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e6eie-0001pc-HV
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 11:32:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e6eib-0003Ha-Do
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 11:32:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50450)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1e6eib-0003HG-5x
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 11:32:45 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 033384E906
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 15:32:44 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20171023143242.GD2522@work-vm> (David Alan Gilbert's message of
	"Mon, 23 Oct 2017 15:32:42 +0100")
References: <20171018103633.5549-1-quintela@redhat.com>
	<20171018103633.5549-9-quintela@redhat.com>
	<20171023143242.GD2522@work-vm>
Reply-To: quintela@redhat.com
Date: Mon, 23 Oct 2017 17:32:38 +0200
Message-ID: <87wp3l98x5.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 08/10] migration: No need to return the
 size of the cache
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
>> After the previous commits, we make sure that the value passed is
>> right, or we just drop an error.  So now we return if there is one
>> error or we have setup correctly the value passed.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  migration/migration.c | 6 ++----
>>  migration/ram.c       | 8 +++-----
>>  migration/ram.h       | 2 +-
>>  3 files changed, 6 insertions(+), 10 deletions(-)
>> 
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 3feffb5e26..f3d4503ce2 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -1371,14 +1371,12 @@ void qmp_migrate_cancel(Error **errp)
>>  void qmp_migrate_set_cache_size(int64_t value, Error **errp)
>>  {
>>      MigrationState *s = migrate_get_current();
>> -    int64_t new_size;
>>  
>> -    new_size = xbzrle_cache_resize(value, errp);
>> -    if (new_size < 0) {
>> +    if (xbzrle_cache_resize(value, errp) < 0) {
>
> That's not consistent with the function below; it returns
> '0 or negative' for error; this check only tests for negative
> as an error.

int xbzrle_cache_resize(int64_t new_size, Error **errp)
{
    PageCache *new_cache;
    int64_t ret = 0;

    /* Check for truncation */
    if (new_size != (size_t)new_size) {
        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "cache size",
                   "exceeding address space");
        return -1;
    }

    if (new_size == migrate_xbzrle_cache_size()) {
        /* nothing to do */
        return new_size;
    }

    XBZRLE_cache_lock();

    if (XBZRLE.cache != NULL) {
        new_cache = cache_init(new_size, TARGET_PAGE_SIZE, errp);
        if (!new_cache) {
            ret = -1;
            goto out;
        }

        cache_fini(XBZRLE.cache);
        XBZRLE.cache = new_cache;
    }
out:
    XBZRLE_cache_unlock();
    return ret;
}


That is the function that we end having.
-1 means error
0 means success (yes, I should have changed the return new_size to
return 0).

I *think* it is ok.  Notice that this is after we have changed all users
to know that it returns an error or set the value that it has been
passed.

Later, Juan.


>
> Dave
>
>>          return;
>>      }
>>  
>> -    s->xbzrle_cache_size = new_size;
>> +    s->xbzrle_cache_size = value;
>>  }
>>  
>>  int64_t qmp_query_migrate_cache_size(Error **errp)
>> diff --git a/migration/ram.c b/migration/ram.c
>> index c84f22d759..ed4d3c6295 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -111,15 +111,15 @@ static void XBZRLE_cache_unlock(void)
>>   * migration may be using the cache and might finish during this call,
>>   * hence changes to the cache are protected by XBZRLE.lock().
>>   *
>> - * Returns the new_size or negative in case of error.
>> + * Returns the 0 or negative in case of error.
>>   *
>>   * @new_size: new cache size
>>   * @errp: set *errp if the check failed, with reason
>>   */
>> -int64_t xbzrle_cache_resize(int64_t new_size, Error **errp)
>> +int xbzrle_cache_resize(int64_t new_size, Error **errp)
>>  {
>>      PageCache *new_cache;
>> -    int64_t ret;
>> +    int64_t ret = 0;
>>  
>>      /* Check for truncation */
>>      if (new_size != (size_t)new_size) {
>> @@ -152,8 +152,6 @@ int64_t xbzrle_cache_resize(int64_t new_size, Error **errp)
>>          cache_fini(XBZRLE.cache);
>>          XBZRLE.cache = new_cache;
>>      }
>> -
>> -    ret = new_size;
>>  out:
>>      XBZRLE_cache_unlock();
>>      return ret;
>> diff --git a/migration/ram.h b/migration/ram.h
>> index 511b3dc582..c8ae382b5b 100644
>> --- a/migration/ram.h
>> +++ b/migration/ram.h
>> @@ -35,7 +35,7 @@
>>  extern MigrationStats ram_counters;
>>  extern XBZRLECacheStats xbzrle_counters;
>>  
>> -int64_t xbzrle_cache_resize(int64_t new_size, Error **errp);
>> +int xbzrle_cache_resize(int64_t new_size, Error **errp);
>>  uint64_t ram_bytes_remaining(void);
>>  uint64_t ram_bytes_total(void);
>>  
>> -- 
>> 2.13.6
>> 
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
