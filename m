Received: from eggs.gnu.org ([2001:4830:134:3::10]:39191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dVdHL-0001TN-5Q
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 08:31:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dVdHF-0007uz-A5
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 08:31:35 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:15669 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dVdHE-0007uL-UI
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 08:31:29 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
References: <20170707203049.534-1-eblake@redhat.com>
	<20170707203049.534-2-eblake@redhat.com>
	<b4c5c384-d759-44f8-bc9a-41f619133a83@virtuozzo.com>
Message-ID: <91f92ed8-cc6d-d4d6-d217-95d91f6bea7c@virtuozzo.com>
Date: Thu, 13 Jul 2017 15:31:24 +0300
MIME-Version: 1.0
In-Reply-To: <b4c5c384-d759-44f8-bc9a-41f619133a83@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v5 1/9] nbd: Create struct for tracking
 export info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, den@virtuozzo.com, marcandre.lureau@redhat.com, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

13.07.2017 15:09, Vladimir Sementsov-Ogievskiy wrote:
> 07.07.2017 23:30, Eric Blake wrote:
>> The NBD Protocol is introducing some additional information
>> about exports, such as minimum request size and alignment, as
>> well as an advertised maximum request size.  It will be easier
>> to feed this information back to the block layer if we gather
>> all the information into a struct, rather than adding yet more
>> pointer parameters during negotiation.
>
> // it was me who do so)
>
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>
>> ---
>> v5: rebase to master, enough differences to drop R-b
>> v4: rebase to master
>> v3: new patch
>> ---
>>   block/nbd-client.h  |  3 +--
>>   include/block/nbd.h | 15 +++++++++++----
>>   block/nbd-client.c  | 18 ++++++++----------
>>   block/nbd.c         |  2 +-
>>   nbd/client.c        | 44 ++++++++++++++++++++++----------------------
>>   qemu-nbd.c          | 10 ++++------
>>   6 files changed, 47 insertions(+), 45 deletions(-)
>>
>> diff --git a/block/nbd-client.h b/block/nbd-client.h
>> index 49636bc..df80771 100644
>> --- a/block/nbd-client.h
>> +++ b/block/nbd-client.h
>> @@ -20,8 +20,7 @@
>>   typedef struct NBDClientSession {
>>       QIOChannelSocket *sioc; /* The master data channel */
>>       QIOChannel *ioc; /* The current I/O channel which may differ 
>> (eg TLS) */
>> -    uint16_t nbdflags;
>> -    off_t size;
>
> was signed
>
>> +    NBDExportInfo info;
>>
>>       CoMutex send_mutex;
>>       CoQueue free_sema;
>> diff --git a/include/block/nbd.h b/include/block/nbd.h
>> index 6d75d5a..9092374 100644
>> --- a/include/block/nbd.h
>> +++ b/include/block/nbd.h
>> @@ -123,13 +123,20 @@ enum {
>>    * aren't overflowing some other buffer. */
>>   #define NBD_MAX_NAME_SIZE 256
>>
>> +/* Details collected by NBD_OPT_EXPORT_NAME and NBD_OPT_GO */
>> +struct NBDExportInfo {
>> +    uint64_t size;
>
> becomes unsigned
>
>> +    uint16_t flags;
>> +};
>> +typedef struct NBDExportInfo NBDExportInfo;
>> +
>>   ssize_t nbd_rwv(QIOChannel *ioc, struct iovec *iov, size_t niov, 
>> size_t length,
>>                   bool do_read, Error **errp);
>
> [...]
>
>> --- a/nbd/client.c
>> +++ b/nbd/client.c
>>
>
> [...]
>
>> @@ -570,13 +570,13 @@ int nbd_receive_negotiate(QIOChannel *ioc, 
>> const char *name, uint16_t *flags,
>>               error_setg(errp, "Unexpected export flags %0x" PRIx32, 
>> oldflags);
>>               goto fail;
>>           }
>> -        *flags = oldflags;
>> +        info->flags = oldflags;
>>       } else {
>>           error_setg(errp, "Bad magic received");
>>           goto fail;
>>       }
>>
>> -    trace_nbd_receive_negotiate_size_flags(*size, *flags);
>> +    trace_nbd_receive_negotiate_size_flags(info->size, info->flags);
>
> trace function declared with uint64_t so this was not very good and 
> becomes ok with this patch.
>
>>       if (zeroes && nbd_drop(ioc, 124, errp) < 0) {
>>           error_prepend(errp, "Failed to read reserved block");
>>           goto fail;
>> @@ -588,13 +588,13 @@ fail:
>>   }
>>
>>   #ifdef __linux__
>> -int nbd_init(int fd, QIOChannelSocket *sioc, uint16_t flags, off_t 
>> size,
>> +int nbd_init(int fd, QIOChannelSocket *sioc, NBDExportInfo *info,
>>                Error **errp)
>>   {
>> -    unsigned long sectors = size / BDRV_SECTOR_SIZE;
>> -    if (size / BDRV_SECTOR_SIZE != sectors) {
>> -        error_setg(errp, "Export size %lld too large for 32-bit 
>> kernel",
>> -                   (long long) size);
>> +    unsigned long sectors = info->size / BDRV_SECTOR_SIZE;
>> +    if (info->size / BDRV_SECTOR_SIZE != sectors) {
>> +        error_setg(errp, "Export size %" PRId64 " too large for 
>> 32-bit kernel",
>
> should be PRIu64
>
>> +                   info->size);
>>           return -E2BIG;
>>       }
>>
> [...]
>

with fixed:

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

(if it is not too late ;)


-- 
Best regards,
Vladimir
