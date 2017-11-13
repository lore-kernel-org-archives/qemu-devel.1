Received: from eggs.gnu.org ([2001:4830:134:3::10]:45867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eEKUL-0003Hj-0a
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 14:33:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eEKUJ-0003h2-T8
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 14:33:45 -0500
References: <20171027104037.8319-1-eblake@redhat.com>
	<20171027104037.8319-11-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <025d95af-d978-32a2-6a13-754496b9cc19@redhat.com>
Date: Mon, 13 Nov 2017 13:33:35 -0600
MIME-Version: 1.0
In-Reply-To: <20171027104037.8319-11-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="mFsN9BhGp3lBLUqDmjkfJXJbMgF4nWapa"
Subject: Re: [Qemu-devel] [PATCH v6 10/12] nbd/client: prepare
 nbd_receive_reply for structured reply
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, pbonzini@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mFsN9BhGp3lBLUqDmjkfJXJbMgF4nWapa
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, pbonzini@redhat.com,
 vsementsov@virtuozzo.com, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Message-ID: <025d95af-d978-32a2-6a13-754496b9cc19@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 10/12] nbd/client: prepare
 nbd_receive_reply for structured reply
References: <20171027104037.8319-1-eblake@redhat.com>
 <20171027104037.8319-11-eblake@redhat.com>
In-Reply-To: <20171027104037.8319-11-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/27/2017 05:40 AM, Eric Blake wrote:
> From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>=20
> In following patch nbd_receive_reply will be used both for simple
> and structured reply header receiving.
> NBDReply is altered into union of simple reply header and structured
> reply chunk header, simple error translation moved to block/nbd-client
> to be consistent with further structured reply error translation.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20

> -    trace_nbd_receive_reply(magic, reply->error, nbd_err_lookup(reply-=
>error),
> -                            reply->handle);
> -    reply->error =3D nbd_errno_to_system_errno(reply->error);
> -
> -    if (reply->error =3D=3D ESHUTDOWN) {
> -        /* This works even on mingw which lacks a native ESHUTDOWN */
> -        error_setg(errp, "server shutting down");
> +        trace_nbd_receive_simple_reply(reply->simple.error,
> +                                       nbd_err_lookup(reply->simple.er=
ror),
> +                                       reply->handle);
> +        if (reply->simple.error =3D=3D NBD_ESHUTDOWN) {
> +            /* This works even on mingw which lacks a native ESHUTDOWN=
 */
> +            error_setg(errp, "server shutting down");
> +            return -EINVAL;
> +        }
> +        break;
> +    case NBD_STRUCTURED_REPLY_MAGIC:
> +        ret =3D nbd_receive_structured_reply_chunk(ioc, &reply->struct=
ured, errp);
> +        if (ret < 0) {
> +            break;
> +        }
> +        trace_nbd_receive_structured_reply_chunk(reply->structured.fla=
gs,
> +                                                 reply->structured.typ=
e,
> +                                                 reply->structured.han=
dle,
> +                                                 reply->structured.len=
gth);
> +        break;

Ouch. This change means that we now handle NBD_ESHUTDOWN differently if
it was sent as a simple message than if it is sent as a structured reply
chunk.  Furthermore, reading the NBD spec:

> On a server shutdown, the server SHOULD wait for inflight requests to b=
e serviced prior to initiating a hard disconnect. A server MAY speed this=
 process up by issuing error replies. The error value issued in respect o=
f these requests and any subsequently received requests SHOULD be ESHUTDO=
WN.
>=20
> If the client receives an ESHUTDOWN error it MUST initiate a soft disco=
nnect.
>=20
> The client MAY issue a soft disconnect at any time, but SHOULD wait unt=
il there are no inflight requests first.

We had a pre-existing bug: our behavior in the simple case is wrong - we
are causing a hard disconnect (the server kills the connection) instead
of initiating a soft disconnect (wait for all other pending replies to
come in, then send no further requests other than NBD_CMD_DISC).

A hard disconnect is not the end of the world, even if it is unclean; on
the other hand, not doing a disconnect at all means the client will
continue to see ESHUTDOWN errors until it does shutdown.  Meanwhile,
refactoring block/nbd-client.c to properly drain all existing requests
while preventing future requests seems too risky for the 2.11 timeframe.
 But I don't like the discrepancy between the two styles, so for 2.11, I
think what I will do is rip out the special-casing of NBD_ESHUTDOWN.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--mFsN9BhGp3lBLUqDmjkfJXJbMgF4nWapa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloJ848ACgkQp6FrSiUn
Q2o3hgf7Bs2jVSVSIDCFAkZIIwgv3A2skke6G9RsDvzXFocx4fUYgvvG2sjF26VG
BAgagMNImQ+pATC4SaWHMpowCF2xFw4p1nhXvvjI2ukXmPeOdwnDlir80JYsg1eU
8jWrN/RhGK9lQ2CwA6mefcXM9F/7cGmN+Px+X/0zNEO5eMzh6iSb+vZb07OXEw+N
k7PS/8x289a3lZH21cnt5N9XZ11L/2bQJI9w+BKQ+hWbKbcTCIY4xeAwpG0wi3hl
7MGMdfnE1EixUJcGyj0/mOtkUG0d6OkkiVZnHedhlnCv/2ZoyUpXMhdwjK76Pi4b
pYbdRFkT9V+ecxjjjeKP7P8ESRsoFQ==
=/1rc
-----END PGP SIGNATURE-----

--mFsN9BhGp3lBLUqDmjkfJXJbMgF4nWapa--
