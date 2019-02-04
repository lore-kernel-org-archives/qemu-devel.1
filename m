Received: from eggs.gnu.org ([209.51.188.92]:45800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gqfag-00066I-SW
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 09:51:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gqfT1-00056s-LI
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 09:43:25 -0500
Received: from mail-qt1-f171.google.com ([209.85.160.171]:32900)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gqfT1-00055w-FN
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 09:43:23 -0500
Received: by mail-qt1-f171.google.com with SMTP id l11so137002qtp.0
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 06:43:23 -0800 (PST)
Date: Mon, 4 Feb 2019 09:43:20 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190204142638.27021-2-mst@redhat.com>
References: <20190204142638.27021-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190204142638.27021-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL 01/25] virtio: add checks for the size of the
 indirect table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Dima Stepanov <dimastep@yandex-team.ru>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: Dima Stepanov <dimastep@yandex-team.ru>

The virtqueue_pop() and virtqueue_get_avail_bytes() routines can use the
INDIRECT table to get the data. It is possible to create a packet which
will lead to the assert message like:
  include/exec/memory.h:1995: void
  address_space_read_cached(MemoryRegionCache *, hwaddr, void *, int):
  Assertion `addr < cache->len && len <= cache->len - addr' failed.
  Aborted
To do it the first descriptor should have a link to the INDIRECT table
and set the size of it to 0. It doesn't look good that the guest should
be able to trigger the assert in qemu. Add additional check for the size
of the INDIRECT table, which should not be 0.

Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/virtio/virtio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 22bd1ac34e..a1ff647a66 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -646,7 +646,7 @@ void virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
         vring_desc_read(vdev, &desc, desc_cache, i);
 
         if (desc.flags & VRING_DESC_F_INDIRECT) {
-            if (desc.len % sizeof(VRingDesc)) {
+            if (!desc.len || (desc.len % sizeof(VRingDesc))) {
                 virtio_error(vdev, "Invalid size for indirect buffer table");
                 goto err;
             }
@@ -902,7 +902,7 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
     desc_cache = &caches->desc;
     vring_desc_read(vdev, &desc, desc_cache, i);
     if (desc.flags & VRING_DESC_F_INDIRECT) {
-        if (desc.len % sizeof(VRingDesc)) {
+        if (!desc.len || (desc.len % sizeof(VRingDesc))) {
             virtio_error(vdev, "Invalid size for indirect buffer table");
             goto done;
         }
-- 
MST
