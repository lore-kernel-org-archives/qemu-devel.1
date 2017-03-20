Received: from eggs.gnu.org ([2001:4830:134:3::10]:39526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq3Zx-0001m1-0l
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 16:06:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq3Zt-0006bX-PH
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 16:06:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40162
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cq3Zt-0006az-It
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 16:06:53 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2KK3Y2O000604
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 16:06:51 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0b-001b2d01.pphosted.com with ESMTP id 29amb2435b-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 16:06:50 -0400
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 20 Mar 2017 16:06:50 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20170228132132.20231-1-pbonzini@redhat.com>
References: <20170228132132.20231-1-pbonzini@redhat.com>
Date: Mon, 20 Mar 2017 15:06:42 -0500
Message-Id: <149004040262.20793.7017812881877388006@loki>
Subject: Re: [Qemu-devel] [Qemu-stable] [PATCH] virtio: always use
 handle_aio_output if registered
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, kraxel@redhat.com, mst@redhat.com

Quoting Paolo Bonzini (2017-02-28 07:21:32)
> Commit ad07cd6 ("virtio-scsi: always use dataplane path if ioeventfd is
> active", 2016-10-30) and 9ffe337 ("virtio-blk: always use dataplane
> path if ioeventfd is active", 2016-10-30) broke the virtio 1.0
> indirect access registers.
> =

> The indirect access registers bypass the ioeventfd, so that virtio-blk
> and virtio-scsi now repeatedly try to initialize dataplane instead of
> triggering the guest->host EventNotifier.  Detect the situation by
> checking vq->handle_aio_output; if it is not NULL, trigger the
> EventNotifier, which is how the device expects to get notifications
> and in fact the only thread-safe manner to deliver them.
> =

> Fixes: ad07cd6
> Fixes: 9ffe337
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Ping for 2.9 / 2.8.1

> ---
>  hw/virtio/virtio.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> =

> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 23483c7..1206f6c 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -1458,7 +1458,18 @@ static void virtio_queue_notify_vq(VirtQueue *vq)
> =

>  void virtio_queue_notify(VirtIODevice *vdev, int n)
>  {
> -    virtio_queue_notify_vq(&vdev->vq[n]);
> +    VirtQueue *vq =3D &vdev->vq[n];
> +
> +    if (unlikely(!vq->vring.desc || vdev->broken)) {
> +        return;
> +    }
> +
> +    trace_virtio_queue_notify(vdev, vq - vdev->vq, vq);
> +    if (vq->handle_aio_output) {
> +        event_notifier_set(&vq->host_notifier);
> +    } else if (vq->handle_output) {
> +        vq->handle_output(vdev, vq);
> +    }
>  }
> =

>  uint16_t virtio_queue_vector(VirtIODevice *vdev, int n)
> -- =

> 2.9.3
> =

>=20
