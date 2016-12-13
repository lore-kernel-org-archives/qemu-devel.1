Received: from eggs.gnu.org ([2001:4830:134:3::10]:51709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1cGo2g-0007nc-HA
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 09:26:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1cGo2c-0004dQ-JU
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 09:26:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34418)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1cGo2c-0004dJ-DN
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 09:26:50 -0500
Date: Tue, 13 Dec 2016 19:56:30 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <1481630872.27088.128.camel@redhat.com>
Message-ID: <alpine.LFD.2.20.1612131946260.6601@wniryva>
References: <20161213071439.32322-1-ppandit@redhat.com>
	<1481627861.27088.116.camel@redhat.com>
	<alpine.LFD.2.20.1612131703450.6298@wniryva>
	<1481630872.27088.128.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH] display: virtio-gpu-3d: check virgl
 capabilities max_size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Zhenhao Hong <zhenhaohong@gmail.com>

+-- On Tue, 13 Dec 2016, Gerd Hoffmann wrote --+
| I guess we want throw an error (VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER)
| in the error case then instead of leaving resp->hdr.type unset.

  I see, okay. Does the patch below look okay?

===
diff --git a/hw/display/virtio-gpu-3d.c b/hw/display/virtio-gpu-3d.c
index 758d33a..6ceeba3 100644
--- a/hw/display/virtio-gpu-3d.c
+++ b/hw/display/virtio-gpu-3d.c
@@ -370,8 +370,12 @@ static void virgl_cmd_get_capset(VirtIOGPU *g,
 
     virgl_renderer_get_cap_set(gc.capset_id, &max_ver,
                                &max_size);
-    resp = g_malloc(sizeof(*resp) + max_size);
+    if (!max_size) {
+        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
+        return;
+    }
 
+    resp = g_malloc(sizeof(*resp) + max_size);
     resp->hdr.type = VIRTIO_GPU_RESP_OK_CAPSET;
     virgl_renderer_fill_caps(gc.capset_id,
                              gc.capset_version,
===

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
