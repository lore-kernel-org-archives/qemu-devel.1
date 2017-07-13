Received: from eggs.gnu.org ([2001:4830:134:3::10]:49622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dVf0I-0006JE-Ks
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:22:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dVf0D-0008Bn-Jp
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:22:06 -0400
Received: from 7.mo2.mail-out.ovh.net ([188.165.48.182]:35280)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dVf0D-0008B6-Ck
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:22:01 -0400
Received: from player796.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id D03A4A0B71
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 16:21:58 +0200 (CEST)
Date: Thu, 13 Jul 2017 16:21:47 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170713162147.3c94d1fc@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <20170713110237.6712-5-lprosek@redhat.com>
References: <20170713110237.6712-1-lprosek@redhat.com>
	<20170713110237.6712-5-lprosek@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/07NGTqV1aEYOa/rUQ.41u66";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v2 4/8] virtio-9p: use virtqueue_error for
 errors with queue context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ladi Prosek <lprosek@redhat.com>
Cc: qemu-devel@nongnu.org, casasfernando@hotmail.com, mst@redhat.com, jasowang@redhat.com, armbru@redhat.com, arei.gonglei@huawei.com, aneesh.kumar@linux.vnet.ibm.com, stefanha@redhat.com

--Sig_/07NGTqV1aEYOa/rUQ.41u66
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 13 Jul 2017 13:02:33 +0200
Ladi Prosek <lprosek@redhat.com> wrote:

> virtqueue_error includes queue index in the error output and is preferred
> for errors that pertain to a virtqueue rather than to the device as a who=
le.
>=20
> Signed-off-by: Ladi Prosek <lprosek@redhat.com>
> ---

Acked-by: Greg Kurz <groug@kaod.org>

>  hw/9pfs/virtio-9p-device.c | 37 +++++++++++++++----------------------
>  1 file changed, 15 insertions(+), 22 deletions(-)
>=20
> diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
> index 62650b0..cf16b4b 100644
> --- a/hw/9pfs/virtio-9p-device.c
> +++ b/hw/9pfs/virtio-9p-device.c
> @@ -54,16 +54,16 @@ static void handle_9p_output(VirtIODevice *vdev, Virt=
Queue *vq)
>          }
> =20
>          if (iov_size(elem->in_sg, elem->in_num) < 7) {
> -            virtio_error(vdev,
> -                         "The guest sent a VirtFS request without space =
for "
> -                         "the reply");
> +            virtqueue_error(vq,
> +                            "The guest sent a VirtFS request without spa=
ce for "
> +                            "the reply");
>              goto out_free_req;
>          }
> =20
>          len =3D iov_to_buf(elem->out_sg, elem->out_num, 0, &out, 7);
>          if (len !=3D 7) {
> -            virtio_error(vdev, "The guest sent a malformed VirtFS reques=
t: "
> -                         "header size is %zd, should be 7", len);
> +            virtqueue_error(vq, "The guest sent a malformed VirtFS reque=
st: "
> +                            "header size is %zd, should be 7", len);
>              goto out_free_req;
>          }
> =20
> @@ -150,10 +150,8 @@ static ssize_t virtio_pdu_vmarshal(V9fsPDU *pdu, siz=
e_t offset,
> =20
>      ret =3D v9fs_iov_vmarshal(elem->in_sg, elem->in_num, offset, 1, fmt,=
 ap);
>      if (ret < 0) {
> -        VirtIODevice *vdev =3D VIRTIO_DEVICE(v);
> -
> -        virtio_error(vdev, "Failed to encode VirtFS reply type %d",
> -                     pdu->id + 1);
> +        virtqueue_error(v->vq, "Failed to encode VirtFS reply type %d",
> +                        pdu->id + 1);
>      }
>      return ret;
>  }
> @@ -168,9 +166,8 @@ static ssize_t virtio_pdu_vunmarshal(V9fsPDU *pdu, si=
ze_t offset,
> =20
>      ret =3D v9fs_iov_vunmarshal(elem->out_sg, elem->out_num, offset, 1, =
fmt, ap);
>      if (ret < 0) {
> -        VirtIODevice *vdev =3D VIRTIO_DEVICE(v);
> -
> -        virtio_error(vdev, "Failed to decode VirtFS request type %d", pd=
u->id);
> +        virtqueue_error(v->vq, "Failed to decode VirtFS request type %d",
> +                        pdu->id);
>      }
>      return ret;
>  }
> @@ -184,11 +181,9 @@ static void virtio_init_in_iov_from_pdu(V9fsPDU *pdu=
, struct iovec **piov,
>      size_t buf_size =3D iov_size(elem->in_sg, elem->in_num);
> =20
>      if (buf_size < size) {
> -        VirtIODevice *vdev =3D VIRTIO_DEVICE(v);
> -
> -        virtio_error(vdev,
> -                     "VirtFS reply type %d needs %zu bytes, buffer has %=
zu",
> -                     pdu->id + 1, size, buf_size);
> +        virtqueue_error(v->vq,
> +                        "VirtFS reply type %d needs %zu bytes, buffer ha=
s %zu",
> +                        pdu->id + 1, size, buf_size);
>      }
> =20
>      *piov =3D elem->in_sg;
> @@ -204,11 +199,9 @@ static void virtio_init_out_iov_from_pdu(V9fsPDU *pd=
u, struct iovec **piov,
>      size_t buf_size =3D iov_size(elem->out_sg, elem->out_num);
> =20
>      if (buf_size < size) {
> -        VirtIODevice *vdev =3D VIRTIO_DEVICE(v);
> -
> -        virtio_error(vdev,
> -                     "VirtFS request type %d needs %zu bytes, buffer has=
 %zu",
> -                     pdu->id, size, buf_size);
> +        virtqueue_error(v->vq,
> +                        "VirtFS request type %d needs %zu bytes, "
> +                        "buffer has %zu", pdu->id, size, buf_size);
>      }
> =20
>      *piov =3D elem->out_sg;


--Sig_/07NGTqV1aEYOa/rUQ.41u66
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAllngfsACgkQAvw66wEB28KNKgCfbyfFHgja8lN8utBSky6AFfNY
Fd8AnjLvV/I6JMOU9VXgaSRSZ62p2UTN
=H5jN
-----END PGP SIGNATURE-----

--Sig_/07NGTqV1aEYOa/rUQ.41u66--
