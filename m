Received: from eggs.gnu.org ([2001:4830:134:3::10]:45989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fsBrt-0004lv-Ko
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 14:59:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fsBro-0000cS-7N
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 14:59:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43634 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1fsBrm-0000b5-AE
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 14:58:58 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 93A4B402315B
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 18:58:57 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
Date: Tue, 21 Aug 2018 12:58:53 -0600
Message-ID: <153487789207.20513.6642364712339067528.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] vfio/pci: Fix failure to close file descriptor
 on error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

A new error path fails to close the device file descriptor when
triggered by a ballooning incompatibility within the group.  Fix it.

Fixes: 238e91728503 ("vfio/ccw/pci: Allow devices to opt-in for ballooning")
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/vfio/common.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 3f31f80b1280..7c185e5a2e79 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1432,6 +1432,7 @@ int vfio_get_device(VFIOGroup *group, const char *name,
         if (!QLIST_EMPTY(&group->device_list)) {
             error_setg(errp,
                        "Inconsistent device balloon setting within group");
+            close(fd);
             return -1;
         }
 
