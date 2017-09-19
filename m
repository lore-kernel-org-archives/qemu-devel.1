Received: from eggs.gnu.org ([2001:4830:134:3::10]:57491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1duF4Q-0004r2-A1
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 05:43:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1duF4P-00004q-8S
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 05:43:58 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:22780 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1duF4O-0008Qq-Rt
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 05:43:57 -0400
References: <20170918135935.255591-1-vsementsov@virtuozzo.com>
	<20170918135935.255591-7-vsementsov@virtuozzo.com>
	<b016f0b6-c7bd-eef3-caee-47f7da7d8deb@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <48c3e73c-d142-7a46-a6be-b4c05349aa81@virtuozzo.com>
Date: Tue, 19 Sep 2017 12:43:45 +0300
MIME-Version: 1.0
In-Reply-To: <b016f0b6-c7bd-eef3-caee-47f7da7d8deb@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 6/7] block/nbd-client: early fail
 nbd_read_reply_entry if s->quit is set
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

19.09.2017 01:27, Eric Blake wrote:
> On 09/18/2017 08:59 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Do not continue any operation if s->quit is set in parallel.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   block/nbd-client.c | 7 +++----
>>   1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/block/nbd-client.c b/block/nbd-client.c
>> index 280147e6a7..f80a4c5564 100644
>> --- a/block/nbd-client.c
>> +++ b/block/nbd-client.c
>> @@ -81,7 +81,7 @@ static coroutine_fn void nbd_read_reply_entry(void *=
opaque)
>>           if (ret < 0) {
>>               error_report_err(local_err);
>>           }
>> -        if (ret <=3D 0) {
>> +        if (ret <=3D 0 || s->quit) {
>>               break;
>>           }
> I'm still not convinced this helps: either nbd_receive_reply() already
> returned an error, or we got a successful reply header, at which point
> either the command is done (no need to abort the command early - it
> succeeded) or it is a read command (and we should detect at the point
> where we try to populate the qiov that we don't want to read any more).
> It depends on your 3/7 patch for the fact that we even try to read the
> qiov directly in this while loop rather than in the coroutine handler,
> where Paolo questioned whether we need that change.
>
>> @@ -105,9 +105,8 @@ static coroutine_fn void nbd_read_reply_entry(void=
 *opaque)
>>               assert(qiov !=3D NULL);
>>               assert(s->requests[i].request->len =3D=3D
>>                      iov_size(qiov->iov, qiov->niov));
>> -            if (qio_channel_readv_all(s->ioc, qiov->iov, qiov->niov,
>> -                                      NULL) < 0)
>> -            {
>> +            ret =3D qio_channel_readv_all(s->ioc, qiov->iov, qiov->ni=
ov, NULL);
>> +            if (ret < 0 || s->quit) {
>>                   s->requests[i].ret =3D -EIO;
>>                   break;
>>               }
> The placement here looks odd. Either we should not attempt the read
> because s->quit was already set (okay, your first addition makes sense
> in that light), or we succeeded at the read (at which point, why do we
> need to claim it failed?).
>
> I'm trying to look forward to structured reads, where we will have to
> deal with more than one server message in reply to a single client
> request.  For read, we just piece together portions of the qiov until
> the server has sent us all the pieces.  But for block query, I really d=
o
> think we'll want to defer to specialized handlers for doing further
> reads (the amount of data to be read from the server is not known by th=
e
> client a priori, so it is a two-part read, one to get the length, and
> another to read that remaining length); if we need some sort of callbac=
k
> function rather than cramming all the logic here in the main read loop,

by patch 3 I do not mean in any way that I want to have all reading=20
staff in one function, ofcourse it should be refactored
for block-status addition. I just want to have all reading staff in one=20
coroutine. Reading from ioc is sequential, so it's
native to do it sequentially in one coroutine, without switches.

> then the qio_channel_readv_all for read commands would belong in the
> callback, and it is more a question of the main read loop checking
> whether there is an early quit condition before calling into the callba=
ck.
>

If I understand correctly, the discussion is:

me: if something fails - fail all other parallel operations - it's=20
simple and clear, but we need to check s->quit after every possible yield

you: .... _not_ all other parallel operations. - may be it is better,=20
but in this case we need carefully define, which parallel operation we fa=
il

 =C2=A0on s->quit and which not and understand all effects of this divisi=
on.

--=20
Best regards,
Vladimir
