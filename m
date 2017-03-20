Received: from eggs.gnu.org ([2001:4830:134:3::10]:57981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cpuOa-0004UL-OQ
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 06:18:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cpuOZ-0007mO-TH
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 06:18:36 -0400
Date: Mon, 20 Mar 2017 10:18:28 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170320101828.GC17887@stefanha-x1.localdomain>
References: <20170313214001.26339-1-mreitz@redhat.com>
	<20170313214001.26339-2-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3siQDZowHQqNOShm"
Content-Disposition: inline
In-Reply-To: <20170313214001.26339-2-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for-2.10 01/16] block: Add
 PreallocMode to BD.bdrv_truncate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org


--3siQDZowHQqNOShm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 13, 2017 at 10:39:46PM +0100, Max Reitz wrote:
> diff --git a/block/iscsi.c b/block/iscsi.c
> index ab559a6f71..5d6265c4a6 100644
> --- a/block/iscsi.c
> +++ b/block/iscsi.c
> @@ -2060,11 +2060,16 @@ static void iscsi_reopen_commit(BDRVReopenState *=
reopen_state)
>      }
>  }
> =20
> -static int iscsi_truncate(BlockDriverState *bs, int64_t offset, Error **=
errp)
> +static int iscsi_truncate(BlockDriverState *bs, int64_t offset,
> +                          PreallocMode prealloc, Error **errp)
>  {
>      IscsiLun *iscsilun =3D bs->opaque;
>      Error *local_err =3D NULL;
> =20
> +    if (prealloc !=3D PREALLOC_MODE_OFF) {
> +        return -ENOTSUP;
> +    }
> +
>      if (iscsilun->type !=3D TYPE_DISK) {
>          return -ENOTSUP;
>      }

Nevermind what I said about adding a BiteSizedTasks entry:

The missing errp usage is not in qemu.git/master yet.  Please fix up
your bdrv_truncate() errp patch to use errp in all cases, e.g.
error_setg("Unable to truncate non-disk LUN").

stefan

--3siQDZowHQqNOShm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYz6x0AAoJEJykq7OBq3PIIiIH/2GfXlSPDywhPrSBfoS7vH8m
t2s9SAr55ZAicM9uK4wh2hXirMkf4KqTFaJnOC2DRetFAQXwkeau10zSRvlpicEb
/YUiv6xwTJ5FU64Z7R8tT7zLyOhG0w1Vtu7+BOJ8XmBGg0nbaNtAkVSwHDXSUYct
k6Lb1UgFpwz3OT9GgTGewrcymhvthqojCN2vDX2gfpktpEw/KepiMG3kVvtcvTqS
UbcXb9kp/PENK5Y+CJ2bPeqxxTbjDGwDFIINyjkiAA4wPfxJqTkkzp9uxxNvU5Q0
jKRpfvpNNQCKT81w9E9GY7IN9C3TC8WKdDbexRKMQAhggy/4vq+oHK/82i3219A=
=5Xgx
-----END PGP SIGNATURE-----

--3siQDZowHQqNOShm--
