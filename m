Received: from eggs.gnu.org ([2001:4830:134:3::10]:44522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fJFjK-0007uD-N5
	for qemu-devel@nongnu.org; Thu, 17 May 2018 06:01:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fJFjF-000818-3Z
	for qemu-devel@nongnu.org; Thu, 17 May 2018 06:01:50 -0400
Date: Thu, 17 May 2018 11:01:34 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180517100134.GB18718@stefanha-x1.localdomain>
References: <20180511120823.7892-1-famz@redhat.com>
	<20180511120823.7892-5-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DKU6Jbt7q3WqK7+M"
Content-Disposition: inline
In-Reply-To: <20180511120823.7892-5-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 04/10] qcow2: Implement copy offloading
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, qemu-block@nongnu.org, Peter Lieven <pl@kamp.de>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, eblake@redhat.com


--DKU6Jbt7q3WqK7+M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 11, 2018 at 08:08:17PM +0800, Fam Zheng wrote:
> +static int qcow2_handle_l2meta(BlockDriverState *bs, QCowL2Meta *l2meta)
> +{
> +    int ret =3D 0;
> +
> +    while (l2meta !=3D NULL) {
> +        QCowL2Meta *next;
> +
> +        if (!ret) {
> +            ret =3D qcow2_alloc_cluster_link_l2(bs, l2meta);
> +        }
> +
> +        /* Take the request off the list of running requests */
> +        if (l2meta->nb_clusters !=3D 0) {
> +            QLIST_REMOVE(l2meta, next_in_flight);
> +        }
> +
> +        qemu_co_queue_restart_all(&l2meta->dependent_requests);

A coroutine_fn may only be called by a coroutine_fn.  Please mark
qcow2_handle_l2meta() coroutine_fn.

> @@ -2069,18 +2080,7 @@ static coroutine_fn int qcow2_co_pwritev(BlockDriv=
erState *bs, uint64_t offset,
>      ret =3D 0;
> =20
>  fail:
> -    while (l2meta !=3D NULL) {
> -        QCowL2Meta *next;
> -
> -        if (l2meta->nb_clusters !=3D 0) {
> -            QLIST_REMOVE(l2meta, next_in_flight);
> -        }
> -        qemu_co_queue_restart_all(&l2meta->dependent_requests);
> -
> -        next =3D l2meta->next;
> -        g_free(l2meta);
> -        l2meta =3D next;
> -    }
> +    qcow2_handle_l2meta(bs, l2meta);

Is qcow2_handle_l2meta() equivalent to the code that is being removed?
qcow2_handle_l2meta() calls qcow2_alloc_cluster_link_l2() while this
code does not.

> =20
>      qemu_co_mutex_unlock(&s->lock);
> =20
> @@ -3267,6 +3267,176 @@ static coroutine_fn int qcow2_co_pdiscard(BlockDr=
iverState *bs,
>      return ret;
>  }
> =20
> +static int qcow2_co_copy_range_from(BlockDriverState *bs,

Missing coroutine_fn.  Please check your patches for more occurrences.

> +        while (l2meta !=3D NULL) {
> +            QCowL2Meta *next;
> +
> +            ret =3D qcow2_alloc_cluster_link_l2(bs, l2meta);
> +            if (ret < 0) {
> +                goto fail;
> +            }
> +
> +            /* Take the request off the list of running requests */
> +            if (l2meta->nb_clusters !=3D 0) {
> +                QLIST_REMOVE(l2meta, next_in_flight);
> +            }
> +
> +            qemu_co_queue_restart_all(&l2meta->dependent_requests);
> +
> +            next =3D l2meta->next;
> +            g_free(l2meta);
> +            l2meta =3D next;
> +        }

Why isn't this a call to qcow2_handle_l2meta()?  I guess the reason for
extracting that function was to use it here?

--DKU6Jbt7q3WqK7+M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa/VL+AAoJEJykq7OBq3PI5coIAMXQ3FqDXXZ0SEt18TWHLA6f
NXBsWXErqdBHHFj+EsHbUqntq5BZFKrHZtFWQYsBL9K+2akoSUYCTuLpQ13yhjsb
XwJ/chR0uKMmmv+bkJjoNBu5OIS5idC8FDLZ7rh+8NgfnRaYSc7j/b/20dntnNjh
LO61jddBWPVCr+dzglBKyFDAtdgs759nuSyRm9Rw6r9eUpUTc/UwkWshIRCn3gmG
3yHx1tcFVtSYSH0vzl7vYokV8LknL93zecwH6nqtpwvmqLxbYdC3A0kZL9P/7jCr
vBv9FPYKj1Y+hCm3xSvZCT/9otoBKWZsoggjLNa7LaSCa3hqjq/5qfAtuMzUObA=
=jdPv
-----END PGP SIGNATURE-----

--DKU6Jbt7q3WqK7+M--
