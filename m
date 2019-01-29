Received: from eggs.gnu.org ([209.51.188.92]:55883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gob2x-0003zH-Eh
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 16:35:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gob2v-0005WE-F8
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 16:35:55 -0500
References: <20190129143800.88563-1-vsementsov@virtuozzo.com>
	<20190129143800.88563-2-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0cc0ace6-c260-85db-3e0b-21d8f7e39005@redhat.com>
Date: Tue, 29 Jan 2019 15:35:36 -0600
MIME-Version: 1.0
In-Reply-To: <20190129143800.88563-2-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="EgMI6lRODOSWHSfDvwZCmY6R8up4JD4Kf"
Subject: Re: [Qemu-devel] [PATCH 1/2] block: enhance QEMUIOVector structure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EgMI6lRODOSWHSfDvwZCmY6R8up4JD4Kf
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com
Message-ID: <0cc0ace6-c260-85db-3e0b-21d8f7e39005@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] block: enhance QEMUIOVector structure
References: <20190129143800.88563-1-vsementsov@virtuozzo.com>
 <20190129143800.88563-2-vsementsov@virtuozzo.com>
In-Reply-To: <20190129143800.88563-2-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/29/19 8:37 AM, Vladimir Sementsov-Ogievskiy wrote:
> Add a possibility of embedded iovec, for cases when we need only one
> local iov.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  include/qemu/iov.h | 41 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 40 insertions(+), 1 deletion(-)
>=20

> =20
> +G_STATIC_ASSERT(offsetof(QEMUIOVector, size) =3D=3D
> +                offsetof(QEMUIOVector, local_iov.iov_len));
> +G_STATIC_ASSERT(sizeof(((QEMUIOVector *)NULL)->size) =3D=3D
> +                sizeof(((QEMUIOVector *)NULL)->local_iov.iov_len));

We don't use G_STATIC_ASSERT() elsewhere (slirp excepted, as that is
trying to split off to a separate project); so these should be:

QEMU_BUILD_BUG_ON(offsetof(QEMUIOVector, size) !=3D
                  offsetof(QEMUIOVector, local_iov.iov_len));

and so on.

POSIX does not guarantee that iov_base occurs prior to iov_len in struct
iovec; your code is therefore rather fragile and would fail to compile
if we encounter a libc where iov_len is positioned differently than in
glibc, tripping the first assertion.  For an offset other than 0, you
could declare:
  char [offsetof(struct iovec, iov_len)] __pad;
to be more robust; but since C doesn't like 0-length array declarations,
I'm not sure how you would cater to a libc where iov_len is at offset 0,
short of a configure probe and #ifdeffery, which feels like a bit much
to manage (really, the point of the assert is that we don't have to
worry about an unusual libc having a different offset UNLESS the build
fails, so no need to address a problem we aren't hitting yet).

The second assertion (about sizeof being identical) is redundant, since
POSIX requires size_t iov_len, and we used size_t size (while a libc
might reorder the fields of struct iovec, they shouldn't be using the
wrong types); but perhaps you could use:
 typeof(struct iovec.iov_len) size;
in the declaration to avoid even that possibility (I'm not sure it is
worth it, though).

> +
> +#define QEMU_IOVEC_INIT_BUF(self, buf, len) \
> +{                                           \
> +    .iov =3D &(self).local_iov,               \
> +    .niov =3D 1,                              \
> +    .nalloc =3D -1,                           \
> +    .local_iov =3D {                          \
> +        .iov_base =3D (void *)(buf),          \

Why is the cast necessary?  Are we casting away const?  Since C already
allows assignment of any other (non-const) pointer to void* without a
cast, it looks superfluous.

> +        .iov_len =3D len                      \

Missing () around len. I might also have used a trailing comma (I find
it easier to always use trailing comma; while we're unlikely to add more
members here, it does make for less churn in other places where a struct
may grow).

> +    }                                       \
> +}
> +
> +static inline void qemu_iovec_init_buf(QEMUIOVector *qiov,
> +                                       void *buf, size_t len)
> +{
> +    *qiov =3D (QEMUIOVector) QEMU_IOVEC_INIT_BUF(*qiov, buf, len);
> +}

Why both a macro and a function that uses the macro? Do you expect any
other code to actually use the macro, or will the function always be
sufficient, in which case you could inline the initializer without the
use of a macro.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--EgMI6lRODOSWHSfDvwZCmY6R8up4JD4Kf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxQxygACgkQp6FrSiUn
Q2oMEggAmLfsb/VOtQckmkwEQfQr2EHsH/H9KEjXGNvbxLVQ0/wZa2stBU7z2iTB
9cOZAZ6qXqn2j12EkeDGrC9JWQPJgwXOax1t33Hue1ViZo4F3KvhP3b097xNBh6z
rM1jo0PjhasAzRP5sxRRJsxf0lC1ZCqPasyQtSa5rFscNDD7g4r+gF7eOUX5iL8A
tAjlbqJwJBL+84n0afIll2hCrhbqvDM91g1t5lsS8Bk8Yu23hyAhIr91k84IRNlR
Z/0F1/5FwzYlQYMqfhUI+bs1LDT3peeHBrP6arRK9eiH37+Za8BXP5r2m9biSFxQ
MFNPlZ1I4YyDW4yx1GJO/a3TUNGDtw==
=FNfr
-----END PGP SIGNATURE-----

--EgMI6lRODOSWHSfDvwZCmY6R8up4JD4Kf--
