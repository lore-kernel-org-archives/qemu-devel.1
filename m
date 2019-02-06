Received: from eggs.gnu.org ([209.51.188.92]:55193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1grQxW-0008EA-6q
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 12:26:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1grQxV-0002Gj-75
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 12:26:02 -0500
References: <20190206165342.219192-1-vsementsov@virtuozzo.com>
	<20190206165342.219192-2-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cb3e35a3-fd92-0b36-52c1-44312c5c11c8@redhat.com>
Date: Wed, 6 Feb 2019 11:25:48 -0600
MIME-Version: 1.0
In-Reply-To: <20190206165342.219192-2-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Nsf443AmvYPNHr0pdPOeDsHufco9EkUeS"
Subject: Re: [Qemu-devel] [PATCH v2 1/2] block: enhance QEMUIOVector
 structure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, fam@euphon.net, stefanha@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Nsf443AmvYPNHr0pdPOeDsHufco9EkUeS
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, fam@euphon.net, stefanha@redhat.com
Message-ID: <cb3e35a3-fd92-0b36-52c1-44312c5c11c8@redhat.com>
Subject: Re: [PATCH v2 1/2] block: enhance QEMUIOVector structure
References: <20190206165342.219192-1-vsementsov@virtuozzo.com>
 <20190206165342.219192-2-vsementsov@virtuozzo.com>
In-Reply-To: <20190206165342.219192-2-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/6/19 10:53 AM, Vladimir Sementsov-Ogievskiy wrote:
> Add a possibility of embedded iovec, for cases when we need only one
> local iov.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  include/qemu/iov.h | 47 ++++++++++++++++++++++++++++++++++++++++++++--=

>  1 file changed, 45 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/qemu/iov.h b/include/qemu/iov.h
> index 5f433c7768..3753b63558 100644
> --- a/include/qemu/iov.h
> +++ b/include/qemu/iov.h
> @@ -133,10 +133,53 @@ size_t iov_discard_back(struct iovec *iov, unsign=
ed int *iov_cnt,
>  typedef struct QEMUIOVector {
>      struct iovec *iov;
>      int niov;
> -    int nalloc;
> -    size_t size;
> +
> +    /*
> +     * For external @iov (qemu_iovec_init_external()) or allocated @io=
v
> +     * (qemu_iovec_init()) @size is the cumulative size of iovecs and

s/ @size/, @size/

> +     * @local_iov is invalid and unused.
> +     *
> +     * For embedded @iov (QEMU_IOVEC_INIT_BUF() or qemu_iovec_init_buf=
()),
> +     * @iov is equal to &@local_iov, and @size is valid, as it has sam=
e
> +     * offset and type as @local_iov.iov_len, which is guaranteed by
> +     * static assertions below.

Only one static assertion below (s/assertions/assertion/), but even that
one could perhaps be dropped and this wording changed to "which is
guaranteed by the layout below"; or you could restore the assertion in
the earlier patch that sizeof(size) and sizeof(struct iovec.iov_len) are
equal) to make the plural correct.

> +     *
> +     * @nalloc is valid always and is -1 both for embedded and externa=
l

s/valid always/always valid/

> +     * cases. It included into union only to make appropriate padding =
for
> +     * @size field avoiding creation of 0-length array in the worst ca=
se.

It is included in the union only to ensure the padding prior to the
@size field will not result in a 0-length array.

> +     */
> +    union {
> +        struct {
> +            int nalloc;
> +            struct iovec local_iov;
> +        };
> +        struct {
> +            char __pad[sizeof(int) + offsetof(struct iovec, iov_len)];=

> +            size_t size;
> +        };
> +    };
>  } QEMUIOVector;
> =20
> +QEMU_BUILD_BUG_ON(offsetof(QEMUIOVector, size) !=3D
> +                  offsetof(QEMUIOVector, local_iov.iov_len));

I'm not sure this assertion adds any value; I don't see any leeway on
how a compiler could lay out the struct based on the declaration of the
padding.  However, I'm not opposed to keeping it in the patch if someone
else finds it useful.

> +
> +#define QEMU_IOVEC_INIT_BUF(self, buf, len)              \
> +{                                                        \
> +    .iov =3D &(self).local_iov,                            \
> +    .niov =3D 1,                                           \
> +    .nalloc =3D -1,                                        \
> +    .local_iov =3D {                                       \
> +        .iov_base =3D (void *)(buf), /* cast away const */ \
> +        .iov_len =3D (len),                                \
> +    },                                                   \
> +}
> +
> +static inline void qemu_iovec_init_buf(QEMUIOVector *qiov,
> +                                       void *buf, size_t len)

Should this be 'const void *buf', to make it easier to initialize a qiov
used for writes from an incoming const pointer?  That, and having const
here would make the 'cast away const' comment above all the more obvious
(I know it is necessary based on code in patch 2, but having it be
worthwhile in patch 1 makes it all the more obvious as a standalone patch=
).

> +{
> +    *qiov =3D (QEMUIOVector) QEMU_IOVEC_INIT_BUF(*qiov, buf, len);
> +}
> +
>  void qemu_iovec_init(QEMUIOVector *qiov, int alloc_hint);
>  void qemu_iovec_init_external(QEMUIOVector *qiov, struct iovec *iov, i=
nt niov);
>  void qemu_iovec_add(QEMUIOVector *qiov, void *base, size_t len);
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--Nsf443AmvYPNHr0pdPOeDsHufco9EkUeS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxbGJwACgkQp6FrSiUn
Q2qubgf+KhDeHpxRiZO3calNwCFhNU2cVT5+LBWnlOGzNpJZxk8fKm+KLntJK+a8
nbGtplB3oikaP1cTLsC+zDABebDLMjDu36x7V38jf2EFa5yu8Ej+pglREH3Xtrna
K4w6IYyVZghyfbdDYOp+e6wyPVexJSBh+bcKOL0lF/ZhCWSFiriijHR2s8UAdvGy
L0ptvd3HTHII1Dr7OvGEKCkQ/d22NWkW9Yop3Wh4r62yGDFF7PlKtK3IgTjwjFBm
FuWMjW2AxdLn3NEvc4C6B88vQMyxsh9NvmlIE6D/kpsk5QSUXD/y1csEvWvwheJU
1rGjREA5PPZAzgGb4cJnyGwyKUtZQQ==
=dqFJ
-----END PGP SIGNATURE-----

--Nsf443AmvYPNHr0pdPOeDsHufco9EkUeS--
