Received: from eggs.gnu.org ([2001:4830:134:3::10]:34745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1d6ETX-0000e9-2H
	for qemu-devel@nongnu.org; Thu, 04 May 2017 06:59:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1d6ETS-00045k-7S
	for qemu-devel@nongnu.org; Thu, 04 May 2017 06:59:11 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:38339 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1d6ETR-0003ys-Rl
	for qemu-devel@nongnu.org; Thu, 04 May 2017 06:59:06 -0400
References: <20170203154757.36140-1-vsementsov@virtuozzo.com>
	<20170203154757.36140-4-vsementsov@virtuozzo.com>
	<e55d7819-db41-3077-3fe5-ecad88ab2c47@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <9392b02d-e251-d3f7-dbf5-b2bce1aa7620@virtuozzo.com>
Date: Thu, 4 May 2017 13:58:45 +0300
MIME-Version: 1.0
In-Reply-To: <e55d7819-db41-3077-3fe5-ecad88ab2c47@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 03/18] nbd: Minimal structured read for
 server
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: famz@redhat.com, jsnow@redhat.com, kwolf@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, armbru@redhat.com, den@virtuozzo.com, stefanha@redhat.com

07.02.2017 02:01, Eric Blake wrote:
> On 02/03/2017 09:47 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Minimal implementation of structured read: one data chunk + finishing
>> none chunk. No segmentation.
>> Minimal structured error implementation: no text message.
>> Support DF flag, but just ignore it, as there is no segmentation any
>> way.
> Might be worth adding that this is still an experimental extension to
> the NBD spec, and therefore that this implementation serves as proof of
> concept and may still need tweaking if anything major turns up before
> promoting it to stable.  It might also be worth a link to:
>
> https://github.com/NetworkBlockDevice/nbd/blob/extension-structured-reply/doc/proto.md
>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   include/block/nbd.h |  31 +++++++++++++
>>   nbd/nbd-internal.h  |   2 +
>>   nbd/server.c        | 125 ++++++++++++++++++++++++++++++++++++++++++++++++++--
>>   3 files changed, 154 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/block/nbd.h b/include/block/nbd.h
>> index 3c65cf8d87..58b864f145 100644
>> --- a/include/block/nbd.h
>> +++ b/include/block/nbd.h
>> @@ -70,6 +70,25 @@ struct NBDSimpleReply {
>>   };
>>   typedef struct NBDSimpleReply NBDSimpleReply;
>>   
>> +typedef struct NBDStructuredReplyChunk {
>> +    uint32_t magic;
>> +    uint16_t flags;
>> +    uint16_t type;
>> +    uint64_t handle;
>> +    uint32_t length;
>> +} QEMU_PACKED NBDStructuredReplyChunk;
>> +
>> +typedef struct NBDStructuredRead {
>> +    NBDStructuredReplyChunk h;
>> +    uint64_t offset;
>> +} QEMU_PACKED NBDStructuredRead;
>> +
>> +typedef struct NBDStructuredError {
>> +    NBDStructuredReplyChunk h;
>> +    uint32_t error;
>> +    uint16_t message_length;
>> +} QEMU_PACKED NBDStructuredError;
> Definitely a subset of all types added in the NBD protocol extension,
> but reasonable for a minimal implementation.  Might be worth adding
> comments to the types...

Hmm, for me their names looks descriptive enough, but my sight may be 
biased.. What kind of comments do you want?

[...]


-- 
Best regards,
Vladimir
