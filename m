Received: from eggs.gnu.org ([2001:4830:134:3::10]:34059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fVzOp-0000iV-Rv
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 09:13:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fVzOo-00050P-IH
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 09:13:19 -0400
References: <20180413143156.11409-1-vsementsov@virtuozzo.com>
	<8003bc90-1b11-3d1b-07a3-dca4d49fb79b@virtuozzo.com>
	<dcffbc2b-e0b0-3c90-0c29-aa0c0be64af8@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <0b3bc235-e1a5-f076-2903-15a12041eed9@virtuozzo.com>
Date: Thu, 21 Jun 2018 16:13:07 +0300
MIME-Version: 1.0
In-Reply-To: <dcffbc2b-e0b0-3c90-0c29-aa0c0be64af8@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH] nbd/server: introduce NBD_CMD_CACHE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, den@openvz.org, pbonzini@redhat.com

17.05.2018 16:34, Eric Blake wrote:
> On 05/17/2018 04:52 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Finally, what about this?
>>
>> 13.04.2018 17:31, Vladimir Sementsov-Ogievskiy wrote:
>>> Handle nbd CACHE command. Just do read, without sending read data back.
>>> Cache mechanism should be done by exported node driver chain.
>
> Still waiting on the NBD spec review, which I've pinged on the NBD=20
> list. But as mentioned there, I'll probably go ahead and accept this=20
> (possibly with slight tweaks) on Monday, after giving one more weekend=20
> for any last-minute review comments.

Hmm, Eric?

>
>>> @@ -1826,7 +1826,9 @@ static int=20
>>> nbd_co_receive_request(NBDRequestData *req, NBDRequest *request,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EIO;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> -=C2=A0=C2=A0=C2=A0 if (request->type =3D=3D NBD_CMD_READ || request->t=
ype =3D=3D=20
>>> NBD_CMD_WRITE) {
>>> +=C2=A0=C2=A0=C2=A0 if (request->type =3D=3D NBD_CMD_READ || request->t=
ype =3D=3D=20
>>> NBD_CMD_WRITE ||
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 request->type =3D=3D NBD_CM=
D_CACHE)
>>> +=C2=A0=C2=A0=C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (request->len=
 > NBD_MAX_BUFFER_SIZE) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 error_setg(errp, "len (%" PRIu32" ) is larger than max=20
>>> len (%u)",
>
> I'm not sure I agree with this one. Since we aren't passing the cached=20
> data over the wire, we can reject the command with EINVAL instead of=20
> killing the connection entirely.
>
> (As it is, I wonder if we can be nicer about rejecting a read request=20
> > 32M. For a write request, we have to disconnect; but for a read=20
> request, we can keep the connection alive by just returning EINVAL for=20
> a too-large read, instead of our current behavior of disconnecting)
>
>>> request->len, NBD_MAX_BUFFER_SIZE);
>>> @@ -1911,7 +1913,7 @@ static coroutine_fn int=20
>>> nbd_do_cmd_read(NBDClient *client, NBDRequest *request,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NBDExport *exp =3D client->exp;
>>> -=C2=A0=C2=A0=C2=A0 assert(request->type =3D=3D NBD_CMD_READ);
>>> +=C2=A0=C2=A0=C2=A0 assert(request->type =3D=3D NBD_CMD_READ || request=
->type =3D=3D=20
>>> NBD_CMD_CACHE);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* XXX: NBD Protocol only documents use =
of FUA with WRITE */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (request->flags & NBD_CMD_FLAG_FUA) {
>>> @@ -1930,7 +1932,7 @@ static coroutine_fn int=20
>>> nbd_do_cmd_read(NBDClient *client, NBDRequest *request,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D blk_pread(exp->blk, request->fro=
m + exp->dev_offset, data,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 request->len);
>>> -=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>>> +=C2=A0=C2=A0=C2=A0 if (ret < 0 || request->type =3D=3D NBD_CMD_CACHE) =
{
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return nbd_send_=
generic_reply(client, request->handle, ret,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 "reading from file failed",=20
>>> errp);
>
> As for the implementation on the server side, yes, this looks=20
> reasonable, given the proposed spec wording being considered on the=20
> NBD list.
>


--=20
Best regards,
Vladimir
