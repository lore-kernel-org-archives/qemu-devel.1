Received: from eggs.gnu.org ([2001:4830:134:3::10]:42495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f1xNo-0001BN-ER
	for qemu-devel@nongnu.org; Fri, 30 Mar 2018 13:00:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f1xNn-0005TY-FA
	for qemu-devel@nongnu.org; Fri, 30 Mar 2018 13:00:08 -0400
References: <20180329231837.1914680-1-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <84116abb-5af9-a017-898e-435e089d2304@virtuozzo.com>
Date: Fri, 30 Mar 2018 19:59:49 +0300
MIME-Version: 1.0
In-Reply-To: <20180329231837.1914680-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH for-2.12] nbd/client: Correctly handle bad
 server REP_META_CONTEXT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

30.03.2018 02:18, Eric Blake wrote:
> It's never a good idea to blindly read for size bytes as
> returned by the server without first validating that the size
> is within bounds; a malicious or buggy server could cause us
> to hang or get out of sync from reading further messages.
>
> It may be smarter to try and teach the client to cope with
> unexpected context ids by silently ignoring them instead of
> hanging up on the server, but for now, if the server doesn't
> reply with exactly the one context we expect, it's easier to
> just give up - however, if we give up for any reason other
> than an I/O failure, we might as well try to politely tell
> the server we are quitting rather than continuing.
>
> Fix some typos in the process.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>   nbd/client.c | 19 +++++++++++++++++--
>   1 file changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/nbd/client.c b/nbd/client.c
> index 9b9b7f0ea29..4ee1d9a4a2c 100644
> --- a/nbd/client.c
> +++ b/nbd/client.c
> @@ -599,8 +599,8 @@ static QIOChannel *nbd_receive_starttls(QIOChannel *i=
oc,
>    * Set one meta context. Simple means that reply must contain zero (not
>    * negotiated) or one (negotiated) contexts. More contexts would be con=
sidered
>    * as a protocol error. It's also implied that meta-data query equals q=
ueried
> - * context name, so, if server replies with something different then @co=
ntext,
> - * it considered as error too.
> + * context name, so, if server replies with something different than @co=
ntext,
> + * it is considered an error too.
>    * return 1 for successful negotiation, context_id is set
>    *        0 if operation is unsupported,
>    *        -1 with errp set for any other error
> @@ -651,6 +651,14 @@ static int nbd_negotiate_simple_meta_context(QIOChan=
nel *ioc,
>           char *name;
>           size_t len;
>
> +        if (reply.length !=3D sizeof(received_id) + context_len) {
> +            error_setg(errp, "Failed to negotiate meta context '%s', ser=
ver "
> +                       "answered with unexpected length %u", context,

uint32_t, is it worth PRIu32 ? Or %u is absolutely portable in this case?

> +                       reply.length);
> +            nbd_send_opt_abort(ioc);
> +            return -1;
> +        }

hmm, after this check, len variable is not actually needed, we can use=20
context_len

> +
>           if (nbd_read(ioc, &received_id, sizeof(received_id), errp) < 0)=
 {
>               return -1;
>           }
> @@ -668,6 +676,7 @@ static int nbd_negotiate_simple_meta_context(QIOChann=
el *ioc,
>                          "answered with different context '%s'", context,
>                          name);
>               g_free(name);
> +            nbd_send_opt_abort(ioc);
>               return -1;
>           }
>           g_free(name);
> @@ -690,6 +699,12 @@ static int nbd_negotiate_simple_meta_context(QIOChan=
nel *ioc,
>       if (reply.type !=3D NBD_REP_ACK) {
>           error_setg(errp, "Unexpected reply type %" PRIx32 " expected %x=
",
>                      reply.type, NBD_REP_ACK);
> +        nbd_send_opt_abort(ioc);
> +        return -1;
> +    }
> +    if (reply.length) {

this check is very common for REP_ACK, it may be better to move it to=20
nbd_handle_reply_err... (and rename this function? and=C2=A0 combine it=20
somehow with _option_request() and _option_reply()?)

> +        error_setg(errp, "Unexpected length to ACK response");
> +        nbd_send_opt_abort(ioc);

hmm, looks like we want nbd_send_opt_abort() before most of return -1.=20
Looks like it lacks some generalization, may be want to send it at some=20
common point..

>           return -1;
>       }
>

mostly, just ideas for future refactoring, so:
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

--=20
Best regards,
Vladimir
