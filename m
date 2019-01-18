Received: from eggs.gnu.org ([209.51.188.92]:44012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkZ03-0007SL-7S
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 13:36:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkYzz-00028c-E1
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 13:36:13 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:41313)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gkYzv-0001y8-R4
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 13:36:09 -0500
Received: by mail-wr1-x442.google.com with SMTP id x10so16213153wrs.8
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 10:36:06 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Jan 2019 18:36:03 +0000
Message-Id: <20190118183603.24757-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] hw/virtio/virtio-balloon: zero-initialize the
 virtio_balloon_config struct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

In virtio_balloon_get_config() we initialize a struct virtio_balloon_config
which we then copy to guest memory. However, the local variable is not
zero initialized. This works OK at the moment because we initialize
all the fields in it; however an upcoming kernel header change will
add some new fields. If we don't zero out the whole struct then we
will start leaking a small amount of the contents of QEMU's stack
to the guest as soon as we update linux-headers/ to a set of headers
that includes the new fields.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
It looks like none of the other virtio devices have this bug.
Tested with "make check" only.
As the commit message notes, must go in before our next headers update.
---
 hw/virtio/virtio-balloon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 1728e4f83af..a12677d4d5b 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -311,7 +311,7 @@ out:
 static void virtio_balloon_get_config(VirtIODevice *vdev, uint8_t *config_data)
 {
     VirtIOBalloon *dev = VIRTIO_BALLOON(vdev);
-    struct virtio_balloon_config config;
+    struct virtio_balloon_config config = {};
 
     config.num_pages = cpu_to_le32(dev->num_pages);
     config.actual = cpu_to_le32(dev->actual);
-- 
2.20.1
