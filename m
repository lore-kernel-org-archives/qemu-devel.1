Received: from eggs.gnu.org ([2001:4830:134:3::10]:52113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1djjga-0006aA-Iw
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 06:11:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1djjgV-0007go-J3
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 06:11:56 -0400
References: <20170815150907.21495-1-eblake@redhat.com>
	<20170815150907.21495-8-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <aca0bbb8-0893-c02a-c3cb-b85fa431437b@virtuozzo.com>
Date: Mon, 21 Aug 2017 13:11:45 +0300
MIME-Version: 1.0
In-Reply-To: <20170815150907.21495-8-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 7/7] nbd-client: Fix regression when server
 sends garbage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

15.08.2017 18:09, Eric Blake wrote:
> When we switched NBD to use coroutines for qemu 2.9 (in particular,
> commit a12a712a), we introduced a regression: if a server sends us
> garbage (such as a corrupted magic number), we quit the read loop
> but do not stop sending further queued commands, resulting in the
> client hanging when it never reads the response to those additional
> commands.  In qemu 2.8, we properly detected that the server is no
> longer reliable, and cancelled all existing pending commands with
> EIO, then tore down the socket so that all further command attempts
> get EPIPE.
>
> Restore the proper behavior of quitting (almost) all communication
> with a broken server: Once we know we are out of sync or otherwise
> can't trust the server, we must assume that any further incoming
> data is unreliable and therefore end all pending commands with EIO,
> and quit trying to send any further commands.  As an exception, we
> still (try to) send NBD_CMD_DISC to let the server know we are going
> away (in part, because it is easier to do that than to further
> refactor nbd_teardown_connection, and in part because it is the
> only command where we do not have to wait for a reply).
>
> Based on a patch by Vladimir Sementsov-Ogievskiy.
>
> A malicious server can be created with the following hack,
> followed by setting NBD_SERVER_DEBUG to a non-zero value in the
> environment when running qemu-nbd:
>
> | --- a/nbd/server.c
> | +++ b/nbd/server.c
> | @@ -919,6 +919,17 @@ static int nbd_send_reply(QIOChannel *ioc, NBDRe=
ply *reply, Error **errp)
> |      stl_be_p(buf + 4, reply->error);
> |      stq_be_p(buf + 8, reply->handle);
> |
> | +    static int debug;
> | +    static int count;
> | +    if (!count++) {
> | +        const char *str =3D getenv("NBD_SERVER_DEBUG");
> | +        if (str) {
> | +            debug =3D atoi(str);
> | +        }
> | +    }
> | +    if (debug && !(count % debug)) {
> | +        buf[0] =3D 0;
> | +    }
> |      return nbd_write(ioc, buf, sizeof(buf), errp);
> |  }
>
> Reported-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Message-Id: <20170814213426.24681-1-eblake@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   block/nbd-client.h |  1 +
>   block/nbd-client.c | 17 +++++++++++++----
>   2 files changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/block/nbd-client.h b/block/nbd-client.h
> index df80771357..1935ffbcaa 100644
> --- a/block/nbd-client.h
> +++ b/block/nbd-client.h
> @@ -29,6 +29,7 @@ typedef struct NBDClientSession {
>
>       Coroutine *recv_coroutine[MAX_NBD_REQUESTS];
>       NBDReply reply;
> +    bool quit;
>   } NBDClientSession;
>
>   NBDClientSession *nbd_get_client_session(BlockDriverState *bs);
> diff --git a/block/nbd-client.c b/block/nbd-client.c
> index 25dd28406b..422ecb4307 100644
> --- a/block/nbd-client.c
> +++ b/block/nbd-client.c
> @@ -73,7 +73,7 @@ static coroutine_fn void nbd_read_reply_entry(void *o=
paque)
>       int ret;
>       Error *local_err =3D NULL;
>
> -    for (;;) {
> +    while (!s->quit) {
>           assert(s->reply.handle =3D=3D 0);
>           ret =3D nbd_receive_reply(s->ioc, &s->reply, &local_err);
>           if (ret < 0) {
> @@ -107,6 +107,9 @@ static coroutine_fn void nbd_read_reply_entry(void =
*opaque)
>           qemu_coroutine_yield();
>       }
>
> +    if (ret < 0) {
> +        s->quit =3D true;

but on wrong handle ret is 0:

 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret <=3D 0) {
break;
}

 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* There's no need for a mute=
x on the receive side, because the
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * handler acts as a syn=
chronization point and ensures that only
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * one coroutine is call=
ed until the reply finishes.
*/
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i =3D HANDLE_TO_INDEX(s, s->r=
eply.handle);
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (i >=3D MAX_NBD_REQUESTS |=
| !s->recv_coroutine[i]) {
break;
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }


looks like we should set ret in this if-block

> +    }
>       nbd_recv_coroutines_enter_all(s);
>       s->read_reply_co =3D NULL;
>   }
> @@ -135,6 +138,10 @@ static int nbd_co_send_request(BlockDriverState *b=
s,
>       assert(i < MAX_NBD_REQUESTS);
>       request->handle =3D INDEX_TO_HANDLE(s, i);
>
> +    if (s->quit) {
> +        qemu_co_mutex_unlock(&s->send_mutex);
> +        return -EIO;
> +    }
>       if (!s->ioc) {
>           qemu_co_mutex_unlock(&s->send_mutex);
>           return -EPIPE;
> @@ -143,7 +150,7 @@ static int nbd_co_send_request(BlockDriverState *bs=
,
>       if (qiov) {
>           qio_channel_set_cork(s->ioc, true);
>           rc =3D nbd_send_request(s->ioc, request);
> -        if (rc >=3D 0) {
> +        if (rc >=3D 0 && !s->quit) {
>               ret =3D nbd_rwv(s->ioc, qiov->iov, qiov->niov, request->l=
en, false,
>                             NULL);
>               if (ret !=3D request->len) {
> @@ -154,6 +161,9 @@ static int nbd_co_send_request(BlockDriverState *bs=
,
>       } else {
>           rc =3D nbd_send_request(s->ioc, request);
>       }
> +    if (rc < 0) {
> +        s->quit =3D true;
> +    }
>       qemu_co_mutex_unlock(&s->send_mutex);
>       return rc;
>   }
> @@ -168,8 +178,7 @@ static void nbd_co_receive_reply(NBDClientSession *=
s,
>       /* Wait until we're woken up by nbd_read_reply_entry.  */
>       qemu_coroutine_yield();
>       *reply =3D s->reply;
> -    if (reply->handle !=3D request->handle ||
> -        !s->ioc) {
> +    if (reply->handle !=3D request->handle || !s->ioc || s->quit) {
>           reply->error =3D EIO;
>       } else {
>           if (qiov && reply->error =3D=3D 0) {


--=20
Best regards,
Vladimir
