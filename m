Received: from eggs.gnu.org ([2001:4830:134:3::10]:40513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpIXv-0003Xe-KJ
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 14:26:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpIXq-00013J-Fn
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 14:25:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41484)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dpIXq-00011t-66
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 14:25:54 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 70112C0753D6
	for <qemu-devel@nongnu.org>; Tue,  5 Sep 2017 18:25:52 +0000 (UTC)
References: <20170831094643.22567-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <334b0d5c-aff2-ca40-b02a-4c95e822c53c@redhat.com>
Date: Tue, 5 Sep 2017 13:25:50 -0500
MIME-Version: 1.0
In-Reply-To: <20170831094643.22567-1-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="9IJBX8Gub3C3t0VGIVh4vqrNde7mQh2PK"
Subject: Re: [Qemu-devel] [PATCH v2] io: add new qio_channel_{readv, writev,
 read, write}_all functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9IJBX8Gub3C3t0VGIVh4vqrNde7mQh2PK
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>
Message-ID: <334b0d5c-aff2-ca40-b02a-4c95e822c53c@redhat.com>
Subject: Re: [PATCH v2] io: add new qio_channel_{readv, writev, read,
 write}_all functions
References: <20170831094643.22567-1-berrange@redhat.com>
In-Reply-To: <20170831094643.22567-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/31/2017 04:46 AM, Daniel P. Berrange wrote:
> These functions wait until they are able to read / write the full
> requested data buffer(s).
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>=20
> Changed in v2:
>=20
>  - Remove 'coroutine_fn' annotation (Stefan)
>  - Fix docs typos (Eric)
>  - Remove bogus error overwriting (Eric)
>=20
>  include/io/channel.h       |  90 +++++++++++++++++++++++++++++++++++++=
++
>  io/channel.c               |  94 +++++++++++++++++++++++++++++++++++++=
++++
>  tests/io-channel-helpers.c | 102 ++++---------------------------------=
--------
>  3 files changed, 193 insertions(+), 93 deletions(-)

Already applied, but just now noticing two things:

