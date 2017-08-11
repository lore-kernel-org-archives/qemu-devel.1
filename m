Received: from eggs.gnu.org ([2001:4830:134:3::10]:60280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dg7Mv-0003je-TB
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 06:40:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dg7Mt-0000Yb-Er
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 06:40:41 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:36668)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dg7Mt-0000YA-7X
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 06:40:39 -0400
Received: by mail-wm0-x241.google.com with SMTP id d40so6000859wma.3
	for <qemu-devel@nongnu.org>; Fri, 11 Aug 2017 03:40:39 -0700 (PDT)
Date: Fri, 11 Aug 2017 11:40:32 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170811104032.GA5643@stefanha-x1.localdomain>
References: <20170810165255.20865-1-rjones@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
In-Reply-To: <20170810165255.20865-1-rjones@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] virtio-scsi: Add virtqueue_size parameter
 allowing virtqueue size to be set.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: pbonzini@redhat.com, hch@lst.de, qemu-devel@nongnu.org, martin.petersen@oracle.com, mst@redhat.com


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 10, 2017 at 05:52:55PM +0100, Richard W.M. Jones wrote:
> Since Linux switched to blk-mq as the default in Linux commit
> 5c279bd9e406 ("scsi: default to scsi-mq"), virtio-scsi LUNs consume
> about 10x as much guest kernel memory.
>=20
> This commit allows you to choose the virtqueue size for each
> virtio-scsi-pci controller like this:
>=20
>   -device virtio-scsi-pci,id=3Dscsi,virtqueue_size=3D16
>=20
> The default is still 128 as before.  Using smaller virtqueue_size
> allows many more disks to be added to small memory virtual machines.
> For a 1 vCPU, 500 MB, no swap VM I observed:
>=20
>   With scsi-mq enabled (upstream kernel):              175 disks
>     -"- ditto -"-   virtqueue_size=3D64:                 318 disks
>     -"- ditto -"-   virtqueue_size=3D16:                 775 disks
>   With scsi-mq disabled (kernel before 5c279bd9e406): 1755 disks
>=20
> Note that to have any effect, this requires a kernel patch:
>=20
>   https://lkml.org/lkml/2017/8/10/689
>=20
> Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
> ---
>  hw/scsi/virtio-scsi.c           | 8 +++++---
>  include/hw/virtio/virtio-scsi.h | 2 +-
>  2 files changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
> index eb639442d1..aca1909a59 100644
> --- a/hw/scsi/virtio-scsi.c
> +++ b/hw/scsi/virtio-scsi.c
> @@ -867,10 +867,10 @@ void virtio_scsi_common_realize(DeviceState *dev,
>      s->sense_size =3D VIRTIO_SCSI_SENSE_DEFAULT_SIZE;
>      s->cdb_size =3D VIRTIO_SCSI_CDB_DEFAULT_SIZE;
> =20
> -    s->ctrl_vq =3D virtio_add_queue(vdev, VIRTIO_SCSI_VQ_SIZE, ctrl);
> -    s->event_vq =3D virtio_add_queue(vdev, VIRTIO_SCSI_VQ_SIZE, evt);
> +    s->ctrl_vq =3D virtio_add_queue(vdev, s->conf.virtqueue_size, ctrl);
> +    s->event_vq =3D virtio_add_queue(vdev, s->conf.virtqueue_size, evt);
>      for (i =3D 0; i < s->conf.num_queues; i++) {
> -        s->cmd_vqs[i] =3D virtio_add_queue(vdev, VIRTIO_SCSI_VQ_SIZE, cm=
d);
> +        s->cmd_vqs[i] =3D virtio_add_queue(vdev, s->conf.virtqueue_size,=
 cmd);
>      }
>  }

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZjYmgAAoJEJykq7OBq3PIf3sIAML8yyOVmo+frwePV27Nh85b
wgqxKf9meq1JhLT6jUssy8EoYIpD4jamYQtSWksraQt1saOdK63S1xOpI017imxD
6MwJ2X2VPrl6yCFoiD2HR6x0PguScUNu2mXovjma+rtzUuy5+mi6NuPKbWs2cPDe
iMh934Ne784WT9CprWYIawuhmo8465iSTurfTPgTe585qedG0rv22sgrEyksZSgA
E+r/FokcgKX3YsbQIXfDrFJS0u44VB2JAoMTd5jTGs2iigR1f+avZd5D1UBb0pdm
GlQtblMOSWhjSIxiTt9eEGwAZLHsemhulF7Wif8Yg/o5kRP/8MLAyDCaaLge604=
=q1PI
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
