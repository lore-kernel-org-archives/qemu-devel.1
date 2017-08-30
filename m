Received: from eggs.gnu.org ([2001:4830:134:3::10]:45782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dn8qf-0004NZ-OK
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 15:40:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dn8qe-0007Tq-RS
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 15:40:25 -0400
References: <cover.1504112061.git.jcody@redhat.com>
	<af4268153bce149a9599e4079a0f8908e32fdef8.1504112061.git.jcody@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <94eb9a23-1cb7-a139-039e-4d0f138a6244@redhat.com>
Date: Wed, 30 Aug 2017 14:40:16 -0500
MIME-Version: 1.0
In-Reply-To: <af4268153bce149a9599e4079a0f8908e32fdef8.1504112061.git.jcody@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3NAxNq8j9SubV9Mguhf5N9HthrlRDhWXU"
Subject: Re: [Qemu-devel] [PATCH v2 1/7] block/ssh: don't call
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
Cc: mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, kwolf@redhat.com, rjones@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3NAxNq8j9SubV9Mguhf5N9HthrlRDhWXU
From: Eric Blake <eblake@redhat.com>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, kwolf@redhat.com,
 rjones@redhat.com, qemu-block@nongnu.org
Message-ID: <94eb9a23-1cb7-a139-039e-4d0f138a6244@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/7] block/ssh: don't call libssh2_init()
 in block_init()
References: <cover.1504112061.git.jcody@redhat.com>
 <af4268153bce149a9599e4079a0f8908e32fdef8.1504112061.git.jcody@redhat.com>
In-Reply-To: <af4268153bce149a9599e4079a0f8908e32fdef8.1504112061.git.jcody@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/30/2017 11:56 AM, Jeff Cody wrote:
> We don't need libssh2 failure to be fatal (we could just opt to not
> register the driver on failure). But, it is probably a good idea to
> avoid external library calls during the block_init(), and call the
> libssh2 global init function on the first usage, returning any errors.
>=20
> Signed-off-by: Jeff Cody <jcody@redhat.com>
> ---
>  block/ssh.c | 40 +++++++++++++++++++++++++++++-----------
>  1 file changed, 29 insertions(+), 11 deletions(-)
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
> +            return ret;

Do we know if this number is always positive or negative?

> @@ -772,8 +788,13 @@ static int ssh_file_open(BlockDriverState *bs, QDi=
ct *options, int bdrv_flags,
>      BDRVSSHState *s =3D bs->opaque;
>      int ret;
>      int ssh_flags;
> +    Error *local_err =3D NULL;
> =20
> -    ssh_state_init(s);
> +    ret =3D ssh_state_init(s, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return ret;

Is returning 'ret' from libssh2_init() wise?

If 'ret' is not important, you could simplify this:

if (ssh_state_init(s, errp)) {
    return -1;
}

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--3NAxNq8j9SubV9Mguhf5N9HthrlRDhWXU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmnFKAACgkQp6FrSiUn
Q2o/fAf+J8u8JWcXAN7bqKxr+esuyf14kt7ivF1ye/GQ5ShGGvlN9eaFG+clUEc4
jynTz3mXmzLHyDj7Yx5jEP1x5y1m4NINla8wGtzKUgMAxm0ZwBhkm+n23EaRAtHu
jcIPe/JmojwYYJlFd8E63xY+4QU3WyjGfAbjVe7VKLGt+XdnkXcnjaOB2rl3vzuD
tpzV6PIqqBpOtaapOPwAmsjXji1LMlc5azh0aNzR5HnpuUTs+bXWj+brKndTgfhh
eudPm7ERj0SYPBeTXIlYIb+UEykbutvfRDVPeCec+2FP/hvv06+aeF/4TNcfPDti
rcZwDN7fg6X56jt478LltCRXiB9jFw==
=BmRE
-----END PGP SIGNATURE-----

--3NAxNq8j9SubV9Mguhf5N9HthrlRDhWXU--