>=20
> diff --git a/include/io/channel.h b/include/io/channel.h
> index 54f3dc252f..8f25893c45 100644
> --- a/include/io/channel.h
> +++ b/include/io/channel.h
> @@ -269,6 +269,58 @@ ssize_t qio_channel_writev_full(QIOChannel *ioc,
>                                  Error **errp);
> =20
>  /**
> + * qio_channel_readv_all:
> + * @ioc: the channel object
> + * @iov: the array of memory regions to read data into
> + * @niov: the length of the @iov array
> + * @errp: pointer to a NULL-initialized error object
> + *
> + * Read data from the IO channel, storing it in the
> + * memory regions referenced by @iov. Each element
> + * in the @iov will be fully populated with data
> + * before the next one is used. The @niov parameter
> + * specifies the total number of elements in @iov.
> + *
> + * The function will wait for all requested data
> + * to be read, yielding from the current coroutine
> + * if required.

[1] This states we yield...

> + *
> + * If end-of-file occurs before all requested data
> + * has been read, an error will be reported.

[2] nbd_read_eof() can't use this function, because it wants to
distinguish between early EOF (no data at all - server quit at a sane
point in the protocol, so the client doesn't need to report an error but
just start clean shutdown) and short read (EOF encountered after at
least one byte was read - server quit mid-message and client must report
the error).  But we don't want all callers to have to check for this
corner-case.  Obvious solution: add qio_channel_readv_all_eof() (I've
got the patch ready to submit, and can take it through my NBD tree since
I'm also patch nbd to take advantage of these new functions).

> +int qio_channel_readv_all(QIOChannel *ioc,

> + *
> + * The function will wait for all requested data
> + * to be written, yielding from the current coroutine
> + * if required.

[1] again

> +++ b/io/channel.c
> @@ -22,6 +22,7 @@
>  #include "io/channel.h"
>  #include "qapi/error.h"
>  #include "qemu/main-loop.h"
> +#include "qemu/iov.h"
> =20
>  bool qio_channel_has_feature(QIOChannel *ioc,
>                               QIOChannelFeature feature)
> @@ -85,6 +86,79 @@ ssize_t qio_channel_writev_full(QIOChannel *ioc,
>  }
> =20
> =20
> +
> +int qio_channel_readv_all(QIOChannel *ioc,
> +                          const struct iovec *iov,
> +                          size_t niov,
> +                          Error **errp)
> +{
> +    int ret =3D -1;
> +    struct iovec *local_iov =3D g_new(struct iovec, niov);
> +    struct iovec *local_iov_head =3D local_iov;
> +    unsigned int nlocal_iov =3D niov;
> +
> +    nlocal_iov =3D iov_copy(local_iov, nlocal_iov,
> +                          iov, niov,
> +                          0, iov_size(iov, niov));
> +
> +    while (nlocal_iov > 0) {
> +        ssize_t len;
> +        len =3D qio_channel_readv(ioc, local_iov, nlocal_iov, errp);
> +        if (len =3D=3D QIO_CHANNEL_ERR_BLOCK) {
> +            qio_channel_wait(ioc, G_IO_IN);

[1] Wait a minute. qio_channel_wait() spawns a NEW coroutine, rather
than yielding the current coroutine. nbd_rwv() was using
qio_channel_yield() here (after asserting that QIO_CHANNEL_ERR_BLOCK is
only possible for a non-blocking channel).  Keeping the wait in place
breaks iotests (things hang), while s/wait/yield/ lets NBD get through
iotests, but then breaks check-tests/test-io/channel-socket.  So I think
we have to make the code choose between the two conditions according to
whether it is currently in a coroutine.  I'll propose that patch, and
see what you say about it :)

> +            continue;
> +        } else if (len < 0) {
> +            goto cleanup;
> +        } else if (len =3D=3D 0) {
> +            error_setg(errp,
> +                       "Unexpected end-of-file before all bytes were r=
ead");

[2] This is where the special-casing for early EOF vs. short read fits.


> +int qio_channel_writev_all(QIOChannel *ioc,
> +                           const struct iovec *iov,
> +                           size_t niov,
> +                           Error **errp)
> +{
> +    int ret =3D -1;
> +    struct iovec *local_iov =3D g_new(struct iovec, niov);
> +    struct iovec *local_iov_head =3D local_iov;
> +    unsigned int nlocal_iov =3D niov;
> +
> +    nlocal_iov =3D iov_copy(local_iov, nlocal_iov,
> +                          iov, niov,
> +                          0, iov_size(iov, niov));
> +
> +    while (nlocal_iov > 0) {
> +        ssize_t len;
> +        len =3D qio_channel_writev(ioc, local_iov, nlocal_iov, errp);
> +        if (len =3D=3D QIO_CHANNEL_ERR_BLOCK) {
> +            qio_channel_wait(ioc, G_IO_OUT);

[1] again

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--9IJBX8Gub3C3t0VGIVh4vqrNde7mQh2PK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmu7C8ACgkQp6FrSiUn
Q2oPVgf/f4RvnCoQBGxOhQNlGLMwXPLhXIQwsCZOyR2hoXvu4aANrCnf8YJmgETt
t+F5XTvzZ+fTRRincETG4DHrD2Rq5lNMVHxbP8xj4PSLNwHURi3h/huOwqVaZMAq
o4Jy97il5M4TE58MsLlpeHdGEmQ/llmDAhXI/Cl2dpWAeAV/zJ4Zbq6ZISU6C3f1
EW8jdaqvBrPtg6F7VPdNSQejby+taI+xHSh0M6i9CF965PMcgkbrPvvHd7QJVbNc
5JHxvA3lOzZI+HR5Ou9QPqjojtvvnmkLvkATWeJ+0DE/nTtTmRB5ywapjHyiMxPg
7l07OWzvrjpy7HahdlOZphQ9UCXjGA==
=CY8q
-----END PGP SIGNATURE-----

--9IJBX8Gub3C3t0VGIVh4vqrNde7mQh2PK--
