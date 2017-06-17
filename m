Received: from eggs.gnu.org ([2001:4830:134:3::10]:60751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dMC6G-0001NO-77
	for qemu-devel@nongnu.org; Sat, 17 Jun 2017 07:41:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dMC6B-0006ar-A8
	for qemu-devel@nongnu.org; Sat, 17 Jun 2017 07:41:08 -0400
Date: Sat, 17 Jun 2017 14:41:01 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170617114101.767vztiyl5xy7qoh@postretch>
References: <1497634636-20230-1-git-send-email-kwolf@redhat.com>
	<1497634636-20230-31-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dqmu2bqtz4upvyag"
Content-Disposition: inline
In-Reply-To: <1497634636-20230-31-git-send-email-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 30/31] qed: Use bdrv_co_*
 for coroutine_fns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, pbonzini@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com


--dqmu2bqtz4upvyag
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Manos Pitsidianakis <el13635@mail.ntua.gr>

On Fri, Jun 16, 2017 at 07:37:15PM +0200, Kevin Wolf wrote:
>All functions that are marked coroutine_fn can directly call the
>bdrv_co_* version of functions instead of going through the wrapper.
>
>Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>---
> block/qed.c | 16 +++++++++-------
> 1 file changed, 9 insertions(+), 7 deletions(-)
>
>diff --git a/block/qed.c b/block/qed.c
>index 48f2b0e..c073baa 100644
>--- a/block/qed.c
>+++ b/block/qed.c
>@@ -116,7 +116,7 @@ static int coroutine_fn qed_write_header(BDRVQEDState =
*s)
>     };
>     qemu_iovec_init_external(&qiov, &iov, 1);
>
>-    ret =3D bdrv_preadv(s->bs->file, 0, &qiov);
>+    ret =3D bdrv_co_preadv(s->bs->file, 0, qiov.size, &qiov, 0);
>     if (ret < 0) {
>         goto out;
>     }
>@@ -124,7 +124,7 @@ static int coroutine_fn qed_write_header(BDRVQEDState =
*s)
>     /* Update header */
>     qed_header_cpu_to_le(&s->header, (QEDHeader *) buf);
>
>-    ret =3D bdrv_pwritev(s->bs->file, 0, &qiov);
>+    ret =3D bdrv_co_pwritev(s->bs->file, 0, qiov.size,  &qiov, 0);
>     if (ret < 0) {
>         goto out;
>     }
>@@ -796,7 +796,7 @@ static int coroutine_fn qed_read_backing_file(BDRVQEDS=
tate *s, uint64_t pos,
>     qemu_iovec_concat(*backing_qiov, qiov, 0, size);
>
>     BLKDBG_EVENT(s->bs->file, BLKDBG_READ_BACKING_AIO);
>-    ret =3D bdrv_preadv(s->bs->backing, pos, *backing_qiov);
>+    ret =3D bdrv_co_preadv(s->bs->backing, pos, size, *backing_qiov, 0);
>     if (ret < 0) {
>         return ret;
>     }
>@@ -844,7 +844,7 @@ static int coroutine_fn qed_copy_from_backing_file(BDR=
VQEDState *s,
>     }
>
>     BLKDBG_EVENT(s->bs->file, BLKDBG_COW_WRITE);
>-    ret =3D bdrv_pwritev(s->bs->file, offset, &qiov);
>+    ret =3D bdrv_co_pwritev(s->bs->file, offset, qiov.size, &qiov, 0);
>     if (ret < 0) {
>         goto out;
>     }
>@@ -987,7 +987,8 @@ static int coroutine_fn qed_aio_write_main(QEDAIOCB *a=
cb)
>     trace_qed_aio_write_main(s, acb, 0, offset, acb->cur_qiov.size);
>
>     BLKDBG_EVENT(s->bs->file, BLKDBG_WRITE_AIO);
>-    ret =3D bdrv_pwritev(s->bs->file, offset, &acb->cur_qiov);
>+    ret =3D bdrv_co_pwritev(s->bs->file, offset, acb->cur_qiov.size,
>+                          &acb->cur_qiov, 0);
>     if (ret < 0) {
>         return ret;
>     }
>@@ -1004,7 +1005,7 @@ static int coroutine_fn qed_aio_write_main(QEDAIOCB =
*acb)
>              * region.  The solution is to flush after writing a new data
>              * cluster and before updating the L2 table.
>              */
>-            ret =3D bdrv_flush(s->bs->file->bs);
>+            ret =3D bdrv_co_flush(s->bs->file->bs);
>             if (ret < 0) {
>                 return ret;
>             }
>@@ -1221,7 +1222,8 @@ static int coroutine_fn qed_aio_read_data(void *opaq=
ue, int ret,
>     }
>
>     BLKDBG_EVENT(bs->file, BLKDBG_READ_AIO);
>-    ret =3D bdrv_preadv(bs->file, offset, &acb->cur_qiov);
>+    ret =3D bdrv_co_preadv(bs->file, offset, acb->cur_qiov.size,
>+                         &acb->cur_qiov, 0);
>     if (ret < 0) {
>         return ret;
>     }
>--=20
>1.8.3.1
>
>
>

--dqmu2bqtz4upvyag
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAllFFU0ACgkQc2J8L2kN
9xAxBBAAgM/tCulien/Ffy2+cbSDh3rGzYTwB3r57GBFU69EbUinsWZmEpScDCrb
gEjVmXQNlQoKytFU1Aj0gDGEj7msE7I61KC6RjkKxVIhNsB3DpykR6gedXqT05Hp
6/aiZXtNot6WEjdfJGq7d4+N4iImLRcq91Vvrtg9f1gCVFPmKtjZfj0fORgzsTP+
sLUK+Q/FKCVNOFcrY5L8fOzgYe5FfiwcEBEGs5RiLAaDQEdSnx+v0lK24LAF82co
Jyo38bfk420Xq4DepgX4BaWbQ3u/HWE+ZMuycXxRl2M6tG4sNWnHgSIbFW/7uDQX
8sNT28BeagOK1bgSlk+mHam///O1LRpwd4KVABE+Sa3ZthJ1MjAxR/3hUZiU//RJ
Bh4tT0f+a3c+bKfLWt4ZzUzYKS6t2DnnzjQz9Vit/bNdxCxi+EDx9i6H9ii3njvF
JpBeEm7+HgqrdlfcgAQj/bP4q3wRQNlUyIvyhBlijONwetfCQforniO9z6EpS0T7
F0Du+Vx7l0LdMCJvo2DSJK4Ux430mn70ZRodkXlWRfTQBUAraTXpXXDr/3k68JuS
h+/9kxtw5sWcIULd362b7r6jfRJxIeFXFiKyX+9XqE+cQq/fq765qv2xq+IBc8TN
4rMEtaKFNslDCPkS7waduyhHZAsFlNxw4rEDBhMMmds961DckJA=
=LIQY
-----END PGP SIGNATURE-----

--dqmu2bqtz4upvyag--
