Received: from eggs.gnu.org ([2001:4830:134:3::10]:49557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1fVBSo-000662-Es
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 03:54:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1fVBSj-0006H2-HW
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 03:54:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40554 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wexu@redhat.com>) id 1fVBSj-0006Ft-BM
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 03:54:01 -0400
Date: Tue, 19 Jun 2018 15:53:55 +0800
From: Wei Xu <wexu@redhat.com>
Message-ID: <20180619075355.GA23983@wei-ubt>
References: <1528225683-11413-1-git-send-email-wexu@redhat.com>
	<1528225683-11413-9-git-send-email-wexu@redhat.com>
	<6972a450-117a-2f3c-fb44-fb985c35b8e6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6972a450-117a-2f3c-fb44-fb985c35b8e6@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v2 8/8] virtio: guest driver reload for
 vhost-net
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, tiwei.bie@intel.com, mst@redhat.com, jfreimann@redhat.com

On Wed, Jun 06, 2018 at 11:48:19AM +0800, Jason Wang wrote:
>=20
>=20
> On 2018=E5=B9=B406=E6=9C=8806=E6=97=A5 03:08, wexu@redhat.com wrote:
> >From: Wei Xu <wexu@redhat.com>
> >
> >last_avail, avail_wrap_count, used_idx and used_wrap_count are
> >needed to support vhost-net backend, all these are either 16 or
> >bool variables, since state.num is 64bit wide, so here it is
> >possible to put them to the 'num' without introducing a new case
> >while handling ioctl.
> >
> >Unload/Reload test has been done successfully with a patch in vhost ke=
rnel.
>=20
> You need a patch to enable vhost.
>=20
> And I think you can only do it for vhost-kenrel now since vhost-user
> protocol needs some extension I believe.

OK.

>=20
> >
> >Signed-off-by: Wei Xu <wexu@redhat.com>
> >---
> >  hw/virtio/virtio.c | 42 ++++++++++++++++++++++++++++++++++--------
> >  1 file changed, 34 insertions(+), 8 deletions(-)
> >
> >diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> >index 4543974..153f6d7 100644
> >--- a/hw/virtio/virtio.c
> >+++ b/hw/virtio/virtio.c
> >@@ -2862,33 +2862,59 @@ hwaddr virtio_queue_get_used_size(VirtIODevice=
 *vdev, int n)
> >      }
> >  }
> >-uint16_t virtio_queue_get_last_avail_idx(VirtIODevice *vdev, int n)
> >+uint64_t virtio_queue_get_last_avail_idx(VirtIODevice *vdev, int n)
> >  {
> >-    return vdev->vq[n].last_avail_idx;
> >+    uint64_t num;
> >+
> >+    num =3D vdev->vq[n].last_avail_idx;
> >+    if (virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
> >+        num |=3D ((uint64_t)vdev->vq[n].avail_wrap_counter) << 16;
> >+        num |=3D ((uint64_t)vdev->vq[n].used_idx) << 32;
> >+        num |=3D ((uint64_t)vdev->vq[n].used_wrap_counter) << 48;
>=20
> So s.num is 32bit, I don't think this can even work.

I mistakenly checked out s.num is 64bit, will add a new case in next vers=
ion.

Wei

>=20
> Thanks
>=20
> >+    }
> >+
> >+    return num;
> >  }
> >-void virtio_queue_set_last_avail_idx(VirtIODevice *vdev, int n, uint1=
6_t idx)
> >+void virtio_queue_set_last_avail_idx(VirtIODevice *vdev, int n, uint6=
4_t num)
> >  {
> >-    vdev->vq[n].last_avail_idx =3D idx;
> >-    vdev->vq[n].shadow_avail_idx =3D idx;
> >+    vdev->vq[n].shadow_avail_idx =3D vdev->vq[n].last_avail_idx =3D (=
uint16_t)(num);
> >+
> >+    if (virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
> >+        vdev->vq[n].avail_wrap_counter =3D (uint16_t)(num >> 16);
> >+        vdev->vq[n].used_idx =3D (uint16_t)(num >> 32);
> >+        vdev->vq[n].used_wrap_counter =3D (uint16_t)(num >> 48);
> >+    }
> >  }
> >  void virtio_queue_restore_last_avail_idx(VirtIODevice *vdev, int n)
> >  {
> >      rcu_read_lock();
> >-    if (vdev->vq[n].vring.desc) {
> >+    if (!vdev->vq[n].vring.desc) {
> >+        goto out;
> >+    }
> >+
> >+    if (!virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
> >          vdev->vq[n].last_avail_idx =3D vring_used_idx(&vdev->vq[n]);
> >-        vdev->vq[n].shadow_avail_idx =3D vdev->vq[n].last_avail_idx;
> >      }
> >+    vdev->vq[n].shadow_avail_idx =3D vdev->vq[n].last_avail_idx;
> >+
> >+out:
> >      rcu_read_unlock();
> >  }
> >  void virtio_queue_update_used_idx(VirtIODevice *vdev, int n)
> >  {
> >      rcu_read_lock();
> >-    if (vdev->vq[n].vring.desc) {
> >+    if (!vdev->vq[n].vring.desc) {
> >+        goto out;
> >+    }
> >+
> >+    if (!virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
> >          vdev->vq[n].used_idx =3D vring_used_idx(&vdev->vq[n]);
> >      }
> >+
> >+out:
> >      rcu_read_unlock();
> >  }
>=20
