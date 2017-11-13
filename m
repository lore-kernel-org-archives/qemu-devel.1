Received: from eggs.gnu.org ([2001:4830:134:3::10]:33350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eED3O-0007aM-OZ
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 06:37:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eED3N-0002dz-OS
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 06:37:26 -0500
References: <20171112013936.5942-1-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <0f61ba9c-439d-eab7-6657-d8088b9adf96@virtuozzo.com>
Date: Mon, 13 Nov 2017 14:37:13 +0300
MIME-Version: 1.0
In-Reply-To: <20171112013936.5942-1-eblake@redhat.com>
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

12.11.2017 04:39, Eric Blake wrote:
> If a server fails a read, for example with EIO, but the connection
> is still live, then we would crash trying to print a non-existent
> error message.  Bug introduced in commit f140e300.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>   block/nbd-client.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/block/nbd-client.c b/block/nbd-client.c
> index b44d4d4a01..5f3375a970 100644
> --- a/block/nbd-client.c
> +++ b/block/nbd-client.c
> @@ -78,7 +78,7 @@ static coroutine_fn void nbd_read_reply_entry(void *opa=
que)
>       while (!s->quit) {
>           assert(s->reply.handle =3D=3D 0);
>           ret =3D nbd_receive_reply(s->ioc, &s->reply, &local_err);

hmm.

/* nbd_receive_reply
 =C2=A0* Returns 1 on success
 =C2=A0*=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 on eof, when no =
data was read (errp is not set)
 =C2=A0*=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 negative errno on =
failure (errp is set)
 =C2=A0*/
int nbd_receive_reply(QIOChannel *ioc, NBDReply *reply, Error **errp)


- looks like errp should be set if ret < 0. may be the function should=20
be fixed?
- don't you think that this function returns transferred server error?=20
it doesn't.

> -        if (ret < 0) {
> +        if (local_err) {
>               error_report_err(local_err);
>           }
>           if (ret <=3D 0) {
> @@ -681,7 +681,7 @@ int nbd_client_co_preadv(BlockDriverState *bs, uint64=
_t offset,
>
>       ret =3D nbd_co_receive_cmdread_reply(client, request.handle, offset=
, qiov,
>                                          &local_err);
> -    if (ret < 0) {
> +    if (local_err) {
>           error_report_err(local_err);
>       }
>       return ret;

but here, it looks like you are right. My first attempt was to store=20
server error to ret and
server error msg to errp (bad idea, as I can see now), but you proposed=20
to do not print every server error msg and
deleted this functionality. And now we have a set of functions which can=20
return ret < 0
and not set errp.. It looks very confusing, I think. Better solution is=20
to refactor this somehow,
may be not mixing server-error-reply with local normal errors..

For now, for second chunk:

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>



--=20
Best regards,
Vladimir
