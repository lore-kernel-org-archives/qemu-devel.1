Received: from eggs.gnu.org ([2001:4830:134:3::10]:43105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fTezZ-0000XD-MO
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 23:01:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fTezY-0002Pt-Qs
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 23:01:37 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 15 Jun 2018 11:01:20 +0800
Message-Id: <1529031683-27458-2-git-send-email-jasowang@redhat.com>
In-Reply-To: <1529031683-27458-1-git-send-email-jasowang@redhat.com>
References: <1529031683-27458-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 1/4] tap: set vhostfd passed from qemu cli to
 non-blocking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: Brijesh Singh <brijesh.singh@amd.com>, qemu-stable@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>

From: Brijesh Singh <brijesh.singh@amd.com>

A guest boot hangs while probing the network interface when
iommu_platform=on is used.

The following qemu cli hangs without this patch:

# $QEMU \
  -netdev tap,fd=3,id=hostnet0,vhost=on,vhostfd=4 3<>/dev/tap67 4<>/dev/host-net \
  -device virtio-net-pci,netdev=hostnet0,id=net0,iommu_platform=on,disable-legacy=on \
  ...

Commit: c471ad0e9bd46 (vhost_net: device IOTLB support) took care of
setting vhostfd to non-blocking when QEMU opens /dev/host-net but if
the fd is passed from qemu cli then we need to ensure that fd is set
to non-blocking.

Fixes: c471ad0e9bd46 ("vhost_net: device IOTLB support")
Cc: qemu-stable@nongnu.org
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/tap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/tap.c b/net/tap.c
index de05f20..2126f48 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -40,6 +40,7 @@
 #include "qemu-common.h"
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
+#include "qemu/sockets.h"
 
 #include "net/tap.h"
 
@@ -693,6 +694,7 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
                 }
                 return;
             }
+            qemu_set_nonblock(vhostfd);
         } else {
             vhostfd = open("/dev/vhost-net", O_RDWR);
             if (vhostfd < 0) {
-- 
2.7.4
