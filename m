Received: from eggs.gnu.org ([2001:4830:134:3::10]:41426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ctlAg-0007mh-Hl
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 21:16:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ctlAf-0006FQ-Lf
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 21:16:10 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 31 Mar 2017 09:15:55 +0800
Message-Id: <1490922956-19731-3-git-send-email-jasowang@redhat.com>
In-Reply-To: <1490922956-19731-1-git-send-email-jasowang@redhat.com>
References: <1490922956-19731-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 1/2] virtio-net: avoid call tap_enable when
 there's only one queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, qemu-stable@nongnu.org

We call tap_enable() even if for multiqueue is not enabled. This is
wrong since it should be used for multiqueue codes to enable a
disabled queue. Fixing this by only calling this when multiqueue is
used.

Fixes: 16dbaf905b72 ("tap: support enabling or disabling a queue")
Reported-by: Andrew Baumann <Andrew.Baumann@microsoft.com>
Tested-by: Andrew Baumann <Andrew.Baumann@microsoft.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/virtio-net.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index c321680..7d091c9 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -510,6 +510,10 @@ static int peer_attach(VirtIONet *n, int index)
         return 0;
     }
 
+    if (n->max_queues == 1) {
+        return 0;
+    }
+
     return tap_enable(nc->peer);
 }
 
-- 
2.7.4
