Received: from eggs.gnu.org ([2001:4830:134:3::10]:50069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e5G9L-0004h5-CI
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 15:06:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e5G9K-0000Cf-3J
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 15:06:35 -0400
References: <20171015010131.12172-1-eblake@redhat.com>
	<20171017125710.11626-1-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9e1de427-f3bd-074b-ada5-b14b97579272@redhat.com>
Date: Thu, 19 Oct 2017 14:06:23 -0500
MIME-Version: 1.0
In-Reply-To: <20171017125710.11626-1-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="WRBGr3b3qB1TdHjR4IBB98fv2hRh0nNo8"
Subject: Re: [Qemu-devel] [PATCH v4 RFC 9/8] nbd: Minimal structured read
 for client
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WRBGr3b3qB1TdHjR4IBB98fv2hRh0nNo8
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org
Message-ID: <9e1de427-f3bd-074b-ada5-b14b97579272@redhat.com>
Subject: Re: [PATCH v4 RFC 9/8] nbd: Minimal structured read for client
References: <20171015010131.12172-1-eblake@redhat.com>
 <20171017125710.11626-1-vsementsov@virtuozzo.com>
In-Reply-To: <20171017125710.11626-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/17/2017 07:57 AM, Vladimir Sementsov-Ogievskiy wrote:
> Minimal implementation: for structured error only error_report error
> message.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---

and I replied:
>=20
> But in the client, I then perform 'w 0 0' (a zero-byte write, which
> should fail because the server is read-only).  I see:
>=20
> C: 19481@1508268433.381446:nbd_send_request Sending request to server: =
{
> .from =3D 0, .len =3D 0, .handle =3D 93997172956880, .flags =3D 0x1, .t=
ype =3D 1
> (write) }
> S: 19479@1508268433.381516:nbd_receive_request Got request: { magic =3D=

> 0x25609513, .flags =3D 0x1, .type =3D 0x1, from =3D 0, len =3D 0 }
> S: 19479@1508268433.381527:nbd_co_receive_request_decode_type Decoding
> type: handle =3D 93997172956880, type =3D 1 (write)
> S: 19479@1508268433.381540:nbd_co_receive_request_payload_received
> Payload received: handle =3D 93997172956880, len =3D 0
> S: 19479@1508268433.381564:nbd_co_send_structured_error Send structured=

> error reply: handle =3D 93997172956880, error =3D 1 (EPERM), msg =3D ''=

> C: 19481@1508268433.381622:nbd_receive_structured_reply_chunk Got
> structured reply chunk: { flags =3D 0x1, type =3D 32769, handle =3D
> 93997172956880, length =3D 6 }
> C: wrote 0/0 bytes at offset 0
> C: 0 bytes, 1 ops; 0.0002 sec (0 bytes/sec and 4291.8455 ops/sec)
>=20
> Oops - the client claimed success, even though the server replied with
> EPERM.  And the server didn't do a good job of including details on the=

> error message.  So there's still some tweaks needed.

Okay, I found that issue:

> +static int nbd_parse_error_payload(NBDStructuredReplyChunk *chunk,
> +                                   uint8_t *payload, int *request_ret,=

> +                                   Error **errp)
> +{
> +    uint32_t error;
> +    uint16_t message_size;
> +
> +    assert(chunk->type & (1 << 15));
> +
> +    if (chunk->length < sizeof(error) + sizeof(message_size)) {
> +        error_setg(errp,
> +                   "Protocol error: invalid payload for structured err=
or");
> +        return -EINVAL;
> +    }
> +
> +    error =3D nbd_errno_to_system_errno(payload_advance32(&payload));
> +    if (error =3D=3D 0) {
> +        error_setg(errp, "Protocol error: server sent structured error=
 chunk"
> +                         "with error =3D 0");
> +        return -EINVAL;
> +    }
> +
> +    *request_ret =3D error;

Here, you set *request_ret to a positive value when the server gives an
error,

> +static coroutine_fn int nbd_co_do_receive_one_chunk(
> +        NBDClientSession *s, uint64_t handle, bool only_structured,
> +        int *request_ret, QEMUIOVector *qiov, void **payload, Error **=
errp)
>  {

> -    } else {
> -        assert(s->reply.handle =3D=3D handle);
> -        ret =3D -nbd_errno_to_system_errno(s->reply.simple.error);
> -        if (qiov && ret =3D=3D 0) {
> -            if (qio_channel_readv_all(s->ioc, qiov->iov, qiov->niov,
> -                                      NULL) < 0) {
> -                ret =3D -EIO;
> -                s->quit =3D true;
> +        error_setg(errp, "Connection closed");
> +        return -EIO;
> +    }
> +
> +    assert(s->reply.handle =3D=3D handle);
> +
> +    if (nbd_reply_is_simple(&s->reply)) {
> +        if (only_structured) {
> +            error_setg(errp, "Protocol error: simple reply when struct=
ured"
> +                             "reply chunk was expected");
> +            return -EINVAL;
> +        }
> +
> +        *request_ret =3D -nbd_errno_to_system_errno(s->reply.simple.er=
ror);

But here, you set it to a negative value,

> +/* nbd_reply_chunk_iter_receive
> + * The pointer stored in @payload requires qemu_vfree() to free it.
> + */
> +static bool nbd_reply_chunk_iter_receive(NBDClientSession *s,
> +                                         NBDReplyChunkIter *iter,
> +                                         uint64_t handle,
> +                                         QEMUIOVector *qiov, NBDReply =
*reply,
> +                                         void **payload)
> +{
> +    int ret;
> +    NBDReply local_reply;
> +    NBDStructuredReplyChunk *chunk;
> +    Error *local_err =3D NULL;
> +    if (s->quit) {
> +        error_setg(&local_err, "Connection closed");
> +        nbd_iter_error(iter, true, -EIO, &local_err);
> +        goto break_loop;
> +    }
> +
> +    if (iter->done) {
> +        /* Previous iteration was last. */
> +        goto break_loop;
> +    }
> +
> +    if (reply =3D=3D NULL) {
> +        reply =3D &local_reply;
> +    }
> +
> +    ret =3D nbd_co_receive_one_chunk(s, handle, iter->only_structured,=

> +                                   qiov, reply, payload, &local_err);
> +    if (ret < 0) {
> +        /* If it is a fatal error s->quit is set by nbd_co_receive_one=
_chunk */
> +        nbd_iter_error(iter, s->quit, ret, &local_err);
> +    }

and you only ever set iter.ret to non-zero if the value was negative (so
you were missing all errors sent through a structured reply).

There was a lot of back-and-forth hunting through the code to see where
errors flow.  I wonder if our intermediate processing should try harder
to distinguish between NBD errors sent by the server (but the connection
is still good - aka not a fatal error for the receive loop but does
affect the end client) vs. those detected locally (server sent garbage
or our connection failed, either way, the error is fatal and we won't
ever talk to the server again).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--WRBGr3b3qB1TdHjR4IBB98fv2hRh0nNo8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlno968ACgkQp6FrSiUn
Q2rF7wf/Qsu249EV84eO8LrLm+vB4cS3FX8bhwquWz55fqXxwY+kvN+lCxr2PSXW
aQgLViqjtTxZrnOgYhg5Ukgm+d/PL/FmYrdXCS+Pse7rFmAikCMe8cEtOCR8fRJ3
JasGL4UyW3dQTeaUBGDgobZ/Y/BY3NHJ4SW1y5ULNOTQzFs7JoaeNBGU0upKWkbY
3ybh7bqan2ixYqLaE/tnJ63jkqhsdUAi19uguH1ktv8Xb4yTarY0FNPXrHpqashA
32Ra3X0E3cs02xwjABetJwtoUL/kjHCMLkCBGDrOM3dU8J6Q398ZQgKx8qRVA/MX
e9oAzt2xnKGJX/Flsid1wHW2E9PoaA==
=heVM
-----END PGP SIGNATURE-----

--WRBGr3b3qB1TdHjR4IBB98fv2hRh0nNo8--
