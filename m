Received: from eggs.gnu.org ([2001:4830:134:3::10]:49736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dGjO3-0008Q0-2K
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 06:00:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dGjO0-000405-2v
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 06:00:55 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:15074 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dGjNz-0003zJ-N3
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 06:00:52 -0400
References: <20170530143052.165002-1-vsementsov@virtuozzo.com>
	<20170530143052.165002-14-vsementsov@virtuozzo.com>
	<6795a44e-a0c4-2c09-390b-af07f675363b@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <9f30e34f-2420-b909-a4c9-594b951b0c11@virtuozzo.com>
Date: Fri, 2 Jun 2017 13:00:48 +0300
MIME-Version: 1.0
In-Reply-To: <6795a44e-a0c4-2c09-390b-af07f675363b@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 13/19] nbd/server: return original error
 codes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, den@openvz.org

02.06.2017 01:29, Eric Blake wrote:
> On 05/30/2017 09:30 AM, Vladimir Sementsov-Ogievskiy wrote:
>> The code in many cases return -EINVAL or -EIO instead of original error
>> code from, for example, write_sync(). Following patch will need EPIPE
>> handling, so, let's refactor this where possible (the only exclusion
>> is nbd_co_receive_request, with own return-code convention)
> Do we still want/need EPIPE handling, given the discussion on the
> previous two patches?

Looks like this patch should be dropped. If EPIPE is not accepted 
(previous discussion), so error code is always EIO, no needs to save it 
into a variable..

>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   nbd/server.c | 124 +++++++++++++++++++++++++++++++++++++----------------------
>>   1 file changed, 77 insertions(+), 47 deletions(-)
>>
> Feels weird to have a net gain in code, but maybe worthwhile.
>
>> diff --git a/nbd/server.c b/nbd/server.c
>> index a47f13e4fb..30dfb81a5c 100644
>> --- a/nbd/server.c
>> +++ b/nbd/server.c
>> @@ -136,30 +136,38 @@ static void nbd_client_receive_next_request(NBDClient *client);
>>   static int nbd_negotiate_send_rep_len(QIOChannel *ioc, uint32_t type,
>>                                         uint32_t opt, uint32_t len)
>>   {
>> +    int ret;
>>       uint64_t magic;
>>   
>>       TRACE("Reply opt=%" PRIx32 " type=%" PRIx32 " len=%" PRIu32,
>>             type, opt, len);
>>   
>>       magic = cpu_to_be64(NBD_REP_MAGIC);
>> -    if (write_sync(ioc, &magic, sizeof(magic), NULL) < 0) {
>> +    ret = write_sync(ioc, &magic, sizeof(magic), NULL);
>> +    if (ret < 0) {
>>           LOG("write failed (rep magic)");
>> -        return -EINVAL;
>> +        return ret;
>>       }
> Constructs like this should get shorter once we plumb errp all the way
> through.  Okay, I can live with the temporary verbosity.
>
> You may still have to make changes due to rebasing (in which case I'll
> definitely want to review again); but if this patch doesn't need further
> rework, you can add:
> Reviewed-by: Eric Blake <eblake@redhat.com>
>

-- 
Best regards,
Vladimir
