Received: from eggs.gnu.org ([209.51.188.92]:37120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hEyFq-0000sa-0l
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 11:38:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hEyFo-0001wr-UI
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 11:38:13 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 12 Apr 2019 17:36:43 +0200
Message-Id: <20190412153647.19027-10-marcandre.lureau@redhat.com>
In-Reply-To: <20190412153647.19027-1-marcandre.lureau@redhat.com>
References: <20190412153647.19027-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 09/13] virtio: add virtio-gpu bswap helpers
 header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

The helper functions are useful to build the vhost-user-gpu backend.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/hw/virtio/virtio-gpu-bswap.h | 61 ++++++++++++++++++++++++++++
 hw/display/virtio-gpu.c              | 43 +-------------------
 2 files changed, 62 insertions(+), 42 deletions(-)
 create mode 100644 include/hw/virtio/virtio-gpu-bswap.h

diff --git a/include/hw/virtio/virtio-gpu-bswap.h b/include/hw/virtio/vir=
tio-gpu-bswap.h
new file mode 100644
index 0000000000..38d12160f6
--- /dev/null
+++ b/include/hw/virtio/virtio-gpu-bswap.h
@@ -0,0 +1,61 @@
+/*
+ * Virtio GPU Device
+ *
+ * Copyright Red Hat, Inc. 2013-2014
+ *
+ * Authors:
+ *     Dave Airlie <airlied@redhat.com>
+ *     Gerd Hoffmann <kraxel@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef HW_VIRTIO_GPU_BSWAP_H
+#define HW_VIRTIO_GPU_BSWAP_H
+
+#include "qemu/bswap.h"
+
+static inline void
+virtio_gpu_ctrl_hdr_bswap(struct virtio_gpu_ctrl_hdr *hdr)
+{
+    le32_to_cpus(&hdr->type);
+    le32_to_cpus(&hdr->flags);
+    le64_to_cpus(&hdr->fence_id);
+    le32_to_cpus(&hdr->ctx_id);
+    le32_to_cpus(&hdr->padding);
+}
+
+static inline void
+virtio_gpu_bswap_32(void *ptr, size_t size)
+{
+#ifdef HOST_WORDS_BIGENDIAN
+
+    size_t i;
+    struct virtio_gpu_ctrl_hdr *hdr =3D (struct virtio_gpu_ctrl_hdr *) p=
tr;
+
+    virtio_gpu_ctrl_hdr_bswap(hdr);
+
+    i =3D sizeof(struct virtio_gpu_ctrl_hdr);
+    while (i < size) {
+        le32_to_cpus((uint32_t *)(ptr + i));
+        i =3D i + sizeof(uint32_t);
+    }
+
+#endif
+}
+
+static inline void
+virtio_gpu_t2d_bswap(struct virtio_gpu_transfer_to_host_2d *t2d)
+{
+    virtio_gpu_ctrl_hdr_bswap(&t2d->hdr);
+    le32_to_cpus(&t2d->r.x);
+    le32_to_cpus(&t2d->r.y);
+    le32_to_cpus(&t2d->r.width);
+    le32_to_cpus(&t2d->r.height);
+    le64_to_cpus(&t2d->offset);
+    le32_to_cpus(&t2d->resource_id);
+    le32_to_cpus(&t2d->padding);
+}
+
+#endif
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 9e37e0ac96..c35025b6fb 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -20,6 +20,7 @@
 #include "sysemu/dma.h"
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/virtio-gpu.h"
+#include "hw/virtio/virtio-gpu-bswap.h"
 #include "hw/virtio/virtio-bus.h"
 #include "hw/display/edid.h"
 #include "migration/blocker.h"
@@ -34,48 +35,6 @@ virtio_gpu_find_resource(VirtIOGPU *g, uint32_t resour=
ce_id);
 static void virtio_gpu_cleanup_mapping(VirtIOGPU *g,
                                        struct virtio_gpu_simple_resource=
 *res);
=20
-static void
-virtio_gpu_ctrl_hdr_bswap(struct virtio_gpu_ctrl_hdr *hdr)
-{
-    le32_to_cpus(&hdr->type);
-    le32_to_cpus(&hdr->flags);
-    le64_to_cpus(&hdr->fence_id);
-    le32_to_cpus(&hdr->ctx_id);
-    le32_to_cpus(&hdr->padding);
-}
-
-static void virtio_gpu_bswap_32(void *ptr,
-                                size_t size)
-{
-#ifdef HOST_WORDS_BIGENDIAN
-
-    size_t i;
-    struct virtio_gpu_ctrl_hdr *hdr =3D (struct virtio_gpu_ctrl_hdr *) p=
tr;
-
-    virtio_gpu_ctrl_hdr_bswap(hdr);
-
-    i =3D sizeof(struct virtio_gpu_ctrl_hdr);
-    while (i < size) {
-        le32_to_cpus((uint32_t *)(ptr + i));
-        i =3D i + sizeof(uint32_t);
-    }
-
-#endif
-}
-
-static void
-virtio_gpu_t2d_bswap(struct virtio_gpu_transfer_to_host_2d *t2d)
-{
-    virtio_gpu_ctrl_hdr_bswap(&t2d->hdr);
-    le32_to_cpus(&t2d->r.x);
-    le32_to_cpus(&t2d->r.y);
-    le32_to_cpus(&t2d->r.width);
-    le32_to_cpus(&t2d->r.height);
-    le64_to_cpus(&t2d->offset);
-    le32_to_cpus(&t2d->resource_id);
-    le32_to_cpus(&t2d->padding);
-}
-
 #ifdef CONFIG_VIRGL
 #include <virglrenderer.h>
 #define VIRGL(_g, _virgl, _simple, ...)                     \
--=20
2.21.0.313.ge35b8cb8e2
