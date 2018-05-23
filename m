Received: from eggs.gnu.org ([2001:4830:134:3::10]:48926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fLUyv-0001qR-VD
	for qemu-devel@nongnu.org; Wed, 23 May 2018 10:43:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fLUyv-0000ow-9l
	for qemu-devel@nongnu.org; Wed, 23 May 2018 10:43:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46948 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fLUyv-0000op-5p
	for qemu-devel@nongnu.org; Wed, 23 May 2018 10:43:13 -0400
Date: Wed, 23 May 2018 17:43:08 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1527086545-68024-16-git-send-email-mst@redhat.com>
References: <1527086545-68024-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527086545-68024-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 15/28] vhost-user+postcopy: Use qemu_set_nonblock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Use qemu_set_nonblock rather than a simple fcntl; cleaner
and I have no reason to change other flags.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 85d8fd2..41cbd8a 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1115,7 +1115,7 @@ static int vhost_user_postcopy_advise(struct vhost_dev *dev, Error **errp)
         error_setg(errp, "%s: Failed to get ufd", __func__);
         return -1;
     }
-    fcntl(ufd, F_SETFL, O_NONBLOCK);
+    qemu_set_nonblock(ufd);
 
     /* register ufd with userfault thread */
     u->postcopy_fd.fd = ufd;
-- 
MST
