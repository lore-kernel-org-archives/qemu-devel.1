Received: from eggs.gnu.org ([2001:4830:134:3::10]:60282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1frlUh-000633-If
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 10:49:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1frlUb-0002R9-BY
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 10:49:22 -0400
From: Alex Williamson <alex.williamson@redhat.com>
Date: Mon, 20 Aug 2018 08:49:03 -0600
Message-ID: <153477652845.3413.12518068251159818959.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] vfio/pci: Handle subsystem realpath()
 returning NULL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

Fix error reported by Coverity where realpath can return NULL,
resulting in a segfault in strcmp().  This should never happen given
that we're working through regularly structured sysfs paths, but
trivial enough to easily avoid.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/vfio/pci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 056f3a887a8f..866f0deeb7eb 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2879,7 +2879,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
     tmp = g_strdup_printf("%s/subsystem", vdev->vbasedev.sysfsdev);
     subsys = realpath(tmp, NULL);
     g_free(tmp);
-    is_mdev = (strcmp(subsys, "/sys/bus/mdev") == 0);
+    is_mdev = subsys && (strcmp(subsys, "/sys/bus/mdev") == 0);
     free(subsys);
 
     trace_vfio_mdev(vdev->vbasedev.name, is_mdev);
