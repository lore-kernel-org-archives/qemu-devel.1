Received: from eggs.gnu.org ([2001:4830:134:3::10]:44085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fUwrE-0002EY-BJ
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:18:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fUwr8-0005Cx-Ad
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:18:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45476 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fUwr8-0005Cc-4a
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:18:14 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C8B267DAC3
	for <qemu-devel@nongnu.org>; Mon, 18 Jun 2018 16:18:13 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 18 Jun 2018 18:17:20 +0200
Message-Id: <20180618161729.334-18-marcandre.lureau@redhat.com>
In-Reply-To: <20180618161729.334-1-marcandre.lureau@redhat.com>
References: <20180618161729.334-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 17/26] virtio: add virtio-gpu bswap helpers
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
Cc: berrange@redhat.com, kraxel@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/hw/virtio/virtio-gpu-bswap.h | 48 ++++++++++++++++++++++++++++
 hw/display/virtio-gpu.c              | 43 +------------------------
 2 files changed, 49 insertions(+), 42 deletions(-)
 create mode 100644 include/hw/virtio/virtio-gpu-bswap.h

diff --git a/include/hw/virtio/virtio-gpu-bswap.h b/include/hw/virtio/vir=
tio-gpu-bswap.h
new file mode 100644
index 0000000000..bc9e895f9c
--- /dev/null
+++ b/include/hw/virtio/virtio-gpu-bswap.h
@@ -0,0 +1,48 @@
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
index 2dd3c3481a..6a55416be7 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -18,6 +18,7 @@
 #include "trace.h"
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/virtio-gpu.h"
+#include "hw/virtio/virtio-gpu-bswap.h"
 #include "hw/virtio/virtio-bus.h"
 #include "migration/blocker.h"
 #include "qemu/log.h"
@@ -30,48 +31,6 @@ virtio_gpu_find_resource(VirtIOGPU *g, uint32_t resour=
ce_id);
=20
 static void virtio_gpu_cleanup_mapping(struct virtio_gpu_simple_resource=
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
2.18.0.rc1
