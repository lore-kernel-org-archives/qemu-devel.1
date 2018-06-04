Received: from eggs.gnu.org ([2001:4830:134:3::10]:42476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1fPlyR-0001EN-Ni
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 05:40:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1fPlyO-0006o9-Hl
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 05:40:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50886 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wexu@redhat.com>) id 1fPlyO-0006nO-5J
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 05:40:20 -0400
Date: Mon, 4 Jun 2018 17:40:09 +0800
From: Wei Xu <wexu@redhat.com>
Message-ID: <20180604094009.GC13354@wei-ubt>
References: <1522846444-31725-1-git-send-email-wexu@redhat.com>
	<1522846444-31725-5-git-send-email-wexu@redhat.com>
	<61ac2a50-5583-2932-cac1-f661fd49e89b@redhat.com>
	<20180604013435.GB28131@wei-ubt>
	<20180604045330-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180604045330-mutt-send-email-mst@kernel.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/8] virtio: add detach element for packed
 ring(1.1)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, jfreimann@redhat.com, qemu-devel@nongnu.org, tiwei.bie@intel.com

On Mon, Jun 04, 2018 at 04:54:45AM +0300, Michael S. Tsirkin wrote:
> On Mon, Jun 04, 2018 at 09:34:35AM +0800, Wei Xu wrote:
> > On Tue, Apr 10, 2018 at 03:32:53PM +0800, Jason Wang wrote:
> > >=20
> > >=20
> > > On 2018=E5=B9=B404=E6=9C=8804=E6=97=A5 20:54, wexu@redhat.com wrote=
:
> > > >From: Wei Xu <wexu@redhat.com>
> > > >
> > > >helper for packed ring
> > >=20
> > > It's odd and hard to review if you put detach patch first. I think =
this
> > > patch needs to be reordered after the implementation of pop/map.
> >=20
> > This patch is not necessary after sync to tiwei's v5, so we can skip =
it.
> >=20
> > Wei
>=20
> I suspect we will need to bring detach back eventually but yes,
> it can wait.

Sure, I reuse the code for 1.0 for now.

Wei

>=20
> > >=20
> > > Thanks
> > >=20
> > > >Signed-off-by: Wei Xu <wexu@redhat.com>
> > > >---
> > > >  hw/virtio/virtio.c | 21 +++++++++++++++++++--
> > > >  1 file changed, 19 insertions(+), 2 deletions(-)
> > > >
> > > >diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > > >index 478df3d..fdee40f 100644
> > > >--- a/hw/virtio/virtio.c
> > > >+++ b/hw/virtio/virtio.c
> > > >@@ -561,6 +561,20 @@ static void virtqueue_unmap_sg(VirtQueue *vq,=
 const VirtQueueElement *elem,
> > > >                           elem->out_sg[i].iov_len);
> > > >  }
> > > >+static void virtqueue_detach_element_split(VirtQueue *vq,
> > > >+                            const VirtQueueElement *elem, unsigne=
d int len)
> > > >+{
> > > >+    vq->inuse--;
> > > >+    virtqueue_unmap_sg(vq, elem, len);
> > > >+}
> > > >+
> > > >+static void virtqueue_detach_element_packed(VirtQueue *vq,
> > > >+                            const VirtQueueElement *elem, unsigne=
d int len)
> > > >+{
> > > >+    vq->inuse -=3D elem->count;
> > > >+    virtqueue_unmap_sg(vq, elem, len);
> > > >+}
> > > >+
> > > >  /* virtqueue_detach_element:
> > > >   * @vq: The #VirtQueue
> > > >   * @elem: The #VirtQueueElement
> > > >@@ -573,8 +587,11 @@ static void virtqueue_unmap_sg(VirtQueue *vq,=
 const VirtQueueElement *elem,
> > > >  void virtqueue_detach_element(VirtQueue *vq, const VirtQueueElem=
ent *elem,
> > > >                                unsigned int len)
> > > >  {
> > > >-    vq->inuse--;
> > > >-    virtqueue_unmap_sg(vq, elem, len);
> > > >+    if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED)) =
{
> > > >+        virtqueue_detach_element_packed(vq, elem, len);
> > > >+    } else {
> > > >+        virtqueue_detach_element_split(vq, elem, len);
> > > >+    }
> > > >  }
> > > >  /* virtqueue_unpop:
> > >=20
>=20
