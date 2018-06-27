Received: from eggs.gnu.org ([2001:4830:134:3::10]:51672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1fY8Hj-0002xO-Aw
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 07:06:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1fY8Hg-00087v-6a
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 07:06:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59080)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1fY8Hf-00087T-WA
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 07:06:48 -0400
Date: Wed, 27 Jun 2018 07:06:45 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <2067006616.46310203.1530097605117.JavaMail.zimbra@redhat.com>
In-Reply-To: <20180627102142.GB5955@stefanha-x1.localdomain>
References: <20180627082248.14921-1-pagupta@redhat.com>
	<20180627082248.14921-3-pagupta@redhat.com>
	<20180627102142.GB5955@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] virtio: Set status early in
 VirtIODevice parent object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: mst@redhat.com, amit@kernel.org, qemu-devel@nongnu.org, slopezpa@redhat.com


> 
> On Wed, Jun 27, 2018 at 01:52:48PM +0530, Pankaj Gupta wrote:
> >  To process pending requests for driver status 'VIRTIO_CONFIG_S_DRIVER_OK',
> >  virtio-rng 'set_status' calls 'is_guest_ready' function. This checks if
> >  virtqueue is ready and status is set to 'VIRTIO_CONFIG_S_DRIVER_OK'.
> > 
> >  This call is made before new status is updated in VirtIODevice parent
> >  object
> >  and calling function uses old status value.
> > 
> > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> > ---
> >  hw/virtio/virtio.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > index d4e4d98b59..37dc59a686 100644
> > --- a/hw/virtio/virtio.c
> > +++ b/hw/virtio/virtio.c
> > @@ -1154,10 +1154,11 @@ int virtio_set_status(VirtIODevice *vdev, uint8_t
> > val)
> >              }
> >          }
> >      }
> > +    vdev->status = val;
> > +
> >      if (k->set_status) {
> >          k->set_status(vdev, val);
> >      }
> > -    vdev->status = val;
> 
> This breaks existing ->set_status() callbacks that rely on vdev->status
> containing the old value.  Have you audited them?

I did not audit them all. I thought that's the way it should be base object
first get updated. But you are right, it can break things where old status is used.

> 
> For example, virtio_net_set_status -> virtio_net_vnet_endian_status uses
> vdev->status!
> 
> It may be easier to modify virtio-rng.c so that the old status value
> isn't used.

Just updating status only for virtio_rng_set_status looks okay? This will avoid
multiple copies of status as different functions are using it.

I will send a V2.

+static void virtio_rng_set_status(VirtIODevice *vdev, uint8_t status)
+{
+    VirtIORNG *vrng = VIRTIO_RNG(vdev);
+
+    if (!vdev->vm_running) {
+        return;
+    }
+    vdev->status = status;
+
+    /* Something changed, try to process buffers */
+    virtio_rng_process(vrng);
+}
+


Thanks,
Pankaj

> 
> Stefan
> 
