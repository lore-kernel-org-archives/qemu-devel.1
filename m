Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02BBAC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 13:28:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA58120863
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 13:28:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA58120863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36258 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTnlu-0006pU-33
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 09:28:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gert.wollny@collabora.com>) id 1hTlWd-0004e9-4D
	for qemu-devel@nongnu.org; Thu, 23 May 2019 07:04:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gert.wollny@collabora.com>) id 1hTlWc-0002U4-0T
	for qemu-devel@nongnu.org; Thu, 23 May 2019 07:04:43 -0400
Received: from bhuna.collabora.co.uk ([2a00:1098:0:82:1000:25:2eeb:e3e3]:59570)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <gert.wollny@collabora.com>)
	id 1hTlWb-0002Py-RX
	for qemu-devel@nongnu.org; Thu, 23 May 2019 07:04:41 -0400
Received: from Isengard.homenet.telecomitalia.it (unknown
	[IPv6:2a02:810a:940:4421:55f7:11f5:99cb:72c6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested) (Authenticated sender: gerddie)
	by bhuna.collabora.co.uk (Postfix) with ESMTPSA id D6A672808DF;
	Thu, 23 May 2019 12:04:37 +0100 (BST)
From: Gert Wollny <gert.wollny@collabora.com>
To: qemu-devel@nongnu.org
Date: Thu, 23 May 2019 13:04:34 +0200
Message-Id: <20190523110434.23830-1-gert.wollny@collabora.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1098:0:82:1000:25:2eeb:e3e3
X-Mailman-Approved-At: Thu, 23 May 2019 09:18:29 -0400
Subject: [Qemu-devel] [PATCH] virtio_gpu_3d: make it possible to configure
 the fence poll time
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
Cc: Gert Wollny <gert.wollny@collabora.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The default fence poll time of 10ms (100 Hz) is sufficent for normal
work loads, but if one wants to play games within the virtual machine
this value might be too high, so make it possible to configure this
value by using the environment variable QEMU_VIRGL_POLL_FREQ where the
poll is given in Hz. To acommodate higher poll frequencies also change
the timer to use micro seconds as base instead of milliseconds.



Signed-off-by: Gert Wollny <gert.wollny@collabora.com>
---
 hw/display/virtio-gpu-3d.c     | 18 ++++++++++++++++--
 include/hw/virtio/virtio-gpu.h |  1 +
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/hw/display/virtio-gpu-3d.c b/hw/display/virtio-gpu-3d.c
index 5ee3566ae0..120e593e76 100644
--- a/hw/display/virtio-gpu-3d.c
+++ b/hw/display/virtio-gpu-3d.c
@@ -17,6 +17,7 @@
 #include "trace.h"
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/virtio-gpu.h"
+#include "qemu/cutils.h"
=20
 #ifdef CONFIG_VIRGL
=20
@@ -580,7 +581,8 @@ static void virtio_gpu_fence_poll(void *opaque)
     virgl_renderer_poll();
     virtio_gpu_process_cmdq(g);
     if (!QTAILQ_EMPTY(&g->cmdq) || !QTAILQ_EMPTY(&g->fenceq)) {
-        timer_mod(g->fence_poll, qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) +=
 1);
+        timer_mod(g->fence_poll, qemu_clock_get_us(QEMU_CLOCK_VIRTUAL) +
+				  g->fence_poll_timeout);
     }
 }
=20
@@ -605,13 +607,25 @@ void virtio_gpu_virgl_reset(VirtIOGPU *g)
 int virtio_gpu_virgl_init(VirtIOGPU *g)
 {
     int ret;
+    const char *val;
=20
     ret =3D virgl_renderer_init(g, 0, &virtio_gpu_3d_cbs);
     if (ret !=3D 0) {
         return ret;
     }
=20
-    g->fence_poll =3D timer_new_ms(QEMU_CLOCK_VIRTUAL,
+    g->fence_poll_timeout =3D 10000; /* default 10 ms */
+    val =3D getenv("QEMU_VIRGL_POLL_FREQ");
+    if (val) {
+        unsigned long long poll_freq;
+        if (parse_uint_full(val, &poll_freq, 10) || poll_freq > UINT32_M=
AX) {
+            fprintf(stderr, "VIRGL_POLL_FREQ: Invalid integer `%s'\n", v=
al);
+            exit(1);
+        }
+        g->fence_poll_timeout =3D 1000000 / (uint32_t)poll_freq;
+    }
+
+    g->fence_poll =3D timer_new_us(QEMU_CLOCK_VIRTUAL,
                                  virtio_gpu_fence_poll, g);
=20
     if (virtio_gpu_stats_enabled(g->conf)) {
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gp=
u.h
index 60425c5d58..a9e03b25aa 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -116,6 +116,7 @@ typedef struct VirtIOGPU {
     bool renderer_reset;
     QEMUTimer *fence_poll;
     QEMUTimer *print_stats;
+    uint32_t fence_poll_timeout;
=20
     uint32_t inflight;
     struct {
--=20
2.20.1


