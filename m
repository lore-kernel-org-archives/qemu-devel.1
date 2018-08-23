Received: from eggs.gnu.org ([2001:4830:134:3::10]:49742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fsuKi-0006cn-Eb
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 14:27:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fsuKh-0003Oe-I8
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 14:27:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34574 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1fsuKh-0003Nk-30
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 14:27:47 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A8622804B9F5
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 18:27:46 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
Date: Thu, 23 Aug 2018 12:27:44 -0600
Message-ID: <153504886445.3676.11231990758206883466.stgit@gimli.home>
In-Reply-To: <153504858585.3676.10222732707932789866.stgit@gimli.home>
References: <153504858585.3676.10222732707932789866.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PULL 1/3] vfio/pci: Handle subsystem realpath()
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

Fix error reported by Coverity where realpath can return NULL,
resulting in a segfault in strcmp().  This should never happen given
that we're working through regularly structured sysfs paths, but
trivial enough to easily avoid.

Fixes: 238e91728503 ("vfio/ccw/pci: Allow devices to opt-in for ballooning")
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
