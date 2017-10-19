Received: from eggs.gnu.org ([2001:4830:134:3::10]:58953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e5Gna-0000ER-Sh
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 15:48:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e5GnZ-00034L-Sr
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 15:48:10 -0400
References: <20171015010131.12172-1-eblake@redhat.com>
	<20171017125710.11626-1-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <556c5686-560d-2caa-7db7-deb2e1d90a90@redhat.com>
Date: Thu, 19 Oct 2017 14:47:57 -0500
MIME-Version: 1.0
In-Reply-To: <20171017125710.11626-1-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="fruBrmTfDqqFFjoo4N1F3WEROdaj16asR"
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
--fruBrmTfDqqFFjoo4N1F3WEROdaj16asR
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org
Message-ID: <556c5686-560d-2caa-7db7-deb2e1d90a90@redhat.com>
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
>=20

> +static int nbd_co_request(BlockDriverState *bs, NBDRequest *request,
> +                          QEMUIOVector *write_qiov)
>  {

> -    return nbd_co_receive_reply(client, request->handle,
> -                                request->type =3D=3D NBD_CMD_READ ? qi=
ov : NULL);
> +    ret =3D nbd_co_receive_return_code(client, request->handle, &local=
_err);
> +    if (ret < 0) {
> +        error_report_err(local_err);
> +    }

I think this new error_report_err() is a regression in behavior.
Running the old server:

$ qemu-nbd -x foo -f qcow2 --trace=3D'nbd_*' file -r

and an old client:

$ qemu-io -f raw nbd://localhost:10809/foo
qemu-io> w 0 0
write failed: Operation not permitted
qemu-io> q

but with the new client (once I fix the bug about being able to ignore
the NBD_REP_ERR_UNSUP with non-zero length in the earlier patch):

$ ./qemu-io -f raw nbd://localhost:10809/foo
qemu-io> w 0 0
Request failed: Operation not permitted
write failed: Operation not permitted
qemu-io>

and worse, new server with new client:

$ ./qemu-io -f raw nbd://localhost:10809/foo
qemu-io> w 0 0
: Operation not permitted
write failed: Operation not permitted
qemu-io>

we don't even manage to post a sane message.

Reporting fatal errors where we lose connection with the server (or
forcefully give up on the server because it violated protocol) may be
okay, but reporting common errors where the server reported a problem
but we are still connected is too verbose.

I know I asked about errp plumbing on v3, but now I'm thinking that it
was a premature request; we either plumb in errp handling without any
new features, or we do the new features in isolation and only later see
if adding errp plumbing makes sense.  Yes, that means undoing some of
the changes you made between v3 and v4, so sorry for the churn it has
caused.

I hope to post a v5 soon with the tweaks I've made after playing with
this version.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--fruBrmTfDqqFFjoo4N1F3WEROdaj16asR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnpAW0ACgkQp6FrSiUn
Q2qBJggAkwffWRrnLzOFIyMZNTlvHHpsXteZUTlCJ4SaZ/l/Qoyr4pcKuB6B+31d
b5CSZ+WCxPeYDPxvXq3DgFe7AiBQkkuVsWNkhTU/ruMke4IwvEIztkP4m9CLIla0
99DKhMmV85k99Fl8/ZwqXnG/uwBETGrgApqH+Wmx+CWwr8StSC0S+N2C/Z1Jk/GF
IASMLFP2vklJEGctDvjcHQpsBzTGxruvxb4YOwBIMZdNVm2CA2sPpaOIhTciPN5K
/UJZASOopbyrvj1WNgiI+via6SryKcVI+NrLc/HcxtoOrEJeFhYMT/tFMDyV0FPw
cnNbwBa3JeVi3ITm/5F6GUielTcH2A==
=1ZNe
-----END PGP SIGNATURE-----

--fruBrmTfDqqFFjoo4N1F3WEROdaj16asR--
