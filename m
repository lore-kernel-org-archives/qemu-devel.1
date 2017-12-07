Received: from eggs.gnu.org ([2001:4830:134:3::10]:52572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eN2qN-00026e-Py
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 15:32:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eN2qM-000573-Lw
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 15:32:31 -0500
References: <20171206144550.22295-1-stefanha@redhat.com>
	<20171206144550.22295-2-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0347dd53-3363-3fdd-8e8a-6f80f3907554@redhat.com>
Date: Thu, 7 Dec 2017 14:32:19 -0600
MIME-Version: 1.0
In-Reply-To: <20171206144550.22295-2-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6fh3vOjb4pqO5OgT6WIrGGsDJduWGn0aQ"
Subject: Re: [Qemu-devel] [PATCH v2 1/9] blockdev: hold AioContext for
 bdrv_unref() in external_snapshot_clean()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6fh3vOjb4pqO5OgT6WIrGGsDJduWGn0aQ
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org
Message-ID: <0347dd53-3363-3fdd-8e8a-6f80f3907554@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/9] blockdev: hold AioContext for
 bdrv_unref() in external_snapshot_clean()
References: <20171206144550.22295-1-stefanha@redhat.com>
 <20171206144550.22295-2-stefanha@redhat.com>
In-Reply-To: <20171206144550.22295-2-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/06/2017 08:45 AM, Stefan Hajnoczi wrote:
> bdrv_unref() requires the AioContext lock because bdrv_flush() uses
> BDRV_POLL_WHILE(), which assumes the AioContext is currently held.  If
> BDRV_POLL_WHILE() runs without AioContext held the
> pthread_mutex_unlock() call in aio_context_release() fails.
>=20
> This patch moves bdrv_unref() into the AioContext locked region to solv=
e
> the following pthread_mutex_unlock() failure:
>=20

> diff --git a/blockdev.c b/blockdev.c
> index 56a6b24a0b..3c8d994ced 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -1812,8 +1812,8 @@ static void external_snapshot_clean(BlkActionStat=
e *common)
>                               DO_UPCAST(ExternalSnapshotState, common, =
common);
>      if (state->aio_context) {
>          bdrv_drained_end(state->old_bs);
> -        aio_context_release(state->aio_context);
>          bdrv_unref(state->new_bs);
> +        aio_context_release(state->aio_context);

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--6fh3vOjb4pqO5OgT6WIrGGsDJduWGn0aQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloppVMACgkQp6FrSiUn
Q2qmIgf8CvURqAlYvrwJMTMsDwkM02FOmjre6XfrmEw+0xdOdOoU5G6k9mIWwZGV
i5xKByYhP2n31cYdpyGxbikJ2UcppSFRadCEXrv4MMthoo0IX15f4L9mJpXo5Oqb
rGjxTRmiDkYzIWvb+IJds/KGddQ53t2OalY1pJ0ehMYOYfre5IUI+SxE/681ernl
S5/4Io23jCOzbyUjF9/Ms7RBpsnqUwLWJ0I+RCcjET5YWrm5nfyVztvv1Aty1IiW
7RHIGicjXcR9xVQ9YEw2NBA3DsnP5bDCo7eh9ORuF9S990l5GKI/JhCAoy2tQrgK
+jWOpgLaV5WuIwEUgt8r8Ia7Ko6ZMQ==
=chtL
-----END PGP SIGNATURE-----

--6fh3vOjb4pqO5OgT6WIrGGsDJduWGn0aQ--
