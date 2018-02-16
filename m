Received: from eggs.gnu.org ([2001:4830:134:3::10]:52159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1emdtT-0002Ao-34
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 06:09:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1emdtR-0002DZ-D1
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 06:09:31 -0500
References: <1518702707-7077-1-git-send-email-vsementsov@virtuozzo.com>
	<1518702707-7077-4-git-send-email-vsementsov@virtuozzo.com>
	<ac33f176-0f15-107f-1c64-4fa3bac77520@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <2b30632c-4028-2726-fd61-81ae3893cfd4@virtuozzo.com>
Date: Fri, 16 Feb 2018 14:09:13 +0300
MIME-Version: 1.0
In-Reply-To: <ac33f176-0f15-107f-1c64-4fa3bac77520@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 3/9] nbd: BLOCK_STATUS for standard
 get_block_status function: server part
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

16.02.2018 02:02, Eric Blake wrote:
> On 02/15/2018 07:51 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Minimal realization: only one extent in server answer is supported.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   include/block/nbd.h |  33 ++++++
>>   nbd/common.c        |  10 ++
>>   nbd/server.c        | 310 
>> +++++++++++++++++++++++++++++++++++++++++++++++++++-
>>   3 files changed, 352 insertions(+), 1 deletion(-)
>>
>
>> @@ -200,9 +227,15 @@ enum {
>>   #define NBD_REPLY_TYPE_NONE          0
>>   #define NBD_REPLY_TYPE_OFFSET_DATA   1
>>   #define NBD_REPLY_TYPE_OFFSET_HOLE   2
>> +#define NBD_REPLY_TYPE_BLOCK_STATUS  5
>
> Stale; see nbd.git commit 56c77720 which changed this to 3.

Very unpleasant surprise. I understand that this is still experimental 
extension, but actually we use it =5 in production about one year. Can 
we revert it to 5?

>
>> +++ b/nbd/server.c
>> @@ -82,6 +82,15 @@ struct NBDExport {
>>     static QTAILQ_HEAD(, NBDExport) exports = 
>> QTAILQ_HEAD_INITIALIZER(exports);
>>   +/* NBDExportMetaContexts represents list of selected by
>> + * NBD_OPT_SET_META_CONTEXT contexts to be exported. */
>
> represents a list of contexts to be exported, as selected by 
> NBD_OPT_SET_META_CONTEXT.
>
>> +typedef struct NBDExportMetaContexts {
>> +    char export_name[NBD_MAX_NAME_SIZE + 1];
>
> Would this work as const char * pointing at some other storage, 
> instead of having to copy into this storage?

I'll think about

>
>> +    bool valid; /* means that negotiation of the option finished 
>> without
>> +                   errors */
>> +    bool base_allocation; /* export base:allocation context (block 
>> status) */
>> +} NBDExportMetaContexts;
>> +
>>   struct NBDClient {
>
>> @@ -636,6 +646,201 @@ static QIOChannel 
>> *nbd_negotiate_handle_starttls(NBDClient *client,
>>       return QIO_CHANNEL(tioc);
>>   }
>>   +/* nbd_alloc_read_size_string
>> + *
>> + * Read string in format
>> + *   uint32_t len
>> + *   len bytes string (not 0-terminated)
>> + * String is allocated and pointer returned as @buf
>> + *
>> + * Return -errno on I/O error, 0 if option was completely handled by
>> + * sending a reply about inconsistent lengths, or 1 on success. */
>> +static int nbd_alloc_read_size_string(NBDClient *client, char **buf,
>> +                                      Error **errp)
>> +{
>> +    int ret;
>> +    uint32_t len;
>> +
>> +    ret = nbd_opt_read(client, &len, sizeof(len), errp);
>> +    if (ret <= 0) {
>> +        return ret;
>> +    }
>> +    cpu_to_be32s(&len);
>> +
>> +    *buf = g_try_malloc(len + 1);
>
> I'd rather check that len is sane prior to trying to malloc. 
> Otherwise, a malicious client can convince us to waste time/space 
> doing a large malloc before we finally realize that we can't read that 
> many bytes after all.  And in fact, if you check len in advance, you 
> can probably just use g_malloc() instead of g_try_malloc() 
> (g_try_malloc() makes sense on a 1M allocation, where we can still 
> allocate smaller stuff in reporting the error; but since NBD limits 
> strings to 4k, if we fail at allocating 4k, we are probably already so 
> hosed that our attempts to report the failure will also run out of 
> memory and abort, so why not just abort now).

reasonable, will do

>
>> +    if (*buf == NULL) {
>> +        error_setg(errp, "No memory");
>> +        return -ENOMEM;
>> +    }
>> +    (*buf)[len] = '\0';
>> +
>> +    ret = nbd_opt_read(client, *buf, len, errp);
>> +    if (ret <= 0) {
>> +        g_free(*buf);
>> +        *buf = NULL;
>> +    }
>> +
>> +    return ret;
>> +}
>> +
>> +/* nbd_read_size_string
>
> Will resume review here...
>


-- 
Best regards,
Vladimir
