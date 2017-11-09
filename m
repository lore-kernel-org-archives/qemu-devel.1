Received: from eggs.gnu.org ([2001:4830:134:3::10]:34044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lepton@google.com>) id 1eCrOq-000402-BX
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 13:18:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lepton@google.com>) id 1eCrOp-0005YK-Hc
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 13:18:00 -0500
Received: from mail-io0-x241.google.com ([2607:f8b0:4001:c06::241]:44620)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lepton@google.com>) id 1eCrOp-0005Xl-Ba
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 13:17:59 -0500
Received: by mail-io0-x241.google.com with SMTP id m16so10845174iod.1
	for <qemu-devel@nongnu.org>; Thu, 09 Nov 2017 10:17:58 -0800 (PST)
From: Tao Wu <lepton@google.com>
Date: Thu,  9 Nov 2017 10:17:41 -0800
Message-Id: <20171109181741.31318-1-lepton@google.com>
In-Reply-To: <152319465.38481678.1510223677165.JavaMail.zimbra@redhat.com>
References: <152319465.38481678.1510223677165.JavaMail.zimbra@redhat.com>
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
Cc: marcandre.lureau@redhat.com, airlied@redhat.com, Tao Wu <lepton@google.com>

The old code treats bits as bytes when calculating host memory usage.
Change it to be consistent with allocation logic in pixman library.

Signed-off-by: Tao Wu <lepton@google.com>
---
 hw/display/virtio-gpu.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 43bbe09ea0..274e365713 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -322,6 +322,18 @@ static pixman_format_code_t get_pixman_format(uint32_t virtio_gpu_format)
     }
 }
 
+static uint32_t calc_image_hostmem(pixman_format_code_t pformat,
+                                   uint32_t width, uint32_t height)
+{
+    /* Copied from pixman/pixman-bits-image.c, skip integer overflow check.
+     * pixman_image_create_bits will fail in case it overflow.
+     */
+
+    int bpp = PIXMAN_FORMAT_BPP(pformat);
+    int stride = ((width * bpp + 0x1f) >> 5) * sizeof(uint32_t);
+    return height * stride;
+}
+
 static void virtio_gpu_resource_create_2d(VirtIOGPU *g,
                                           struct virtio_gpu_ctrl_command *cmd)
 {
@@ -366,7 +378,7 @@ static void virtio_gpu_resource_create_2d(VirtIOGPU *g,
         return;
     }
 
-    res->hostmem = PIXMAN_FORMAT_BPP(pformat) * c2d.width * c2d.height;
+    res->hostmem = calc_image_hostmem(pformat, c2d.width, c2d.height);
     if (res->hostmem + g->hostmem < g->conf.max_hostmem) {
         res->image = pixman_image_create_bits(pformat,
                                               c2d.width,
@@ -1087,7 +1099,7 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
             return -EINVAL;
         }
 
-        res->hostmem = PIXMAN_FORMAT_BPP(pformat) * res->width * res->height;
+        res->hostmem = calc_image_hostmem(pformat, res->width, res->height);
 
         res->addrs = g_new(uint64_t, res->iov_cnt);
         res->iov = g_new(struct iovec, res->iov_cnt);
-- 
2.15.0.448.gf294e3d99a-goog
