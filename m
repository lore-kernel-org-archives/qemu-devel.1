Received: from eggs.gnu.org ([2001:4830:134:3::10]:33585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cRG98-0001aE-1H
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 05:28:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cRG97-0003Qw-6l
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 05:28:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39290)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cRG97-0003QV-1K
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 05:28:45 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 11 Jan 2017 11:28:36 +0100
Message-Id: <1484130518-18873-5-git-send-email-kraxel@redhat.com>
In-Reply-To: <1484130518-18873-1-git-send-email-kraxel@redhat.com>
References: <1484130518-18873-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 4/5] virtio-gpu: Fix memory leak in
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

From: Peter Maydell <peter.maydell@linaro.org>

Coverity points out that if we fail in the "creating resources"
loop in virtio_gpu_load() we will leak various resources (CID 1356431).
Failing a VM load is going to leave the simulation in a complete mess,
but we can tidy up to the point that a full system reset should
get us back to sanity.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 1483969123-14839-3-git-send-email-peter.maydell@linaro.org
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
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
1.8.3.1
