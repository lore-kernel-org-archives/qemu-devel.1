Received: from eggs.gnu.org ([2001:4830:134:3::10]:39609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cUPYh-0000WG-UN
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 22:08:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cUPYg-0002uV-WD
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 22:08:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54332)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cUPYg-0002uG-QA
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 22:08:10 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 20 Jan 2017 11:07:50 +0800
Message-Id: <1484881670-24237-7-git-send-email-jasowang@redhat.com>
In-Reply-To: <1484881670-24237-1-git-send-email-jasowang@redhat.com>
References: <1484881670-24237-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 6/6] tap: fix memory leak on failure in
 net_init_tap()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>

From: Peter Maydell <peter.maydell@linaro.org>

Commit 091a6b2ac fixed most of the memory leaks in failure
paths in net_init_tap() reported by Coverity (CID 1356216),
but missed one. Fix it by deferring the allocation of
fds and vhost_fds until after the error check.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/tap.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index b6896a7..6248e85 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -788,8 +788,8 @@ int net_init_tap(const Netdev *netdev, const char *name,
             return -1;
         }
     } else if (tap->has_fds) {
-        char **fds = g_new0(char *, MAX_TAP_QUEUES);
-        char **vhost_fds = g_new0(char *, MAX_TAP_QUEUES);
+        char **fds;
+        char **vhost_fds;
         int nfds, nvhosts;
 
         if (tap->has_ifname || tap->has_script || tap->has_downscript ||
@@ -801,6 +801,9 @@ int net_init_tap(const Netdev *netdev, const char *name,
             return -1;
         }
 
+        fds = g_new0(char *, MAX_TAP_QUEUES);
+        vhost_fds = g_new0(char *, MAX_TAP_QUEUES);
+
         nfds = get_fds(tap->fds, fds, MAX_TAP_QUEUES);
         if (tap->has_vhostfds) {
             nvhosts = get_fds(tap->vhostfds, vhost_fds, MAX_TAP_QUEUES);
-- 
2.7.4
