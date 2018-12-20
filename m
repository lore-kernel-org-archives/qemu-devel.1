Received: from eggs.gnu.org ([2001:4830:134:3::10]:53421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <remy.noel@blade-group.com>) id 1ga07n-0006lw-93
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 10:20:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <remy.noel@blade-group.com>) id 1ga07k-00060Z-6d
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 10:20:35 -0500
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:40332)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <remy.noel@blade-group.com>)
	id 1ga07k-0005zO-0C
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 10:20:32 -0500
Received: by mail-ed1-x544.google.com with SMTP id g22so2055558edr.7
	for <qemu-devel@nongnu.org>; Thu, 20 Dec 2018 07:20:31 -0800 (PST)
From: remy.noel@blade-group.com
Date: Thu, 20 Dec 2018 16:20:29 +0100
Message-Id: <20181220152030.28035-2-remy.noel@blade-group.com>
In-Reply-To: <20181220152030.28035-1-remy.noel@blade-group.com>
References: <20181220152030.28035-1-remy.noel@blade-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [QEMU-devel][PATCH v4 1/2] aio-posix: Unregister fd
 from ctx epoll when removing fd_handler.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Remy Noel <remy.noel@blade-group.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, "open list:Block I/O path" <qemu-block@nongnu.org>

From: Remy Noel <remy.noel@blade-group.com>

Cleaning the events will cause aio_epoll_update to unregister the fd.
Otherwise, the fd is kept registered until it is destroyed.

Signed-off-by: Remy Noel <remy.noel@blade-group.com>
---
 util/aio-posix.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/util/aio-posix.c b/util/aio-posix.c
index 51c41ed3c9..a927319d2c 100644
--- a/util/aio-posix.c
+++ b/util/aio-posix.c
@@ -245,6 +245,9 @@ void aio_set_fd_handler(AioContext *ctx,
             QLIST_REMOVE(node, node);
             deleted = true;
         }
+        /* Clean events in order to unregister fd from the ctx epoll. */
+        node->pfd.events = 0;
+
         poll_disable_change = -!node->io_poll;
     } else {
         poll_disable_change = !io_poll - (node && !node->io_poll);
-- 
2.19.2
