Received: from eggs.gnu.org ([2001:4830:134:3::10]:37968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gBxzE-0004XS-Ry
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 04:12:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gBxz9-0002a1-0R
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 04:12:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37892)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wexu@redhat.com>) id 1gBxz6-0002X0-Uz
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 04:12:18 -0400
Date: Mon, 15 Oct 2018 16:11:43 +0800
From: Wei Xu <wexu@redhat.com>
Message-ID: <20181015081143.GF27871@wei-ubt>
References: <1539266915-15216-1-git-send-email-wexu@redhat.com>
	<1539266915-15216-13-git-send-email-wexu@redhat.com>
	<18508f1e-06bf-3507-2193-ce34518dcb3f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <18508f1e-06bf-3507-2193-ce34518dcb3f@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [[RFC v3 12/12] virtio: feature vhost-net support
 for packed ring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, maxime.coquelin@redhat.com, jfreimann@redhat.com, tiwei.bie@intel.com

On Mon, Oct 15, 2018 at 03:50:21PM +0800, Jason Wang wrote:
>=20
>=20
> On 2018=E5=B9=B410=E6=9C=8811=E6=97=A5 22:08, wexu@redhat.com wrote:
> >From: Wei Xu <wexu@redhat.com>
> >
> >(cherry picked from commit 305a2c4640c15c5717245067ab937fd10f478ee6)
> >Signed-off-by: Wei Xu <wexu@redhat.com>
> >(cherry picked from commit 46476dae6f44c6fef8802a4a0ac7d0d79fe399e3)
> >Signed-off-by: Wei Xu <wexu@redhat.com>
>=20
> The cherry-pick tag looks odd.

My bad.

>=20
> >---
> >  hw/virtio/vhost.c          | 3 +++
> >  hw/virtio/virtio.c         | 4 ++++
> >  include/hw/virtio/virtio.h | 1 +
> >  3 files changed, 8 insertions(+)
> >
> >diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> >index 9df2da3..de06d55 100644
> >--- a/hw/virtio/vhost.c
> >+++ b/hw/virtio/vhost.c
> >@@ -974,6 +974,9 @@ static int vhost_virtqueue_start(struct vhost_dev =
*dev,
> >      }
> >      state.num =3D virtio_queue_get_last_avail_idx(vdev, idx);
> >+    if (virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
> >+        state.num |=3D ((int)virtio_queue_packed_get_wc(vdev, idx)) <=
< 31;
> >+    }
>=20
> We decide to use bit 15 instead.
>=20
> And please refer the recent discussion for the agreement.

OK.

>=20
> Thanks
>=20
> >      r =3D dev->vhost_ops->vhost_set_vring_base(dev, &state);
> >      if (r) {
> >          VHOST_OPS_DEBUG("vhost_set_vring_base failed");
> >diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> >index 1d25776..2a90163 100644
> >--- a/hw/virtio/virtio.c
> >+++ b/hw/virtio/virtio.c
> >@@ -2894,6 +2894,10 @@ void virtio_init(VirtIODevice *vdev, const char=
 *name,
> >      vdev->use_guest_notifier_mask =3D true;
> >  }
> >+bool virtio_queue_packed_get_wc(VirtIODevice *vdev, int n)
> >+{
> >+    return vdev->vq[n].avail_wrap_counter;
> >+}
> >  hwaddr virtio_queue_get_desc_addr(VirtIODevice *vdev, int n)
> >  {
> >      return vdev->vq[n].vring.desc;
> >diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> >index 9af8839..0bb3be5 100644
> >--- a/include/hw/virtio/virtio.h
> >+++ b/include/hw/virtio/virtio.h
> >@@ -295,6 +295,7 @@ void virtio_queue_aio_set_host_notifier_handler(Vi=
rtQueue *vq, AioContext *ctx,
> >                                                  VirtIOHandleAIOOutpu=
t handle_output);
> >  VirtQueue *virtio_vector_first_queue(VirtIODevice *vdev, uint16_t ve=
ctor);
> >  VirtQueue *virtio_vector_next_queue(VirtQueue *vq);
> >+bool virtio_queue_packed_get_wc(VirtIODevice *vdev, int n);
> >  static inline void virtio_add_feature(uint64_t *features, unsigned i=
nt fbit)
> >  {
>=20
>=20
