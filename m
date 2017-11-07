Received: from eggs.gnu.org ([2001:4830:134:3::10]:41139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eCCg4-0001d6-FP
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 17:49:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eCCg3-0008Ht-JD
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 17:49:04 -0500
References: <cover.1510093478.git.jcody@redhat.com>
	<27e0bf9dfb1370e8beb08c7b5ad6894540fff13a.1510093478.git.jcody@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <41cfae9c-b487-89c1-47fd-778dd98968a0@redhat.com>
Date: Tue, 7 Nov 2017 16:48:54 -0600
MIME-Version: 1.0
In-Reply-To: <27e0bf9dfb1370e8beb08c7b5ad6894540fff13a.1510093478.git.jcody@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="fTnr9HEiJcpDxKnew0FvJXa14jtxePFos"
Subject: Re: [Qemu-devel] [PATCH v3 1/7] block/ssh: don't call
 libssh2_init() in block_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, rjones@redhat.com, kwolf@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fTnr9HEiJcpDxKnew0FvJXa14jtxePFos
From: Eric Blake <eblake@redhat.com>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp,
 namei.unix@gmail.com, rjones@redhat.com, kwolf@redhat.com
Message-ID: <41cfae9c-b487-89c1-47fd-778dd98968a0@redhat.com>
Subject: Re: [PATCH v3 1/7] block/ssh: don't call libssh2_init() in
 block_init()
References: <cover.1510093478.git.jcody@redhat.com>
 <27e0bf9dfb1370e8beb08c7b5ad6894540fff13a.1510093478.git.jcody@redhat.com>
In-Reply-To: <27e0bf9dfb1370e8beb08c7b5ad6894540fff13a.1510093478.git.jcody@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/07/2017 04:27 PM, Jeff Cody wrote:
> We don't need libssh2 failure to be fatal (we could just opt to not
> register the driver on failure). But, it is probably a good idea to
> avoid external library calls during the block_init(), and call the
> libssh2 global init function on the first usage, returning any errors.
>=20
> Signed-off-by: Jeff Cody <jcody@redhat.com>
> ---
>  block/ssh.c | 37 ++++++++++++++++++++++++++-----------
>  1 file changed, 26 insertions(+), 11 deletions(-)
>=20
> +static int ssh_state_init(BDRVSSHState *s, Error **errp)
>  {
> +    int ret;
> +
> +    if (!ssh_libinit_called) {
> +        ret =3D libssh2_init(0);
> +        if (ret) {
> +            error_setg(errp, "libssh2 initialization failed with %d", =
ret);

Maybe s/with %d/with status %d/

> +            return ret;

This is returning a non-zero value, but not necessarily a negative errno.=
=2E.

> @@ -821,8 +839,13 @@ static int ssh_create(const char *filename, QemuOp=
ts *opts, Error **errp)
>      BDRVSSHState s;
>      ssize_t r2;
>      char c[1] =3D { '\0' };
> +    Error *local_err =3D NULL;
> =20
> -    ssh_state_init(&s);
> +    ret =3D ssh_state_init(&s, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return ret;

=2E..but this function wants to return a negative errno.  I think you can=

rewrite this to:

if (ssh_state_init(&s, errp)) {
    return -EIO;
}

and skip out on local_err.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--fTnr9HEiJcpDxKnew0FvJXa14jtxePFos
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloCOFYACgkQp6FrSiUn
Q2r3PQf/U3f+1mXre+DpMBOqAAFUBgfZQQ9z7GD7G4p8gUEbWQodMXb1akmUBysI
jRKPpTTX4VoUlVK1753AVHWB8T2qndaswy4YZzkv5yqO5RsdeJccgDK97muEddKk
uCK4JAacxJjXvA/DjLv0r93bfi9cEK3GR7xDK2rjPc5eNKAnBHksHIukqWyM5pFC
NqZTwD4//cAOJcYE9hT+4GzhhS/dpa/ZG/+JGATTYVXsC2+iDIusCBXDZdgA3v2b
jUw+b3DXAxC4/SZz4RkkMaKI82+pxVg0atWrVQOXunQ9OFFrieq2ruUQGZT3vHLu
9E/9YE3zLqZQ2ZpOysuqTLNInjgCcA==
=yb3r
-----END PGP SIGNATURE-----

--fTnr9HEiJcpDxKnew0FvJXa14jtxePFos--
