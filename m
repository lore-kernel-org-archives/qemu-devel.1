Received: from eggs.gnu.org ([2001:4830:134:3::10]:38508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cQaac-0000KI-UC
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 09:06:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cQaab-0002R5-Ei
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 09:06:22 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48004)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cQaab-0002Qo-8D
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 09:06:21 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  9 Jan 2017 13:38:43 +0000
Message-Id: <1483969123-14839-3-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1483969123-14839-1-git-send-email-peter.maydell@linaro.org>
References: <1483969123-14839-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 2/2] virtio-gpu: Fix memory leak in
 virtio_gpu_load()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

Coverity points out that if we fail in the "creating resources"
loop in virtio_gpu_load() we will leak various resources (CID 1356431).
Failing a VM load is going to leave the simulation in a complete mess,
but we can tidy up to the point that a full system reset should
get us back to sanity.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/display/virtio-gpu.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index c3cf47e..cef736c 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1052,12 +1052,14 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size)
         /* allocate */
         pformat = get_pixman_format(res->format);
         if (!pformat) {
+            g_free(res);
             return -EINVAL;
         }
         res->image = pixman_image_create_bits(pformat,
                                               res->width, res->height,
                                               NULL, 0);
         if (!res->image) {
+            g_free(res);
             return -EINVAL;
         }
 
@@ -1080,6 +1082,16 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size)
             res->iov[i].iov_base =
                 cpu_physical_memory_map(res->addrs[i], &len, 1);
             if (!res->iov[i].iov_base || len != res->iov[i].iov_len) {
+                /* Clean up the half-a-mapping we just created... */
+                if (res->iov[i].iov_base) {
+                    cpu_physical_memory_unmap(res->iov[i].iov_base,
+                                              len, 0, 0);
+                }
+                /* ...and the mappings for previous loop iterations */
+                res->iov_cnt = i;
+                virtio_gpu_cleanup_mapping(res);
+                pixman_image_unref(res->image);
+                g_free(res);
                 return -EINVAL;
             }
         }
-- 
2.7.4
