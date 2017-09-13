Received: from eggs.gnu.org ([2001:4830:134:3::10]:50828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ds98D-0008CP-Ck
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 10:59:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ds98A-0006hg-CF
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 10:59:13 -0400
Received: from 2.mo2.mail-out.ovh.net ([188.165.53.149]:58724)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ds98A-0006fj-6Y
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 10:59:10 -0400
Received: from player770.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 27010ABA7F
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 16:59:07 +0200 (CEST)
Date: Wed, 13 Sep 2017 16:59:02 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170913165902.3d907b10@bahia.lan>
In-Reply-To: <1505312203-6319-1-git-send-email-jan.dakinevich@gmail.com>
References: <1505312203-6319-1-git-send-email-jan.dakinevich@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_//1PMdsM_+KQ0ieHDQUKrO5u";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH] virtio-9p: don't break device on
 marshaling fail
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jan Dakinevich <jan.dakinevich@gmail.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, "Aneesh
	Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

--Sig_//1PMdsM_+KQ0ieHDQUKrO5u
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 13 Sep 2017 17:16:43 +0300
Jan Dakinevich <jan.dakinevich@gmail.com> wrote:

> Fix regression from commit 8d37de41cab145cbba250a8f1f1372b0a5cdf26f.
>=20
> The situation when pdu_marshal returns an error should be considered
> valid. At least `v9fs_do_readdir_with_stat' relies on that to place in
> responce buffer as much data as can fit.
>=20

Indeed, that's embarrassing... but since v9fs_do_readdir_with_stat() is the
only guy that does that, I'd prefer you send a patch to handle this special
case instead of reverting 8d37de41ca. Please add a new transport operation
for this.

Thanks!

> Signed-off-by: Jan Dakinevich <jan.dakinevich@gmail.com>
> ---
>  hw/9pfs/virtio-9p-device.c | 19 ++-----------------
>  1 file changed, 2 insertions(+), 17 deletions(-)
>=20
> diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
> index 62650b0..c3e5935 100644
> --- a/hw/9pfs/virtio-9p-device.c
> +++ b/hw/9pfs/virtio-9p-device.c
> @@ -146,16 +146,8 @@ static ssize_t virtio_pdu_vmarshal(V9fsPDU *pdu, siz=
e_t offset,
>      V9fsState *s =3D pdu->s;
>      V9fsVirtioState *v =3D container_of(s, V9fsVirtioState, state);
>      VirtQueueElement *elem =3D v->elems[pdu->idx];
> -    ssize_t ret;
> =20
> -    ret =3D v9fs_iov_vmarshal(elem->in_sg, elem->in_num, offset, 1, fmt,=
 ap);
> -    if (ret < 0) {
> -        VirtIODevice *vdev =3D VIRTIO_DEVICE(v);
> -
> -        virtio_error(vdev, "Failed to encode VirtFS reply type %d",
> -                     pdu->id + 1);
> -    }
> -    return ret;
> +    return v9fs_iov_vmarshal(elem->in_sg, elem->in_num, offset, 1, fmt, =
ap);
>  }
> =20
>  static ssize_t virtio_pdu_vunmarshal(V9fsPDU *pdu, size_t offset,
> @@ -164,15 +156,8 @@ static ssize_t virtio_pdu_vunmarshal(V9fsPDU *pdu, s=
ize_t offset,
>      V9fsState *s =3D pdu->s;
>      V9fsVirtioState *v =3D container_of(s, V9fsVirtioState, state);
>      VirtQueueElement *elem =3D v->elems[pdu->idx];
> -    ssize_t ret;
> =20
> -    ret =3D v9fs_iov_vunmarshal(elem->out_sg, elem->out_num, offset, 1, =
fmt, ap);
> -    if (ret < 0) {
> -        VirtIODevice *vdev =3D VIRTIO_DEVICE(v);
> -
> -        virtio_error(vdev, "Failed to decode VirtFS request type %d", pd=
u->id);
> -    }
> -    return ret;
> +    return v9fs_iov_vunmarshal(elem->out_sg, elem->out_num, offset, 1, f=
mt, ap);
>  }
> =20
>  static void virtio_init_in_iov_from_pdu(V9fsPDU *pdu, struct iovec **pio=
v,


--Sig_//1PMdsM_+KQ0ieHDQUKrO5u
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQQr1DtEU17Ap5iU26IC/DrrAQHbwgUCWblHtgAKCRAC/DrrAQHb
woezAKCV1st4Dtcn0b5Tia3W1TIaIdrzfwCgjIGoW5sJteeOrMsAwnPrWv98Vts=
=jubK
-----END PGP SIGNATURE-----

--Sig_//1PMdsM_+KQ0ieHDQUKrO5u--
