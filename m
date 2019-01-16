Received: from eggs.gnu.org ([209.51.188.92]:45740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gjpTo-0008GX-69
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 12:59:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gjpTn-0006bJ-CD
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 12:59:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58759)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wexu@redhat.com>) id 1gjpTn-0006am-5q
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 12:59:55 -0500
Date: Thu, 17 Jan 2019 01:50:03 +0800
From: Wei Xu <wexu@redhat.com>
Message-ID: <20190116175003.GC28579@wei-ubt>
References: <1542895581-10721-1-git-send-email-wexu@redhat.com>
	<1542895581-10721-13-git-send-email-wexu@redhat.com>
	<e0fc9da4-264a-b003-0304-470b15d28368@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e0fc9da4-264a-b003-0304-470b15d28368@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 12/16] virtio: add userspace migration
 of packed ring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, maxime.coquelin@redhat.com, jfreimann@redhat.com, tiwei.bie@intel.com, mst@redhat.com

On Thu, Nov 22, 2018 at 10:45:36PM +0800, Jason Wang wrote:
>=20
> On 2018/11/22 =E4=B8=8B=E5=8D=8810:06, wexu@redhat.com wrote:
> >From: Wei Xu <wexu@redhat.com>
> >
> >Signed-off-by: Wei Xu <wexu@redhat.com>
>=20
>=20
> I think you need subsection. Otherwise you will break migration
> compatibility.

ok, thanks.

Wei

>=20
> Thanks
>=20
>=20
> >---
> >  hw/virtio/virtio.c | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >
> >diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> >index 240c4e3..64d5c04 100644
> >--- a/hw/virtio/virtio.c
> >+++ b/hw/virtio/virtio.c
> >@@ -2558,6 +2558,12 @@ int virtio_save(VirtIODevice *vdev, QEMUFile *f=
)
> >           */
> >          qemu_put_be64(f, vdev->vq[i].vring.desc);
> >          qemu_put_be16s(f, &vdev->vq[i].last_avail_idx);
> >+        qemu_put_8s(f, (const uint8_t *)&vdev->vq[i].avail_wrap_count=
er);
> >+        qemu_put_8s(f, (const uint8_t *)&vdev->vq[i].event_wrap_count=
er);
> >+        qemu_put_8s(f, (const uint8_t *)&vdev->vq[i].used_wrap_counte=
r);
> >+        qemu_put_be16s(f, &vdev->vq[i].used_idx);
> >+        qemu_put_be16s(f, &vdev->vq[i].shadow_avail_idx);
> >+        qemu_put_be32s(f, &vdev->vq[i].inuse);
> >          if (k->save_queue) {
> >              k->save_queue(qbus->parent, i, f);
> >          }
> >@@ -2705,6 +2711,14 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f=
, int version_id)
> >          }
> >          vdev->vq[i].vring.desc =3D qemu_get_be64(f);
> >          qemu_get_be16s(f, &vdev->vq[i].last_avail_idx);
> >+
> >+        qemu_get_8s(f, (uint8_t *)&vdev->vq[i].avail_wrap_counter);
> >+        qemu_get_8s(f, (uint8_t *)&vdev->vq[i].event_wrap_counter);
> >+        qemu_get_8s(f, (uint8_t *)&vdev->vq[i].used_wrap_counter);
> >+        qemu_get_be16s(f, &vdev->vq[i].used_idx);
> >+        qemu_get_be16s(f, &vdev->vq[i].shadow_avail_idx);
> >+        qemu_get_be32s(f, &vdev->vq[i].inuse);
> >+
> >          vdev->vq[i].signalled_used_valid =3D false;
> >          vdev->vq[i].notification =3D true;
> >@@ -2786,6 +2800,10 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f=
, int version_id)
> >                  virtio_queue_update_rings(vdev, i);
> >              }
> >+            if (virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) =
{
> >+                continue;
> >+            }
> >+
> >              nheads =3D vring_avail_idx(&vdev->vq[i]) - vdev->vq[i].l=
ast_avail_idx;
> >              /* Check it isn't doing strange things with descriptor n=
umbers. */
> >              if (nheads > vdev->vq[i].vring.num) {
>=20
