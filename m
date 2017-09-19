Received: from eggs.gnu.org ([2001:4830:134:3::10]:35641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1duFKW-0004cQ-Q1
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:00:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1duFKQ-00012q-Vq
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:00:36 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:5811 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1duFKQ-0000zm-Jf
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:00:30 -0400
References: <20170918135935.255591-1-vsementsov@virtuozzo.com>
	<20170918135935.255591-8-vsementsov@virtuozzo.com>
	<0f9ffc3d-02e1-fde8-67ac-0f62101f1204@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <17fdbc1d-05db-ee91-6b13-cac9d3719c21@virtuozzo.com>
Date: Tue, 19 Sep 2017 13:00:19 +0300
MIME-Version: 1.0
In-Reply-To: <0f9ffc3d-02e1-fde8-67ac-0f62101f1204@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 7/7] block/nbd-client: do not yield from
 nbd_read_reply_entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

19.09.2017 01:36, Eric Blake wrote:
> On 09/18/2017 08:59 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Refactor nbd client to not yield from nbd_read_reply_entry. It's
>> possible now as all reading is done in nbd_read_reply_entry and
>> all request-related data is stored in per-request s->requests[i].
>>
>> We need here some additional work with s->requests[i].ret and
>> s->quit to not fail requests on normal disconnet and to not report
>> reading errors on normal disconnect.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   block/nbd-client.c | 29 ++++++++++-------------------
>>   1 file changed, 10 insertions(+), 19 deletions(-)
> The diffstat may have merit, but I'm wondering:
>
>> diff --git a/block/nbd-client.c b/block/nbd-client.c
>> index f80a4c5564..bf20d5d5e6 100644
>> --- a/block/nbd-client.c
>> +++ b/block/nbd-client.c
>> @@ -79,7 +79,11 @@ static coroutine_fn void nbd_read_reply_entry(void =
*opaque)
>>       while (!s->quit) {
>>           ret =3D nbd_receive_reply(s->ioc, &reply, &local_err);
>>           if (ret < 0) {
>> -            error_report_err(local_err);
>> +            if (s->quit) {
>> +                error_free(local_err);
> This discards errors on all remaining coroutines after we detect an
> early exit. Are we sure the coroutine that set s->quit will have
> reported an appropriate error, and thus explaining why we can discard
> all secondary errors?  A comment in the code would be helpful.

I'll think about it.

>
>> +            } else {
>> +                error_report_err(local_err);
>> +            }
>>           }
>> @@ -210,7 +204,7 @@ static int nbd_co_receive_reply(NBDClientSession *=
s, NBDRequest *request)
>>       s->requests[i].receiving =3D true;
>>       qemu_coroutine_yield();
>>       s->requests[i].receiving =3D false;
>> -    if (!s->ioc || s->quit) {
>> +    if (!s->ioc) {
>>           ret =3D -EIO;
> Why don't we need to check s->quit any more?  That was just added
> earlier in the series; why the churn?

it is "to not fail requests on normal disconnet". Because reply_entry=20
may be already finished.
Initializing "+=C2=A0=C2=A0=C2=A0 s->requests[i].ret =3D -EIO;" is enough.

>
>>       } else {
>>           ret =3D s->requests[i].ret;
>> @@ -218,11 +212,6 @@ static int nbd_co_receive_reply(NBDClientSession =
*s, NBDRequest *request)
>>  =20
>>       s->requests[i].coroutine =3D NULL;
>>  =20
>> -    /* Kick the read_reply_co to get the next reply.  */
>> -    if (s->read_reply_co) {
>> -        aio_co_wake(s->read_reply_co);
>> -    }
>> -
>>       qemu_co_mutex_lock(&s->send_mutex);
>>       s->in_flight--;
>>       qemu_co_queue_next(&s->free_sema);
>> @@ -364,6 +353,8 @@ void nbd_client_close(BlockDriverState *bs)
>>  =20
>>       nbd_send_request(client->ioc, &request);
>>  =20
>> +    client->quit =3D true;
> Previously, client->quit was only set when detecting a broken server,
> now it is also set for a clean exit.  Do we need to change any
> documentation of the field?

It has documentation?

>

--=20
Best regards,
Vladimir
