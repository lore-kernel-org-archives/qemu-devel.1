Received: from eggs.gnu.org ([2001:4830:134:3::10]:40483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dy1VJ-00067o-Up
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 16:03:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dy1VI-0005Bw-NU
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 16:03:21 -0400
References: <20170913160333.23622-1-eblake@redhat.com>
	<20170913160333.23622-4-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <86c281c3-7630-b6f3-27d7-ef778f75e798@redhat.com>
Date: Fri, 29 Sep 2017 15:03:03 -0500
MIME-Version: 1.0
In-Reply-To: <20170913160333.23622-4-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="TMnlPxMSopGc41xveaoVUNKB2jPBFBLbv"
Subject: Re: [Qemu-devel] [PATCH v4 03/23] block: Make
 bdrv_round_to_clusters() signature more useful
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, jsnow@redhat.com
List-ID: <qemu-devel.nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TMnlPxMSopGc41xveaoVUNKB2jPBFBLbv
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org,
 Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, jsnow@redhat.com
Message-ID: <86c281c3-7630-b6f3-27d7-ef778f75e798@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 03/23] block: Make
 bdrv_round_to_clusters() signature more useful
References: <20170913160333.23622-1-eblake@redhat.com>
 <20170913160333.23622-4-eblake@redhat.com>
In-Reply-To: <20170913160333.23622-4-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/13/2017 11:03 AM, Eric Blake wrote:
> In the process of converting sector-based interfaces to bytes,
> I'm finding it easier to represent a byte count as a 64-bit
> integer at the block layer (even if we are internally capped
> by SIZE_MAX or even INT_MAX for individual transactions, it's
> still nicer to not have to worry about truncation/overflow
> issues on as many variables).  Update the signature of
> bdrv_round_to_clusters() to uniformly use int64_t, matching
> the signature already chosen for bdrv_is_allocated and the
> fact that off_t is also a signed type, then adjust clients
> according to the required fallout.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Fam Zheng <famz@redhat.com>
>=20

> @@ -946,7 +946,7 @@ static int coroutine_fn bdrv_co_do_copy_on_readv(Bd=
rvChild *child,
>      struct iovec iov;
>      QEMUIOVector bounce_qiov;
>      int64_t cluster_offset;
> -    unsigned int cluster_bytes;
> +    int64_t cluster_bytes;
>      size_t skip_bytes;
>      int ret;

Here, 'bytes' is still unsigned int, and I widened cluster_bytes,

> +++ b/block/trace-events
> @@ -12,7 +12,7 @@ blk_co_pwritev(void *blk, void *bs, int64_t offset, u=
nsigned int bytes, int flag
>  bdrv_co_preadv(void *bs, int64_t offset, int64_t nbytes, unsigned int =
flags) "bs %p offset %"PRId64" nbytes %"PRId64" flags 0x%x"
>  bdrv_co_pwritev(void *bs, int64_t offset, int64_t nbytes, unsigned int=
 flags) "bs %p offset %"PRId64" nbytes %"PRId64" flags 0x%x"
>  bdrv_co_pwrite_zeroes(void *bs, int64_t offset, int count, int flags) =
"bs %p offset %"PRId64" count %d flags 0x%x"
> -bdrv_co_do_copy_on_readv(void *bs, int64_t offset, unsigned int bytes,=
 int64_t cluster_offset, unsigned int cluster_bytes) "bs %p offset %"PRId=
64" bytes %u cluster_offset %"PRId64" cluster_bytes %u"
> +bdrv_co_do_copy_on_readv(void *bs, int64_t offset, int64_t bytes, int6=
4_t cluster_offset, unsigned int cluster_bytes) "bs %p offset %"PRId64" b=
ytes %"PRId64" cluster_offset %"PRId64" cluster_bytes %u"

but I botched which variable got widened in the trace.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--TMnlPxMSopGc41xveaoVUNKB2jPBFBLbv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnOpvgACgkQp6FrSiUn
Q2pMuAgAnN0gefXPA5rQJ/dur49K+mnUlNRdTx4FuAKaeuUBiHUGM0mkRYsJMGXJ
8sOOqYPlK1PH3YCp2JMlF31WhPTj4IVyTn6iVLhVlhTB57i5Ez5h7RSN6GZdWsDc
RxgyC2uCF4gC1MOvikco/LP+k2aJ/Y95yLdJxAicBrJB9FhfjvHWj1kKI8T7aCSS
j9+rX0xyQyY6twQAP8raiNIEOIUCexbODqW3ISankla6XEjI5oQG8AwlAUQb6WWY
JEIZlWDokWxBjPN/2EiGCzPzh4ANFlJruRCAwXZH2MDUj03wQQcdFhyQA5ocgUgY
wkeJoKos9LioPst8394+gY9EgqOOCA==
=j/Hq
-----END PGP SIGNATURE-----

--TMnlPxMSopGc41xveaoVUNKB2jPBFBLbv--
