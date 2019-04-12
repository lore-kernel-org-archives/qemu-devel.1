Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A91C10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 15:52:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5321520693
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 15:52:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5321520693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39027 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEyTL-0004e7-Gd
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 11:52:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hEyFq-0000sa-0l
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 11:38:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hEyFo-0001wr-UI
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 11:38:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43370)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1hEyFo-0001wd-Jb; Fri, 12 Apr 2019 11:38:12 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E2C45307D85A;
	Fri, 12 Apr 2019 15:38:11 +0000 (UTC)
Received: from localhost (ovpn-112-59.ams2.redhat.com [10.36.112.59])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D3C1760BFC;
	Fri, 12 Apr 2019 15:38:04 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 12 Apr 2019 17:36:43 +0200
Message-Id: <20190412153647.19027-10-marcandre.lureau@redhat.com>
In-Reply-To: <20190412153647.19027-1-marcandre.lureau@redhat.com>
References: <20190412153647.19027-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Fri, 12 Apr 2019 15:38:11 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v5 09/13] virtio: add virtio-gpu bswap helpers
 header
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-ppc@nongnu.org,
	Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412153643.s-5_OPDPnLiMyosqU2UthN2pVzDRwPG7Iq48eAM1Qyw@z>

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


