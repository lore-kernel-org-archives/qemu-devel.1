Received: from eggs.gnu.org ([2001:4830:134:3::10]:38860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dddZr-0003WM-G3
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 10:28:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddbKy-0002k2-8c
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 08:05:22 -0400
References: <20170804105059.11941-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b2a62b9c-b05e-eec7-9875-5773d67f5311@redhat.com>
Date: Fri, 4 Aug 2017 07:02:50 -0500
MIME-Version: 1.0
In-Reply-To: <20170804105059.11941-1-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="M91EoMA9qDvRHTfCmChHFih54kKIHvENE"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block: document semanatics of
 bdrv_co_preadv|pwritev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--M91EoMA9qDvRHTfCmChHFih54kKIHvENE
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <famz@redhat.com>
Message-ID: <b2a62b9c-b05e-eec7-9875-5773d67f5311@redhat.com>
Subject: Re: [Qemu-block] [PATCH] block: document semanatics of
 bdrv_co_preadv|pwritev
References: <20170804105059.11941-1-berrange@redhat.com>
In-Reply-To: <20170804105059.11941-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/04/2017 05:50 AM, Daniel P. Berrange wrote:
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  include/block/block_int.h | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>=20
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index d4f4ea7584..deb81a58bd 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -147,12 +147,41 @@ struct BlockDriver {
> =20
>      int coroutine_fn (*bdrv_co_readv)(BlockDriverState *bs,
>          int64_t sector_num, int nb_sectors, QEMUIOVector *qiov);
> +
> +    /**
> +     * @offset: position in bytes to read at
> +     * @bytes: number of bytes to read
> +     * @qiov: the buffers to fill with read data
> +     *
> +     * @offset and @bytes will be a multiple of 'request_alignment',
> +     * but the length of individual @qiov elements does not have to
> +     * be a multiple.
> +     *
> +     * @bytes may be less than the total sizeof @iov, and will be
> +     * no larger than 'max_transfer'.
> +     *
> +     * The buffer in @qiov may point directly to guest memory.
> +     */
>      int coroutine_fn (*bdrv_co_preadv)(BlockDriverState *bs,
>          uint64_t offset, uint64_t bytes, QEMUIOVector *qiov, int flags=
);

Documenting flags would also be nice (at the moment, flags is always 0)

>      int coroutine_fn (*bdrv_co_writev)(BlockDriverState *bs,
>          int64_t sector_num, int nb_sectors, QEMUIOVector *qiov);
>      int coroutine_fn (*bdrv_co_writev_flags)(BlockDriverState *bs,
>          int64_t sector_num, int nb_sectors, QEMUIOVector *qiov, int fl=
ags);
> +    /**
> +     * @offset: position in bytes to write at
> +     * @bytes: number of bytes to write
> +     * @qiov: the buffers containing data to write
> +     *
> +     * @offset and @bytes will be a multiple of 'request_alignment',
> +     * but the length of individual @qiov elements does not have to
> +     * be a multiple.
> +     *
> +     * @bytes may be less than the total sizeof @iov, and will be
> +     * no larger than 'max_transfer'.
> +     *
> +     * The buffer in @qiov may point directly to guest memory.
> +     */
>      int coroutine_fn (*bdrv_co_pwritev)(BlockDriverState *bs,
>          uint64_t offset, uint64_t bytes, QEMUIOVector *qiov, int flags=
);

Likewise for documentation, but here, flags will never exceed
bs->supported_write_flags.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--M91EoMA9qDvRHTfCmChHFih54kKIHvENE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmEYmoACgkQp6FrSiUn
Q2pP6gf9HTWzjZIUGitYmqRFxnmqh8VnADyqZmlL0KrLiF22b9x5FTojEqPrrRQy
/JUsaapjnYMiXWFkBVmaz1S9K9XXhK2RCt0bzjKSsdf/DvBzOtTqQ0juIcS1RXNY
V20QJSGVe0GjujNvLG/9cT2wFphhbduDqIoAlXKNB+4v0KV0D2RTs2jVY6acHajy
EBb8sq+S5UdPbG1BB0P4/WprG1GAUhRQRhRjOOVzhZ/46BupEMgHCepLHjRxqQlA
WtX1vZ9fZcwXrMaLAl5mivEYvmNI+bMgGI74NQpkiWqHnapsG0T8281U0L4bbReX
ygkZnrv2xiSQ5ZS7+IW5XrFJYEeAog==
=wfwV
-----END PGP SIGNATURE-----

--M91EoMA9qDvRHTfCmChHFih54kKIHvENE--
