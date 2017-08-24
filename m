Received: from eggs.gnu.org ([2001:4830:134:3::10]:52654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dkutP-0005Rq-1B
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 12:22:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dkutO-0002rU-2O
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 12:22:03 -0400
References: <20170824153345.2244-1-stefanha@redhat.com>
	<20170824153345.2244-2-stefanha@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a839e5fa-0495-902c-5a20-6592ab07bb9e@redhat.com>
Date: Thu, 24 Aug 2017 18:21:50 +0200
MIME-Version: 1.0
In-Reply-To: <20170824153345.2244-2-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/3] nbd-client: enter read_reply_co during
 init to avoid crash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org

On 24/08/2017 17:33, Stefan Hajnoczi wrote:
> This patch enters read_reply_co directly in
> nbd_client_attach_aio_context().  This is safe because new_context is
> acquired by the caller.  This ensures that read_reply_co reaches its
> first yield point and its ctx is set up.

I'm not very confident with this patch.  aio_context_acquire/release is
going to go away, and this then becomes possible

	main context			new_context
	qemu_aio_coroutine_enter
					send request
					wait for reply
	read first reply
	wake coroutine

where the "wake coroutine" part thinks it's running in new_context, and
thus simply enters the coroutine instead of using the bottom half.

But blk_co_preadv() should need the read_reply_co itself, in order to be
woken up after reading the reply header.  The core issue here is that
nbd_co_receive_reply was never called, I suspect.  And if it was never
called, read_reply_co should not be woken up by nbd_coroutine_end.

So the fix is:

1) assign NULL to s->recv_coroutine[i] when nbd_co_send_request fails

2) move this to nbd_co_receive_reply:

    s->recv_coroutine[i] =3D NULL;

    /* Kick the read_reply_co to get the next reply.  */
    if (s->read_reply_co) {
        aio_co_wake(s->read_reply_co);
    }

Does this make sense?  (Note that the read_reply_co idea actually came
from you, or from my recollections of your proposed design :)).

Paolo

> Note this only happens with UNIX domain sockets on Linux.  It doesn't
> seem possible to reproduce this with TCP sockets.
>=20
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  block/nbd-client.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/block/nbd-client.c b/block/nbd-client.c
> index 25bcaa2346..0a7f32779e 100644
> --- a/block/nbd-client.c
> +++ b/block/nbd-client.c
> @@ -371,7 +371,7 @@ void nbd_client_attach_aio_context(BlockDriverState=
 *bs,
>  {
>      NBDClientSession *client =3D nbd_get_client_session(bs);
>      qio_channel_attach_aio_context(QIO_CHANNEL(client->ioc), new_conte=
xt);
> -    aio_co_schedule(new_context, client->read_reply_co);
> +    qemu_aio_coroutine_enter(new_context, client->read_reply_co);
>  }
