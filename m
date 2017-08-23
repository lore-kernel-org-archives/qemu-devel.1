Received: from eggs.gnu.org ([2001:4830:134:3::10]:59638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dkXcz-0006V1-Dd
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 11:31:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dkXcv-0006XQ-7g
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 11:31:33 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:47839 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dkXcu-0006U5-NK
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 11:31:29 -0400
Received: from [172.16.24.243] (msk-vpn.virtuozzo.com [195.214.232.6])
	by relay.sw.ru (8.13.4/8.13.4) with ESMTP id v7NFVOSL021523
	for <qemu-devel@nongnu.org>; Wed, 23 Aug 2017 18:31:25 +0300 (MSK)
References: <20170822125113.5025-1-stefanha@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <2f1cfb90-a5e3-c4b4-d497-056d22b7fe59@virtuozzo.com>
Date: Wed, 23 Aug 2017 18:31:24 +0300
MIME-Version: 1.0
In-Reply-To: <20170822125113.5025-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] nbd-client: avoid spurious
 qio_channel_yield() re-entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

22.08.2017 15:51, Stefan Hajnoczi wrote:
> The following scenario leads to an assertion failure in
> qio_channel_yield():
>
> 1. Request coroutine calls qio_channel_yield() successfully when sendin=
g
>     would block on the socket.  It is now yielded.
> 2. nbd_read_reply_entry() calls nbd_recv_coroutines_enter_all() because
>     nbd_receive_reply() failed.
> 3. Request coroutine is entered and returns from qio_channel_yield().
>     Note that the socket fd handler has not fired yet so
>     ioc->write_coroutine is still set.
> 4. Request coroutine attempts to send the request body with nbd_rwv()
>     but the socket would still block.  qio_channel_yield() is called
>     again and assert(!ioc->write_coroutine) is hit.
>
> The problem is that nbd_read_reply_entry() does not distinguish between
> request coroutines that are waiting to receive a reply and those that
> are not.
>
> This patch adds a per-request bool receiving flag so
> nbd_read_reply_entry() can avoid spurious aio_wake() calls.
>
> Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> This should fix the issue that Dave is seeing but I'm concerned that
> there are more problems in nbd-client.c.  We don't have good
> abstractions for writing coroutine socket I/O code.  Something like Go'=
s
> channels would avoid manual low-level coroutine calls.  There is
> currently no way to cancel qio_channel_yield() so requests doing I/O ma=
y
> remain in-flight indefinitely and nbd-client.c doesn't join them...
>
>   block/nbd-client.h |  7 ++++++-
>   block/nbd-client.c | 35 ++++++++++++++++++++++-------------
>   2 files changed, 28 insertions(+), 14 deletions(-)
>
> diff --git a/block/nbd-client.h b/block/nbd-client.h
> index 1935ffbcaa..b435754b82 100644
> --- a/block/nbd-client.h
> +++ b/block/nbd-client.h
> @@ -17,6 +17,11 @@
>  =20
>   #define MAX_NBD_REQUESTS    16
>  =20
> +typedef struct {
> +    Coroutine *coroutine;
> +    bool receiving;         /* waiting for read_reply_co? */
> +} NBDClientRequest;
> +
>   typedef struct NBDClientSession {
>       QIOChannelSocket *sioc; /* The master data channel */
>       QIOChannel *ioc; /* The current I/O channel which may differ (eg =
TLS) */
> @@ -27,7 +32,7 @@ typedef struct NBDClientSession {
>       Coroutine *read_reply_co;
>       int in_flight;
>  =20
> -    Coroutine *recv_coroutine[MAX_NBD_REQUESTS];
> +    NBDClientRequest requests[MAX_NBD_REQUESTS];
>       NBDReply reply;
>       bool quit;
>   } NBDClientSession;
> diff --git a/block/nbd-client.c b/block/nbd-client.c
> index 422ecb4307..c2834f6b47 100644
> --- a/block/nbd-client.c
> +++ b/block/nbd-client.c
> @@ -39,8 +39,10 @@ static void nbd_recv_coroutines_enter_all(NBDClientS=
ession *s)
>       int i;
>  =20
>       for (i =3D 0; i < MAX_NBD_REQUESTS; i++) {
> -        if (s->recv_coroutine[i]) {
> -            aio_co_wake(s->recv_coroutine[i]);
> +        NBDClientRequest *req =3D &s->requests[i];
> +
> +        if (req->coroutine && req->receiving) {
> +            aio_co_wake(req->coroutine);
>           }
>       }
>   }
> @@ -88,28 +90,28 @@ static coroutine_fn void nbd_read_reply_entry(void =
*opaque)
>            * one coroutine is called until the reply finishes.
>            */
>           i =3D HANDLE_TO_INDEX(s, s->reply.handle);
> -        if (i >=3D MAX_NBD_REQUESTS || !s->recv_coroutine[i]) {
> +        if (i >=3D MAX_NBD_REQUESTS ||
> +            !s->requests[i].coroutine ||
> +            !s->requests[i].receiving) {
>               break;
>           }
>  =20
> -        /* We're woken up by the recv_coroutine itself.  Note that the=
re
> +        /* We're woken up again by the request itself.  Note that ther=
e
>            * is no race between yielding and reentering read_reply_co. =
 This
>            * is because:
>            *
> -         * - if recv_coroutine[i] runs on the same AioContext, it is o=
nly
> +         * - if the request runs on the same AioContext, it is only
>            *   entered after we yield
>            *
> -         * - if recv_coroutine[i] runs on a different AioContext, reen=
tering
> +         * - if the request runs on a different AioContext, reentering
>            *   read_reply_co happens through a bottom half, which can o=
nly
>            *   run after we yield.
>            */
> -        aio_co_wake(s->recv_coroutine[i]);
> +        aio_co_wake(s->requests[i].coroutine);
>           qemu_coroutine_yield();
>       }
>  =20
> -    if (ret < 0) {
> -        s->quit =3D true;
> -    }
> +    s->quit =3D true;

good. this fixes the case when "if (i=C2=A0 >=3D MAX...)" goes here witho=
ut=20
setting ret.

>       nbd_recv_coroutines_enter_all(s);
>       s->read_reply_co =3D NULL;
>   }
> @@ -128,14 +130,17 @@ static int nbd_co_send_request(BlockDriverState *=
bs,
>       s->in_flight++;
>  =20
>       for (i =3D 0; i < MAX_NBD_REQUESTS; i++) {
> -        if (s->recv_coroutine[i] =3D=3D NULL) {
> -            s->recv_coroutine[i] =3D qemu_coroutine_self();
> +        if (s->requests[i].coroutine =3D=3D NULL) {
>               break;
>           }
>       }
>  =20
>       g_assert(qemu_in_coroutine());
>       assert(i < MAX_NBD_REQUESTS);
> +
> +    s->requests[i].coroutine =3D qemu_coroutine_self();
> +    s->requests[i].receiving =3D false;
> +
>       request->handle =3D INDEX_TO_HANDLE(s, i);
>  =20
>       if (s->quit) {
> @@ -173,10 +178,13 @@ static void nbd_co_receive_reply(NBDClientSession=
 *s,
>                                    NBDReply *reply,
>                                    QEMUIOVector *qiov)
>   {
> +    int i =3D HANDLE_TO_INDEX(s, request->handle);
>       int ret;
>  =20
>       /* Wait until we're woken up by nbd_read_reply_entry.  */
> +    s->requests[i].receiving =3D true;
>       qemu_coroutine_yield();
> +    s->requests[i].receiving =3D false;
>       *reply =3D s->reply;
>       if (reply->handle !=3D request->handle || !s->ioc || s->quit) {
>           reply->error =3D EIO;
> @@ -186,6 +194,7 @@ static void nbd_co_receive_reply(NBDClientSession *=
s,
>                             NULL);
>               if (ret !=3D request->len) {
>                   reply->error =3D EIO;
> +                s->quit =3D true;

as I understand, some fixes around s->quit are merged into this patch=20
and actually unrelated to the described problem.
Anyway, setting quite here should be not bad (I set corresponding=20
eio_to_all variable in my series on each error and check it after each=20
possible yield).

>               }
>           }
>  =20
> @@ -200,7 +209,7 @@ static void nbd_coroutine_end(BlockDriverState *bs,
>       NBDClientSession *s =3D nbd_get_client_session(bs);
>       int i =3D HANDLE_TO_INDEX(s, request->handle);
>  =20
> -    s->recv_coroutine[i] =3D NULL;
> +    s->requests[i].coroutine =3D NULL;
>  =20
>       /* Kick the read_reply_co to get the next reply.  */
>       if (s->read_reply_co) {


Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>


--=20
Best regards,
Vladimir
