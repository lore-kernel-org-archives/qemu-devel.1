Received: from eggs.gnu.org ([2001:4830:134:3::10]:56321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cqzEI-0001xN-OG
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 05:40:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cqzEF-0003qC-LN
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 05:40:26 -0400
Received: from [45.249.212.187] (port=3010 helo=dggrg01-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cqzEF-0003cX-6q
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 05:40:23 -0400
From: Gonglei <arei.gonglei@huawei.com>
Date: Thu, 23 Mar 2017 17:39:11 +0800
Message-ID: <1490261951-21352-3-git-send-email-arei.gonglei@huawei.com>
In-Reply-To: <1490261951-21352-1-git-send-email-arei.gonglei@huawei.com>
References: <1490261951-21352-1-git-send-email-arei.gonglei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PULL for-2.9 2/2] cryptodev: fix asserting single
 queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Halil Pasic <pasic@linux.vnet.ibm.com>, Gonglei <arei.gonglei@huawei.com>

From: Halil Pasic <pasic@linux.vnet.ibm.com>

We already check for queues == 1 in cryptodev_builtin_init and when that
is not true raise an error. But before that error is reported the
assertion in cryptodev_builtin_cleanup kicks in (because object is being
finalized and freed).

Let's remove assert(queues == 1) form cryptodev_builtin_cleanup as it
does only harm and no good.

Reported-by: Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>
Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Gonglei <arei.gonglei@huawei.com>
---
 backends/cryptodev-builtin.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/backends/cryptodev-builtin.c b/backends/cryptodev-builtin.c
index b24a299..657c0ba 100644
--- a/backends/cryptodev-builtin.c
+++ b/backends/cryptodev-builtin.c
@@ -361,8 +361,6 @@ static void cryptodev_builtin_cleanup(
         }
     }
 
-    assert(queues == 1);
-
     for (i = 0; i < queues; i++) {
         cc = backend->conf.peers.ccs[i];
         if (cc) {
-- 
1.7.12.4
