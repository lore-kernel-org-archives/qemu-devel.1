Received: from eggs.gnu.org ([2001:4830:134:3::10]:39946)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <ps@pks.im>)
	id 1dPZZ9-0002ku-0o
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 15:20:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ps@pks.im>) id 1dPZZ4-0007mn-H7
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 15:20:54 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:56237)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ps@pks.im>) id 1dPZZ4-0007lF-1q
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 15:20:50 -0400
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 26 Jun 2017 21:20:45 +0200
Message-Id: <07010a2ad79559c412949f0005dbe3cb03d8416e.1498504812.git.ps@pks.im>
Subject: [Qemu-devel] [PATCH] 9pfs: include <linux/limits.h> for
 XATTR_SIZE_MAX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Patrick Steinhardt <ps@pks.im>

The function `v9fs_xattrcreate` makes use of the define `XATTR_SIZE_MAX`
to reject attempts of creating xattrs with an invalid size, which is
defined in <linux/limits.h>. On glibc-based systems, this header is
indirectly included via <limits.h>, <bits/posix1_lim.h>,
<bitts/local_lim.h>, but on other platforms this is not guaranteed due
to not being part of the POSIX standard. One examples are systems based
on musl libc, which do not include the <linux/limits.h> indirectly,
which leads to `XATTR_SIZE_MAX` being undefined.

Fix this error by directly include <linux/limits.h>. As the 9P fs code
is being Linux-based either way, we can simply do so without breaking
other platforms. This enables building 9pfs on musl-based systems.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 hw/9pfs/9p.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 96d2683348..48cd558e96 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -13,6 +13,7 @@
 
 #include "qemu/osdep.h"
 #include <glib/gprintf.h>
+#include <linux/limits.h>
 #include "hw/virtio/virtio.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
-- 
2.13.2
