Received: from eggs.gnu.org ([2001:4830:134:3::10]:37123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1gFz4u-0001Qf-CB
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 06:10:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1gFz4p-0008HN-TQ
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 06:10:49 -0400
Received: from mo6-p00-ob.smtp.rzone.de ([2a01:238:20a:202:5300::1]:35247)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <olaf@aepfle.de>) id 1gFz4k-0007zq-A3
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 06:10:44 -0400
From: Olaf Hering <olaf@aepfle.de>
Date: Fri, 26 Oct 2018 12:10:16 +0200
Message-Id: <20181026101016.28584-1-olaf@aepfle.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1] xen: preserve COMPAT in CFLAGS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Olaf Hering <olaf@aepfle.de>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, "open list:X86" <xen-devel@lists.xenproject.org>

A given Qemu version can not predict what version of Xen it will run on.
There are some checks in configure to decide what Xen libraries and
functions are available. How exactly these functions must be accessed
has to be decided by configure and the user who is compiling Qemu.
In no way some random header file must override this decision.

Remove the breakage introduced by commit 5eeb39c24b, which would always
hide the libxc interfaces the given version of Qemu knows about.

The current symptom of such breakage is a build failure with qemu-2.9
and older, in combination with Xen 4.12.

Fixes: 5eeb39c24b7d4da5d129bfdd9c4fd21cfb3d28d6
Signed-off-by: Olaf Hering <olaf@aepfle.de>
---
 include/hw/xen/xen_common.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/include/hw/xen/xen_common.h b/include/hw/xen/xen_common.h
index 5f1402b494..33fa2d3497 100644
--- a/include/hw/xen/xen_common.h
+++ b/include/hw/xen/xen_common.h
@@ -1,15 +1,6 @@
 #ifndef QEMU_HW_XEN_COMMON_H
 #define QEMU_HW_XEN_COMMON_H
 
-/*
- * If we have new enough libxenctrl then we do not want/need these compat
- * interfaces, despite what the user supplied cflags might say. They
- * must be undefined before including xenctrl.h
- */
-#undef XC_WANT_COMPAT_EVTCHN_API
-#undef XC_WANT_COMPAT_GNTTAB_API
-#undef XC_WANT_COMPAT_MAP_FOREIGN_API
-
 #include <xenctrl.h>
 #include <xenstore.h>
 #include <xen/io/xenbus.h>
