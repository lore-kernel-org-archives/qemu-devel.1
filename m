Received: from eggs.gnu.org ([2001:4830:134:3::10]:41276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fdxpl-0004Fu-Dd
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 09:10:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fdxpk-0004dk-8R
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 09:10:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40336 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fdxpk-0004av-2B
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 09:10:04 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BF6177DAC8
	for <qemu-devel@nongnu.org>; Fri, 13 Jul 2018 13:10:03 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 13 Jul 2018 15:09:05 +0200
Message-Id: <20180713130916.4153-19-marcandre.lureau@redhat.com>
In-Reply-To: <20180713130916.4153-1-marcandre.lureau@redhat.com>
References: <20180713130916.4153-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 18/29] virtio: add virtio-gpu bswap helpers
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
Cc: airlied@redhat.com, kraxel@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

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
index ec366f4c35..28602c1a35 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -19,6 +19,7 @@
 #include "trace.h"
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/virtio-gpu.h"
+#include "hw/virtio/virtio-gpu-bswap.h"
 #include "hw/virtio/virtio-bus.h"
 #include "migration/blocker.h"
 #include "qemu/log.h"
@@ -31,48 +32,6 @@ virtio_gpu_find_resource(VirtIOGPU *g, uint32_t resour=
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
2.18.0.129.ge3331758f1
