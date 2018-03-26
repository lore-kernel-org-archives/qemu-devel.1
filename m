Received: from eggs.gnu.org ([2001:4830:134:3::10]:42828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1f0M7g-0002Im-J2
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 03:00:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1f0M7f-0000u1-DP
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 03:00:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50374 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1f0M7f-0000tv-9G
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 03:00:51 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 26 Mar 2018 15:00:29 +0800
Message-Id: <1522047629-27658-3-git-send-email-jasowang@redhat.com>
In-Reply-To: <1522047629-27658-1-git-send-email-jasowang@redhat.com>
References: <1522047629-27658-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 2/2] net/vde: print error on vde_open() failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: Julia Suvorova <jusual@mail.ru>, Jason Wang <jasowang@redhat.com>

From: Julia Suvorova via Qemu-devel <qemu-devel@nongnu.org>

Despite the fact that now when the initialization of vde fails, qemu
does not end silently, no informative error is printed. The patch
generates an error and pushes it through the calling function.

Related bug: https://bugs.launchpad.net/qemu/+bug/676029

Signed-off-by: Julia Suvorova <jusual@mail.ru>
Signed-off-by: Jason Wang <jasowang@redhat.com>
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
2.7.4
