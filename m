Received: from eggs.gnu.org ([2001:4830:134:3::10]:51473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lepton@google.com>) id 1eCUkH-0002LO-4c
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 13:06:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lepton@google.com>) id 1eCUjU-0000UK-7Y
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 13:06:37 -0500
Received: from mail-io0-x244.google.com ([2607:f8b0:4001:c06::244]:51471)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lepton@google.com>) id 1eCUjT-0000TH-Ua
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 13:05:48 -0500
Received: by mail-io0-x244.google.com with SMTP id b186so6893033iof.8
	for <qemu-devel@nongnu.org>; Wed, 08 Nov 2017 10:05:47 -0800 (PST)
From: Tao Wu <lepton@google.com>
Date: Wed,  8 Nov 2017 10:05:36 -0800
Message-Id: <20171108180536.38781-1-lepton@google.com>
Subject: [Qemu-devel] [PATCH] virtio-gpu: fix bug in host memory calculation.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, kraxel@redhat.com
Cc: marcandre.lureau@redhat.com, airlied@redhat.com, liqiang6-s@360.cn, Tao Wu <lepton@google.com>

The old code treats bits as bytes when calculating host memory usage.
Change it to be consistent with allocation logic in pixman library.

Signed-off-by: Tao Wu <lepton@google.com>
---
 hw/display/virtio-gpu.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 43bbe09ea0..428786f291 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -322,6 +322,15 @@ static pixman_format_code_t get_pixman_format(uint32_t virtio_gpu_format)
     }
 }
 
+static uint32_t calc_image_hostmem(pixman_format_code_t pformat,
+                                   uint32_t width, uint32_t height)
+{
+    /* copied from pixman/pixman-bits-image.c, skip integer overflow check. */
+    int bpp = PIXMAN_FORMAT_BPP(pformat);
+    int stride = ((width * bpp + 0x1f) >> 5) * sizeof(uint32_t);
+    return height * stride;
+}
+
 static void virtio_gpu_resource_create_2d(VirtIOGPU *g,
                                           struct virtio_gpu_ctrl_command *cmd)
 {
@@ -366,7 +375,7 @@ static void virtio_gpu_resource_create_2d(VirtIOGPU *g,
         return;
     }
 
-    res->hostmem = PIXMAN_FORMAT_BPP(pformat) * c2d.width * c2d.height;
+    res->hostmem = calc_image_hostmem(pformat, c2d.width, c2d.height);
     if (res->hostmem + g->hostmem < g->conf.max_hostmem) {
         res->image = pixman_image_create_bits(pformat,
                                               c2d.width,
@@ -1087,7 +1096,7 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
             return -EINVAL;
         }
 
-        res->hostmem = PIXMAN_FORMAT_BPP(pformat) * res->width * res->height;
+        res->hostmem = calc_image_hostmem(pformat, res->width, res->height);
 
         res->addrs = g_new(uint64_t, res->iov_cnt);
         res->iov = g_new(struct iovec, res->iov_cnt);
-- 
2.15.0.403.gc27cc4dac6-goog
