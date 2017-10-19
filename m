Received: from eggs.gnu.org ([2001:4830:134:3::10]:55929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e5GY3-0004Sk-Pg
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 15:32:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e5GXx-0008IJ-Qt
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 15:32:07 -0400
References: <20171015010131.12172-1-eblake@redhat.com>
	<20171015010131.12172-7-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bf5851de-9551-2eb8-9727-0d316822ea5b@redhat.com>
Date: Thu, 19 Oct 2017 14:31:54 -0500
MIME-Version: 1.0
In-Reply-To: <20171015010131.12172-7-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="rVBrciF21wSp43QNcBpNERx8Kqpsac3fT"
Subject: Re: [Qemu-devel] [PATCH v4 6/8] nbd/client: refactor
 nbd_receive_starttls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, vsementsov@virtuozzo.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rVBrciF21wSp43QNcBpNERx8Kqpsac3fT
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, vsementsov@virtuozzo.com,
 qemu-block@nongnu.org
Message-ID: <bf5851de-9551-2eb8-9727-0d316822ea5b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 6/8] nbd/client: refactor
 nbd_receive_starttls
References: <20171015010131.12172-1-eblake@redhat.com>
 <20171015010131.12172-7-eblake@redhat.com>
In-Reply-To: <20171015010131.12172-7-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/14/2017 08:01 PM, Eric Blake wrote:
> From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>=20
> Split out nbd_request_simple_option to be reused for structured reply
> option.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20

> +static int nbd_request_simple_option(QIOChannel *ioc, int opt, Error *=
*errp)
> +{
> +    nbd_opt_reply reply;
> +
> +    if (nbd_send_option_request(ioc, opt, 0, NULL, errp) < 0) {
> +        return -1;
> +    }
> +
> +    if (nbd_receive_option_reply(ioc, opt, &reply, errp) < 0) {
> +        return -1;
> +    }
> +
> +    if (reply.length !=3D 0) {
> +        error_setg(errp, "Option %d ('%s') response length is %" PRIu3=
2
> +                   " (it should be zero)", opt, nbd_opt_lookup(opt),
> +                   reply.length);
> +        nbd_send_opt_abort(ioc);
> +        return -1;
> +    }
> +
> +    if (reply.type =3D=3D NBD_REP_ERR_UNSUP) {
> +        return 0;
> +    }

Oops, these two conditions are swapped.  A non-zero reply length is
perfectly acceptable if the server is sending NBD_REP_ERR_UNSUP with an
error message (as is the case with old qemu server, new qemu client).
We can only enforce non-zero length...

> +
> +    if (reply.type !=3D NBD_REP_ACK) {
> +        error_setg(errp, "Server rejected request for option %d (%s) "=

> +                   "with reply %" PRIx32 " (%s)", opt, nbd_opt_lookup(=
opt),
> +                   reply.type, nbd_rep_lookup(reply.type));
> +        nbd_send_opt_abort(ioc);
> +        return -1;
> +    }
> +

=2E..here, after we know we got an ACK.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--rVBrciF21wSp43QNcBpNERx8Kqpsac3fT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlno/aoACgkQp6FrSiUn
Q2rw6gf/Y+icF6AIoQts+dbdZmYTLlY0b1RIgptlMiK9VneTcdjGVcecqDa3WaxV
XsNw8sYpJPowLtpO1/qpsjwIWNN5sb1Ko+w+KHh90c94TIWMopwlEOT0y21yrLZa
bAARukSfURKkRkU8B5OgOSTVol3koyhgRRHGVO2joAGKpYBGUyJltXFkSTd1rSid
LxIHxzsK2E2C6R89dEnIw6IOJm8a5A5oGESsMvdrNXt/0uFQ8BbGMlnohuf0PLO0
6xHpS2bp/i72hW3LpiI9A9Lds5MfgPvrQ33kF0h3Z68hRrSbVJ4UIlmYJC8xsDlm
0y2geKf8FYvUXvJ6F0OT0fC6fZ9Srw==
=MTaL
-----END PGP SIGNATURE-----

--rVBrciF21wSp43QNcBpNERx8Kqpsac3fT--
