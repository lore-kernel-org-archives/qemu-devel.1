Received: from eggs.gnu.org ([2001:4830:134:3::10]:56963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nia.alarie@gmail.com>) id 1evPT1-0003Mg-SU
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 11:34:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nia.alarie@gmail.com>) id 1evPSy-0003TN-NN
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 11:34:27 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:38584)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <nia.alarie@gmail.com>)
	id 1evPSy-0003Si-Fc
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 11:34:24 -0400
Received: by mail-wm0-x242.google.com with SMTP id z9so16935037wmb.3
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 08:34:24 -0700 (PDT)
From: Nia Alarie <nia.alarie@gmail.com>
Date: Mon, 12 Mar 2018 15:33:44 +0000
Message-Id: <20180312153344.23453-1-nia.alarie@gmail.com>
Subject: [Qemu-devel] [PATCH v2] 9p: Convert use of atoi to qemu_strtoi to
 allow error checking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: groug@kaod.org, stefanha@gmail.com, jim@groklearning.com, joel@jms.id.au, Nia Alarie <nia.alarie@gmail.com>

Signed-off-by: Nia Alarie <nia.alarie@gmail.com>
---
 hw/9pfs/9p.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 48fa48e720..254385dfa4 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -15,6 +15,7 @@
 #include <glib/gprintf.h>
 #include "hw/virtio/virtio.h"
 #include "qapi/error.h"
+#include "qemu/cutils.h"
 #include "qemu/error-report.h"
 #include "qemu/iov.h"
 #include "qemu/sockets.h"
@@ -2213,8 +2214,14 @@ static void coroutine_fn v9fs_create(void *opaque)
         }
         v9fs_path_copy(&fidp->path, &path);
     } else if (perm & P9_STAT_MODE_LINK) {
-        int32_t ofid = atoi(extension.data);
-        V9fsFidState *ofidp = get_fid(pdu, ofid);
+        int ofid;
+        V9fsFidState *ofidp;
+
+        if (qemu_strtoi(extension.data, NULL, 10, &ofid)) {
+            err = -EINVAL;
+            goto out;
+        }
+        ofidp = get_fid(pdu, (int32_t)ofid);
         if (ofidp == NULL) {
             err = -EINVAL;
             goto out;
-- 
2.16.2
