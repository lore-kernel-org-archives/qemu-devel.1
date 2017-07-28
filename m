Received: from eggs.gnu.org ([2001:4830:134:3::10]:46551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1db0IV-0000VR-9L
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 04:07:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1db0IU-0000s2-K9
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 04:06:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53646)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1db0IU-0000rn-Ec
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 04:06:58 -0400
From: Peter Xu <peterx@redhat.com>
Date: Fri, 28 Jul 2017 16:06:12 +0800
Message-Id: <1501229198-30588-4-git-send-email-peterx@redhat.com>
In-Reply-To: <1501229198-30588-1-git-send-email-peterx@redhat.com>
References: <1501229198-30588-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [RFC 03/29] io: fix qio_channel_socket_accept err
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

When accept failed, we should setup errp with the reason. More
importantly, the caller may assume errp be non-NULL when error happens,
and not setting the errp may crash QEMU.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 io/channel-socket.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/io/channel-socket.c b/io/channel-socket.c
index 53386b7..7bc308e 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -344,6 +344,7 @@ qio_channel_socket_accept(QIOChannelSocket *ioc,
         if (errno == EINTR) {
             goto retry;
         }
+        error_setg_errno(errp, errno, "Unable to accept connection");
         goto error;
     }
 
-- 
2.7.4
