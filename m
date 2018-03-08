Received: from eggs.gnu.org ([2001:4830:134:3::10]:38168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nasastry@in.ibm.com>) id 1etnor-0001Ix-AB
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 00:10:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nasastry@in.ibm.com>) id 1etnom-00068j-BQ
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 00:10:21 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37908)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nasastry@in.ibm.com>) id 1etnol-00062d-Ni
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 00:10:16 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2859x9s142486
	for <qemu-devel@nongnu.org>; Thu, 8 Mar 2018 00:10:00 -0500
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com
	[192.155.248.75])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2gjxkygbnq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 08 Mar 2018 00:09:58 -0500
Received: from localhost
	by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
	for <qemu-devel@nongnu.org> from <nasastry@in.ibm.com>;
	Thu, 8 Mar 2018 05:09:01 -0000
In-Reply-To: <152044905701.22965.8924520463227226351.stgit@bahia.lan>
From: "Nageswara R Sastry" <nasastry@in.ibm.com>
Date: Thu, 8 Mar 2018 10:38:56 +0530
References: <152044905701.22965.8924520463227226351.stgit@bahia.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="US-ASCII"
Message-Id: <OFE3A7F910.3814D427-ON6525824A.001BEDE1-6525824A.001C48BE@notes.na.collabserv.com>
Subject: Re: [Qemu-devel] [PATCH] virtio_net: flush uncompleted TX on reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Greg Kurz <groug@kaod.org>

Greg Kurz <groug@kaod.org> wrote on 08/03/2018 12:27:37 AM:

> From: Greg Kurz <groug@kaod.org>
> To: qemu-devel@nongnu.org
> Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang=20
> <jasowang@redhat.com>, R Nageswara Sastry <nasastry@in.ibm.com>
> Date: 08/03/2018 12:27 AM
> Subject: [PATCH] virtio=5Fnet: flush uncompleted TX on reset
>=20
> If the backend could not transmit a packet right away for some reason,
> the packet is queued for asynchronous sending. The corresponding vq
> element is tracked in the async=5Ftx.elem field of the VirtIONetQueue,
> for later freeing when the transmission is complete.
>=20
> If a reset happens before completion, virtio=5Fnet=5Ftx=5Fcomplete() will=
 push
> async=5Ftx.elem back to the guest anyway, and we end up with the inuse=20
flag
> of the vq being equal to -1. The next call to virtqueue=5Fpop() is then
> likely to fail with "Virtqueue size exceeded".
>=20
> This can be reproduced easily by starting a guest without a net backend,
> doing a system reset when it is booted, and finally snapshotting it.
>=20
> The appropriate fix is to ensure that such an asynchronous transmission
> cannot survive a device reset. So for all queues, we first try to send
> the packet again, and eventually we purge it if the backend still could
> not deliver it.
>=20
> Reported-by: R. Nageswara Sastry <nasastry@in.ibm.com>

Tested-by: R. Nageswara Sastry <nasastry@in.ibm.com>

> Buglink: https://urldefense.proofpoint.com/v2/url?
>=20
u=3Dhttps-3A=5F=5Fgithub.com=5Fopen-2Dpower-2Dhost-2Dos=5Fqemu=5Fissues=5F3=
7&d=3DDwICaQ&c=3Djf=5FiaSHvJObTbx-
> siA1ZOg&r=3DmxAxqGE8eb0FlPPFjDZkTNaoci-GdQbkJayE4r-
>=20
wzYY&m=3DhPoY6b601IXJbUV2uh22jBrnYuByNQpwi1d7gvN4yZs&s=3DIc3NN3mM=5FNv1gAJ7=
dY22-
> ebnJsG7c0yNkbThX8Tu6xg&e=3D
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/net/virtio-net.c |   11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 188744e17d57..eea3cdb2c700 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -422,6 +422,7 @@ static RxFilterInfo=20
> *virtio=5Fnet=5Fquery=5Frxfilter(NetClientState *nc)
>  static void virtio=5Fnet=5Freset(VirtIODevice *vdev)
>  {
>      VirtIONet *n =3D VIRTIO=5FNET(vdev);
> +    int i;
>=20
>      /* Reset back to compatibility mode */
>      n->promisc =3D 1;
> @@ -445,6 +446,16 @@ static void virtio=5Fnet=5Freset(VirtIODevice *vdev)
>      memcpy(&n->mac[0], &n->nic->conf->macaddr, sizeof(n->mac));
>      qemu=5Fformat=5Fnic=5Finfo=5Fstr(qemu=5Fget=5Fqueue(n->nic), n->mac);
>      memset(n->vlans, 0, MAX=5FVLAN >> 3);
> +
> +    /* Flush any async TX */
> +    for (i =3D 0;  i < n->max=5Fqueues; i++) {
> +        NetClientState *nc =3D qemu=5Fget=5Fsubqueue(n->nic, i);
> +
> +        if (!qemu=5Fnet=5Fqueue=5Fflush(nc->peer->incoming=5Fqueue)) {
> +            qemu=5Fnet=5Fqueue=5Fpurge(nc->peer->incoming=5Fqueue, nc);
> +        }
> +        assert(!virtio=5Fnet=5Fget=5Fsubqueue(nc)->async=5Ftx.elem);
> +    }
>  }
>=20
>  static void peer=5Ftest=5Fvnet=5Fhdr(VirtIONet *n)
>=20


With out patch:
(qemu) system=5Freset
(qemu) savevm 1
Virtqueue size exceeded
(qemu) loadvm 1
VQ 1 size 0x100 < last=5Favail=5Fidx 0x0 - used=5Fidx 0x1
Failed to load virtio-net:virtio
error while loading state for instance 0x0 of device
'pci@800000020000000:00.0/virtio-net'
Error -1 while loading VM state

With patch:
(qemu) system=5Freset
(qemu) savevm 1
(qemu) loadvm 1
