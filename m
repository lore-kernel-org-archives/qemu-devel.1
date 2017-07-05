Received: from eggs.gnu.org ([2001:4830:134:3::10]:55387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dSjVN-0002j2-FG
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 08:34:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dSjVI-00030y-I3
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 08:34:05 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:2234 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dSjVI-0002yt-6b
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 08:34:00 -0400
References: <20170621153424.16690-1-vsementsov@virtuozzo.com>
	<20170621153424.16690-3-vsementsov@virtuozzo.com>
	<695de534-7f65-c6cc-00ac-4d35e3eb6e7d@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <a0dae7c7-f0e8-2c6b-e35e-096f597c40cb@virtuozzo.com>
Date: Wed, 5 Jul 2017 15:33:56 +0300
MIME-Version: 1.0
In-Reply-To: <695de534-7f65-c6cc-00ac-4d35e3eb6e7d@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 2/6] nbd/server: use errp instead of LOG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: stefanha@redhat.com, pbonzini@redhat.com, den@openvz.org, Markus Armbruster <armbru@redhat.com>

Markus, what do you think? I'll resend tomorrow with Eric's comments 
applied, should I change something with this errp?

29.06.2017 22:27, Eric Blake wrote:
> On 06/21/2017 10:34 AM, Vladimir Sementsov-Ogievskiy wrote:

[...]

>> -static int GCC_FMT_ATTR(4, 5)
>> +static int GCC_FMT_ATTR(5, 6)
>>   nbd_negotiate_send_rep_err(QIOChannel *ioc, uint32_t type,
>> -                           uint32_t opt, const char *fmt, ...)
>> +                           uint32_t opt, Error **errp, const char *fmt, ...)
>>   {
> Markus, this violates our usual idiom of errp last in code that is not
> directly operating on an Error (the actual Error implementation in
> error.c being the main obvious exception that lists errp first), but I
> don't see any better approach. Do you have any thoughts on it?
>
>> -    if (nbd_read(client->ioc, name, length, NULL) < 0) {
>> -        LOG("read failed");
>> +    if (nbd_read(client->ioc, name, length, errp) < 0) {
>> +        error_prepend(errp, "read failed: ");
>>           return -EINVAL;
>>       }

[...]

>
> Overall the change looks good to me, but I'll wait to see if Markus has
> any design advice before giving my R-b.
>

-- 
Best regards,
Vladimir
