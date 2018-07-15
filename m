Received: from eggs.gnu.org ([2001:4830:134:3::10]:52107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fejmd-0006be-UM
	for qemu-devel@nongnu.org; Sun, 15 Jul 2018 12:22:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fejmZ-0001UW-1v
	for qemu-devel@nongnu.org; Sun, 15 Jul 2018 12:22:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57688 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fejmY-0001U6-T5
	for qemu-devel@nongnu.org; Sun, 15 Jul 2018 12:21:58 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sun, 15 Jul 2018 18:21:56 +0200
Message-Id: <20180715162156.12394-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH for-3.0] qga: fix file descriptor leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>

The file descriptor for /sys/power/state was never closed.  Reported
by Coverity.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qga/commands-posix.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 233f78a406..4160aceaed 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -1651,6 +1651,7 @@ static bool linux_sys_state_supports_mode(SuspendMode mode, Error **errp)
     }
 
     ret = read(fd, buf, sizeof(buf) - 1);
+    close(fd);
     if (ret <= 0) {
         return false;
     }
-- 
2.17.1
