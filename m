Received: from eggs.gnu.org ([2001:4830:134:3::10]:37866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1ewZ9j-0005EM-22
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 16:07:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1ewZ9f-0000C8-QE
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 16:07:18 -0400
Received: from smtp52.i.mail.ru ([94.100.177.112]:39354)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jusual@mail.ru>) id 1ewZ9f-0000An-Er
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 16:07:15 -0400
From: Julia Suvorova <jusual@mail.ru>
Date: Thu, 15 Mar 2018 23:06:32 +0300
Message-Id: <1521144392-26203-1-git-send-email-jusual@mail.ru>
Subject: [Qemu-devel] [PATCH] net/vde: print error on vde_open() failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Jim Mussared <jim@groklearning.com>, Joel Stanley <joel@jms.id.au>, Julia Suvorova <jusual@mail.ru>

Despite the fact that now when the initialization of vde fails, qemu
does not end silently, no informative error is printed. The patch
generates an error and pushes it through the calling function.

Related bug: https://bugs.launchpad.net/qemu/+bug/676029

Signed-off-by: Julia Suvorova <jusual@mail.ru>
---
 net/vde.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/vde.c b/net/vde.c
index e50e5d6..99189cc 100644
--- a/net/vde.c
+++ b/net/vde.c
@@ -30,6 +30,7 @@
 #include "qemu-common.h"
 #include "qemu/option.h"
 #include "qemu/main-loop.h"
+#include "qapi/error.h"
 
 typedef struct VDEState {
     NetClientState nc;
@@ -76,7 +77,7 @@ static NetClientInfo net_vde_info = {
 
 static int net_vde_init(NetClientState *peer, const char *model,
                         const char *name, const char *sock,
-                        int port, const char *group, int mode)
+                        int port, const char *group, int mode, Error **errp)
 {
     NetClientState *nc;
     VDEState *s;
@@ -92,6 +93,7 @@ static int net_vde_init(NetClientState *peer, const char *model,
 
     vde = vde_open(init_sock, (char *)"QEMU", &args);
     if (!vde){
+        error_setg_errno(errp, errno, "Could not open vde");
         return -1;
     }
 
@@ -112,7 +114,6 @@ static int net_vde_init(NetClientState *peer, const char *model,
 int net_init_vde(const Netdev *netdev, const char *name,
                  NetClientState *peer, Error **errp)
 {
-    /* FIXME error_setg(errp, ...) on failure */
     const NetdevVdeOptions *vde;
 
     assert(netdev->type == NET_CLIENT_DRIVER_VDE);
@@ -120,7 +121,7 @@ int net_init_vde(const Netdev *netdev, const char *name,
 
     /* missing optional values have been initialized to "all bits zero" */
     if (net_vde_init(peer, "vde", name, vde->sock, vde->port, vde->group,
-                     vde->has_mode ? vde->mode : 0700) == -1) {
+                     vde->has_mode ? vde->mode : 0700, errp) == -1) {
         return -1;
     }
 
-- 
2.1.4
