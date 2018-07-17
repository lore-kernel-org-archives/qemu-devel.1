Received: from eggs.gnu.org ([2001:4830:134:3::10]:49443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1ffYl9-0005WI-U1
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 18:47:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1ffYl9-0000sv-1e
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 18:47:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:29272)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1ffYl8-0000sJ-K3
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 18:47:54 -0400
From: Alex Williamson <alex.williamson@redhat.com>
Date: Tue, 17 Jul 2018 16:47:51 -0600
Message-ID: <20180717224751.14019.95362.stgit@gimli.home>
In-Reply-To: <20180717222721.14019.27548.stgit@gimli.home>
References: <20180717222721.14019.27548.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [RFC PATCH 3/3] vfio: Inhibit ballooning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org

For all directly assigned devices and potentially some mdev devices,
internal management of pinned pages is incompatible with ballooning.
In the case of mdev devices, QEMU cannot know which pages the vendor
driver has mapped for the device.  It could be only the working set,
which should never be a ballooning victim page, or it could be the
entire VM address space.  Until the vfio IOMMU interface can tell us
more about the support for handling ballooning, assume any vfio
container inhibits ballooning.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/vfio/common.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index fb396cf00ac4..8124dd8df3c1 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -32,6 +32,7 @@
 #include "hw/hw.h"
 #include "qemu/error-report.h"
 #include "qemu/range.h"
+#include "sysemu/balloon.h"
 #include "sysemu/kvm.h"
 #include "trace.h"
 #include "qapi/error.h"
@@ -1218,6 +1219,9 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
 
     container->initialized = true;
 
+    /* vfio is currently incompatible with ballooning */
+    qemu_balloon_inhibit(true);
+
     return 0;
 listener_release_exit:
     QLIST_REMOVE(group, container_next);
@@ -1276,6 +1280,8 @@ static void vfio_disconnect_container(VFIOGroup *group)
         g_free(container);
 
         vfio_put_address_space(space);
+
+        qemu_balloon_inhibit(false);
     }
 }
 
