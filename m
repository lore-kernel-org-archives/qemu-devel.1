Received: from eggs.gnu.org ([2001:4830:134:3::10]:59107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cqzNn-0006rk-7b
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 05:50:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cqzNd-0007Mq-N9
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 05:50:15 -0400
Received: from 5.mo2.mail-out.ovh.net ([87.98.181.248]:58556)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cqzNd-0007Mh-GL
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 05:50:05 -0400
Received: from player731.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 9CABB7681D
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 10:50:03 +0100 (CET)
Date: Thu, 23 Mar 2017 10:49:58 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170323104958.42237143@bahia.lan>
In-Reply-To: <1490259133-44411-1-git-send-email-liqiang6-s@360.cn>
References: <1490259133-44411-1-git-send-email-liqiang6-s@360.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/X6dGqvhW0wlZuB.4emq02+v";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH] 9pfs: fix file descriptor leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>
Cc: qemu-devel@nongnu.org, ppandit@redhat.com, Li Qiang <liqiang6-s@360.cn>

--Sig_/X6dGqvhW0wlZuB.4emq02+v
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 23 Mar 2017 01:52:13 -0700
Li Qiang <liq3ea@gmail.com> wrote:

> In v9fs_create/lcreate dispatch handler, the fidp's fid_type is not check=
ed
> before used. As these function will set the fid_type, if the guest call
> more than once them, it will leak the fidp. This can cause some other

Not leak the fidp but rather a file descriptor or directory handle...

> issue, such as memory leak. Check the fid_type before using them.
>=20

or memory previously allocated for an extended attribute.

I'll fix the changelog before pushing the fix.

Thanks,

--
Greg

> Signed-off-by: Li Qiang <liqiang6-s@360.cn>
> ---
>  hw/9pfs/9p.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index b8c0b99..48babce 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -1550,6 +1550,10 @@ static void coroutine_fn v9fs_lcreate(void *opaque)
>          err =3D -ENOENT;
>          goto out_nofid;
>      }
> +    if (fidp->fid_type !=3D P9_FID_NONE) {
> +        err =3D -EINVAL;
> +        goto out;
> +    }
> =20
>      flags =3D get_dotl_openflags(pdu->s, flags);
>      err =3D v9fs_co_open2(pdu, fidp, &name, gid,
> @@ -2153,6 +2157,10 @@ static void coroutine_fn v9fs_create(void *opaque)
>          err =3D -EINVAL;
>          goto out_nofid;
>      }
> +    if (fidp->fid_type !=3D P9_FID_NONE) {
> +        err =3D -EINVAL;
> +        goto out;
> +    }
>      if (perm & P9_STAT_MODE_DIR) {
>          err =3D v9fs_co_mkdir(pdu, fidp, &name, perm & 0777,
>                              fidp->uid, -1, &stbuf);


--Sig_/X6dGqvhW0wlZuB.4emq02+v
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAljTmkYACgkQAvw66wEB28J0sQCgnpINhGK6EvVEwjPbXOTPvA+c
AsMAnjZzK+D+dS9UVHtJoJrngtDfltpO
=p/i1
-----END PGP SIGNATURE-----

--Sig_/X6dGqvhW0wlZuB.4emq02+v--
