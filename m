Received: from eggs.gnu.org ([2001:4830:134:3::10]:44660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eB2bc-0005do-Fg
	for Qemu-devel@nongnu.org; Sat, 04 Nov 2017 13:51:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eB2bZ-0000nJ-DM
	for Qemu-devel@nongnu.org; Sat, 04 Nov 2017 13:51:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56602)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eB2bZ-0000mf-40
	for Qemu-devel@nongnu.org; Sat, 04 Nov 2017 13:51:37 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 34A22C0587E0
	for <Qemu-devel@nongnu.org>; Sat,  4 Nov 2017 17:51:35 +0000 (UTC)
References: <f88b9c1e-6331-8c7f-b748-62dc11a50c1e@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a71b6b5e-152a-af9d-efdf-316c7b926d79@redhat.com>
Date: Sat, 4 Nov 2017 18:51:23 +0100
MIME-Version: 1.0
In-Reply-To: <f88b9c1e-6331-8c7f-b748-62dc11a50c1e@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="A3C8fjfgHOSfK88dHK4IljbVtVCFIiJL9"
Subject: Re: [Qemu-devel] coroutine question, for NBD debugging
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, "Qemu-devel@nongnu.org" <Qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--A3C8fjfgHOSfK88dHK4IljbVtVCFIiJL9
From: Paolo Bonzini <pbonzini@redhat.com>
To: Eric Blake <eblake@redhat.com>,
 "Qemu-devel@nongnu.org" <Qemu-devel@nongnu.org>
