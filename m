Received: from eggs.gnu.org ([2001:4830:134:3::10]:45481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cVbpz-0000Kj-Mo
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 05:27:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cVbpv-00057k-5Y
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 05:26:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54624)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cVbpu-00057R-W7
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 05:26:55 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C02A0624AC
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 10:26:54 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 23 Jan 2017 11:26:50 +0100
Message-Id: <1485167210-4757-1-git-send-email-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] virtio-gpu: fix resource leak in
 virgl_cmd_resource_unref
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

When the guest sends VIRTIO_GPU_CMD_RESOURCE_UNREF without detaching the
backing storage beforehand (VIRTIO_GPU_CMD_RESOURCE_DETACH_BACKING)
we'll leak memory.

This patch fixes it for 3d mode, simliar to the 2d mode fix in commit
"b8e2392 virtio-gpu: call cleanup mapping function in resource destroy".

Reported-by: =E6=9D=8E=E5=BC=BA <liqiang6-s@360.cn>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/virtio-gpu-3d.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/display/virtio-gpu-3d.c b/hw/display/virtio-gpu-3d.c
index f96a0c2..ecb09d1 100644
--- a/hw/display/virtio-gpu-3d.c
+++ b/hw/display/virtio-gpu-3d.c
@@ -77,10 +77,18 @@ static void virgl_cmd_resource_unref(VirtIOGPU *g,
                                      struct virtio_gpu_ctrl_command *cmd=
)
 {
     struct virtio_gpu_resource_unref unref;
+    struct iovec *res_iovs =3D NULL;
+    int num_iovs =3D 0;
=20
     VIRTIO_GPU_FILL_CMD(unref);
     trace_virtio_gpu_cmd_res_unref(unref.resource_id);
=20
+    virgl_renderer_resource_detach_iov(unref.resource_id,
+                                       &res_iovs,
+                                       &num_iovs);
+    if (res_iovs !=3D NULL && num_iovs !=3D 0) {
+        virtio_gpu_cleanup_mapping_iov(res_iovs, num_iovs);
+    }
     virgl_renderer_resource_unref(unref.resource_id);
 }
=20
--=20
1.8.3.1
