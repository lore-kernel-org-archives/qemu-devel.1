Received: from eggs.gnu.org ([2001:4830:134:3::10]:33753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eEG8v-0002SS-W8
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 09:55:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eEG8p-0007TL-Sa
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 09:55:21 -0500
References: <20171112013936.5942-1-eblake@redhat.com>
	<0f61ba9c-439d-eab7-6657-d8088b9adf96@virtuozzo.com>
	<c9b80c9d-4131-a7f6-6283-6aadf9d50c7d@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <687789bb-3eb9-98fc-a84e-14a6e0b27e02@virtuozzo.com>
Date: Mon, 13 Nov 2017 17:55:01 +0300
MIME-Version: 1.0
In-Reply-To: <c9b80c9d-4131-a7f6-6283-6aadf9d50c7d@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH for-2.11] nbd: Don't crash when server
 reports NBD_CMD_READ failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

13.11.2017 17:45, Eric Blake wrote:
> On 11/13/2017 05:37 AM, Vladimir Sementsov-Ogievskiy wrote:
>> 12.11.2017 04:39, Eric Blake wrote:
>>> If a server fails a read, for example with EIO, but the connection
>>> is still live, then we would crash trying to print a non-existent
>>> error message.=C2=A0 Bug introduced in commit f140e300.
>>>
>>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>> ---
>>>  =C2=A0 block/nbd-client.c | 4 ++--
>>>  =C2=A0 1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/block/nbd-client.c b/block/nbd-client.c
>>> index b44d4d4a01..5f3375a970 100644
>>> --- a/block/nbd-client.c
>>> +++ b/block/nbd-client.c
>>> @@ -78,7 +78,7 @@ static coroutine_fn void nbd_read_reply_entry(void
>>> *opaque)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while (!s->quit) {
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assert(s->reply=
.handle =3D=3D 0);
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D nbd_rec=
eive_reply(s->ioc, &s->reply, &local_err);
>> hmm.
>>
>> /* nbd_receive_reply
>>  =C2=A0* Returns 1 on success
>>  =C2=A0*=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 on eof, when =
no data was read (errp is not set)
>>  =C2=A0*=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 negative errno =
on failure (errp is set)
>>  =C2=A0*/
>> int nbd_receive_reply(QIOChannel *ioc, NBDReply *reply, Error **errp)
>>
>>
>> - looks like errp should be set if ret < 0. may be the function should
>> be fixed?
>> - don't you think that this function returns transferred server error?
>> it doesn't.
>>
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (local_err) {
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 error_report_err(local_err);
> In my testing, I did not trip on this error_report_err() crashing.
> Which means I think we are already honoring our contract:
> nbd_receive_reply() is setting local_err if it returns -1.  Thus, for
> this call site, 'if (ret < 0)' is equivalent to 'if (local_err)'.  The
> only reason to change it, then, is for consistency with the other 2
> callers of error_report_err() in this file...
>
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret <=3D 0)=
 {
>>> @@ -681,7 +681,7 @@ int nbd_client_co_preadv(BlockDriverState *bs,
>>> uint64_t offset,
>>>
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D nbd_co_receive_cmdread_reply(cl=
ient, request.handle,
>>> offset, qiov,
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 &local_err);
>>> -=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>>> +=C2=A0=C2=A0=C2=A0 if (local_err) {
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report_er=
r(local_err);
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> but here, it looks like you are right. My first attempt was to store
>> server error to ret and
>> server error msg to errp (bad idea, as I can see now), but you proposed
>> to do not print every server error msg and
>> deleted this functionality. And now we have a set of functions which can
>> return ret < 0
>> and not set errp..
> Indeed, this is the caller that MUST return a negative value to get the
> caller to report a failed operation, but where the negative value does
> NOT imply a dead connection unless local_err was also set, so here, we
> must not print anything unless local_err was set.  I caught one of the
> two spots like this while revising your patch prior to soft freeze, but
> missed this one.
>
>> It looks very confusing, I think. Better solution is
>> to refactor this somehow,
>> may be not mixing server-error-reply with local normal errors..
> A refactoring may be nice, but it would be 2.12 material; at this point,
> I want to minimize what further changes go into 2.11.  That said,
>
>> For now, for second chunk:
> I see no problem with both chunks going in.  The second is a bug fix,
> but the first is for consistency, and I'd rather have all callers to
> error_report_err() look consistent, rather than trying to remember that
> 'ret < 0' does not always imply errp is set.

ok, lets proceed with both chunks.

>
>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>
>>
>>


--=20
Best regards,
Vladimir
