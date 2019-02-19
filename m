Received: from eggs.gnu.org ([209.51.188.92]:56425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gw3BH-0002bc-Lg
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 06:03:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gw3B7-0005yR-Rc
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 06:03:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37435)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wexu@redhat.com>) id 1gw3B5-0005vO-Rv
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 06:03:08 -0500
Date: Tue, 19 Feb 2019 19:00:03 +0800
From: Wei Xu <wexu@redhat.com>
Message-ID: <20190219110003.GE15343@wei-ubt>
References: <1550118402-4057-1-git-send-email-wexu@redhat.com>
	<1550118402-4057-11-git-send-email-wexu@redhat.com>
	<af2abdf0-3f96-6e97-d5c0-5ab2211222e1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <af2abdf0-3f96-6e97-d5c0-5ab2211222e1@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 10/11] virtio: migration support for
 packed ring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, tiwei.bie@intel.com, mst@redhat.com, jfreiman@redhat.com, maxime.coquelin@redhat.com

On Tue, Feb 19, 2019 at 03:30:41PM +0800, Jason Wang wrote:
>=20
> On 2019/2/14 =E4=B8=8B=E5=8D=8812:26, wexu@redhat.com wrote:
> >From: Wei Xu <wexu@redhat.com>
> >
> >Both userspace and vhost-net/user are supported with this patch.
> >
> >A new subsection is introduced for packed ring, only 'last_avail_idx'
> >and 'last_avail_wrap_counter' are saved/loaded presumably based on
> >all the others relevant data(inuse, used/avail index and wrap count
> >should be the same.
>=20
>=20
> This is probably only true for net device, see comment in virtio_load()=
:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 * Some devices migrate VirtQueueElements that have been popped
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 * from the avail ring but not yet returned to the used ring.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 * Since max ring size < UINT16_MAX it's safe to use modulo
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 * UINT16_MAX + 1 subtraction.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vdev=
->vq[i].inuse =3D (uint16_t)(vdev->vq[i].last_avail_idx -
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vdev->vq[i].used_idx);
>=20
>=20
> So you need to migrate used_idx and used_wrap_counter since we don't ha=
ve
> used idx.

This is trying to align with vhost-net/user as we discussed, since all we
have done is to support  virtio-net device for packed ring, maybe we can
consider supporting other devices after we have got it verified.

>=20
>=20
> >
> >Signed-off-by: Wei Xu <wexu@redhat.com>
> >---
> >  hw/virtio/virtio.c | 69 ++++++++++++++++++++++++++++++++++++++++++++=
+++++++---
> >  1 file changed, 66 insertions(+), 3 deletions(-)
> >
> >diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> >index 8cfc7b6..7c5de07 100644
> >--- a/hw/virtio/virtio.c
> >+++ b/hw/virtio/virtio.c
> >@@ -2349,6 +2349,13 @@ static bool virtio_virtqueue_needed(void *opaqu=
e)
> >      return virtio_host_has_feature(vdev, VIRTIO_F_VERSION_1);
> >  }
> >+static bool virtio_packed_virtqueue_needed(void *opaque)
> >+{
> >+    VirtIODevice *vdev =3D opaque;
> >+
> >+    return virtio_host_has_feature(vdev, VIRTIO_F_RING_PACKED);
> >+}
> >+
> >  static bool virtio_ringsize_needed(void *opaque)
> >  {
> >      VirtIODevice *vdev =3D opaque;
> >@@ -2390,6 +2397,17 @@ static const VMStateDescription vmstate_virtque=
ue =3D {
> >      }
> >  };
> >+static const VMStateDescription vmstate_packed_virtqueue =3D {
> >+    .name =3D "packed_virtqueue_state",
> >+    .version_id =3D 1,
> >+    .minimum_version_id =3D 1,
> >+    .fields =3D (VMStateField[]) {
> >+        VMSTATE_UINT16(last_avail_idx, struct VirtQueue),
> >+        VMSTATE_BOOL(last_avail_wrap_counter, struct VirtQueue),
> >+        VMSTATE_END_OF_LIST()
> >+    }
> >+};
> >+
> >  static const VMStateDescription vmstate_virtio_virtqueues =3D {
> >      .name =3D "virtio/virtqueues",
> >      .version_id =3D 1,
> >@@ -2402,6 +2420,18 @@ static const VMStateDescription vmstate_virtio_=
virtqueues =3D {
> >      }
> >  };
> >+static const VMStateDescription vmstate_virtio_packed_virtqueues =3D =
{
> >+    .name =3D "virtio/packed_virtqueues",
> >+    .version_id =3D 1,
> >+    .minimum_version_id =3D 1,
> >+    .needed =3D &virtio_packed_virtqueue_needed,
> >+    .fields =3D (VMStateField[]) {
> >+        VMSTATE_STRUCT_VARRAY_POINTER_KNOWN(vq, struct VirtIODevice,
> >+                      VIRTIO_QUEUE_MAX, 0, vmstate_packed_virtqueue, =
VirtQueue),
> >+        VMSTATE_END_OF_LIST()
> >+    }
> >+};
> >+
> >  static const VMStateDescription vmstate_ringsize =3D {
> >      .name =3D "ringsize_state",
> >      .version_id =3D 1,
> >@@ -2522,6 +2552,7 @@ static const VMStateDescription vmstate_virtio =3D=
 {
> >          &vmstate_virtio_ringsize,
> >          &vmstate_virtio_broken,
> >          &vmstate_virtio_extra_state,
> >+        &vmstate_virtio_packed_virtqueues,
> >          NULL
> >      }
> >  };
> >@@ -2794,6 +2825,17 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f=
, int version_id)
> >                  virtio_queue_update_rings(vdev, i);
> >              }
> >+            if (virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) =
{
> >+                vdev->vq[i].shadow_avail_idx =3D vdev->vq[i].last_ava=
il_idx;
> >+                vdev->vq[i].avail_wrap_counter =3D
> >+                                        vdev->vq[i].last_avail_wrap_c=
ounter;
> >+
> >+                vdev->vq[i].used_idx =3D vdev->vq[i].last_avail_idx;
> >+                vdev->vq[i].used_wrap_counter =3D
> >+                                        vdev->vq[i].last_avail_wrap_c=
ounter;
> >+                continue;
> >+            }
> >+
> >              nheads =3D vring_avail_idx(&vdev->vq[i]) - vdev->vq[i].l=
ast_avail_idx;
> >              /* Check it isn't doing strange things with descriptor n=
umbers. */
> >              if (nheads > vdev->vq[i].vring.num) {
> >@@ -2955,17 +2997,34 @@ hwaddr virtio_queue_get_used_size(VirtIODevice=
 *vdev, int n)
> >  uint16_t virtio_queue_get_last_avail_idx(VirtIODevice *vdev, int n)
> >  {
> >-    return vdev->vq[n].last_avail_idx;
> >+    uint16_t idx;
> >+
> >+    if (virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
> >+        idx =3D vdev->vq[n].last_avail_idx;
> >+        idx |=3D ((int)vdev->vq[n].avail_wrap_counter) << 15;
> >+    } else {
> >+        idx =3D (int)vdev->vq[n].last_avail_idx;
> >+    }
> >+    return idx;
> >  }
> >  void virtio_queue_set_last_avail_idx(VirtIODevice *vdev, int n, uint=
16_t idx)
> >  {
> >-    vdev->vq[n].last_avail_idx =3D idx;
> >-    vdev->vq[n].shadow_avail_idx =3D idx;
> >+    if (virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
> >+        vdev->vq[n].last_avail_idx =3D idx & 0x7fff;
> >+        vdev->vq[n].avail_wrap_counter =3D !!(idx & 0x8000);
>=20
>=20
> Let's define some macros for those magic number.

OK.

>=20
>=20
> >+    } else {
> >+        vdev->vq[n].last_avail_idx =3D idx;
> >+        vdev->vq[n].shadow_avail_idx =3D idx;
> >+    }
> >  }
> >  void virtio_queue_restore_last_avail_idx(VirtIODevice *vdev, int n)
> >  {
> >+    if (virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
> >+        return;
> >+    }
>=20
>=20
> Why doesn't packed ring care about this?

As elaborated above, used idx/wrap_counter are supposed to be the
same with avail ones for vhost-net/user.

>=20
>=20
> >+
> >      rcu_read_lock();
> >      if (vdev->vq[n].vring.desc) {
> >          vdev->vq[n].last_avail_idx =3D vring_used_idx(&vdev->vq[n]);
> >@@ -2976,6 +3035,10 @@ void virtio_queue_restore_last_avail_idx(VirtIO=
Device *vdev, int n)
> >  void virtio_queue_update_used_idx(VirtIODevice *vdev, int n)
> >  {
> >+    if (virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
> >+        return;
> >+    }
>=20
>=20
> And this?

Same as above.

Wei

>=20
> Thanks
>=20
>=20
> >+
> >      rcu_read_lock();
> >      if (vdev->vq[n].vring.desc) {
> >          vdev->vq[n].used_idx =3D vring_used_idx(&vdev->vq[n]);
