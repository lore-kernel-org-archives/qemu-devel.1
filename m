Received: from eggs.gnu.org ([2001:4830:134:3::10]:49555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1djdHA-0001Uu-9j
	for qemu-devel@nongnu.org; Sun, 20 Aug 2017 23:21:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1djdH7-0001Zw-1a
	for qemu-devel@nongnu.org; Sun, 20 Aug 2017 23:21:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51666)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1djdH6-0001Z1-RE
	for qemu-devel@nongnu.org; Sun, 20 Aug 2017 23:21:12 -0400
References: <1503280223-6880-1-git-send-email-lu.zhipeng@zte.com.cn>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <2a48da8e-67fa-87b0-d4c8-0ba49bca54b8@redhat.com>
Date: Mon, 21 Aug 2017 11:11:32 +0800
MIME-Version: 1.0
In-Reply-To: <1503280223-6880-1-git-send-email-lu.zhipeng@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] vhost: don't set vring call fd to -1 in
 vhost_virtqueue_start for vhost-user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ZhiPeng Lu <lu.zhipeng@zte.com.cn>, mst@redhat.com
Cc: qemu-devel@nongnu.org



On 2017=E5=B9=B408=E6=9C=8821=E6=97=A5 09:50, ZhiPeng Lu wrote:
> commit 96a3d98d2cdbd897ff5ab33427aa4cfb94077665 (vhost: don't set vring=
 call
> if no vector) set vring call fd to -1 for drivers does not use interrup=
t
> at all(e.g virtio-net pmd). That patch setting vring call fd to -1 caus=
e
> the network to not work when running dpdk in the guest. The openvswitch=
 port
> status is down by executing the command "ovs-vsctl list interface"
> in host of running the guest. The network is ok if it doesn't set vring=
 call fd
> to -1 in vhost_virtqueue_start.
> The patch doesn't set vring call fd to -1 for vhost-user.
>
> Signed-off-by: ZhiPeng Lu <lu.zhipeng@zte.com.cn>
> ---
>   hw/virtio/vhost.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 6eddb09..bb8db7d 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -1098,7 +1098,8 @@ static int vhost_virtqueue_start(struct vhost_dev=
 *dev,
>  =20
>       if (k->query_guest_notifiers &&
>           k->query_guest_notifiers(qbus->parent) &&
> -        virtio_queue_vector(vdev, idx) =3D=3D VIRTIO_NO_VECTOR) {
> +        virtio_queue_vector(vdev, idx) =3D=3D VIRTIO_NO_VECTOR &&
> +        vdev->use_guest_notifier_mask) {
>           file.fd =3D -1;
>           r =3D dev->vhost_ops->vhost_set_vring_call(dev, &file);
>           if (r) {

Hi:

Which kind/version of vhost-user bakcend did you use? What happen if we=20
don't do vhost_set_vring_call for it? Is this a bug of vhost-user=20
backend instead of qemu?

Thanks
