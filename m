Received: from eggs.gnu.org ([2001:4830:134:3::10]:49833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fsuKv-0006l9-2u
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 14:28:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fsuKr-0003bW-Tj
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 14:28:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34578 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1fsuKo-0003Y8-EY
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 14:27:56 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 274CB804B9F4
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 18:27:54 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
Date: Thu, 23 Aug 2018 12:27:51 -0600
Message-ID: <153504887176.3676.14416169422675105431.stgit@gimli.home>
In-Reply-To: <153504858585.3676.10222732707932789866.stgit@gimli.home>
References: <153504858585.3676.10222732707932789866.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PULL 2/3] vfio/pci: Fix failure to close file
 descriptor on error
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
Reviewed-by: Peter Xu <peterx@redhat.com>
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
 
