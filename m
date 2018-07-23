Received: from eggs.gnu.org ([2001:4830:134:3::10]:41851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhJS-0002d2-GT
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:20:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhJO-0004Mf-RV
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:20:10 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 23 Jul 2018 15:16:54 -0500
Message-Id: <20180723201748.25573-46-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
References: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 45/99] tap: set vhostfd passed from qemu cli to
 non-blocking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Brijesh Singh <brijesh.singh@amd.com>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>

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
(cherry picked from commit d542800d1edc62f63f8a29cfa6bdd1a9536ae11c)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 net/tap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/tap.c b/net/tap.c
index 2b3a36f9b5..89c4e19162 100644
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
2.17.1
