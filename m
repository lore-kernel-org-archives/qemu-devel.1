Received: from eggs.gnu.org ([2001:4830:134:3::10]:57574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gQuxp-0007xC-O5
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 09:00:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gQuxm-0007Ek-Jf
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 09:00:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:64344)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wexu@redhat.com>) id 1gQuxm-0007Ds-EU
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 09:00:42 -0500
Date: Sun, 25 Nov 2018 21:59:00 +0800
From: Wei Xu <wexu@redhat.com>
Message-ID: <20181125135900.GA16714@wei-ubt>
References: <1542895581-10721-1-git-send-email-wexu@redhat.com>
	<2a4aa88d-37ce-7b9e-14c9-238b1e0ffd5c@redhat.com>
	<20181123055737.GA8087@wei-ubt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181123055737.GA8087@wei-ubt>
Subject: Re: [Qemu-devel] [PATCH v1 00/16] packed ring virtio-net backend
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: jasowang@redhat.com, jfreimann@redhat.com, qemu-devel@nongnu.org, tiwei.bie@intel.com, mst@redhat.com

On Fri, Nov 23, 2018 at 01:57:37PM +0800, Wei Xu wrote:
> On Thu, Nov 22, 2018 at 06:57:31PM +0100, Maxime Coquelin wrote:
> > Hi Wei,
> > 
> > I just tested your series with Tiwei's v3, and it fails
> > with ctrl vq enabled:
> > qemu-system-x86_64: virtio-net ctrl missing headers
> 
> OK, I haven't tried Tiwei's v3 yet, will give it a try.

Hi Maxime,
It is caused by the _F_NEXT flag bit for indirect descriptor as
mentioned by tiwei, this patch is needed to fix it.

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 7487d3d..8e61e6f 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -1478,7 +1478,11 @@ static void *virtqueue_packed_pop(VirtQueue *vq, size_t sz)
             i -= vq->vring.num;
         }
 
-        if (desc.flags & VRING_DESC_F_NEXT) {
+        if (cache == &indirect_desc_cache) {
+            if (i == max)
+                break;
+            vring_packed_desc_read(vq->vdev, &desc, cache, i);
+        } else if (desc.flags & VRING_DESC_F_NEXT) {
             vring_packed_desc_read(vq->vdev, &desc, cache, i);
         } else {
 
