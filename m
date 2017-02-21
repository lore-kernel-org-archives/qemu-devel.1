Received: from eggs.gnu.org ([2001:4830:134:3::10]:53868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cgIiK-0002qc-C0
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 17:15:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cgIiI-0004Sv-Mh
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 17:15:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58416)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cgIiI-0004SU-HN
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 17:15:14 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C293A3B721
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 22:15:14 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 21 Feb 2017 23:14:56 +0100
Message-Id: <1487715299-21102-7-git-send-email-kraxel@redhat.com>
In-Reply-To: <1487715299-21102-1-git-send-email-kraxel@redhat.com>
References: <1487715299-21102-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 6/9] virtio-gpu: use graphic_* variables.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

If graphic_* variables are set (via -g switch), pass on
that information to the guest so the driver can use it.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/virtio-gpu.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 9b530ab..04ba221 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1170,8 +1170,13 @@ static void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
     virtio_init(VIRTIO_DEVICE(g), "virtio-gpu", VIRTIO_ID_GPU,
                 g->config_size);
 
-    g->req_state[0].width = 1024;
-    g->req_state[0].height = 768;
+    if (graphic_width && graphic_height) {
+        g->req_state[0].width = graphic_width;
+        g->req_state[0].height = graphic_height;
+    } else {
+        g->req_state[0].width = 1024;
+        g->req_state[0].height = 768;
+    }
 
     if (virtio_gpu_virgl_enabled(g->conf)) {
         /* use larger control queue in 3d mode */
-- 
1.8.3.1
