Received: from eggs.gnu.org ([2001:4830:134:3::10]:52693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cbi5j-00029f-0B
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 01:20:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cbi5h-00080R-Uy
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 01:20:26 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:16771 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1cbi5h-0007yq-Hh
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 01:20:25 -0500
References: <20170203154757.36140-1-vsementsov@virtuozzo.com>
	<20170203154757.36140-5-vsementsov@virtuozzo.com>
	<7b79d03c-0fba-ddb8-4295-b155cb26a206@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <829007b8-d8a4-652c-7a23-59fbb5476cd2@virtuozzo.com>
Date: Thu, 9 Feb 2017 09:20:13 +0300
MIME-Version: 1.0
In-Reply-To: <7b79d03c-0fba-ddb8-4295-b155cb26a206@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 04/18] nbd/client: refactor
 nbd_receive_starttls
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

07.02.2017 19:32, Eric Blake wrote:
> On 02/03/2017 09:47 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Split out nbd_receive_simple_option to be reused for structured reply
>> option.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   nbd/client.c       | 54 +++++++++++++++++++++++++++++++++++-------------------
>>   nbd/nbd-internal.h | 14 ++++++++++++++
>>   2 files changed, 49 insertions(+), 19 deletions(-)
>>
>> +++ b/nbd/nbd-internal.h
>> @@ -96,6 +96,20 @@
>>   #define NBD_ENOSPC     28
>>   #define NBD_ESHUTDOWN  108
>>   
>> +static inline const char *nbd_opt_name(int opt)
>> +{
>> +    switch (opt) {
>> +    case NBD_OPT_EXPORT_NAME: return "export_name";
> Does this really get past checkpatch?
>
>> +    case NBD_OPT_ABORT: return "abort";
>> +    case NBD_OPT_LIST: return "list";
>> +    case NBD_OPT_PEEK_EXPORT: return "peek_export";
>> +    case NBD_OPT_STARTTLS: return "tls";
> Why just 'tls' instead of 'starttls'?
>
>> +    case NBD_OPT_STRUCTURED_REPLY: return "structured_reply";
>> +    }
>> +
>> +    return "<unknown option>";
> Can you please consider making this include the %d representation of the
> unknown option; perhaps by snprintf'ing into static storage?  While it

Hmm.. The caller should free it in this case. Currently, the 
get_opt_name is called only on error path or if tracing enabled. How to 
achieve this with variable string return value not complicating the code 
a lot? When there is unknown message there should be other mechanism to 
inform user

> is unlikely that a well-behaved server will respond to a client with an
> option the client doesn't recognize, it is much more likely that this
> reverse lookup function will be used in a server to respond to an
> unknown option from a client.
>
> In fact, I might have split this into two patches: one providing
> nbd_opt_name() and using it throughout the code base where appropriate,
> and the other refactoring starttls in the client.
>
> I'm not sure if the reverse lookup function needs to be inline in the
> header; it could reasonably live in nbd/common.c, particularly if you
> are going to take my advice to have it format a message for unknown values.
>


-- 
Best regards,
Vladimir