Message-ID: <a71b6b5e-152a-af9d-efdf-316c7b926d79@redhat.com>
Subject: Re: coroutine question, for NBD debugging
References: <f88b9c1e-6331-8c7f-b748-62dc11a50c1e@redhat.com>
In-Reply-To: <f88b9c1e-6331-8c7f-b748-62dc11a50c1e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/11/2017 21:03, Eric Blake wrote:
> In include/qemu/coroutine.h, we have:
>=20
> /**
>  * Yield the coroutine for a given duration
>  *
>  * Behaves similarly to co_sleep_ns(), but the sleeping coroutine will =
be
>  * resumed when using aio_poll().
>  */
> void coroutine_fn co_aio_sleep_ns(AioContext *ctx, QEMUClockType type,
>=20
> but there is no co_sleep_ns() anywhere.  What should the documentation
> actually state?

The old doc comment for co_sleep_ns was:

/**
 * Yield the coroutine for a given duration
 *
 * Note this function uses timers and hence only works when a main loop i=
s in
 * use.  See main-loop.h and do not use from qemu-tool programs.
 */

So probably:

This function uses timers and hence needs to know the event loop
(#AioContext) to place the timer on.  In any case, co_aio_sleep_ns()
does not affect the #AioContext where the current coroutine is running,
as the coroutine will restart on the same #AioContext that it is
running on.

Thanks,

Paolo

>=20
> Meanwhile, I'm trying to figure out if there is an easy way to hack
> qemu-nbd to send two structured replies interleaved (as in A.1, B.1,
> A.2, B.2) to ensure the NBD client coroutines properly handle
> interleaved responses, but adding a plain sleep() between A.1 and A.2
> does not work, and I'm not sure whether co_aio_sleep_ns() would work fo=
r
> the hack instead.
>=20
> The hack I'm currently playing with splits reads and structured errors
> into two parts, attempting to use sleeps to force the server to send
> replies out of order:
>=20
> diff --git c/nbd/server.c w/nbd/server.c
> index bcf0cdb47c..4b642127bb 100644
> --- c/nbd/server.c
> +++ w/nbd/server.c
> @@ -1285,13 +1285,24 @@ static int coroutine_fn
> nbd_co_send_structured_read(NBDClient *client,
>          {.iov_base =3D &chunk, .iov_len =3D sizeof(chunk)},
>          {.iov_base =3D data, .iov_len =3D size}
>      };
> +    int ret;
>=20
>      trace_nbd_co_send_structured_read(handle, offset, data, size);
> -    set_be_chunk(&chunk.h, NBD_REPLY_FLAG_DONE, NBD_REPLY_TYPE_OFFSET_=
DATA,
> +    set_be_chunk(&chunk.h, 0, NBD_REPLY_TYPE_OFFSET_DATA,
>                   handle, sizeof(chunk) - sizeof(chunk.h) + size);
>      stq_be_p(&chunk.offset, offset);
>=20
> -    return nbd_co_send_iov(client, iov, 2, errp);
> +    ret =3D nbd_co_send_iov(client, iov, 2, errp);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    sleep(2);
> +
> +    set_be_chunk(&chunk.h, NBD_REPLY_FLAG_DONE, NBD_REPLY_TYPE_NONE,
> +                 handle, 0);
> +    iov[0].iov_len =3D sizeof(chunk.h);
> +    return nbd_co_send_iov(client, iov, 1, errp);
>  }
>=20
>  static int coroutine_fn nbd_co_send_structured_error(NBDClient *client=
,
> @@ -1306,16 +1317,27 @@ static int coroutine_fn
> nbd_co_send_structured_error(NBDClient *client,
>          {.iov_base =3D &chunk, .iov_len =3D sizeof(chunk)},
>          {.iov_base =3D (char *)msg, .iov_len =3D msg ? strlen(msg) : 0=
},
>      };
> +    int ret;
>=20
>      assert(nbd_err);
>      trace_nbd_co_send_structured_error(handle, nbd_err,
>                                         nbd_err_lookup(nbd_err), msg ?
> msg : "");
> -    set_be_chunk(&chunk.h, NBD_REPLY_FLAG_DONE, NBD_REPLY_TYPE_ERROR,
> handle,
> +    set_be_chunk(&chunk.h, 0, NBD_REPLY_TYPE_ERROR, handle,
>                   sizeof(chunk) - sizeof(chunk.h) + iov[1].iov_len);
>      stl_be_p(&chunk.error, nbd_err);
>      stw_be_p(&chunk.message_length, iov[1].iov_len);
>=20
> -    return nbd_co_send_iov(client, iov, 1 + !!iov[1].iov_len, errp);
> +    ret =3D nbd_co_send_iov(client, iov, 1 + !!iov[1].iov_len, errp);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    sleep(1);
> +
> +    set_be_chunk(&chunk.h, NBD_REPLY_FLAG_DONE, NBD_REPLY_TYPE_NONE,
> +                 handle, 0);
> +    iov[0].iov_len =3D sizeof(chunk.h);
> +    return nbd_co_send_iov(client, iov, 1, errp);
>  }
>=20
>  /* nbd_co_receive_request
>=20
>=20
> coupled with a client that does:
>=20
> $ ./qemu-io -f raw nbd://localhost:10809/foo --trace=3D'nbd_*' -c
> 'aio_write -P 3 1 1' -c 'aio_read -P 1 1 1'
>=20
> but the trace shows that the client does not receive B.1 until after it=

> has blocked waiting for A.2, which is not what I was hoping to see.
>=20



--A3C8fjfgHOSfK88dHK4IljbVtVCFIiJL9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAln9/h8ACgkQv/vSX3jH
roPbKgf9FNlLUtzb0VlieSc9JWwNdDfYteLNevaK1WM4n6reux116r3dBWjij/+G
hTz8jJFncNavkx3kdyeR0PGrxVFv4fKOJSt4PGnJHPGS8IhNoukEEzNapiLuK5q1
BdvUxeGaXSyrMS90fAYj64hfWoMDOMQdZ8AJEzhtZVTelwISJqdnbU85a/8JRlVB
J1DUaOZZUK2LB+lQMZQBCiWTSMzjk/0le17kqstQZ/NvzxAUfPbIFP22+I5TG0Qb
32RURs3Wd7F8WKDM80yDm0wIRzbLD5hLGg8scvsGWLzWzYGu4pTjbVaMk+7zjz67
0rnRk2tX5eq49HU7pbvd182SsnyYSw==
=pfzn
-----END PGP SIGNATURE-----

--A3C8fjfgHOSfK88dHK4IljbVtVCFIiJL9--
