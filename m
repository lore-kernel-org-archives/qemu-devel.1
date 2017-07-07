Received: from eggs.gnu.org ([2001:4830:134:3::10]:34042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dTUu4-0005Z2-Vr
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 11:10:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dTUu0-0007xU-Tz
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 11:10:44 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:45182 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dTUu0-0007uy-GM
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 11:10:40 -0400
References: <20170621153424.16690-1-vsementsov@virtuozzo.com>
	<20170621153424.16690-3-vsementsov@virtuozzo.com>
	<b8174b0b-1782-48ae-6bef-3f2a6a08f025@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <0c0712e3-3136-5a62-3c5b-90c9e861c469@virtuozzo.com>
Date: Fri, 7 Jul 2017 18:10:37 +0300
MIME-Version: 1.0
In-Reply-To: <b8174b0b-1782-48ae-6bef-3f2a6a08f025@redhat.com>
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
Cc: stefanha@redhat.com, pbonzini@redhat.com, den@openvz.org, "Daniel P. Berrange" <berrange@redhat.com>

07.07.2017 17:40, Eric Blake wrote:
> On 06/21/2017 10:34 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Move to modern errp scheme from just LOGging errors.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   nbd/server.c | 268 +++++++++++++++++++++++++++++++++++------------------------
>>   1 file changed, 161 insertions(+), 107 deletions(-)
>> -static coroutine_fn int nbd_negotiate(NBDClient *client)
>> +static coroutine_fn int nbd_negotiate(NBDClient *client, Error **errp)
>>   {
>>       char buf[8 + 8 + 8 + 128];
>>       int ret;
> Now that you have this,
>
>>      qio_channel_set_blocking(client->ioc, false, NULL);
>>
> you should probably pass errp through to qio_channel_set_blocking and
> return early if that fails (either here or in one of the followup
> patches) [hmm, I note that most callers of qio_channel_set_blocking()
> ignore errors - outside of NBD, so that's a separate cleanup series]

I've looked through realizations of ioc_klass->io_set_blocking - looks 
like they all are returning zero always.

>
>
>> @@ -591,21 +617,23 @@ static coroutine_fn int nbd_negotiate(NBDClient *client)
>>   
>>       if (oldStyle) {
>>           if (client->tlscreds) {
>> -            TRACE("TLS cannot be enabled with oldstyle protocol");
>> +            error_setg(errp, "TLS cannot be enabled with oldstyle protocol");
>>               return -EINVAL;
> This code is unreachable, since earlier we have:
>
>>      oldStyle = client->exp != NULL && !client->tlscreds;
> You could just as easily delete the conditional.  In fact, our code has:
>
> if (oldStyle) {
>      do stuff
> } else {
>      do stuff
> }
>
> if (oldStyle) {
>      do stuff
> } else {
>      do stuff
> }
>
> and it would be simple to merge that into a single if statement.
>

-- 
Best regards,
Vladimir
