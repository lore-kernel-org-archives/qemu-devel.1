Received: from eggs.gnu.org ([2001:4830:134:3::10]:60928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cR1za-0000lV-V1
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 14:21:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cR1za-0007uc-2m
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 14:21:58 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48137)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cR1zZ-0007sm-SF
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 14:21:58 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Jan 2017 19:21:54 +0000
Message-Id: <1484076114-5594-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] tap: fix memory leak on failure in
 net_init_tap()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>

Commit 091a6b2ac fixed most of the memory leaks in failure
paths in net_init_tap() reported by Coverity (CID 1356216),
but missed one. Fix it by deferring the allocation of
fds and vhost_fds until after the error check.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
